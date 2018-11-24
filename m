Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E55C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 04:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E0E2082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 04:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E0E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbeKXO5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 09:57:39 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:48783 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbeKXO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 09:57:39 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAO4AV72042414;
        Sat, 24 Nov 2018 13:10:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Sat, 24 Nov 2018 13:10:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAO4AQkE042386
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 24 Nov 2018 13:10:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Make printk_emit() local function.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <1542898768-5732-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181123122405.3iqc6bvdxkngntzl@pathway.suse.cz>
 <d2dd8a02-4e1d-7e9b-4639-fe3a640a2742@i-love.sakura.ne.jp>
Message-ID: <5cc99d2c-c408-34f7-d1fc-e1cd2a9e31da@i-love.sakura.ne.jp>
Date:   Sat, 24 Nov 2018 13:10:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <d2dd8a02-4e1d-7e9b-4639-fe3a640a2742@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, moving "__printf(3, 4) __cold" to before
"int devkmsg_emit(int facility, int level, const char *fmt, ...) {"
seems to be working. I did not know...

From 86fff21e5fef6d3f7970cf5c07a54a907e582b52 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 24 Nov 2018 13:05:25 +0900
Subject: [PATCH v2] printk: Make printk_emit() local function.

printk_emit() is called from only devkmsg_write() in the same file.
Save object size by making it a local function.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/printk.h |  5 -----
 kernel/printk/printk.c | 30 ++++++++++++++----------------
 2 files changed, 14 insertions(+), 21 deletions(-)

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
index 1b2a029..5c2079d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -752,6 +752,19 @@ struct devkmsg_user {
 	char buf[CONSOLE_EXT_LOG_MAX];
 };
 
+static __printf(3, 4) __cold
+int devkmsg_emit(int facility, int level, const char *fmt, ...)
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
@@ -810,7 +823,7 @@ static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
 		}
 	}
 
-	printk_emit(facility, level, NULL, 0, "%s", line);
+	devkmsg_emit(facility, level, "%s", line);
 	kfree(buf);
 	return ret;
 }
@@ -1935,21 +1948,6 @@ asmlinkage int vprintk(const char *fmt, va_list args)
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

