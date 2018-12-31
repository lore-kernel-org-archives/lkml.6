Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D42C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 05:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F422D20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 05:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeLaFvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 00:51:05 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:45880 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLaFvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 00:51:04 -0500
Received: by mail-io1-f69.google.com with SMTP id r65so30667410iod.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 21:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=u+ijmyPXhbBaKFW4g5TRz1uOKR3aU8fnxKomTjhMvxY=;
        b=Q3AA/HcoofcOaa9Sj2JbtA0NIZsSH4sxvgJcD+mz8bmOErwp13roKXGpf+wClGVgfQ
         B3RV2aE6NsUYS2QiKnc5wy/IlC/9zrex+R4ukmNTFLrI6+kW4SIdxU3y9jd6nmsGSWCV
         C+FL9mEL281wViZMNtlKnxGa1GwcqwtMMLHe4QzqyKkFBQ4dw81cxJgHXzKzAUpKcria
         m9jE169ZS4ISgHiLjFEVDwlhz88NqnJefcD2z65P57NKEyg+cCMs4qOB1mU3XM7xwnVj
         OKG4ipkhffzb+xPhMgfO9B9BdoVvqIO8v5aMBkctX/90p/8SPIlrVAkzDCdtI0HPhufp
         Cx3g==
X-Gm-Message-State: AJcUukfnk4NdfuZtifHhMa9g+wuxtZR6oI1We11MV9PHzsh0tBpN5BC/
        NSv7P7uO2T5uEFU7NWC7LMRqblIBkpPx57iwYy6/Eve7xUMG
X-Google-Smtp-Source: AFSGD/XrrB16d9NCoU7NGEFqTEvusDzk3KbHT15h46R3rCLeZbJSoURenF62epWdVdzso3WvTRAPKkBx3kyZX5flZX+DPKWnwqf8
MIME-Version: 1.0
X-Received: by 2002:a24:244:: with SMTP id 65mr28101862itu.3.1546235463676;
 Sun, 30 Dec 2018 21:51:03 -0800 (PST)
Date:   Sun, 30 Dec 2018 21:51:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d3a7f057e4aff68@google.com>
Subject: KASAN: use-after-free Read in batadv_interface_tx
From:   syzbot <syzbot+7d20bc3f1ddddc0f9079@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    903b77c63167 Merge tag 'linux-kselftest-4.21-rc1' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168acbdd400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53a2f2aa0b1f7606
dashboard link: https://syzkaller.appspot.com/bug?extid=7d20bc3f1ddddc0f9079
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11aa3b57400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c907ed400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7d20bc3f1ddddc0f9079@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
8021q: adding VLAN 0 to HW filter on device batadv0
==================================================================
BUG: KASAN: use-after-free in batadv_interface_tx+0x160a/0x18b0  
net/batman-adv/soft-interface.c:226
Read of size 2 at addr ffff88809f96aa4b by task syz-executor871/8379

CPU: 1 PID: 8379 Comm: syz-executor871 Not tainted 4.20.0+ #395
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.5+0x9/0x1ff mm/kasan/report.c:187
  kasan_report.cold.6+0x1b/0x39 mm/kasan/report.c:317
  __asan_report_load_n_noabort+0xf/0x20 mm/kasan/generic_report.c:145
  batadv_interface_tx+0x160a/0x18b0 net/batman-adv/soft-interface.c:226
  __netdev_start_xmit include/linux/netdevice.h:4382 [inline]
  netdev_start_xmit include/linux/netdevice.h:4391 [inline]
  dev_direct_xmit+0x36c/0x6a0 net/core/dev.c:3930
  packet_direct_xmit+0xfb/0x170 net/packet/af_packet.c:246
  packet_snd net/packet/af_packet.c:2932 [inline]
  packet_sendmsg+0x298a/0x6ad0 net/packet/af_packet.c:2957
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  __sys_sendto+0x3d7/0x670 net/socket.c:1788
  __do_sys_sendto net/socket.c:1800 [inline]
  __se_sys_sendto net/socket.c:1796 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1796
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441eb9
Code: e8 4c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 04 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffee312ce58 EFLAGS: 00000212 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441eb9
RDX: 000000000000000e RSI: 0000000020000180 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000212 R12: 0000000000000000
R13: 00000000004028d0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 8368:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc+0xcb/0xd0 mm/kasan/common.c:482
  kasan_slab_alloc+0x12/0x20 mm/kasan/common.c:397
  kmem_cache_alloc+0x130/0x730 mm/slab.c:3541
  getname_flags+0xd0/0x590 fs/namei.c:140
  user_path_at_empty+0x2d/0x50 fs/namei.c:2608
  user_path_at include/linux/namei.h:57 [inline]
  do_faccessat+0x254/0x800 fs/open.c:378
  __do_sys_access fs/open.c:430 [inline]
  __se_sys_access fs/open.c:428 [inline]
  __x64_sys_access+0x59/0x80 fs/open.c:428
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8368:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3747
  putname+0xf2/0x130 fs/namei.c:261
  filename_lookup+0x39a/0x520 fs/namei.c:2357
  user_path_at_empty+0x40/0x50 fs/namei.c:2608
  user_path_at include/linux/namei.h:57 [inline]
  do_faccessat+0x254/0x800 fs/open.c:378
  __do_sys_access fs/open.c:430 [inline]
  __se_sys_access fs/open.c:428 [inline]
  __x64_sys_access+0x59/0x80 fs/open.c:428
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88809f96a2c0
  which belongs to the cache names_cache of size 4096
The buggy address is located 1931 bytes inside of
  4096-byte region [ffff88809f96a2c0, ffff88809f96b2c0)
The buggy address belongs to the page:
page:ffffea00027e5a80 count:1 mapcount:0 mapping:ffff88821bc49080 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0002810f08 ffffea00027d0388 ffff88821bc49080
raw: 0000000000000000 ffff88809f96a2c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809f96a900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809f96a980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88809f96aa00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                               ^
  ffff88809f96aa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809f96ab00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
