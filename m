Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E76C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC152145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="svK7cntf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC152145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbeK3BcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:32:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbeK3Bb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:31:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 721622133F;
        Thu, 29 Nov 2018 14:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501586;
        bh=vhPuVxessv532O79CgtPwTEhrejhfqOXPSQzrqMjiNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svK7cntfoeIDu2de4xumbQYocQrHpxy0Y1vWgJThXt8QF0MA8YntasL8mZhJTkEbi
         GM7ukRP9XJ8+L9w99eqgR0vw6op3s0UgJDeaVhBbQb3E49ijQ6/5laFIr3Hia8GRmY
         G9y9cA86WFnL/CwD9is+XD/eI6IHoHgcathftPC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Jonathan Toppins <jtoppins@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 059/100] kdb: Use strscpy with destination buffer size
Date:   Thu, 29 Nov 2018 15:12:29 +0100
Message-Id: <20181129140104.178001855@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -336,9 +336,8 @@ poll_again:
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
@@ -350,9 +349,13 @@ poll_again:
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
index fc224fbcf954..f2158e463a0f 100644
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
index 84422d2b95c0..014f6fbb3832 100644
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



