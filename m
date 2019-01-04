Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF86C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4B42184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfADJqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:46:04 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:54233 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfADJqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:46:04 -0500
Received: by mail-it1-f200.google.com with SMTP id i12so549970ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 01:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=a3DMV1clYHpY3RXXWGtCPAX+8A23FuVFl51zxnc57NI=;
        b=mP9UTNBJVVbgPzN1rZKkWoVzWJN06kljaiEHDOnbSUSAixrHH+5xZa/D6NIymaN7QP
         hdH5RapNJAsiDCsEe3NgoRxYEFljOBeik8wuRzcohAk5cTb2FziZEAl4/BXPRpYxXAu/
         JsWG4feK68HOZWViwTdQHISPo4+knTzP6EFKUU0ODzeFZg54C5LZ2nkWl0XsfJznP+8f
         8nM37D+xLwrqyh0EWNQHJGVkQgrZPju9q6WKUYrAonN1nAMLiqbzXPbAZJ4vBAP4uYhE
         TwdIcIuIZiHCgY9yrCUBgezFoyB2B8GOfaKGFJSvNI5lMtr1IAyb3FN8GOWqurz/C+LQ
         Vbew==
X-Gm-Message-State: AJcUukc/zFumtW52XWkFdBEb4bRxOsvZRMcKtH3gLh8E3dqIpT9pLUAk
        k+PMHJIYDmdMe+Fj/FWbxlkCziznc6w/RWecYuG5KBr650Wb
X-Google-Smtp-Source: ALg8bN5rMM7PO2deYAQIYpr8nEu1hDXnj0SJowJcuNkyKni9/yClHe0xml1ugnSRnpJWRSXpUtHgyvjIYWO+0Jv1ELxsKlHEm3sz
MIME-Version: 1.0
X-Received: by 2002:a6b:680a:: with SMTP id d10mr30523857ioc.35.1546595162720;
 Fri, 04 Jan 2019 01:46:02 -0800 (PST)
Date:   Fri, 04 Jan 2019 01:46:02 -0800
In-Reply-To: <000000000000a980e3057896e9df@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000491298057e9ebf6e@google.com>
Subject: Re: KASAN: use-after-free Read in kobject_put
From:   syzbot <syzbot+fdc00003f4efff43bc5b@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    645ff1e8e704 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172cee4b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
dashboard link: https://syzkaller.appspot.com/bug?extid=fdc00003f4efff43bc5b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d603e7400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10786f77400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fdc00003f4efff43bc5b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in kobject_put+0xca/0xe0 lib/kobject.c:704
Read of size 1 at addr ffff88808f9e9ecc by task syz-executor111/8699

CPU: 1 PID: 8699 Comm: syz-executor111 Not tainted 4.20.0+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  kobject_put+0xca/0xe0 lib/kobject.c:704
  put_device+0x20/0x30 drivers/base/core.c:2060
  hci_free_dev+0x19/0x20 net/bluetooth/hci_core.c:3208
  vhci_release+0x7e/0xf0 drivers/bluetooth/hci_vhci.c:355
  __fput+0x3c5/0xb10 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4054f1
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 94 17 00 00 c3 48  
83 ec 08 e8 6a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 b3 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffeb26e56e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00000000004054f1
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 000000037ffffa00 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000293 R12: 00000000006dbc2c
R13: 20c49ba5e353f7cf R14: 000000000000002d R15: 0000000000000005

Allocated by task 8707:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc mm/kasan/common.c:482 [inline]
  kasan_kmalloc+0xcf/0xe0 mm/kasan/common.c:455
  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3607
  kmalloc include/linux/slab.h:545 [inline]
  kzalloc include/linux/slab.h:740 [inline]
  hci_alloc_dev+0x148/0x21a0 net/bluetooth/hci_core.c:3116
  __vhci_create_device+0x101/0x5a0 drivers/bluetooth/hci_vhci.c:114
  vhci_create_device drivers/bluetooth/hci_vhci.c:163 [inline]
  vhci_get_user drivers/bluetooth/hci_vhci.c:219 [inline]
  vhci_write+0x2d0/0x470 drivers/bluetooth/hci_vhci.c:299
  call_write_iter include/linux/fs.h:1862 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x764/0xb40 fs/read_write.c:487
  vfs_write+0x20c/0x580 fs/read_write.c:549
  ksys_write+0x105/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8699:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kfree+0xcf/0x230 mm/slab.c:3804
  bt_host_release+0x19/0x30 net/bluetooth/hci_sysfs.c:86
  device_release+0x7d/0x210 drivers/base/core.c:919
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put.cold+0x28f/0x2ec lib/kobject.c:708
  put_device+0x20/0x30 drivers/base/core.c:2060
  hci_dev_put include/net/bluetooth/hci_core.h:1014 [inline]
  hci_unregister_dev+0x716/0x980 net/bluetooth/hci_core.c:3379
  vhci_release+0x76/0xf0 drivers/bluetooth/hci_vhci.c:354
  __fput+0x3c5/0xb10 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88808f9e8e00
  which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 4300 bytes inside of
  8192-byte region [ffff88808f9e8e00, ffff88808f9eae00)
The buggy address belongs to the page:
page:ffffea00023e7a00 count:1 mapcount:0 mapping:ffff88812c3f2080 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00023e6808 ffffea00023e8408 ffff88812c3f2080
raw: 0000000000000000 ffff88808f9e8e00 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected
kobject: 'rfkill468' (000000007192bbb6): kobject_cleanup, parent            
(null)

Memory state around the buggy address:
  ffff88808f9e9d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808f9e9e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88808f9e9e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                               ^
  ffff88808f9e9f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808f9e9f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
kobject: 'rfkill471' (00000000171c66a4): kobject_add_internal:  
parent: 'hci2', set: 'devices'
kobject: 'rfkill471' (00000000171c66a4): kobject_uevent_env
kobject: 'hci6' (00000000cea6c5b0): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci6'
kobject: 'hci5' (00000000d9130f82): kobject_uevent_env
kobject: 'rfkill468' (000000007192bbb6): calling ktype release
kobject: 'hci5' (00000000d9130f82): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci5'
kobject: 'rfkill468': free name
kobject: 'rfkill471' (00000000171c66a4): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci2/rfkill471'
kobject: 'hci1' (000000006eef9329): kobject_uevent_env
kobject: 'rfkill472' (000000003d2f7a84): kobject_add_internal:  
parent: 'hci0', set: 'devices'
kobject: 'hci1' (000000006eef9329): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci1'
kobject: 'rfkill469' (0000000043e5b34a): kobject_uevent_env
kobject: 'hci1' (000000006eef9329): kobject_cleanup, parent           (null)
kobject: 'rfkill469' (0000000043e5b34a): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci3/rfkill469'
kobject: 'hci1' (000000006eef9329): calling ktype release
kobject: 'rfkill472' (000000003d2f7a84): kobject_uevent_env
kobject: 'rfkill470' (00000000155e553b): kobject_uevent_env
kobject: 'rfkill472' (000000003d2f7a84): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci0/rfkill472'
kobject: 'rfkill470' (00000000155e553b): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci4/rfkill470'
kobject: 'rfkill473' (0000000082665f74): kobject_add_internal:  
parent: 'hci6', set: 'devices'
kobject: 'hci1': free name
kobject: 'rfkill473' (0000000082665f74): kobject_uevent_env
kobject: 'hci1' (00000000a68c12d6): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
kobject: 'rfkill472' (000000003d2f7a84): kobject_uevent_env
kobject: 'hci1' (00000000a68c12d6): kobject_uevent_env
kobject: 'rfkill472' (000000003d2f7a84): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci0/rfkill472'
kobject: 'hci1' (00000000a68c12d6): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci1'
kobject: 'rfkill473' (0000000082665f74): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci6/rfkill473'

