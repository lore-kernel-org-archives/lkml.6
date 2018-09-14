Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0FAECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CBE20833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CBE20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeINXip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:38:45 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:44012 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINXip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:38:45 -0400
Received: by mail-it0-f71.google.com with SMTP id z72-v6so3809829itc.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 11:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1WjQh3CAFjEkWFn8xEcS8zIynhjs0gEePTku7pZC9rM=;
        b=tlKD6QMR3zebECeV0kDt8DakYVBliKaU3qwJIOtZAAiuB0hbDJru7YPVwcCQB+PTCF
         nWV1usLCVvkc3CAl4nSomCFdqtFVoXM6CX5nHF3RrP2y1v4AYYAqCKUpO7cp/72d2pU0
         ESxiftgYA0FcTpoEui0c8K07jd7tyfE4MKkzBy2Q3b5kjRJAmMZFSl0rSo/MLzhbt0LV
         3cbQU1zcOpXAxL4r7s+rSpvpMdP4X0D8iwcWsnsSPBYjOIPkZVekCCj9wdvEmKCuKmhC
         IKoNGG0b/My8k9fuujRiy1J5Jww4rUSB5W3Xcqfn5RTS863abvX7VqOlpwKHLSvNJluc
         sAWQ==
X-Gm-Message-State: APzg51DHDbivOXig9jmWRzJPhLEoKB5paMvBm/dfDnCc3Enc6cWd5oHY
        TB2jElmftXwD/WKsAkTWfT9+z1q/S6iX0G0gW4UG4q0ZiEGY
X-Google-Smtp-Source: ANB0VdYwCBG3ZKrWBZQkaqrciHRzadAu+ZJkdqBRJsDgVvvKs18jbZAB3L8r2YxwdCwKqQKtoxq53IDZvlyMyJzzLazARyK3mjZ4
MIME-Version: 1.0
X-Received: by 2002:a02:4ad2:: with SMTP id s79-v6mr10690725jad.50.1536949384002;
 Fri, 14 Sep 2018 11:23:04 -0700 (PDT)
Date:   Fri, 14 Sep 2018 11:23:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012463d0575d8eace@google.com>
Subject: KMSAN: uninit-value in strlcpy (2)
From:   syzbot <syzbot+c86cf7903306a6c201ba@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        horms@verge.net.au, ja@ssi.bg, kadlec@blackhole.kfki.hu,
        linux-kernel@vger.kernel.org, lvs-devel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        wensong@linux-vs.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9822946c7fee kmsan: update .config.example to v4.17-rc5
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=169a5197800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9fa436d3ae606638
dashboard link: https://syzkaller.appspot.com/bug?extid=c86cf7903306a6c201ba
compiler:       clang version 7.0.0 (trunk 329391)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d1b87b800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11235417800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c86cf7903306a6c201ba@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KMSAN: uninit-value in strlen lib/string.c:482 [inline]
BUG: KMSAN: uninit-value in strlcpy+0x68/0x1c0 lib/string.c:142
CPU: 0 PID: 4506 Comm: syz-executor160 Not tainted 4.17.0-rc5+ #95
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1084
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
  strlen lib/string.c:482 [inline]
  strlcpy+0x68/0x1c0 lib/string.c:142
  do_ip_vs_set_ctl+0x3f1/0x2760 net/netfilter/ipvs/ip_vs_ctl.c:2384
  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
  nf_setsockopt+0x476/0x4d0 net/netfilter/nf_sockopt.c:115
  ip_setsockopt+0x24b/0x2b0 net/ipv4/ip_sockglue.c:1253
  udp_setsockopt+0x108/0x1b0 net/ipv4/udp.c:2416
  ipv6_setsockopt+0x30c/0x340 net/ipv6/ipv6_sockglue.c:917
  tcp_setsockopt+0x1bb/0x1f0 net/ipv4/tcp.c:2891
  sock_common_setsockopt+0x136/0x170 net/core/sock.c:3039
  __sys_setsockopt+0x4af/0x560 net/socket.c:1903
  __do_sys_setsockopt net/socket.c:1914 [inline]
  __se_sys_setsockopt net/socket.c:1911 [inline]
  __x64_sys_setsockopt+0x15c/0x1c0 net/socket.c:1911
  do_syscall_64+0x154/0x220 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x43fce9
RSP: 002b:00007ffea6b1dd08 EFLAGS: 00000213 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fce9
RDX: 000000000000048b RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000018 R09: 00000000004002c8
R10: 00000000200001c0 R11: 0000000000000213 R12: 0000000000401610
R13: 00000000004016a0 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----arg@do_ip_vs_set_ctl
Variable was created at:
  read_pnet include/net/net_namespace.h:288 [inline]
  sock_net include/net/sock.h:2306 [inline]
  do_ip_vs_set_ctl+0x93/0x2760 net/netfilter/ipvs/ip_vs_ctl.c:2347
  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
  nf_setsockopt+0x476/0x4d0 net/netfilter/nf_sockopt.c:115
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
