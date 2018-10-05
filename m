Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E38C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D31320644
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D31320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeJFFYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:24:50 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:53436 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeJFFYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:24:50 -0400
Received: by mail-it1-f200.google.com with SMTP id f79-v6so3888577ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 15:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LfN1MiSRcGscbkyKOAOm6lWyk1TPDsb6sUqbo9++KRk=;
        b=MzjMgOiXqpITvco5c8F0VT2GvciXBCxk+2NtHYCG8zG9g7WSRJYVvMj1WwQjhbz1So
         N4Y2U8PE/PJ1+soOYi1nHKoLOIPFMbkCsxYuBlx/1aKrD+PK2GS4G2npSs5GzlGM9Yec
         XwqDE1T0iMHawtFCd2xElFwkAJTaYxEkncEqFcLpEJbkmSYDc6P1SYS/UKfQRUpv05WK
         sMQTkDxe9ZGF0L/QNAAJkkIoxr0wbV5H8HWpRzbdDRr6toW56M2G+VuefQmw0a/Cu519
         CfKugmE60zGKL9SqPLFlD/hhSXBD2ueCxrayRWvCcNlvRcO5ZdDw+1ybLn5IRK/NlHa+
         E3Sw==
X-Gm-Message-State: ABuFfoij5SY8QIaoJdo3XPCUXddsGgWv3UhTm1dhGrSMaCSJM6ugTdgr
        FyCE0g017FXB00ICqFpvydcVx4Ll0Cf+nAbp0x6gxN31tlml
X-Google-Smtp-Source: ACcGV62DIPwHX8MyQ+9cCfMaOCsTIruBhN1ozF+FX28cLTjOsyqEU5xMDtIbhhwd1CjmEqPDVl/Y1mJGa76QCcMFJfWFHKMEp9/F
MIME-Version: 1.0
X-Received: by 2002:a02:8981:: with SMTP id p1-v6mr10185158jaj.7.1538778243874;
 Fri, 05 Oct 2018 15:24:03 -0700 (PDT)
Date:   Fri, 05 Oct 2018 15:24:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d47b2057782bab4@google.com>
Subject: general protection fault in __handle_mm_fault
From:   syzbot <syzbot+1577fbe983d20fe2e88f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    25bcda3e8b9f Add linux-next specific files for 20181004
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=130e3bf1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=603d7f9140c3368a
dashboard link: https://syzkaller.appspot.com/bug?extid=1577fbe983d20fe2e88f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127e88d6400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cdb67e400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1577fbe983d20fe2e88f@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
nf_conntrack: default automatic helper assignment has been turned off for  
security reasons and CT-based  firewall rule not found. Use the iptables CT  
target to attach helpers instead.
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6015 Comm: syz-executor196 Not tainted  
4.19.0-rc6-next-20181004+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:do_fault mm/memory.c:3524 [inline]
RIP: 0010:handle_pte_fault mm/memory.c:3762 [inline]
RIP: 0010:__handle_mm_fault+0x2d72/0x55c0 mm/memory.c:3886
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 87 20 00 00 49 8b 9c 24 b0 fe  
ff ff 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f  
85 57 20 00 00 48 8b 1b 31 ff 48 83 e3 9f 48 89 de
RSP: 0018:ffff8801bbe66fc0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8160f791
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8801bbe670f8
RBP: ffff8801bbe67270 R08: ffffed0039d485ae R09: ffffed0039d485ad
R10: ffffed0039d485ad R11: ffff8801cea42d6b R12: ffff8801bbe67248
R13: ffff8801bbc7e800 R14: ffff8801d1759f40 R15: 0000000000000067
FS:  0000000001c6a880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020077000 CR3: 00000001d79be000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  handle_mm_fault+0x54f/0xc70 mm/memory.c:3923
  __do_page_fault+0x567/0xd10 arch/x86/mm/fault.c:1355
  do_page_fault+0xed/0x7d1 arch/x86/mm/fault.c:1430
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1139
RIP: 0010:copy_user_enhanced_fast_string+0xe/0x20  
arch/x86/lib/copy_user_64.S:180
Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f  
80 00 00 00 00 0f 1f 00 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3> a4 31 c0 0f  
1f 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 83
RSP: 0018:ffff8801bbe675b8 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000007a50 RCX: 0000000000001b40
RDX: 0000000000007a50 RSI: 0000000020077000 RDI: ffff8801ce615f10
RBP: ffff8801bbe675f0 R08: ffffed0039cc2f4a R09: ffffed0039cc2f4a
R10: ffffed0039cc2f49 R11: ffff8801ce617a4f R12: 0000000020078b40
R13: 00000000200710f0 R14: ffff8801ce610000 R15: 00007ffffffff000
  _copy_from_iter_full+0x263/0xc20 lib/iov_iter.c:724
  copy_from_iter_full include/linux/uio.h:124 [inline]
  skb_do_copy_data_nocache include/net/sock.h:1951 [inline]
  skb_copy_to_page_nocache include/net/sock.h:1977 [inline]
  tcp_sendmsg_locked+0x159e/0x3f90 net/ipv4/tcp.c:1338
  tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1443
  inet_sendmsg+0x19c/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:632
  __sys_sendto+0x3d7/0x670 net/socket.c:1789
  __do_sys_sendto net/socket.c:1801 [inline]
  __se_sys_sendto net/socket.c:1797 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1797
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441159
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc1def2948 EFLAGS: 00000217 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000441159
RDX: fffffffffffffee3 RSI: 0000000020000b40 RDI: 0000000000000003
RBP: 00000000006cc018 R08: 0000000000000000 R09: ffffffffffffff61
R10: 00000000040000cb R11: 0000000000000217 R12: 00000000004020c0
R13: 0000000000402150 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace d2b868b55677c602 ]---
RIP: 0010:do_fault mm/memory.c:3524 [inline]
RIP: 0010:handle_pte_fault mm/memory.c:3762 [inline]
RIP: 0010:__handle_mm_fault+0x2d72/0x55c0 mm/memory.c:3886
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 87 20 00 00 49 8b 9c 24 b0 fe  
ff ff 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f  
85 57 20 00 00 48 8b 1b 31 ff 48 83 e3 9f 48 89 de
RSP: 0018:ffff8801bbe66fc0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8160f791
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8801bbe670f8
RBP: ffff8801bbe67270 R08: ffffed0039d485ae R09: ffffed0039d485ad
R10: ffffed0039d485ad R11: ffff8801cea42d6b R12: ffff8801bbe67248
R13: ffff8801bbc7e800 R14: ffff8801d1759f40 R15: 0000000000000067
FS:  0000000001c6a880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020077000 CR3: 00000001d79be000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
