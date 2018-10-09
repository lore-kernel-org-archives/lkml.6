Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E110C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F87214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F87214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJJAcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:32:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:57005 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJJAcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:32:01 -0400
Received: by mail-io1-f69.google.com with SMTP id f9-v6so1944300iok.23
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mlHn2kW5Fz/DRQPb42W+P5jJJU7iIK0gv3Fr/36wuxY=;
        b=frLY704WjYc/k/glorrV4imh5zaDgb0PDmd4oVysZyg1hJdg1pwocggI37gwtJK/y+
         e9+KGFnocz//IBmedXxUicEcqWhCNK1+TKYxaYo8RuhBZcvmCUInjJJkLUdSXytJ4Uf1
         V9fae3ndyxaoQDus0OjDgRNz2Nn8ME6uejuybpVu5K/ZX3eHLYHvKQwJwgD3csoNqX2Z
         vn6Krd6pZ/K2oTeHOPUsgNc43MQZ/2ZvqPV99Im0+t++8zzgvqMANDAdr2PVAuPGaVNX
         glyl79Axb72NLC2MlYHpjVVqPnshWaseFKIu3Vr35e1ZG56SsJEjCxfetDOTSBsy0sAQ
         LGPQ==
X-Gm-Message-State: ABuFfoj0lYPCNLspXx5xSBltUDDhwC+DQ8OujqonWL4otAF+Zrqjwn8w
        g0dGBCuGr/Y7CwP68kmKZfvVa3wmAxivnPCukkiF6Y3DN9xU
X-Google-Smtp-Source: ACcGV63WVX2GzKzB+K3V2XFDj6QhumjQm/z5f6zO1Eqv3UMVP6wOpSzXYdN7e+ClnTFTXZykLotnHwT5T37KY9HwM7MgGnedDD5O
MIME-Version: 1.0
X-Received: by 2002:a24:7546:: with SMTP id y67-v6mr2657410itc.26.1539105243764;
 Tue, 09 Oct 2018 10:14:03 -0700 (PDT)
Date:   Tue, 09 Oct 2018 10:14:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053a2ca0577ceddac@google.com>
Subject: WARNING: ODEBUG bug in free_task
From:   syzbot <syzbot+71aff6ea121ffefc280f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ebiederm@xmission.com, guro@fb.com,
        keescook@chromium.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        marcos.souza.org@gmail.com, mhocko@kernel.org, riel@surriel.com,
        syzkaller-bugs@googlegroups.com, wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ae16eea39a86 Add linux-next specific files for 20181008
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16a493b9400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42525ce985d1a955
dashboard link: https://syzkaller.appspot.com/bug?extid=71aff6ea121ffefc280f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14567ae6400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14baa25e400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+71aff6ea121ffefc280f@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 1) object type: rcu_head hint:            
(null)
WARNING: CPU: 0 PID: 6048 at lib/debugobjects.c:329  
debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 6048 Comm: syz-executor022 Not tainted  
4.19.0-rc7-next-20181008+ #89
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x3ab lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Code: 41 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 92 00 00 00 48 8b 14 dd  
60 02 41 88 4c 89 fe 48 c7 c7 00 f8 40 88 e8 36 2f b4 fd <0f> 0b 83 05 a9  
f4 5e 06 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffff8801d8c3eda8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8164d235 RDI: 0000000000000005
RBP: ffff8801d8c3ede8 R08: ffff8801d70aa280 R09: ffffed003b5c3eda
R10: ffffed003b5c3eda R11: ffff8801dae1f6d7 R12: 0000000000000001
R13: ffffffff8939a760 R14: 0000000000000000 R15: ffffffff8840fca0
  __debug_check_no_obj_freed lib/debugobjects.c:786 [inline]
  debug_check_no_obj_freed+0x3ae/0x58d lib/debugobjects.c:818
  kmem_cache_free+0x202/0x290 mm/slab.c:3759
  free_task_struct kernel/fork.c:163 [inline]
  free_task+0x16e/0x1f0 kernel/fork.c:457
  __put_task_struct+0x2e6/0x620 kernel/fork.c:730
  put_task_struct include/linux/sched/task.h:96 [inline]
  finish_task_switch+0x66c/0x900 kernel/sched/core.c:2715
  context_switch kernel/sched/core.c:2834 [inline]
  __schedule+0x8d7/0x21d0 kernel/sched/core.c:3480
  schedule+0xfe/0x460 kernel/sched/core.c:3524
  freezable_schedule include/linux/freezer.h:172 [inline]
  futex_wait_queue_me+0x3f9/0x840 kernel/futex.c:2530
  futex_wait+0x45c/0xa50 kernel/futex.c:2645
  do_futex+0x31a/0x26d0 kernel/futex.c:3528
  __do_sys_futex kernel/futex.c:3589 [inline]
  __se_sys_futex kernel/futex.c:3557 [inline]
  __x64_sys_futex+0x472/0x6a0 kernel/futex.c:3557
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446549
Code: e8 2c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3a998f5da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446549
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dbc38
RBP: 00000000006dbc30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 2f646e6162696e69 R14: 666e692f7665642f R15: 00000000006dbd2c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
