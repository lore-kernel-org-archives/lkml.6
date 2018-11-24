Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E3BC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 18:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6400205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 18:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6400205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeKYFTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 00:19:03 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:41723 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeKYFTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 00:19:03 -0500
Received: by mail-it1-f200.google.com with SMTP id 123so17562373itv.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 10:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FjQiOwTynuja1xkXqZK0/dGlK4ms7Bd6o2e7c1CaR8E=;
        b=BRUG9Cjucyzi5jZE+wULly3rAX7dv+QRygA2dscI5dWBnTK5r/AZb+awG+nkFUUFdP
         QaE7ZJsLcslrfO5y1mAUr0RpyQ9tJeMC/Z917NJfK+t7rGyEeSfqqZFLz6RTbHrxZWvG
         mKerOf90xEGy5iGB3ftHEZb3PRVE41LTk8T3GDsyjlNZ5bpqT/rDKrnlnALc1i+ibNoP
         Ig8BKIsTy7lu06M9F3T7S/3I5Ayqj/UnBM2fHPrycgoEw4IZBpr68TTEXzt4nOzfzKEg
         Z6QGIbWzpzyN7cuwCqTFzl+DCFRIndNaWZN2uQh1KBsfVj49giyKi61OAcv89EIx5+uk
         ZodQ==
X-Gm-Message-State: AA+aEWb7y2RQI95SozlU6vnKoGCAxZ5T+7POGlg3I+91wxivEfNlfsX8
        LIZnSdurMy0ylui/ljgsgqPu2S3OZlynvo2y4hndQStzHmrY
X-Google-Smtp-Source: AFSGD/WgS45sB2Zo7WvdBDnmXNLjHWuROZgDyPTQtHZlFiPqAHdLEHehBBGYl1fo+mMRSRYW3N3CFX7xGlCcxNwFtC+IYyCSxURB
MIME-Version: 1.0
X-Received: by 2002:a5e:a61a:: with SMTP id q26mr12523946ioi.29.1543084203126;
 Sat, 24 Nov 2018 10:30:03 -0800 (PST)
Date:   Sat, 24 Nov 2018 10:30:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c93833057b6d496a@google.com>
Subject: KASAN: slab-out-of-bounds Read in default_write_copy_kernel
From:   syzbot <syzbot+d4503ae45b65c5bc1194@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com,
        linux-kernel@vger.kernel.org, o-takashi@sakamocchi.jp,
        pasqualirb@gmail.com, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        twischer@de.adit-jv.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7c98a4261827 Merge tag 'ceph-for-4.20-rc4' of https://gith..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142c8893400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=d4503ae45b65c5bc1194
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1789354d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162ebe2b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d4503ae45b65c5bc1194@syzkaller.appspotmail.com

RDX: 0000000056da83a0 RSI: 00000000200000c0 RDI: 0000000000000004
RBP: 00000000006cf018 R08: 0000000000000001 R09: 0000000000000037
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:352 [inline]
BUG: KASAN: slab-out-of-bounds in default_write_copy_kernel+0xe1/0x140  
sound/core/pcm_lib.c:1946
Read of size 64 at addr ffff8881cee03c40 by task syz-executor636/6021

CPU: 1 PID: 6021 Comm: syz-executor636 Not tainted 4.20.0-rc3+ #347
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  memcpy+0x23/0x50 mm/kasan/kasan.c:302
  memcpy include/linux/string.h:352 [inline]
  default_write_copy_kernel+0xe1/0x140 sound/core/pcm_lib.c:1946
  interleaved_copy+0xd1/0x110 sound/core/pcm_lib.c:2007
  __snd_pcm_lib_xfer+0x115f/0x1f23 sound/core/pcm_lib.c:2227
  snd_pcm_oss_write3+0xe9/0x220 sound/core/oss/pcm_oss.c:1237
  io_playback_transfer+0x27d/0x310 sound/core/oss/io.c:47
  snd_pcm_plug_write_transfer+0x374/0x490 sound/core/oss/pcm_plugin.c:620
  snd_pcm_oss_write2+0x25d/0x450 sound/core/oss/pcm_oss.c:1366
  snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1432 [inline]
  snd_pcm_oss_write+0x567/0xa60 sound/core/oss/pcm_oss.c:2775
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444119
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdf4510538 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444119
RDX: 0000000056da83a0 RSI: 00000000200000c0 RDI: 0000000000000004
RBP: 00000000006cf018 R08: 0000000000000001 R09: 0000000000000037
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6021:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3684 [inline]
  __kmalloc_node+0x50/0x70 mm/slab.c:3691
  kmalloc_node include/linux/slab.h:589 [inline]
  kvmalloc_node+0x65/0xf0 mm/util.c:416
  kvmalloc include/linux/mm.h:577 [inline]
  kvzalloc include/linux/mm.h:585 [inline]
  snd_pcm_plugin_alloc+0x577/0x770 sound/core/oss/pcm_plugin.c:70
  snd_pcm_plug_alloc+0x218/0x340 sound/core/oss/pcm_plugin.c:117
  snd_pcm_oss_change_params_locked+0x2209/0x3c60  
sound/core/oss/pcm_oss.c:1038
  snd_pcm_oss_make_ready_locked+0xbc/0x130 sound/core/oss/pcm_oss.c:1183
  snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1397 [inline]
  snd_pcm_oss_write+0x51e/0xa60 sound/core/oss/pcm_oss.c:2775
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2446:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  blk_mq_hw_sysfs_release+0x42/0x60 block/blk-mq-sysfs.c:25
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:70 [inline]
  kobject_put.cold.9+0x287/0x2e4 lib/kobject.c:708
  blk_mq_release+0xf2/0x210 block/blk-mq.c:2478
  __blk_release_queue+0x228/0x510 block/blk-sysfs.c:862
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881cee03c40
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
  32-byte region [ffff8881cee03c40, ffff8881cee03c60)
The buggy address belongs to the page:
page:ffffea00073b80c0 count:1 mapcount:0 mapping:ffff8881da8001c0  
index:0xffff8881cee03fc1
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea0007433308 ffff8881da801248 ffff8881da8001c0
raw: ffff8881cee03fc1 ffff8881cee03000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881cee03b00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8881cee03b80: fb fb fb fb fc fc fc fc 00 fc fc fc fc fc fc fc
> ffff8881cee03c00: fb fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
                                                        ^
  ffff8881cee03c80: 00 00 fc fc fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8881cee03d00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
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
