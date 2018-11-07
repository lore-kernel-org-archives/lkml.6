Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC21EC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946E82086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946E82086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbeKGLGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:06:13 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:54952 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731041AbeKGLGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:06:13 -0500
Received: by mail-it1-f199.google.com with SMTP id r79-v6so8154585itc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zLfIIYC+kz0FLbrzhXVatrNwp2S/BkHfR0TxQ0h2Gas=;
        b=Ru7hkA0TePTspCu4rVDP3OQLS0fNS/2zqino1DgQhjRAPbJsGjlY8lP/nr+wupGgXt
         6AkyZM/+4VCqcH4vgxfTmyquDx1WkrvsI3vi6yqhYcc5QQLIJ5RFCAJ9jX2sVNNWsEKf
         wjacy8LBbBy2sSspkj1BIG7sgVD1t2BkOFtI7UyGKkfgI6KH/RHYnkdBuTvVfD1ZfteX
         XrkTEpxIcvwNywkf5wpAwd0zciYuWvTM9EZGulvk69JMelcP2ctoRLbnVWxyOsy81VQ+
         oUHZwAhyu9xNzBYzDiP/nTQpcOe7yjeuCfguyrr+22ALNayPupNyLDGVsqxzVzbrt/jr
         Uc7A==
X-Gm-Message-State: AGRZ1gJnWAC52Z64MVzCVS+v0es+QYmFg1LnaKryU6Pn+E6qBDx1kni+
        Eda4D8Fejb9KOKYX77/0+Fox15nRKwaIzV0+8i/nOZ8OFW4u
X-Google-Smtp-Source: AJdET5fnVMjV8FauntCO4Ro9YwYXMIumNDAQWINnqlbLONzWQek1I6q1EFpZDH35B7KQ/py1E7DmBsRXn+Vd6b8o+4M2Z56qqYo+
MIME-Version: 1.0
X-Received: by 2002:a6b:3b4b:: with SMTP id i72-v6mr19926989ioa.6.1541554684843;
 Tue, 06 Nov 2018 17:38:04 -0800 (PST)
Date:   Tue, 06 Nov 2018 17:38:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000645f00057a092b8c@google.com>
Subject: BUG: spinlock cpu recursion on CPU, syz-executor
From:   syzbot <syzbot+e9a3960298616a5a5abc@syzkaller.appspotmail.com>
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

HEAD commit:    651022382c7f Linux 4.20-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d6ae33400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f559fee2fc3375a
dashboard link: https://syzkaller.appspot.com/bug?extid=e9a3960298616a5a5abc
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130d742b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e9a3960298616a5a5abc@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
BUG: spinlock cpu recursion on CPU#0, syz-executor0/8023
  lock: 0xffffc900045ea000, .magic: dead4ead, .owner: <none>/-1, .owner_cpu:  
0
CPU: 0 PID: 8023 Comm: syz-executor0 Not tainted 4.20.0-rc1+ #99
kobject: 'kvm' (00000000968c974f): kobject_uevent_env
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
kobject: 'kvm' (00000000968c974f): kobject_uevent_env
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  spin_dump.cold.3+0x81/0xe7 kernel/locking/spinlock_debug.c:67
kobject: 'kvm' (00000000968c974f): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
  spin_bug kernel/locking/spinlock_debug.c:75 [inline]
  debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
  do_raw_spin_lock+0x26a/0x350 kernel/locking/spinlock_debug.c:112
kobject: 'loop2' (000000000bdb293a): kobject_uevent_env
  __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
  _raw_spin_lock+0x35/0x40 kernel/locking/spinlock.c:144
kobject: 'loop2' (000000000bdb293a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  spin_lock include/linux/spinlock.h:329 [inline]
  kvm_mmu_change_mmu_pages+0xf3/0x450 arch/x86/kvm/mmu.c:2717
kobject: 'kvm' (00000000968c974f): kobject_uevent_env
  kvm_arch_commit_memory_region+0x289/0x2d0 arch/x86/kvm/x86.c:9322
kobject: 'kvm' (00000000968c974f): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
  __kvm_set_memory_region+0x1c99/0x2d50  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1064
kobject: 'kvm' (00000000968c974f): kobject_uevent_env
kobject: 'kvm' (00000000968c974f): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000968c974f): kobject_uevent_env
  kvm_set_memory_region+0x2e/0x50  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1085
kobject: 'kvm' (00000000968c974f): kobject_uevent_env
  kvm_vm_ioctl_set_memory_region  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1097 [inline]
  kvm_vm_ioctl+0x652/0x1d60 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2995
kobject: 'loop3' (0000000005b5310e): kobject_uevent_env
kobject: 'kvm' (00000000968c974f): kobject_uevent_env
kobject: 'kvm' (00000000968c974f): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000968c974f): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000968c974f): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000968c974f): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
kobject: 'loop3' (0000000005b5310e): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
------------[ cut here ]------------
downgrading a read lock
WARNING: CPU: 1 PID: 5667 at kernel/locking/lockdep.c:3556 __lock_downgrade  
kernel/locking/lockdep.c:3556 [inline]
WARNING: CPU: 1 PID: 5667 at kernel/locking/lockdep.c:3556  
lock_downgrade+0x4d7/0x900 kernel/locking/lockdep.c:3819


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
