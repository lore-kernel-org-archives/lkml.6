Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeFDFqm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 01:46:42 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:60914 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750723AbeFDFql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 01:46:41 -0400
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: hoeun.ryu@lge.com.com
X-Original-SENDERIP: 10.177.226.38
X-Original-MAILFROM: hoeun.ryu@lge.com.com
From: Hoeun Ryu <hoeun.ryu@lge.com.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Hoeun Ryu <hoeun.ryu@lge.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] panic: move bust_spinlocks(0) after console_flush_on_panic() to avoid deadlocks
Date: Mon,  4 Jun 2018 14:45:57 +0900
Message-Id: <1528091179-3015-1-git-send-email-hoeun.ryu@lge.com.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoeun Ryu <hoeun.ryu@lge.com>

 Many console device drivers hold the uart_port->lock spinlock with irq enabled
(using spin_lock()) while the device drivers are writing characters to their devices,
but the device drivers just try to hold the spin lock (using spin_trylock()) if
"oops_in_progress" is equal or greater than 1 to avoid deadlocks.

 There is a case ocurring a deadlock related to the lock and oops_in_progress. A CPU
could be stopped by smp_send_stop() while it was holding the port lock because irq was
enabled. Once a CPU stops, it doesn't respond interrupts anymore and the lock stays
locked forever.

 console_flush_on_panic() is called during panic() and it eventually holds the uart
lock but the lock is held by another stopped CPU and it is a deadlock. By moving
bust_spinlocks(0) after console_flush_on_panic(), let the console device drivers
think the Oops is still in progress to call spin_trylock() instead of spin_lock() to
avoid the deadlock.

Signed-off-by: Hoeun Ryu <hoeun.ryu@lge.com>
---
 kernel/panic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 42e4874..b4063b6 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -233,8 +233,6 @@ void panic(const char *fmt, ...)
 	if (_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
-	bust_spinlocks(0);
-
 	/*
 	 * We may have ended up stopping the CPU holding the lock (in
 	 * smp_send_stop()) while still having some valuable data in the console
@@ -246,6 +244,8 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic();
 
+	bust_spinlocks(0);
+
 	if (!panic_blink)
 		panic_blink = no_blink;
 
-- 
2.1.4
