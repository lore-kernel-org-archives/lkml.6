Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECE6ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F07214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F07214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeIQQp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:45:56 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:40410 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeIQQp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:45:56 -0400
Received: by mail-it0-f72.google.com with SMTP id k143-v6so12664832ite.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 04:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BwunwHBQ/BoO8tBT64ECbYie1Cn/sfwmSJSsZsxLSPE=;
        b=RTzu/18GAvXpQ5xG8yGSUVcHf7zzeLU/WGXPFkIvjaTgdqFIL7q6SpQ/6OLL73gRvk
         r81ECdaeOInkgcpeqh2Bni51rXAt2ZapFPtf8CxLP3M2DVFnA5LNZL7C1jrDhBZLOnlz
         DRcQxS/FkW9VC0lFRelUD4y30aWyUy9xvBPgRjzuBMAVReyPHUsXW+kg+F09knaTetvn
         Lq4g2PIb8rnJXcUHPmYl9hvCMoPj6RbZzm4UI7d6YwLJjLo+a4300slIwI3WqmEMCLax
         qP+bm7xqyW6S7bRVKKfClSZFhyjRUVSezPCmmSWXbsPOkkvqvbyR2Smz3Tydp+qhkVGd
         Pl4g==
X-Gm-Message-State: APzg51DXaylniwAkbYXuymCgu4TikBrrY9zVjM327P1pRmn12XElE1/a
        JOKD3Dh4KlTdCzcomrIxKpi9kcKQuR+Fyl9Z791Mp/MvI+C8
X-Google-Smtp-Source: ANB0VdZqcXccGuoC3aFjAL9qRm5oKF0y8FNwy/URw3DxBkfwTYxmYsIuag1WcPMAvrMcFisjODFtkdRQSVUfxHEDOxGKyAqX4MTO
MIME-Version: 1.0
X-Received: by 2002:a6b:c786:: with SMTP id x128-v6mr18644880iof.1.1537183142627;
 Mon, 17 Sep 2018 04:19:02 -0700 (PDT)
Date:   Mon, 17 Sep 2018 04:19:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002be16c05760f576d@google.com>
Subject: KASAN: use-after-free Write in jbd2_log_do_checkpoint
From:   syzbot <syzbot+7f4a27091759e2fe7453@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2e2a0c961a87 Merge branch 'progarray_mapinmap_dump'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17622811400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=7f4a27091759e2fe7453
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7f4a27091759e2fe7453@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_inc  
include/asm-generic/atomic-instrumented.h:109 [inline]
BUG: KASAN: use-after-free in get_bh include/linux/buffer_head.h:283  
[inline]
BUG: KASAN: use-after-free in jbd2_log_do_checkpoint+0x113d/0x13e0  
fs/jbd2/checkpoint.c:337
Write of size 4 at addr ffff8801b6d96300 by task syz-executor1/904

CPU: 0 PID: 904 Comm: syz-executor1 Not tainted 4.19.0-rc2+ #94
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
  atomic_inc include/asm-generic/atomic-instrumented.h:109 [inline]
  get_bh include/linux/buffer_head.h:283 [inline]
  jbd2_log_do_checkpoint+0x113d/0x13e0 fs/jbd2/checkpoint.c:337
  jbd2_journal_flush+0x156/0x540 fs/jbd2/journal.c:2001
  ext4_ioctl+0x259f/0x4210 fs/ext4/ioctl.c:749
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4572d9
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3c1e090c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3c1e0916d4 RCX: 00000000004572d9
RDX: 00000000007fffff RSI: 0000000040086607 RDI: 0000000000000006
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d0080 R14: 00000000004bee80 R15: 0000000000000001

Allocated by task 900:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  kmem_cache_zalloc include/linux/slab.h:697 [inline]
  alloc_buffer_head+0x7c/0x1b0 fs/buffer.c:3360
  alloc_page_buffers+0x1cd/0x6b0 fs/buffer.c:829
  grow_dev_page fs/buffer.c:966 [inline]
  grow_buffers fs/buffer.c:1016 [inline]
  __getblk_slow fs/buffer.c:1043 [inline]
  __getblk_gfp+0x611/0xd50 fs/buffer.c:1320
  sb_getblk include/linux/buffer_head.h:325 [inline]
  ext4_read_block_bitmap_nowait+0x314/0x1f50 fs/ext4/balloc.c:427
  ext4_mb_init_cache+0x3b9/0x19d0 fs/ext4/mballoc.c:864
  ext4_mb_load_buddy_gfp+0xf48/0x1e70 fs/ext4/mballoc.c:1162
  ext4_mb_load_buddy fs/ext4/mballoc.c:1241 [inline]
  ext4_mb_regular_allocator+0x634/0x1590 fs/ext4/mballoc.c:2190
  ext4_mb_new_blocks+0x1de3/0x4840 fs/ext4/mballoc.c:4538
  ext4_ext_map_blocks+0x2f14/0x6330 fs/ext4/extents.c:4467
  ext4_map_blocks+0x8f7/0x1b50 fs/ext4/inode.c:636
  ext4_alloc_file_blocks+0x319/0xaf0 fs/ext4/extents.c:4694
  ext4_fallocate+0xa33/0x2300 fs/ext4/extents.c:4979
  vfs_fallocate+0x4b4/0x940 fs/open.c:308
  ioctl_preallocate+0x1e8/0x300 fs/ioctl.c:482
  file_ioctl fs/ioctl.c:498 [inline]
  do_vfs_ioctl+0x1435/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 897:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3756
  free_buffer_head+0xd8/0x190 fs/buffer.c:3375
  try_to_free_buffers+0x53a/0xc80 fs/buffer.c:3290
  jbd2_journal_try_to_free_buffers+0x5cb/0x810 fs/jbd2/transaction.c:2022
  bdev_try_to_free_page+0x129/0x1b0 fs/ext4/super.c:1194
  blkdev_releasepage+0xec/0x150 fs/block_dev.c:1949
  try_to_release_page+0x4dc/0x8d0 mm/filemap.c:3327
  shrink_page_list+0x7a17/0xc510 mm/vmscan.c:1406
  shrink_inactive_list+0x77b/0x1c60 mm/vmscan.c:1943
  shrink_list mm/vmscan.c:2254 [inline]
  shrink_node_memcg+0x78b/0x18e0 mm/vmscan.c:2517
  shrink_node+0x3bc/0x16b0 mm/vmscan.c:2732
  shrink_zones mm/vmscan.c:2964 [inline]
  do_try_to_free_pages+0x3e7/0x1290 mm/vmscan.c:3026
  try_to_free_mem_cgroup_pages+0x4bb/0xca0 mm/vmscan.c:3324
  reclaim_high.constprop.70+0x135/0x1e0 mm/memcontrol.c:2117
  mem_cgroup_handle_over_high+0x8d/0x130 mm/memcontrol.c:2142
  tracehook_notify_resume include/linux/tracehook.h:195 [inline]
  exit_to_usermode_loop+0x287/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode+0x342/0x3b0 arch/x86/entry/common.c:197
  retint_user+0x8/0x18

The buggy address belongs to the object at ffff8801b6d962a0
  which belongs to the cache buffer_head(65:syz1) of size 104
The buggy address is located 96 bytes inside of
  104-byte region [ffff8801b6d962a0, ffff8801b6d96308)
The buggy address belongs to the page:
page:ffffea0006db6580 count:1 mapcount:0 mapping:ffff8801cf4e79c0  
index:0xffff8801b6d96000
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0006455e08 ffffea0006456d48 ffff8801cf4e79c0
raw: ffff8801b6d96000 ffff8801b6d96000 0000000100000005 ffff8801a35dab80
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801a35dab80

Memory state around the buggy address:
  ffff8801b6d96200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801b6d96280: fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801b6d96300: fb fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb
                    ^
  ffff8801b6d96380: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fb fb
  ffff8801b6d96400: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
