Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBA2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F0F208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ziLcSLyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F0F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407452AbeKWGjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:39:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389557AbeKWGjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:39:04 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA76920870;
        Thu, 22 Nov 2018 19:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916690;
        bh=wT8vvqalbjW5TCh9SCp9r/sALELtPRS0dLjQW/BQrO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ziLcSLyc90zvpupjOeJrh6OqGjKj/BDCvu1mJ9C2JrszAsxXXv474SEZyh6h3Diwr
         YjQTDQTkV5ivLRGjnSMT+5kXLLfkA5vX8UmjQKZX0hNpoUmqYnV9yFdOJfdLXN+D/Q
         f7cBIi9XRBXybyizyQP+JNEFN9kKvwVuhim3uNXc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Jonathan Toppins <jtoppins@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 5/7] kdb: Use strscpy with destination buffer size
Date:   Thu, 22 Nov 2018 14:57:47 -0500
Message-Id: <20181122195749.14086-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195749.14086-1-sashal@kernel.org>
References: <20181122195749.14086-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prarit Bhargava <prarit@redhat.com>

[ Upstream commit c2b94c72d93d0929f48157eef128c4f9d2e603ce ]

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
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/debug/kdb/kdb_io.c      | 15 +++++++++------
 kernel/debug/kdb/kdb_private.h |  2 +-
 kernel/debug/kdb/kdb_support.c | 10 +++++-----
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 681c8b42e013..1c6b7055f11f 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -215,7 +215,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 	int count;
 	int i;
 	int diag, dtab_count;
-	int key;
+	int key, buf_size, ret;
 
 
 	diag = kdbgetintenv("DTABCOUNT", &dtab_count);
@@ -335,9 +335,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
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
@@ -349,9 +348,13 @@ static char *kdb_read(char *buffer, size_t bufsize)
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
index 7afd3c8c41d5..439f1c8b1193 100644
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
index d35cc2d3a4cc..2aed4a33521b 100644
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
2.17.1

