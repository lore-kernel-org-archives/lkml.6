Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbeDYOoX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:44:23 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:60155 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754473AbeDYOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:44:20 -0400
To: "Theodore Ts'o" <tytso@mit.edu>, Shuah Khan <shuah@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
From: Shuah Khan <shuah@kernel.org>
Subject: Linux 4.17.0-rc2 - WARNING: inconsistent lock state
Message-ID: <2f2bd4d8-f143-913f-af5c-2767d4e35149@kernel.org>
Date: Wed, 25 Apr 2018 08:44:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing the following on my system with 4.17-rc2. Probably in 4.17-rc1
as well.

Something to be concerned about. Is this related to
Commit: a45403b51582a87872927a3e0fc0a389c26867f1
ext4: always initialize the crc32c checksum driver?

================================
WARNING: inconsistent lock state
4.17.0-rc2+ #3 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
apparmor_parser/836 [HC1[1]:SC0[0]:HE0:SE1] takes:
        (ptrval) (fs_reclaim){?.+.}, at: fs_reclaim_acquire.part.75+0x5/0x30
{HARDIRQ-ON-W} state was registered at:
  fs_reclaim_acquire.part.75+0x29/0x30
  kmem_cache_alloc_node_trace+0x39/0x2d0
  alloc_worker+0x2d/0xa0
  init_rescuer.part.25+0x1c/0xe0
  workqueue_init+0x26f/0x39a
  kernel_init_freeable+0x153/0x33b
  kernel_init+0xf/0x120
  ret_from_fork+0x3a/0x50
irq event stamp: 15968
hardirqs last  enabled at (15967): [<ffffffff8113bd9c>] __raw_spin_lock_init+0x1c/0x70
hardirqs last disabled at (15968): [<ffffffff82000951>] interrupt_entry+0xc1/0xf0
softirqs last  enabled at (15952): [<ffffffff82200436>] __do_softirq+0x436/0x560
softirqs last disabled at (15933): [<ffffffff810a98d4>] irq_exit+0x104/0x110

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(fs_reclaim);
  <Interrupt>
    lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by apparmor_parser/836:
 #0:         (ptrval) (&mm->mmap_sem){++++}, at: copy_process.part.46+0x1867/0x3460
 #1:         (ptrval) (&mm->mmap_sem/1){+.+.}, at: copy_process.part.46+0x1891/0x3460
 #2:         (ptrval) (&mapping->i_mmap_rwsem){+.+.}, at: copy_process.part.46+0x1ba5/0x3460

stack backtrace:
CPU: 3 PID: 836 Comm: apparmor_parser Not tainted 4.17.0-rc2+ #3
Hardware name: System76, Inc. Wild Dog Performance/H87-PLUS, BIOS 0705 12/05/2013
Call Trace:
 <IRQ>
 dump_stack+0x7c/0xbb
 print_usage_bug+0x24c/0x266
 mark_lock+0x717/0x7c0
 ? check_usage_backwards+0x230/0x230
 __lock_acquire+0x1252/0x1e70
 ? debug_check_no_locks_freed+0x190/0x190
 ? debug_check_no_locks_freed+0x190/0x190
 ? memzero_explicit+0xa/0x10
 ? extract_buf+0x1b1/0x220
 ? trace_event_raw_event_credit_entropy_bits+0x1c0/0x1c0
 ? _raw_spin_unlock_irqrestore+0x3e/0x50
 ? __wake_up_common_lock+0xd7/0x130
 ? match_held_lock+0x1b/0x210
 ? lock_acquire+0xcd/0x220
 lock_acquire+0xcd/0x220
 ? fs_reclaim_acquire.part.75+0x5/0x30
 fs_reclaim_acquire.part.75+0x29/0x30
 ? fs_reclaim_acquire.part.75+0x5/0x30
 __kmalloc+0x52/0x2f0
 ? crng_reseed+0x229/0x460
 crng_reseed+0x229/0x460
 ? init_std_data+0x1c0/0x1c0
 ? check_chain_key+0x139/0x1f0
 ? add_interrupt_randomness+0x27d/0x340
 credit_entropy_bits+0x3db/0x3f0
 add_interrupt_randomness+0x27d/0x340
 ? extract_entropy.constprop.41+0x1b0/0x1b0
 ? rcu_read_lock_sched_held+0x7c/0x80
 ? __handle_irq_event_percpu+0xf9/0x3c0
 handle_irq_event_percpu+0x8b/0xe0
 ? __handle_irq_event_percpu+0x3c0/0x3c0
 ? lock_acquire+0xcd/0x220
 ? handle_edge_irq+0x28/0x2c0
 ? do_raw_spin_unlock+0xa2/0x130
 handle_irq_event+0x5a/0x90
 handle_edge_irq+0xef/0x2c0
 handle_irq+0x32/0x40
 do_IRQ+0x60/0x130
 common_interrupt+0xf/0xf
 </IRQ>
RIP: 0010:__rb_insert_augmented+0x2/0x420
RSP: 0018:ffff8803378cfc28 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffde
RAX: 0000000000000000 RBX: ffff88033b1e0600 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff880332eca4f0 RDI: ffff88033794b958
RBP: ffff8803378cfe18 R08: ffffffff812d95f0 R09: 0000000000000000
R10: ffff8803378cfba8 R11: fffffbfff07fdc69 R12: ffff88033794b900
R13: ffff880332eca498 R14: ffff88033794b950 R15: ffff880332eca500
 ? vmacache_find+0x110/0x110
 copy_process.part.46+0x1bd7/0x3460
 ? __cleanup_sighand+0x40/0x40
 ? __wake_up_parent+0x40/0x40
 _do_fork+0x17f/0x8c0
 ? fork_idle+0x140/0x140
 ? mark_held_locks+0x1c/0x90
 ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
 ? mark_held_locks+0x1c/0x90
 ? do_syscall_64+0x14/0x210
 do_syscall_64+0x68/0x210
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7ff45afbbd0b
RSP: 002b:00007fffa50027d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007fffa50027d0 RCX: 00007ff45afbbd0b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007fffa5002830 R08: 00007ff45b6e5740 R09: 0000000000000010
R10: 00007ff45b6e5a10 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000020 R14: 0000000000000000 R15: 0000000000000000
new mount options do not match the existing superblock, will be ignored
kauditd_printk_skb: 94 callbacks suppressed


thanks,
-- Shuah
