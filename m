Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6860EC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC08214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfBLOak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:30:40 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43788 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbfBLOag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:36 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4p-0005Af-Me; Tue, 12 Feb 2019 15:30:23 +0100
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
Subject: [RFC PATCH v1 17/25] printk: add processor number to output
Date:   Tue, 12 Feb 2019 15:29:55 +0100
Message-Id: <20190212143003.48446-18-john.ogness@linutronix.de>
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

It can be difficult to sort printk out if multiple processors are
printing simultaneously. Add the processor number to the printk
output to allow the messages to be sorted.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b97d4195b09a..cde036d8487a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -331,6 +331,7 @@ enum log_flags {
 
 struct printk_log {
 	u64 ts_nsec;		/* timestamp in nanoseconds */
+	u16 cpu;		/* cpu that generated record */
 	u16 len;		/* length of entire record */
 	u16 text_len;		/* length of text buffer */
 	u16 dict_len;		/* length of dictionary buffer */
@@ -475,7 +476,7 @@ static u32 log_next(u32 idx)
 
 /* insert record into the buffer, discard old ones, update heads */
 static int log_store(int facility, int level,
-		     enum log_flags flags, u64 ts_nsec,
+		     enum log_flags flags, u64 ts_nsec, u16 cpu,
 		     const char *dict, u16 dict_len,
 		     const char *text, u16 text_len)
 {
@@ -506,6 +507,7 @@ static int log_store(int facility, int level,
 	msg->level = level & 7;
 	msg->flags = flags & 0x1f;
 	msg->ts_nsec = ts_nsec;
+	msg->cpu = cpu;
 	msg->len = size;
 
 	/* insert message */
@@ -570,9 +572,9 @@ static ssize_t msg_print_ext_header(char *buf, size_t size,
 
 	do_div(ts_usec, 1000);
 
-	return scnprintf(buf, size, "%u,%llu,%llu,%c;",
+	return scnprintf(buf, size, "%u,%llu,%llu,%c,%hu;",
 		       (msg->facility << 3) | msg->level, seq, ts_usec,
-		       msg->flags & LOG_CONT ? 'c' : '-');
+		       msg->flags & LOG_CONT ? 'c' : '-', msg->cpu);
 }
 
 static ssize_t msg_print_ext_body(char *buf, size_t size,
@@ -1110,6 +1112,11 @@ static inline void boot_delay_msec(int level)
 static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
 module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
 
+static size_t print_cpu(u16 cpu, char *buf)
+{
+	return sprintf(buf, "%03hu: ", cpu);
+}
+
 static size_t print_syslog(unsigned int level, char *buf)
 {
 	return sprintf(buf, "<%u>", level);
@@ -1132,6 +1139,7 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog,
 		len = print_syslog((msg->facility << 3) | msg->level, buf);
 	if (time)
 		len += print_time(msg->ts_nsec, buf + len);
+	len += print_cpu(msg->cpu, buf + len);
 	return len;
 }
 
@@ -1698,6 +1706,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	u64 ts_nsec;
 	char *text;
 	char *rbuf;
+	int cpu;
 
 	ts_nsec = local_clock();
 
@@ -1707,6 +1716,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 		return printed_len;
 	}
 
+	cpu = raw_smp_processor_id();
+
 	text = rbuf;
 	text_len = vscnprintf(text, PRINTK_SPRINT_MAX, fmt, args);
 
@@ -1744,7 +1755,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (dict)
 		lflags |= LOG_PREFIX|LOG_NEWLINE;
 
-	printed_len = log_store(facility, level, lflags, ts_nsec,
+	printed_len = log_store(facility, level, lflags, ts_nsec, cpu,
 				dict, dictlen, text, text_len);
 
 	prb_commit(&h);
-- 
2.11.0

