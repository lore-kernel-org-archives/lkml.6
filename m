Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74340ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F3020673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F3020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeGTAEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:04:23 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:42799 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbeGTAEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:04:23 -0400
Received: by mail-it0-f72.google.com with SMTP id p21-v6so7361088itc.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 16:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EBPgTsWP65PxgfcpcAOJjQgVsR4d1WmmAa61v6Ldkvk=;
        b=Dl8PPcgLRyMchNb1+hzDqQyYWrMoehPrsrNePAHocoYzHrxFXJmKWII6KyaFziahQt
         xK3XZI/BtaHvKUVd688mxgRJGgKomUC5s6vfGbI4/lrX4A2ydBuFDASot4GM3F6CTmOx
         fXq4PpIL6fxkS3wjBYwL62HgComCIiPV2ObT8Ouoo7uozcfVLvkg8LJ3je0by3Jif3uB
         HtStUMzBgrLnpFJyG3FuDd4AfHsDtMPzkwLhzv3WBEp0F556KshVfxeNzNbDlgvIh8Kd
         3VE12T89fA2ug591Z+MjIKYOEuJJlZiJELLfjSaiDTuc4EcZ48U92/vqtJ4q1jmofzrQ
         iL0w==
X-Gm-Message-State: AOUpUlE0cHF9v/DsGEcLgR7xK/AhS7wUdFj5zMX3PLkJiPpCLrBQBNKd
        vMzmdgMqqQtjLBe/bAeF9Ie/ndqF1dd2NTBDiogZcSUiLEww
X-Google-Smtp-Source: AAOMgpfNd60sHsYlP22ot7WG5XO7wd48ArrK1c9C7/fkwWt+qRAQAJM04p98GZKWj5kWSm83diMm6fGf4ADyiKh0AoMwYBvI+EsH
MIME-Version: 1.0
X-Received: by 2002:a24:646:: with SMTP id 67-v6mr29033itv.54.1532042342476;
 Thu, 19 Jul 2018 16:19:02 -0700 (PDT)
Date:   Thu, 19 Jul 2018 16:19:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ab6cf0571626794@google.com>
Subject: KASAN: use-after-free Read in _copy_from_iter
From:   syzbot <syzbot+467050c1ce275af2a5b8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1c34981993da Add linux-next specific files for 20180719
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1658732c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7002497517b09aec
dashboard link: https://syzkaller.appspot.com/bug?extid=467050c1ce275af2a5b8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15983b68400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13dc4d1c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+467050c1ce275af2a5b8@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: use-after-free in memcpy include/linux/string.h:345 [inline]
BUG: KASAN: use-after-free in _copy_from_iter+0x9ea/0x1090  
lib/iov_iter.c:701
Read of size 21 at addr ffff8801abd90360 by task kworker/0:2/2142

CPU: 0 PID: 2142 Comm: kworker/0:2 Not tainted 4.18.0-rc5-next-20180719+ #11
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events p9_write_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  memcpy+0x23/0x50 mm/kasan/kasan.c:302
  memcpy include/linux/string.h:345 [inline]
  _copy_from_iter+0x9ea/0x1090 lib/iov_iter.c:701
  copy_page_from_iter+0x576/0x890 lib/iov_iter.c:857
  pipe_write+0x235/0xeb0 fs/pipe.c:429
  call_write_iter include/linux/fs.h:1826 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6af/0x9d0 fs/read_write.c:487
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  kernel_write+0xab/0x120 fs/read_write.c:526
  p9_fd_write net/9p/trans_fd.c:427 [inline]
  p9_write_work+0x6f1/0xd50 net/9p/trans_fd.c:476
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415

Allocated by task 4465:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc+0x14e/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  p9_fcall_alloc+0x1e/0x90 net/9p/client.c:237
  p9_tag_alloc net/9p/client.c:266 [inline]
  p9_client_prepare_req.part.8+0x107/0xa00 net/9p/client.c:640
  p9_client_prepare_req net/9p/client.c:675 [inline]
  p9_client_rpc+0x242/0x1330 net/9p/client.c:675
  p9_client_version net/9p/client.c:890 [inline]
  p9_client_create+0xca4/0x1537 net/9p/client.c:974
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  legacy_get_tree+0x131/0x460 fs/fs_context.c:674
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1743
  do_new_mount fs/namespace.c:2603 [inline]
  do_mount+0x6f2/0x1e20 fs/namespace.c:2927
  ksys_mount+0x12d/0x140 fs/namespace.c:3143
  __do_sys_mount fs/namespace.c:3157 [inline]
  __se_sys_mount fs/namespace.c:3154 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3154
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4465:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  p9_free_req+0xb5/0x120 net/9p/client.c:338
  p9_client_rpc+0xa8e/0x1330 net/9p/client.c:739
  p9_client_version net/9p/client.c:890 [inline]
  p9_client_create+0xca4/0x1537 net/9p/client.c:974
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  legacy_get_tree+0x131/0x460 fs/fs_context.c:674
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1743
  do_new_mount fs/namespace.c:2603 [inline]
  do_mount+0x6f2/0x1e20 fs/namespace.c:2927
  ksys_mount+0x12d/0x140 fs/namespace.c:3143
  __do_sys_mount fs/namespace.c:3157 [inline]
  __se_sys_mount fs/namespace.c:3154 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3154
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801abd90340
  which belongs to the cache kmalloc-16384 of size 16384
The buggy address is located 32 bytes inside of
  16384-byte region [ffff8801abd90340, ffff8801abd94340)
The buggy address belongs to the page:
page:ffffea0006af6400 count:1 mapcount:0 mapping:ffff8801da802200 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0006c75e08 ffffea0006afaa08 ffff8801da802200
raw: 0000000000000000 ffff8801abd90340 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801abd90200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801abd90280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801abd90300: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                        ^
  ffff8801abd90380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801abd90400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
