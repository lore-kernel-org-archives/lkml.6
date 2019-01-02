Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D655CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61A7206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfABJjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:39:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:59352 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbfABJjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:39:05 -0500
Received: by mail-it1-f198.google.com with SMTP id p21so32672523itb.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 01:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PXrcp1EiYzGOHfusimKKlJ85byl4wgam4Ym7PLIZQY4=;
        b=f7ZBSoCb3t8P/dXZ9NipatM7C2PpVta/WnFsKQ1lDGcq/iCye8WH1e7iwzpRMuABgY
         f+zauWDZQuAKADwLVontqCpwj6rsmyJI91bEO1aABgx0mzxCNBEzLkmfXsJ7VDb4PuDt
         q9Ca8FF9jLbkTzJYLAuwrPGLFH+KmEqwezndIf9jW63ghjBIBmy6tjzirWDP5WWQiUBI
         MeE+q4etsFuCqIqCdjQp4LA83FafHFgRQchLHS1MZKz2N8x2jJm/NZCRFM5p7HmLY/3q
         UXEh8NDLdOjYbzX5Tp7H8iLgwMdJ/LuK9ZwsoUoffO0t5OA573B5ULoydwwPa8FLHy3y
         Hs1Q==
X-Gm-Message-State: AJcUukc16zTgRXg5jti0B3NbyhDxrNMdCAVFD8c8PyWeHveSu92gPtwU
        lroAV5H4/PmfkdliI95baX9drhjDyNoemvb5SjOxYUJblv0u
X-Google-Smtp-Source: ALg8bN53QepVnXfS0CE4UdTRzdJJPuZzJTlP8m+SGbyWnkMEjdzjyNkikcTlR2MAE2x9tAfmOilu+ZCmbVUC1RadTyjtZ/j2r1wj
MIME-Version: 1.0
X-Received: by 2002:a5d:9057:: with SMTP id v23mr3620833ioq.6.1546421943865;
 Wed, 02 Jan 2019 01:39:03 -0800 (PST)
Date:   Wed, 02 Jan 2019 01:39:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a317f3057e766a0a@google.com>
Subject: KASAN: use-after-free Read in dev_expire_timer
From:   syzbot <syzbot+7ea31f54ecacb8f68330@syzkaller.appspotmail.com>
To:     isdn@linux-pingi.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    28e8c4bc8eb4 Merge tag 'rtc-4.21' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11eceee7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2ab9708c613a224
dashboard link: https://syzkaller.appspot.com/bug?extid=7ea31f54ecacb8f68330
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7ea31f54ecacb8f68330@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in dev_expire_timer+0x414/0x570  
drivers/isdn/mISDN/timerdev.c:174
Read of size 8 at addr ffff88809fd76cd0 by task syz-executor1/18425

CPU: 1 PID: 18425 Comm: syz-executor1 Not tainted 4.20.0+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  dev_expire_timer+0x414/0x570 drivers/isdn/mISDN/timerdev.c:174
  call_timer_fn+0x254/0x900 kernel/time/timer.c:1325
  expire_timers kernel/time/timer.c:1362 [inline]
  __run_timers+0x6fc/0xd50 kernel/time/timer.c:1681
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1b7/0x760 arch/x86/kernel/apic/apic.c:1062
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:memset_erms+0x9/0x10 arch/x86/lib/memset_64.S:66
Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48  
ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8  
c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
RSP: 0000:ffff8880531e7118 EFLAGS: 00010206 ORIG_RAX: ffffffffffffff13
RAX: 1ffff11007b40000 RBX: ffffed1007b40000 RCX: 0000000000005e40
RDX: 0000000000040000 RSI: 0000000000000000 RDI: ffffed1007b3a1c0
RBP: ffff8880531e7130 R08: ffff88805a594600 R09: ffffed1007b00000
R10: fffff940001ec006 R11: ffffea0000f60037 R12: 0000000000200000
R13: dffffc0000000000 R14: dffffc0000000000 R15: dffffc0000000000
  kasan_alloc_pages+0x38/0x40 mm/kasan/common.c:233
  post_alloc_hook mm/page_alloc.c:1949 [inline]
  prep_new_page mm/page_alloc.c:1958 [inline]
  get_page_from_freelist+0xc7f/0x5190 mm/page_alloc.c:3494
  __alloc_pages_nodemask+0x4fd/0xdc0 mm/page_alloc.c:4529
  __alloc_pages include/linux/gfp.h:473 [inline]
  __alloc_pages_node include/linux/gfp.h:486 [inline]
  alloc_pages_vma+0x39a/0x540 mm/mempolicy.c:2062
  do_huge_pmd_anonymous_page+0x53a/0x1840 mm/huge_memory.c:738
  create_huge_pmd mm/memory.c:3657 [inline]
  __handle_mm_fault+0x38e7/0x5690 mm/memory.c:3861
  handle_mm_fault+0x4ec/0xc80 mm/memory.c:3927
  do_user_addr_fault arch/x86/mm/fault.c:1475 [inline]
  __do_page_fault+0x5da/0xd60 arch/x86/mm/fault.c:1541
  do_page_fault+0xe6/0x7d8 arch/x86/mm/fault.c:1572
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1143
RIP: 0033:0x43f1c1
Code: 8d 15 23 54 0a 00 8b 0c 8a 8b 04 82 29 c8 c3 66 2e 0f 1f 84 00 00 00  
00 00 48 83 fa 20 48 89 f8 73 77 f6 c2 01 74 0b 0f b6 0e <88> 0f 48 ff c6  
48 ff c7 f6 c2 02 74 12 0f b7 0e 66 89 0f 48 83 c6
RSP: 002b:00007ffcf3a17428 EFLAGS: 00010202
RAX: 0000000020042000 RBX: 0000000000000003 RCX: 000000000000002f
RDX: 000000000000000d RSI: 0000000000740020 RDI: 0000000020042000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000004
R10: 0000000000000075 R11: 0000000000000246 R12: 0000000000000000
R13: fffffffffffffffe R14: 000000000000005c R15: 0000000000000001

Allocated by task 18426:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc mm/kasan/common.c:482 [inline]
  kasan_kmalloc+0xcf/0xe0 mm/kasan/common.c:455
  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3607
  kmalloc include/linux/slab.h:545 [inline]
  kzalloc include/linux/slab.h:740 [inline]
  misdn_add_timer drivers/isdn/mISDN/timerdev.c:188 [inline]
  mISDN_ioctl+0x544/0xc40 drivers/isdn/mISDN/timerdev.c:242
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 18423:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kfree+0xcf/0x230 mm/slab.c:3804
  mISDN_close+0x375/0x530 drivers/isdn/mISDN/timerdev.c:95
  __fput+0x3c5/0xb10 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88809fd76cc0
  which belongs to the cache kmalloc-128 of size 128
The buggy address is located 16 bytes inside of
  128-byte region [ffff88809fd76cc0, ffff88809fd76d40)
The buggy address belongs to the page:
page:ffffea00027f5d80 count:1 mapcount:0 mapping:ffff88812c3f0640 index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea000279f148 ffffea00026e6788 ffff88812c3f0640
raw: 0000000000000000 ffff88809fd76000 0000000100000015 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809fd76b80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff88809fd76c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88809fd76c80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                  ^
  ffff88809fd76d00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff88809fd76d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
