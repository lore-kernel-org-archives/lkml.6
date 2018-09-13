Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F44C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6729820854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6729820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeIMO0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:26:39 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:57249 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeIMO0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:26:39 -0400
Received: by mail-it0-f70.google.com with SMTP id i188-v6so7615146itf.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 02:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MhFF8Ip1p+VrAjKcNBSkfM17GVV9Pa7qKu3VkQZibac=;
        b=EnQxcHGQMJ/zyQ8vtTvLE4Zj2NeHXQCCywWMZILaB6QJaMrSWJYO2darNHv7DYyzil
         ++yMUHdZkjSBJNNB6/mSxW2GRxKFcmcT3mRj2W/u4zfhvGJ37NF1gD3jw93PkRrEbQ1f
         a03n5N0uMjXK9ObW+/RREZkOVCcF9n9ONofAbMuCudfPs1IJuHL3sQrf4B7lR0sptNRs
         0qp9pxiSaa2YTp5PAKDqn9vEdqr6AxLpqNHMe6mPjPyM5SX8ybVrFrmBAqSDda/wXleE
         vN57KES1Vx/BFZgY+2IK4ARtoxfhHitxxq9eTBj+htHGL8ekGGYEg5JoeoPhs03s85+e
         E6Cw==
X-Gm-Message-State: APzg51BOXTRMyQ2xqGBvluR1XA24LeIR5FkDiD/qgpoAsaGLpsqbUAOd
        oNInxSKKeLaxstDM9wyrYP0SSO43aYyOEx0k56Pj5DzEfQA8
X-Google-Smtp-Source: ANB0VdbOD6hxFerAQEhXhfJp+EYu2yhb5jkb67Ub5zIhRX15ggCCeNFdE/Xnsr7TFBkHwCBXCt2LOSXHJH6zlKh1tlRAZ8qZpJqD
MIME-Version: 1.0
X-Received: by 2002:a6b:ab81:: with SMTP id u123-v6mr4642574ioe.102.1536830282850;
 Thu, 13 Sep 2018 02:18:02 -0700 (PDT)
Date:   Thu, 13 Sep 2018 02:18:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016eb330575bd2fab@google.com>
Subject: KMSAN: kernel-infoleak in copy_page_to_iter (2)
From:   syzbot <syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com>
To:     ak@linux.intel.com, akpm@linux-foundation.org, jack@suse.cz,
        jlayton@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mawilcox@microsoft.com,
        mgorman@techsingularity.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    123906095e30 kmsan: introduce kmsan_interrupt_enter()/kmsa..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=1249fcb8400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=848e40757852af3e
dashboard link: https://syzkaller.appspot.com/bug?extid=2dcfeaf8cb49b05e8f1a
compiler:       clang version 7.0.0 (trunk 334104)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116ef050400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122870ff800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KMSAN: kernel-infoleak in copyout lib/iov_iter.c:140 [inline]
BUG: KMSAN: kernel-infoleak in copy_page_to_iter_iovec lib/iov_iter.c:212  
[inline]
BUG: KMSAN: kernel-infoleak in copy_page_to_iter+0x754/0x1b70  
lib/iov_iter.c:716
CPU: 0 PID: 4516 Comm: blkid Not tainted 4.17.0+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:1125
  kmsan_internal_check_memory+0x17e/0x1f0 mm/kmsan/kmsan.c:1238
  kmsan_copy_to_user+0x7a/0x160 mm/kmsan/kmsan.c:1261
  copyout lib/iov_iter.c:140 [inline]
  copy_page_to_iter_iovec lib/iov_iter.c:212 [inline]
  copy_page_to_iter+0x754/0x1b70 lib/iov_iter.c:716
  generic_file_buffered_read mm/filemap.c:2185 [inline]
  generic_file_read_iter+0x2ef8/0x44d0 mm/filemap.c:2362
  blkdev_read_iter+0x20d/0x280 fs/block_dev.c:1930
  call_read_iter include/linux/fs.h:1778 [inline]
  new_sync_read fs/read_write.c:406 [inline]
  __vfs_read+0x775/0x9d0 fs/read_write.c:418
  vfs_read+0x36c/0x6b0 fs/read_write.c:452
  ksys_read fs/read_write.c:578 [inline]
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __x64_sys_read+0x1bf/0x3e0 fs/read_write.c:586
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fdeff68f310
RSP: 002b:00007ffe999660b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdeff68f310
RDX: 0000000000000100 RSI: 0000000001e78df8 RDI: 0000000000000003
RBP: 0000000001e78dd0 R08: 0000000000000028 R09: 0000000001680000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001e78030
R13: 0000000000000100 R14: 0000000001e78080 R15: 0000000001e78de8

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:282 [inline]
  kmsan_alloc_meta_for_pages+0x161/0x3a0 mm/kmsan/kmsan.c:819
  kmsan_alloc_page+0x82/0xe0 mm/kmsan/kmsan.c:889
  __alloc_pages_nodemask+0xf7b/0x5cc0 mm/page_alloc.c:4402
  alloc_pages_current+0x6b1/0x970 mm/mempolicy.c:2093
  alloc_pages include/linux/gfp.h:494 [inline]
  __page_cache_alloc+0x95/0x320 mm/filemap.c:946
  pagecache_get_page+0x52b/0x1450 mm/filemap.c:1577
  grab_cache_page_write_begin+0x10d/0x190 mm/filemap.c:3089
  block_write_begin+0xf9/0x3a0 fs/buffer.c:2068
  blkdev_write_begin+0xf5/0x110 fs/block_dev.c:584
  generic_perform_write+0x438/0x9d0 mm/filemap.c:3139
  __generic_file_write_iter+0x43b/0xa10 mm/filemap.c:3264
  blkdev_write_iter+0x3a8/0x5f0 fs/block_dev.c:1910
  do_iter_readv_writev+0x81c/0xa20 include/linux/fs.h:1778
  do_iter_write+0x30d/0xd50 fs/read_write.c:959
  vfs_writev fs/read_write.c:1004 [inline]
  do_writev+0x3be/0x820 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0xe1/0x120 fs/read_write.c:1109
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Bytes 4-255 of 256 are uninitialized
Memory access starts at ffff8801b9903000
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
