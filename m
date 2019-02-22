Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B889C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F96720700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfBVJ7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:59:41 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58885 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfBVJ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:59:41 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1M9xcQK021862;
        Fri, 22 Feb 2019 18:59:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Fri, 22 Feb 2019 18:59:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1M9xX2i021827
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Feb 2019 18:59:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] printk: Remove no longer used LOG_PREFIX.
Date:   Fri, 22 Feb 2019 18:59:40 +0900
Message-Id: <1550829580-9189-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When commit 5becfb1df5ac8e49 ("kmsg: merge continuation records while
printing") introduced LOG_PREFIX, we used KERN_DEFAULT etc. as a flag
for setting LOG_PREFIX in order to tell whether to call cont_add()
(i.e. whether to append the message to "struct cont").

But since commit 4bcc595ccd80decb ("printk: reinstate KERN_CONT for
printing continuation lines") inverted the behavior (i.e. don't append
the message to "struct cont" unless KERN_CONT is specified) and commit
5aa068ea4082b39e ("printk: remove games with previous record flags")
removed the last LOG_PREFIX check, setting LOG_PREFIX via KERN_DEFAULT
etc. is no longer meaningful.

Therefore, we can remove LOG_PREFIX and make KERN_DEFAULT empty string.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/kern_levels.h | 2 +-
 include/linux/printk.h      | 1 -
 kernel/printk/printk.c      | 6 +-----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/kern_levels.h b/include/linux/kern_levels.h
index d237fe8..bf2389c 100644
--- a/include/linux/kern_levels.h
+++ b/include/linux/kern_levels.h
@@ -14,7 +14,7 @@
 #define KERN_INFO	KERN_SOH "6"	/* informational */
 #define KERN_DEBUG	KERN_SOH "7"	/* debug-level messages */
 
-#define KERN_DEFAULT	KERN_SOH "d"	/* the default kernel loglevel */
+#define KERN_DEFAULT	""		/* the default kernel loglevel */
 
 /*
  * Annotation for a "continued" line of log printout (only done after a
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 77740a5..9fe6c9e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -18,7 +18,6 @@ static inline int printk_get_level(const char *buffer)
 	if (buffer[0] == KERN_SOH_ASCII && buffer[1]) {
 		switch (buffer[1]) {
 		case '0' ... '7':
-		case 'd':	/* KERN_DEFAULT */
 		case 'c':	/* KERN_CONT */
 			return buffer[1];
 		}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d3d1703..3e4a735 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -344,7 +344,6 @@ enum con_msg_format_flags {
 
 enum log_flags {
 	LOG_NEWLINE	= 2,	/* text ended with a newline */
-	LOG_PREFIX	= 4,	/* text started with a prefix */
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
@@ -1867,9 +1866,6 @@ int vprintk_store(int facility, int level,
 			case '0' ... '7':
 				if (level == LOGLEVEL_DEFAULT)
 					level = kern_level - '0';
-				/* fallthrough */
-			case 'd':	/* KERN_DEFAULT */
-				lflags |= LOG_PREFIX;
 				break;
 			case 'c':	/* KERN_CONT */
 				lflags |= LOG_CONT;
@@ -1884,7 +1880,7 @@ int vprintk_store(int facility, int level,
 		level = default_message_loglevel;
 
 	if (dict)
-		lflags |= LOG_PREFIX|LOG_NEWLINE;
+		lflags |= LOG_NEWLINE;
 
 	return log_output(facility, level, lflags,
 			  dict, dictlen, text, text_len);
-- 
1.8.3.1
