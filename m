Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFDBC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0568F2064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0568F2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeJOOL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:11:56 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:36699 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeJOOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 10:11:55 -0400
Received: by mail-it1-f199.google.com with SMTP id p125-v6so21366397itg.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 23:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SCTu81GXEUVkIi/frBFGEd38d5XKwoHWUKa1JSBj6Rs=;
        b=i3ydLcdFOYSDEY1iQixf/f2rT5uiXhsPAZkiSYZC6omRcpr2UbOPYL8MZxy5t5qT+O
         xkzHnD+WvjXjLMMTtgmboBBdX8lp4rauvEaj7j/MvVik3g3bmjIio/sxgStJyWWhx32h
         llOEGdEFMh8LAjrQUvdzdxtzvEz6ZupKM8v+iLAp3VuA188EHGllsmJL4rcApPlm+Vo3
         MNGumJkBtAtJVd6DMVrl2mTmnhcrXCZHUkwrvuiwx47LBbfYeYCLntoNNa+0qy63lume
         md7dTvhXM3L/tpVlnYld4qxvBCelfajK6Rk6ksPXpYM5tkxaaWvnujOxSl/Avf+Cstoi
         3lCQ==
X-Gm-Message-State: ABuFfojwRwpwri+P06K6UD8q9wgIjgooXGsDHMQeamPYEjfDyg2tQwSU
        P8Ho6NA/TB4lo47gnwH/25UwrdMTmJWa+8HCbRmsyxiobrBc
X-Google-Smtp-Source: ACcGV61kRXPfZCYxNSK32Lf4PtFXJtmuyvaEXuMUWGWI5qE3t229jYkqcx/ACAoCrwYTMxSq37CPSXdyuzwrVZ67BrKFaTT3jjMp
MIME-Version: 1.0
X-Received: by 2002:a6b:4919:: with SMTP id u25-v6mr12410377iob.0.1539584884047;
 Sun, 14 Oct 2018 23:28:04 -0700 (PDT)
Date:   Sun, 14 Oct 2018 23:28:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d985405783e8aee@google.com>
Subject: KASAN: use-after-free Read in bpf_prog_kallsyms_del
From:   syzbot <syzbot+10cffda23c81a3ff1088@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    67e89ac32828 bpf: Fix dev pointer dereference from sk_skb
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11381531400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e7e2279c0020d5f
dashboard link: https://syzkaller.appspot.com/bug?extid=10cffda23c81a3ff1088
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+10cffda23c81a3ff1088@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0xf1/0xf3  
lib/list_debug.c:51
Read of size 8 at addr ffff8801d18fd820 by task syz-executor1/1917

CPU: 0 PID: 1917 Comm: syz-executor1 Not tainted 4.19.0-rc6+ #120
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __list_del_entry_valid+0xf1/0xf3 lib/list_debug.c:51
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_rcu include/linux/rculist.h:130 [inline]
  bpf_prog_ksym_node_del kernel/bpf/core.c:467 [inline]
  bpf_prog_kallsyms_del+0x1e7/0x410 kernel/bpf/core.c:498
  bpf_prog_kallsyms_del_all+0x1d/0x20 kernel/bpf/core.c:364
  __bpf_prog_put+0xd7/0x150 kernel/bpf/syscall.c:1135
  bpf_prog_put kernel/bpf/syscall.c:1143 [inline]
  bpf_prog_release+0x3c/0x50 kernel/bpf/syscall.c:1151
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411021
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fff25880b30 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000411021
RDX: 0000000000000000 RSI: 0000000000732b80 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007fff25880a60 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000311 R15: 0000000000000001

Allocated by task 1907:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  bpf_prog_alloc+0x328/0x3e0 kernel/bpf/core.c:89
  bpf_prog_load+0x435/0x1cb0 kernel/bpf/syscall.c:1402
  __do_sys_bpf kernel/bpf/syscall.c:2409 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2371 [inline]
  __x64_sys_bpf+0x36c/0x510 kernel/bpf/syscall.c:2371
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2682:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  __bpf_prog_free kernel/bpf/core.c:146 [inline]
  bpf_prog_unlock_free include/linux/filter.h:740 [inline]
  bpf_prog_free_deferred+0x2a4/0x420 kernel/bpf/core.c:1740
  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

The buggy address belongs to the object at ffff8801d18fd7c0
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 96 bytes inside of
  512-byte region [ffff8801d18fd7c0, ffff8801d18fd9c0)
The buggy address belongs to the page:
page:ffffea0007463f40 count:1 mapcount:0 mapping:ffff8801da800940 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea000706cf08 ffffea00075d1b88 ffff8801da800940
raw: 0000000000000000 ffff8801d18fd040 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d18fd700: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8801d18fd780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff8801d18fd800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                ^
  ffff8801d18fd880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d18fd900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
