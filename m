Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF12C43610
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4B320855
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4B320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeKJNIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 08:08:32 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:52282 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeKJNIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 08:08:32 -0500
Received: by mail-io1-f72.google.com with SMTP id o8-v6so4119856iob.19
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 19:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JtpWXZPx9T3VraptmBpM+x2OAirEFtygC47198dsJ64=;
        b=O2um5+XEyOgfeMagHpIpamXBt1rLz62hlxquGiQk3do/M95d2epZSdcXhsqS6tNlWv
         SFRB+024O55ds3MzIFUlrUj0zrHMcNgK10jG87fweW6Qxflt6lWLL8WCSQM49naMtV5F
         jNVHWK7qUCe29B2tT6+iQi13Tca0l0kpz3vhJGVTFF2xwuqhExWA2d8NGPoboEXaQHWj
         VbQUQPbqvfnZElhSYoq7rXTJVHfX10hdULwnoQWYQ75hHw2NcXZIbzrc0+s8EaQEd4Bw
         76tw1FXqbaglZzCMYegaehvLEI/w8l+8H0oUjJRhjq48Aqk8+HlbhaT0HBNGsPPdrGjn
         I35g==
X-Gm-Message-State: AGRZ1gILaYNzAD2WvB4PPLh3hGx6BUBww8fVbmpETfhzU99eEzqWLBUp
        DdKZnhSiYjOeXBKTpNRf4dHejr1HBSPaRjHVomcp7ZnQKaYo
X-Google-Smtp-Source: AJdET5c4WGDylUPJKdPC8v0+B6zjWq5zOXuSgn7TCWKUDQVm4Uhf/i8vARI84U8RSiko1pCM4Cmw6Tx+QyCAPPnMKL6UtjA4/5Gd
MIME-Version: 1.0
X-Received: by 2002:a02:7607:: with SMTP id z7-v6mr8799194jab.0.1541820303574;
 Fri, 09 Nov 2018 19:25:03 -0800 (PST)
Date:   Fri, 09 Nov 2018 19:25:03 -0800
In-Reply-To: <0000000000004904df0578b7d3da@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008090a9057a4703aa@google.com>
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

HEAD commit:    3541833fd1f2 Merge tag 's390-4.20-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d3cad5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f559fee2fc3375a
dashboard link: https://syzkaller.appspot.com/bug?extid=a9ac39bf55329e206219
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1494bb0b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:182  
[inline]
BUG: KASAN: use-after-free in task_is_descendant.part.3+0x610/0x670  
security/yama/yama_lsm.c:295
Read of size 8 at addr ffff8801c46f24e0 by task syz-executor2/9973

CPU: 0 PID: 9973 Comm: syz-executor2 Not tainted 4.20.0-rc1+ #107
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
  __do_sys_ptrace kernel/ptrace.c:1139 [inline]
  __se_sys_ptrace kernel/ptrace.c:1119 [inline]
  __x64_sys_ptrace+0x229/0x260 kernel/ptrace.c:1119
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2ed4dbfc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000065
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 000000000000021d RDI: 0000000000004206
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2ed4dc06d4
R13: 00000000004c33bd R14: 00000000004d50e0 R15: 00000000ffffffff

Allocated by task 5873:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc_node+0x144/0x730 mm/slab.c:3644
  alloc_task_struct_node kernel/fork.c:158 [inline]
  dup_task_struct kernel/fork.c:843 [inline]
  copy_process+0x2026/0x87a0 kernel/fork.c:1751
  _do_fork+0x1cb/0x11d0 kernel/fork.c:2216
  __do_sys_clone kernel/fork.c:2323 [inline]
  __se_sys_clone kernel/fork.c:2317 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2317
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9:
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

The buggy address belongs to the object at ffff8801c46f2000
  which belongs to the cache task_struct(65:syz2) of size 6080
The buggy address is located 1248 bytes inside of
  6080-byte region [ffff8801c46f2000, ffff8801c46f37c0)
The buggy address belongs to the page:
page:ffffea000711bc80 count:1 mapcount:0 mapping:ffff8801c204fc80 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea00073cf808 ffffea000697c908 ffff8801c204fc80
raw: 0000000000000000 ffff8801c46f2000 0000000100000001 ffff8801d8404a80
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801d8404a80

Memory state around the buggy address:
  ffff8801c46f2380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c46f2400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801c46f2480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff8801c46f2500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c46f2580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

