Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC72C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F13B2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F13B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbeKPDqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:46:49 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:54054 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeKPDqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:46:49 -0500
Received: by mail-it1-f199.google.com with SMTP id i12so336250ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 09:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6hBDVL+RHIE9nwL3xaVGtjeBi3NFm3e5Jz3xtzl+mo0=;
        b=Xaz7wuJOkF2wMQUYlVr6D30AzYiw9hSypnjHtm43VS0enMYdnEiaL1xv6kNBWDSwjh
         /TvaTCJ0rRs+6pJm12rupAPv9VkMEpBGHeR0atVu4aIhsKvaB60saa9KCn5063oaUPBN
         7ODbcP2lFRbW+l5SQ0uLEDMjWzyj/kKU0/sKxNe2VbGw9ak84v9BqpkbFrHYNRVdjBCK
         VyvFc55+uLpYzNmeg4PrQRWWyxCYGUBCiKOWjv+mFaWPZGyuf5gFGvSRYy/nA9MN3ijn
         OBgeH4Dy9f0n1SM/RGRtCHvK7WLfDLY2WoqqFV+thyNHjsk2WcCq6pGDopSx4vAwNZlb
         1kDw==
X-Gm-Message-State: AA+aEWY2DP3+nRoIa6bgZQof4k7f/2vtbC2FKqhbwYtWv8wNUbtmGyrp
        68YPz5jOqCxscBJxvlXPV0XL+ddYxIaS8TZuYdTciTqcVPob
X-Google-Smtp-Source: AFSGD/VfeXnw9+rIXR1ainBhihxxFnmM+YzvgK5IquxosYkC3/mNarXstqhKGDyHUo6b9DRwCo9uqpNy60kgfO8PyxFU1eaKgMbH
MIME-Version: 1.0
X-Received: by 2002:a6b:d80d:: with SMTP id y13-v6mr992431iob.23.1542303483509;
 Thu, 15 Nov 2018 09:38:03 -0800 (PST)
Date:   Thu, 15 Nov 2018 09:38:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004550b5057ab7831a@google.com>
Subject: KASAN: use-after-free Read in snd_ctl_elem_add
From:   syzbot <syzbot+dc09047bce3820621ba2@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        o-takashi@sakamocchi.jp, perex@perex.cz, rf@opensource.cirrus.com,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ccda4af0f4b9 Linux 4.20-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139bbad5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=dc09047bce3820621ba2
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dc09047bce3820621ba2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in snd_ctl_get_ioff include/sound/control.h:164  
[inline]
BUG: KASAN: use-after-free in snd_ctl_elem_add+0x1210/0x14d0  
sound/core/control.c:1367
Read of size 4 at addr ffff8881780ba710 by task syz-executor1/10730

CPU: 0 PID: 10730 Comm: syz-executor1 Not tainted 4.20.0-rc2+ #112
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  snd_ctl_get_ioff include/sound/control.h:164 [inline]
  snd_ctl_elem_add+0x1210/0x14d0 sound/core/control.c:1367
  snd_ctl_elem_add_user+0xb8/0x170 sound/core/control.c:1392
  snd_ctl_ioctl+0x480/0x1110 sound/core/control.c:1568
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe6bc8bac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000020000080 RSI: 00000000c1105517 RDI: 0000000000000006
RBP: 000000000072c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe6bc8bb6d4
R13: 00000000004c8a70 R14: 00000000004d15d8 R15: 00000000ffffffff

Allocated by task 10730:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3722 [inline]
  __kmalloc+0x15b/0x760 mm/slab.c:3731
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  snd_ctl_new+0x5c/0x180 sound/core/control.c:223
  snd_ctl_elem_add+0x555/0x14d0 sound/core/control.c:1324
  snd_ctl_elem_add_user+0xb8/0x170 sound/core/control.c:1392
  snd_ctl_ioctl+0x480/0x1110 sound/core/control.c:1568
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 10728:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  snd_ctl_free_one+0x5d/0x70 sound/core/control.c:313
  snd_ctl_remove+0x43b/0x5a0 sound/core/control.c:504
  snd_ctl_remove_user_ctl+0x17d/0x240 sound/core/control.c:568
  snd_ctl_elem_remove sound/core/control.c:1410 [inline]
  snd_ctl_ioctl+0xb25/0x1110 sound/core/control.c:1572
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881780ba6c0
  which belongs to the cache kmalloc-16k of size 16384
The buggy address is located 80 bytes inside of
  16384-byte region [ffff8881780ba6c0, ffff8881780be6c0)
The buggy address belongs to the page:
page:ffffea0005e02e00 count:1 mapcount:0 mapping:ffff8881da802200 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea00068ce008 ffff8881da801c48 ffff8881da802200
raw: 0000000000000000 ffff8881780ba6c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881780ba600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881780ba680: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff8881780ba700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff8881780ba780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881780ba800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
kauditd_printk_skb: 174 callbacks suppressed
audit: type=1400 audit(1542205722.082:3119): avc:  denied  { map } for   
pid=10761 comm="blkid" path="/lib/x86_64-linux-gnu/libblkid.so.1.1.0"  
dev="sda1" ino=2825 scontext=system_u:system_r:kernel_t:s0  
tcontext=system_u:object_r:file_t:s0 tclass=file permissive=1
audit: type=1400 audit(1542205722.102:3121): avc:  denied  { map } for   
pid=10764 comm="modprobe" path="/lib/x86_64-linux-gnu/libkmod.so.2.1.3"  
dev="sda1" ino=2811 scontext=system_u:system_r:kernel_t:s0  
tcontext=system_u:object_r:file_t:s0 tclass=file permissive=1


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
