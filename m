Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD70C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700FD214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfBLOc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:32:26 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43774 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730270AbfBLOae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:34 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4o-0005Af-NB; Tue, 12 Feb 2019 15:30:22 +0100
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
Subject: [RFC PATCH v1 16/25] printk: implement CON_PRINTBUFFER
Date:   Tue, 12 Feb 2019 15:29:54 +0100
Message-Id: <20190212143003.48446-17-john.ogness@linutronix.de>
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

If the CON_PRINTBUFFER flag is not set, do not replay the history
for that console.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6c875abd7b17..b97d4195b09a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -399,10 +399,6 @@ static u32 log_first_idx;
 static u64 log_next_seq;
 static u32 log_next_idx;
 
-/* the next printk record to write to the console */
-static u64 console_seq;
-static u32 console_idx;
-
 /* the next printk record to read after the last 'clear' command */
 static u64 clear_seq;
 static u32 clear_idx;
@@ -1596,8 +1592,12 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
 		if (!(con->flags & CON_ENABLED))
 			continue;
 		if (!con->wrote_history) {
-			printk_write_history(con, seq);
-			continue;
+			if (con->flags & CON_PRINTBUFFER) {
+				printk_write_history(con, seq);
+				continue;
+			}
+			con->wrote_history = 1;
+			con->printk_seq = seq - 1;
 		}
 		if (!con->write)
 			continue;
@@ -1822,8 +1822,6 @@ EXPORT_SYMBOL(printk);
 
 static u64 syslog_seq;
 static u32 syslog_idx;
-static u64 console_seq;
-static u32 console_idx;
 static u64 log_first_seq;
 static u32 log_first_idx;
 static u64 log_next_seq;
@@ -2224,7 +2222,6 @@ early_param("keep_bootcon", keep_bootcon_setup);
 void register_console(struct console *newcon)
 {
 	int i;
-	unsigned long flags;
 	struct console *bcon = NULL;
 	struct console_cmdline *c;
 	static bool has_preferred;
@@ -2340,16 +2337,6 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_EXTENDED)
 		nr_ext_console_drivers++;
 
-	if (newcon->flags & CON_PRINTBUFFER) {
-		/*
-		 * console_unlock(); will print out the buffered messages
-		 * for us.
-		 */
-		logbuf_lock_irqsave(flags);
-		console_seq = syslog_seq;
-		console_idx = syslog_idx;
-		logbuf_unlock_irqrestore(flags);
-	}
 	console_unlock();
 	console_sysfs_notify();
 
-- 
2.11.0

