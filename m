Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB6BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6312075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6312075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbeGRW7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:59:01 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:53541 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbeGRW7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:59:00 -0400
Received: by mail-it0-f70.google.com with SMTP id u140-v6so3813158itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=o85wHT0UBwU2C797nrByqNU6E7FDx3MZLjrCVRJyePE=;
        b=cjlx4fp25U8tvH1FpC0LUS5459LgpMfiTEX3DiaKNpTnPDM2LnGpgX9l98OzqmCHH1
         hDLJr7F4Up1UPgCXTWLnV9B8WbsLg0rr1LHl2tnrD+stpZSqrV3zopNG7jLmUu9vAEFc
         5pahftwAburHKOeLDyE6ILKAiqwgAulzBhkyrSWZ2Rzw2+7TmwPrhT7dgmxi7L2he6iY
         PDp3lAzwuc4Qxw8UUPrRDbHlNMGGTZodV9MZokIgecTGXZD+UKCzsdOwBMzd2zOCklIr
         TzbfOjNznDZonmX2TYHKZ8nx5rSzddUnwBd8AGJEnu6erix+HA3ttQMaGym7IRMJNnHF
         ENeA==
X-Gm-Message-State: AOUpUlGkiHlo1nhGzYHEknQEai6y5T2Pd6Vgu7n5gJPlgqLTCB6BxD5F
        jGNU4Q57Dza9h0PmExfDFuiB+jBT4SNEa5fTMAqNPdxsiIIL
X-Google-Smtp-Source: AAOMgpethN2JfFhlGEZl+dhAEsGhRZDdURT1qoscmU6iCpMpaQoYvad5wPW2VIeN/TDxjFMKOUIefP/cj/tJq8ivJeZ4drn8Hv4s
MIME-Version: 1.0
X-Received: by 2002:a24:b30f:: with SMTP id e15-v6mr1864021itf.48.1531952342455;
 Wed, 18 Jul 2018 15:19:02 -0700 (PDT)
Date:   Wed, 18 Jul 2018 15:19:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f5daa05714d739b@google.com>
Subject: KASAN: stack-out-of-bounds Read in bpf_tcp_close
From:   syzbot <syzbot+65a97319fd875ea52b73@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8ae71e76cf1f Merge branch 'bpf-offload-sharing'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1379a978400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89129667b46496c3
dashboard link: https://syzkaller.appspot.com/bug?extid=65a97319fd875ea52b73
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=114f4b2c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1774932c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+65a97319fd875ea52b73@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
IPVS: ftp: loaded support on port[0] = 21
==================================================================
swap_info_get: Bad swap file entry 8007fffc400d72b
BUG: KASAN: stack-out-of-bounds in __read_once_size  
include/linux/compiler.h:188 [inline]
BUG: KASAN: stack-out-of-bounds in smap_psock_sk kernel/bpf/sockmap.c:149  
[inline]
BUG: KASAN: stack-out-of-bounds in bpf_tcp_close+0xf10/0x1050  
kernel/bpf/sockmap.c:316
Read of size 8 at addr ffff8801adcc4428 by task syz-executor115/24313
BUG: Bad page map in process syz-executor115  pte:1ffff10035cac810  
pmd:1ae564067

CPU: 0 PID: 24313 Comm: syz-executor115 Not tainted 4.18.0-rc3+ #58
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:

addr:(____ptrval____) vm_flags:00000875 anon_vma:          (null)  
mapping:(____ptrval____) index:0
Allocated by task 2294230744:
usercopy: Kernel memory overwrite attempt detected to SLAB  
object 'task_struct(17:syz0)' (offset 6088, size 2)!
file:syz-executor115250413 fault:ext4_filemap_fault mmap:ext4_file_mmap  
readpage:ext4_readpage
------------[ cut here ]------------
Bad or missing usercopy whitelist? Kernel memory overwrite attempt detected  
to SLAB object 'task_struct(17:syz0)' (offset 4936, size 2)!
WARNING: CPU: 0 PID: 24313 at mm/usercopy.c:81 usercopy_warn+0xf5/0x120  
mm/usercopy.c:76
CPU: 1 PID: 4479 Comm: syz-executor115 Not tainted 4.18.0-rc3+ #58
Kernel panic - not syncing: panic_on_warn set ...

Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_bad_pte.cold.116+0x1cd/0x22b mm/memory.c:774
  zap_pte_range mm/memory.c:1380 [inline]
  zap_pmd_range mm/memory.c:1437 [inline]
  zap_pud_range mm/memory.c:1466 [inline]
  zap_p4d_range mm/memory.c:1487 [inline]
  unmap_page_range+0x1cb9/0x2220 mm/memory.c:1508
  unmap_single_vma+0x1a0/0x310 mm/memory.c:1553
  unmap_vmas+0x120/0x1f0 mm/memory.c:1583
  exit_mmap+0x2c2/0x5b0 mm/mmap.c:3105
  __mmput kernel/fork.c:970 [inline]
  mmput+0x265/0x620 kernel/fork.c:991
  exit_mm kernel/exit.c:544 [inline]
  do_exit+0xea9/0x2750 kernel/exit.c:852
  do_group_exit+0x177/0x440 kernel/exit.c:968
  get_signal+0x88e/0x1970 kernel/signal.c:2468
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e0/0x370 arch/x86/entry/common.c:162
  prepare_exit_to_usermode+0x342/0x3b0 arch/x86/entry/common.c:197
  retint_user+0x8/0x18
RIP: 0033:0x4731e0
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00  
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 002b:00007ffd426a9928 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000002e7e RCX: 00000000004731e0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffd426a9930
RBP: 0000000000002e7e R08: 0000000000000001 R09: 0000000000e2a880
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000f7e
R13: 000000000003ab5f R14: 0000000000000000 R15: 0000000000000000
CPU: 0 PID: 24313 Comm: syz-executor115 Not tainted 4.18.0-rc3+ #58
swap_info_get: Bad swap file entry 403fffe200725fc
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
