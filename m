Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeE0WQx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 18:16:53 -0400
Received: from www62.your-server.de ([213.133.104.62]:47792 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbeE0WQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 18:16:47 -0400
Subject: Re: KASAN: use-after-free Read in bpf_tcp_close
To: syzbot <syzbot+fce8f2462c403d02af98@syzkaller.appspotmail.com>,
        ast@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, john.fastabend@gmail.com
References: <000000000000ac9069056d1806c4@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cf1ce0ba-e4aa-8fde-e136-2cbb740b5bc3@iogearbox.net>
Date: Mon, 28 May 2018 00:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <000000000000ac9069056d1806c4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +John ]

On 05/26/2018 10:54 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    3fb48d881dbe Merge branch 'bpf-fib-mtu-check'
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15fc1977800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b632d8e2c2ab2c1
> dashboard link: https://syzkaller.appspot.com/bug?extid=fce8f2462c403d02af98
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1310c857800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17de7177800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+fce8f2462c403d02af98@syzkaller.appspotmail.com

Should be fixed by: https://patchwork.ozlabs.org/patch/920695/

> ==================================================================
> BUG: KASAN: use-after-free in hlist_del_rcu include/linux/rculist.h:427 [inline]
> BUG: KASAN: use-after-free in bpf_tcp_close+0xd7f/0xf80 kernel/bpf/sockmap.c:271
> Read of size 8 at addr ffff8801c884cf90 by task syz-executor330/11778
> 
> CPU: 1 PID: 11778 Comm: syz-executor330 Not tainted 4.17.0-rc4+ #18
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  hlist_del_rcu include/linux/rculist.h:427 [inline]
>  bpf_tcp_close+0xd7f/0xf80 kernel/bpf/sockmap.c:271
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
>  get_signal+0x886/0x1960 kernel/signal.c:2469
>  do_signal+0x98/0x2040 arch/x86/kernel/signal.c:810
>  exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x445ed9
> RSP: 002b:00007f0078c0adb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00000000006dbc24 RCX: 0000000000445ed9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000006dbc24
> RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffcd147dbef R14: 00007f0078c0b9c0 R15: 0000000000000007
> 
> Allocated by task 11787:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  __do_kmalloc_node mm/slab.c:3682 [inline]
>  __kmalloc_node+0x47/0x70 mm/slab.c:3689
>  kmalloc_node include/linux/slab.h:554 [inline]
>  alloc_sock_hash_elem kernel/bpf/sockmap.c:2114 [inline]
>  sock_hash_ctx_update_elem.isra.23+0xa57/0x1560 kernel/bpf/sockmap.c:2245
>  sock_hash_update_elem+0x14f/0x2d0 kernel/bpf/sockmap.c:2303
>  map_update_elem+0x5c4/0xc90 kernel/bpf/syscall.c:760
>  __do_sys_bpf kernel/bpf/syscall.c:2134 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:2105 [inline]
>  __x64_sys_bpf+0x32a/0x4f0 kernel/bpf/syscall.c:2105
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 8998:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3813
>  sock_hash_free+0x24e/0x6e0 kernel/bpf/sockmap.c:2093
>  bpf_map_free_deferred+0xba/0xf0 kernel/bpf/syscall.c:259
>  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
>  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
>  kthread+0x345/0x410 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> 
> The buggy address belongs to the object at ffff8801c884cf80
>  which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 16 bytes inside of
>  64-byte region [ffff8801c884cf80, ffff8801c884cfc0)
> The buggy address belongs to the page:
> page:ffffea0007221300 count:1 mapcount:0 mapping:ffff8801c884c000 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801c884c000 0000000000000000 0000000100000020
> raw: ffffea00072e08e0 ffffea0006e99660 ffff8801da800340 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801c884ce80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff8801c884cf00: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>> ffff8801c884cf80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>                          ^
>  ffff8801c884d000: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>  ffff8801c884d080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
