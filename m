Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5C4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A44C20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A44C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbeKHE3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:29:44 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:44289 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeKHE3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:29:44 -0500
Received: by mail-io1-f71.google.com with SMTP id u5-v6so19950189iol.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 10:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3dp5mjuZq6EaeSi9osdN2HZdPlrZMq2hPbZhmyc9ctM=;
        b=OiypiqdFY5JHTlw8q7jLjmWFDwwORqh3ItIpDMecSQdLvp3YuIqfd8a2SBmmrbb08T
         bj8nLLsedJZ+v6CV0T+SysWym0IGgg7Jw+fjRHFF+ZZc7O51wbl3Zcg8dtZgzSjSYGXP
         OqyrjXVyePmvJ75Mb6NVlrbd7JZmnfGrQzdwVWjz7lZNXdNTihQYoH5MJoasszfdZHAk
         OT1+qG2mw6Q7+kvh8OMvTK79p/Y+wNDuk/w/vXMLNw00Q3hIre5UvWSriIMveqKOGUXv
         pLD6hqdcdLv4UExC2so8H+FWvW/ZHNWqeMqjJhl+iDTYeCTKocqP+PX9n0NH0zawrUtQ
         vbZQ==
X-Gm-Message-State: AGRZ1gLdpsS6jTTjT+YKU1xQoQmsBW1HQJKI5IttEb4RS6NLZDez8JPn
        aoEPy8BKkmHWBTTbYzXDOhrkrtwe1RY3npMvmVmkyKPJkWIR
X-Google-Smtp-Source: AJdET5dIG4oTu1JwxtjFRWcd16E5FGhLCPvDJhvhsuhUICCXXm5MyuhmoeU6IFJm4EiVDtzsxImI0pBGWiwr5zu2sVeizIU6nMPN
MIME-Version: 1.0
X-Received: by 2002:a24:2c91:: with SMTP id i139-v6mr1060561iti.40.1541617084335;
 Wed, 07 Nov 2018 10:58:04 -0800 (PST)
Date:   Wed, 07 Nov 2018 10:58:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b10cfe057a17b246@google.com>
Subject: KMSAN: kernel-infoleak in kvm_write_guest_page
From:   syzbot <syzbot+a8ef68d71211ba264f56@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7438a3b20295 kmsan: print user address when reporting info..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=10d782f5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8df5fc509a1b351b
dashboard link: https://syzkaller.appspot.com/bug?extid=a8ef68d71211ba264f56
compiler:       clang version 8.0.0 (trunk 343298)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f09133400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a39e05400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a8ef68d71211ba264f56@syzkaller.appspotmail.com

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
==================================================================
BUG: KMSAN: kernel-infoleak in __copy_to_user include/linux/uaccess.h:121  
[inline]
BUG: KMSAN: kernel-infoleak in __kvm_write_guest_page  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1849 [inline]
BUG: KMSAN: kernel-infoleak in kvm_write_guest_page+0x373/0x500  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1861
CPU: 1 PID: 6274 Comm: syz-executor149 Not tainted 4.19.0+ #78
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x32d/0x480 lib/dump_stack.c:113
  kmsan_report+0x19f/0x300 mm/kmsan/kmsan.c:911
  kmsan_internal_check_memory+0x35f/0x450 mm/kmsan/kmsan.c:993
  kmsan_copy_to_user+0x7c/0xe0 mm/kmsan/kmsan_hooks.c:552
  __copy_to_user include/linux/uaccess.h:121 [inline]
  __kvm_write_guest_page arch/x86/kvm/../../../virt/kvm/kvm_main.c:1849  
[inline]
  kvm_write_guest_page+0x373/0x500  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1861
  kvm_write_guest+0x1e1/0x360 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1883
  kvm_pv_clock_pairing arch/x86/kvm/x86.c:6793 [inline]
  kvm_emulate_hypercall+0x1c96/0x21b0 arch/x86/kvm/x86.c:6866
  handle_vmcall+0x41/0x50 arch/x86/kvm/vmx.c:7487
  vmx_handle_exit+0x1e81/0xbac0 arch/x86/kvm/vmx.c:10128
  vcpu_enter_guest arch/x86/kvm/x86.c:7667 [inline]
  vcpu_run arch/x86/kvm/x86.c:7730 [inline]
  kvm_arch_vcpu_ioctl_run+0xac32/0x11d80 arch/x86/kvm/x86.c:7930
  kvm_vcpu_ioctl+0xfb1/0x1f90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
  do_vfs_ioctl+0xf77/0x2d30 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:702 [inline]
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:707
  __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:707
  do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x442b39
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b 0c fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcb4e05478 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000442b39
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000007
RBP: 00000000006cd018 R08: 0000000020000100 R09: 0000000020000100
R10: 0000000000000000 R11: 0000000000000217 R12: 0000000000403be0
R13: 0000000000403c70 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----clock_pairing.i@kvm_emulate_hypercall
Variable was created at:
  kvm_emulate_hypercall+0x60/0x21b0 arch/x86/kvm/x86.c:6827
  handle_vmcall+0x41/0x50 arch/x86/kvm/vmx.c:7487

Bytes 28-63 of 64 are uninitialized
Memory access of size 64 starts at ffff8801aac5f3d8
Data copied to user address 0000000020000000
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
