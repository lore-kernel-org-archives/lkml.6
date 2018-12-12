Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A540C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30542084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30542084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeLLLLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:11:06 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:43535 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeLLLLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:11:05 -0500
Received: by mail-io1-f70.google.com with SMTP id k4so16872973ioc.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 03:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=P2UPX8eAvHkTJnKSMu1/woxPWLn1kyg8nYmnnU6XRXc=;
        b=g2nINKPEraUpjfvqsvrkYkbV195NAh5x5GvMC1VjcCbYWiHKXv+GseZl8jmLgZsuke
         n8L+ZMFBkUnDPNJyw+9mQHF6B1wSvHmMd0NoBpxcE3y3x115SCLSMIme2Erj0tleU0D5
         ySQONAEfcNq/aKvp+2VzryQ37xcu7+BJM+MLbSG4xycmWVYmeiULK2PBItXhfUC5SRCE
         X1QKeflnttMk4hke6cdmMngp0y/Jk7uZpiweWXYLfMcTs3ThxdXiTVhD5Px3b5HnkByC
         dxiOBWkOh86mGVnnav8XAnlIkKXeq5VHW2uZpceGcsvBckOFTZLgkseioMdC52M+Zpwv
         Rzcw==
X-Gm-Message-State: AA+aEWZRH7WAOIpn2t/LhdMsxa9AJRWrYnwUaKtdFXHJdhUW2P53S8T4
        LUT1FaZjo9lBBmgKxljITKZgfztl8s7dOspdLknzDsWXeAHg
X-Google-Smtp-Source: AFSGD/UuY0TbqKbLWpvoxYoIiiKfajCWZvJ6nJOJ2T9DnTQHNKdR2rtvQylBHAzPd2vH4/T0VRgKU+n1/kzLxOzqSOxWiQDO3U3x
MIME-Version: 1.0
X-Received: by 2002:a02:8785:: with SMTP id t5mr16034860jai.10.1544613064247;
 Wed, 12 Dec 2018 03:11:04 -0800 (PST)
Date:   Wed, 12 Dec 2018 03:11:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000029056057cd141cb@google.com>
Subject: possible deadlock in neigh_change_state
From:   syzbot <syzbot+6a3c02010a025ac7b7cf@syzkaller.appspotmail.com>
To:     christian@brauner.io, davem@davemloft.net, dsahern@gmail.com,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        syzkaller-bugs@googlegroups.com, w.bumiller@proxmox.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    addb0679839a Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13320143400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9655b05acfc97ff
dashboard link: https://syzkaller.appspot.com/bug?extid=6a3c02010a025ac7b7cf
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13317705400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177bb01b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6a3c02010a025ac7b7cf@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0

======================================================
WARNING: possible circular locking dependency detected
4.20.0-rc6+ #338 Not tainted
------------------------------------------------------
syz-executor662/6051 is trying to acquire lock:
000000000d190a6e (&tbl->lock){+.-.}, at: neigh_change_state+0x1dc/0x7a0  
net/core/neighbour.c:141

but task is already holding lock:
000000006a610774 (&n->lock){++--}, at: __neigh_update+0xe6/0x1eb0  
net/core/neighbour.c:1203

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&n->lock){++--}:
        __raw_write_lock include/linux/rwlock_api_smp.h:210 [inline]
        _raw_write_lock+0x2d/0x40 kernel/locking/spinlock.c:288
        neigh_flush_dev+0x34f/0x960 net/core/neighbour.c:294
        neigh_changeaddr+0x31/0x40 net/core/neighbour.c:325
        ndisc_netdev_event+0xe6/0x5b0 net/ipv6/ndisc.c:1770
        notifier_call_chain+0x17e/0x380 kernel/notifier.c:93
        __raw_notifier_call_chain kernel/notifier.c:394 [inline]
        raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
        call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1737
        call_netdevice_notifiers_extack net/core/dev.c:1749 [inline]
        call_netdevice_notifiers net/core/dev.c:1763 [inline]
        dev_set_mac_address+0x293/0x3b0 net/core/dev.c:7780
        do_setlink+0x7c7/0x3f30 net/core/rtnetlink.c:2447
        __rtnl_newlink+0xcde/0x19e0 net/core/rtnetlink.c:3115
        rtnl_newlink+0x6b/0xa0 net/core/rtnetlink.c:3240
        rtnetlink_rcv_msg+0x46a/0xc20 net/core/rtnetlink.c:4969
        netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
        rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4987
        netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
        netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
        netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
        sock_sendmsg_nosec net/socket.c:621 [inline]
        sock_sendmsg+0xd5/0x120 net/socket.c:631
        ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
        __sys_sendmsg+0x11d/0x280 net/socket.c:2154
        __do_sys_sendmsg net/socket.c:2163 [inline]
        __se_sys_sendmsg net/socket.c:2161 [inline]
        __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&tbl->lock){+.-.}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
        __raw_write_lock_bh include/linux/rwlock_api_smp.h:203 [inline]
        _raw_write_lock_bh+0x31/0x40 kernel/locking/spinlock.c:312
        neigh_change_state+0x1dc/0x7a0 net/core/neighbour.c:141
        __neigh_update+0x478/0x1eb0 net/core/neighbour.c:1302
        neigh_update+0x37/0x50 net/core/neighbour.c:1372
        arp_req_set+0x54c/0xaa0 net/ipv4/arp.c:1072
        arp_ioctl+0x48b/0xae0 net/ipv4/arp.c:1230
        inet_ioctl+0x237/0x360 net/ipv4/af_inet.c:932
        sock_do_ioctl+0xeb/0x420 net/socket.c:950
        sock_ioctl+0x313/0x690 net/socket.c:1074
        vfs_ioctl fs/ioctl.c:46 [inline]
        file_ioctl fs/ioctl.c:509 [inline]
        do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
        ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
        __do_sys_ioctl fs/ioctl.c:720 [inline]
        __se_sys_ioctl fs/ioctl.c:718 [inline]
        __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&n->lock);
                                lock(&tbl->lock);
                                lock(&n->lock);
   lock(&tbl->lock);

  *** DEADLOCK ***

2 locks held by syz-executor662/6051:
  #0: 000000003d2094e6 (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:77
  #1: 000000006a610774 (&n->lock){++--}, at: __neigh_update+0xe6/0x1eb0  
net/core/neighbour.c:1203

stack backtrace:
CPU: 0 PID: 6051 Comm: syz-executor662 Not tainted 4.20.0-rc6+ #338
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_circular_bug.isra.35.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2347 [inline]
  __lock_acquire+0x3399/0x4c20 kernel/locking/lockdep.c:3341
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  __raw_write_lock_bh include/linux/rwlock_api_smp.h:203 [inline]
  _raw_write_lock_bh+0x31/0x40 kernel/locking/spinlock.c:312
  neigh_change_state+0x1dc/0x7a0 net/core/neighbour.c:141
  __neigh_update+0x478/0x1eb0 net/core/neighbour.c:1302
  neigh_update+0x37/0x50 net/core/neighbour.c:1372
  arp_req_set+0x54c/0xaa0 net/ipv4/arp.c:1072
  arp_ioctl+0x48b/0xae0 net/ipv4/arp.c:1230
  inet_ioctl+0x237/0x360 net/ipv4/af_inet.c:932
  sock_do_ioctl+0xeb/0x420 net/socket.c:950
  sock_ioctl+0x313/0x690 net/socket.c:1074
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441089
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc4143a2e8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000441089
RDX: 0000000020000000 RSI: 0000000000008955 RDI: 0000000000000003
RBP: 00000000006cc018 R08: 0000000000000100 R09: 0000000000000100
R10: 0000000000000020 R11: 0000000000000213 R12: 0000000000401ff0
R13: 0000000000402080 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
