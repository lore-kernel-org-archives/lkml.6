Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeDLKdu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 06:33:50 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:40713 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeDLKds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 06:33:48 -0400
X-Google-Smtp-Source: AIpwx4/W5xyPDkvyaZgvV+Fpal/dg/rwyMpAqv2J7nlZbxB1/NlMYU8vlKdzQMex4ANIg+zVOhFLXvX+vXHaLvvuCN0=
MIME-Version: 1.0
In-Reply-To: <20180412091822.GG12256@bigcity.dyn.berto.se>
References: <20180412091822.GG12256@bigcity.dyn.berto.se>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Apr 2018 12:33:27 +0200
Message-ID: <CAKfTPtAE3qeWcTdT-WL8nrbZmP_+OaxPyyjUfVCzn=rax9tQZQ@mail.gmail.com>
Subject: Re: Potential problem with 31e77c93e432dec7 ("sched/fair: Update
 blocked load when newly idle")
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3CAXr8Y020743

Hi Niklas,

On 12 April 2018 at 11:18, Niklas Söderlund
<niklas.soderlund@ragnatech.se> wrote:
> Hi Vincent,
>
> I have observed issues running on linus/master from a few days back [1].
> I'm running on a Renesas Koelsch board (arm32) and I can trigger a issue
> by X forwarding the v4l2 test application qv4l2 over ssh and moving the
> courser around in the GUI (best test case description award...). I'm
> sorry about the really bad way I trigger this but I can't do it in any
> other way, I'm happy to try other methods if you got some ideas. The
> symptom of the issue is a complete hang of the system for more then 30
> seconds and then this information is printed in the console:

Heiner (edded cc) also reported similar problem with his platform: a
dual core celeron

Do you confirm that your platform is a dual cortex-A15 ? At least that
what I have seen on web
This would confirm that dual system is a key point.

The ssh connection is also common with Heiner's setup

>
> [  142.849390] INFO: rcu_sched detected stalls on CPUs/tasks:
> [  142.854972]  1-...!: (1 GPs behind) idle=7a4/0/0 softirq=3214/3217 fqs=0
> [  142.861976]  (detected by 0, t=8232 jiffies, g=930, c=929, q=11)
> [  142.868042] Sending NMI from CPU 0 to CPUs 1:
> [  142.872443] NMI backtrace for cpu 1
> [  142.872452] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.16.0-05506-g28aba11c1393691a #14
> [  142.872455] Hardware name: Generic R8A7791 (Flattened Device Tree)
> [  142.872473] PC is at arch_cpu_idle+0x28/0x44
> [  142.872484] LR is at trace_hardirqs_on_caller+0x1a4/0x1d4
> [  142.872488] pc : [<c01088a4>]    lr : [<c01747a8>]    psr: 20070013
> [  142.872491] sp : eb0b9f90  ip : eb0b9f60  fp : eb0b9f9c
> [  142.872495] r10: 00000000  r9 : 413fc0f2  r8 : 4000406a
> [  142.872498] r7 : c0c08478  r6 : c0c0842c  r5 : ffffe000  r4 : 00000002
> [  142.872502] r3 : eb0b6ec0  r2 : 00000000  r1 : 00000004  r0 : 00000001
> [  142.872507] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [  142.872511] Control: 10c5387d  Table: 6a61406a  DAC: 00000051
> [  142.872516] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.16.0-05506-g28aba11c1393691a #14
> [  142.872519] Hardware name: Generic R8A7791 (Flattened Device Tree)
> [  142.872522] Backtrace:
> [  142.872534] [<c010cbf8>] (dump_backtrace) from [<c010ce78>] (show_stack+0x18/0x1c)
> [  142.872540]  r7:c0c81388 r6:00000000 r5:60070193 r4:c0c81388
> [  142.872550] [<c010ce60>] (show_stack) from [<c07dec20>] (dump_stack+0xa4/0xd8)
> [  142.872557] [<c07deb7c>] (dump_stack) from [<c0108b38>] (show_regs+0x14/0x18)
> [  142.872563]  r9:00000001 r8:00000000 r7:c0c4f678 r6:eb0b9f40 r5:00000001 r4:c13e1130
> [  142.872571] [<c0108b24>] (show_regs) from [<c07e4cd0>] (nmi_cpu_backtrace+0xfc/0x118)
> [  142.872578] [<c07e4bd4>] (nmi_cpu_backtrace) from [<c010fb28>] (handle_IPI+0x2a8/0x320)
> [  142.872583]  r7:c0c4f678 r6:eb0b9f40 r5:00000007 r4:c0b75b68
> [  142.872594] [<c010f880>] (handle_IPI) from [<c03cb528>] (gic_handle_irq+0x8c/0x98)
> [  142.872599]  r10:00000000 r9:eb0b8000 r8:f0803000 r7:c0c4f678 r6:eb0b9f40 r5:c0c08a90
> [  142.872602]  r4:f0802000
> [  142.872608] [<c03cb49c>] (gic_handle_irq) from [<c01019f0>] (__irq_svc+0x70/0x98)
> [  142.872612] Exception stack(0xeb0b9f40 to 0xeb0b9f88)
> [  142.872618] 9f40: 00000001 00000004 00000000 eb0b6ec0 00000002 ffffe000 c0c0842c c0c08478
> [  142.872624] 9f60: 4000406a 413fc0f2 00000000 eb0b9f9c eb0b9f60 eb0b9f90 c01747a8 c01088a4
> [  142.872627] 9f80: 20070013 ffffffff
> [  142.872632]  r9:eb0b8000 r8:4000406a r7:eb0b9f74 r6:ffffffff r5:20070013 r4:c01088a4
> [  142.872642] [<c010887c>] (arch_cpu_idle) from [<c07fb1a8>] (default_idle_call+0x34/0x38)
> [  142.872650] [<c07fb174>] (default_idle_call) from [<c0155fe0>] (do_idle+0xe0/0x134)
> [  142.872656] [<c0155f00>] (do_idle) from [<c0156398>] (cpu_startup_entry+0x20/0x24)
> [  142.872660]  r7:c0c8e9d0 r6:10c0387d r5:00000051 r4:00000085
> [  142.872667] [<c0156378>] (cpu_startup_entry) from [<c010f644>] (secondary_start_kernel+0x114/0x134)
> [  142.872673] [<c010f530>] (secondary_start_kernel) from [<401026ec>] (0x401026ec)
> [  142.872676]  r5:00000051 r4:6b0a406a
> [  142.873456] rcu_sched kthread starved for 8235 jiffies! g930 c929 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
> [  143.135040] RCU grace-period kthread stack dump:
> [  143.139695] rcu_sched       I    0     9      2 0x00000000
> [  143.145234] Backtrace:
> [  143.147719] [<c07f5120>] (__schedule) from [<c07f5b3c>] (schedule+0x94/0xb8)
> [  143.154823]  r10:c0b714c0 r9:c0c85f8a r8:ffffffff r7:eb0abec4 r6:ffffa274 r5:00000000
> [  143.162712]  r4:ffffe000
> [  143.165273] [<c07f5aa8>] (schedule) from [<c07fa940>] (schedule_timeout+0x440/0x4b0)
> [  143.173076]  r5:00000000 r4:eb79c4c0
> [  143.176692] [<c07fa500>] (schedule_timeout) from [<c0196e08>] (rcu_gp_kthread+0x958/0x150c)
> [  143.185108]  r10:c0c87274 r9:00000000 r8:c0c165b8 r7:00000001 r6:00000000 r5:c0c16590
> [  143.192997]  r4:c0c16300
> [  143.195560] [<c01964b0>] (rcu_gp_kthread) from [<c0145eb8>] (kthread+0x148/0x160)
> [  143.203099]  r7:c0c16300
> [  143.205660] [<c0145d70>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> [  143.212938] Exception stack(0xeb0abfb0 to 0xeb0abff8)
> [  143.218030] bfa0:                                     00000000 00000000 00000000 00000000
> [  143.226271] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [  143.234511] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [  143.241177]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0145d70
> [  143.249065]  r4:eb037b00
>
> After the freeze the system becomes responsive again and I can sometimes
> trigger the hang multiple times. I tried to bisect the problem and I
> found that by reverting [2] I can no longer reproduce the issue. I can
> also not reproduce the issue on v4.16.  I can't figure out if reverting
> [2] is just treating a symptom or the root cause of my troubles and
> would appreciate your input. Also my "test-case" do not trigger every
> time but I have tested this scenario quiet a lot and the result seems to
> be constant.
>
> My test setup involves a NFS root filesystem, I ssh in and launch the
> GUI application over X forwarding. From what I know the application is
> not doing any ioctl calls to the v4l2 framework it's just sitting there
> idle as I move the courser around showing tool tips and such as I hover
> over elements and then it freeze up. I have not observed this issue by
> just booting the system and leaving it idle, movement in the GUI seems
> to be the key to trigger this.
>
> I'm a bit lost on how to progress with this issue and would appreciate
> any help you can provide to help me figure this out.

Can you send me your config ?

I'm going to prepare a debug patch to spy what's happening when entering idle

Regards,
Vincent
>
> 1. c18bb396d3d261eb ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net"))
> 2. 31e77c93e432dec7 ("sched/fair: Update blocked load when newly idle")
>
> --
> Regards,
> Niklas Söderlund
