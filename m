Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C738AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C86120867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C86120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeIRDCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 23:02:13 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:59599 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbeIRDCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 23:02:12 -0400
Received: by mail-it0-f70.google.com with SMTP id a10-v6so280774itc.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 14:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=peki7EY8jnSLuZO/yWgLoTkkoycLdrIC1mAlvuYdh8U=;
        b=ShiOJrO7fsdRL8Pikdg7+zh6pymShSnQZ7dT1SmIOLiV6hW5+WOa2dEeWvzuLdxT5u
         d9MZUMtEgTu9YdLU2CToZob82FbjmsuWlas/1M2D6cAv83ooUE/2RjM8DVSunUhteSXU
         4OSFuFaRMHBpQGRsQeQineguoqsPyXnhspTyojIv1sw2HlAemI0DGhVKbxMsWGOzPkFk
         Qffcskii4gImHzbDGit0h/ExjK4zedJ/UqcIv0l54J9BpuJ7V6PMqfqkTY3cRgfA8ncN
         JdLKNJzHclWwOdOTC/8Wo6Vt1ZWXvv4qL8r4RXGDyn2UzWrTLWpPEqWuw1qudIroKo/G
         q9iw==
X-Gm-Message-State: APzg51BzqWrU2HAKeowwARVEUU7o6AR/rk7gQRfyC7fZQsVPPHYNu/Jy
        JurfWh0TS2KQwimeqsJYGmmpRUNtQaat/HD0oYjTf2QKeusx
X-Google-Smtp-Source: ANB0Vdabnbgp2P4oCi6L7scmSAuSjKVmrM33oXRImS8p0vcN/+rbkAm9FNF4szNE1cAJZIkYKWSCpTMRgN4vPkfDLiP9vhyPjnyC
MIME-Version: 1.0
X-Received: by 2002:a24:4643:: with SMTP id j64-v6mr13881948itb.18.1537219983690;
 Mon, 17 Sep 2018 14:33:03 -0700 (PDT)
Date:   Mon, 17 Sep 2018 14:33:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011d524057617eb4a@google.com>
Subject: KMSAN: uninit-value in __dev_mc_del
From:   syzbot <syzbot+0ffee94c5c059dbbc2a9@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sunlw.fnst@cn.fujitsu.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5815ca49bf07 Temporarily revert "Revert "kmsan: don't trac..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=14dafb66400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6be230b6f0ad3490
dashboard link: https://syzkaller.appspot.com/bug?extid=0ffee94c5c059dbbc2a9
compiler:       clang version 8.0.0 (trunk 339414)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1417c62a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ce684e400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0ffee94c5c059dbbc2a9@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
==================================================================
BUG: KMSAN: uninit-value in memcmp+0x11d/0x180 lib/string.c:863
CPU: 1 PID: 4510 Comm: syz-executor267 Not tainted 4.19.0-rc3+ #48
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x14b/0x190 lib/dump_stack.c:113
  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
  memcmp+0x11d/0x180 lib/string.c:863
  __hw_addr_del_ex net/core/dev_addr_lists.c:123 [inline]
  __dev_mc_del+0x169/0x6c0 net/core/dev_addr_lists.c:710
  dev_mc_del+0x6d/0x80 net/core/dev_addr_lists.c:728
  ip_mc_filter_del net/ipv4/igmp.c:1129 [inline]
  igmp_group_dropped+0x21a/0x1280 net/ipv4/igmp.c:1262
  ip_mc_down+0x1d9/0x3e0 net/ipv4/igmp.c:1712
  inetdev_event+0x238/0x1d70 net/ipv4/devinet.c:1522
  notifier_call_chain kernel/notifier.c:93 [inline]
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x13e/0x240 kernel/notifier.c:401
  call_netdevice_notifiers_info net/core/dev.c:1733 [inline]
  call_netdevice_notifiers net/core/dev.c:1751 [inline]
  dev_close_many+0x627/0x9e0 net/core/dev.c:1503
  rollback_registered_many+0x9eb/0x2040 net/core/dev.c:7929
  rollback_registered net/core/dev.c:7994 [inline]
  unregister_netdevice_queue+0x547/0xa40 net/core/dev.c:9038
  unregister_netdevice include/linux/netdevice.h:2589 [inline]
  __tun_detach+0x220c/0x2c70 drivers/net/tun.c:729
  tun_detach drivers/net/tun.c:746 [inline]
  tun_chr_close+0xda/0x1c0 drivers/net/tun.c:3272
  __fput+0x4cf/0xc20 fs/file_table.c:278
  ____fput+0x37/0x40 fs/file_table.c:309
  task_work_run+0x22e/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop arch/x86/entry/common.c:166 [inline]
  prepare_exit_to_usermode+0x33e/0x410 arch/x86/entry/common.c:197
  syscall_return_slowpath+0xdb/0x700 arch/x86/entry/common.c:268
  do_syscall_64+0xde/0x100 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x401540
Code: 01 f0 ff ff 0f 83 b0 0a 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f  
44 00 00 83 3d ed 22 2d 00 00 75 14 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 84 0a 00 00 c3 48 83 ec 08 e8 3a 01 00 00
RSP: 002b:00007fffbb917ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000401540
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00000000006cc018 R08: 0000000000000100 R09: 0000000000000100
R10: 0000000000000100 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000004024e0 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----buf.i@igmp_group_dropped
Variable was created at:
  igmp_group_dropped+0x49/0x1280 net/ipv4/igmp.c:1253
  ip_mc_down+0x1d9/0x3e0 net/ipv4/igmp.c:1712
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
