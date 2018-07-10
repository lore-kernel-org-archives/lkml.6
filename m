Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B852FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D06208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D06208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeGJCQH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:16:07 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:52063 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932824AbeGJCQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 22:16:02 -0400
Received: by mail-it0-f69.google.com with SMTP id b83-v6so11180446itg.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 19:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IWuejZ7cxcRYtnEZgygezNN/Mb8xfd0W0yTtgr81oBo=;
        b=QhpfavdQfSd3Srwjs/v4jMv2nCUMcxqqFqz+Put6xR1VzNLdJhDmS8gGprPHm4AHX7
         NVWXtY0eu48mmJQ/25TRBfnOA3n5Dj2HQ+dMVJdNWEY/dbFh/knRmtNoNXnZVn+HZS+p
         icYw7SqcH/kJOIO956c84V5gHzpQqGYYGMKe5uoyzYevz9f8sUef9iG8LS+4xkiffLHA
         EDSH7s5hEDfgF+F6WbQAYbH682ZPajJsQ9mp8mfiTgh12pu/gHXY9f/40uGWxMlx0Hgi
         fQwncGRoey8upYqfkAt+K6ME1AYNr5cW5O9ogyZlHI2J9uQlQaZA7+CFpf6lXQxeqHam
         fe/Q==
X-Gm-Message-State: APt69E2pXB9S/4kQVJpP0kQoifv5/0+/GBmpWWR82gz0B7TL4QcnfkCo
        PveNlyAuAg0Ny2plKD/EcdtANzKN9gkSPtFp/+a7oUtEqgSp
X-Google-Smtp-Source: AAOMgpfMTY64Iyv6HxXOzVlJ8oxatdQv/bpQndrNXvJaFWDqOP2fA63PmQsXenwtHbfd1yJAA5JBYAmbIN3jr88M1hf8k/QPWp68
MIME-Version: 1.0
X-Received: by 2002:a24:2544:: with SMTP id g65-v6mr5930113itg.0.1531188961932;
 Mon, 09 Jul 2018 19:16:01 -0700 (PDT)
Date:   Mon, 09 Jul 2018 19:16:01 -0700
In-Reply-To: <000000000000ccdf0605708a9ccc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028fe5e05709bb662@google.com>
Subject: Re: KASAN: use-after-free Write in _free_event
From:   syzbot <syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        dvyukov@google.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    092150a25cb7 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16627cc2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=a24c397a29ad22d86c98
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=14d45afc400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dd4968400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_dec_and_test  
include/asm-generic/atomic-instrumented.h:222 [inline]
BUG: KASAN: use-after-free in put_task_struct include/linux/sched/task.h:95  
[inline]
BUG: KASAN: use-after-free in _free_event+0x48d/0x1440  
kernel/events/core.c:4451
Write of size 4 at addr ffff8801ab6360e0 by task syz-executor205/5237

CPU: 1 PID: 5237 Comm: syz-executor205 Not tainted 4.18.0-rc4+ #139
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
  atomic_dec_and_test include/asm-generic/atomic-instrumented.h:222 [inline]
  put_task_struct include/linux/sched/task.h:95 [inline]
  _free_event+0x48d/0x1440 kernel/events/core.c:4451
  free_event+0xb4/0x180 kernel/events/core.c:4472
  perf_event_release_kernel+0x7d5/0x1050 kernel/events/core.c:4633
  perf_release+0x37/0x50 kernel/events/core.c:4647
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1b08/0x2750 kernel/exit.c:865
  do_group_exit+0x177/0x440 kernel/exit.c:968
  get_signal+0x88e/0x1970 kernel/signal.c:2468
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e0/0x370 arch/x86/entry/common.c:162
  prepare_exit_to_usermode+0x342/0x3b0 arch/x86/entry/common.c:197
  retint_user+0x8/0x18
RIP: 0033:          (null)
Code: Bad RIP value.
RSP: 002b:0000000020000048 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00000000006dbc24 RCX: 0000000000445d89
RDX: 0000000020000100 RSI: 0000000020000040 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000020000080 R09: 0000000000000000
R10: 0000000020000000 R11: 0000000000000246 R12: 00000000006dbc20
R13: 0030656c69662f2e R14: 0000004000008912 R15: 0000000000000006

Allocated by task 5236:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc_node+0x144/0x780 mm/slab.c:3644
  alloc_task_struct_node kernel/fork.c:157 [inline]
  dup_task_struct kernel/fork.c:779 [inline]
  copy_process.part.39+0x16b5/0x7220 kernel/fork.c:1641
  copy_process kernel/fork.c:1616 [inline]
  _do_fork+0x291/0x12a0 kernel/fork.c:2099
  __do_sys_clone kernel/fork.c:2206 [inline]
  __se_sys_clone kernel/fork.c:2200 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2200
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5236:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  free_task_struct kernel/fork.c:162 [inline]
  free_task+0x16e/0x1f0 kernel/fork.c:390
  copy_process.part.39+0x15c9/0x7220 kernel/fork.c:2034
  copy_process kernel/fork.c:1616 [inline]
  _do_fork+0x291/0x12a0 kernel/fork.c:2099
  __do_sys_clone kernel/fork.c:2206 [inline]
  __se_sys_clone kernel/fork.c:2200 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2200
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801ab6360c0
  which belongs to the cache task_struct of size 5952
The buggy address is located 32 bytes inside of
  5952-byte region [ffff8801ab6360c0, ffff8801ab637800)
The buggy address belongs to the page:
page:ffffea0006ad8d80 count:1 mapcount:0 mapping:ffff8801da94b200 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0006ad9008 ffffea00075f5888 ffff8801da94b200
raw: 0000000000000000 ffff8801ab6360c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ab635f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801ab636000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801ab636080: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                        ^
  ffff8801ab636100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801ab636180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

