Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeDBGBl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:01:41 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:48165 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbeDBGBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:01:04 -0400
X-Google-Smtp-Source: AIpwx48qaJxOh6bqjQ4pMMDp5hQQXhFDX1dqQVpXFqTLJrfIsj5W/WwsOIdYaWlkilmD1sQemjaNPSopQ7p8MlEvDLNdEKoZY9rG
MIME-Version: 1.0
Date: Sun, 01 Apr 2018 23:01:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5390a0568d7508a@google.com>
Subject: KASAN: stack-out-of-bounds Read in xfrm_state_find (5)
From: syzbot <syzbot+d90468452f685a0b28eb@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
10b84daddbec72c6b440216a69de9a9605127f7a (Sat Mar 31 17:59:00 2018 +0000)
Merge branch 'perf-urgent-for-linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=d90468452f685a0b28eb

So far this crash happened 4 times on net-next, upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6686969799114752
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5121263362113536
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5897355362566144
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d90468452f685a0b28eb@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

==================================================================
BUG: KASAN: stack-out-of-bounds in xfrm_state_find+0x30de/0x3210  
net/xfrm/xfrm_state.c:1051
Read of size 4 at addr ffff8801b25ef480 by task syzkaller538986/4480

CPU: 0 PID: 4480 Comm: syzkaller538986 Not tainted 4.16.0-rc7+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  print_address_description+0x73/0x250 mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report+0x23c/0x360 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  xfrm_state_find+0x30de/0x3210 net/xfrm/xfrm_state.c:1051
  xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:1393 [inline]
  xfrm_tmpl_resolve+0x2ee/0xc40 net/xfrm/xfrm_policy.c:1437
  xfrm_resolve_and_create_bundle+0x184/0x28d0 net/xfrm/xfrm_policy.c:1833
  xfrm_lookup+0xfcb/0x25c0 net/xfrm/xfrm_policy.c:2163
  xfrm_lookup_route+0x39/0x1a0 net/xfrm/xfrm_policy.c:2283
  ip_route_output_flow+0x7c/0xa0 net/ipv4/route.c:2583
  udp_sendmsg+0x19bd/0x2f70 net/ipv4/udp.c:1012
  udpv6_sendmsg+0x757/0x3400 net/ipv6/udp.c:1156
  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:764
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg+0xca/0x110 net/socket.c:640
  ___sys_sendmsg+0x767/0x8b0 net/socket.c:2046
  __sys_sendmsg+0xe5/0x210 net/socket.c:2080
  SYSC_sendmsg net/socket.c:2091 [inline]
  SyS_sendmsg+0x2d/0x50 net/socket.c:2087
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x440139
RSP: 002b:00007fffa14c36e8 EFLAGS: 00000217 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440139
RDX: 0000000000000000 RSI: 0000000020000580 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000000000e8 R11: 0000000000000217 R12: 0000000000401a60
R13: 0000000000401af0 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea0006c97bc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: 0000000000000000 ffffea0006c90101 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b25ef380: f2 00 f2 f2 f2 f2 f2 f2 f2 f8 f2 f2 f2 f2 f2 f2
  ffff8801b25ef400: f2 00 00 00 00 f2 f2 f2 f2 00 00 00 00 00 00 00
> ffff8801b25ef480: f2 f2 f2 f2 f2 00 00 00 00 00 00 00 00 00 f2 f2
                    ^
  ffff8801b25ef500: f2 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801b25ef580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
==================================================================


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
