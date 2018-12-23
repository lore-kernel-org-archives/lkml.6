Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0038C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B7521917
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeLWHLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 02:11:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:58571 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeLWHLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 02:11:05 -0500
Received: by mail-it1-f199.google.com with SMTP id p21so10131057itb.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 23:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9T9yc5M2sOehkhDU1HEPeMBXv8F8JLy1OzvMNRT6SlQ=;
        b=pSebhdfXb8XEyi1/YC/HEGJAGQrPZzAOSfof2OAf+KoVoGa3wWon9Ce5kmNemlh4NE
         4TtiCpIhKDTfQ2bWgakZStASe9YUlLVl0jgkq8GxftPHhkz863FlKjPBCocwEUYMPyR1
         6zgBsdU4D/GoVKEv1oH3DFahE5g6zoZKKuG79+ef5nHbhkCi1ostrYynhuWCrVa1g4e6
         WXjDZHICY9lu6ozNP9dZ5nOrG3KCQcGLX7s+oV116WTE2OBSey++UmcNMGIaAS1YOW9C
         Qthhrv9UqzqG5ggTkMNxCmhymKR/4qiA0K2PZtCAToky2wZDnOO1wehXKjGEPnE13PQ5
         LiSw==
X-Gm-Message-State: AA+aEWa0WVbMDCgnQeTaBwOnVv2/VauiSBmKRM5kGjgEA1XGDn0bQ5H/
        FEzEo/P+zRcFTFe+CsIbcFD1i/7TxrLlXRhy4BM0QSvx8Oxu
X-Google-Smtp-Source: ALg8bN7bjnqJp9yAkziNZnnUVRLWk9LymlqjKjnDE9vB0a8qUpVWW27e8Wfn5aQ2Xszvg0OT5aIaOIozhzbSnIkMzt5ILIToFzXw
MIME-Version: 1.0
X-Received: by 2002:a24:5e90:: with SMTP id h138mr6952364itb.27.1545549063730;
 Sat, 22 Dec 2018 23:11:03 -0800 (PST)
Date:   Sat, 22 Dec 2018 23:11:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed3d51057dab2ed4@google.com>
Subject: KASAN: slab-out-of-bounds Write in fpstate_init
From:   syzbot <syzbot+5ce1a620488e94bf2f15@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, nstange@suse.de,
        riel@surriel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6648e120dd1a Add linux-next specific files for 20181217
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16fddf97400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e2825c86a37329f
dashboard link: https://syzkaller.appspot.com/bug?extid=5ce1a620488e94bf2f15
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107348c3400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135f5b1b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5ce1a620488e94bf2f15@syzkaller.appspotmail.com

audit: type=1800 audit(1545532930.544:30): pid=6029 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="startpar" name="rmnologin" dev="sda1" ino=2423 res=0
sshd (6168) used greatest stack depth: 15728 bytes left
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
==================================================================
BUG: KASAN: slab-out-of-bounds in memset include/linux/string.h:337 [inline]
BUG: KASAN: slab-out-of-bounds in fpstate_init+0x50/0x160  
arch/x86/kernel/fpu/core.c:178
Write of size 832 at addr ffff8881bba4bbc0 by task syz-executor233/6184

CPU: 1 PID: 6184 Comm: syz-executor233 Not tainted  
4.20.0-rc6-next-20181217+ #172
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.4+0x9/0x1ff mm/kasan/report.c:187
  kasan_report.cold.5+0x1b/0x39 mm/kasan/report.c:317
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/generic.c:191
  memset+0x23/0x40 mm/kasan/common.c:113
  memset include/linux/string.h:337 [inline]
  fpstate_init+0x50/0x160 arch/x86/kernel/fpu/core.c:178
  fx_init arch/x86/kvm/x86.c:8646 [inline]
  kvm_arch_vcpu_init+0x3e9/0x870 arch/x86/kvm/x86.c:9006
  kvm_vcpu_init+0x2fa/0x420 arch/x86/kvm/../../../virt/kvm/kvm_main.c:315
  vmx_create_vcpu+0x1b7/0x2695 arch/x86/kvm/vmx/vmx.c:6375
  kvm_arch_vcpu_create+0xe5/0x220 arch/x86/kvm/x86.c:8679
  kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:2555  
[inline]
  kvm_vm_ioctl+0x526/0x2030 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3084
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440039
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe478aae78 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440039
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000217 R12: 00000000004018c0
R13: 0000000000401950 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6184:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc+0xcb/0xd0 mm/kasan/common.c:482
  kasan_slab_alloc+0x12/0x20 mm/kasan/common.c:397
  kmem_cache_alloc+0x130/0x730 mm/slab.c:3541
  kmem_cache_zalloc include/linux/slab.h:730 [inline]
  vmx_create_vcpu+0x110/0x2695 arch/x86/kvm/vmx/vmx.c:6366
  kvm_arch_vcpu_create+0xe5/0x220 arch/x86/kvm/x86.c:8679
  kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:2555  
[inline]
  kvm_vm_ioctl+0x526/0x2030 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3084
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8881bba4bb80
  which belongs to the cache x86_fpu of size 832
The buggy address is located 64 bytes inside of
  832-byte region [ffff8881bba4bb80, ffff8881bba4bec0)
The buggy address belongs to the page:
page:ffffea0006ee92c0 count:1 mapcount:0 mapping:ffff8881d7a9d380 index:0x0
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffff8881d6780448 ffff8881d6780448 ffff8881d7a9d380
raw: 0000000000000000 ffff8881bba4b040 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881bba4bd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8881bba4be00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8881bba4be80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                            ^
  ffff8881bba4bf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881bba4bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
