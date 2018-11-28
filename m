Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22321C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6E12081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6E12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeK2Ema (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:42:30 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:38537 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbeK2Em3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:42:29 -0500
Received: by mail-it1-f197.google.com with SMTP id m128so1313716itd.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Zw1r+UlUl6UXCR8K8ZMzlh0Z/JQjsNqEPKcdcTkOj70=;
        b=OieEWHYjJeNP8nFJwzSpDlVzpiwZwR3pgHIF3EInnsvJRkUbN2RIFss0PlERI3NwJu
         OzUU5URPxtaqNwg0ydS3s/AJP3cdEV1BeycDB9aIQG92Sje8jETjzXZjnS80pj9coHNc
         Usy1AS7JQQYqz0X036rnB9awFAHoAXTjRFvHlAXqPoNq0SB266RmGVo7aGAUB+1fBk0O
         taBj+HNDoP4pKIDc9MyGar1L+QEhvGgZ9mr6EEv9L86CMc2CuC3d8hiKNE8p3JMyQIrG
         GKm/GLN+p5Ocn4dnvyLf95KgdFiMCIBcZmY5HRKsoUR6mUD7wPjH9cJ6JrnB1dEePz4i
         uFqw==
X-Gm-Message-State: AA+aEWb6Rli5cy5WnNRzavhxG8pDHI98KXaEl67VjYg4psQhgDCTIYa1
        jE+nmwONKStqidIZm3ezyObqkknOl75jNtEwCAtFwyr4k6nK
X-Google-Smtp-Source: AFSGD/XiplDyAytpyxG2RBs2KmHpNKIe8yJsTzB4D7YH2S24WGaVTKzLwJUT1a4tC5GPKAwQPxXahkDuHibjaRbWh2pM4cxeLbrr
MIME-Version: 1.0
X-Received: by 2002:a24:5311:: with SMTP id n17mr3047238itb.39.1543426804166;
 Wed, 28 Nov 2018 09:40:04 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:40:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000663620057bbd0e9d@google.com>
Subject: KASAN: use-after-free Read in link_path_walk
From:   syzbot <syzbot+fb731ca573367b7f6564@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ef78e5ec9214 ia64: export node_distance function
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bc2415400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c94f9f0c0363db4b
dashboard link: https://syzkaller.appspot.com/bug?extid=fb731ca573367b7f6564
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11116225400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fb731ca573367b7f6564@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
audit: type=1400 audit(1543395345.166:38): avc:  denied  { associate } for   
pid=6244 comm="syz-executor3" name="syz3"  
scontext=unconfined_u:object_r:unlabeled_t:s0  
tcontext=system_u:object_r:unlabeled_t:s0 tclass=filesystem permissive=1
==================================================================
BUG: KASAN: use-after-free in link_path_walk.part.40+0x12e6/0x1530  
fs/namei.c:2091
Read of size 1 at addr ffff8881cca65d40 by task syz-executor2/10223

CPU: 1 PID: 10223 Comm: syz-executor2 Not tainted 4.20.0-rc4+ #132
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  link_path_walk.part.40+0x12e6/0x1530 fs/namei.c:2091
  link_path_walk fs/namei.c:2269 [inline]
  path_lookupat.isra.43+0xf7/0xc00 fs/namei.c:2317
  filename_lookup+0x26a/0x520 fs/namei.c:2348
  user_path_at_empty+0x40/0x50 fs/namei.c:2608
  user_path include/linux/namei.h:62 [inline]
  do_mount+0x177/0x31f0 fs/namespace.c:2741
  ksys_mount+0x12d/0x140 fs/namespace.c:3017
  __do_sys_mount fs/namespace.c:3031 [inline]
  __se_sys_mount fs/namespace.c:3028 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3028
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb6416b0c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457569
RDX: 0000000020000040 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 000000000072bf00 R08: 0000000020000340 R09: 0000000000000000
R10: 0000000000200000 R11: 0000000000000246 R12: 00007fb6416b16d4
R13: 00000000004c2c24 R14: 00000000004d4990 R15: 00000000ffffffff

Allocated by task 10228:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3722 [inline]
  __kmalloc_track_caller+0x157/0x760 mm/slab.c:3737
  kstrdup+0x39/0x70 mm/util.c:49
  bpf_symlink+0x26/0x140 kernel/bpf/inode.c:356
  vfs_symlink+0x37a/0x5d0 fs/namei.c:4127
  do_symlinkat+0x242/0x2d0 fs/namei.c:4154
  __do_sys_symlink fs/namei.c:4173 [inline]
  __se_sys_symlink fs/namei.c:4171 [inline]
  __x64_sys_symlink+0x59/0x80 fs/namei.c:4171
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 10235:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  bpf_evict_inode+0x11f/0x150 kernel/bpf/inode.c:565
  evict+0x4b9/0x980 fs/inode.c:558
  iput_final fs/inode.c:1550 [inline]
  iput+0x679/0xa90 fs/inode.c:1576
  do_unlinkat+0x733/0xa30 fs/namei.c:4069
  __do_sys_unlink fs/namei.c:4110 [inline]
  __se_sys_unlink fs/namei.c:4108 [inline]
  __x64_sys_unlink+0x42/0x50 fs/namei.c:4108
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881cca65d40
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
  32-byte region [ffff8881cca65d40, ffff8881cca65d60)
The buggy address belongs to the page:
page:ffffea0007329940 count:1 mapcount:0 mapping:ffff8881da8001c0  
index:0xffff8881cca65fc1
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea000730d6c8 ffffea00075efa48 ffff8881da8001c0
raw: ffff8881cca65fc1 ffff8881cca65000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881cca65c00: fb fb fb fb fc fc fc fc 05 fc fc fc fc fc fc fc
  ffff8881cca65c80: fb fb fb fb fc fc fc fc 05 fc fc fc fc fc fc fc
> ffff8881cca65d00: 00 00 01 fc fc fc fc fc fb fb fb fb fc fc fc fc
                                            ^
  ffff8881cca65d80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8881cca65e00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
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
