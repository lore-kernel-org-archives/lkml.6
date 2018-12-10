Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D450C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E54F2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E54F2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeLJStF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:49:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:38975 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeLJStE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:49:04 -0500
Received: by mail-it1-f198.google.com with SMTP id k133so15482786ite.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 10:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iH4OfsqRwB/lozk2QAV/w3sSDhA4Di7uoaBft9QjRhg=;
        b=nqAzBmnmHrjL+b6OTKPdxwmVLaTYi+d6H6raUJ8SaN/gCoByHsnz+eb3bJ/ZqDbhl8
         deY95L7aZ5M8wM3uF0xRHDI6GD8kvmVYU+LDvRsDO9YfNsXiPbhqtWcjvgj4pVPyiMQ4
         X0hrIzzNS3a288AdqQZfsaYqjfUW/mZIumNEfRDWx95NBVgF+C+3gtOHSlDPC1jHsP4J
         oSrhA8AEa1gatS0MG3XyRrD6COhE3Rso8NvCgktS4qtsPGOAljgbrJhKUDGcsTFWuSpQ
         eoopg6PjlwJ0KwfFL7QoNJK8oanuT/NfUJA6rHEq8DGkWnkDP2DOLx8Ws46+z897LQg4
         2Mpw==
X-Gm-Message-State: AA+aEWYVJxczcdonCcQdBnP4pihft0vU6R6/OmpOaYAjavFiKTkolfsv
        zNq7Cf1FCFQlvgbDZw8DYuXP2YJAIQEqbIPF2nXp+eeQ98bt
X-Google-Smtp-Source: AFSGD/VKBRtyHB+cBO5JuPfTODkvuU342pLkoJA29+2pXlQeirYYIpu+IZyuvWpRKSmXfFsZsh4+ufN64s3oefFrLtbTCl4IJL8M
MIME-Version: 1.0
X-Received: by 2002:a24:2289:: with SMTP id o131mr11148063ito.7.1544467743551;
 Mon, 10 Dec 2018 10:49:03 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:49:03 -0800
In-Reply-To: <000000000000a1adb3057ca63d3b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038b88e057caf6bd9@google.com>
Subject: Re: KASAN: use-after-free Read in ___neigh_create
From:   syzbot <syzbot+e4d42eb35f6a27b0a628@syzkaller.appspotmail.com>
To:     christian@brauner.io, davem@davemloft.net, dsahern@gmail.com,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        syzkaller-bugs@googlegroups.com, w.bumiller@proxmox.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    14cf8c1d5b90 Add linux-next specific files for 20181210
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1666c56d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9133d0a4284c012
dashboard link: https://syzkaller.appspot.com/bug?extid=e4d42eb35f6a27b0a628
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12438215400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11399125400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e4d42eb35f6a27b0a628@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in neigh_forced_gc net/core/neighbour.c:208  
[inline]
BUG: KASAN: use-after-free in neigh_alloc net/core/neighbour.c:365 [inline]
BUG: KASAN: use-after-free in ___neigh_create+0x21fd/0x2600  
net/core/neighbour.c:553
Read of size 8 at addr ffff8881b3566b70 by task syz-executor075/6593

CPU: 1 PID: 6593 Comm: syz-executor075 Not tainted  
4.20.0-rc6-next-20181210+ #164
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.4+0x9/0x1ff mm/kasan/report.c:187
  kasan_report.cold.5+0x1b/0x39 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  neigh_forced_gc net/core/neighbour.c:208 [inline]
  neigh_alloc net/core/neighbour.c:365 [inline]
  ___neigh_create+0x21fd/0x2600 net/core/neighbour.c:553
  __neigh_create+0x30/0x40 net/core/neighbour.c:640
  neigh_create include/net/neighbour.h:319 [inline]
  __neigh_lookup_errno include/net/neighbour.h:529 [inline]
  arp_req_set+0x59d/0xaa0 net/ipv4/arp.c:1066
  arp_ioctl+0x48b/0xae0 net/ipv4/arp.c:1230
  inet_ioctl+0x237/0x360 net/ipv4/af_inet.c:932
  sock_do_ioctl+0xeb/0x420 net/socket.c:951
  sock_ioctl+0x313/0x690 net/socket.c:1075
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440e39
Code: e8 cc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffea8160338 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440e39
RDX: 0000000020000000 RSI: 0000000000008955 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000001fe3880 R11: 0000000000000213 R12: 000000000000d704
R13: 0000000000401e10 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6083:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc+0xcb/0xd0 mm/kasan/common.c:482
  __do_kmalloc mm/slab.c:3709 [inline]
  __kmalloc+0x15d/0x760 mm/slab.c:3718
  kmalloc include/linux/slab.h:550 [inline]
  kzalloc include/linux/slab.h:740 [inline]
  neigh_alloc net/core/neighbour.c:375 [inline]
  ___neigh_create+0x13fc/0x2600 net/core/neighbour.c:553
  __neigh_create+0x30/0x40 net/core/neighbour.c:640
  neigh_create include/net/neighbour.h:319 [inline]
  __neigh_lookup_errno include/net/neighbour.h:529 [inline]
  arp_req_set+0x59d/0xaa0 net/ipv4/arp.c:1066
  arp_ioctl+0x48b/0xae0 net/ipv4/arp.c:1230
  inet_ioctl+0x237/0x360 net/ipv4/af_inet.c:932
  sock_do_ioctl+0xeb/0x420 net/socket.c:951
  sock_ioctl+0x313/0x690 net/socket.c:1075
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 0:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kfree+0xcf/0x230 mm/slab.c:3804
  __rcu_reclaim kernel/rcu/rcu.h:233 [inline]
  rcu_do_batch kernel/rcu/tree.c:2452 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2773 [inline]
  rcu_process_callbacks+0xd91/0x15f0 kernel/rcu/tree.c:2754
  __do_softirq+0x308/0xb7e kernel/softirq.c:292

The buggy address belongs to the object at ffff8881b3566900
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 624 bytes inside of
  1024-byte region [ffff8881b3566900, ffff8881b3566d00)
The buggy address belongs to the page:
page:ffffea0006cd5980 count:1 mapcount:0 mapping:ffff8881da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0007354b88 ffffea000704b308 ffff8881da800ac0
raw: 0000000000000000 ffff8881b3566000 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881b3566a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b3566a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881b3566b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                              ^
  ffff8881b3566b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b3566c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

