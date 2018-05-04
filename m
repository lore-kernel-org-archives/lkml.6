Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeEDJL4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:11:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53982 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEDJLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:11:54 -0400
Date: Fri, 4 May 2018 11:11:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, wfg@linux.intel.com
Subject: Re: 85f1abe001 ("kthread, sched/wait: Fix kthread_parkme() .."):
 WARNING: CPU: 0 PID: 1 at kernel/kthread.c:486 kthread_park
Message-ID: <20180504091142.GI12235@hirez.programming.kicks-ass.net>
References: <5aeb303f.ZSZnAoV6lBIOMHs0%lkp@intel.com>
 <20180503165452.GH12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503165452.GH12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 06:54:52PM +0200, Peter Zijlstra wrote:
> On Thu, May 03, 2018 at 11:52:31PM +0800, kernel test robot wrote:
> > [    0.011005] CPU: GenuineIntel Intel Core Processor (Haswell) (family: 0x6, model: 0x3c, stepping: 0x4)
> > [    0.012011] Spectre V2 : Spectre mitigation: kernel not compiled with retpoline; no mitigation available!
> > [    0.013949] Performance Events: no PMU driver, software events only.
> > [    0.019490] NMI watchdog: Perf event create on CPU 0 failed with -2
> > [    0.020005] NMI watchdog: Perf NMI watchdog permanently disabled
> > [    0.020692] WARNING: CPU: 0 PID: 1 at kernel/kthread.c:486 kthread_park+0x2b/0x56
> > [    0.021000] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc3-00038-g85f1abe #687
> > [    0.021000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > [    0.021000] EIP: kthread_park+0x2b/0x56
> > [    0.021000] EFLAGS: 00210202 CPU: 0
> > [    0.021000] EAX: cf464d40 EBX: cf422500 ECX: 00000000 EDX: 00000004
> > [    0.021000] ESI: c221e2c0 EDI: 00000000 EBP: cf42df68 ESP: cf42df60
> > [    0.021000]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068
> > [    0.021000] CR0: 80050033 CR2: ffffffff CR3: 022e8000 CR4: 00140690
> > [    0.021000] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [    0.021000] DR6: fffe0ff0 DR7: 00000400
> > [    0.021000] Call Trace:
> > [    0.021000]  smpboot_update_cpumask_percpu_thread+0x28/0x42
> > [    0.021000]  softlockup_update_smpboot_threads+0x37/0x39
> > [    0.021000]  lockup_detector_reconfigure+0x17/0x62
> > [    0.021000]  lockup_detector_init+0x5d/0x69
> > [    0.021000]  kernel_init_freeable+0x52/0x15c
> > [    0.021000]  ? rest_init+0xf4/0xf4
> > [    0.021000]  kernel_init+0x8/0xd0
> > [    0.021000]  ret_from_fork+0x19/0x30
> > [    0.021000] Code: 55 89 e5 56 53 8b 50 14 0f ba e2 15 72 02 0f 0b 8b 98 44 03 00 00 80 e2 04 74 09 0f 0b be da ff ff ff eb 2c 8b 13 80 e2 04 74 09 <0f> 0b be f0 ff ff ff eb 1c 80 0b 04 8b 15 70 de f6 c1 31 f6 39 
> > [    0.021000] ---[ end trace 3a71adb42feecba7 ]---
> > [    0.021060] TSC deadline timer enabled
> 
> Clearly my machine didn't do that :-)
> 
> I think I see what's going on, this path actually does a kthread_park()
> when already parked, which sorta used to work.
> 
> Let me try and fix that.

I tried to reproduce using kvm, but I cannot trigger the above. I
suspect the below will cure things, can you confirm?

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 2017a39ab490..481951bf091d 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -193,7 +193,7 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
 
 void kthread_park_complete(struct task_struct *k)
 {
-	complete(&to_kthread(k)->parked);
+	complete_all(&to_kthread(k)->parked);
 }
 
 static int kthread(void *_create)
@@ -459,6 +459,7 @@ void kthread_unpark(struct task_struct *k)
 	if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
 		__kthread_bind(k, kthread->cpu, TASK_PARKED);
 
+	reinit_completion(&kthread->parked);
 	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	wake_up_state(k, TASK_PARKED);
 }
@@ -483,9 +484,6 @@ int kthread_park(struct task_struct *k)
 	if (WARN_ON(k->flags & PF_EXITING))
 		return -ENOSYS;
 
-	if (WARN_ON_ONCE(test_bit(KTHREAD_SHOULD_PARK, &kthread->flags)))
-		return -EBUSY;
-
 	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	if (k != current) {
 		wake_up_process(k);
