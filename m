Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AC5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B82206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B82206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405701AbeKWBkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:40:35 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:24266 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403968AbeKWBkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:40:35 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAMF0XL5052401;
        Fri, 23 Nov 2018 00:00:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Fri, 23 Nov 2018 00:00:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAMF0RmN052338
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Nov 2018 00:00:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] printk: Make printk_emit() local function.
Date:   Thu, 22 Nov 2018 23:59:28 +0900
Message-Id: <1542898768-5732-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk_emit() is called from only devkmsg_write() in the same file.
Save object size by making it a local function.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/printk.h |  5 -----
 kernel/printk/printk.c | 31 +++++++++++++++----------------
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf3eccf..55aa969 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -166,11 +166,6 @@ int vprintk_emit(int facility, int level,
 asmlinkage __printf(1, 0)
 int vprintk(const char *fmt, va_list args);
 
-asmlinkage __printf(5, 6) __cold
-int printk_emit(int facility, int level,
-		const char *dict, size_t dictlen,
-		const char *fmt, ...);
-
 asmlinkage __printf(1, 2) __cold
 int printk(const char *fmt, ...);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1b2a029..315718b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -752,6 +752,20 @@ struct devkmsg_user {
 	char buf[CONSOLE_EXT_LOG_MAX];
 };
 
+static __printf(3, 4) __cold int devkmsg_emit(int facility, int level,
+					      const char *fmt, ...);
+static int devkmsg_emit(int facility, int level, const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	va_start(args, fmt);
+	r = vprintk_emit(facility, level, NULL, 0, fmt, args);
+	va_end(args);
+
+	return r;
+}
+
 static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char *buf, *line;
@@ -810,7 +824,7 @@ static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
 		}
 	}
 
-	printk_emit(facility, level, NULL, 0, "%s", line);
+	devkmsg_emit(facility, level, "%s", line);
 	kfree(buf);
 	return ret;
 }
@@ -1935,21 +1949,6 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 }
 EXPORT_SYMBOL(vprintk);
 
-asmlinkage int printk_emit(int facility, int level,
-			   const char *dict, size_t dictlen,
-			   const char *fmt, ...)
-{
-	va_list args;
-	int r;
-
-	va_start(args, fmt);
-	r = vprintk_emit(facility, level, dict, dictlen, fmt, args);
-	va_end(args);
-
-	return r;
-}
-EXPORT_SYMBOL(printk_emit);
-
 int vprintk_default(const char *fmt, va_list args)
 {
 	int r;
-- 
1.8.3.1

