Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952A2C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC822086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC822086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeLKUXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:23:06 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:38817 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeLKUXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:23:05 -0500
Received: by mail-it1-f197.google.com with SMTP id m128so3563182itd.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 12:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/5fVjzsNSPqMZr2Efw3HSBQwqqn+4DvNeMyjRy7Aq54=;
        b=PpgDV2e6I0VhPMacMNwuwIAPou3n82nG6BjflCOJz3a0T30D67qcKzRXVTchPROR2T
         myCISn49k0N8LtZtRv0bqG78uOrg/+6FdvVthBS8ICC547AXh98VRCaPOSH3YDwrj+sm
         LfUwGJQGd/JCY3EBfR011EqpG+DFGyXmMR5UGHoztpK06F82tEL1YdsFq7muNMYONGpS
         oaydNFUOVQuMbrhW0bw1I+d3GqucE7pblDzZ0axtnY4lVDDrssIZtjbwiCXdQNKkEtCE
         3YPhqey4F/HZYvREEoTGShME3g4Jn9AbS3GW9dHKw2vAR1UPvT0Bs4tjX+q0zVLmUZHX
         TWSQ==
X-Gm-Message-State: AA+aEWZZqcIgQ4f/xAHBjaHtId7p/dTquROAr6cPkMfJoodQG9mFypUG
        hFHMbrG2iWd7PrHvFZurdHUplwulFZLOIMT+cuz8xqL1yJxX
X-Google-Smtp-Source: AFSGD/UiLKgmY6DXhiQbrd7T/piP6JyLSTz/KSKhc6rCYW4aCcWOE/kWJm/FeySbK1H/4XCaqQ24Q5ZtXCruH7j3R04NCkRlY1Gs
MIME-Version: 1.0
X-Received: by 2002:a24:3603:: with SMTP id l3mr2774152itl.11.1544559785004;
 Tue, 11 Dec 2018 12:23:05 -0800 (PST)
Date:   Tue, 11 Dec 2018 12:23:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051ee78057cc4d98f@google.com>
Subject: general protection fault in put_pid
From:   syzbot <syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, ktsanaktsidis@zendesk.com,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135bc547400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16803afb400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com

kmem_cache               221KB        225KB
Out of memory: Kill process 6139 (syz-execprog) score 1 or sacrifice child
Killed process 6164 (syz-executor0) total-vm:37444kB, anon-rss:60kB,  
file-rss:0kB, shmem-rss:0kB
oom_reaper: reaped process 6164 (syz-executor0), now anon-rss:0kB,  
file-rss:0kB, shmem-rss:0kB
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6159 Comm: syz-executor3 Not tainted 4.20.0-rc6+ #151
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:put_pid.part.3+0xb6/0x240 kernel/pid.c:108
Code: d2 0f 85 89 01 00 00 44 8b 63 04 49 8d 44 24 03 48 c1 e0 04 48 8d 7c  
03 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 66 01 00 00 49 83 c4 03 be 04 00 00 00 48 89 df
RSP: 0018:ffff8881ae116e78 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff816149a0 RCX: ffffffff833e420e
RDX: 00000001933eab7c RSI: ffffffff8152bf8e RDI: 0000000c99f55be0
RBP: ffff8881ae116f08 R08: ffff8881cdbf2300 R09: fffff52001507600
R10: fffff52001507600 R11: ffffc9000a83b003 R12: 00000000d1894120
R13: 1ffff11035c22dd0 R14: ffff8881ae116ee0 R15: dffffc0000000000
FS:  000000000166d940(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000075c458 CR3: 00000001d2bd1000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  put_pid+0x1f/0x30 kernel/pid.c:105
  ipc_update_pid ipc/util.h:159 [inline]
  freeary+0x10c8/0x1a40 ipc/sem.c:1167
  free_ipcs+0x9f/0x1c0 ipc/namespace.c:112
  sem_exit_ns+0x20/0x40 ipc/sem.c:237
  free_ipc_ns ipc/namespace.c:120 [inline]
  put_ipc_ns+0x66/0x180 ipc/namespace.c:152
  free_nsproxy+0xcf/0x220 kernel/nsproxy.c:180
  switch_task_namespaces+0xb3/0xd0 kernel/nsproxy.c:229
  exit_task_namespaces+0x17/0x20 kernel/nsproxy.c:234
  do_exit+0x1ad1/0x26d0 kernel/exit.c:866
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2517
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode+0x342/0x3b0 arch/x86/entry/common.c:197
  retint_user+0x8/0x18
RIP: 0033:0x45a4d0
Code: 10 44 00 00 00 e8 c0 cc ff ff 0f b6 44 24 18 eb c2 e8 44 ad ff ff e9  
6f ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <64> 48 8b 0c 25  
f8 ff ff ff 48 3b 61 10 76 68 48 83 ec 28 48 89 6c
RSP: 002b:00007fff9b9d3578 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000a4edb RCX: 0000000000483170
RDX: 0000000000000000 RSI: 00007fff9b9d3580 RDI: 0000000000000001
RBP: 00000000000002ef R08: 0000000000000001 R09: 000000000166d940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00000000000a4e70 R14: 00000000000001f1 R15: 0000000000000003
Modules linked in:
---[ end trace 9933854824df8420 ]---
RIP: 0010:put_pid.part.3+0xb6/0x240 kernel/pid.c:108
Code: d2 0f 85 89 01 00 00 44 8b 63 04 49 8d 44 24 03 48 c1 e0 04 48 8d 7c  
03 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 66 01 00 00 49 83 c4 03 be 04 00 00 00 48 89 df
RSP: 0018:ffff8881ae116e78 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff816149a0 RCX: ffffffff833e420e
RDX: 00000001933eab7c RSI: ffffffff8152bf8e RDI: 0000000c99f55be0
RBP: ffff8881ae116f08 R08: ffff8881cdbf2300 R09: fffff52001507600
R10: fffff52001507600 R11: ffffc9000a83b003 R12: 00000000d1894120
R13: 1ffff11035c22dd0 R14: ffff8881ae116ee0 R15: dffffc0000000000
FS:  000000000166d940(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000075c458 CR3: 00000001d2bd1000 CR4: 00000000001406f0
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
