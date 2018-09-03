Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35681C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30AB20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30AB20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbeICVxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:53:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47530 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeICVxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:53:44 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C345CD1B;
        Mon,  3 Sep 2018 17:32:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 4.18 025/123] printk: Split the code for storing a message into the log buffer
Date:   Mon,  3 Sep 2018 18:56:09 +0200
Message-Id: <20180903165720.560164940@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Mladek <pmladek@suse.com>

commit ba552399954dde1b388f7749fecad5c349216981 upstream.

It is just a preparation step. The patch does not change
the existing behavior.

Link: http://lkml.kernel.org/r/20180627140817.27764-2-pmladek@suse.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/printk/printk.c |   43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1824,28 +1824,16 @@ static size_t log_output(int facility, i
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
@@ -1886,8 +1874,29 @@ asmlinkage int vprintk_emit(int facility
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


