Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B05ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 06:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F8C214C1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 06:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F8C214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeIVLxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 07:53:22 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34436 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeIVLxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 07:53:22 -0400
Received: by mail-io1-f71.google.com with SMTP id z20-v6so27806046iol.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 23:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=p37WZ2M+DsrbCIl6dRyXo83H4I2jqUhot0Sy3YITjiY=;
        b=ff+7CbhL0tSd5EVeIx/YYsc4a09hefyAhAU4pB/HhmTH9xFLg7Y6ySM0d3UYD2ms6M
         9Tsnpb6HL3R9crwt8MRh5XDqj/2ol6yBZBE+2xxnJ/N3xGdKIdqlDaI8FSOU2wP/fCuP
         8p8DGsyjK5bZKrTius6gxiyz58JwD2CCbqYHpPhYYDqx8IQvhdPaJ0L4LugEcxXmSro3
         JqL61Cb85aXgxsIB7MWpehQQX+Lb32Klxk0ZWX6D8qFBVjJQABpnlNVzzgAEeey1gLC6
         2VaeNWe/UhBDEPnRnpZDsN1ZXXBLBxaWwTMcBwpXYnaQu3O/1twIywVAI/DoOVfrqhcC
         nr/g==
X-Gm-Message-State: ABuFfoj7ntm7OXJnE79RjFU2U4hZOn6L9n0aGMH4Pi68PsoW/6rm29Db
        OC8WidL92tQL9W6mY53DPl1LpiBOKovLPmTipZ58dUS3JDxK
X-Google-Smtp-Source: ANB0VdbFJNLRZcFjHq0SMC2ZpO3TigIjQWyItIwKNNfyXl8FGNfI+lAT6DCMMCo7Qy81FVGi+5BJUpTQejEQ0cw5SKTY3FH4f7Gd
MIME-Version: 1.0
X-Received: by 2002:a24:2f0e:: with SMTP id j14-v6mr510582itj.8.1537596062589;
 Fri, 21 Sep 2018 23:01:02 -0700 (PDT)
Date:   Fri, 21 Sep 2018 23:01:02 -0700
In-Reply-To: <000000000000863e0205747fdfef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e6c0105766f7b02@google.com>
Subject: Re: KASAN: use-after-free Read in vhost_work_queue
From:   syzbot <syzbot+d5a0a170c5069658b141@syzkaller.appspotmail.com>
To:     cavery@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, stefanha@redhat.com,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    46c163a036b4 Add linux-next specific files for 20180921
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10c6792a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20ea07a946ad19d7
dashboard link: https://syzkaller.appspot.com/bug?extid=d5a0a170c5069658b141
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130cec76400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d5a0a170c5069658b141@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in vhost_work_queue+0xc3/0xe0  
drivers/vhost/vhost.c:258
Read of size 8 at addr ffff8801b05432a8 by task syz-executor0/9644

CPU: 1 PID: 9644 Comm: syz-executor0 Not tainted 4.19.0-rc4-next-20180921+  
#77
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  vhost_work_queue+0xc3/0xe0 drivers/vhost/vhost.c:258
  vhost_transport_send_pkt+0x28a/0x380 drivers/vhost/vsock.c:227
  virtio_transport_send_pkt_info+0x31d/0x460  
net/vmw_vsock/virtio_transport_common.c:190
  virtio_transport_connect+0x17c/0x220  
net/vmw_vsock/virtio_transport_common.c:588
  vsock_stream_connect+0x4ed/0xe40 net/vmw_vsock/af_vsock.c:1200
  __sys_connect+0x37d/0x4c0 net/socket.c:1665
  __do_sys_connect net/socket.c:1676 [inline]
  __se_sys_connect net/socket.c:1673 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1673
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457679
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f746bbf5c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f746bbf66d4 RCX: 0000000000457679
RDX: 0000000000000010 RSI: 0000000020000200 RDI: 0000000000000009
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cc658 R14: 00000000004bdcb3 R15: 0000000000000000

Allocated by task 9654:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3682 [inline]
  __kmalloc_node+0x47/0x70 mm/slab.c:3689
  kmalloc_node include/linux/slab.h:589 [inline]
  kvmalloc_node+0xb9/0xf0 mm/util.c:423
  kvmalloc include/linux/mm.h:577 [inline]
  vhost_vsock_dev_open+0xa2/0x5a0 drivers/vhost/vsock.c:511
  misc_open+0x3ca/0x560 drivers/char/misc.c:141
  chrdev_open+0x25a/0x710 fs/char_dev.c:417
  do_dentry_open+0x499/0x1250 fs/open.c:771
  vfs_open+0xa0/0xd0 fs/open.c:880
  do_last fs/namei.c:3418 [inline]
  path_openat+0x12bc/0x5160 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  __do_sys_openat fs/open.c:1090 [inline]
  __se_sys_openat fs/open.c:1084 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1084
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9643:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  kvfree+0x61/0x70 mm/util.c:452
  vhost_vsock_free drivers/vhost/vsock.c:499 [inline]
  vhost_vsock_dev_release+0x4f4/0x720 drivers/vhost/vsock.c:604
  __fput+0x3bc/0xa70 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801b0543200
  which belongs to the cache kmalloc-64k of size 65536
The buggy address is located 168 bytes inside of
  65536-byte region [ffff8801b0543200, ffff8801b0553200)
The buggy address belongs to the page:
page:ffffea0006c15000 count:1 mapcount:0 mapping:ffff8801da802500 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0006c14808 ffffea0006c15808 ffff8801da802500
raw: 0000000000000000 ffff8801b0543200 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b0543180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801b0543200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801b0543280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
  ffff8801b0543300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b0543380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

