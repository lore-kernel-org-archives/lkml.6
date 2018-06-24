Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FF3C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 04:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985C924DB7
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 04:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985C924DB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751083AbeFXEJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 00:09:04 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:49078 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbeFXEJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 00:09:02 -0400
Received: by mail-io0-f197.google.com with SMTP id t11-v6so8787126iog.15
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 21:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5JHEchusOTTYr20rtTXGl/P9cFYtGaNQbUfpNHH+IoI=;
        b=iisCMAPN5+aVD97B0mFOj7yI1U0ptVCUI8bshJo9JHgOShHB1hrEyyNruGUU4R0X7U
         +ZrdrvfxXUfDoa/+hrfgysfbdE0XLTh9u+ZBFmc6ZlsAJb4Ybu86R4IX7HFFMbi0C8J3
         OevlhLArizXX+oUq4GZAoKcnbdjbaOUH3WzUNcwiYCBQ2VVxoXk6LMWBaI0YTTfkxYym
         Y5ziJFbKEba1F9UBY5LU6EhLW+RMmm2hxtiIp++OBpLxD1qrAQri6Y69+E9qnGu9/OpX
         8oWH10FTgvdiF4q0xaa6Byjj5Yi0QgcJtnEeLpeOTTse/mGtf0xSlnPZtcPQmXa2n/Qa
         aYSg==
X-Gm-Message-State: APt69E3q2Xc6AS+nJbmS0IS8EyZrC1AO31f6tsfxWtrG+apSDHxcSAMz
        jzmwVSLZAIfCwyUIhsX0xTwkdZQOZWja05WEk8Qoo0ZP2ExX
X-Google-Smtp-Source: AAOMgpfLb5iSWbMIsndPWR1DTAcc7Q9IXXAMEpP7Qeh0DL5qSHRIt+FYGQWSdKYQWAceX6QBeu+P/af7G60X030Am7MNx6mlSsCY
MIME-Version: 1.0
X-Received: by 2002:a5e:8d11:: with SMTP id m17-v6mr3147798ioj.132.1529813342127;
 Sat, 23 Jun 2018 21:09:02 -0700 (PDT)
Date:   Sat, 23 Jun 2018 21:09:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d48c8e056f5b6c67@google.com>
Subject: BUG: unable to handle kernel paging request in bpf_int_jit_compile
From:   syzbot <syzbot+a4eb8c7766952a1ca872@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hpa@zytor.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5e2204832b20 Merge tag 'powerpc-4.18-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148b5a90400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=befbcd7305e41bb0
dashboard link: https://syzkaller.appspot.com/bug?extid=a4eb8c7766952a1ca872
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10ee22d4400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a4eb8c7766952a1ca872@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 0000000001429914 RCX: 0000000000455a99
RDX: 0000000000000048 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: 00000000004bb7d5 R14: 00000000004c8508 R15: 0000000000000023
BUG: unable to handle kernel paging request at ffffffffa0008002
PGD 8e6d067 P4D 8e6d067 PUD 8e6e063 PMD 1b4528067 PTE 1d433d161
Oops: 0003 [#1] SMP KASAN
CPU: 1 PID: 4811 Comm: syz-executor0 Not tainted 4.18.0-rc1+ #114
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_jit_binary_lock_ro include/linux/filter.h:703 [inline]
RIP: 0010:bpf_int_jit_compile+0xc36/0xf30 arch/x86/net/bpf_jit_comp.c:1168
Code: b8 00 00 00 00 00 fc ff df 48 c1 ea 03 0f b6 04 02 4c 89 f2 83 e2 07  
38 d0 7f 08 84 c0 0f 85 a0 02 00 00 48 8b 85 00 ff ff ff <80> 60 02 fe e9  
c7 fb ff ff e8 ac 00 36 00 48 8b 8d 30 ff ff ff 48
RSP: 0018:ffff8801cfca7998 EFLAGS: 00010246
RAX: ffffffffa0008000 RBX: 0000000000000046 RCX: ffffffff81460e4a
RDX: 0000000000000002 RSI: ffffffff81460e58 RDI: 0000000000000005
RBP: ffff8801cfca7ab8 R08: ffff8801aa2121c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90001938002
R13: ffff8801cfca7a90 R14: ffffffffa0008002 R15: 00000000fffffff4
FS:  0000000001429940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffa0008002 CR3: 00000001d2c40000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  bpf_prog_select_runtime+0x7db/0xa60 kernel/bpf/core.c:1505
  bpf_prog_load+0x1194/0x1c60 kernel/bpf/syscall.c:1356
  __do_sys_bpf kernel/bpf/syscall.c:2360 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2322 [inline]
  __x64_sys_bpf+0x36c/0x510 kernel/bpf/syscall.c:2322
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455a99
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd396676f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000001429914 RCX: 0000000000455a99
RDX: 0000000000000048 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: 00000000004bb7d5 R14: 00000000004c8508 R15: 0000000000000023
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: ffffffffa0008002
---[ end trace fa548fc30dca8c15 ]---
RIP: 0010:bpf_jit_binary_lock_ro include/linux/filter.h:703 [inline]
RIP: 0010:bpf_int_jit_compile+0xc36/0xf30 arch/x86/net/bpf_jit_comp.c:1168
Code: b8 00 00 00 00 00 fc ff df 48 c1 ea 03 0f b6 04 02 4c 89 f2 83 e2 07  
38 d0 7f 08 84 c0 0f 85 a0 02 00 00 48 8b 85 00 ff ff ff <80> 60 02 fe e9  
c7 fb ff ff e8 ac 00 36 00 48 8b 8d 30 ff ff ff 48
RSP: 0018:ffff8801cfca7998 EFLAGS: 00010246
RAX: ffffffffa0008000 RBX: 0000000000000046 RCX: ffffffff81460e4a
RDX: 0000000000000002 RSI: ffffffff81460e58 RDI: 0000000000000005
RBP: ffff8801cfca7ab8 R08: ffff8801aa2121c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90001938002
R13: ffff8801cfca7a90 R14: ffffffffa0008002 R15: 00000000fffffff4
FS:  0000000001429940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffa0008002 CR3: 00000001d2c40000 CR4: 00000000001406e0
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
