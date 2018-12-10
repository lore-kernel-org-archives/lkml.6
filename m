Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0808DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B689E20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B689E20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeLJEvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:51:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:40140 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLJEvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:51:04 -0500
Received: by mail-io1-f70.google.com with SMTP id u2so10109978iob.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 20:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=upr036N1uYOu3BSW3ykxflvELONnmDTNXl3wdoe62+A=;
        b=qkkT5O2mCqFn88+gsQV/Kj1fWfWCcJkJal3145tL4opHQXK63rpdHvUA0wfYy5D+7P
         ewMYcPxlzAUnGaY4ZzO1YS5a0tcfqTzrwEWzk9c/+xU4MevcVqmrS9/QSkEJCaHC0Chl
         itFfOJStKBPC4H5/nGilr7TekxN32fnWlQjd6PJIKIJvFRgKgt66CcQlpUovPeJAcK+/
         ln5kr5NPBrZ7SW4bWz8HbGu3Yo5XFUpzqeoO+0OJz1Dajtz54x8P/XKKhVYqO5V7n83s
         wzHUP0sXAM2GYnf4Aoio8EKH5beZUpOpseKd2M+sMXusOJ4EQvv42VLMAn3wnqcpIQSY
         U2/A==
X-Gm-Message-State: AA+aEWaLepSitxb2pTNZ9gY0tMYaT9aLiIPkLEHu3Q+quMi7vv72g/gE
        Q1eufhZZlckJSTMHdZrpj0WGunqPDSWq5nSSb0PrYdTJVc5C
X-Google-Smtp-Source: AFSGD/WaXvxVUE7hAQxLu8KHE11/1oe/1CmrVjw299HqQGrkSz18cVxvAhkxJK8+XLVKfqbim6Ym3yPwbukNEP9j8nYE+Re758fW
MIME-Version: 1.0
X-Received: by 2002:a24:2c4d:: with SMTP id i74mr9438246iti.12.1544417463392;
 Sun, 09 Dec 2018 20:51:03 -0800 (PST)
Date:   Sun, 09 Dec 2018 20:51:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a6256057ca3b6bd@google.com>
Subject: KASAN: slab-out-of-bounds Write in default_read_copy_kernel
From:   syzbot <syzbot+12f17c177de05efea72d@syzkaller.appspotmail.com>
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

HEAD commit:    abb8d6ecbd8f Merge tag 'trace-v4.20-rc5' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17932f4d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9cc5a440391cbfd
dashboard link: https://syzkaller.appspot.com/bug?extid=12f17c177de05efea72d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c27125400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152a2a43400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+12f17c177de05efea72d@syzkaller.appspotmail.com

RDX: 0000000000000001 RSI: 0000000020001640 RDI: 0000000000000003
RBP: 00000000006cf018 R08: 0000000000000001 R09: 0000000000000037
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:352 [inline]
BUG: KASAN: slab-out-of-bounds in default_read_copy_kernel+0xe1/0x140  
sound/core/pcm_lib.c:1988
Write of size 64 at addr ffff8881cec699c0 by task syz-executor520/6056

CPU: 1 PID: 6056 Comm: syz-executor520 Not tainted 4.20.0-rc5+ #365
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
  memcpy+0x37/0x50 mm/kasan/kasan.c:303
  memcpy include/linux/string.h:352 [inline]
  default_read_copy_kernel+0xe1/0x140 sound/core/pcm_lib.c:1988
  interleaved_copy+0xd1/0x110 sound/core/pcm_lib.c:2007
  __snd_pcm_lib_xfer+0x115f/0x1f23 sound/core/pcm_lib.c:2227
  snd_pcm_oss_read3+0x1c8/0x410 sound/core/oss/pcm_oss.c:1274
  io_capture_transfer+0x27d/0x310 sound/core/oss/io.c:73
  snd_pcm_plug_read_transfer+0x1d7/0x3b0 sound/core/oss/pcm_plugin.c:651
  snd_pcm_oss_read2+0x221/0x450 sound/core/oss/pcm_oss.c:1474
  snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1531 [inline]
  snd_pcm_oss_read+0x638/0x830 sound/core/oss/pcm_oss.c:2752
  do_loop_readv_writev fs/read_write.c:700 [inline]
  do_iter_read+0x4a3/0x650 fs/read_write.c:924
  vfs_readv+0x175/0x1c0 fs/read_write.c:986
  do_readv+0x11a/0x310 fs/read_write.c:1019
  __do_sys_readv fs/read_write.c:1106 [inline]
  __se_sys_readv fs/read_write.c:1103 [inline]
  __x64_sys_readv+0x75/0xb0 fs/read_write.c:1103
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444079
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc8067a328 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444079
RDX: 0000000000000001 RSI: 0000000020001640 RDI: 0000000000000003
RBP: 00000000006cf018 R08: 0000000000000001 R09: 0000000000000037
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6056:
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
  snd_pcm_plug_alloc+0x149/0x340 sound/core/oss/pcm_plugin.c:129
  snd_pcm_oss_change_params_locked+0x2209/0x3c60  
sound/core/oss/pcm_oss.c:1038
  snd_pcm_oss_make_ready_locked+0xbc/0x130 sound/core/oss/pcm_oss.c:1183
  snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1507 [inline]
  snd_pcm_oss_read+0x417/0x830 sound/core/oss/pcm_oss.c:2752
  do_loop_readv_writev fs/read_write.c:700 [inline]
  do_iter_read+0x4a3/0x650 fs/read_write.c:924
  vfs_readv+0x175/0x1c0 fs/read_write.c:986
  do_readv+0x11a/0x310 fs/read_write.c:1019
  __do_sys_readv fs/read_write.c:1106 [inline]
  __se_sys_readv fs/read_write.c:1103 [inline]
  __x64_sys_readv+0x75/0xb0 fs/read_write.c:1103
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  kzfree+0x28/0x30 mm/slab_common.c:1564
  aa_free_task_ctx security/apparmor/include/task.h:61 [inline]
  apparmor_task_free+0x13a/0x1e0 security/apparmor/lsm.c:95
  security_task_free+0x4a/0x80 security/security.c:1007
  __put_task_struct+0x195/0x620 kernel/fork.c:724
  put_task_struct include/linux/sched/task.h:96 [inline]
  delayed_put_task_struct+0x2ff/0x4c0 kernel/exit.c:181
  __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
  rcu_do_batch kernel/rcu/tree.c:2437 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2716 [inline]
  rcu_process_callbacks+0x100a/0x1ac0 kernel/rcu/tree.c:2697
  __do_softirq+0x308/0xb7e kernel/softirq.c:292

The buggy address belongs to the object at ffff8881cec699c0
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
  32-byte region [ffff8881cec699c0, ffff8881cec699e0)
The buggy address belongs to the page:
page:ffffea00073b1a40 count:1 mapcount:0 mapping:ffff8881da8001c0  
index:0xffff8881cec69fc1
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea00073a3748 ffff8881da801248 ffff8881da8001c0
raw: ffff8881cec69fc1 ffff8881cec69000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881cec69880: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8881cec69900: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8881cec69980: fb fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
                                                        ^
  ffff8881cec69a00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8881cec69a80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
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
