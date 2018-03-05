Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeCERgl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:36:41 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60127 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbeCERgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:36:40 -0500
Date: Mon, 5 Mar 2018 18:36:38 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.14.24-rt19
Message-ID: <20180305173638.nu66gsbn6nvnwnf4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.14.24-rt19 patch set. 

Changes since v4.14.24-rt18:

  - Some adjtimex related code has been moved to a helper thread after
    it has been claimed that it is called from hard interrupt context.
    I was not able to find that hard interrupt context and now that
    change is reverted.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.14.24-rt18 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.24-rt18-rt19.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.24-rt19

The RT patch against v4.14.24 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.24-rt19.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.24-rt19.tar.xz

Sebastian

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 2c226b90c231..99e03bec68e4 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/math64.h>
-#include <linux/swork.h>
 
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -570,35 +569,10 @@ static void sync_cmos_clock(struct work_struct *work)
 			   &sync_cmos_work, timespec64_to_jiffies(&next));
 }
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-
-static void run_clock_set_delay(struct swork_event *event)
-{
-	queue_delayed_work(system_power_efficient_wq, &sync_cmos_work, 0);
-}
-
-static struct swork_event ntp_cmos_swork;
-
-void ntp_notify_cmos_timer(void)
-{
-	swork_queue(&ntp_cmos_swork);
-}
-
-static __init int create_cmos_delay_thread(void)
-{
-	WARN_ON(swork_get());
-	INIT_SWORK(&ntp_cmos_swork, run_clock_set_delay);
-	return 0;
-}
-early_initcall(create_cmos_delay_thread);
-
-#else
-
 void ntp_notify_cmos_timer(void)
 {
 	queue_delayed_work(system_power_efficient_wq, &sync_cmos_work, 0);
 }
-#endif /* CONFIG_PREEMPT_RT_FULL */
 
 #else
 void ntp_notify_cmos_timer(void) { }
diff --git a/localversion-rt b/localversion-rt
index 9e7cd66d9f44..483ad771f201 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt18
+-rt19
