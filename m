Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF6EECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 06:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2419D2154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 06:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2419D2154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeIVMia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 08:38:30 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40355 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeIVMi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 08:38:29 -0400
Received: by mail-io1-f71.google.com with SMTP id p22-v6so27570361ioh.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 23:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4t8EVwNwSflg3x0UrsVFB3l+xCJRYU49h8Aua3q3G7k=;
        b=eNwd3HVptpNl0x/Cn+bDJHPMY0iVwfMulDZzS26HYlpJYCv0wSp50gdJVi/tBQwDk0
         wt+dZ9gKvtxyGSFgEPxPLf9gUUntXBfgKHxCGv54n/GWzWUzcNUau+f5ir1iRyzipEpq
         TVkQXtBZP9XoNZGtUpBgNtQxI5Hile7C67ho+Ikz/p5+J+/oxFu1/5V77VnV0CZjouWm
         2lJMhitXeOtP5pLC6XxHhOvrdu33dRUzGImodkVvRTDRmnho67qv+uW73Ug1eJ65FnEx
         SPh7YBmCzSNNO5c5Sp/OR1VXwNTv/1dQ7Zs8LioTmKxeQQTmAX5r9LW7PLK+vPitkijU
         PISQ==
X-Gm-Message-State: ABuFfojC4Vvf7b1pbqDVo1b8OnCLKwdOPW5JOjeYvJe+zU8GI3p/gi0y
        Tsh0DvZoNPVk8cPyVmghfs4d/JfDPfYT9xzWh1T2s5CQGpmH
X-Google-Smtp-Source: ACcGV63IOD8ksKXnj+2I2br13/n7/BRCcEQWlo9f4SrLx3mlLNSs7DMrXF54t/4qA3PZAXrwI3n/g7rl7ommEF4o6wx2MVyJFB7N
MIME-Version: 1.0
X-Received: by 2002:a6b:b3d4:: with SMTP id c203-v6mr674061iof.53.1537598763392;
 Fri, 21 Sep 2018 23:46:03 -0700 (PDT)
Date:   Fri, 21 Sep 2018 23:46:03 -0700
In-Reply-To: <000000000000b4f77905723b70ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019666e0576701cde@google.com>
Subject: Re: KASAN: use-after-free Read in vhost_transport_send_pkt
From:   syzbot <syzbot+bd391451452fb0b93039@syzkaller.appspotmail.com>
To:     dvyukov@google.com, jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, stefanha@gmail.com, stefanha@redhat.com,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    10dc890d4228 Merge tag 'pinctrl-v4.19-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11be7111400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
dashboard link: https://syzkaller.appspot.com/bug?extid=bd391451452fb0b93039
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127cbf99400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bd391451452fb0b93039@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
hrtimer: interrupt took 32480 ns
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x37c2/0x4ec0  
kernel/locking/lockdep.c:3290
Read of size 8 at addr ffff8801b192a110 by task syz-executor0/7102

CPU: 0 PID: 7102 Comm: syz-executor0 Not tainted 4.19.0-rc4+ #249
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __lock_acquire+0x37c2/0x4ec0 kernel/locking/lockdep.c:3290
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:334 [inline]
  vhost_transport_send_pkt+0x12e/0x380 drivers/vhost/vsock.c:223
  virtio_transport_send_pkt_info+0x31d/0x460  
net/vmw_vsock/virtio_transport_common.c:190
  virtio_transport_connect+0x17c/0x220  
net/vmw_vsock/virtio_transport_common.c:588
  vsock_stream_connect+0x4ed/0xe40 net/vmw_vsock/af_vsock.c:1200
  __sys_connect+0x37d/0x4c0 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1672
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457679
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff9deebf38 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 000000000141d914 RCX: 0000000000457679
RDX: 0000000000000010 RSI: 0000000020000200 RDI: 0000000000000009
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cc658 R14: 00000000004bdcb3 R15: 0000000000000000

Allocated by task 7102:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3682 [inline]
  __kmalloc_node+0x47/0x70 mm/slab.c:3689
  kmalloc_node include/linux/slab.h:555 [inline]
  kvmalloc_node+0xb9/0xf0 mm/util.c:423
  kvmalloc include/linux/mm.h:577 [inline]
  vhost_vsock_dev_open+0xa2/0x5a0 drivers/vhost/vsock.c:511
  misc_open+0x3ca/0x560 drivers/char/misc.c:141
  chrdev_open+0x25a/0x710 fs/char_dev.c:417
  do_dentry_open+0x499/0x1250 fs/open.c:771
  vfs_open+0xa0/0xd0 fs/open.c:880
  do_last fs/namei.c:3418 [inline]
  path_openat+0x12bf/0x5160 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  __do_sys_openat fs/open.c:1090 [inline]
  __se_sys_openat fs/open.c:1084 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1084
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7104:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  kvfree+0x61/0x70 mm/util.c:452
  vhost_vsock_free drivers/vhost/vsock.c:499 [inline]
  vhost_vsock_dev_release+0x4f4/0x720 drivers/vhost/vsock.c:604
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801b1921400
  which belongs to the cache kmalloc-65536 of size 65536
The buggy address is located 36112 bytes inside of
  65536-byte region [ffff8801b1921400, ffff8801b1931400)
The buggy address belongs to the page:
page:ffffea0006c64800 count:1 mapcount:0 mapping:ffff8801da802500 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0006c64008 ffffea0006c69008 ffff8801da802500
raw: 0000000000000000 ffff8801b1921400 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b192a000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b192a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801b192a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff8801b192a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b192a200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

