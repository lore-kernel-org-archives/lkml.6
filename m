Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A23C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C257620834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C257620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeLCNVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:21:04 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:37117 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeLCNVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:21:03 -0500
Received: by mail-io1-f72.google.com with SMTP id d63so14310422iog.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 05:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=c/KLNlppy1L4fl5QhbI+8CdAYOFOELFizlmNqPEIU4w=;
        b=bvZi4X2T+aAelhMQSHaOhbC/0bC57YTEXmwb80Y/YbG14mABUgSfWBXLhDW5eV3a6K
         QcI9FiNbN8di88zxXiOYst8udO+nFJ+ghC90/OPnMkW9wObroOxoBL1XLPiDtsTbwZtw
         Yx0aVo8lv9YRJuXs8ZYxW3p4+5fW11HmK+iJgT47mNG7TX6oy3aumQxmbcleArCnfSgD
         HH01FVu9U8ObsIlQLkdu8f7CVm756/OdTHFn5SC+EIGT3zC3PSJ37611p8SHzULLyjtP
         MZi8z/eupbcObarNpzu5i1DslweRzmqFjVs8FXn3rvNxjt97x7vh/nC3N+JrWKdrF6zc
         09+A==
X-Gm-Message-State: AA+aEWalY69BKRRJb94msxCTsim/tqA3GoQsDJeGYl8XJ6XRTGvUyovh
        HcA1rmSE40nSgY7kbIdCdirB+c74/n1/Ci421l4HxmO8L9o1
X-Google-Smtp-Source: AFSGD/VZQOb5+1IEezy+F1outTMTncgLVeUYraBQnBP0KD9ws82oEWCaDIh9CrA3grQnzxLdODTcCc8oXiZIDiQscEhlAKbPruk1
MIME-Version: 1.0
X-Received: by 2002:a02:4f03:: with SMTP id c3mr12511078jab.13.1543843203400;
 Mon, 03 Dec 2018 05:20:03 -0800 (PST)
Date:   Mon, 03 Dec 2018 05:20:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba5be2057c1e01fa@google.com>
Subject: KMSAN: uninit-value in vmx_queue_exception
From:   syzbot <syzbot+788c6e0a154504bd4b99@syzkaller.appspotmail.com>
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

HEAD commit:    2808e543aacb kmsan: use __memmove() in fixup_bad_iret()
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=171e8f7b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c73fa4249092e6f1
dashboard link: https://syzkaller.appspot.com/bug?extid=788c6e0a154504bd4b99
compiler:       clang version 8.0.0 (trunk 343298)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a0ac5d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113a6f7b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+788c6e0a154504bd4b99@syzkaller.appspotmail.com

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
==================================================================
BUG: KMSAN: uninit-value in __vmcs_writel arch/x86/kvm/vmx.c:2399 [inline]
BUG: KMSAN: uninit-value in vmcs_write32 arch/x86/kvm/vmx.c:2420 [inline]
BUG: KMSAN: uninit-value in vmx_queue_exception+0x757/0x920  
arch/x86/kvm/vmx.c:3352
CPU: 0 PID: 6638 Comm: syz-executor166 Not tainted 4.20.0-rc3+ #89
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x32d/0x480 lib/dump_stack.c:113
  kmsan_report+0x19f/0x300 mm/kmsan/kmsan.c:911
  __msan_warning+0x76/0xc0 mm/kmsan/kmsan_instr.c:415
  __vmcs_writel arch/x86/kvm/vmx.c:2399 [inline]
  vmcs_write32 arch/x86/kvm/vmx.c:2420 [inline]
  vmx_queue_exception+0x757/0x920 arch/x86/kvm/vmx.c:3352
  inject_pending_event arch/x86/kvm/x86.c:7146 [inline]
  vcpu_enter_guest arch/x86/kvm/x86.c:7641 [inline]
  vcpu_run arch/x86/kvm/x86.c:7872 [inline]
  kvm_arch_vcpu_ioctl_run+0x7d81/0x12040 arch/x86/kvm/x86.c:8072
  kvm_vcpu_ioctl+0xfb1/0x1f90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2596
  do_vfs_ioctl+0xfbc/0x2f70 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:713 [inline]
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:718
  __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:718
  do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x442a39
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b 0c fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffef8ea1048 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000442a39
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 00000000006cd018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000020014000 R11: 0000000000000217 R12: 0000000000403ae0
R13: 0000000000403b70 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:252 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:267 [inline]
  kmsan_internal_chain_origin+0x136/0x240 mm/kmsan/kmsan.c:569
  __msan_chain_origin+0x6d/0xb0 mm/kmsan/kmsan_instr.c:292
  kvm_multiple_exception arch/x86/kvm/x86.c:483 [inline]
  kvm_queue_exception_e_p arch/x86/kvm/x86.c:554 [inline]
  kvm_inject_page_fault+0xa60/0xef0 arch/x86/kvm/x86.c:578
  nested_vmx_get_vmptr+0x36f/0x3d0 arch/x86/kvm/vmx.c:8264
  handle_vmon+0x5ea/0xe70 arch/x86/kvm/vmx.c:8387
  vmx_handle_exit+0x21bd/0xb980 arch/x86/kvm/vmx.c:10600
  vcpu_enter_guest arch/x86/kvm/x86.c:7809 [inline]
  vcpu_run arch/x86/kvm/x86.c:7872 [inline]
  kvm_arch_vcpu_ioctl_run+0xaeee/0x12040 arch/x86/kvm/x86.c:8072
  kvm_vcpu_ioctl+0xfb1/0x1f90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2596
  do_vfs_ioctl+0xfbc/0x2f70 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:713 [inline]
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:718
  __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:718
  do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7

Local variable description: ----e@nested_vmx_get_vmptr
Variable was created at:
  nested_vmx_get_vmptr+0xa5/0x3d0 arch/x86/kvm/vmx.c:8255
  handle_vmon+0x5ea/0xe70 arch/x86/kvm/vmx.c:8387
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
