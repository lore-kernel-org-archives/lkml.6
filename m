Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5C5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA512075B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbfABLCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:02:04 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:48186 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbfABLCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:02:04 -0500
Received: by mail-io1-f69.google.com with SMTP id s3so30107532iob.15
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 03:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=am9rJFM0I+ccym52GJ62I79rn0afbZ9ZbMv3LfedKmY=;
        b=SxlKE4/sr2pdnC596wOCXaMkzqAputdt+fssWH86sRBTGLRTwvgpeayvX2bKuyO6tK
         RUC4Ei55dWT4HokBlKquvkI8p4VWfiQo4qidHqoDCa1+Vxcu0e6Mp2RvlNjB+N/9xeON
         XPNiVTee7SqQ1KDANeNJoPHAMQDq0+YEUIw46xIEETr2mjWDlyPGmCSAOOjfXUMd9H4q
         RSfyYlSAxYL0xAvsX/+k1Iagn+KrSTEeRsuJP7vEbD2RDKggewV1ykJWnIVl6B8ouzv9
         thERyoHKtZl6sBoktY/duzC/JNADB54jito3R96+FXhPJ7xGrm48NPb4jtN6L5UERBDV
         QsoQ==
X-Gm-Message-State: AJcUukeZSdVjqFwb4TNESjWEc1NnaVTugehvUmy8IzhXr8B4YgOp4s/Y
        De0dWy1SEgtMsYwohZ6XBdnhB5fgsCTA+Vj5/Y/2deJs48lE
X-Google-Smtp-Source: ALg8bN7pe+EHdgtOMHAOTb34HX8olHyMYGH8SKwJnQz/fkdtskiSUdUwF9M2jrFx8NoLBHCIa8B1M9BKYRDkE4kVghXmteLw0pmg
MIME-Version: 1.0
X-Received: by 2002:a5e:a913:: with SMTP id c19mr20993136iod.32.1546426923276;
 Wed, 02 Jan 2019 03:02:03 -0800 (PST)
Date:   Wed, 02 Jan 2019 03:02:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ee231057e779375@google.com>
Subject: KASAN: use-after-free Read in x25_write_internal
From:   syzbot <syzbot+426b913e690764e50c83@syzkaller.appspotmail.com>
To:     andrew.hendry@gmail.com, anto.cardace@gmail.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-x25@vger.kernel.org, netdev@vger.kernel.org,
        stephen@networkplumber.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7418e6520f22 isdn: hisax: hfc_pci: Fix a possible concurre..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=137658e7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbee5876573727cd
dashboard link: https://syzkaller.appspot.com/bug?extid=426b913e690764e50c83
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+426b913e690764e50c83@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in x25_write_internal+0xded/0xef0  
net/x25/x25_subr.c:173
Read of size 4 at addr ffff8880923f6bdc by task syz-executor1/30378

CPU: 0 PID: 30378 Comm: syz-executor1 Not tainted 4.20.0+ #252
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  x25_write_internal+0xded/0xef0 net/x25/x25_subr.c:173
  x25_release+0x1f8/0x350 net/x25/af_x25.c:660
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1141
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  get_signal+0x1558/0x1980 kernel/signal.c:2347
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4579b9
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f959bdb5c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffe00 RBX: 0000000000000003 RCX: 00000000004579b9
RDX: 0000000000000012 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f959bdb66d4
R13: 00000000004be22e R14: 00000000004ce488 R15: 00000000ffffffff

Allocated by task 12427:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  x25_link_device_up+0xb2/0x500 net/x25/x25_link.c:249
  x25_device_event+0x116/0x2b0 net/x25/af_x25.c:242
  notifier_call_chain+0x17e/0x380 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1739
  call_netdevice_notifiers_extack net/core/dev.c:1751 [inline]
  call_netdevice_notifiers net/core/dev.c:1765 [inline]
  __dev_notify_flags+0x17a/0x480 net/core/dev.c:7605
  dev_change_flags+0x109/0x160 net/core/dev.c:7643
  dev_ifsioc+0x7da/0xa80 net/core/dev_ioctl.c:237
  dev_ioctl+0x1b5/0xcc0 net/core/dev_ioctl.c:488
  sock_do_ioctl+0x1f6/0x420 net/socket.c:973
  sock_ioctl+0x313/0x690 net/socket.c:1074
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 30378:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  x25_neigh_put include/net/x25.h:253 [inline]
  x25_connect+0xc67/0x1050 net/x25/af_x25.c:823
  __sys_connect+0x37d/0x4c0 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1672
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880923f6bc0
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 28 bytes inside of
  256-byte region [ffff8880923f6bc0, ffff8880923f6cc0)
The buggy address belongs to the page:
page:ffffea000248fd80 count:1 mapcount:0 mapping:ffff88812c3f07c0 index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00023d4748 ffffea000267af08 ffff88812c3f07c0
raw: 0000000000000000 ffff8880923f6080 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880923f6a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880923f6b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8880923f6b80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                     ^
  ffff8880923f6c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880923f6c80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
