Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E72C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D380A20847
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D380A20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbeHWQop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:44:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46296 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbeHWQop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:44:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E559ED1;
        Thu, 23 Aug 2018 06:15:05 -0700 (PDT)
Received: from red-moon (red-moon.emea.arm.com [10.4.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 088F13F5BC;
        Thu, 23 Aug 2018 06:15:03 -0700 (PDT)
Date:   Thu, 23 Aug 2018 14:15:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: CPU: 0 PID: 14 at kernel/kthread.c:501
 kthread_park+0x44/0xa4 (was: Re: kthread: Simplify kthread_park()
 completion)
Message-ID: <20180823131505.GA31558@red-moon>
References: <20180813220011.D03DE21C8F@pdx-korg-gitolite-1.ci.codeaurora.org>
 <CAMuHMdVg868LgL5xTg5Dp5rReKxoo+8fRy+ETJiMxGWZCp+hWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVg868LgL5xTg5Dp5rReKxoo+8fRy+ETJiMxGWZCp+hWw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 08:38:39PM +0200, Geert Uytterhoeven wrote:
> Hoi Peter,
> 
> On Tue, Aug 14, 2018 at 12:00 AM Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org> wrote:
> > Web:        https://git.kernel.org/torvalds/c/f83ee19be4272564ad592ef90145db7295229490
> > Commit:     f83ee19be4272564ad592ef90145db7295229490
> > Parent:     167a88677b05d6a810f23b871cfb2b5db1808e60
> > Refname:    refs/heads/master
> > Author:     Peter Zijlstra <peterz@infradead.org>
> > AuthorDate: Thu Jun 7 10:55:56 2018 +0200
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Tue Jul 3 09:20:44 2018 +0200
> >
> >     kthread: Simplify kthread_park() completion
> >
> >     Oleg explains the reason we could hit park+park is that
> >     smpboot_update_cpumask_percpu_thread()'s
> >
> >       for_each_cpu_and(cpu, &tmp, cpu_online_mask)
> >             smpboot_park_kthread();
> >
> >     turns into:
> >
> >       for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)and)
> >             smpboot_park_kthread();
> >
> >     on UP, ignoring the mask. But since we just completely removed that
> >     function, this is no longer relevant.
> >
> >     So revert commit:
> >
> >       b1f5b378e126 ("kthread: Allow kthread_park() on a parked kthread")
> >
> >     Suggested-by: Oleg Nesterov <oleg@redhat.com>
> >     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >     Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Cc: Thomas Gleixner <tglx@linutronix.de>
> >     Cc: linux-kernel@vger.kernel.org
> >     Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  kernel/kthread.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index 750cb8082694..11b591ee51ab 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -190,7 +190,7 @@ static void __kthread_parkme(struct kthread *self)
> >                 if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
> >                         break;
> >
> > -               complete_all(&self->parked);
> > +               complete(&self->parked);
> >                 schedule();
> >         }
> >         __set_current_state(TASK_RUNNING);
> > @@ -465,7 +465,6 @@ void kthread_unpark(struct task_struct *k)
> >         if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
> >                 __kthread_bind(k, kthread->cpu, TASK_PARKED);
> >
> > -       reinit_completion(&kthread->parked);
> >         clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
> >         /*
> >          * __kthread_parkme() will either see !SHOULD_PARK or get the wakeup.
> > @@ -493,6 +492,9 @@ int kthread_park(struct task_struct *k)
> >         if (WARN_ON(k->flags & PF_EXITING))
> >                 return -ENOSYS;
> >
> > +       if (WARN_ON_ONCE(test_bit(KTHREAD_SHOULD_PARK, &kthread->flags)))
> > +               return -EBUSY;
> > +
> >         set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
> >         if (k != current) {
> >                 wake_up_process(k);
> 
> The above WARN_ON_ONCE() triggers during psci_checker operation when booting
> on R-Car Gen3 (arm64) SoCs where a trusted OS is resident on CPU0.
> 
> Reverting the commit fixes the issue.
> 
> Dmesg before/after on R-Car H3 ES2.0:
> 
>  psci: probing for conduit method from DT.
>  psci: PSCIv1.0 detected in firmware.
>  psci: Using standard PSCI v0.2 function IDs
>  psci: Trusted OS resident on physical CPU 0x0
>  psci: SMC Calling Convention v1.0
>  ...
>  psci_checker: Trying to turn off and on again group 0 (CPUs 0-3)
> +WARNING: CPU: 0 PID: 14 at kernel/kthread.c:501 kthread_park+0x44/0xa4
> +Modules linked in:
> +CPU: 0 PID: 14 Comm: cpuhp/0 Not tainted
> 4.18.0-salvator-x-00407-gbc763e81b483a4e3 #170
> +Hardware name: Renesas Salvator-X 2nd version board based on r8a7795
> ES2.0+ (DT)
> +pstate: 80400005 (Nzcv daif +PAN -UAO)
> +pc : kthread_park+0x44/0xa4
> +lr : smpboot_park_threads+0x88/0x94
> +sp : ffffff8009dcbca0
> +x29: ffffff8009dcbca0 x28: ffffff80081156cc
> +x27: ffffff800900e000 x26: 00000046f7027000
> +x25: ffffff8008e9cfc0 x24: ffffffc6ffec3fc0
> +x23: ffffff80090305b8 x22: 0000000000000000
> +x21: ffffffc6fb8ab200 x20: 0000000000000001
> +x19: ffffff80090269e8 x18: ffffffc6fb897348
> +x17: 0000000000000000 x16: 0000000000000000
> +x15: 0000000000000400 x14: 0000000000000400
> +x13: 0000000000000400 x12: 0000000000000001
> +x11: 0000000000000400 x10: 0000000000000400
> +x9 : 0000000000000125 x8 : 0000000000000000
> +x7 : ffffff80081156f8 x6 : 0000000000000001
> +x5 : 0000000000000000 x4 : ffffff8009804b40
> +x3 : 000000007cbd3c4e x2 : 38716e04a5aa3600
> +x1 : 0000000004208040 x0 : ffffffc6fb95c240
> +Call trace:
> + kthread_park+0x44/0xa4
> + smpboot_park_threads+0x88/0x94
> + cpuhp_invoke_callback+0x230/0xcfc
> + cpuhp_thread_fun+0xb8/0x1d8
> + smpboot_thread_fn+0x228/0x244
> + kthread+0x124/0x134
> + ret_from_fork+0x10/0x18
> +irq event stamp: 3390
> +hardirqs last  enabled at (3389): [<ffffff800818729c>]
> generic_exec_single+0x80/0x11c
> +hardirqs last disabled at (3390): [<ffffff80080818cc>]
> do_debug_exception+0x5c/0x17c
> +softirqs last  enabled at (1810): [<ffffff8008081da8>] __do_softirq+0x160/0x4ec
> +softirqs last disabled at (1795): [<ffffff80080ed460>] irq_exit+0xa4/0x100
> +---[ end trace 518ee2fb840813cb ]---
>  CPU1: shutdown
>  psci: CPU1 killed.
> -NOHZ: local_softirq_pending 51
> +NOHZ: local_softirq_pending 55
>  CPU2: shutdown
>  psci: CPU2 killed.
>  NOHZ: local_softirq_pending 51
>  CPU3: shutdown
>  psci: CPU3 killed.
>  Detected PIPT I-cache on CPU1
>  CPU1: Booted secondary processor 0x0000000001 [0x411fd073]
>  Detected PIPT I-cache on CPU2
>  CPU2: Booted secondary processor 0x0000000002 [0x411fd073]
>  Detected PIPT I-cache on CPU3
>  CPU3: Booted secondary processor 0x0000000003 [0x411fd073]
> 
> The issue can also be seen on R-Car M3-W and M3-N.  It does not happen
> on R-Car H3 ES1.0 with an older firmware version, where no trusted OS
> is running on CPU0 ("psci: Trusted OS migration not required").

The problem is caused by __cpu_disable() returning -EPERM. I was
expecting the hotplug state machine to rollback the state
but it seems that, in _cpu_down() the callback following
CPUHP_TEARDOWN_CPU (ie CPUHP_AP_SMPBOOT_THREADS, that should call
smpboot_unpark_threads()) is skipped. I am trying to debug the
hotplug state machine and I am not familiar enough with that code
to pinpoint an issue but I have more than a feeling that reverting
the patch removes the warning but does _not_ fix the underlying
issue.

You can easily reproduce the problem by tring to hotplug CPU0
out through sysfs (and AFAICS it is a problem also on other
arches where __cpu_disable() may return an error).

Lorenzo
