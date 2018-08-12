Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9172AC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 20:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B7221A0B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 20:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B7221A0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeHLX3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 19:29:16 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:46527 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeHLX3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 19:29:16 -0400
Received: by mail-io0-f200.google.com with SMTP id c5-v6so12284145ioi.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 13:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=b/YL1d/3twwn3mQrHGKvCkMdUeXGcgC316y8yBo/A8Q=;
        b=KtqE1p8whhi6h0pve1VPoMLtZ9nIbTsM57PN8WvWZ130C8iRVORgq9JqkWUVLrVmcl
         z8zJspiBXy59WtueeIYhcrkNLsLAVK57bF8ePVFtM7CrqdzQzRg427/RnV49Bw+BMsIG
         9uPBthbJb5gscahHuikbpgqEqkqGyrrKmnN1s5GN7zThYmahyfzTwMGkU62fUFYOsd+J
         FzbIJx2twmfiEeyzYUzlOvX5/rojE0KDe5ag+xDAbxn+p9ixb3OhuqQskMaXPbJThdET
         7rb6/vCavFgVzChuD9rfbtFnGJV0ARGIbkjtlyICGKQi6kDuSS2BUlwL56wXFGQvssty
         eNdw==
X-Gm-Message-State: AOUpUlG9R2UbO+Gfge+SXj81kcNISH+LXbX8eKrKtcyppANr0ZcIRA15
        B2w5VfT6huSAVrUGAKEqmjLQjYOrlJ1xPgSUD6ZJdPgq+N/f
X-Google-Smtp-Source: AA+uWPwwenswGTvVStBJwGfUzCR3mY/vNX02juv5Wpg/Gfxt/QB744Hqp6mW16VChSdjx8EmeBhX49vJe4i6bAfyTS4xe3x+FsMG
MIME-Version: 1.0
X-Received: by 2002:a6b:db05:: with SMTP id t5-v6mr6882348ioc.15.1534107002232;
 Sun, 12 Aug 2018 13:50:02 -0700 (PDT)
Date:   Sun, 12 Aug 2018 13:50:02 -0700
In-Reply-To: <000000000000e106310573146798@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea6b380573431e98@google.com>
Subject: Re: KASAN: use-after-free Read in finish_task_switch
From:   syzbot <syzbot+e62f8ba2b2af8dbd6729@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        dvhart@infradead.org, jglisse@redhat.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        minchan@kernel.org, mingo@redhat.com, peterz@infradead.org,
        riel@surriel.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        ying.huang@intel.com, zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    4110b42356f3 Add linux-next specific files for 20180810
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=107162c4400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d80606e3795a4f5
dashboard link: https://syzkaller.appspot.com/bug?extid=e62f8ba2b2af8dbd6729
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=16d33cc4400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142c7202400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e62f8ba2b2af8dbd6729@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: use-after-free in __fire_sched_in_preempt_notifiers  
kernel/sched/core.c:2481 [inline]
BUG: KASAN: use-after-free in fire_sched_in_preempt_notifiers  
kernel/sched/core.c:2487 [inline]
BUG: KASAN: use-after-free in finish_task_switch+0x544/0x870  
kernel/sched/core.c:2679
Read of size 8 at addr ffff8801c79482d8 by task syz-executor216/4445

CPU: 0 PID: 4445 Comm: syz-executor216 Not tainted  
4.18.0-rc8-next-20180810+ #36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __fire_sched_in_preempt_notifiers kernel/sched/core.c:2481 [inline]
  fire_sched_in_preempt_notifiers kernel/sched/core.c:2487 [inline]
  finish_task_switch+0x544/0x870 kernel/sched/core.c:2679
  context_switch kernel/sched/core.c:2826 [inline]
  __schedule+0x884/0x1ec0 kernel/sched/core.c:3471
  schedule+0xfb/0x450 kernel/sched/core.c:3515
  freezable_schedule include/linux/freezer.h:172 [inline]
  futex_wait_queue_me+0x3f9/0x840 kernel/futex.c:2530
  futex_wait+0x45b/0xa20 kernel/futex.c:2645
  do_futex+0x336/0x27d0 kernel/futex.c:3527
  __do_sys_futex kernel/futex.c:3587 [inline]
  __se_sys_futex kernel/futex.c:3555 [inline]
  __x64_sys_futex+0x472/0x6a0 kernel/futex.c:3555
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4468a9
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f34d3e78da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00000000006dbc88 RCX: 00000000004468a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000006dbc88
RBP: 00000000006dbc80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc8c
R13: 0030656c69662f2e R14: 6c75662f7665642f R15: 00000000006dbd6c

Allocated by task 4439:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  kmem_cache_zalloc include/linux/slab.h:697 [inline]
  vmx_create_vcpu+0xcf/0x28b0 arch/x86/kvm/vmx.c:10682
  kvm_arch_vcpu_create+0xe5/0x220 arch/x86/kvm/x86.c:8401
  kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:2476  
[inline]
  kvm_vm_ioctl+0x488/0x1d80 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2977
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4423:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  vmx_free_vcpu+0x26b/0x300 arch/x86/kvm/vmx.c:10676
  kvm_arch_vcpu_free arch/x86/kvm/x86.c:8387 [inline]
  kvm_free_vcpus arch/x86/kvm/x86.c:8836 [inline]
  kvm_arch_destroy_vm+0x365/0x7c0 arch/x86/kvm/x86.c:8933
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:752 [inline]
  kvm_put_kvm+0x73f/0x1060 arch/x86/kvm/../../../virt/kvm/kvm_main.c:773
  kvm_vcpu_release+0x7b/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2407
  __fput+0x376/0x8a0 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801c79482c0
  which belongs to the cache kvm_vcpu of size 23808
The buggy address is located 24 bytes inside of
  23808-byte region [ffff8801c79482c0, ffff8801c794dfc0)
The buggy address belongs to the page:
page:ffffea00071e5200 count:1 mapcount:0 mapping:ffff8801d4c35a80 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea000721fe08 ffffea0007364208 ffff8801d4c35a80
raw: 0000000000000000 ffff8801c79482c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c7948180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801c7948200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801c7948280: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                     ^
  ffff8801c7948300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c7948380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

