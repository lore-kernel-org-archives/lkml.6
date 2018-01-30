Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbeA3WD6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:03:58 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:39603 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeA3WD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:03:56 -0500
X-Google-Smtp-Source: AH8x224vBXKJxF3AyFSebDHNOL5qRHJC7aSHPPjk8ODMEz/KyUs5n6wLLORaLJxuL9KjSSluRjUJLw==
Date: Tue, 30 Jan 2018 14:03:53 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+114f9d8dc954cefaa1a08dc1718eec743d46fdc0@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 ipv6_get_lladdr
Message-ID: <20180130220353.udvfgfo7y7vbdfuz@gmail.com>
References: <001a1145ac5412fe450560b417d0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a1145ac5412fe450560b417d0@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2017 at 08:38:01AM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 6084b576dca2e898f5c101baef151f7bfdbb606d
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> 
> Unfortunately, I don't have any reproducer for this bug yet.
> 
> 
> device lo entered promiscuous mode
> device lo left promiscuous mode
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000328
> IP: __read_once_size include/linux/compiler.h:183 [inline]
> IP: __in6_dev_get include/net/addrconf.h:300 [inline]
> IP: ipv6_get_lladdr+0x6f/0x270 net/ipv6/addrconf.c:1813
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 1 PID: 16588 Comm: syz-executor1 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:183 [inline]
> RIP: 0010:__in6_dev_get include/net/addrconf.h:300 [inline]
> RIP: 0010:ipv6_get_lladdr+0x6f/0x270 net/ipv6/addrconf.c:1813
> RSP: 0018:ffff88021fd03da8 EFLAGS: 00010206
> RAX: ffff8801fcb0a280 RBX: 0000000000000000 RCX: ffffffff8225359f
> RDX: 0000000000000100 RSI: 00000000aa440f11 RDI: 0000000000000286
> RBP: ffff88021fd03de0 R08: 0000000000000001 R09: 0000000000000002
> R10: ffff88021fd03d30 R11: 0000000000000002 R12: ffff8802156f2000
> R13: 0000000000000040 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88021fd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000328 CR3: 000000000301e002 CR4: 00000000001606e0
> Call Trace:
>  <IRQ>
>  addrconf_rs_timer+0x128/0x230 net/ipv6/addrconf.c:3762
>  call_timer_fn+0x9f/0x3f0 kernel/time/timer.c:1320
>  expire_timers kernel/time/timer.c:1357 [inline]
>  __run_timers kernel/time/timer.c:1660 [inline]
>  run_timer_softirq+0x68a/0x830 kernel/time/timer.c:1686
>  __do_softirq+0xcb/0x4f3 kernel/softirq.c:285
>  invoke_softirq kernel/softirq.c:365 [inline]
>  irq_exit+0xd4/0xe0 kernel/softirq.c:405
>  exiting_irq arch/x86/include/asm/apic.h:540 [inline]
>  smp_apic_timer_interrupt+0x8e/0x2a0 arch/x86/kernel/apic/apic.c:1052
>  apic_timer_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:920
>  </IRQ>
> RIP: 0010:lock_acquire+0x21/0x220 kernel/locking/lockdep.c:3906
> RSP: 0018:ffffc90000ee79f8 EFLAGS: 00000292 ORIG_RAX: ffffffffffffff11
> RAX: ffff8801fcb0a280 RBX: ffffea00084e2340 RCX: 0000000000000002
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff83080740
> RBP: ffffc90000ee7a38 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: ffff8801fcb0a280 R12: ffffea00084e2340
> R13: ffffea00084e2340 R14: 0000000000000000 R15: 0000000000000000
>  rcu_lock_acquire include/linux/rcupdate.h:244 [inline]
>  rcu_read_lock include/linux/rcupdate.h:630 [inline]
>  lock_page_memcg+0x33/0xf0 mm/memcontrol.c:1620
>  page_remove_file_rmap mm/rmap.c:1213 [inline]
>  page_remove_rmap+0x12e/0x4b0 mm/rmap.c:1298
>  zap_pte_range mm/memory.c:1337 [inline]
>  zap_pmd_range mm/memory.c:1441 [inline]
>  zap_pud_range mm/memory.c:1470 [inline]
>  zap_p4d_range mm/memory.c:1491 [inline]
>  unmap_page_range+0x86f/0xed0 mm/memory.c:1512
>  unmap_single_vma+0xbb/0x140 mm/memory.c:1557
>  unmap_vmas+0x65/0xd0 mm/memory.c:1587
>  exit_mmap+0xb0/0x1e0 mm/mmap.c:3020
>  __mmput kernel/fork.c:966 [inline]
>  mmput+0x82/0x190 kernel/fork.c:987
>  exit_mm kernel/exit.c:544 [inline]
>  do_exit+0x356/0x1050 kernel/exit.c:856
>  do_group_exit+0x60/0x100 kernel/exit.c:972
>  get_signal+0x36c/0xad0 kernel/signal.c:2337
>  do_signal+0x23/0x670 arch/x86/kernel/signal.c:809
>  exit_to_usermode_loop+0x13c/0x160 arch/x86/entry/common.c:161
>  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
>  syscall_return_slowpath+0x1b4/0x1e0 arch/x86/entry/common.c:264
>  entry_SYSCALL_64_fastpath+0x94/0x96
> RIP: 0033:0x452a09
> RSP: 002b:00007f96787f3ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 000000000071c0f0 RCX: 0000000000452a09
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000071c0f0
> RBP: 000000000071c0f0 R08: 0000000000000422 R09: 000000000071c0c8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000a2f7ff R14: 00007f96787f49c0 R15: 0000000000000006
> Code: c7 40 07 08 83 e8 b2 2e fd fe e8 3d 9e ff fe 85 c0 5a 74 12 e8 b3 6d
> 06 ff 80 3d 73 10 f6 00 00 0f 84 7a 01 00 00 e8 a1 6d 06 ff <4c> 8b a3 28 03
> 00 00 e8 15 9e ff fe 85 c0 74 12 e8 8c 6d 06 ff
> RIP: __read_once_size include/linux/compiler.h:183 [inline] RSP:
> ffff88021fd03da8
> RIP: __in6_dev_get include/net/addrconf.h:300 [inline] RSP: ffff88021fd03da8
> RIP: ipv6_get_lladdr+0x6f/0x270 net/ipv6/addrconf.c:1813 RSP:
> ffff88021fd03da8
> CR2: 0000000000000328
> ---[ end trace cc2639f5bc6e4363 ]---

Invalidating this bug since it hasn't been seen again, and it was reported while
KASAN was accidentally disabled in the syzbot kconfig due to a change to the
kconfig menus in linux-next (so this crash was possibly caused by slab
corruption elsewhere).

#syz invalid
