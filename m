Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbeDMUiS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 16:38:18 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:38863 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbeDMUiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 16:38:16 -0400
X-Google-Smtp-Source: AIpwx4/ihyi/6n8p+EqHpOYj04QYbPYnnamMd7z7hbBs/0k64FdhqCh1fMiqgUYtUESHJ8+PZ6mQiA==
Date: Fri, 13 Apr 2018 22:38:13 +0200
From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Potential problem with 31e77c93e432dec7 ("sched/fair: Update
 blocked load when newly idle")
Message-ID: <20180413203813.GB8132@bigcity.dyn.berto.se>
References: <20180412091822.GG12256@bigcity.dyn.berto.se>
 <CAKfTPtAE3qeWcTdT-WL8nrbZmP_+OaxPyyjUfVCzn=rax9tQZQ@mail.gmail.com>
 <20180412111519.GH12256@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180412111519.GH12256@bigcity.dyn.berto.se>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 2018-04-12 13:15:19 +0200, Niklas Söderlund wrote:
> Hi Vincent,
> 
> Thanks for your feedback.
> 
> On 2018-04-12 12:33:27 +0200, Vincent Guittot wrote:
> > Hi Niklas,
> > 
> > On 12 April 2018 at 11:18, Niklas Söderlund
> > <niklas.soderlund@ragnatech.se> wrote:
> > > Hi Vincent,
> > >
> > > I have observed issues running on linus/master from a few days back [1].
> > > I'm running on a Renesas Koelsch board (arm32) and I can trigger a issue
> > > by X forwarding the v4l2 test application qv4l2 over ssh and moving the
> > > courser around in the GUI (best test case description award...). I'm
> > > sorry about the really bad way I trigger this but I can't do it in any
> > > other way, I'm happy to try other methods if you got some ideas. The
> > > symptom of the issue is a complete hang of the system for more then 30
> > > seconds and then this information is printed in the console:
> > 
> > Heiner (edded cc) also reported similar problem with his platform: a
> > dual core celeron
> > 
> > Do you confirm that your platform is a dual cortex-A15 ? At least that
> > what I have seen on web
> > This would confirm that dual system is a key point.
> 
> I can confirm that my platform is a dual core.

I tested another dual core system today Renesas M3-W ARM64 system and I 
can observe the same lockups-on that system if it helps you understand 
the problem. It seems to be much harder to trigger the issue on this 
system for some reason. Hitting return in a ssh session don't seem to 
produce the lockup while starting a GUI using X forwarding over ssh it's 
possible.

[  392.306441] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  392.312201]  (detected by 0, t=19366 jiffies, g=7177, c=7176, q=35)
[  392.318555] All QSes seen, last rcu_preempt kthread activity 19368 
(4294990375-4294971007), jiffies_till_next_fqs=1, root ->qsmask 0x0
[  392.330758] swapper/0       R  running task        0     0      0 
0x00000022
[  392.337883] Call trace:
[  392.340365]  dump_backtrace+0x0/0x1c8
[  392.344065]  show_stack+0x14/0x20
[  392.347416]  sched_show_task+0x224/0x2e8
[  392.351377]  rcu_check_callbacks+0x8ac/0x8b0
[  392.355686]  update_process_times+0x2c/0x58
[  392.359908]  tick_sched_handle.isra.5+0x30/0x50
[  392.364479]  tick_sched_timer+0x40/0x90
[  392.368351]  __hrtimer_run_queues+0xfc/0x208
[  392.372659]  hrtimer_interrupt+0xd4/0x258
[  392.376710]  arch_timer_handler_virt+0x28/0x48
[  392.381194]  handle_percpu_devid_irq+0x80/0x138
[  392.385767]  generic_handle_irq+0x28/0x40
[  392.389813]  __handle_domain_irq+0x5c/0xb8
[  392.393946]  gic_handle_irq+0x58/0xa8
[  392.397640]  el1_irq+0xb4/0x130
[  392.400810]  arch_cpu_idle+0x14/0x20
[  392.404422]  default_idle_call+0x1c/0x38
[  392.408381]  do_idle+0x17c/0x1f8
[  392.411640]  cpu_startup_entry+0x20/0x28
[  392.415598]  rest_init+0x24c/0x260
[  392.419037]  start_kernel+0x3e8/0x414

I was running the same tests on another ARM64 platform earlier using the 
same build which have more then two cores and there I could not observe 
this issue.

-- 
Regards,
Niklas Söderlund
