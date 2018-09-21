Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277B2ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88EF21568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88EF21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390935AbeIUXNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:13:55 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:35825 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390180AbeIUXNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:13:54 -0400
Received: by mail-io1-f70.google.com with SMTP id z20-v6so17135934ioh.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NKtriFQcbLeTwO4bQVvJmnvFL/kqZrxU1mm0q2f+PxU=;
        b=BJ07T1CsAcXEtoj09Xne+gO/YgZcjtv0bLWzodqbnErz3RQ35sy1zuiU+e0mNcEg4h
         8K+ZesQB+9pUVPxBjcgi3vSiD9bD9+cjvtDtMjDAdk+pbQY16A8G/ZqAILO+wJE+Nbis
         hq75yTpP7jq3kF07FcF/JliIDU5r4yLc2jiv7uF2lRuY4Hy1Y3fP7flSA2fbUkYU2Ijw
         12s80klEoLbGlQkBTA7jYfHRMPaGtWHDd7OtCeqzjP4tPfl3woWQSBpNAaK1ZiJl4mfq
         +r396W2W5Kw8c2Whjk6MzomozM8ffb85CA/Y9ytn58/xEWGXd50IgUPwWNQ+2sMvNvjN
         alpA==
X-Gm-Message-State: APzg51CK1mOj3qkbA/CxRcICZHGx51l7jM535L8rOP8RXKR3R17dfHtn
        E+TPH0JZP0WKUm50h4fwOikuXBed9i+QEzbEWjQptT+mUYFt
X-Google-Smtp-Source: ANB0VdYcLt1dri8OcXrfApHZhqhrK6xu9NkwJ4/pUKTiYVXBPfWp+kFOzetXVcKBxbzaoRIQsOmoDQBYUpErI6Rk2ty7HWgl6/QY
MIME-Version: 1.0
X-Received: by 2002:a6b:2953:: with SMTP id p80-v6mr35425552iop.120.1537550642597;
 Fri, 21 Sep 2018 10:24:02 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:24:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e058cc057664e752@google.com>
Subject: KMSAN: uninit-value in tipc_nl_compat_dumpit
From:   syzbot <syzbot+6bdb590321a7ae40c1a6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    74ee2200b89f kmsan: bump .config.example to v4.17-rc3
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=1164f197800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ca1e57bafa8ab1f
dashboard link: https://syzkaller.appspot.com/bug?extid=6bdb590321a7ae40c1a6
compiler:       clang version 7.0.0 (trunk 329391)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15341157800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17410147800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6bdb590321a7ae40c1a6@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KMSAN: uninit-value in tipc_nl_compat_dumpit+0x490/0x870  
net/tipc/netlink_compat.c:245
CPU: 0 PID: 4507 Comm: syz-executor018 Not tainted 4.17.0-rc3+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
  tipc_nl_compat_dumpit+0x490/0x870 net/tipc/netlink_compat.c:245
  tipc_nl_compat_handle net/tipc/netlink_compat.c:1108 [inline]
  tipc_nl_compat_recv+0x1394/0x2700 net/tipc/netlink_compat.c:1204
  genl_family_rcv_msg net/netlink/genetlink.c:599 [inline]
  genl_rcv_msg+0x1686/0x1810 net/netlink/genetlink.c:624
  netlink_rcv_skb+0x378/0x600 net/netlink/af_netlink.c:2448
  genl_rcv+0x63/0x80 net/netlink/genetlink.c:635
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x166b/0x1740 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x1072/0x1370 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg net/socket.c:639 [inline]
  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2117
  __sys_sendmsg net/socket.c:2155 [inline]
  __do_sys_sendmsg net/socket.c:2164 [inline]
  __se_sys_sendmsg net/socket.c:2162 [inline]
  __x64_sys_sendmsg+0x331/0x460 net/socket.c:2162
  do_syscall_64+0x154/0x220 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x445599
RSP: 002b:00007f4c1ecc6db8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000006dac24 RCX: 0000000000445599
RDX: 0000000000000000 RSI: 0000000020023000 RDI: 0000000000000003
RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe5ef31bcf R14: 00007f4c1ecc79c0 R15: 0000000000000001

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan.c:321
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2753 [inline]
  __kmalloc_node_track_caller+0xb32/0x11b0 mm/slub.c:4395
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:988 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
  netlink_sendmsg+0x76e/0x1370 net/netlink/af_netlink.c:1876
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg net/socket.c:639 [inline]
  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2117
  __sys_sendmsg net/socket.c:2155 [inline]
  __do_sys_sendmsg net/socket.c:2164 [inline]
  __se_sys_sendmsg net/socket.c:2162 [inline]
  __x64_sys_sendmsg+0x331/0x460 net/socket.c:2162
  do_syscall_64+0x154/0x220 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
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
