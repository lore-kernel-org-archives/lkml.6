Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BC8C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C04216F9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C04216F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbeHNKgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 06:36:03 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:48396 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeHNKgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 06:36:03 -0400
Received: by mail-io0-f200.google.com with SMTP id n26-v6so5388942iog.15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 00:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eSPhSnJXPs/1oGzPgRlFUZyfMWLymBm6a8yWqDEfsFU=;
        b=C/xPA9412BCmmS8U4j8zaLdumMFQtLuYe3S10fin8YOl5GzfcMrz1LxyDGFvARbkxz
         S2nUNfpurhRdSuiuBdECNjEm6yfTLmOElAhTrIdUcK8Uc5goVMKAHOtHX/bI6pG6C95X
         J7uStNS1qc4wEm/3nqbilMbPZFCluh398NEgtBzcBtQ7pi1mYJhpSHOLVza6cxWpM/K7
         +E1haAcMColJWtK+aawv+ba1Ko9BcajTHmdndZhtj8OZ+ABmzbFUmfNQgvsmA/1SkbJM
         pBnBNmalY0FkXtCaB5GYRKITZ48IULAHXPkp+9MlGaUNam5BbS0VGCKzSqpja4puva30
         q3iA==
X-Gm-Message-State: AOUpUlFmnC8olKxKnMBzW1UJfzM6QYArzWYVGheVggUt45Mm71aS8n+Q
        YPM6Yf4ByKF6NoewjJ9ICGqVXOAq0Nz8kx0AP1DBJJ6U7Ttx
X-Google-Smtp-Source: AA+uWPy7gSIY8XFiC4RlYC46Qiy4sWa6/QfJk7kjlUajTR6Wutq2XVIP4UTC0hsf3rwiEFRIvJ4z6vO/MyVLeLBow/5qpCsOn5vW
MIME-Version: 1.0
X-Received: by 2002:a6b:7119:: with SMTP id q25-v6mr6773211iog.130.1534233002406;
 Tue, 14 Aug 2018 00:50:02 -0700 (PDT)
Date:   Tue, 14 Aug 2018 00:50:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c7a5c0573607583@google.com>
Subject: general protection fault in kvm_ioapic_scan_entry
From:   syzbot <syzbot+20eae20afcbd851b8601@syzkaller.appspotmail.com>
To:     hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1c2f2531cf8b Add linux-next specific files for 20180809
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16016cf8400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44657afb75515c8b
dashboard link: https://syzkaller.appspot.com/bug?extid=20eae20afcbd851b8601
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12038e22400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163caee2400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+20eae20afcbd851b8601@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
urandom_read: 1 callbacks suppressed
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 4332 Comm: syz-executor255 Not tainted  
4.18.0-rc8-next-20180809+ #35
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:do_raw_spin_lock+0x27/0x200 kernel/locking/spinlock_debug.c:111
Code: 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 41 55 41 54  
53 48 89 fb 48 83 c7 04 48 89 fa 48 c1 ea 03 48 83 ec 08 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7b
RSP: 0018:ffff8801cf1a7430 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 00000000000001b0 RCX: 0000000000000000
RDX: 0000000000000036 RSI: 0000000000000000 RDI: 00000000000001b4
RBP: ffff8801cf1a7458 R08: 0000000000000001 R09: 0000000000000000
R10: ffffed0035c51089 R11: ffff8801ae28844f R12: ffff8801ae288430
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  00000000014a5880(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000001b4a66000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
  _raw_spin_lock+0x32/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  kvm_ioapic_scan_entry+0x7f/0x3c0 arch/x86/kvm/ioapic.c:246
  vcpu_scan_ioapic arch/x86/kvm/x86.c:7253 [inline]
  vcpu_enter_guest+0x494b/0x6360 arch/x86/kvm/x86.c:7389
  vcpu_run arch/x86/kvm/x86.c:7660 [inline]
  kvm_arch_vcpu_ioctl_run+0x33e/0x1690 arch/x86/kvm/x86.c:7837
  kvm_vcpu_ioctl+0x7b8/0x1300 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4402f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdb31251d8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402f9
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 0000000000401b80
R13: 0000000000401c10 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace c89a962150abb5ce ]---
RIP: 0010:do_raw_spin_lock+0x27/0x200 kernel/locking/spinlock_debug.c:111
Code: 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 41 55 41 54  
53 48 89 fb 48 83 c7 04 48 89 fa 48 c1 ea 03 48 83 ec 08 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7b
RSP: 0018:ffff8801cf1a7430 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 00000000000001b0 RCX: 0000000000000000
RDX: 0000000000000036 RSI: 0000000000000000 RDI: 00000000000001b4
RBP: ffff8801cf1a7458 R08: 0000000000000001 R09: 0000000000000000
R10: ffffed0035c51089 R11: ffff8801ae28844f R12: ffff8801ae288430
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  00000000014a5880(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000001b4a66000 CR4: 00000000001426e0
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
