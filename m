Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE65C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADF1208E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADF1208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756672AbeFOVnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:43:01 -0400
Received: from www62.your-server.de ([213.133.104.62]:38444 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753688AbeFOVm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:42:56 -0400
Received: from [178.197.249.15] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fTwUg-0000iU-US; Fri, 15 Jun 2018 23:42:55 +0200
Subject: Re: KASAN: use-after-free Write in free_htab_elem
To:     syzbot <syzbot+ce67d3e4fa77eedee964@syzkaller.appspotmail.com>,
        ast@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        john.fastabend@gmail.com
References: <000000000000394fd9056eb28b51@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <841dce9f-1130-4a39-7cd5-4ef8f374c131@iogearbox.net>
Date:   Fri, 15 Jun 2018 23:42:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <000000000000394fd9056eb28b51@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24666/Fri Jun 15 22:38:25 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/15/2018 08:40 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11dad428400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9c20c48788d1c1
> dashboard link: https://syzkaller.appspot.com/bug?extid=ce67d3e4fa77eedee964
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ce67d3e4fa77eedee964@syzkaller.appspotmail.com

(John, if you do the respin would be great to double check all the open
reports on sock{map,hash} and annotate with syzkaller Reported-by tags.
Looks like on https://syzkaller.appspot.com/ we have 5 in total that may
be all related to your series of fixes you have. 2 of the reports have
wrong syz-fix tag, though, so we should clarify tracking them a bit. Thx)

> ==================================================================
> BUG: KASAN: use-after-free in atomic_dec include/asm-generic/atomic-instrumented.h:114 [inline]
> BUG: KASAN: use-after-free in free_htab_elem+0x23/0x40 kernel/bpf/sockmap.c:224
> Write of size 4 at addr ffff8801b3dce648 by task syz-executor1/8114
> 
> CPU: 0 PID: 8114 Comm: syz-executor1 Not tainted 4.17.0+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
>  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
>  atomic_dec include/asm-generic/atomic-instrumented.h:114 [inline]
>  free_htab_elem+0x23/0x40 kernel/bpf/sockmap.c:224
>  bpf_tcp_close+0x8c1/0xf80 kernel/bpf/sockmap.c:273
>  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
>  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
>  __sock_release+0xd7/0x260 net/socket.c:603
>  sock_close+0x19/0x20 net/socket.c:1186
>  __fput+0x353/0x890 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x1e4/0x290 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x1aee/0x2730 kernel/exit.c:865
>  do_group_exit+0x16f/0x430 kernel/exit.c:968
>  get_signal+0x886/0x1960 kernel/signal.c:2468
>  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
>  exit_to_usermode_loop+0x2cf/0x360 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455b29
> Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f3bbf323ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 000000000072bf78 RCX: 0000000000455b29
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072bf78
> RBP: 000000000072bf78 R08: 0000000000000000 R09: 000000000072bf50
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd7addc2cf R14: 00007f3bbf3249c0 R15: 0000000000000001
> 
> Allocated by task 8104:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
>  kmalloc include/linux/slab.h:513 [inline]
>  kzalloc include/linux/slab.h:706 [inline]
>  sock_hash_alloc+0x20d/0x6a0 kernel/bpf/sockmap.c:2003
>  find_and_alloc_map kernel/bpf/syscall.c:129 [inline]
>  map_create+0x393/0x1010 kernel/bpf/syscall.c:453
>  __do_sys_bpf kernel/bpf/syscall.c:2351 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:2328 [inline]
>  __x64_sys_bpf+0x303/0x510 kernel/bpf/syscall.c:2328
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 2131:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3813
>  sock_hash_free+0x51c/0x6e0 kernel/bpf/sockmap.c:2098
>  bpf_map_free_deferred+0xba/0xf0 kernel/bpf/syscall.c:262
>  process_one_work+0xc64/0x1b70 kernel/workqueue.c:2153
>  worker_thread+0x181/0x13a0 kernel/workqueue.c:2296
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> 
> The buggy address belongs to the object at ffff8801b3dce540
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 264 bytes inside of
>  512-byte region [ffff8801b3dce540, ffff8801b3dce740)
> The buggy address belongs to the page:
> page:ffffea0006cf7380 count:1 mapcount:0 mapping:ffff8801da800940 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea0006caccc8 ffffea0006f57b08 ffff8801da800940
> raw: 0000000000000000 ffff8801b3dce040 0000000100000006 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801b3dce500: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>  ffff8801b3dce580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff8801b3dce600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                               ^
>  ffff8801b3dce680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801b3dce700: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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

