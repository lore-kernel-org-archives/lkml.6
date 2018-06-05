Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeFECV3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 22:21:29 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:56887 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751194AbeFECV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 22:21:28 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: hoeun.ryu@lge.com.com
X-Original-SENDERIP: 10.177.226.38
X-Original-MAILFROM: hoeun.ryu@lge.com.com
From: Hoeun Ryu <hoeun.ryu@lge.com.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Andi Kleen <ak@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, Hoeun Ryu <hoeun.ryu@lge.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] panic: move bust_spinlocks(0) after console_flush_on_panic() to avoid deadlocks
Date: Tue,  5 Jun 2018 11:19:13 +0900
Message-Id: <1528165248-17914-1-git-send-email-hoeun.ryu@lge.com.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoeun Ryu <hoeun.ryu@lge.com>

 Many console device drivers hold the uart_port->lock spinlock with irq disabled
(using spin_lock_irqsave()) while the device drivers are writing characters to their
devices, but the device drivers just try to hold the spin lock (using
spin_trylock_irqsave()) instead if "oops_in_progress" is equal or greater than 1 to
avoid deadlocks.

 There is a case ocurring a deadlock related to the lock and oops_in_progress. If the
kernel lockup detector calls panic() while the device driver is holding the lock,
it can cause a deadlock because panic() eventually calls console_unlock() and tries
to hold the lock. Here is an example.

 CPU0

 local_irq_save()
 .
 foo()
 bar()
 .						// foo() + bar() takes long time
 printk()
   console_unlock()
     call_console_drivers()			// close to watchdog threshold
       some_slow_console_device_write()		// device driver code
         spin_lock_irqsave(uart->lock)		// acquire uart spin lock
           slow-write()
             watchdog_overflow_callback()	// watchdog expired and call panic()
               panic()
                 bust_spinlocks(0)		// now, oops_in_progress = 0
                   console_flush_on_panic()
                     console_unlock()
                       call_console_drivers()
                         some_slow_console_device_write()
                           spin_lock_irqsave(uart->lock)
                           ^^^^ deadlock	// we can use spin_trylock_irqsave()

 console_flush_on_panic() is called in panic() and it eventually holds the uart
lock but the lock is held by the preempted CPU (the same CPU in NMI context) and it is
a deadlock.
 By moving bust_spinlocks(0) after console_flush_on_panic(), let the console device
drivers think the Oops is still in progress to call spin_trylock_irqsave() instead of
spin_lock_irqsave() to avoid the deadlock.

 CPU0

 watchdog_overflow_callback()			// watchdog expired and call panic()
   panic()
     console_flush_on_panic()
       console_unlock()
         call_console_drivers()
           some_slow_console_device_write()
             spin_trylock_irqsave(uart->lock)	// oops_in_progress = 1
             ^^^^ use trylock, no deadlock
     bust_spinlocks(0)				// now, oops_in_progress = 0

Signed-off-by: Hoeun Ryu <hoeun.ryu@lge.com>
---
 v2: fix commit message on the reason of a deadlock, no code change.

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
