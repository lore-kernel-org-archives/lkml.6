Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC483ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD4320882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD4320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeINXip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:38:45 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:53494 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeINXip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:38:45 -0400
Received: by mail-io1-f71.google.com with SMTP id h20-v6so9485614iob.20
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 11:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dA3z8t4KZONv9tgd5JM9kMouiAmGD4FgYgsVKK+y0ro=;
        b=suG8pIKPw0V4NTLA04vzZSGVJVIGXI/gBFmsGQp7JxXFDjt5pdW7ggyhRFPwbjoCxZ
         4WTfkWy0XjPr5d6h3TfczIaOfdyUSOGLkv1LMYzg+2akebPIqa7fIKRa3EYtcGwxA5JZ
         oDXCPBQjT/5QvV2HKaeAencaf7IIQ7YdpQqEDtqAojYyOqHXkTzRaEeQ9JRyKdiN0I2o
         MuHYNwOB8lBiIKyp0qaopIwXy8d+1EfbPfDVut3tgKkCiweNdZVOYR16Dq3bIAgrbMmX
         x1g8sRGx8LJR8d/r9OtWs61MQoMgeR828IQJ4aY+DmeItrWNoWIksgZOfFX29r+RAUSC
         P+cw==
X-Gm-Message-State: APzg51BbDXBeTFFwaYC1na2gRKP3NAO0hSYzjbcfjYjL0wBprcrwlx4y
        qLEdBh9PDZBz/+KuMUOMltwX7eEApkMB1kgnd7vyW27ml2gt
X-Google-Smtp-Source: ANB0VdbjFXhHmmMEUb+Wev1eT8qwPYZqhaFrtfhPZXAypyvWwkkv3UhFZjbqJ2Iz02VQFjci43xqhgX74cKFPgT242UrJFjgDW+G
MIME-Version: 1.0
X-Received: by 2002:a24:2944:: with SMTP id p65-v6mr3131655itp.49.1536949384222;
 Fri, 14 Sep 2018 11:23:04 -0700 (PDT)
Date:   Fri, 14 Sep 2018 11:23:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015a13b0575d8eae8@google.com>
Subject: KMSAN: uninit-value in do_ip_vs_set_ctl
From:   syzbot <syzbot+23b5f9e7caf61d9a3898@syzkaller.appspotmail.com>
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

HEAD commit:    06b2df0593a8 kmsan: unpoison only the created pages in get..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=11a6ae37800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ca1e57bafa8ab1f
dashboard link: https://syzkaller.appspot.com/bug?extid=23b5f9e7caf61d9a3898
compiler:       clang version 7.0.0 (trunk 329391)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14008417800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11deb017800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+23b5f9e7caf61d9a3898@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KMSAN: uninit-value in do_ip_vs_set_ctl+0x15ac/0x2760  
net/netfilter/ipvs/ip_vs_ctl.c:2424
CPU: 1 PID: 4464 Comm: syz-executor844 Not tainted 4.17.0-rc3+ #94
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1084
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
  do_ip_vs_set_ctl+0x15ac/0x2760 net/netfilter/ipvs/ip_vs_ctl.c:2424
  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
  nf_setsockopt+0x476/0x4d0 net/netfilter/nf_sockopt.c:115
  ip_setsockopt+0x24b/0x2b0 net/ipv4/ip_sockglue.c:1253
  raw_setsockopt+0x2e5/0x350 net/ipv4/raw.c:868
  sock_common_setsockopt+0x136/0x170 net/core/sock.c:3039
  __sys_setsockopt+0x4af/0x560 net/socket.c:1903
  __do_sys_setsockopt net/socket.c:1914 [inline]
  __se_sys_setsockopt net/socket.c:1911 [inline]
  __x64_sys_setsockopt+0x15c/0x1c0 net/socket.c:1911
  do_syscall_64+0x154/0x220 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x43fca9
RSP: 002b:00007fff7a4795b8 EFLAGS: 00000213 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fca9
RDX: 0000000000000480 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 00000000004015d0
R13: 0000000000401660 R14: 0000000000000000 R15: 0000000000000000

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
