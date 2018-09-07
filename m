Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE93C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB70A2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB70A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbeIGUK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:10:29 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:55611 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbeIGUK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:10:28 -0400
Received: by mail-it0-f69.google.com with SMTP id m207-v6so22613362itg.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 08:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NHmJBnWDH7I5C6L4zaMTHe7OylK2WiYCJnAJw4JLHNI=;
        b=l/DqyCWfw0Ndd1AdZIGJaEhYhVjkVUifjmch4XxRINOQW+2bQExtPJLjIGklvxGCKi
         btiWBxbJv6mON9n6GewMnsaHv7ab+fHF7K8vHCicRdVKS+M8/yaAV45Yr8oV59kP7CWB
         d7k0sWy3n3v/2KP53NbT1C0fOGZs0QXoQY8pCEZS8cUEA/4eVW9d6U+AiS1ZIaS6TrN8
         TrcJ1wp12padVaPS1VLOqdpcNrGEejTU7d87puGAFOCmdp/V1A7tnA0mGFKHThsbWZA1
         EO5Esx1dF8hzqDqmdXHdQdBgjnirIwDOR9HeeyyXg79illreCTUJVPndB4kCGpEpjAVG
         EhvQ==
X-Gm-Message-State: APzg51AG+DDrVgJZkeEy3EAmdJ+r8LSWvqOAMYLk7ZqcwCdGfGWSxCl9
        xTT4FSSjL7M8fFzUngRuUa6qglGaG69myjbkVvb8Y1T+WB1N
X-Google-Smtp-Source: ANB0VdYCu7gH3R0xm+CZ8rMBl/1CKkLW2TB3SeiR9z/amfgO7l7lsR3JXGMuUVMHmSyj983Y3GNnUNIGT7uoFCOO+pbkSHN0uVpn
MIME-Version: 1.0
X-Received: by 2002:a02:4fc7:: with SMTP id r68-v6mr7001624jad.47.1536334143513;
 Fri, 07 Sep 2018 08:29:03 -0700 (PDT)
Date:   Fri, 07 Sep 2018 08:29:03 -0700
In-Reply-To: <000000000000edab9e0575497f40@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e16cba057549aab6@google.com>
Subject: Re: BUG: bad usercopy in __check_object_size (2)
From:   syzbot <syzbot+a3c9d2673837ccc0f22b@syzkaller.appspotmail.com>
To:     crecklin@redhat.com, dvyukov@google.com, hpa@zytor.com,
        keescook@chromium.org, keescook@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    28619527b8a7 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=124e64d1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62e9b447c16085cf
dashboard link: https://syzkaller.appspot.com/bug?extid=a3c9d2673837ccc0f22b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179f9cd1400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b3e8be400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a3c9d2673837ccc0f22b@syzkaller.appspotmail.com

  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440479
usercopy: Kernel memory overwrite attempt detected to spans multiple pages  
(offset 0, size 64)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:102!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5340 Comm: syz-executor610 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:usercopy_abort+0xbb/0xbd mm/usercopy.c:90
Code: c0 e8 8a 23 b2 ff 48 8b 55 c0 49 89 d9 4d 89 f0 ff 75 c8 4c 89 e1 4c  
89 ee 48 c7 c7 80 48 15 88 ff 75 d0 41 57 e8 5a 38 98 ff <0f> 0b e8 5f 23  
b2 ff e8 8a 6e f5 ff 8b 95 5c fe ff ff 4d 89 e0 31
RSP: 0018:ffff8801bbcf6d50 EFLAGS: 00010086
RAX: 000000000000005f RBX: ffffffff881545a0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8164f825 RDI: 0000000000000005
RBP: ffff8801bbcf6da8 R08: ffff8801d8f1a500 R09: ffffed003b5c3ee2
R10: ffffed003b5c3ee2 R11: ffff8801dae1f717 R12: ffffffff88154ac0
R13: ffffffff881546e0 R14: ffffffff881545a0 R15: ffffffff881545a0
FS:  000000000225c880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000455350 CR3: 00000001d90eb000 CR4: 00000000001406f0
Call Trace:
  check_page_span mm/usercopy.c:212 [inline]
  check_heap_object mm/usercopy.c:241 [inline]
  __check_object_size.cold.2+0x23/0x134 mm/usercopy.c:266
  check_object_size include/linux/thread_info.h:119 [inline]
  __copy_from_user_inatomic include/linux/uaccess.h:65 [inline]
  __probe_kernel_read+0xda/0x1c0 mm/maccess.c:33
  show_opcodes+0x4c/0x70 arch/x86/kernel/dumpstack.c:109
  show_ip+0x31/0x36 arch/x86/kernel/dumpstack.c:126
  show_iret_regs+0x14/0x38 arch/x86/kernel/dumpstack.c:131
  __show_regs+0x1c/0x60 arch/x86/kernel/process_64.c:72
  show_regs_if_on_stack.constprop.10+0x36/0x39  
arch/x86/kernel/dumpstack.c:149
  show_trace_log_lvl+0x25d/0x28c arch/x86/kernel/dumpstack.c:274
  show_stack+0x38/0x3a arch/x86/kernel/dumpstack.c:293
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1557
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  kmem_cache_alloc_trace+0x2d7/0x750 mm/slab.c:3618
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  aa_alloc_file_ctx security/apparmor/include/file.h:60 [inline]
  apparmor_file_alloc_security+0x168/0xaa0 security/apparmor/lsm.c:438
  security_file_alloc+0x4c/0xa0 security/security.c:884
  __alloc_file+0x12a/0x470 fs/file_table.c:105
  alloc_empty_file+0x72/0x170 fs/file_table.c:150
  dentry_open+0x71/0x1d0 fs/open.c:894
  open_related_ns+0x1b0/0x210 fs/nsfs.c:177
  __tun_chr_ioctl+0x48d/0x4690 drivers/net/tun.c:2901
  tun_chr_ioctl+0x2a/0x40 drivers/net/tun.c:3179
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440479
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe3cf83628 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440479
RDX: 0000000000000000 RSI: 000000000000894c RDI: 0000000000000004
RBP: 00000000006cb018 R08: 0000000000000001 R09: 0000000000000034
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 125c9e5841391893 ]---
RIP: 0010:usercopy_abort+0xbb/0xbd mm/usercopy.c:90
Code: c0 e8 8a 23 b2 ff 48 8b 55 c0 49 89 d9 4d 89 f0 ff 75 c8 4c 89 e1 4c  
89 ee 48 c7 c7 80 48 15 88 ff 75 d0 41 57 e8 5a 38 98 ff <0f> 0b e8 5f 23  
b2 ff e8 8a 6e f5 ff 8b 95 5c fe ff ff 4d 89 e0 31
RSP: 0018:ffff8801bbcf6d50 EFLAGS: 00010086
RAX: 000000000000005f RBX: ffffffff881545a0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8164f825 RDI: 0000000000000005
RBP: ffff8801bbcf6da8 R08: ffff8801d8f1a500 R09: ffffed003b5c3ee2
R10: ffffed003b5c3ee2 R11: ffff8801dae1f717 R12: ffffffff88154ac0
R13: ffffffff881546e0 R14: ffffffff881545a0 R15: ffffffff881545a0
FS:  000000000225c880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000455350 CR3: 00000001d90eb000 CR4: 00000000001406f0

