Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205B0C0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 11:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9A420883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 11:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9A420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeKJVat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 16:30:49 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:54178 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbeKJVat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 16:30:49 -0500
Received: by mail-it1-f199.google.com with SMTP id l200-v6so6288267ita.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 03:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xJX20HzMchDUufUCWMeLYaiQJSe/OL/ziT07LD85WJc=;
        b=mbjslqWS88OGDe82ETEG2dw6/WhxQ+guVJfmkJa/mdBR4DvKoYoDVxf6MtajnCBpbl
         MWaPXK4vLFQ1lKqMSIngDZXGngmBrwmaYti1AWfHui9qU0HFLVPvq/Jbg+L7agkRFPVe
         0Zpr6/fwS6sY8dIC6rs234oqRkOkf03aOyHJB8m1NWx6W8jfPU2FK+MNVEpSyw5EmG0Y
         J+8myI2GOIYNZwreycjUtGg6A47d7EyFESdkr0VZu3SU7soIXI2FHs9GNpBboJbNlN1d
         Z+GwoJsCtieF6NVtTzVEOb1WHzLjyIcn/xPnt5krXWKzmhXMXcvQZ6rOkWT1Bb4K2P0I
         ZBtg==
X-Gm-Message-State: AGRZ1gIvjsP6Q0/t6jIk3CkR7UTXyPwoJL/xLKnnUwpwRPrmdENMLI3b
        4FX8+1ouyJzHCdrKQspH1CX5r5S4WGSBPQhlvpNsdVflh1y3
X-Google-Smtp-Source: AJdET5eDbN/KSW1CPqZAfRQfRLarFUeVxNtYxug+Jm0/WjirHWXjMGRpR2XCRqd+9OLp2HNNkUMrP9dzv3i6JXXsojshIv0GdtTv
MIME-Version: 1.0
X-Received: by 2002:a24:bdc7:: with SMTP id x190-v6mr4536120ite.21.1541850364386;
 Sat, 10 Nov 2018 03:46:04 -0800 (PST)
Date:   Sat, 10 Nov 2018 03:46:04 -0800
In-Reply-To: <0000000000004904df0578b7d3da@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000442753057a4e036d@google.com>
Subject: Re: KASAN: use-after-free Read in task_is_descendant
From:   syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>
To:     jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    aa4330e15c26 Merge tag 'devicetree-fixes-for-4.20-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17abaa47400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f559fee2fc3375a
dashboard link: https://syzkaller.appspot.com/bug?extid=a9ac39bf55329e206219
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108ae6d5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bd86a3400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:182  
[inline]
BUG: KASAN: use-after-free in task_is_descendant.part.3+0x610/0x670  
security/yama/yama_lsm.c:295
Read of size 8 at addr ffff8801ae718560 by task syz-executor198/4607

CPU: 1 PID: 4607 Comm: syz-executor198 Not tainted 4.20.0-rc1+ #232
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __read_once_size include/linux/compiler.h:182 [inline]
  task_is_descendant.part.3+0x610/0x670 security/yama/yama_lsm.c:295
  task_is_descendant security/yama/yama_lsm.c:282 [inline]
  yama_ptrace_access_check+0x215/0x10fc security/yama/yama_lsm.c:371
  security_ptrace_access_check+0x54/0xb0 security/security.c:271
  __ptrace_may_access+0x5c8/0x980 kernel/ptrace.c:336
  ptrace_attach+0x1fa/0x640 kernel/ptrace.c:389
  __do_compat_sys_ptrace kernel/ptrace.c:1284 [inline]
  __se_compat_sys_ptrace kernel/ptrace.c:1266 [inline]
  __ia32_compat_sys_ptrace+0x1d2/0x260 kernel/ptrace.c:1266
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7feba29
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7fe71ec EFLAGS: 00000296 ORIG_RAX: 000000000000001a
RAX: ffffffffffffffda RBX: 0000000000004206 RCX: 00000000000014b5
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 5668:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc_node+0x144/0x730 mm/slab.c:3644
  alloc_task_struct_node kernel/fork.c:158 [inline]
  dup_task_struct kernel/fork.c:843 [inline]
  copy_process+0x2026/0x87a0 kernel/fork.c:1751
  _do_fork+0x1cb/0x11d0 kernel/fork.c:2216
  __do_compat_sys_x86_clone arch/x86/ia32/sys_ia32.c:240 [inline]
  __se_compat_sys_x86_clone arch/x86/ia32/sys_ia32.c:236 [inline]
  __ia32_compat_sys_x86_clone+0xbc/0x140 arch/x86/ia32/sys_ia32.c:236
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

Freed by task 16:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3760
  free_task_struct kernel/fork.c:163 [inline]
  free_task+0x16e/0x1f0 kernel/fork.c:457
  __put_task_struct+0x2e6/0x620 kernel/fork.c:730
  put_task_struct include/linux/sched/task.h:96 [inline]
  delayed_put_task_struct+0x2ff/0x4c0 kernel/exit.c:181
  __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
  rcu_do_batch kernel/rcu/tree.c:2437 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2716 [inline]
  rcu_process_callbacks+0x100a/0x1ac0 kernel/rcu/tree.c:2697
  __do_softirq+0x308/0xb7e kernel/softirq.c:292

The buggy address belongs to the object at ffff8801ae718080
  which belongs to the cache task_struct of size 6080
The buggy address is located 1248 bytes inside of
  6080-byte region [ffff8801ae718080, ffff8801ae719840)
The buggy address belongs to the page:
page:ffffea0006b9c600 count:1 mapcount:0 mapping:ffff8801da970180 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0006b99488 ffffea0006b9c688 ffff8801da970180
raw: 0000000000000000 ffff8801ae718080 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ae718400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801ae718480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801ae718500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff8801ae718580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801ae718600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

