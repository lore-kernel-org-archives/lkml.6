Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707F5ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070AA21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070AA21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbeITSmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:42:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27159 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387679AbeITSml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:42:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E47405C9;
        Thu, 20 Sep 2018 12:59:17 +0000 (UTC)
Received: from prarit.khw1.lab.eng.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CAB97E6C1;
        Thu, 20 Sep 2018 12:59:16 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Jonathan Toppins <jtoppins@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH v2] kdb: Use strscpy with destination buffer size
Date:   Thu, 20 Sep 2018 08:59:14 -0400
Message-Id: <20180920125914.17920-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 20 Sep 2018 12:59:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 8.1.0 warns with:

kernel/debug/kdb/kdb_support.c: In function ‘kallsyms_symbol_next’:
kernel/debug/kdb/kdb_support.c:239:4: warning: ‘strncpy’ specified bound depends on the length of the source argument [-Wstringop-overflow=]
     strncpy(prefix_name, name, strlen(name)+1);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/debug/kdb/kdb_support.c:239:31: note: length computed here

Use strscpy() with the destination buffer size, and use ellipses when
displaying truncated symbols.

v2: Use strscpy()

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Jonathan Toppins <jtoppins@redhat.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net
---
 kernel/debug/kdb/kdb_io.c      | 15 +++++++++------
 kernel/debug/kdb/kdb_private.h |  2 +-
 kernel/debug/kdb/kdb_support.c | 10 +++++-----
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index ed5d34925ad0..6a4b41484afe 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -216,7 +216,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 	int count;
 	int i;
 	int diag, dtab_count;
-	int key;
+	int key, buf_size, ret;
 
 
 	diag = kdbgetintenv("DTABCOUNT", &dtab_count);
@@ -336,9 +336,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 		else
 			p_tmp = tmpbuffer;
 		len = strlen(p_tmp);
-		count = kallsyms_symbol_complete(p_tmp,
-						 sizeof(tmpbuffer) -
-						 (p_tmp - tmpbuffer));
+		buf_size = sizeof(tmpbuffer) - (p_tmp - tmpbuffer);
+		count = kallsyms_symbol_complete(p_tmp, buf_size);
 		if (tab == 2 && count > 0) {
 			kdb_printf("\n%d symbols are found.", count);
 			if (count > dtab_count) {
@@ -350,9 +349,13 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			}
 			kdb_printf("\n");
 			for (i = 0; i < count; i++) {
-				if (WARN_ON(!kallsyms_symbol_next(p_tmp, i)))
+				ret = kallsyms_symbol_next(p_tmp, i, buf_size);
+				if (WARN_ON(!ret))
 					break;
-				kdb_printf("%s ", p_tmp);
+				if (ret != -E2BIG)
+					kdb_printf("%s ", p_tmp);
+				else
+					kdb_printf("%s... ", p_tmp);
 				*(p_tmp + len) = '\0';
 			}
 			if (i >= dtab_count)
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 1e5a502ba4a7..2118d8258b7c 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -83,7 +83,7 @@ typedef struct __ksymtab {
 		unsigned long sym_start;
 		unsigned long sym_end;
 		} kdb_symtab_t;
-extern int kallsyms_symbol_next(char *prefix_name, int flag);
+extern int kallsyms_symbol_next(char *prefix_name, int flag, int buf_size);
 extern int kallsyms_symbol_complete(char *prefix_name, int max_len);
 
 /* Exported Symbols for kernel loadable modules to use. */
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 990b3cc526c8..61cd704a21c8 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -221,11 +221,13 @@ int kallsyms_symbol_complete(char *prefix_name, int max_len)
  * Parameters:
  *	prefix_name	prefix of a symbol name to lookup
  *	flag	0 means search from the head, 1 means continue search.
+ *	buf_size	maximum length that can be written to prefix_name
+ *			buffer
  * Returns:
  *	1 if a symbol matches the given prefix.
  *	0 if no string found
  */
-int kallsyms_symbol_next(char *prefix_name, int flag)
+int kallsyms_symbol_next(char *prefix_name, int flag, int buf_size)
 {
 	int prefix_len = strlen(prefix_name);
 	static loff_t pos;
@@ -235,10 +237,8 @@ int kallsyms_symbol_next(char *prefix_name, int flag)
 		pos = 0;
 
 	while ((name = kdb_walk_kallsyms(&pos))) {
-		if (strncmp(name, prefix_name, prefix_len) == 0) {
-			strncpy(prefix_name, name, strlen(name)+1);
-			return 1;
-		}
+		if (!strncmp(name, prefix_name, prefix_len))
+			return strscpy(prefix_name, name, buf_size);
 	}
 	return 0;
 }
-- 
2.14.4

