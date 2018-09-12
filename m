Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0B3C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFBB206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFBB206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeILS1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:27:32 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:43334 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbeILS1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:27:32 -0400
Received: by mail-it0-f69.google.com with SMTP id z72-v6so3349051itc.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 06:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3Y+96eAc+F0eFbeI5+gMKc3tMC9TzJ/lthfgPFye9gk=;
        b=nR+K2z3jQbf9bZRzaM0XCvkS4P45DGkbsd84cdpvBMV15nZJZDs+8qaexCtSdX2B9P
         hw0LeoJoRuIjJEaJ20J29Mb0UcrU3vm8W8IVHCE0Yd1xitIes5k5EEQwR8zCZyA77bhl
         eC6mbp/immvivzeRxg2hqZRXmte9CGx2UDqHURxb2Fb/K40t75QnjViHLLSOGHPgjNQ2
         eZs6wyHFRg8+2h7cQkD0HQTOR61ATS9gio8sqpoT9jZEReYjgweBiC5eHq/uFiTl0D5L
         ZeYRoTKQPGcv0OwGyGWJccSPvcuRFESKYe+vn2yQ/I/loKudREoll1u+S048DJqRNg6j
         2qJQ==
X-Gm-Message-State: APzg51CuWB6kex+1LbP/Aj7ItFI+pwLTMPcuYQ7pBDFjsSaR1XsN3AiD
        iXVamHlWQQyiAct4ECKTDJe6fYbujC8kNyx3S+I83o0L8WRB
X-Google-Smtp-Source: ANB0VdYndwrvKS8oYavUNoUh6D+wnPkUMJz4o7GcPTUuZYei0nDieLLsWyu1aEuo2QZ616OKWgPEGWOsgpNafiIkUB3KvnJcwGFv
MIME-Version: 1.0
X-Received: by 2002:a5e:d908:: with SMTP id n8-v6mr1480154iop.77.1536758582661;
 Wed, 12 Sep 2018 06:23:02 -0700 (PDT)
Date:   Wed, 12 Sep 2018 06:23:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006cd9da0575ac7d9d@google.com>
Subject: KASAN: use-after-free Read in mqueue_get_tree
From:   syzbot <syzbot+fef0b74a3bf760a9ee85@syzkaller.appspotmail.com>
To:     arnd@arndb.de, dbueso@suse.de, dhowells@redhat.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7c1b097f27bf Add linux-next specific files for 20180912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14e6101a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5980033172920ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=fef0b74a3bf760a9ee85
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13104f71400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fef0b74a3bf760a9ee85@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: cc1: uninitialized urandom read (8 bytes read)
==================================================================
BUG: KASAN: use-after-free in mqueue_get_tree+0x2ac/0x2e0 ipc/mqueue.c:362
Read of size 8 at addr ffff8801d7cc0688 by task syz-executor4/5584

CPU: 0 PID: 5584 Comm: syz-executor4 Not tainted 4.19.0-rc3-next-20180912+  
#72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  mqueue_get_tree+0x2ac/0x2e0 ipc/mqueue.c:362
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1787
  mq_create_mount+0xe3/0x190 ipc/mqueue.c:415
  mq_init_ns+0x15a/0x210 ipc/mqueue.c:1621
  create_ipc_ns ipc/namespace.c:58 [inline]
  copy_ipcs+0x3d2/0x580 ipc/namespace.c:84
  create_new_namespaces+0x376/0x900 kernel/nsproxy.c:87
  unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:206
  ksys_unshare+0x79c/0x10b0 kernel/fork.c:2535
  __do_sys_unshare kernel/fork.c:2603 [inline]
  __se_sys_unshare kernel/fork.c:2601 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2601
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459d87
Code: 00 00 00 b8 63 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 3d 8a fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1d 8a fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffddc9e7fb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459d87
RDX: 0000000000000000 RSI: 00007ffddc9e7fc0 RDI: 0000000008000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000018
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000412c30
R13: 0000000000412cc0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 3455:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  getname_flags+0xd0/0x5a0 fs/namei.c:140
  getname fs/namei.c:211 [inline]
  do_symlinkat+0x8b/0x2d0 fs/namei.c:4143
  __do_sys_symlink fs/namei.c:4173 [inline]
  __se_sys_symlink fs/namei.c:4171 [inline]
  __x64_sys_symlink+0x59/0x80 fs/namei.c:4171
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 3455:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3756
  putname+0xf2/0x130 fs/namei.c:261
  do_symlinkat+0x18c/0x2d0 fs/namei.c:4161
  __do_sys_symlink fs/namei.c:4173 [inline]
  __se_sys_symlink fs/namei.c:4171 [inline]
  __x64_sys_symlink+0x59/0x80 fs/namei.c:4171
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d7cc0540
  which belongs to the cache names_cache of size 4096
The buggy address is located 328 bytes inside of
  4096-byte region [ffff8801d7cc0540, ffff8801d7cc1540)
The buggy address belongs to the page:
page:ffffea00075f3000 count:1 mapcount:0 mapping:ffff8801da972d80 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea00075fa788 ffffea00075f0b08 ffff8801da972d80
raw: 0000000000000000 ffff8801d7cc0540 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d7cc0580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d7cc0600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801d7cc0680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff8801d7cc0700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d7cc0780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
