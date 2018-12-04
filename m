Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03871C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D28206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D28206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeLDPnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:43:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:39106 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDPnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:43:05 -0500
Received: by mail-it1-f199.google.com with SMTP id k133so12977148ite.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 07:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aNuQebNaQSzNE1On/zMf+LiB63ZlAszx3rL0nPsUiW0=;
        b=oRM721BKBJXWWX3CtYJYGBG01yvvyYGwZLk8D8ROqdjCVHAHZmBFmzE1ig/CPeX0KL
         R73jColCvwsjSvcumDq5u9GHxHXJQFd5V0qUE3xW8X+408K0mPlJcdGB/ebWMHlDmYVD
         PXFTzU2iZ3FBcwqdMRNSqgfeCQPEDZ+8Hj28HfDeRwg1lj47uvAmNfxvkDNFTEZ0ut3T
         xR6lmPAYirW2Yxj89t1DaSXhXNNi4ORcEXq296ooB/D9ziFlstXl4XDEkYVyFaNYA9P9
         fehxjRQvIWKlHy8GyqNz1Rw8BbMFEUzlVDbuMxInqRA4RU2M7ezRrEvnGpgIQusemMJG
         7BpA==
X-Gm-Message-State: AA+aEWYcqFEJwE+jBdPwk5+4YLoANqSnThggkI6CdQJgzQh3rmm6i5v4
        MWAiPUirmdRFYhVxrJOHNslU9VqeSvCMq73a/gTscmViNqJ8
X-Google-Smtp-Source: AFSGD/WytAUic465apjIvtBokpdV6PBlfON4+IZpb/p7A800Hfc2O9DgGgQ4C3ILrTzrC7vROxqfVg6n/s+8P5E6Efi2i3BDygvA
MIME-Version: 1.0
X-Received: by 2002:a24:a94:: with SMTP id 142mr3877779itw.15.1543938184198;
 Tue, 04 Dec 2018 07:43:04 -0800 (PST)
Date:   Tue, 04 Dec 2018 07:43:04 -0800
In-Reply-To: <000000000000601367057a095de4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006457e057c341ff8@google.com>
Subject: Re: KASAN: use-after-free Read in get_mem_cgroup_from_mm
From:   syzbot <syzbot+cbb52e396df3e565ab02@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, syzkaller-bugs@googlegroups.com,
        vdavydov.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    0072a0c14d5b Merge tag 'media/v4.20-4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c885a3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9cc5a440391cbfd
dashboard link: https://syzkaller.appspot.com/bug?extid=cbb52e396df3e565ab02
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12835e25400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172fa5a3400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cbb52e396df3e565ab02@syzkaller.appspotmail.com

cgroup: fork rejected by pids controller in /syz2
==================================================================
BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:182  
[inline]
BUG: KASAN: use-after-free in task_css include/linux/cgroup.h:477 [inline]
BUG: KASAN: use-after-free in mem_cgroup_from_task mm/memcontrol.c:815  
[inline]
BUG: KASAN: use-after-free in get_mem_cgroup_from_mm.part.62+0x6d7/0x880  
mm/memcontrol.c:844
Read of size 8 at addr ffff8881b72af310 by task syz-executor198/9332

CPU: 0 PID: 9332 Comm: syz-executor198 Not tainted 4.20.0-rc5+ #142
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
  task_css include/linux/cgroup.h:477 [inline]
  mem_cgroup_from_task mm/memcontrol.c:815 [inline]
  get_mem_cgroup_from_mm.part.62+0x6d7/0x880 mm/memcontrol.c:844
  get_mem_cgroup_from_mm mm/memcontrol.c:834 [inline]
  mem_cgroup_try_charge+0x608/0xe20 mm/memcontrol.c:5888
  mcopy_atomic_pte mm/userfaultfd.c:71 [inline]
  mfill_atomic_pte mm/userfaultfd.c:418 [inline]
  __mcopy_atomic mm/userfaultfd.c:559 [inline]
  mcopy_atomic+0xb08/0x2c70 mm/userfaultfd.c:609
  userfaultfd_copy fs/userfaultfd.c:1705 [inline]
  userfaultfd_ioctl+0x29fb/0x5610 fs/userfaultfd.c:1851
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44c7e9
Code: 5d c5 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b c5 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f906b69fdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006e4a08 RCX: 000000000044c7e9
RDX: 0000000020000100 RSI: 00000000c028aa03 RDI: 0000000000000004
RBP: 00000000006e4a00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e4a0c
R13: 00007ffdfd47813f R14: 00007f906b6a09c0 R15: 000000000000002d

Allocated by task 9325:
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

Freed by task 9325:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3760
  free_task_struct kernel/fork.c:163 [inline]
  free_task+0x16e/0x1f0 kernel/fork.c:457
  copy_process+0x1dcc/0x87a0 kernel/fork.c:2148
  _do_fork+0x1cb/0x11d0 kernel/fork.c:2216
  __do_sys_clone kernel/fork.c:2323 [inline]
  __se_sys_clone kernel/fork.c:2317 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2317
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881b72ae240
  which belongs to the cache task_struct(81:syz2) of size 6080
The buggy address is located 4304 bytes inside of
  6080-byte region [ffff8881b72ae240, ffff8881b72afa00)
The buggy address belongs to the page:
page:ffffea0006dcab80 count:1 mapcount:0 mapping:ffff8881d2dce0c0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea00074a1f88 ffffea0006ebbb88 ffff8881d2dce0c0
raw: 0000000000000000 ffff8881b72ae240 0000000100000001 ffff8881d87fe580
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8881d87fe580

Memory state around the buggy address:
  ffff8881b72af200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b72af280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881b72af300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff8881b72af380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b72af400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

