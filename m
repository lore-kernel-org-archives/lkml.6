Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922D7C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4512186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfBLOcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:32:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43811 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730325AbfBLOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:38 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4t-0005Af-6K; Tue, 12 Feb 2019 15:30:27 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC PATCH v1 21/25] printk: implement KERN_CONT
Date:   Tue, 12 Feb 2019 15:29:59 +0100
Message-Id: <20190212143003.48446-22-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement KERN_CONT based on the printing CPU rather than on the
printing task. As long as the KERN_CONT messages are coming from the
same CPU and no non-KERN_CONT messages come, the messages are assumed
to belong to each other.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 73 +++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index eebe6f4fdbba..306e7575499c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1649,8 +1649,6 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
 	}
 }
 
-/* FIXME: no support for LOG_CONT */
-#if 0
 /*
  * Continuation lines are buffered, and not committed to the record buffer
  * until the line is complete, or a race forces it. The line fragments
@@ -1660,52 +1658,57 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
 static struct cont {
 	char buf[LOG_LINE_MAX];
 	size_t len;			/* length == 0 means unused buffer */
-	struct task_struct *owner;	/* task of first print*/
+	int cpu_owner;			/* cpu of first print*/
 	u64 ts_nsec;			/* time of first print */
 	u8 level;			/* log level of first message */
 	u8 facility;			/* log facility of first message */
 	enum log_flags flags;		/* prefix, newline flags */
-} cont;
+} cont[2];
 
-static void cont_flush(void)
+static void cont_flush(int ctx)
 {
-	if (cont.len == 0)
+	struct cont *c = &cont[ctx];
+
+	if (c->len == 0)
 		return;
 
-	log_store(cont.facility, cont.level, cont.flags, cont.ts_nsec,
-		  NULL, 0, cont.buf, cont.len);
-	cont.len = 0;
+	log_store(c->facility, c->level, c->flags, c->ts_nsec, c->cpu_owner,
+		  NULL, 0, c->buf, c->len);
+	c->len = 0;
 }
 
-static bool cont_add(int facility, int level, enum log_flags flags, const char *text, size_t len)
+static void cont_add(int ctx, int cpu, int facility, int level,
+		     enum log_flags flags, const char *text, size_t len)
 {
+	struct cont *c = &cont[ctx];
+
+	if (cpu != c->cpu_owner || !(flags & LOG_CONT))
+		cont_flush(ctx);
+
 	/* If the line gets too long, split it up in separate records. */
-	if (cont.len + len > sizeof(cont.buf)) {
-		cont_flush();
-		return false;
-	}
+	while (c->len + len > sizeof(c->buf))
+		cont_flush(ctx);
 
-	if (!cont.len) {
-		cont.facility = facility;
-		cont.level = level;
-		cont.owner = current;
-		cont.ts_nsec = local_clock();
-		cont.flags = flags;
+	if (!c->len) {
+		c->facility = facility;
+		c->level = level;
+		c->cpu_owner = cpu;
+		c->ts_nsec = local_clock();
+		c->flags = flags;
 	}
 
-	memcpy(cont.buf + cont.len, text, len);
-	cont.len += len;
+	memcpy(c->buf + c->len, text, len);
+	c->len += len;
 
-	// The original flags come from the first line,
-	// but later continuations can add a newline.
+	/*
+	 * The original flags come from the first line,
+	 * but later continuations can add a newline.
+	 */
 	if (flags & LOG_NEWLINE) {
-		cont.flags |= LOG_NEWLINE;
-		cont_flush();
+		c->flags |= LOG_NEWLINE;
+		cont_flush(ctx);
 	}
-
-	return true;
 }
-#endif /* 0 */
 
 /* ring buffer used as memory allocator for temporary sprint buffers */
 DECLARE_STATIC_PRINTKRB(sprint_rb,
@@ -1717,6 +1720,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const char *fmt, va_list args)
 {
 	enum log_flags lflags = 0;
+	int ctx = !!in_nmi();
 	int printed_len = 0;
 	struct prb_handle h;
 	size_t text_len;
@@ -1784,8 +1788,15 @@ asmlinkage int vprintk_emit(int facility, int level,
 	 */
 	printk_emergency(rbuf, level, ts_nsec, cpu, text, text_len);
 
-	printed_len = log_store(facility, level, lflags, ts_nsec, cpu,
-				dict, dictlen, text, text_len);
+	if ((lflags & LOG_CONT) || !(lflags & LOG_NEWLINE)) {
+		cont_add(ctx, cpu, facility, level, lflags, text, text_len);
+		printed_len = text_len;
+	} else {
+		if (cpu == cont[ctx].cpu_owner)
+			cont_flush(ctx);
+		printed_len = log_store(facility, level, lflags, ts_nsec, cpu,
+					dict, dictlen, text, text_len);
+	}
 
 	prb_commit(&h);
 	return printed_len;
-- 
2.11.0

