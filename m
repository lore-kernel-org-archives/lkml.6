Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9CAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E7D208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E7D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbeKQIXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:23:15 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:35858 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeKQIXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:23:14 -0500
Received: by mail-io1-f71.google.com with SMTP id w5so688719iom.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 14:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=q/Xy4u37esu6jonFyOoEAOaLEXNv1nCncNvMM6VHDeA=;
        b=gX4BWJFfJ77w8x+sQA/QEr+5qoh6LkhhUOq1xNKFfnetbZi/YgTE6kIoI5CwQ+h/A1
         TGcTqDsfGmcHzaEOOL23J4PXFIaMHc9RnT/e1ynNMdxTGO5U8jyzkjol68PplrgOJwoW
         Uj145Agg3Piu5zMmqpj5sl0pAFCcOrWo5dotr6PYizANvfWvJ+7f9PfVe1/whzhRhRGw
         Zse7mxoaYFNSJaxAdVoNfgRRyxL7OgbfEL3/baMslSrGsUtYikCIf7pA0EMSMXGiDCl3
         F7fzoYrGgsbC1ScBqJKW/ZSU4731Oso8nfPP32JzC5oNJj1coBHUH7k5uZgNozTSCEh3
         TRKw==
X-Gm-Message-State: AA+aEWaEJsbW4cZZvHgfMIvrkBaiRYrOQW08Hxd7TFR1eFGNq/zJCV1l
        C91eJtYvuwicAw5jL9vbsbKldN1RJXJ/JZ5DL1pvfBBgiq22
X-Google-Smtp-Source: AFSGD/UWaxXWPaivkO2AdjDx+hZg3djPXl1uBYRfFt1IorxBLesVhcJCbv1VkaFb6w8ALwnPfcJbyn2AzYmp5sFmvX0RIb10r+PS
MIME-Version: 1.0
X-Received: by 2002:a24:6908:: with SMTP id e8-v6mr48646itc.7.1542406144215;
 Fri, 16 Nov 2018 14:09:04 -0800 (PST)
Date:   Fri, 16 Nov 2018 14:09:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000535c70057acf6a48@google.com>
Subject: KMSAN: kernel-infoleak in kvm_arch_vcpu_ioctl
From:   syzbot <syzbot+cfbc368e283d381f8cef@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    006aa39cddee kmsan: don't instrument fixup_bad_iret()
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=101dcb0b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f388ea1732f3c473
dashboard link: https://syzkaller.appspot.com/bug?extid=cfbc368e283d381f8cef
compiler:       clang version 8.0.0 (trunk 343298)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c56fbd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153c8a47400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cfbc368e283d381f8cef@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
==================================================================
BUG: KMSAN: kernel-infoleak in _copy_to_user+0x19a/0x230 lib/usercopy.c:31
CPU: 0 PID: 6697 Comm: syz-executor853 Not tainted 4.20.0-rc2+ #85
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x32d/0x480 lib/dump_stack.c:113
  kmsan_report+0x19f/0x300 mm/kmsan/kmsan.c:911
  kmsan_internal_check_memory+0x35b/0x3b0 mm/kmsan/kmsan.c:993
  kmsan_copy_to_user+0x7c/0xe0 mm/kmsan/kmsan_hooks.c:552
  _copy_to_user+0x19a/0x230 lib/usercopy.c:31
  copy_to_user include/linux/uaccess.h:183 [inline]
  kvm_vcpu_ioctl_enable_cap arch/x86/kvm/x86.c:3834 [inline]
  kvm_arch_vcpu_ioctl+0x5dee/0x7680 arch/x86/kvm/x86.c:4132
  kvm_vcpu_ioctl+0xca3/0x1f90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2748
  do_vfs_ioctl+0xfbc/0x2f70 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:713 [inline]
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:718
  __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:718
  do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x4471b9
Code: e8 fc b9 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1e22946da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006f0038 RCX: 00000000004471b9
RDX: 0000000020000000 RSI: 000000004068aea3 RDI: 0000000000000005
RBP: 00000000006f0030 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006f003c
R13: 6d766b2f7665642f R14: 00007f1e229479c0 R15: 00000000000003e8

Local variable description: ----__pu_val@kvm_arch_vcpu_ioctl
Variable was created at:
  kvm_arch_vcpu_ioctl+0x29d/0x7680 arch/x86/kvm/x86.c:3848
  kvm_vcpu_ioctl+0xca3/0x1f90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2748

Bytes 0-1 of 2 are uninitialized
Memory access of size 2 starts at ffff8881967ffbb0
Data copied to user address 0000000000706000
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
