Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F327C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E78A2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E78A2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965208AbeF0OIi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:08:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:37973 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933627AbeF0OIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:08:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 427A9AFC3;
        Wed, 27 Jun 2018 14:08:34 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 1/3] printk: Split the code for storing a message into the log buffer
Date:   Wed, 27 Jun 2018 16:08:15 +0200
Message-Id: <20180627140817.27764-2-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180627140817.27764-1-pmladek@suse.com>
References: <20180627140817.27764-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is just a preparation step. The patch does not change
the existing behavior.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..a844c611b17c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1824,28 +1824,16 @@ static size_t log_output(int facility, int level, enum log_flags lflags, const c
 	return log_store(facility, level, lflags, 0, dict, dictlen, text, text_len);
 }
 
-asmlinkage int vprintk_emit(int facility, int level,
-			    const char *dict, size_t dictlen,
-			    const char *fmt, va_list args)
+/* Must be called under logbuf_lock. */
+int vprintk_store(int facility, int level,
+		  const char *dict, size_t dictlen,
+		  const char *fmt, va_list args)
 {
 	static char textbuf[LOG_LINE_MAX];
 	char *text = textbuf;
 	size_t text_len;
 	enum log_flags lflags = 0;
-	unsigned long flags;
-	int printed_len;
-	bool in_sched = false;
-
-	if (level == LOGLEVEL_SCHED) {
-		level = LOGLEVEL_DEFAULT;
-		in_sched = true;
-	}
-
-	boot_delay_msec(level);
-	printk_delay();
 
-	/* This stops the holder of console_sem just where we want him */
-	logbuf_lock_irqsave(flags);
 	/*
 	 * The printf needs to come first; we need the syslog
 	 * prefix which might be passed-in as a parameter.
@@ -1886,8 +1874,29 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (dict)
 		lflags |= LOG_PREFIX|LOG_NEWLINE;
 
-	printed_len = log_output(facility, level, lflags, dict, dictlen, text, text_len);
+	return log_output(facility, level, lflags,
+			  dict, dictlen, text, text_len);
+}
 
+asmlinkage int vprintk_emit(int facility, int level,
+			    const char *dict, size_t dictlen,
+			    const char *fmt, va_list args)
+{
+	int printed_len;
+	bool in_sched = false;
+	unsigned long flags;
+
+	if (level == LOGLEVEL_SCHED) {
+		level = LOGLEVEL_DEFAULT;
+		in_sched = true;
+	}
+
+	boot_delay_msec(level);
+	printk_delay();
+
+	/* This stops the holder of console_sem just where we want him */
+	logbuf_lock_irqsave(flags);
+	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
 	logbuf_unlock_irqrestore(flags);
 
 	/* If called from the scheduler, we can not call up(). */
-- 
2.13.7

