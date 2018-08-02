Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBCAC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF0721537
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF0721537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbeHBTvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:51:14 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:38693 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730841AbeHBTvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:51:13 -0400
Received: by mail-it0-f69.google.com with SMTP id h5-v6so2991935itb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 10:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2CWrRN6NJ6nYEhHZo9tBSrDgeIzBEIkrjbUNDHCfEOo=;
        b=Sw1vcLwwbJ3cwUvdq58IhQwvdgXdFUBP0utpGZYdrfR3pojGGl2coYHpFSM7AXqs+h
         P49NHNR8r+CpDatKAFj3yib9gOabNqiNac1zz0mNmUbAQKqAStYBETS+ZyIK6E0d8Vxx
         89+WzYJAnGh0LmFyai4sSWjuSr+Zep046Dwh7LvszS41W++07JqD0NcxAV2Y0QUThXiy
         A/pD8v6fp4h7cWxxPw2gXyG6wEQ6faKi4GWoOxDvcfi9gGaQUc/1MuUWZqiAd36prSFd
         9Rv6n34wKTDt+IaEasMqmCy5U0ERwabP3RaD3sKV15IxqrWUhgmGviTzLLi7nBBQbW/8
         KKLA==
X-Gm-Message-State: AOUpUlFsLjnKfIWTazkKEW9LfrVTJWgqlNnI3PeIEzGqIL2nkeVgGlV1
        YLp3ecnGNYfZ6R+vz3u8QCDrZJ6RfDFqx9P1L3wqatqBvpLF
X-Google-Smtp-Source: AAOMgpeSPN3pNYzs00ivBiUsEVIFnlE3WE/F9E44R2pir5xHiD46SZL/afgDVDIokLPf7AkBVhzAZHtoukhmvlCsaCpyKbsDlMfX
MIME-Version: 1.0
X-Received: by 2002:a6b:3443:: with SMTP id b64-v6mr1558781ioa.68.1533232742115;
 Thu, 02 Aug 2018 10:59:02 -0700 (PDT)
Date:   Thu, 02 Aug 2018 10:59:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3b1570572779079@google.com>
Subject: KASAN: use-after-free Read in bpf_cgroup_storage_release
From:   syzbot <syzbot+25554ab865a12b51c66f@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fc2a3b5dd618 Merge branch 'bpf-cgroup-local-storage'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17a6a1c8400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bfcc1651962483
dashboard link: https://syzkaller.appspot.com/bug?extid=25554ab865a12b51c66f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12c4b9b4400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e9d6f0400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+25554ab865a12b51c66f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in debug_spin_lock_before  
kernel/locking/spinlock_debug.c:83 [inline]
BUG: KASAN: use-after-free in do_raw_spin_lock+0x1c0/0x200  
kernel/locking/spinlock_debug.c:112
Read of size 4 at addr ffff8801c4723644 by task syz-executor865/9746

CPU: 0 PID: 9746 Comm: syz-executor865 Not tainted 4.18.0-rc5+ #68
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
  do_raw_spin_lock+0x1c0/0x200 kernel/locking/spinlock_debug.c:112
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:136 [inline]
  _raw_spin_lock_bh+0x39/0x40 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:315 [inline]
  bpf_cgroup_storage_release+0x2c/0x110 kernel/bpf/local_storage.c:276
  free_used_maps+0x81/0x200 kernel/bpf/syscall.c:961
  bpf_prog_load+0x17ba/0x1c90 kernel/bpf/syscall.c:1414
  __do_sys_bpf kernel/bpf/syscall.c:2338 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2300 [inline]
  __x64_sys_bpf+0x36c/0x510 kernel/bpf/syscall.c:2300
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4490d9
Code: e8 8c bb 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4b 00 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6096d1ace8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000006e5a08 RCX: 00000000004490d9
RDX: 0000000000000048 RSI: 000000002001a840 RDI: 0000000000000005
RBP: 00000000006e5a00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e5a0c
R13: 00007fffd579e24f R14: 00007f6096d1b9c0 R15: 0000000000000019

Allocated by task 9746:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_node_trace+0x150/0x770 mm/slab.c:3663
  kmalloc_node include/linux/slab.h:551 [inline]
  cgroup_storage_map_alloc+0x26d/0x400 kernel/bpf/local_storage.c:209
  find_and_alloc_map kernel/bpf/syscall.c:129 [inline]
  map_create+0x37f/0xe20 kernel/bpf/syscall.c:481
  __do_sys_bpf kernel/bpf/syscall.c:2323 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2300 [inline]
  __x64_sys_bpf+0x303/0x510 kernel/bpf/syscall.c:2300
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 19:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  cgroup_storage_map_free+0x16e/0x210 kernel/bpf/local_storage.c:234
  bpf_map_free_deferred+0xba/0xf0 kernel/bpf/syscall.c:290
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

The buggy address belongs to the object at ffff8801c4723540
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 260 bytes inside of
  512-byte region [ffff8801c4723540, ffff8801c4723740)
The buggy address belongs to the page:
page:ffffea000711c8c0 count:1 mapcount:0 mapping:ffff8801dac00940  
index:0xffff8801c4723a40
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0007299088 ffffea00072247c8 ffff8801dac00940
raw: ffff8801c4723a40 ffff8801c4723040 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c4723500: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
  ffff8801c4723580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801c4723600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                            ^
  ffff8801c4723680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c4723700: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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
