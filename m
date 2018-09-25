Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2190FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D3320684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D3320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeIZFyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:54:03 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:34972 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIZFyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:54:02 -0400
Received: by mail-it1-f199.google.com with SMTP id w68-v6so721600ith.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 16:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bC1kM/mp3wWXgyUTyRhRg19acNjt8wqPlVoQ4Lq4md8=;
        b=gP7ll7jVL5ajAEu4alRNm28HNI1bkuy1Z0k9++lk9+yv8uEFsv/AhAGFb8AEWJIh4F
         l9aYApY/wAqd0rtEFEf2Fw/mBvmJ3TRoNMjeJhMpJxkgVQ3gYG6OJfhPutoLzjlV59g3
         enDuZvDWb7iLlz98z2GhBY7723E6UTc4Z/dE+mnchKY/FxAWiNfVGnCStH+JjjU5vV/i
         n9Og9V2ZWz/B6MuY5c7JBNSiLNOXzgwBelD4dYhK01KqJjPEMXRUXFl71ufaYrrOJh78
         yTb0ily1u2pKjHDCcFbh6Dmtujc+zu26VlEWBU1gKK5xFqhAkSVTP3jQSLZWgWhf6JK/
         aEjA==
X-Gm-Message-State: ABuFfohIW5JgwjTbhJ4DK0dou9LfEUMMmyOlovTUtf+5tOy/3AWmbT6n
        PvkmXo1tIu6Rv3syPF69lGaRxYg6bQQ76Gqlo/WCl6hlY6o7
X-Google-Smtp-Source: ACcGV63x/0OmuBqXIRdgx/cxMZdKIri8xN+FfkwAcAm5bPWITti2ReWRKNjZC7ptszXA6zRroTUvgGoqcc88USc4eXpbexXyCxSb
MIME-Version: 1.0
X-Received: by 2002:a24:5953:: with SMTP id p80-v6mr2564630itb.1.1537919043087;
 Tue, 25 Sep 2018 16:44:03 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:44:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041b4c20576baae46@google.com>
Subject: general protection fault in rb_erase
From:   syzbot <syzbot+e81ccd4744c6c4f71354@syzkaller.appspotmail.com>
To:     dmitry.kasatkin@gmail.com, jlayton@kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mjg59@google.com,
        serge@hallyn.com, sudeep.holla@arm.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    846e8dd47c26 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c874a1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
dashboard link: https://syzkaller.appspot.com/bug?extid=e81ccd4744c6c4f71354
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bddd2a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1293d3fa400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e81ccd4744c6c4f71354@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5336 Comm: syz-executor564 Not tainted 4.19.0-rc5+ #31
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:168 [inline]
RIP: 0010:rb_erase+0x306/0x3710 lib/rbtree.c:459
Code: c7 81 28 01 00 00 f2 f2 f2 f2 c7 81 2c 01 00 00 00 f2 f2 f2 48 89 f9  
65 48 8b 1c 25 28 00 00 00 48 89 5d d0 31 db 48 c1 e9 03 <42> 80 3c 01 00  
0f 85 41 1c 00 00 4c 8d 48 10 4c 8b 78 08 48 b9 00
RSP: 0018:ffff8801d782e918 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 1ffff1003af05d2b RSI: ffffffff8b5a08a0 RDI: 0000000000000008
RBP: ffff8801d782f320 R08: dffffc0000000000 R09: fffffbfff135d5c8
R10: fffffbfff135d5c8 R11: ffffffff89aeae43 R12: ffff8801b677f1f0
R13: dffffc0000000000 R14: ffff8801d782f2f8 R15: ffff8801d782f438
FS:  0000000002278880(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000700 CR3: 00000001d84b2000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  integrity_inode_free+0x12f/0x320 security/integrity/iint.c:150
  security_inode_free+0x19/0x90 security/security.c:453
  __destroy_inode+0x328/0x820 fs/inode.c:238
  destroy_inode+0xda/0x200 fs/inode.c:265
  evict+0x5e0/0x980 fs/inode.c:575
  iput_final fs/inode.c:1547 [inline]
  iput+0x679/0xa90 fs/inode.c:1573
  swap_inode_boot_loader fs/ext4/ioctl.c:188 [inline]
  ext4_ioctl+0x236f/0x4210 fs/ext4/ioctl.c:865
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440029
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdcb8f20d8 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440029
RDX: 0000000000440029 RSI: 0000000000006611 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000217 R12: 00000000004018b0
R13: 0000000000401940 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 07a7abe879deb9f2 ]---
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:168 [inline]
RIP: 0010:rb_erase+0x306/0x3710 lib/rbtree.c:459
Code: c7 81 28 01 00 00 f2 f2 f2 f2 c7 81 2c 01 00 00 00 f2 f2 f2 48 89 f9  
65 48 8b 1c 25 28 00 00 00 48 89 5d d0 31 db 48 c1 e9 03 <42> 80 3c 01 00  
0f 85 41 1c 00 00 4c 8d 48 10 4c 8b 78 08 48 b9 00
RSP: 0018:ffff8801d782e918 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 1ffff1003af05d2b RSI: ffffffff8b5a08a0 RDI: 0000000000000008
RBP: ffff8801d782f320 R08: dffffc0000000000 R09: fffffbfff135d5c8
R10: fffffbfff135d5c8 R11: ffffffff89aeae43 R12: ffff8801b677f1f0
R13: dffffc0000000000 R14: ffff8801d782f2f8 R15: ffff8801d782f438
FS:  0000000002278880(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000700 CR3: 00000001d84b2000 CR4: 00000000001406f0
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
