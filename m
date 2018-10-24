Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEECC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0DC2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0DC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeJXTTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:19:40 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:54510 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbeJXTTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:19:40 -0400
Received: by mail-io1-f72.google.com with SMTP id q26-v6so1954207ioi.21
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OZm1TcUVq+NvPgbvReoVt1NjAK1GqmrZIdyuVYxdzEw=;
        b=FMWPeZTbFnTc+mrqeIh2jX7w+jVkW0GyUd6sRmG/5aFCjuG/1lAOCKEsFWEd6yuk42
         hD5TnHPgUHXObNUaIhm+CkWnXOeTS1w8Fy7riDBvug1hvgzzwviCJ6wSRsaYCe3gVy3S
         sonCyao/aScmhtB7bAcWljT68P4T6tfImtfvzlLrjpRJNERH02LIDeItF5YU3VJ21Mx5
         wCAA0w6wpttaQvRSF94d/HVi1TNzNukuaa73gVhqKKXUtBgB+F9cP6Yr4oro4L+1H9zb
         9gLm/78t464o2PPs3ZiWOKNjBxPkCfGsfsH1XP7PHa2sFgFwxaKeTdRWp6xeugXsUFIN
         J4HQ==
X-Gm-Message-State: AGRZ1gI9FJRc+gzXyhN5rAaHO7q6c1CM3nIIYNnKwxx6haSR45sE1kRc
        pKuDZ9S+f09O0/d8wMlB17ncqynAW+pVv++8hNgC+x4A/Vmv
X-Google-Smtp-Source: AJdET5dNcRNr/KosNvoEUl7/janMeQhU/nFCJfQGxgQwQzrKcTDOj0HPnPZOn4MHeny+dVwlys6+tTHJEmYT2OI1HavMSt5eMY4U
MIME-Version: 1.0
X-Received: by 2002:a24:ee8b:: with SMTP id b133-v6mr1362402iti.37.1540378322404;
 Wed, 24 Oct 2018 03:52:02 -0700 (PDT)
Date:   Wed, 24 Oct 2018 03:52:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba0e9c0578f7460f@google.com>
Subject: BUG: unable to handle kernel paging request in mmu_page_zap_pte
From:   syzbot <syzbot+ba439f0471266afef763@syzkaller.appspotmail.com>
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

HEAD commit:    44786880df19 Merge branch 'parisc-4.20-1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13debe13400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5071a2e3cb82c943
dashboard link: https://syzkaller.appspot.com/bug?extid=ba439f0471266afef763
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16790ff9400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ba439f0471266afef763@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
BUG: unable to handle kernel paging request at ffff8801bcd3d000
kobject: 'kvm' (000000008948623e): kobject_uevent_env
PGD bc01067 P4D bc01067 PUD 80000001800001e3
Oops: 000b [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7199 Comm: syz-executor5 Not tainted 4.19.0+ #77
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__update_clear_spte_fast include/linux/compiler.h:206 [inline]
RIP: 0010:mmu_spte_clear_no_track arch/x86/kvm/mmu.c:819 [inline]
RIP: 0010:drop_parent_pte arch/x86/kvm/mmu.c:1998 [inline]
RIP: 0010:mmu_page_zap_pte+0x295/0x390 arch/x86/kvm/mmu.c:2576
Code: 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c7 85 58 ff ff ff 00 00 00  
00 48 c1 ea 03 80 3c 02 00 0f 85 d4 00 00 00 48 c1 eb 03 <49> c7 45 00 00  
00 00 00 48 b8 00 00 00 00 00 fc ff df 41 be 01 00
RSP: 0018:ffff8801b949f158 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: 1ffff10037293e30 RCX: ffffffff8111254b
RDX: 1ffff100379a7a00 RSI: ffffffff8111262b RDI: 0000000000000007
RBP: ffff8801b949f228 R08: ffff8801b8e66100 R09: ffffed003b5e5b57
R10: ffffed003b5e5b57 R11: ffff8801daf2dabb R12: 1ffff10037293e2c
R13: ffff8801bcd3d000 R14: 0000000000000004 R15: 0000000000000000
FS:  0000000001c2b940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8801bcd3d000 CR3: 00000001c0684000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kvm_mmu_page_unlink_children arch/x86/kvm/mmu.c:2593 [inline]
  kvm_mmu_prepare_zap_page+0x215/0x1830 arch/x86/kvm/mmu.c:2637
  kvm_zap_obsolete_pages arch/x86/kvm/mmu.c:5736 [inline]
  kvm_mmu_invalidate_zap_all_pages+0x348/0x7b0 arch/x86/kvm/mmu.c:5777
  kvm_arch_flush_shadow_all+0x15/0x20 arch/x86/kvm/x86.c:9215
  kvm_mmu_notifier_release+0x59/0x90  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:497
  mmu_notifier_unregister+0x1ff/0x600 mm/mmu_notifier.c:396
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:748 [inline]
  kvm_put_kvm+0x6c0/0xff0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:773
  kvm_vcpu_release+0x7b/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2407
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411021
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffe6a59f310 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000411021
RDX: 0000000000000000 RSI: 0000000000730930 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffe6a59f240 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000008 R15: 0000000000000005
Modules linked in:
CR2: ffff8801bcd3d000
---[ end trace 3fadd54c1e724eb5 ]---
RIP: 0010:__update_clear_spte_fast include/linux/compiler.h:206 [inline]
RIP: 0010:mmu_spte_clear_no_track arch/x86/kvm/mmu.c:819 [inline]
RIP: 0010:drop_parent_pte arch/x86/kvm/mmu.c:1998 [inline]
RIP: 0010:mmu_page_zap_pte+0x295/0x390 arch/x86/kvm/mmu.c:2576
Code: 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c7 85 58 ff ff ff 00 00 00  
00 48 c1 ea 03 80 3c 02 00 0f 85 d4 00 00 00 48 c1 eb 03 <49> c7 45 00 00  
00 00 00 48 b8 00 00 00 00 00 fc ff df 41 be 01 00
RSP: 0018:ffff8801b949f158 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: 1ffff10037293e30 RCX: ffffffff8111254b
RDX: 1ffff100379a7a00 RSI: ffffffff8111262b RDI: 0000000000000007
RBP: ffff8801b949f228 R08: ffff8801b8e66100 R09: ffffed003b5e5b57
R10: ffffed003b5e5b57 R11: ffff8801daf2dabb R12: 1ffff10037293e2c
R13: ffff8801bcd3d000 R14: 0000000000000004 R15: 0000000000000000
FS:  0000000001c2b940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8801bcd3d000 CR3: 00000001c0684000 CR4: 00000000001426e0
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
