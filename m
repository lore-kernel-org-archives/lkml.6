Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B8BC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6938A2174E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6938A2174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754098AbeGGOJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:09:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:44109 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753587AbeGGOJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:09:02 -0400
Received: by mail-io0-f198.google.com with SMTP id f12-v6so11961436iob.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TjwHmpH54/WzZ9NP/W46iU4RgzlFnIdnhGwfHGjg9bM=;
        b=Q4RAgQgl5yeL2ewHRkDr11vVrEi8Gyho7lOJfHWhqRnktovoo3veInYiBViVED5Qjs
         cDvjYy/nADrh34o+OLuQ5XKgBY7J1HMprQCl0sA0drZuYKvJ9fuZM5qkfueaieU9eZQR
         zW9pEXHBc4uPPHaRsEslLHwqDTaMVaEWHKY//ZSdsznfnTctzD9CugLjfGimSdO85Uo0
         JTWf+jkdv/IWE6Zl+XLHVhDT3KqRy8NbjleltZJB35TBtYoSdm/XWIeNMmbHqONnxivS
         RvE9tyJ5ZIyoj1l59GEIvlYbRxwukmDmxvCTO/j+UHeiiUMQsbKbuSdIDVikEtlnlzuf
         RLwA==
X-Gm-Message-State: APt69E2yplD1SR3Q4WRj/c3rO+g2JdE3iWtm/Ov4Yja4lfrEyYFzfplR
        B4/R5UIfuZsdf6tdT3PWc5vg9Vh9TNJZwSXEsa4NJIWQFRYi
X-Google-Smtp-Source: AAOMgpf/23sMSMzZ3+GLUBeZiPX6LiUJY6iyn3E6I/cSlpvSmpvV8Z9le8KhTwfxp8sNF9x1IEZ3ZrD3P6mBwJWtedoAbxz8iBnd
MIME-Version: 1.0
X-Received: by 2002:a24:391:: with SMTP id e139-v6mr5909312ite.29.1530972541456;
 Sat, 07 Jul 2018 07:09:01 -0700 (PDT)
Date:   Sat, 07 Jul 2018 07:09:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e9bdb057069522e@google.com>
Subject: KASAN: use-after-free Read in dput
From:   syzbot <syzbot+f364b40402d79b9902d7@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    526674536360 Add linux-next specific files for 20180706
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=121481b2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
dashboard link: https://syzkaller.appspot.com/bug?extid=f364b40402d79b9902d7
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=16b47cc2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137cec58400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f364b40402d79b9902d7@syzkaller.appspotmail.com

Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
==================================================================
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x11 lib/fault-inject.c:149
BUG: KASAN: use-after-free in fast_dput fs/dcache.c:717 [inline]
BUG: KASAN: use-after-free in dput.part.26+0x634/0x7a0 fs/dcache.c:836
Read of size 4 at addr ffff8801a7b8c4a0 by task syz-executor287/4482

  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1557
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x2c8/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  prealloc_shrinker+0x124/0x450 mm/vmscan.c:361
  register_shrinker+0x17/0x40 mm/vmscan.c:413
  sget_fc+0x778/0x960 fs/super.c:562
  vfs_get_super+0x6e/0x270 fs/super.c:1263
  proc_get_tree+0x88/0xb0 fs/proc/root.c:159
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1751
  do_new_mount fs/namespace.c:2567 [inline]
  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
  ksys_mount+0x12d/0x140 fs/namespace.c:3105
  __do_sys_mount fs/namespace.c:3119 [inline]
  __se_sys_mount fs/namespace.c:3116 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441d79
Code: e8 6c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe4c8551b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441d79
RDX: 0000000020000540 RSI: 0000000020000500 RDI: 00000000200004c0
RBP: 00007ffe4c8551d0 R08: 0000000020000580 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
CPU: 0 PID: 4482 Comm: syz-executor287 Not tainted  
4.18.0-rc3-next-20180706+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  fast_dput fs/dcache.c:717 [inline]
  dput.part.26+0x634/0x7a0 fs/dcache.c:836
  dput+0x15/0x20 fs/dcache.c:831
  proc_kill_sb+0x125/0x1e0 fs/proc/root.c:198
  deactivate_locked_super+0x97/0x100 fs/super.c:328
  vfs_get_super+0x20f/0x270 fs/super.c:1270
  proc_get_tree+0x88/0xb0 fs/proc/root.c:159
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1751
  do_new_mount fs/namespace.c:2567 [inline]
  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
  ksys_mount+0x12d/0x140 fs/namespace.c:3105
  __do_sys_mount fs/namespace.c:3119 [inline]
  __se_sys_mount fs/namespace.c:3116 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441d79
Code: e8 6c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe4c8551b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441d79
RDX: 0000000020000540 RSI: 0000000020000500 RDI: 00000000200004c0
RBP: 00007ffe4c8551d0 R08: 0000000020000580 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4473:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  __d_alloc+0xc8/0xd50 fs/dcache.c:1617
  d_alloc+0x96/0x380 fs/dcache.c:1701
  d_alloc_name+0xbb/0x120 fs/dcache.c:1755
  proc_setup_self+0xe1/0x3af fs/proc/self.c:43
  proc_fill_super+0x37e/0x630 fs/proc/root.c:133
  vfs_get_super+0x15e/0x270 fs/super.c:1268
  proc_get_tree+0x88/0xb0 fs/proc/root.c:159
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1751
  do_new_mount fs/namespace.c:2567 [inline]
  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
  ksys_mount+0x12d/0x140 fs/namespace.c:3105
  __do_sys_mount fs/namespace.c:3119 [inline]
  __se_sys_mount fs/namespace.c:3116 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4474:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  __d_free+0x20/0x30 fs/dcache.c:257
  __rcu_reclaim kernel/rcu/rcu.h:258 [inline]
  rcu_do_batch kernel/rcu/tree.c:2576 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2878 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2845 [inline]
  rcu_process_callbacks+0xe01/0x2810 kernel/rcu/tree.c:2862
  __do_softirq+0x2e8/0xb17 kernel/softirq.c:288

The buggy address belongs to the object at ffff8801a7b8c4a0
  which belongs to the cache dentry(17:syz4) of size 288
The buggy address is located 0 bytes inside of
  288-byte region [ffff8801a7b8c4a0, ffff8801a7b8c5c0)
The buggy address belongs to the page:
page:ffffea00069ee300 count:1 mapcount:0 mapping:ffff8801ccf543c0 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801d4348948 ffffea00069ee788 ffff8801ccf543c0
raw: 0000000000000000 ffff8801a7b8c080 000000010000000b ffff8801ab42c3c0
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801ab42c3c0

Memory state around the buggy address:
  ffff8801a7b8c380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801a7b8c400: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> ffff8801a7b8c480: fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb fb
                                ^
  ffff8801a7b8c500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801a7b8c580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
