Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750914AbeDNEHa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 00:07:30 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:44888 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbeDNEH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 00:07:29 -0400
X-Google-Smtp-Source: AIpwx4/c2mI/5qK5THc2kwsgGdzAMGpfbRjKp+apz40vAXNlvqVGxfTiMfZqPVE9spaWourJqyddcYG5dY1ivN8VTr8=
MIME-Version: 1.0
From: Jacek Tomaka <jacekt@dug.com>
Date: Sat, 14 Apr 2018 12:07:27 +0800
Message-ID: <CAKVxXCW+i7G=iY+xcNZRrs70Y9FiChYdTMD35deLuFXvLvo59g@mail.gmail.com>
Subject: Re: NO_HZ_FULL and tick running within a reasonable amount of time
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Apr 03, 2018 at 10:08:58AM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 03, 2018 at 01:41:31PM +0200, Frederic Weisbecker wrote:
> > > On Mon, Apr 02, 2018 at 03:04:38PM -0700, Paul E. McKenney wrote:
> > > > Hello!
> > > >
> > > > I am hitting the following on today's mainline under rcutorture, but
> > > > only on scenarios built with CONFIG_NO_HZ_FULL=y:
> > > >
> > > > ------------------------------------------------------------------------
> > > >
> > > > WARNING: CPU: 0 PID: 7 at /home/paulmck/public_git/linux-rcu/kernel/sched/core.c:3124 sched_tick_remote+0x113/0x120
> > > > Modules linked in:
> > > > CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 4.16.0+ #1
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> > > > Workqueue: events_unbound sched_tick_remote
> > > > RIP: 0010:sched_tick_remote+0x113/0x120
> > > > RSP: 0018:ffff94d540103e20 EFLAGS: 00010002
> > > > RAX: 000000012e9bb357 RBX: ffff8f95dfd21840 RCX: 000000000000001f
> > > > RDX: 00000000b2d05e00 RSI: 00000000ffffffff RDI: ffff8f95dfd21858
> > > > RBP: ffff94d540103e48 R08: 00000000f6499019 R09: 00000000f6499000
> > > > R10: 00000000b163d33b R11: ffffffffa5c8c212 R12: ffff8f95dfd25518
> > > > R13: ffff8f95de9e4200 R14: 0000000000003402 R15: ffff8f95dfd21858
> > > > FS:  0000000000000000(0000) GS:ffff8f95dfc00000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 000000000a015b40 CR3: 000000001de14000 CR4: 00000000000006f0
> > > > Call Trace:
> > > >  process_one_work+0x1d9/0x6a0
> > > >  worker_thread+0x42/0x420
> > > >  kthread+0xf3/0x130
> > > >  ? rescuer_thread+0x340/0x340
> > > >  ? kthread_delayed_work_timer_fn+0x80/0x80
> > > >  ret_from_fork+0x3a/0x50
> > > > Code: ff 48 8b 83 80 0b 00 00 48 85 c0 0f 85 41 ff ff ff e9 45 ff ff ff be ff ff ff ff 4c 89 ff e8 55 44 02 00 85 c0 75 87 0f 0b eb 83 <0f> 0b eb 97 66 0f 1f 84 00 00 00 00 00 41 57 41 56 41 55 41 54
> > > > ---[ end trace fbdcbe529a8ae799 ]--
> > > >
> > > > ------------------------------------------------------------------------
> > > >
> > > > The WARN_ON_ONCE() triggering is this guy:
> > > >
> > > > delta = rq_clock_task(rq) - curr->se.exec_start;
> > > > WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
> > >
> > > Weird. Can you try to print up those values and see how much they drift?
> > >
> > >         if (WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3))
> > >                printk_once("clock_task: %lld exec_start: %lld\n", rq_clock_task(rq), curr-> >se.exec_start);
> >
> > Here you go!
> >
> > Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > WARNING: CPU: 0 PID: 7 at /home/paulmck/public_git/linux-rcu/kernel/sched/core.c:3124 sched_tick_remote+0xdb/0x100
> > Modules linked in:
> > CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 4.16.0+ #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> > Workqueue: events_unbound sched_tick_remote
> > RIP: 0010:sched_tick_remote+0xdb/0x100
> > RSP: 0018:ffffa2c440103e60 EFLAGS: 00010006
> > RAX: 00000000b2d05e00 RBX: ffff96f0dfd20980 RCX: 000000016a8de322
> > RDX: 000000000d33a301 RSI: 0000000177c18623 RDI: fffffffeb0bf0e53
> > RBP: ffff96f0dfd24328 R08: 0000000000000000 R09: 0000000000000001
> > R10: 0000000000000000 R11: 0000000000000000 R12: ffff96f0de9d2640
> > R13: 0000000000000000 R14: 0ffff96f0de81700 R15: ffff96f0de96f540
> > FS:  0000000000000000(0000) GS:ffff96f0dfc00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000f7ec6ca3 CR3: 000000001e03e000 CR4: 00000000000006f0
> > Call Trace:
> >  process_one_work+0x139/0x3e0
> >  worker_thread+0x42/0x420
> >  kthread+0xf3/0x130
> >  ? create_worker+0x190/0x190
> >  ? kthread_destroy_worker+0x40/0x40
> >  ret_from_fork+0x35/0x40
> > Code: 89 8b 43 04 85 c0 0f 85 75 ff ff ff 48 8b 83 e0 0a 00 00 48 85 c0 0f 85 65 ff ff ff e9 69 ff ff ff 48 89 df e8 87 fe ff ff eb 8d <0f> 0b 80 3d 7d 57 2b 01 00 75 a8 48 c7 c7 e8 e1 fd a4 c6 05 6d
> > ---[ end trace f0c6a1afa55d130d ]---
> > clock_task: 6304138787 exec_start: 221487873
> >
>
> That's a 6 second delay, it's huge!
>
> Could it be because you use Qemu and the virtualized CPUs got interrupted for
a long while?

Hello,
I am seeing the following message as well and I am running it on real
hardware (Intel Xeon Phi 7250):
My kernel parameters include:
nohz_full=1-271 noretpoline isolcpus=nohz

RCU threads are pinned to cpu zero
for i in `pgrep rcu[^c]` ; do
    taskset -pc 0 $i
done

One thing i noticed though that my date is not set properly:
-bash-4.2# date
Thu Jan  1 10:56:21 UTC 1970

Probably because of :
[    0.000000] NO_HZ: Full dynticks CPUs: 1-271.
[    0.000000]  Offload RCU callbacks from CPUs: 1-271.
[    0.000000] WARNING: Persistent clock returned invalid value!
[    0.000000]          Check your CMOS/BIOS settings.
?

Here is the message i am seeing (kernel is tainted because I stripped
debug symbols without resigning):

[  133.471425] WARNING: CPU: 0 PID: 2185 at kernel/sched/core.c:3124
sched_tick_remote+0xf5/0x100
[  133.576313] Modules linked in: coretemp(E) nfsv4(E) dns_resolver(E)
nfs(E) lockd(E) grace(E) sunrpc(E) fscache(E) bridge(E) tg3(E)
ipmi_ssif(E) ipmi_devintf(E) ipmi_si(E) ip
mi_msghandler(E) e1000(E) igb(E) e1000e(E) ixgbe(E) i40e(E)
mlx5_core(E) mlx4_en(E) vxlan(E) ip6_udp_tunnel(E) udp_tunnel(E)
ip_tunnel(E) mlx4_core(E) mlxfw(E) devlink(E) mdio(
E) i2c_algo_bit(E) i2c_piix4(E) i2c_core(E) 8021q(E) mrp(E) garp(E)
stp(E) llc(E) dca(E)
[  134.044162] CPU: 0 PID: 2185 Comm: kworker/u544:2 Tainted: G
    E     4.16.0+ #1
[  134.142670] Hardware name: Intel Corporation S7200AP/S7200AP, BIOS
S72C610.86B.01.02.0072.041620172102 04/16/2017
[  134.267638] Workqueue: events_unbound sched_tick_remote
[  134.331240] RIP: 0010:sched_tick_remote+0xf5/0x100
[  134.389540] RSP: 0018:ffffb009c6653e60 EFLAGS: 00010006
[  134.453132] RAX: 0000001e8285ce48 RBX: ffff91c8ebe62500 RCX: ffff91c8ebe40000
[  134.540003] RDX: 00000000b2d05e00 RSI: ffff91c5c3d50000 RDI: 0000000000000031
[  134.626875] RBP: ffff91c8ebe65e28 R08: ffff91c8ebca5e30 R09: ffff91c8ebca5e30
[  134.713742] R10: 0000000000000000 R11: 0000000000000018 R12: ffff91c5c7d18000
[  134.800609] R13: ffff91c5c7d20000 R14: 0000000000000000 R15: ffff91c8ebe65e30
[  134.887477] FS:  0000000000000000(0000) GS:ffff91c8eb200000(0000)
knlGS:0000000000000000
[  134.985988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  135.055930] CR2: 00007f8cd5352f70 CR3: 000000036f40a000 CR4: 00000000001406f0
[  135.142801] Call Trace:
[  135.172563]  process_one_work+0x152/0x350
[  135.221345]  worker_thread+0x47/0x3e0
[  135.265903]  kthread+0xf5/0x130
[  135.304109]  ? max_active_store+0x80/0x80
[  135.352893]  ? kthread_bind+0x10/0x10
[  135.397458]  ret_from_fork+0x35/0x40
[  135.440953] Code: 83 40 0b 00 00 48 85 c0 0f 85 5f ff ff ff e9 63
ff ff ff 80 3d dd ef 12 01 00 75 a0 48 89 34 24 e8 5e 55 00 00 48 8b
34 24 eb 91 <0f> 0b eb a5 0f 1f 80 00
00 00 00 0f 1f 44 00 00 41 56 41 55 41
[  135.670765] ---[ end trace 7031db6a8ce43506 ]--

Regards.
-- 
Jacek Tomaka
