Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C532C677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 15:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302CF21473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 15:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302CF21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeJFWuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 18:50:52 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:57705 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeJFWuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 18:50:51 -0400
Received: by mail-it1-f199.google.com with SMTP id y142-v6so5955724itb.7
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 08:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5h/wPkMlzUYrFgESqqZt4JsgdWeqADfzeCulI6GuRBE=;
        b=o7ggulLkKrKkLnKt6qeqmHbEci506ebr/I9H7esdz6IctjDJg3rqjXr1ekZyoYr9sM
         BuF04/DusrNsi3y0zy2aquVRa/HThKI6lvoqX/pg+aciVjodQQps/XgjObYwn/zKRZFV
         QdAcI2oL3HJQg+ftZfHWsyUDXg4xMWpbEoGwYFvyQjMxheamOyZRBGe41B/I7GsQZqsc
         A4JzGhrXqazTgRS2X6z8gJz+6duU8sLb1TJxqMUlgkJb8rZxu6+cw9oZIgu8oPEl1TnJ
         6JUDylRMys59NLmcWY7OfspLL2VMH8UvvLezAXPIIQ3xvgzLf/Hd0ej8JUMv7bxoBsrr
         Mk4A==
X-Gm-Message-State: ABuFfoh0TRgFCkjKiirvsghW2AuTHeRK/HtirqLNHaSix9TlKNje4HCk
        9tI/l3iDEIPI0y4qYtYCTANdvLrjkO4mnkmDh87wNh3b359D
X-Google-Smtp-Source: ACcGV63iK9cf4rXQSfPEJ/WbtqFuqNRJKmOs9B1y4noTqKvlGIrrE7h5h7RfUSVVGNC3b+FdCR1DLA+7ptHeyZgw7NZtjPBpTwW0
MIME-Version: 1.0
X-Received: by 2002:a24:8306:: with SMTP id d6-v6mr11681521ite.24.1538840823267;
 Sat, 06 Oct 2018 08:47:03 -0700 (PDT)
Date:   Sat, 06 Oct 2018 08:47:03 -0700
In-Reply-To: <00000000000068750f0576c178ab@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a30bcb0577914cba@google.com>
Subject: Re: KASAN: use-after-free Read in vhost_transport_cancel_pkt
From:   syzbot <syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com>
To:     jasowang@redhat.com, kvm@vger.kernel.org,
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

HEAD commit:    091a1eaa0e30 Merge branch 'akpm'
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15627ae6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
dashboard link: https://syzkaller.appspot.com/bug?extid=e3e074963495f92a89ed
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120d5491400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in debug_spin_lock_before  
kernel/locking/spinlock_debug.c:83 [inline]
BUG: KASAN: use-after-free in do_raw_spin_lock+0x1c0/0x200  
kernel/locking/spinlock_debug.c:112
Read of size 4 at addr ffff8801c5e6977c by task syz-executor0/7470

CPU: 1 PID: 7470 Comm: syz-executor0 Not tainted 4.19.0-rc6+ #47
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
  do_raw_spin_lock+0x1c0/0x200 kernel/locking/spinlock_debug.c:112
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:136 [inline]
  _raw_spin_lock_bh+0x39/0x40 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:334 [inline]
  vhost_transport_cancel_pkt+0x15e/0x910 drivers/vhost/vsock.c:244
  vsock_transport_cancel_pkt net/vmw_vsock/af_vsock.c:1114 [inline]
  vsock_stream_connect+0x903/0xe40 net/vmw_vsock/af_vsock.c:1241
  __sys_connect+0x37d/0x4c0 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1672
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbd405dac78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 0000000000000080 RSI: 0000000020000400 RDI: 0000000000000007
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbd405db6d4
R13: 00000000004bda00 R14: 00000000004cc478 R15: 00000000ffffffff

Allocated by task 7456:
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

