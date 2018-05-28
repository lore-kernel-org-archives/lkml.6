Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937266AbeE1Ov5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:51:57 -0400
Received: from www62.your-server.de ([213.133.104.62]:35409 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937265AbeE1Ovt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:51:49 -0400
Subject: Re: possible deadlock in bpf_tcp_close
To: syzbot <syzbot+47ed903f50684f046b15@syzkaller.appspotmail.com>,
        ast@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, john.fastabend@gmail.com
References: <000000000000ca8a42056d4530a5@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f206c890-1ed7-59b5-0a9e-eb5db1c51a95@iogearbox.net>
Date: Mon, 28 May 2018 16:51:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <000000000000ca8a42056d4530a5@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +John ]

On 05/28/2018 04:47 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7a1a98c171ea Merge branch 'bpf-sendmsg-hook'
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10fd82d7800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e4078980b886800c
> dashboard link: https://syzkaller.appspot.com/bug?extid=47ed903f50684f046b15
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+47ed903f50684f046b15@syzkaller.appspotmail.com

So this one does have [1] included in the tree. :-( John, can you take a look?

  [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=c1659ee5bb2a9f2023f5065256d5fd742ed660d2

Thanks,
Daniel

> ======================================================
> WARNING: possible circular locking dependency detected
> 4.17.0-rc6+ #25 Not tainted
> ------------------------------------------------------
> syz-executor4/7489 is trying to acquire lock:
>         (ptrval) (&htab->buckets[i].lock#2){+...}, at: bpf_tcp_close+0x822/0x10b0 kernel/bpf/sockmap.c:285
> 
> but task is already holding lock:
>         (ptrval) (clock-AF_INET6){++..}, at: bpf_tcp_close+0x241/0x10b0 kernel/bpf/sockmap.c:260
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (clock-AF_INET6){++..}:
>        __raw_write_lock_bh include/linux/rwlock_api_smp.h:203 [inline]
>        _raw_write_lock_bh+0x31/0x40 kernel/locking/spinlock.c:312
>        sock_hash_delete_elem+0x7c6/0xaf0 kernel/bpf/sockmap.c:2338
>        map_delete_elem+0x32e/0x4e0 kernel/bpf/syscall.c:815
>        __do_sys_bpf kernel/bpf/syscall.c:2349 [inline]
>        __se_sys_bpf kernel/bpf/syscall.c:2317 [inline]
>        __x64_sys_bpf+0x342/0x510 kernel/bpf/syscall.c:2317
>        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> -> #0 (&htab->buckets[i].lock#2){+...}:
>        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
>        __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
>        _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
>        bpf_tcp_close+0x822/0x10b0 kernel/bpf/sockmap.c:285
>        inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
>        inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
>        sock_release+0x96/0x1b0 net/socket.c:594
>        sock_close+0x16/0x20 net/socket.c:1149
>        __fput+0x34d/0x890 fs/file_table.c:209
>        ____fput+0x15/0x20 fs/file_table.c:243
>        task_work_run+0x1e4/0x290 kernel/task_work.c:113
>        exit_task_work include/linux/task_work.h:22 [inline]
>        do_exit+0x1aee/0x2730 kernel/exit.c:865
>        do_group_exit+0x16f/0x430 kernel/exit.c:968
>        get_signal+0x886/0x1960 kernel/signal.c:2482
>        do_signal+0x98/0x2040 arch/x86/kernel/signal.c:810
>        exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
>        prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>        syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>        do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(clock-AF_INET6);
>                                lock(&htab->buckets[i].lock#2);
>                                lock(clock-AF_INET6);
>   lock(&htab->buckets[i].lock#2);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by syz-executor4/7489:
>  #0:         (ptrval) (rcu_read_lock){....}, at: bpf_tcp_close+0x0/0x10b0 kernel/bpf/sockmap.c:2106
>  #1:         (ptrval) (clock-AF_INET6){++..}, at: bpf_tcp_close+0x241/0x10b0 kernel/bpf/sockmap.c:260
> 
> stack backtrace:
> CPU: 1 PID: 7489 Comm: syz-executor4 Not tainted 4.17.0-rc6+ #25
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_circular_bug.isra.36.cold.54+0x1bd/0x27d kernel/locking/lockdep.c:1223
>  check_prev_add kernel/locking/lockdep.c:1863 [inline]
>  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
>  validate_chain kernel/locking/lockdep.c:2417 [inline]
>  __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3431
>  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
>  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
>  _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
>  bpf_tcp_close+0x822/0x10b0 kernel/bpf/sockmap.c:285
>  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
>  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
>  sock_release+0x96/0x1b0 net/socket.c:594
>  sock_close+0x16/0x20 net/socket.c:1149
>  __fput+0x34d/0x890 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x1e4/0x290 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x1aee/0x2730 kernel/exit.c:865
>  do_group_exit+0x16f/0x430 kernel/exit.c:968
>  get_signal+0x886/0x1960 kernel/signal.c:2482
>  do_signal+0x98/0x2040 arch/x86/kernel/signal.c:810
>  exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455a09
> RSP: 002b:00007f95715e8ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 000000000072c028 RCX: 0000000000455a09
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072c028
> RBP: 000000000072c028 R08: 0000000000000000 R09: 000000000072c000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fffdce9240f R14: 00007f95715e99c0 R15: 0000000000000002
> cgroup: cgroup2: unknown option "cgroup2"
> cgroup: cgroup2: unknown option "cgroup2"
> syz-executor4 uses obsolete (PF_INET,SOCK_PACKET)
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 1
> CPU: 0 PID: 7912 Comm: syz-executor0 Not tainted 4.17.0-rc6+ #25
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  __should_failslab+0x124/0x180 mm/failslab.c:32
>  should_failslab+0x9/0x14 mm/slab_common.c:1522
>  slab_pre_alloc_hook mm/slab.h:423 [inline]
>  slab_alloc_node mm/slab.c:3299 [inline]
>  kmem_cache_alloc_node+0x272/0x780 mm/slab.c:3642
>  __alloc_skb+0x111/0x780 net/core/skbuff.c:193
>  alloc_skb include/linux/skbuff.h:989 [inline]
>  alloc_skb_with_frags+0x137/0x760 net/core/skbuff.c:5266
>  sock_alloc_send_pskb+0x87a/0xae0 net/core/sock.c:2095
>  unix_dgram_sendmsg+0x4f9/0x1730 net/unix/af_unix.c:1672
>  unix_seqpacket_sendmsg+0x115/0x18f net/unix/af_unix.c:2053
>  sock_sendmsg_nosec net/socket.c:629 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:639
>  ___sys_sendmsg+0x805/0x940 net/socket.c:2117
>  __sys_sendmsg+0x115/0x270 net/socket.c:2155
>  __do_sys_sendmsg net/socket.c:2164 [inline]
>  __se_sys_sendmsg net/socket.c:2162 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2162
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455a09
> RSP: 002b:00007f85737fdc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f85737fe6d4 RCX: 0000000000455a09
> RDX: 0000000000000000 RSI: 00000000200013c0 RDI: 0000000000000013
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000015
> R13: 000000000000057f R14: 00000000006fc488 R15: 0000000000000000
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 1 PID: 7947 Comm: syz-executor0 Not tainted 4.17.0-rc6+ #25
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  __should_failslab+0x124/0x180 mm/failslab.c:32
>  should_failslab+0x9/0x14 mm/slab_common.c:1522
>  slab_pre_alloc_hook mm/slab.h:423 [inline]
>  slab_alloc_node mm/slab.c:3299 [inline]
>  kmem_cache_alloc_node_trace+0x26f/0x770 mm/slab.c:3661
>  __do_kmalloc_node mm/slab.c:3681 [inline]
>  __kmalloc_node_track_caller+0x33/0x70 mm/slab.c:3696
>  __kmalloc_reserve.isra.39+0x3a/0xe0 net/core/skbuff.c:137
>  __alloc_skb+0x14d/0x780 net/core/skbuff.c:205
>  alloc_skb include/linux/skbuff.h:989 [inline]
>  alloc_skb_with_frags+0x137/0x760 net/core/skbuff.c:5266
>  sock_alloc_send_pskb+0x87a/0xae0 net/core/sock.c:2095
>  unix_dgram_sendmsg+0x4f9/0x1730 net/unix/af_unix.c:1672
>  unix_seqpacket_sendmsg+0x115/0x18f net/unix/af_unix.c:2053
>  sock_sendmsg_nosec net/socket.c:629 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:639
>  ___sys_sendmsg+0x805/0x940 net/socket.c:2117
>  __sys_sendmsg+0x115/0x270 net/socket.c:2155
>  __do_sys_sendmsg net/socket.c:2164 [inline]
>  __se_sys_sendmsg net/socket.c:2162 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2162
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455a09
> RSP: 002b:00007f85737fdc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f85737fe6d4 RCX: 0000000000455a09
> RDX: 0000000000000000 RSI: 00000000200013c0 RDI: 0000000000000013
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000015
> R13: 000000000000057f R14: 00000000006fc488 R15: 0000000000000001
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 1 PID: 8051 Comm: syz-executor1 Not tainted 4.17.0-rc6+ #25
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  __should_failslab+0x124/0x180 mm/failslab.c:32
>  should_failslab+0x9/0x14 mm/slab_common.c:1522
>  slab_pre_alloc_hook mm/slab.h:423 [inline]
>  slab_alloc mm/slab.c:3378 [inline]
>  __do_kmalloc mm/slab.c:3716 [inline]
>  __kmalloc+0x2c8/0x760 mm/slab.c:3727
>  kmalloc include/linux/slab.h:517 [inline]
>  map_get_next_key+0x24a/0x640 kernel/bpf/syscall.c:863
>  __do_sys_bpf kernel/bpf/syscall.c:2352 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:2317 [inline]
>  __x64_sys_bpf+0x357/0x510 kernel/bpf/syscall.c:2317
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455a09
> RSP: 002b:00007fbd35c1ac68 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007fbd35c1b6d4 RCX: 0000000000455a09
> RDX: 000000000000002c RSI: 0000000020003000 RDI: 0000000000000004
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000014
> R13: 000000000000003d R14: 00000000006f4658 R15: 0000000000000000
> FAULT_INJECTION: forcing a failure.
> name fail_page_alloc, interval 1, probability 0, space 0, times 1
> CPU: 1 PID: 8104 Comm: syz-executor1 Not tainted 4.17.0-rc6+ #25
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  should_fail_alloc_page mm/page_alloc.c:3060 [inline]
>  prepare_alloc_pages mm/page_alloc.c:4319 [inline]
>  __alloc_pages_nodemask+0x34e/0xd70 mm/page_alloc.c:4358
>  alloc_pages_vma+0xdd/0x540 mm/mempolicy.c:2057
>  wp_page_copy+0x24c/0x1440 mm/memory.c:2490
>  do_wp_page+0x425/0x1990 mm/memory.c:2776
>  handle_pte_fault mm/memory.c:3979 [inline]
>  __handle_mm_fault+0x2996/0x4310 mm/memory.c:4087
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
