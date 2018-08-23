Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C934C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DF82156B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1FlOF6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DF82156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeHXAbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:31:39 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46311 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeHXAbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:31:39 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so11681228oie.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 14:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cF2Ly316zzITjLnK5Zf+gP6V2fxlOJ5GIjT29Mw8pxw=;
        b=Q1FlOF6qIfUITlhI4XJ7URss01tT3ka9IOg3h01nI0nHhuTA7hArsZTEiAH5M7vcyu
         1nE97hbHlMrZ+dJ6HXbfKHh9cn+KLEYf7xO3qrLfUMXwP3oVw2KGrhDRtACubUYti39i
         Ty3JnMHLtRJul+Nxbt3RVSAr68P40GuD+xNAUfcbNCrs7ZEBe7njaAhsNmgCaYs36MYM
         2uMWHUV2fzFxdwyaH4AKgmJ6wFBHdA7ynNw/ugUHGQ2jfawZwSoOf3GjgFUJuZ5wIZKG
         LSGGN1mkcRE/pfMVppG4TS2enQGQPujCzUHJ70t/hdAbquqIDbEnxEbg5gHDOric9a5c
         Ib5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cF2Ly316zzITjLnK5Zf+gP6V2fxlOJ5GIjT29Mw8pxw=;
        b=iY2PreZgePI4tcStUvHuqfIbSBMh7RdLuftpMoZZEXR38eRz9o/Q1DRFYPhD8Gm0+/
         GTmzLymuwXUdFxyD5D36Mo6z9RD5+kz3NcMY2/Zbg2bnL0bIwxid7taBrc376UZUScLL
         en+S7/NpveBTV64uxCPkpU60JQfbstIiGK9C5tNn3A+EdgaE5XC4CWauKrgaj5QaKsMx
         fn5XJKhcGjUBH9oCCbkG9aVMRdKSAq+FSRgWENfmvFx+jzGILzAaEsxlDQWzqSQ75fic
         fbCSLY6jiLCM+xt7bPKuAU6L+d5NSp6KnE65GaGDWk34S+ciReboW4zTg26/o0btjY/4
         LbgQ==
X-Gm-Message-State: APzg51Dr3mIVDb2xjVO7h16QZNeOSF5tWN7aXWlUONGRZmAUDwDYkG2d
        lyuUqV6D4DKdD3Il/bXJBndTiS5qG0eCRyAaBzGpIw==
X-Google-Smtp-Source: ANB0VdYSc215PuIvS2NaltQZkY+vm9y50RAabfyYkKh7W8o1CaQDYMqmx3hr8iIjA0vhGL6I2++Rcm2RERnzAnT328k=
X-Received: by 2002:aca:dc55:: with SMTP id t82-v6mr9003671oig.159.1535058010770;
 Thu, 23 Aug 2018 14:00:10 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Thu, 23 Aug 2018 22:59:44 +0200
Message-ID: <CAG48ez1B1pqCdsEtNLpCBHHzNnqnpvkHkxF2TDNqe9fgF6Ozbg@mail.gmail.com>
Subject: rewind_stack_do_exit + KASAN incompatibility
To:     Andy Lutomirski <luto@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some while back (commit 2deb4be28077 ("x86/dumpstack: When OOPSing,
rewind the stack before do_exit()")), Andy added
rewind_stack_do_exit(), which is used in kernel oops handling to
discard the current stack contents and reset the stack pointer,
ensuring that the whole kernel stack is available for do_exit().
However, this code isn't integrated with KASAN.

Sometimes, when ASAN enters a function, it poisons parts of the
newly-allocated stack frame; on function exit, it un-poisons that
memory. ASAN does not, in general, unpoison stack memory on function
entry; instead, it is assumed that unallocated stack memory is not
poisoned.

This means that after rewind_stack_do_exit() has rewound the stack,
random parts of the stack are left poisoned, and when you try to
access those, KASAN spews random false-positives. I'm currently
working on adding some new kernel code, including an LKDTM testcase,
and running that testcase generated the following spew - the first
oops is intended, but the KASAN report after it is, from what I can
tell, garbage.

I'm not very familiar with KASAN internals, but I think a call to
kasan_unpoison_task_stack(current) in the right place should solve the
issue. I'm not entirely sure about where the call should be coming
from - probably from inside rewind_stack_do_exit()? But I'm not sure
whether it's possible to do this after rewinding the stack pointer
(which would require kasan_unpoison_task_stack(), including all
callees, to be uninstrumented), or whether it would have to happen
before rewinding the stack pointer.

[  237.475363] lkdtm: Performing direct entry USERCOPY_KERNEL_DS
[  237.478799] lkdtm: attempting copy_to_user on unmapped kernel address
[  237.482621] BUG: pagefault on kernel address 0xffffffffffffffea in
non-whitelisted uaccess
[  237.487197] BUG: unable to handle kernel paging request at ffffffffffffffea
[  237.487199] PGD 6242c067 P4D 6242c067 PUD 6242e067 PMD 0
[  237.487207] Oops: 0002 [#1] PREEMPT SMP KASAN PTI
[  237.487212] CPU: 2 PID: 1198 Comm: bash Tainted: G        W
4.18.0+ #101
[  237.487215] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[  237.487227] RIP: 0010:copy_user_generic_unrolled+0x89/0xc0
[  237.487230] Code: 38 4c 89 47 20 4c 89 4f 28 4c 89 57 30 4c 89 5f
38 48 8d 76 40 48 8d 7f 40 ff c9 75 b6 89 d1 83 e2 07 c1 e9 03 74 12
4c 8b 06 <4c> 89 07 48 8d 76 08 48 8d 7f 08 ff c9 75 ee 21 d2 74 10 89
d1 8a
[  237.487232] RSP: 0018:ffff8801add67bc8 EFLAGS: 00050202
[  237.487235] RAX: 0000000000000002 RBX: 000000000000000a RCX: 0000000000000001
[  237.487237] RDX: 0000000000000002 RSI: ffff8801add67c18 RDI: ffffffffffffffea
[  237.487239] RBP: ffffffffffffffea R08: 0000000000000000 R09: ffffed0035bacf85
[  237.487241] R10: 0000000000000002 R11: ffffed0035bacf84 R12: ffff8801add67c18
[  237.487242] R13: ffff8801db6ed040 R14: ffffffff9607cee0 R15: ffff8801e245d000
[  237.487245] FS:  00007f0c82df6b40(0000) GS:ffff8801ec280000(0000)
knlGS:0000000000000000
[  237.487247] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  237.487249] CR2: ffffffffffffffea CR3: 00000001de520002 CR4: 00000000003606e0
[  237.487254] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  237.487256] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  237.487257] Call Trace:
[  237.487266]  _copy_to_user+0x4f/0x60
[  237.487276]  lkdtm_USERCOPY_KERNEL_DS+0xc3/0x130
[  237.487281]  ? lkdtm_USERCOPY_KERNEL+0x170/0x170
[  237.487289]  ? free_unref_page_commit+0x107/0x1b0
[  237.487293]  direct_entry+0xe8/0x140
[  237.487300]  full_proxy_write+0x88/0xb0
[  237.487308]  __vfs_write+0xc4/0x370
[  237.487311]  ? kernel_read+0xa0/0xa0
[  237.487318]  ? locks_remove_posix+0x84/0x240
[  237.487321]  ? do_lock_file_wait+0x160/0x160
[  237.487326]  ? preempt_count_sub+0x14/0xc0
[  237.487333]  ? _raw_spin_lock+0x20/0x40
[  237.487338]  ? set_close_on_exec+0x77/0x90
[  237.487341]  ? preempt_count_sub+0x14/0xc0
[  237.487343]  ? expand_files+0x89/0x340
[  237.487347]  vfs_write+0xe7/0x230
[  237.487351]  ksys_write+0xa1/0x120
[  237.487355]  ? __ia32_sys_read+0x50/0x50
[  237.487359]  ? mm_fault_error+0x1b0/0x1b0
[  237.487366]  do_syscall_64+0x73/0x160
[  237.487369]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  237.487373] RIP: 0033:0x7f0c82500760
[  237.487376] Code: 73 01 c3 48 8b 0d 38 d7 2b 00 f7 d8 64 89 01 48
83 c8 ff c3 66 0f 1f 44 00 00 83 3d e9 2f 2c 00 00 75 10 b8 01 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89
04 24
[  237.487377] RSP: 002b:00007ffce9e99658 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  237.487380] RAX: ffffffffffffffda RBX: 0000000000000013 RCX: 00007f0c82500760
[  237.487382] RDX: 0000000000000013 RSI: 0000000000929008 RDI: 0000000000000001
[  237.487384] RBP: 0000000000929008 R08: 00007f0c827c0760 R09: 00007f0c82df6b40
[  237.487385] R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000013
[  237.487387] R13: 0000000000000001 R14: 00007f0c827bf600 R15: 0000000000000013
[  237.487390] Modules linked in: bpfilter
[  237.487395] CR2: ffffffffffffffea
[  237.487398] ---[ end trace f6027c19ee5b58c5 ]---
[  237.487402] RIP: 0010:copy_user_generic_unrolled+0x89/0xc0
[  237.487405] Code: 38 4c 89 47 20 4c 89 4f 28 4c 89 57 30 4c 89 5f
38 48 8d 76 40 48 8d 7f 40 ff c9 75 b6 89 d1 83 e2 07 c1 e9 03 74 12
4c 8b 06 <4c> 89 07 48 8d 76 08 48 8d 7f 08 ff c9 75 ee 21 d2 74 10 89
d1 8a
[  237.487407] RSP: 0018:ffff8801add67bc8 EFLAGS: 00050202
[  237.487409] RAX: 0000000000000002 RBX: 000000000000000a RCX: 0000000000000001
[  237.487410] RDX: 0000000000000002 RSI: ffff8801add67c18 RDI: ffffffffffffffea
[  237.487412] RBP: ffffffffffffffea R08: 0000000000000000 R09: ffffed0035bacf85
[  237.487414] R10: 0000000000000002 R11: ffffed0035bacf84 R12: ffff8801add67c18
[  237.487416] R13: ffff8801db6ed040 R14: ffffffff9607cee0 R15: ffff8801e245d000
[  237.487418] FS:  00007f0c82df6b40(0000) GS:ffff8801ec280000(0000)
knlGS:0000000000000000
[  237.487420] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  237.487421] CR2: ffffffffffffffea CR3: 00000001de520002 CR4: 00000000003606e0
[  237.487423] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  237.487424] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  237.487722] ==================================================================
[  237.487730] BUG: KASAN: stack-out-of-bounds in
get_page_from_freelist+0xa8/0x1a10
[  237.487732] Read of size 8 at addr ffff8801add67a80 by task bash/1198

[  237.487737] CPU: 2 PID: 1198 Comm: bash Tainted: G      D W
4.18.0+ #101
[  237.487739] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[  237.487740] Call Trace:
[  237.487747]  dump_stack+0x71/0xab
[  237.487753]  print_address_description+0x6a/0x250
[  237.487756]  kasan_report+0x258/0x380
[  237.487760]  ? get_page_from_freelist+0xa8/0x1a10
[  237.487763]  get_page_from_freelist+0xa8/0x1a10
[  237.487767]  ? __kernel_text_address+0xe/0x30
[  237.487773]  ? __save_stack_trace+0x92/0x100
[  237.487777]  ? preempt_count_add+0x70/0xc0
[  237.487779]  ? preempt_count_sub+0x14/0xc0
[  237.487783]  ? _raw_spin_unlock_irqrestore+0x20/0x40
[  237.487788]  ? depot_save_stack+0x2d9/0x460
[  237.487793]  ? __isolate_free_page+0x270/0x270
[  237.487799]  ? prepare_reply+0x2f/0xd0
[  237.487802]  ? taskstats_exit+0x1b6/0x5f0
[  237.487807]  ? do_exit+0x23c/0x1320
[  237.487810]  ? rewind_stack_do_exit+0x17/0x20
[  237.487816]  ? kvm_sched_clock_read+0x5/0x10
[  237.487819]  ? apic_timer_interrupt+0xa/0x20
[  237.487823]  __alloc_pages_nodemask+0x170/0x380
[  237.487828]  ? __alloc_pages_slowpath+0x1250/0x1250
[  237.487836]  cache_grow_begin+0x7c/0x840
[  237.487840]  ? rb_erase_cached+0x3b9/0x7f0
[  237.487845]  ? __rcu_read_unlock+0x66/0x80
[  237.487850]  kmem_cache_alloc_node_trace+0x2c5/0x5f0
[  237.487853]  ? kasan_kmalloc+0xa0/0xd0
[  237.487858]  __kmalloc_node_track_caller+0x33/0x60
[  237.487864]  __kmalloc_reserve.isra.44+0x2e/0x80
[  237.487867]  __alloc_skb+0xc2/0x2f0
[  237.487870]  ? netdev_alloc_frag+0x70/0x70
[  237.487874]  ? __schedule+0x4e7/0xe80
[  237.487877]  ? full_proxy_write+0x88/0xb0
[  237.487881]  prepare_reply+0x2f/0xd0
[  237.487885]  taskstats_exit+0x1b6/0x5f0
[  237.487888]  ? taskstats_user_cmd+0x620/0x620
[  237.487891]  ? preempt_schedule_common+0x3c/0x80
[  237.487894]  ? __acct_update_integrals+0x4d/0x170
[  237.487897]  ? preempt_count_add+0x70/0xc0
[  237.487899]  ? _raw_spin_lock_irq+0x27/0x50
[  237.487902]  do_exit+0x23c/0x1320
[  237.487907]  ? mm_update_next_owner+0x360/0x360
[  237.487910]  ? vfs_write+0xe7/0x230
[  237.487913]  ? ksys_write+0xa1/0x120
[  237.487916]  ? __ia32_sys_read+0x50/0x50
[  237.487919]  ? mm_fault_error+0x1b0/0x1b0
[  237.487923]  rewind_stack_do_exit+0x17/0x20

[  237.487928] The buggy address belongs to the page:
[  237.487931] page:ffffea0006b759c0 count:0 mapcount:0
mapping:0000000000000000 index:0x0
[  237.487933] flags: 0x17fffc000000000()
[  237.487938] raw: 017fffc000000000 dead000000000100 dead000000000200
0000000000000000
[  237.487941] raw: 0000000000000000 0000000000000000 00000000ffffffff
0000000000000000
[  237.487942] page dumped because: kasan: bad access detected

[  237.487944] Memory state around the buggy address:
[  237.487946]  ffff8801add67980: 00 00 00 00 f1 f1 f1 f1 01 f2 f2 f2
00 00 00 00
[  237.487948]  ffff8801add67a00: 00 00 00 00 00 00 00 00 00 00 f1 f1
f1 f1 00 00
[  237.487950] >ffff8801add67a80: f1 f1 00 f2 f2 f2 f2 f2 00 00 00 00
00 00 00 00
[  237.487951]                    ^
[  237.487957]  ffff8801add67b00: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[  237.487959]  ffff8801add67b80: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 f1
[  237.487960] ==================================================================
