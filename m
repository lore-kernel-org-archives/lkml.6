Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031768AbeBNWNV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 17:13:21 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:50264 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031551AbeBNWNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 17:13:19 -0500
From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [v4.14-rt][report] arm: just another rcu_note_context_switch
To: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>
Message-ID: <6f2e005d-26c1-19ca-283a-5f5e441e2f80@ti.com>
Date: Wed, 14 Feb 2018 16:12:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.247.59.147]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I can see below warning during boot on few TI boards am437x-idk, am335x-evm, am335x-ice
All of them are non-SMP

[    1.229376] NET: Registered protocol family 10
[    1.235443] ------------[ cut here ]------------
[    1.235489] WARNING: CPU: 0 PID: 18 at kernel/rcu/tree_plugin.h:310 rcu_note_context_switch+0x1b4/0x528
[    1.235494] Modules linked in:
[    1.235514] CPU: 0 PID: 18 Comm: kworker/0:1 Not tainted 4.14.19-rt15-177004-gd5e1859 #3
[    1.235518] Hardware name: Generic AM33XX (Flattened Device Tree)
[    1.235539] Workqueue: ipv6_addrconf addrconf_verify_work
[    1.235544] Backtrace: 
[    1.235577] [<c010b848>] (dump_backtrace) from [<c010bb18>] (show_stack+0x18/0x1c)
[    1.235588]  r7:00000009 r6:00000000 r5:c098d728 r4:00000000
[    1.235602] [<c010bb00>] (show_stack) from [<c07d4b70>] (dump_stack+0x24/0x28)
[    1.235620] [<c07d4b4c>] (dump_stack) from [<c01295e4>] (__warn+0xe8/0x100)
[    1.235631] [<c01294fc>] (__warn) from [<c01296b4>] (warn_slowpath_null+0x28/0x30)
[    1.235642]  r9:00000000 r8:a0000013 r7:ffffe000 r6:00000000 r5:cf063800 r4:c0c18380
[    1.235654] [<c012968c>] (warn_slowpath_null) from [<c017a148>] (rcu_note_context_switch+0x1b4/0x528)
[    1.235672] [<c0179f94>] (rcu_note_context_switch) from [<c07e99a4>] (__schedule+0x7c/0x64c)
[    1.235682]  r10:cf108000 r9:00000000 r8:a0000013 r7:ffffe000 r6:c0c12b10 r5:00000000
[    1.235687]  r4:cf063800 r3:001eab3b
[    1.235698] [<c07e9928>] (__schedule) from [<c07e9fd4>] (schedule+0x60/0xf8)
[    1.235708]  r10:cf108000 r9:00000000 r8:a0000013 r7:cf109df0 r6:cf063800 r5:cf063800
[    1.235712]  r4:cf108000
[    1.235726] [<c07e9f74>] (schedule) from [<c07eb9e4>] (rt_spin_lock_slowlock_locked+0x130/0x250)
[    1.235731]  r5:c0c12000 r4:cf108000
[    1.235742] [<c07eb8b4>] (rt_spin_lock_slowlock_locked) from [<c07ebb60>] (rt_spin_lock_slowlock+0x5c/0xa8)
[    1.235752]  r9:00000000 r8:00000001 r7:cf109e74 r6:c0c4ec18 r5:a0000013 r4:ffffe000
[    1.235767] [<c07ebb04>] (rt_spin_lock_slowlock) from [<c07ed850>] (rt_spin_lock+0x48/0x4c)
[    1.235772]  r5:ffffe000 r4:c0c11c94
[    1.235788] [<c07ed808>] (rt_spin_lock) from [<c0140340>] (try_to_grab_pending+0x50/0x20c)
[    1.235798] [<c01402f0>] (try_to_grab_pending) from [<c0140524>] (__cancel_work+0x28/0xa0)
[    1.235808]  r9:00000000 r8:cfd82300 r7:00000000 r6:00000001 r5:c0c4ec18 r4:c0c18640
[    1.235819] [<c01404fc>] (__cancel_work) from [<c01405b0>] (cancel_delayed_work+0x14/0x18)
[    1.235826]  r6:51eb851f r5:ffffba7c r4:c0c18640
[    1.235837] [<c014059c>] (cancel_delayed_work) from [<c076e374>] (addrconf_verify_rtnl+0x84/0x448)
[    1.235847] [<c076e2f0>] (addrconf_verify_rtnl) from [<c076e74c>] (addrconf_verify_work+0x14/0x1c)
[    1.235857]  r10:cf108000 r9:00000000 r8:cfd82300 r7:00000000 r6:c0c11c94 r5:cf0eff80
[    1.235861]  r4:c0c4ec18
[    1.235871] [<c076e738>] (addrconf_verify_work) from [<c013fadc>] (process_one_work+0x1b4/0x3e8)
[    1.235881] [<c013f928>] (process_one_work) from [<c013fd68>] (worker_thread+0x58/0x5e0)
[    1.235891]  r10:cf108000 r9:c0c11cbc r8:c0c18640 r7:00000008 r6:cf0eff98 r5:c0c11c94
[    1.235895]  r4:cf0eff80
[    1.235912] [<c013fd10>] (worker_thread) from [<c0145d6c>] (kthread+0x130/0x160)
[    1.235922]  r10:cf04de94 r9:cf104198 r8:cf0eff80 r7:cf108000 r6:cf0ff100 r5:00000000
[    1.235926]  r4:cf104180
[    1.235937] [<c0145c3c>] (kthread) from [<c0107bd0>] (ret_from_fork+0x14/0x24)
[    1.235947]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0145c3c
[    1.235951]  r4:cf0ff100
[    1.235955] ---[ end trace 0000000000000001 ]---
