Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE79C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB16E2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfBLOaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:30:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43751 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730218AbfBLOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:32 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4m-0005Af-QD; Tue, 12 Feb 2019 15:30:21 +0100
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
Subject: [RFC PATCH v1 14/25] printk: do boot_delay_msec inside printk_delay
Date:   Tue, 12 Feb 2019 15:29:52 +0100
Message-Id: <20190212143003.48446-15-john.ogness@linutronix.de>
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

Both functions needed to be called one after the other, so just
integrate boot_delay_msec into printk_delay for simplification.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ebd9aac06323..897219f34cab 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1453,6 +1453,21 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
 	return do_syslog(type, buf, len, SYSLOG_FROM_READER);
 }
 
+int printk_delay_msec __read_mostly;
+
+static inline void printk_delay(int level)
+{
+	boot_delay_msec(level);
+	if (unlikely(printk_delay_msec)) {
+		int m = printk_delay_msec;
+
+		while (m--) {
+			mdelay(1);
+			touch_nmi_watchdog();
+		}
+	}
+}
+
 static void print_console_dropped(struct console *con, u64 count)
 {
 	char text[64];
@@ -1534,20 +1549,6 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
 	}
 }
 
-int printk_delay_msec __read_mostly;
-
-static inline void printk_delay(void)
-{
-	if (unlikely(printk_delay_msec)) {
-		int m = printk_delay_msec;
-
-		while (m--) {
-			mdelay(1);
-			touch_nmi_watchdog();
-		}
-	}
-}
-
 /* FIXME: no support for LOG_CONT */
 #if 0
 /*
@@ -2506,10 +2507,8 @@ static int printk_kthread_func(void *data)
 		console_lock();
 		call_console_drivers(master_seq, ext_text,
 				     ext_len, text, len);
-		if (len > 0 || ext_len > 0) {
-			boot_delay_msec(msg->level);
-			printk_delay();
-		}
+		if (len > 0 || ext_len > 0)
+			printk_delay(msg->level);
 		console_unlock();
 	}
 
-- 
2.11.0

