Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbeDYTTF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 15:19:05 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:53034 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbeDYTTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 15:19:03 -0400
X-Google-Smtp-Source: AIpwx49e/VRjrpgbcmxf3QDq1cPcFSdHAhdwI+DvdB1flTXIy5hjnW3ncOanDrQMzT16M8yWuNW7wpcOy0Mnx8nAHhtRM93v3red
MIME-Version: 1.0
Date: Wed, 25 Apr 2018 12:19:02 -0700
In-Reply-To: <000000000000a5b2b1056a86e98c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf4578056ab12452@google.com>
Subject: Re: KMSAN: uninit-value in _copy_to_iter (2)
From: syzbot <syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com>
To: avagin@openvz.org, davem@davemloft.net, dingtianhong@huawei.com,
        edumazet@google.com, elena.reshetova@intel.com, jasowang@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew@mjdsystems.ca, mingo@kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        virtualization@lists.linux-foundation.org, willemb@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found reproducer for the following crash on  
https://github.com/google/kmsan.git/master commit
d2d741e5d1898dfde1a75ea3d29a9a3e2edf0617 (Sun Apr 22 15:05:22 2018 +0000)
kmsan: add initialization for shmem pages
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=87cfa083e727a224754b

So far this crash happened 3 times on  
https://github.com/google/kmsan.git/master.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5122017598636032
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6680049734385664
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5920461749747712
Kernel config: https://syzkaller.appspot.com/x/.config?id=328654897048964367
compiler: clang version 7.0.0 (trunk 329391)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

==================================================================
BUG: KMSAN: uninit-value in copyout lib/iov_iter.c:140 [inline]
BUG: KMSAN: uninit-value in _copy_to_iter+0x46d/0x28f0 lib/iov_iter.c:571
CPU: 1 PID: 4516 Comm: syz-executor879 Not tainted 4.16.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  kmsan_internal_check_memory+0x135/0x1e0 mm/kmsan/kmsan.c:1157
  kmsan_copy_to_user+0x69/0x160 mm/kmsan/kmsan.c:1199
  copyout lib/iov_iter.c:140 [inline]
  _copy_to_iter+0x46d/0x28f0 lib/iov_iter.c:571
  copy_to_iter include/linux/uio.h:106 [inline]
  vhost_chr_read_iter+0x7ac/0xc50 drivers/vhost/vhost.c:1104
  vhost_net_chr_read_iter+0xf6/0x130 drivers/vhost/net.c:1365
  call_read_iter include/linux/fs.h:1776 [inline]
  aio_read+0x5c1/0x6f0 fs/aio.c:1517
  io_submit_one fs/aio.c:1633 [inline]
  do_io_submit+0x1bb4/0x2f60 fs/aio.c:1698
  SYSC_io_submit+0x98/0xb0 fs/aio.c:1723
  SyS_io_submit+0x56/0x80 fs/aio.c:1720
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x4457b9
RSP: 002b:00007ff9343e4da8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00000000006dac44 RCX: 00000000004457b9
RDX: 00000000200001c0 RSI: 0000000000000001 RDI: 00007ff93439a000
RBP: 00000000006dac40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 901aeeff3a98f9ab
R13: 98c94b26f489688e R14: ae1b2dfa3c87200a R15: 0000000000000001

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
  __kmalloc+0x23c/0x350 mm/slub.c:3791
  kmalloc include/linux/slab.h:517 [inline]
  vhost_new_msg drivers/vhost/vhost.c:2340 [inline]
  vhost_iotlb_miss drivers/vhost/vhost.c:1124 [inline]
  translate_desc+0xbef/0x1120 drivers/vhost/vhost.c:1829
  __vhost_get_user_slow drivers/vhost/vhost.c:812 [inline]
  __vhost_get_user drivers/vhost/vhost.c:846 [inline]
  vhost_update_used_flags+0x469/0x8d0 drivers/vhost/vhost.c:1715
  vhost_vq_init_access+0x173/0xa20 drivers/vhost/vhost.c:1763
  vhost_net_set_backend drivers/vhost/net.c:1166 [inline]
  vhost_net_ioctl+0x22b0/0x3480 drivers/vhost/net.c:1322
  vfs_ioctl fs/ioctl.c:46 [inline]
  do_vfs_ioctl+0xaf0/0x2440 fs/ioctl.c:686
  SYSC_ioctl+0x1d2/0x260 fs/ioctl.c:701
  SyS_ioctl+0x54/0x80 fs/ioctl.c:692
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Bytes 4-7 of 72 are uninitialized
==================================================================
