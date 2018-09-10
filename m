Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30168C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE7F2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE7F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeIJNW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:22:58 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:32906 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeIJNW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:22:58 -0400
Received: by mail-it0-f69.google.com with SMTP id u126-v6so7791567itb.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=w9wUxKRfa6Ha7HC98xHDXJZmCdYcmT8Su3JMtDnyyQ0=;
        b=Hrfutf9/XiIwOpj77n/GYhhpirvUDHxHgLFXG0uoy3Cjk4IH9tCppNDofg/IVxOrvD
         8UjyPTpPxsL2fVu7toFaoIVoAoDQT9RK7bMepYLQxUH3al6KtWovzuseZXv1y5ijqrrj
         Vq5wdfwNP/tJqhuPF1FPs+QCKHWfCf4WWDZWSlqb/jhrDTrgnKgbco3hS/cGAp/GDmsL
         GzTLf5pFvSeqifL2Dk3XzeO1MEQJeaWJAQ7spdj0jwFt0IJS67FPgIa7DCXYUEML9dwF
         47wwxgx58oUrkkb537j5HMPnwuJAFlNJj8FQLORDvQ6FcIeP9FxZes4IEpJIeIvmM3hF
         z2Rg==
X-Gm-Message-State: APzg51DQmvtC4zu4UmnOvZo10psn1D3LMesu/5+oPhJ9Wu7KYAXuLxw6
        8sIN8gPZepmRF/W3rBBoK3AAWZtwKDo4bwOm384nHt/H2UKj
X-Google-Smtp-Source: ANB0VdYXjdQhTv0Dl+0LLJ2xAPsuzQCzFnEC67FvJlaAkE97wHrkxyILW788uO5e47pxmYpzAQscOezMYICMYL+SNbxSXzR6F5AY
MIME-Version: 1.0
X-Received: by 2002:a24:b94e:: with SMTP id k14-v6mr308891iti.8.1536568203131;
 Mon, 10 Sep 2018 01:30:03 -0700 (PDT)
Date:   Mon, 10 Sep 2018 01:30:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebd44005758029c2@google.com>
Subject: KASAN: use-after-free Read in bpf_prog_kallsyms_add
From:   syzbot <syzbot+ac0311cfc9e80cd2e0e8@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f6f3bac08ff9 tools/bpf: bpftool: add net support
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=151ff9b6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=ac0311cfc9e80cd2e0e8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ac0311cfc9e80cd2e0e8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0x8f/0xb0 lib/list_debug.c:26
Read of size 8 at addr ffff8801b843a220 by task syz-executor2/19913

CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __list_add_valid+0x8f/0xb0 lib/list_debug.c:26
  __list_add_rcu include/linux/rculist.h:52 [inline]
  list_add_tail_rcu include/linux/rculist.h:101 [inline]
  bpf_prog_ksym_node_add kernel/bpf/core.c:457 [inline]
  bpf_prog_kallsyms_add+0x200/0x9b0 kernel/bpf/core.c:488
  bpf_prog_load+0x13d1/0x1cb0 kernel/bpf/syscall.c:1442
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a041f598 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a041f710 R08: ffff880197a4a600 R09: ffffed003b584732
R10: ffffed003b584732 R11: ffff8801dac23993 R12: 1ffff10034083ed5
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#2] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a041ee38 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a041efb0 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff10034083de9
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#3] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a041e6d8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a041e850 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff10034083cfd
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#4] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a041df78 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a041e0f0 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff10034083c11
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#5] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a041d818 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a041d990 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff10034083b25
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#6] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a041d0b8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a041d230 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff10034083a39
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#7] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a041c958 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a041cad0 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff1003408394d
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#8] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a041c1f8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a041c370 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff10034083861
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#9] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a041ba98 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a041bc10 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff10034083775
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#10] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a041b338 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a041b4b0 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff10034083689
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#11] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a041abd8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a041ad50 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff1003408359d
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#12] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a041a478 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a041a5f0 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff100340834b1
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#13] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a0419d18 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a0419e90 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff100340833c5
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Oops: 0000 [#14] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a04195b8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a0419730 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff100340832d9
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#15] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a0418e58 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a0418fd0 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff100340831ed
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#16] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a04186f8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a0418870 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff10034083101
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#17] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a0417f98 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a0418110 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff10034083015
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#18] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a0417838 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a04179b0 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff10034082f29
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#19] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a04170d8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a0417250 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff10034082e3d
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001935030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d45bd067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#20] PREEMPT SMP KASAN
CPU: 0 PID: 19913 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a0416978 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a0416af0 R08: ffff880197a4a600 R09: 0000000000000001
R10: ffffed003b584732 R11: 0000000000000000 R12: 1ffff10034082d51
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
Modules linked in:
Dumping ftrace buffer:
---------------------------------
CPU:0 [LOST 7646 EVENTS]
syz-exec-16687   0...1 217412324us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412329us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412334us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412339us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412344us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412349us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412354us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412359us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412364us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412369us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412374us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412379us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412384us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412389us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412394us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412399us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412404us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412409us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412414us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412419us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412424us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412429us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412434us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412439us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412445us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412449us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412454us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412459us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412463us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412469us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412473us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412479us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412484us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412489us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412507us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412513us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412518us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412523us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412528us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412532us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412538us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412543us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412548us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412553us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412558us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412563us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412568us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412573us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412578us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412583us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412588us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412593us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412598us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412603us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412609us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412614us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412619us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412624us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412629us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412635us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412640us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412645us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412650us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412655us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412660us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412665us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412670us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412676us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412681us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412686us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412691us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412696us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412701us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412706us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412711us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412716us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412722us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412727us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412732us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412737us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412742us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412748us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412761us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412767us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412772us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412777us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412782us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412788us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412793us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412798us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412802us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412807us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412812us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412817us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412822us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412826us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412832us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412837us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412842us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412846us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412851us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412856us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412863us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412868us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412873us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412878us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412883us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412888us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412893us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412898us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412903us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412908us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412913us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412918us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412924us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412929us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412934us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412939us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412944us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412949us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412954us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412959us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412965us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412970us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412975us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412980us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412985us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412990us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217412995us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217413000us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217413006us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217413011us : 0: u000000000958b6c8	
syz-exec-16687   0.N.1 217413051us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217415442us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217415448us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217415453us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217415457us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217415462us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217415466us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217415470us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217415474us : 0: u000000000958b6c8	
syz-exec-16687   0...1 217415479us : 0: u000000000958b6c8	
syz-exec-16687   0.N.1 217415630us : 0: u000000000958b6c8	
---------------------------------
CR2: ffffc90001935030
---[ end trace 4908ab663d8e7ff1 ]---
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801a041f598 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801b843a1f0 RCX: ffffffff818b41d1
RDX: 1ffff92000326a06 RSI: 0000000000000008 RDI: ffffc90001935002
RBP: ffff8801a041f710 R08: ffff880197a4a600 R09: ffffed003b584732
R10: ffffed003b584732 R11: ffff8801dac23993 R12: 1ffff10034083ed5
R13: ffffc90001935000 R14: dffffc0000000000 R15: ffff8801b843a1f0
FS:  00007f1716646700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001935030 CR3: 00000001cd5b5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
