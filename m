Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9DAC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAE8217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAE8217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeHDO0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 10:26:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:44625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbeHDO0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 10:26:20 -0400
Received: from homer.simpson.net ([185.221.151.107]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9fLX-1feWxZ0ION-00D3G4; Sat, 04
 Aug 2018 14:25:22 +0200
Message-ID: <1533385520.5602.31.camel@gmx.de>
Subject: Re: [rt-patch 4/3] arm,KVM: Move phys_timer handling to hard irq
 context
From:   Mike Galbraith <efault@gmx.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Sat, 04 Aug 2018 14:25:20 +0200
In-Reply-To: <1533231816.12550.54.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532764179.9882.14.camel@gmx.de> <1532768853.9882.73.camel@gmx.de>
         <1533192980.11791.8.camel@gmx.de>
         <20180802123104.7fed73b4@gandalf.local.home>
         <1533228650.12550.15.camel@gmx.de> <1533231816.12550.54.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GeScqmksnAxH2mdPqhaKYG5+7kvTRdFT9WrwYnlB1w8B5mWowiT
 86rGKYBNQXq3mQI7GREloQ4KQDKx45GuWqCGz59X1fvdw0PUaLLde42qdl9lw3CBwnK6MZ6
 isSICZJxXB8T8MvW5kJyAhCd1onmSFFKdrOXkHJm1PT069mmisTI6S3FrQMssJQLtchhAAV
 CElJQcmtRARtOzUbVt7yA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cl3qqrC3fqk=:B0fJSIU98OZ4COmJYR1BPQ
 LdZBqykKFpHsjQPUCNbXv7rSdvR1WMPEYUBcH1R0GVwJ5wMfH9ejKsOAzi6bDGR4P24bdiXPR
 Vuhp2hZFTshqDZNzSOgPiFqEAYftXQaE6JRPO5nDHcoyk4biBGjqJ0/0JyIDJJo3k2zYYU0hi
 rME9wqkL9NzVqumi+LW/qDmJ8V05HV/721hLVJFBCVpGVjuu9FnL8AxXtajuhkbkZ13YC991o
 VqF6h0Tv1I9e5v7zG1mgN71ePoE6Dqczj5AIHyPGVm1KNjn7sdiPSCPFzrOg9UMcLTxhKLE43
 6m4a+GCZmHMd/7G87uB8Z+4tIO76u2nuOd87mEo/LQ53Mhu7FOCLvZ1f75BEdsDjd2yEScSmp
 0qhjR8EgdvQUyb0oLFNSGZOo8zK0dZDeroI5P0yMgp7GBTTZRR6T4nGUaaQQuVBtYJcDS2S+6
 TpJ2tcdUJvy6QQmJzmzPivaFz0/hNqAJKBF+u3W4GLHY+Z4dJ2LMS0ZlSkE+EOaLCdmyyMj/Y
 t1S2RZ12oqfiVDwmtBGwess93v7xz8ut0IkwiJ6tv1CN/d7VkZ8fjwuy55pWD61HNbICeAGnL
 f0ly9/TmhQMs4p8N66h0HQyz28JhlkhD4KBSkTGBdMgksJRCmaLz7mz/rq+UrhDgr67GE+oqj
 V5ILISOcG+TEpibPM/ubZP3O6QOzzJNiYTAlMCWUaRh0CuAwevyTeyH8MiNq7Rfp5qOPiSijy
 h9SYHw0uTJFnMMupuf3zmBLHM06XvWabUg8UBxbJpeWLn0PHMp3LSQnTmegs8O6WokUTlyHiz
 tawMluP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 19:43 +0200, Mike Galbraith wrote:
> On Thu, 2018-08-02 at 18:50 +0200, Mike Galbraith wrote:
> > On Thu, 2018-08-02 at 12:31 -0400, Steven Rostedt wrote:
> > > On Thu, 02 Aug 2018 08:56:20 +0200
> > > Mike Galbraith <efault@gmx.de> wrote:
> > > 
> > > > (arm-land adventures 1/3 take2 will have to wait, my cup runeth over) 
> > > > 
> > > > v4.14..v4.15 timer handling changes including calling kvm_timer_vcpu_load()
> > > 
> > > I take it that this should be added to v4.16-rt and marked stable-rt?
> > 
> > Yeah, barring way sexier ideas of course.
> 
> Gah, wait.  WRT marking for stable-rt, only the pmu allocation splat
> fix is applicable to @stable-rt, kvm locking woes start at 4.15.

None of that series got picked up, so the pmu patch is moot as well. 
The warning is harmless anyway.

Besides, there are more interesting fish in the arm64 sea than kvm.

virgin 4.16.18-rt12-rt

[  537.236131] ITS queue timeout (65440 65504 4640)
[  537.236150] ITS cmd its_build_inv_cmd failed
[  537.236160] sched: RT throttling activated
[ 1229.180124] ITS queue timeout (65440 65504 3744)
[ 1229.180134] ITS cmd its_build_inv_cmd failed

(converts those to trace_printk [invalidating virgin source warantee])

# tracer: nop
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | /  _----=> need-resched_lazy
#                            || / _---=> hardirq/softirq
#                            ||| / _--=> preempt-depth
#                            |||| /     delay
#           TASK-PID   CPU#  |||||    TIMESTAMP  FUNCTION
#              | |       |   |||||       |         |
          <idle>-0     [000] d..h2..    84.967153: its_wait_for_range_completion+0xa8/0xe0: ITS queue timeout (65440 65504 96)
          <idle>-0     [000] d..h2..    84.967155: its_send_single_command+0xd4/0x130: ITS cmd its_build_inv_cmd failed

(starts cyclictest+kbuild)

[ 9609.602489] NOHZ: local_softirq_pending 10
[10089.311713] NOHZ: local_softirq_pending 80
[10089.311735] NOHZ: local_softirq_pending 80
[10097.315809] NOHZ: local_softirq_pending 80
[10112.262436] NOHZ: local_softirq_pending 10
[10118.966066] NOHZ: local_softirq_pending 80
[10121.211106] NOHZ: local_softirq_pending 80
[10121.287093] NOHZ: local_softirq_pending 80
[10329.501202] NOHZ: local_softirq_pending 80
[10329.501231] NOHZ: local_softirq_pending 80

T:60 (17291) P:99 I:31000 C:  18128 Min:      5 Act:   12 Avg:  107 Max: 1581163 <== Thar she blows!

 irq/464-eth0-Tx-3955  [060] d...111 11015.059743: its_wait_for_range_completion+0xa8/0xe0: ITS queue timeout (65440 65504 5280)
 irq/464-eth0-Tx-3955  [060] d...111 11015.059749: <stack trace>
 => irq_chip_unmask_parent+0x2c/0x38
 => its_unmask_msi_irq+0x28/0x38
 => unmask_irq.part.4+0x30/0x50
 => unmask_threaded_irq+0x4c/0x58
 => irq_finalize_oneshot.part.2+0x9c/0x100
 => irq_forced_thread_fn+0x60/0x98
 => irq_thread+0x148/0x1e0
 => kthread+0x140/0x148
 => ret_from_fork+0x10/0x18
 irq/464-eth0-Tx-3955  [060] d...111 11015.059751: its_send_single_command+0xd4/0x130: ITS cmd its_build_inv_cmd failed
 irq/464-eth0-Tx-3955  [060] d...111 11015.059752: <stack trace>
 => its_unmask_msi_irq+0x28/0x38
 => unmask_irq.part.4+0x30/0x50
 => unmask_threaded_irq+0x4c/0x58
 => irq_finalize_oneshot.part.2+0x9c/0x100
 => irq_forced_thread_fn+0x60/0x98
 => irq_thread+0x148/0x1e0
 => kthread+0x140/0x148
 => ret_from_fork+0x10/0x18
 irq/464-eth0-Tx-3955  [060] d..h311 11015.059764: update_curr_rt+0x280/0x320: sched: RT throttling activated
 irq/464-eth0-Tx-3955  [060] d..h311 11015.059765: <stack trace>
 => update_process_times+0x48/0x60
 => tick_sched_handle.isra.5+0x34/0x70
 => tick_sched_timer+0x54/0xa8
 => __hrtimer_run_queues+0xf8/0x388
 => hrtimer_interrupt+0xe4/0x258
 => arch_timer_handler_phys+0x38/0x58
 => handle_percpu_devid_irq+0xa8/0x2c8
 => generic_handle_irq+0x34/0x50
 => __handle_domain_irq+0x8c/0x100
 => gic_handle_irq+0x80/0x18c
 => el1_irq+0xb4/0x13c
 => _raw_spin_unlock_irq+0x2c/0x78
 => irq_finalize_oneshot.part.2+0x6c/0x100
 => irq_forced_thread_fn+0x60/0x98
 => irq_thread+0x148/0x1e0
 => kthread+0x140/0x148
 => ret_from_fork+0x10/0x18
          <idle>-0     [008] d..h3.. 11015.374565: sched_rt_period_timer+0x2f0/0x420: sched: RT throttling deactivated
          <idle>-0     [008] d..h3.. 11015.374570: <stack trace>
 => arch_timer_handler_phys+0x38/0x58
 => handle_percpu_devid_irq+0xa8/0x2c8
 => generic_handle_irq+0x34/0x50
 => __handle_domain_irq+0x8c/0x100
 => gic_handle_irq+0x80/0x18c
 => el1_irq+0xb4/0x13c
 => arch_cpu_idle+0x2c/0x1d0
 => default_idle_call+0x30/0x48
 => do_idle+0x1c4/0x218
 => cpu_startup_entry+0x2c/0x30
 => secondary_start_kernel+0x184/0x1d0
