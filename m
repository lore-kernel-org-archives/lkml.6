Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0F5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B56C20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfAKXvf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:51:35 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:55630 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfAKXve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:51:34 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gi6aB-0005cI-LT; Fri, 11 Jan 2019 16:51:23 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gi6a8-0006aS-25; Fri, 11 Jan 2019 16:51:23 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     zzoru <zzoru007@gmail.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        Andrey Vagin <avagin@virtuozzo.com>,
        "dsahern\@gmail.com" <dsahern@gmail.com>,
        "nicolas.dichtel\@6wind.com" <nicolas.dichtel@6wind.com>,
        "tyhicks\@canonical.com" <tyhicks@canonical.com>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller\@googlegroups.com" <syzkaller@googlegroups.com>
References: <bc63c776-99f9-ca6e-0e81-f91b1448932b@gmail.com>
        <87fttzaq8k.fsf@xmission.com>
        <fa46d362-9ced-8376-0770-e39a658c24ec@virtuozzo.com>
        <81dab6a7-a28d-552f-d0d8-f83f9d261200@gmail.com>
Date:   Fri, 11 Jan 2019 17:50:54 -0600
In-Reply-To: <81dab6a7-a28d-552f-d0d8-f83f9d261200@gmail.com> (zzoru's message
        of "Sat, 12 Jan 2019 08:31:05 +0900")
Message-ID: <87imyuah41.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1gi6a8-0006aS-25;;;mid=<87imyuah41.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+oBLXaWcaJoUdk9vts56CjlpvxGV3xuFk=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: net/core: BUG in copy_net_ns()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zzoru <zzoru007@gmail.com> writes:

>> I received 3 spam messages from this address today.
>> We can simply ignore this report.
> I already mentioned about this.
>
>> and, sorry for my encrypted mails.
>> I don't understand this failure report at all.
>>
>> I don't see the connection to copy_net_ns().  And I don't see how the
>> suggested patch short of covering up a memory stomp could possibly make
>> a difference.
>>
>> What am I missing?
>> void execute_one(void)
>> {
>>   syscall(__NR_unshare, 0x40000000);
>> }
> ksys_unshare -> unshare_nsproxy_namespaces -> create_new_namespaces ->
> copy_net_ns
> unshare(CLONE_NEWNET) calls copy_net_ns() (It requires the CAP_SYS_ADMIN
> capability)

Looking at your alternate patch where you switch the structure
order it looks like there is a memory stomp.  Probably a use
after free.  It is a shame that KASAN is not catching the problem.
That is my only suggestion at the moment.

The OOM may be because network namespaces are created in quick
succession and they take a while to free.

One of the nasty truths about testing is sometimes you can be testing
one thing and you can trigger a bug in something completely different.
Right now it looks like anything that copy_net_ns calls could be
responsible for the memory problems.

Eric


> I made many error reports about this bug, and the other one is
>
> [   90.289025] WARNING: CPU: 1 PID: 1732 at mm/page_alloc.c:4415
> __alloc_pages_slowpath+0x1cb1/0x2220
> [   90.290223] Modules linked in:
> [   90.290639] CPU: 1 PID: 1732 Comm: kworker/u4:5 Not tainted 5.0.0-rc1+ #6
> [   90.291475] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [   90.292681] Workqueue: writeback wb_workfn (flush-8:0)
> [   90.293350] RIP: 0010:__alloc_pages_slowpath+0x1cb1/0x2220
> [   90.294075] Code: 8b 84 24 a8 00 00 00 e9 ea f1 ff ff 85 d2 0f 85 0b
> 01 00 00 48 c7 c7 c0 5e 55 84 e8 79 f8 23 02 e9 86 f9 ff ff 44 8b 74 24
> 0c <0f> 0b 48 b8 00 00 00 00 00 fc ff df 48 8b 54 24 18 48 c1 ea 03 80
> [   90.296527] RSP: 0018:ffff888064276dd8 EFLAGS: 00010046
> [   90.297203] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 1ffff1100c84eda8
> [   90.297784] kmemleak: Cannot allocate a kmemleak_object structure
> [   90.298186] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff88807ffdd528
> [   90.298242] RBP: dffffc0000000000 R08: 0000000000000000 R09:
> 0000000000000679
> [   90.298247] R10: 0000000000000000 R11: ffff88807ffdc487 R12:
> 0000000000000000
> [   90.298251] R13: ffff888064277030 R14: 0000000000415a00 R15:
> ffff888064277030
> [   90.298257] FS:  0000000000000000(0000) GS:ffff88806d500000(0000)
> knlGS:0000000000000000
> [   90.298262] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   90.298267] CR2: 00007fff6ac6a718 CR3: 0000000056578000 CR4:
> 00000000000006e0
> [   90.298272] Call Trace:
> [   90.298283]  ? __alloc_pages_slowpath+0x1ce6/0x2220
> [   90.298299]  ? warn_alloc+0x120/0x120
> [   90.302432] kmemleak: Kernel memory leak detector disabled
> [   90.303346]  ? lock_acquire+0x103/0x2e0
> [   90.303358]  ? __isolate_free_page+0x4b0/0x4b0
> [   90.303366]  ? __lock_is_held+0xad/0x140
> [   90.303377]  __alloc_pages_nodemask+0x521/0x5f0
> [   90.303386]  ? __alloc_pages_slowpath+0x2220/0x2220
> [   90.315010]  cache_grow_begin+0x95/0x300
> [   90.315613]  fallback_alloc+0x1ce/0x270
> [   90.316211]  ? mempool_free+0x360/0x360
> [   90.316767]  kmem_cache_alloc+0x286/0x2f0
> [   90.317348]  ? mempool_free+0x360/0x360
> [   90.317919]  create_object+0x83/0x880
> [   90.318517]  ? kmemleak_disable+0x90/0x90
> [   90.319103]  ? mark_held_locks+0xc1/0x140
> [   90.319679]  ? kmem_cache_alloc+0x9c/0x2f0
> [   90.320307]  ? mempool_free+0x360/0x360
> [   90.320900]  kmem_cache_alloc+0x18f/0x2f0
> [   90.321650]  ? mempool_free+0x360/0x360
> [   90.322228]  mempool_alloc+0x13e/0x340
> [   90.322765]  ? mempool_destroy+0x30/0x30
> [   90.323370]  ? mark_held_locks+0xc1/0x140
> [   90.323993]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
> [   90.324786]  bio_alloc_bioset+0x36f/0x5d0
> [   90.325397]  ? __test_set_page_writeback+0x136/0x960
> [   90.326161]  ? bvec_alloc+0x2d0/0x2d0
> [   90.326708]  ? wait_for_stable_page+0x290/0x290
> [   90.327392]  submit_bh_wbc.isra.57+0x128/0x680
> [   90.328053]  ? create_page_buffers+0x111/0x200
> [   90.328685]  __block_write_full_page+0x6e8/0xcd0
> [   90.329339]  ? check_disk_change+0x130/0x130
> [   90.329966]  block_write_full_page+0x202/0x250
> [   90.330675]  ? check_disk_change+0x130/0x130
> [   90.331291]  __writepage+0x62/0xe0
> [   90.331786]  write_cache_pages+0x5b8/0xf60
> [   90.332375]  ? __wb_calc_thresh+0x290/0x290
> [   90.332976]  ? clear_page_dirty_for_io+0x5c0/0x5c0
> [   90.333686]  ? mark_held_locks+0x140/0x140
> [   90.334301]  ? print_circular_bug_entry+0x1f/0x60
> [   90.334999]  ? __lock_acquire+0x5d6/0x4630
> [   90.335621]  generic_writepages+0xda/0x150
> [   90.336243]  ? write_cache_pages+0xf60/0xf60
> [   90.336852]  ? mark_held_locks+0x140/0x140
> [   90.337453]  ? blkdev_readpages+0x30/0x30
> [   90.338020]  do_writepages+0xf0/0x290
> [   90.338611]  ? page_writeback_cpu_online+0x10/0x10
> [   90.339324]  ? __lock_is_held+0xad/0x140
> [   90.339900]  __writeback_single_inode+0xf3/0x1000
> [   90.340587]  writeback_sb_inodes+0x4e7/0xce0
> [   90.341214]  ? __writeback_single_inode+0x1000/0x1000
> [   90.341929]  ? down_read_trylock+0x5b/0x90
> [   90.342579]  ? trylock_super+0x1d/0x100
> [   90.343162]  __writeback_inodes_wb+0x109/0x220
> [   90.343799]  wb_writeback+0x7a1/0xb90
> [   90.344347]  ? writeback_inodes_wb.constprop.44+0x190/0x190
> [   90.345143]  ? cpumask_next+0x1f/0x30
> [   90.345679]  ? find_next_bit+0x101/0x130
> [   90.346281]  ? get_nr_dirty_inodes+0xd0/0x130
> [   90.346909]  wb_workfn+0x921/0xec0
> [   90.347397]  ? process_one_work+0xadd/0x1bb0
> [   90.348025]  ? inode_wait_for_writeback+0x30/0x30
> [   90.348700]  process_one_work+0xbbd/0x1bb0
> [   90.349314]  ? max_active_store+0x130/0x130
> [   90.349915]  ? do_raw_spin_lock+0x11b/0x280
> [   90.350557]  worker_thread+0x8c/0x1060
> [   90.351096]  ? __kthread_parkme+0xf8/0x1a0
> [   90.351673]  ? process_one_work+0x1bb0/0x1bb0
> [   90.352334]  kthread+0x347/0x410
> [   90.352798]  ? kthread_create_worker_on_cpu+0xe0/0xe0
> [   90.353509]  ret_from_fork+0x3a/0x50
> [   90.354020] irq event stamp: 282384
> [   90.354590] hardirqs last  enabled at (282383): [<ffffffff8160678c>]
> kmem_cache_alloc+0x9c/0x2f0
> [   90.355832] hardirqs last disabled at (282384): [<ffffffff8160674d>]
> kmem_cache_alloc+0x5d/0x2f0
> [   90.357066] softirqs last  enabled at (282196): [<ffffffff816daa87>]
> wb_workfn+0x387/0xec0
> [   90.358280] softirqs last disabled at (282194): [<ffffffff816da918>]
> wb_workfn+0x218/0xec0
> [   90.359426] ---[ end trace 71c4462c6227f0d8 ]---
> [   90.360135] kmemleak: Cannot allocate a kmemleak_object structure
> [   90.888624] a.out invoked oom-killer:
> gfp_mask=0x6040d0(GFP_KERNEL|__GFP_COMP|__GFP_RECLAIMABLE), order=0,
> oom_score_adj=0
> [   90.890564] CPU: 0 PID: 22248 Comm: a.out Tainted: G        W        
> 5.0.0-rc1+ #6
> [   90.891793] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [   90.893263] Call Trace:
> [   90.893678]  dump_stack+0xca/0x13e
> [   90.894242]  dump_header+0x108/0xaef
> [   90.894822]  ? ___ratelimit+0x5b/0x436
> [   90.895430]  oom_kill_process.cold.38+0x10/0xa87
> [   90.896164]  ? lock_downgrade+0x5d0/0x5d0
> [   90.896806]  ? _raw_spin_unlock+0x1f/0x30
> [   90.897445]  ? oom_badness+0xc8/0x770
> [   90.898045]  out_of_memory+0x32a/0x1ab0
> [   90.898668]  ? oom_killer_disable+0x280/0x280
> [   90.899365]  ? mutex_trylock+0x162/0x1a0
> [   90.899998]  __alloc_pages_slowpath+0x1b7a/0x2220
> [   90.900754]  ? warn_alloc+0x120/0x120
> [   90.901344]  ? find_held_lock+0x33/0x1c0
> [   90.901985]  __alloc_pages_nodemask+0x521/0x5f0
> [   90.902723]  ? __alloc_pages_slowpath+0x2220/0x2220
> [   90.903499]  ? mark_held_locks+0xc1/0x140
> [   90.904137]  ? cache_grow_begin+0x28f/0x300
> [   90.904807]  cache_grow_begin+0x95/0x300
> [   90.905443]  fallback_alloc+0x1ce/0x270
> [   90.906074]  kmem_cache_alloc+0x286/0x2f0
> [   90.906720]  ? sock_destroy_inode+0x60/0x60
> [   90.907392]  sock_alloc_inode+0x18/0x250
> [   90.908021]  ? sock_destroy_inode+0x60/0x60
> [   90.908690]  alloc_inode+0x5e/0x180
> [   90.909254]  new_inode_pseudo+0x12/0xd0
> [   90.909868]  sock_alloc+0x3c/0x270
> [   90.910428]  __sock_create+0xbe/0x740
> [   90.911026]  inet_ctl_sock_create+0x8c/0x1e0
> [   90.911710]  ? inet_current_timestamp+0xc0/0xc0
> [   90.912432]  ? rcu_read_lock_sched_held+0x10f/0x130
> [   90.913205]  ? find_next_bit+0x101/0x130
> [   90.913837]  icmpv6_sk_init+0x12a/0x2b0
> [   90.914463]  ? inet6_net_init+0x437/0x7c0
> [   90.915102]  ? icmpv6_err_convert+0x180/0x180
> [   90.915799]  ? ac6_proc_init+0x5a/0x70
> [   90.916402]  ? inet6_net_init+0x53b/0x7c0
> [   90.917041]  ? icmpv6_err_convert+0x180/0x180
> [   90.917734]  ops_init+0xb2/0x400
> [   90.918265]  setup_net+0x24c/0x5e0
> [   90.918817]  ? ops_init+0x400/0x400
> [   90.919386]  copy_net_ns+0x1a2/0x270
> [   90.919969]  create_new_namespaces+0x579/0x790
> [   90.920676]  unshare_nsproxy_namespaces+0xc3/0x190
> [   90.921435]  ksys_unshare+0x428/0x810
> [   90.922029]  ? walk_process_tree+0x2c0/0x2c0
> [   90.922712]  ? __change_pid+0x19c/0x2c0
> [   90.923328]  ? _raw_write_unlock_irq+0x24/0x30
> [   90.924038]  ? trace_hardirqs_on_thunk+0x1a/0x1c
> [   90.924771]  ? trace_hardirqs_off_caller+0x55/0x1c0
> [   90.925547]  __x64_sys_unshare+0x2d/0x40
> [   90.926187]  do_syscall_64+0xbc/0x4e0
> [   90.926777]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   90.927573] RIP: 0033:0x7f827ad52229
> [   90.928146] Code: Bad RIP value.
> [   90.928663] RSP: 002b:00007fff6ac6a6c8 EFLAGS: 00000217 ORIG_RAX:
> 0000000000000110
> [   90.929837] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007f827ad52229
> [   90.930952] RDX: 00007f827ad27147 RSI: 0000000000000000 RDI:
> 0000000040000000
> [   90.932056] RBP: 00007fff6ac6a6d0 R08: 0000000000000005 R09:
> 00007fff6ac6a720
> [   90.933165] R10: 0000000000000000 R11: 0000000000000217 R12:
> 00005607242822e0
> [   90.934278] R13: 00007fff6ac6a830 R14: 0000000000000000 R15:
> 0000000000000000
>
> I just guess that copy_net_ns func doesn't call net_free, and it makes OOM.
>
> And, I found that
>
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 99d4148e0f90..38c474e4ab4c 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -50,12 +50,12 @@ struct bpf_prog;
>  #define NETDEV_HASHENTRIES (1 << NETDEV_HASHBITS)
>
>  struct net {
> -       refcount_t              passive;        /* To decided when the
> network
> -                                                * namespace should be
> freed.
> -                                                */
>         refcount_t              count;          /* To decided when the
> network
>                                                  *  namespace should be
> shut down.
>                                                  */
> +       refcount_t              passive;        /* To decided when the
> network
> +                                                * namespace should be
> freed.
> +                                                */
>         spinlock_t              rules_mod_lock;
>
>         atomic64_t              cookie_gen;
>
> this patch also works on this bug. (Just swap the order of net struct.)
> I don't know why this patch works (I just thought that compiler
> optimization issue can make this bug and try this one.)
> I need to review code more on copy_net_ns().
>
> Also, I reproduce this bug on Ubuntu 18.10 (4.18.0-10-generic) on VMWare
> Workstation Pro 15.0.2 by C reproducer.
>
> On 12/01/2019 5:41 오전, Kirill Tkhai wrote:
>> On 11.01.2019 23:33, Eric W. Biederman wrote:
>>> zzoru <zzoru007@gmail.com> writes:
>>>
>>>> net/core: BUG in copy_net_ns() (net_namespace.c)
>>> I don't understand this failure report at all.
>>>
>>> I don't see the connection to copy_net_ns().  And I don't see how the
>>> suggested patch short of covering up a memory stomp could possibly make
>>> a difference.
>>>
>>> What am I missing?
>> I received 3 spam messages from this address today.
>> We can simply ignore this report.
>>
>>>
>>>> Hello,
>>>>
>>>> I've got the following error report while fuzzing the kernel with syzkaller.
>>>>
>>>> On commit 1bdbe227492075d058e37cb3d400e6468d0095b5
>>>>
>>>> Syzkaller hit 'WARNING in __alloc_pages_slowpath' bug.
>>>>
>>>> syz-executor561 (17453) used greatest stack depth: 25056 bytes left
>>>> WARNING: CPU: 0 PID: 692 at mm/page_alloc.c:4415
>>>> __alloc_pages_slowpath+0x1cb1/0x2220 mm/page_alloc.c:4386
>>>> Kernel panic - not syncing: panic_on_warn set ...
>>>> CPU: 0 PID: 692 Comm: kswapd0 Not tainted 5.0.0-rc1+ #4
>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>>> Ubuntu-1.8.2-1ubuntu1 04/01/2014
>>>> Call Trace:
>>>>  __dump_stack lib/dump_stack.c:77 [inline]
>>>>  dump_stack+0xca/0x13e lib/dump_stack.c:113
>>>>  panic+0x278/0x5bf kernel/panic.c:214
>>>>  __warn.cold.10+0x20/0x45 kernel/panic.c:571
>>>>  report_bug+0x246/0x2d0 lib/bug.c:186
>>>>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>>>>  do_error_trap+0x123/0x1e0 arch/x86/kernel/traps.c:271
>>>>  do_invalid_op+0x31/0x40 arch/x86/kernel/traps.c:290
>>>>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
>>>> RIP: 0010:__alloc_pages_slowpath+0x1cb1/0x2220 mm/page_alloc.c:4415
>>>> Code: 8b 84 24 a8 00 00 00 e9 ea f1 ff ff 85 d2 0f 85 0b 01 00 00 48 c7
>>>> c7 c0 5e 55 84 e8 79 f8 23 02 e9 86 f9 ff ff 44 8b 74 24 0c <0f> 0b 48
>>>> b8 00 00 00 00 00 fc ff df 48 8b 54 24 18 48 c1 ea 03 80
>>>> RSP: 0018:ffff8880683fedb8 EFLAGS: 00010046
>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffff1100d07fda4
>>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88807ffdd528
>>>> RBP: dffffc0000000000 R08: 0000000000000000 R09: 000000000000067a
>>>> R10: 0000000000000000 R11: ffff88807ffdc487 R12: 0000000000000000
>>>> R13: ffff8880683ff010 R14: 0000000000415a00 R15: ffff8880683ff010
>>>>  __alloc_pages_nodemask+0x521/0x5f0 mm/page_alloc.c:4555
>>>>  __alloc_pages include/linux/gfp.h:473 [inline]
>>>>  __alloc_pages_node include/linux/gfp.h:486 [inline]
>>>>  kmem_getpages mm/slab.c:1398 [inline]
>>>>  cache_grow_begin+0x95/0x300 mm/slab.c:2666
>>>>  fallback_alloc+0x1ce/0x270 mm/slab.c:3208
>>>>  __do_cache_alloc mm/slab.c:3345 [inline]
>>>>  slab_alloc mm/slab.c:3373 [inline]
>>>>  kmem_cache_alloc+0x286/0x2f0 mm/slab.c:3541
>>>>  create_object+0x83/0x880 mm/kmemleak.c:578
>>>>  kmemleak_alloc_recursive include/linux/kmemleak.h:55 [inline]
>>>>  slab_post_alloc_hook mm/slab.h:442 [inline]
>>>>  slab_alloc mm/slab.c:3381 [inline]
>>>>  kmem_cache_alloc+0x18f/0x2f0 mm/slab.c:3541
>>>>  mempool_alloc+0x13e/0x340 mm/mempool.c:385
>>>>  bio_alloc_bioset+0x36f/0x5d0 block/bio.c:489
>>>>  bio_alloc include/linux/bio.h:393 [inline]
>>>>  submit_bh_wbc.isra.57+0x128/0x680 fs/buffer.c:3061
>>>>  __block_write_full_page+0x6e8/0xcd0 fs/buffer.c:1765
>>>>  block_write_full_page+0x202/0x250 fs/buffer.c:2955
>>>>  pageout mm/vmscan.c:865 [inline]
>>>>  shrink_page_list+0x220f/0x3800 mm/vmscan.c:1383
>>>>  shrink_inactive_list+0x3c2/0xaa0 mm/vmscan.c:1961
>>>>  shrink_list mm/vmscan.c:2273 [inline]
>>>>  shrink_node_memcg.constprop.83+0x4bf/0x10e0 mm/vmscan.c:2538
>>>>  shrink_node+0x162/0xd10 mm/vmscan.c:2753
>>>>  kswapd_shrink_node mm/vmscan.c:3516 [inline]
>>>>  balance_pgdat+0x47f/0xc00 mm/vmscan.c:3674
>>>>  kswapd+0x57c/0xde0 mm/vmscan.c:3929
>>>>  kthread+0x347/0x410 kernel/kthread.c:246
>>>>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
>>>> Dumping ftrace buffer:
>>>>    (ftrace buffer empty)
>>>> Kernel Offset: disabled
>>>> Rebooting in 86400 seconds..
>>>>
>>>>
>>>> Syzkaller reproducer:
>>>> # {Threaded:false Collide:false Repeat:true RepeatTimes:0 Procs:8
>>>> Sandbox:none Fault:false FaultCall:-1 FaultNth:0 EnableTun:false
>>>> UseTmpDir:true EnableCgroups:false EnableNetdev:true ResetNet:false
>>>> HandleSegv:false Repro:false Trace:false}
>>>> unshare(0x40000000)
>>>>
>>>>
>>>> C reproducer:
>>>> // autogenerated by syzkaller (https://github.com/google/syzkaller)
>>>>
>>>> #define _GNU_SOURCE
>>>>
>>>> #include <arpa/inet.h>
>>>> #include <dirent.h>
>>>> #include <endian.h>
>>>> #include <errno.h>
>>>> #include <fcntl.h>
>>>> #include <net/if.h>
>>>> #include <net/if_arp.h>
>>>> #include <netinet/in.h>
>>>> #include <sched.h>
>>>> #include <signal.h>
>>>> #include <stdarg.h>
>>>> #include <stdbool.h>
>>>> #include <stdint.h>
>>>> #include <stdio.h>
>>>> #include <stdlib.h>
>>>> #include <string.h>
>>>> #include <sys/ioctl.h>
>>>> #include <sys/mount.h>
>>>> #include <sys/prctl.h>
>>>> #include <sys/resource.h>
>>>> #include <sys/socket.h>
>>>> #include <sys/stat.h>
>>>> #include <sys/syscall.h>
>>>> #include <sys/time.h>
>>>> #include <sys/types.h>
>>>> #include <sys/uio.h>
>>>> #include <sys/wait.h>
>>>> #include <time.h>
>>>> #include <unistd.h>
>>>>
>>>> #include <linux/if_addr.h>
>>>> #include <linux/if_ether.h>
>>>> #include <linux/if_link.h>
>>>> #include <linux/if_tun.h>
>>>> #include <linux/in6.h>
>>>> #include <linux/ip.h>
>>>> #include <linux/neighbour.h>
>>>> #include <linux/net.h>
>>>> #include <linux/netlink.h>
>>>> #include <linux/rtnetlink.h>
>>>> #include <linux/tcp.h>
>>>> #include <linux/veth.h>
>>>>
>>>> unsigned long long procid;
>>>>
>>>> static void sleep_ms(uint64_t ms)
>>>> {
>>>>   usleep(ms * 1000);
>>>> }
>>>>
>>>> static uint64_t current_time_ms(void)
>>>> {
>>>>   struct timespec ts;
>>>>   if (clock_gettime(CLOCK_MONOTONIC, &ts))
>>>>     exit(1);
>>>>   return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
>>>> }
>>>>
>>>> static void use_temporary_dir(void)
>>>> {
>>>>   char tmpdir_template[] = "./syzkaller.XXXXXX";
>>>>   char* tmpdir = mkdtemp(tmpdir_template);
>>>>   if (!tmpdir)
>>>>     exit(1);
>>>>   if (chmod(tmpdir, 0777))
>>>>     exit(1);
>>>>   if (chdir(tmpdir))
>>>>     exit(1);
>>>> }
>>>>
>>>> static bool write_file(const char* file, const char* what, ...)
>>>> {
>>>>   char buf[1024];
>>>>   va_list args;
>>>>   va_start(args, what);
>>>>   vsnprintf(buf, sizeof(buf), what, args);
>>>>   va_end(args);
>>>>   buf[sizeof(buf) - 1] = 0;
>>>>   int len = strlen(buf);
>>>>   int fd = open(file, O_WRONLY | O_CLOEXEC);
>>>>   if (fd == -1)
>>>>     return false;
>>>>   if (write(fd, buf, len) != len) {
>>>>     int err = errno;
>>>>     close(fd);
>>>>     errno = err;
>>>>     return false;
>>>>   }
>>>>   close(fd);
>>>>   return true;
>>>> }
>>>>
>>>> static struct {
>>>>   char* pos;
>>>>   int nesting;
>>>>   struct nlattr* nested[8];
>>>>   char buf[1024];
>>>> } nlmsg;
>>>>
>>>> static void netlink_init(int typ, int flags, const void* data, int size)
>>>> {
>>>>   memset(&nlmsg, 0, sizeof(nlmsg));
>>>>   struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg.buf;
>>>>   hdr->nlmsg_type = typ;
>>>>   hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags;
>>>>   memcpy(hdr + 1, data, size);
>>>>   nlmsg.pos = (char*)(hdr + 1) + NLMSG_ALIGN(size);
>>>> }
>>>>
>>>> static void netlink_attr(int typ, const void* data, int size)
>>>> {
>>>>   struct nlattr* attr = (struct nlattr*)nlmsg.pos;
>>>>   attr->nla_len = sizeof(*attr) + size;
>>>>   attr->nla_type = typ;
>>>>   memcpy(attr + 1, data, size);
>>>>   nlmsg.pos += NLMSG_ALIGN(attr->nla_len);
>>>> }
>>>>
>>>> static void netlink_nest(int typ)
>>>> {
>>>>   struct nlattr* attr = (struct nlattr*)nlmsg.pos;
>>>>   attr->nla_type = typ;
>>>>   nlmsg.pos += sizeof(*attr);
>>>>   nlmsg.nested[nlmsg.nesting++] = attr;
>>>> }
>>>>
>>>> static void netlink_done(void)
>>>> {
>>>>   struct nlattr* attr = nlmsg.nested[--nlmsg.nesting];
>>>>   attr->nla_len = nlmsg.pos - (char*)attr;
>>>> }
>>>>
>>>> static int netlink_send(int sock)
>>>> {
>>>>   if (nlmsg.pos > nlmsg.buf + sizeof(nlmsg.buf) || nlmsg.nesting)
>>>>     exit(1);
>>>>   struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg.buf;
>>>>   hdr->nlmsg_len = nlmsg.pos - nlmsg.buf;
>>>>   struct sockaddr_nl addr;
>>>>   memset(&addr, 0, sizeof(addr));
>>>>   addr.nl_family = AF_NETLINK;
>>>>   unsigned n = sendto(sock, nlmsg.buf, hdr->nlmsg_len, 0,
>>>>                       (struct sockaddr*)&addr, sizeof(addr));
>>>>   if (n != hdr->nlmsg_len)
>>>>     exit(1);
>>>>   n = recv(sock, nlmsg.buf, sizeof(nlmsg.buf), 0);
>>>>   if (n < sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))
>>>>     exit(1);
>>>>   if (hdr->nlmsg_type != NLMSG_ERROR)
>>>>     exit(1);
>>>>   return -((struct nlmsgerr*)(hdr + 1))->error;
>>>> }
>>>>
>>>> static void netlink_add_device_impl(const char* type, const char* name)
>>>> {
>>>>   struct ifinfomsg hdr;
>>>>   memset(&hdr, 0, sizeof(hdr));
>>>>   netlink_init(RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr, sizeof(hdr));
>>>>   if (name)
>>>>     netlink_attr(IFLA_IFNAME, name, strlen(name));
>>>>   netlink_nest(IFLA_LINKINFO);
>>>>   netlink_attr(IFLA_INFO_KIND, type, strlen(type));
>>>> }
>>>>
>>>> static void netlink_add_device(int sock, const char* type, const char* name)
>>>> {
>>>>   netlink_add_device_impl(type, name);
>>>>   netlink_done();
>>>>   int err = netlink_send(sock);
>>>>   (void)err;
>>>> }
>>>>
>>>> static void netlink_add_veth(int sock, const char* name, const char* peer)
>>>> {
>>>>   netlink_add_device_impl("veth", name);
>>>>   netlink_nest(IFLA_INFO_DATA);
>>>>   netlink_nest(VETH_INFO_PEER);
>>>>   nlmsg.pos += sizeof(struct ifinfomsg);
>>>>   netlink_attr(IFLA_IFNAME, peer, strlen(peer));
>>>>   netlink_done();
>>>>   netlink_done();
>>>>   netlink_done();
>>>>   int err = netlink_send(sock);
>>>>   (void)err;
>>>> }
>>>>
>>>> static void netlink_add_hsr(int sock, const char* name, const char* slave1,
>>>>                             const char* slave2)
>>>> {
>>>>   netlink_add_device_impl("hsr", name);
>>>>   netlink_nest(IFLA_INFO_DATA);
>>>>   int ifindex1 = if_nametoindex(slave1);
>>>>   netlink_attr(IFLA_HSR_SLAVE1, &ifindex1, sizeof(ifindex1));
>>>>   int ifindex2 = if_nametoindex(slave2);
>>>>   netlink_attr(IFLA_HSR_SLAVE2, &ifindex2, sizeof(ifindex2));
>>>>   netlink_done();
>>>>   netlink_done();
>>>>   int err = netlink_send(sock);
>>>>   (void)err;
>>>> }
>>>>
>>>> static void netlink_device_change(int sock, const char* name, bool up,
>>>>                                   const char* master, const void* mac,
>>>>                                   int macsize)
>>>> {
>>>>   struct ifinfomsg hdr;
>>>>   memset(&hdr, 0, sizeof(hdr));
>>>>   if (up)
>>>>     hdr.ifi_flags = hdr.ifi_change = IFF_UP;
>>>>   netlink_init(RTM_NEWLINK, 0, &hdr, sizeof(hdr));
>>>>   netlink_attr(IFLA_IFNAME, name, strlen(name));
>>>>   if (master) {
>>>>     int ifindex = if_nametoindex(master);
>>>>     netlink_attr(IFLA_MASTER, &ifindex, sizeof(ifindex));
>>>>   }
>>>>   if (macsize)
>>>>     netlink_attr(IFLA_ADDRESS, mac, macsize);
>>>>   int err = netlink_send(sock);
>>>>   (void)err;
>>>> }
>>>>
>>>> static int netlink_add_addr(int sock, const char* dev, const void* addr,
>>>>                             int addrsize)
>>>> {
>>>>   struct ifaddrmsg hdr;
>>>>   memset(&hdr, 0, sizeof(hdr));
>>>>   hdr.ifa_family = addrsize == 4 ? AF_INET : AF_INET6;
>>>>   hdr.ifa_prefixlen = addrsize == 4 ? 24 : 120;
>>>>   hdr.ifa_scope = RT_SCOPE_UNIVERSE;
>>>>   hdr.ifa_index = if_nametoindex(dev);
>>>>   netlink_init(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, &hdr,
>>>> sizeof(hdr));
>>>>   netlink_attr(IFA_LOCAL, addr, addrsize);
>>>>   netlink_attr(IFA_ADDRESS, addr, addrsize);
>>>>   return netlink_send(sock);
>>>> }
>>>>
>>>> static void netlink_add_addr4(int sock, const char* dev, const char* addr)
>>>> {
>>>>   struct in_addr in_addr;
>>>>   inet_pton(AF_INET, addr, &in_addr);
>>>>   int err = netlink_add_addr(sock, dev, &in_addr, sizeof(in_addr));
>>>>   (void)err;
>>>> }
>>>>
>>>> static void netlink_add_addr6(int sock, const char* dev, const char* addr)
>>>> {
>>>>   struct in6_addr in6_addr;
>>>>   inet_pton(AF_INET6, addr, &in6_addr);
>>>>   int err = netlink_add_addr(sock, dev, &in6_addr, sizeof(in6_addr));
>>>>   (void)err;
>>>> }
>>>>
>>>> #define DEV_IPV4 "172.20.20.%d"
>>>> #define DEV_IPV6 "fe80::%02hx"
>>>> #define DEV_MAC 0x00aaaaaaaaaa
>>>> static void initialize_netdevices(void)
>>>> {
>>>>   char netdevsim[16];
>>>>   sprintf(netdevsim, "netdevsim%d", (int)procid);
>>>>   struct {
>>>>     const char* type;
>>>>     const char* dev;
>>>>   } devtypes[] = {
>>>>       {"ip6gretap", "ip6gretap0"}, {"bridge", "bridge0"},
>>>>       {"vcan", "vcan0"},           {"bond", "bond0"},
>>>>       {"team", "team0"},           {"dummy", "dummy0"},
>>>>       {"nlmon", "nlmon0"},         {"caif", "caif0"},
>>>>       {"batadv", "batadv0"},       {"vxcan", "vxcan1"},
>>>>       {"netdevsim", netdevsim},    {"veth", 0},
>>>>   };
>>>>   const char* devmasters[] = {"bridge", "bond", "team"};
>>>>   struct {
>>>>     const char* name;
>>>>     int macsize;
>>>>     bool noipv6;
>>>>   } devices[] = {
>>>>       {"lo", ETH_ALEN},
>>>>       {"sit0", 0},
>>>>       {"bridge0", ETH_ALEN},
>>>>       {"vcan0", 0, true},
>>>>       {"tunl0", 0},
>>>>       {"gre0", 0},
>>>>       {"gretap0", ETH_ALEN},
>>>>       {"ip_vti0", 0},
>>>>       {"ip6_vti0", 0},
>>>>       {"ip6tnl0", 0},
>>>>       {"ip6gre0", 0},
>>>>       {"ip6gretap0", ETH_ALEN},
>>>>       {"erspan0", ETH_ALEN},
>>>>       {"bond0", ETH_ALEN},
>>>>       {"veth0", ETH_ALEN},
>>>>       {"veth1", ETH_ALEN},
>>>>       {"team0", ETH_ALEN},
>>>>       {"veth0_to_bridge", ETH_ALEN},
>>>>       {"veth1_to_bridge", ETH_ALEN},
>>>>       {"veth0_to_bond", ETH_ALEN},
>>>>       {"veth1_to_bond", ETH_ALEN},
>>>>       {"veth0_to_team", ETH_ALEN},
>>>>       {"veth1_to_team", ETH_ALEN},
>>>>       {"veth0_to_hsr", ETH_ALEN},
>>>>       {"veth1_to_hsr", ETH_ALEN},
>>>>       {"hsr0", 0},
>>>>       {"dummy0", ETH_ALEN},
>>>>       {"nlmon0", 0},
>>>>       {"vxcan1", 0, true},
>>>>       {"caif0", ETH_ALEN},
>>>>       {"batadv0", ETH_ALEN},
>>>>       {netdevsim, ETH_ALEN},
>>>>   };
>>>>   int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
>>>>   if (sock == -1)
>>>>     exit(1);
>>>>   unsigned i;
>>>>   for (i = 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++)
>>>>     netlink_add_device(sock, devtypes[i].type, devtypes[i].dev);
>>>>   for (i = 0; i < sizeof(devmasters) / (sizeof(devmasters[0])); i++) {
>>>>     char master[32], slave0[32], veth0[32], slave1[32], veth1[32];
>>>>     sprintf(slave0, "%s_slave_0", devmasters[i]);
>>>>     sprintf(veth0, "veth0_to_%s", devmasters[i]);
>>>>     netlink_add_veth(sock, slave0, veth0);
>>>>     sprintf(slave1, "%s_slave_1", devmasters[i]);
>>>>     sprintf(veth1, "veth1_to_%s", devmasters[i]);
>>>>     netlink_add_veth(sock, slave1, veth1);
>>>>     sprintf(master, "%s0", devmasters[i]);
>>>>     netlink_device_change(sock, slave0, false, master, 0, 0);
>>>>     netlink_device_change(sock, slave1, false, master, 0, 0);
>>>>   }
>>>>   netlink_device_change(sock, "bridge_slave_0", true, 0, 0, 0);
>>>>   netlink_device_change(sock, "bridge_slave_1", true, 0, 0, 0);
>>>>   netlink_add_veth(sock, "hsr_slave_0", "veth0_to_hsr");
>>>>   netlink_add_veth(sock, "hsr_slave_1", "veth1_to_hsr");
>>>>   netlink_add_hsr(sock, "hsr0", "hsr_slave_0", "hsr_slave_1");
>>>>   netlink_device_change(sock, "hsr_slave_0", true, 0, 0, 0);
>>>>   netlink_device_change(sock, "hsr_slave_1", true, 0, 0, 0);
>>>>   for (i = 0; i < sizeof(devices) / (sizeof(devices[0])); i++) {
>>>>     char addr[32];
>>>>     sprintf(addr, DEV_IPV4, i + 10);
>>>>     netlink_add_addr4(sock, devices[i].name, addr);
>>>>     if (!devices[i].noipv6) {
>>>>       sprintf(addr, DEV_IPV6, i + 10);
>>>>       netlink_add_addr6(sock, devices[i].name, addr);
>>>>     }
>>>>     uint64_t macaddr = DEV_MAC + ((i + 10ull) << 40);
>>>>     netlink_device_change(sock, devices[i].name, true, 0, &macaddr,
>>>>                           devices[i].macsize);
>>>>   }
>>>>   close(sock);
>>>> }
>>>> static void initialize_netdevices_init(void)
>>>> {
>>>>   int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
>>>>   if (sock == -1)
>>>>     exit(1);
>>>>   struct {
>>>>     const char* type;
>>>>     int macsize;
>>>>     bool noipv6;
>>>>     bool noup;
>>>>   } devtypes[] = {
>>>>       {"nr", 7, true}, {"rose", 5, true, true},
>>>>   };
>>>>   unsigned i;
>>>>   for (i = 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++) {
>>>>     char dev[32], addr[32];
>>>>     sprintf(dev, "%s%d", devtypes[i].type, (int)procid);
>>>>     sprintf(addr, "172.30.%d.%d", i, (int)procid + 1);
>>>>     netlink_add_addr4(sock, dev, addr);
>>>>     if (!devtypes[i].noipv6) {
>>>>       sprintf(addr, "fe88::%02hx:%02hx", i, (int)procid + 1);
>>>>       netlink_add_addr6(sock, dev, addr);
>>>>     }
>>>>     int macsize = devtypes[i].macsize;
>>>>     uint64_t macaddr = 0xbbbbbb +
>>>>                        ((unsigned long long)i << (8 * (macsize - 2))) +
>>>>                        (procid << (8 * (macsize - 1)));
>>>>     netlink_device_change(sock, dev, !devtypes[i].noup, 0, &macaddr,
>>>> macsize);
>>>>   }
>>>>   close(sock);
>>>> }
>>>>
>>>> static void setup_common()
>>>> {
>>>>   if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
>>>>   }
>>>> }
>>>>
>>>> static void loop();
>>>>
>>>> static void sandbox_common()
>>>> {
>>>>   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>>>>   setpgrp();
>>>>   setsid();
>>>>   struct rlimit rlim;
>>>>   rlim.rlim_cur = rlim.rlim_max = 200 << 20;
>>>>   setrlimit(RLIMIT_AS, &rlim);
>>>>   rlim.rlim_cur = rlim.rlim_max = 32 << 20;
>>>>   setrlimit(RLIMIT_MEMLOCK, &rlim);
>>>>   rlim.rlim_cur = rlim.rlim_max = 136 << 20;
>>>>   setrlimit(RLIMIT_FSIZE, &rlim);
>>>>   rlim.rlim_cur = rlim.rlim_max = 1 << 20;
>>>>   setrlimit(RLIMIT_STACK, &rlim);
>>>>   rlim.rlim_cur = rlim.rlim_max = 0;
>>>>   setrlimit(RLIMIT_CORE, &rlim);
>>>>   rlim.rlim_cur = rlim.rlim_max = 256;
>>>>   setrlimit(RLIMIT_NOFILE, &rlim);
>>>>   if (unshare(CLONE_NEWNS)) {
>>>>   }
>>>>   if (unshare(CLONE_NEWIPC)) {
>>>>   }
>>>>   if (unshare(0x02000000)) {
>>>>   }
>>>>   if (unshare(CLONE_NEWUTS)) {
>>>>   }
>>>>   if (unshare(CLONE_SYSVSEM)) {
>>>>   }
>>>>   typedef struct {
>>>>     const char* name;
>>>>     const char* value;
>>>>   } sysctl_t;
>>>>   static const sysctl_t sysctls[] = {
>>>>       {"/proc/sys/kernel/shmmax", "16777216"},
>>>>       {"/proc/sys/kernel/shmall", "536870912"},
>>>>       {"/proc/sys/kernel/shmmni", "1024"},
>>>>       {"/proc/sys/kernel/msgmax", "8192"},
>>>>       {"/proc/sys/kernel/msgmni", "1024"},
>>>>       {"/proc/sys/kernel/msgmnb", "1024"},
>>>>       {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
>>>>   };
>>>>   unsigned i;
>>>>   for (i = 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
>>>>     write_file(sysctls[i].name, sysctls[i].value);
>>>> }
>>>>
>>>> int wait_for_loop(int pid)
>>>> {
>>>>   if (pid < 0)
>>>>     exit(1);
>>>>   int status = 0;
>>>>   while (waitpid(-1, &status, __WALL) != pid) {
>>>>   }
>>>>   return WEXITSTATUS(status);
>>>> }
>>>>
>>>> static int do_sandbox_none(void)
>>>> {
>>>>   if (unshare(CLONE_NEWPID)) {
>>>>   }
>>>>   int pid = fork();
>>>>   if (pid != 0)
>>>>     return wait_for_loop(pid);
>>>>   setup_common();
>>>>   sandbox_common();
>>>>   initialize_netdevices_init();
>>>>   if (unshare(CLONE_NEWNET)) {
>>>>   }
>>>>   initialize_netdevices();
>>>>   loop();
>>>>   exit(1);
>>>> }
>>>>
>>>> #define FS_IOC_SETFLAGS _IOW('f', 2, long)
>>>> static void remove_dir(const char* dir)
>>>> {
>>>>   DIR* dp;
>>>>   struct dirent* ep;
>>>>   int iter = 0;
>>>> retry:
>>>>   while (umount2(dir, MNT_DETACH) == 0) {
>>>>   }
>>>>   dp = opendir(dir);
>>>>   if (dp == NULL) {
>>>>     if (errno == EMFILE) {
>>>>       exit(1);
>>>>     }
>>>>     exit(1);
>>>>   }
>>>>   while ((ep = readdir(dp))) {
>>>>     if (strcmp(ep->d_name, ".") == 0 || strcmp(ep->d_name, "..") == 0)
>>>>       continue;
>>>>     char filename[FILENAME_MAX];
>>>>     snprintf(filename, sizeof(filename), "%s/%s", dir, ep->d_name);
>>>>     while (umount2(filename, MNT_DETACH) == 0) {
>>>>     }
>>>>     struct stat st;
>>>>     if (lstat(filename, &st))
>>>>       exit(1);
>>>>     if (S_ISDIR(st.st_mode)) {
>>>>       remove_dir(filename);
>>>>       continue;
>>>>     }
>>>>     int i;
>>>>     for (i = 0;; i++) {
>>>>       if (unlink(filename) == 0)
>>>>         break;
>>>>       if (errno == EPERM) {
>>>>         int fd = open(filename, O_RDONLY);
>>>>         if (fd != -1) {
>>>>           long flags = 0;
>>>>           if (ioctl(fd, FS_IOC_SETFLAGS, &flags) == 0)
>>>>             close(fd);
>>>>           continue;
>>>>         }
>>>>       }
>>>>       if (errno == EROFS) {
>>>>         break;
>>>>       }
>>>>       if (errno != EBUSY || i > 100)
>>>>         exit(1);
>>>>       if (umount2(filename, MNT_DETACH))
>>>>         exit(1);
>>>>     }
>>>>   }
>>>>   closedir(dp);
>>>>   int i;
>>>>   for (i = 0;; i++) {
>>>>     if (rmdir(dir) == 0)
>>>>       break;
>>>>     if (i < 100) {
>>>>       if (errno == EPERM) {
>>>>         int fd = open(dir, O_RDONLY);
>>>>         if (fd != -1) {
>>>>           long flags = 0;
>>>>           if (ioctl(fd, FS_IOC_SETFLAGS, &flags) == 0)
>>>>             close(fd);
>>>>           continue;
>>>>         }
>>>>       }
>>>>       if (errno == EROFS) {
>>>>         break;
>>>>       }
>>>>       if (errno == EBUSY) {
>>>>         if (umount2(dir, MNT_DETACH))
>>>>           exit(1);
>>>>         continue;
>>>>       }
>>>>       if (errno == ENOTEMPTY) {
>>>>         if (iter < 100) {
>>>>           iter++;
>>>>           goto retry;
>>>>         }
>>>>       }
>>>>     }
>>>>     exit(1);
>>>>   }
>>>> }
>>>>
>>>> static void kill_and_wait(int pid, int* status)
>>>> {
>>>>   kill(-pid, SIGKILL);
>>>>   kill(pid, SIGKILL);
>>>>   int i;
>>>>   for (i = 0; i < 100; i++) {
>>>>     if (waitpid(-1, status, WNOHANG | __WALL) == pid)
>>>>       return;
>>>>     usleep(1000);
>>>>   }
>>>>   DIR* dir = opendir("/sys/fs/fuse/connections");
>>>>   if (dir) {
>>>>     for (;;) {
>>>>       struct dirent* ent = readdir(dir);
>>>>       if (!ent)
>>>>         break;
>>>>       if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
>>>>         continue;
>>>>       char abort[300];
>>>>       snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>>>>                ent->d_name);
>>>>       int fd = open(abort, O_WRONLY);
>>>>       if (fd == -1) {
>>>>         continue;
>>>>       }
>>>>       if (write(fd, abort, 1) < 0) {
>>>>       }
>>>>       close(fd);
>>>>     }
>>>>     closedir(dir);
>>>>   } else {
>>>>   }
>>>>   while (waitpid(-1, status, __WALL) != pid) {
>>>>   }
>>>> }
>>>>
>>>> #define SYZ_HAVE_SETUP_TEST 1
>>>> static void setup_test()
>>>> {
>>>>   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>>>>   setpgrp();
>>>> }
>>>>
>>>> #define SYZ_HAVE_RESET_TEST 1
>>>> static void reset_test()
>>>> {
>>>>   int fd;
>>>>   for (fd = 3; fd < 30; fd++)
>>>>     close(fd);
>>>> }
>>>>
>>>> static void execute_one(void);
>>>>
>>>> #define WAIT_FLAGS __WALL
>>>>
>>>> static void loop(void)
>>>> {
>>>>   int iter;
>>>>   for (iter = 0;; iter++) {
>>>>     char cwdbuf[32];
>>>>     sprintf(cwdbuf, "./%d", iter);
>>>>     if (mkdir(cwdbuf, 0777))
>>>>       exit(1);
>>>>     int pid = fork();
>>>>     if (pid < 0)
>>>>       exit(1);
>>>>     if (pid == 0) {
>>>>       if (chdir(cwdbuf))
>>>>         exit(1);
>>>>       setup_test();
>>>>       execute_one();
>>>>       reset_test();
>>>>       exit(0);
>>>>     }
>>>>     int status = 0;
>>>>     uint64_t start = current_time_ms();
>>>>     for (;;) {
>>>>       if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
>>>>         break;
>>>>       sleep_ms(1);
>>>>       if (current_time_ms() - start < 5 * 1000)
>>>>         continue;
>>>>       kill_and_wait(pid, &status);
>>>>       break;
>>>>     }
>>>>     remove_dir(cwdbuf);
>>>>   }
>>>> }
>>>>
>>>> void execute_one(void)
>>>> {
>>>>   syscall(__NR_unshare, 0x40000000);
>>>> }
>>>> int main(void)
>>>> {
>>>>   syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
>>>>   for (procid = 0; procid < 8; procid++) {
>>>>     if (fork() == 0) {
>>>>       use_temporary_dir();
>>>>       do_sandbox_none();
>>>>     }
>>>>   }
>>>>   sleep(1000000);
>>>>   return 0;
>>>> }
>>>>
>>>>
>>>> I reviewed kernel code and found a bug that
>>>> net_drop_ns func doesn't call net_free func when refcount_dec_and_test's
>>>> return value is zero.
>>> Yes.  We don't call net_free when the reference count does not decrement
>>> to zero.  The reference count is initialized to 1 a few lines above the
>>> section of code in your patch so that should not be a problem.
>>>
>>>> or
>>>> when rv = down_read_killable(&pernet_ops_rwsem) < 0, it doesn't need to
>>>> call refcount_dec_and_test.
>>> It doesn't need to but it should be harmless.
>>>
>>>> https://github.com/torvalds/linux/commit/5ba049a5cc8e24a1643df75bbf65b4efa070fa74#diff-9312644e2968a45510bacdd2b2872ad2
>>>> (I can't reproduce this bug on v4.15 , and
>>>> 1bdbe227492075d058e37cb3d400e6468d0095b5 with my patch. Because of the
>>>> previous version of kernel doesn't have this bug.)
>>>> This bug can lead to memory leak or DOS.
>>>>
>>>> I made a patch for this bug. (just revert to a before commit)
>>> What am I missing?
>>>
>>> The only thing I can see your patch doing is covering up a memory stomp
>>> that has the effect of changing the value of net->passive.  I am not
>>> really keen on hiding bugs of that kind.
>>>
>>>
>>>> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
>>>> index b02fb19df2cc..9de0ade14956 100644
>>>> --- a/net/core/net_namespace.c
>>>> +++ b/net/core/net_namespace.c
>>>> @@ -431,15 +431,18 @@ struct net *copy_net_ns(unsigned long flags,
>>>>         get_user_ns(user_ns);
>>>>
>>>>         rv = down_read_killable(&pernet_ops_rwsem);
>>>> -       if (rv < 0)
>>>> -               goto put_userns;
>>>> +       if (rv < 0){
>>>> +        net_free(net);
>>>> +        dec_net_namespaces(ucounts);
>>>> +        put_user_ns(user_ns);
>>>> +        return ERR_PTR(rv);
>>>> +    }
>>>>
>>>>         rv = setup_net(net, user_ns);
>>>>
>>>>         up_read(&pernet_ops_rwsem);
>>>>
>>>>         if (rv < 0) {
>>>> -put_userns:
>>>>                 put_user_ns(user_ns);
>>>>                 net_drop_ns(net);
>>>>  dec_ucounts:
>>>>
>>>> and, sorry for my encrypted mails.
>>> Eric
>>>
