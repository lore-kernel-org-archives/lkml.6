Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53D6C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF00208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF00208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754407AbeGIFzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:55:04 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:50772 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeGIFzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:55:02 -0400
Received: by mail-it0-f70.google.com with SMTP id g125-v6so14879583ita.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 22:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=F4NQ+gyCl/DNC86gVQ5HpdBSpbzySHkCXIBuXPYDEyA=;
        b=bfIF9EKUWVlMEcFe2O8ncRNAEF6uDmFrKFfZ64x+EA/BlCWjEu2+3L/oWR9xUdcWN+
         /XjMtpdV0Ewz8qy6oVnRp1jr3UnJgR1c/5qsiOZZa2RmLqWumkWtmkB2wtE15L78+Op8
         iQm28elvtbfOJ9gPuT+wnUFme+i+G+8kMqM2JWP9nvPhBYeSDvejRPTQOUpPEY89D6Ki
         RledxZsLu8CuHnVGxGX+mIEr6barCwW81EpYv1uf9BHQ0yaUXJvq94KV1rP23VXP6NTo
         8kjkpXB7BdKbC1GguSMeNA91KghW1+P05MlSi6btZK5ippVMB9YXV0c4aMIWgIdr8y6A
         RVFA==
X-Gm-Message-State: APt69E2d0JrboModAgBmAnb2jhvJtrVUdrwNfq3OCn5AzUPtFsajMh3X
        IFpEK/NpVk/cp6kANoObmJ1MxgsLAo93V4rfkE8C3+iM7AKK
X-Google-Smtp-Source: AAOMgpec/xBc5vNHh2Y2Dt27DNb73WwrBUIj3gmoxX6wkXO1swuevrFE3N5dKTBY8zxuC9gtvJWQnIjvJJRN3iR8rskB4zl+6+Nu
MIME-Version: 1.0
X-Received: by 2002:a02:5c01:: with SMTP id q1-v6mr8899223jab.31.1531115702318;
 Sun, 08 Jul 2018 22:55:02 -0700 (PDT)
Date:   Sun, 08 Jul 2018 22:55:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c012905708aa7bf@google.com>
Subject: BUG: unable to handle kernel paging request in kfree (2)
From:   syzbot <syzbot+ad37a4e3a54f2dbc5546@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ca04b3cca11a Merge tag 'armsoc-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116d29b2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=ad37a4e3a54f2dbc5546
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=144c8162400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17daa6d0400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ad37a4e3a54f2dbc5546@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
BUG: unable to handle kernel paging request at ffffebe000000008
PGD 0 P4D 0
Oops: 0000 [#1] SMP KASAN
CPU: 1 PID: 4512 Comm: syz-executor551 Not tainted 4.18.0-rc3+ #137
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:virt_to_head_page include/linux/mm.h:638 [inline]
RIP: 0010:virt_to_cache mm/slab.c:399 [inline]
RIP: 0010:kfree+0xa0/0x260 mm/slab.c:3809
Code: 82 cb 01 00 00 48 ba 00 00 00 80 ff 77 00 00 48 01 c2 48 89 df 48 b8  
00 00 00 00 00 ea ff ff 48 c1 ea 0c 48 c1 e2 06 48 01 c2 <48> 8b 42 08 a8  
01 48 8d 48 ff 48 0f 45 d1 4c 8b 6a 18 49 63 75 74
RSP: 0018:ffff8801c9d0f520 EFLAGS: 00010086
RAX: ffffea0000000000 RBX: 0000000000000286 RCX: 0000000000000000
RDX: ffffebe000000000 RSI: 0000000000000000 RDI: 0000000000000286
RBP: ffff8801c9d0f540 R08: ffffed003b5e46d7 R09: ffffed003b5e46d6
R10: ffffed003b5e46d6 R11: ffff8801daf236b3 R12: 0000000000000286
R13: ffffffff8766d6c3 R14: ffff8801c9d0f690 R15: ffff8801af230380
FS:  00000000012d0880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffebe000000008 CR3: 00000001aff92000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  p9_client_version net/9p/client.c:1009 [inline]
  p9_client_create+0xf43/0x16c9 net/9p/client.c:1069
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4401d9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe6e8d4698 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401d9
RDX: 00000000200002c0 RSI: 00000000200001c0 RDI: 0000000000000000
RBP: 00000000006ca018 R08: 00000000200003c0 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401a60
R13: 0000000000401af0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: ffffebe000000008
---[ end trace a145a38935e2c7cf ]---
RIP: 0010:virt_to_head_page include/linux/mm.h:638 [inline]
RIP: 0010:virt_to_cache mm/slab.c:399 [inline]
RIP: 0010:kfree+0xa0/0x260 mm/slab.c:3809
Code: 82 cb 01 00 00 48 ba 00 00 00 80 ff 77 00 00 48 01 c2 48 89 df 48 b8  
00 00 00 00 00 ea ff ff 48 c1 ea 0c 48 c1 e2 06 48 01 c2 <48> 8b 42 08 a8  
01 48 8d 48 ff 48 0f 45 d1 4c 8b 6a 18 49 63 75 74
RSP: 0018:ffff8801c9d0f520 EFLAGS: 00010086
RAX: ffffea0000000000 RBX: 0000000000000286 RCX: 0000000000000000
RDX: ffffebe000000000 RSI: 0000000000000000 RDI: 0000000000000286
RBP: ffff8801c9d0f540 R08: ffffed003b5e46d7 R09: ffffed003b5e46d6
R10: ffffed003b5e46d6 R11: ffff8801daf236b3 R12: 0000000000000286
R13: ffffffff8766d6c3 R14: ffff8801c9d0f690 R15: ffff8801af230380
FS:  00000000012d0880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffebe000000008 CR3: 00000001aff92000 CR4: 00000000001406e0
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
