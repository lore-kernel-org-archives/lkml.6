Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeAaGjN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 01:39:13 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35518 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeAaGjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 01:39:11 -0500
X-Google-Smtp-Source: AH8x225NmC6TNuLnGkKQAkn9eYBMUl7U0jCuzDRDGqN85kAjzNDTc064Opx4Kxb7RDDkZOpvFYtijg==
Date: Tue, 30 Jan 2018 22:39:08 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+d9b83ca6cd9450add704@syzkaller.appspotmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in map_lookup_elem
Message-ID: <20180131063908.GD2736@zzz.localdomain>
References: <001a1140f8d6536b7005629c3264@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a1140f8d6536b7005629c3264@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2018 at 02:58:02PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 4147d50978df60f34d444c647dde9e5b34a4315e
> git://git.cmpxchg.org/linux-mmots.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d9b83ca6cd9450add704@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> audit: type=1400 audit(1515719240.359:8): avc:  denied  { sys_admin } for
> pid=3510 comm="syzkaller886548" capability=21
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 tclass=cap_userns
> permissive=1
> audit: type=1400 audit(1515719240.417:9): avc:  denied  { sys_chroot } for
> pid=3511 comm="syzkaller886548" capability=18
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 tclass=cap_userns
> permissive=1
> ==================================================================
> BUG: KASAN: use-after-free in memcpy include/linux/string.h:344 [inline]
> BUG: KASAN: use-after-free in map_lookup_elem+0x4dc/0xbd0
> kernel/bpf/syscall.c:584
> Read of size 4 at addr ffff8801bf5a9858 by task syzkaller886548/3511
> 
> CPU: 0 PID: 3511 Comm: syzkaller886548 Not tainted 4.15.0-rc7-mm1+ #53
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report+0x23b/0x360 mm/kasan/report.c:412
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>  check_memory_region+0x137/0x190 mm/kasan/kasan.c:267
>  memcpy+0x23/0x50 mm/kasan/kasan.c:302
>  memcpy include/linux/string.h:344 [inline]
>  map_lookup_elem+0x4dc/0xbd0 kernel/bpf/syscall.c:584
>  SYSC_bpf kernel/bpf/syscall.c:1808 [inline]
>  SyS_bpf+0x922/0x4400 kernel/bpf/syscall.c:1782
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> RIP: 0033:0x440ab9
> RSP: 002b:00000000007dff68 EFLAGS: 00000203 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 0000000000440ab9
> RDX: 0000000000000018 RSI: 0000000020c3c000 RDI: 0000000000000001
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000203 R12: 0000000000402290
> R13: 0000000000402320 R14: 0000000000000000 R15: 0000000000000000
> 
> Allocated by task 3510:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
>  kmem_cache_alloc_trace+0x136/0x750 mm/slab.c:3607
>  kmalloc include/linux/slab.h:515 [inline]
>  kzalloc include/linux/slab.h:704 [inline]
>  do_execveat_common.isra.30+0x3ea/0x22a0 fs/exec.c:1730
>  do_execve fs/exec.c:1848 [inline]
>  SYSC_execve fs/exec.c:1929 [inline]
>  SyS_execve+0x39/0x50 fs/exec.c:1924
>  do_syscall_64+0x273/0x920 arch/x86/entry/common.c:285
>  return_from_SYSCALL_64+0x0/0x75
> 
> Freed by task 3510:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
>  __cache_free mm/slab.c:3485 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3800
>  free_bprm+0x19d/0x200 fs/exec.c:1415
>  do_execveat_common.isra.30+0x19e1/0x22a0 fs/exec.c:1813
>  do_execve fs/exec.c:1848 [inline]
>  SYSC_execve fs/exec.c:1929 [inline]
>  SyS_execve+0x39/0x50 fs/exec.c:1924
>  do_syscall_64+0x273/0x920 arch/x86/entry/common.c:285
>  return_from_SYSCALL_64+0x0/0x75
> 
> The buggy address belongs to the object at ffff8801bf5a97c0
>  which belongs to the cache kmalloc-256 of size 256
> The buggy address is located 152 bytes inside of
>  256-byte region [ffff8801bf5a97c0, ffff8801bf5a98c0)
> The buggy address belongs to the page:
> page:ffffea0006fd6a40 count:1 mapcount:0 mapping:ffff8801bf5a9040 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801bf5a9040 0000000000000000 000000010000000c
> raw: ffffea0006fd6920 ffffea0006fdc520 ffff8801dac007c0 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801bf5a9700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8801bf5a9780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> > ffff8801bf5a9800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                     ^
>  ffff8801bf5a9880: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff8801bf5a9900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:

#syz fix: bpf, array: fix overflow in max_entries and undefined behavior in index_mask
