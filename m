Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DB8C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE9D21476
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Q8d9Tz4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE9D21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeJIIs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:48:57 -0400
Received: from imap.thunk.org ([74.207.234.97]:53664 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeJIIs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ihi4W3IBOc1tsldpIlxeFoQDF9VneWSuHU3bpQkbKBI=; b=Q8d9Tz4sWuaQoeTIM+g8RoUhBa
        SiHnO/bM+J3b9HoaWg30oB66xx2TZbg/tzBZr7uZ3q+MpTsO8DRzR7mbvInuhHE4FATLs9zJb5sf7
        6+YCVtObDzvwKNEXq4NLU+rSJv+YUuTUzJ7nNDJKuMQSCI8Pjefz/EzJMrD5Av7gCuhs=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g9guo-00018R-HT; Tue, 09 Oct 2018 01:34:26 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 419C47A7900; Mon,  8 Oct 2018 21:34:25 -0400 (EDT)
Date:   Mon, 8 Oct 2018 21:34:25 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+85da7ac734f7ba432ee4@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in ext4_invalidatepage
Message-ID: <20181009013425.GB3369@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+85da7ac734f7ba432ee4@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000002753c60577b9f707@google.com>
 <CACT4Y+bdR3ch9q_FCND4YmqjunYBVbEk3n167DT0r0GqzVKL-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bdR3ch9q_FCND4YmqjunYBVbEk3n167DT0r0GqzVKL-g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 06:29:54PM +0200, Dmitry Vyukov wrote:
> 
> The program that triggered it did the following:
> 
> 05:23:28 executing program 5:
> r0 = creat(&(0x7f00000001c0)='./file0\x00', 0x0)
> socketpair$unix(0x1, 0x1, 0x0, &(0x7f0000000380)={0xffffffffffffffff,
> <r1=>0xffffffffffffffff})
> write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000240)={0x0, 0x18,
> 0xfa00, {0x0, &(0x7f0000000200)}}, 0x20)

This looks like it's doing an ioctl-like thing which is now restricted
to root --- it looks like people can do arbitrary stupid things with
it?

https://www.openwall.com/lists/oss-security/2016/05/09/11

> ioctl$PERF_EVENT_IOC_ENABLE(r1, 0x8912, 0x400200)
> ioctl$EXT4_IOC_SETFLAGS(r0, 0x4008660f, &(0x7f0000000000)=0x4000)

Um, this doesn't seem to correspond to the stack trace:

> >  do_invalidatepage mm/truncate.c:165 [inline]
> >  truncate_cleanup_page+0x5ac/0xa90 mm/truncate.c:187
> >  truncate_inode_page+0x107/0x1a0 mm/truncate.c:229
> >  truncate_inode_pages_range+0x1382/0x2d50 mm/truncate.c:451
> >  truncate_inode_pages+0x24/0x30 mm/truncate.c:478
> >  swap_inode_boot_loader fs/ext4/ioctl.c:123 [inline]
> >  ext4_ioctl+0x1e3b/0x4210 fs/ext4/ioctl.c:865
> >  vfs_ioctl fs/ioctl.c:46 [inline]
> >  file_ioctl fs/ioctl.c:501 [inline]
> >  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
> >  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
> >  __do_sys_ioctl fs/ioctl.c:709 [inline]
> >  __se_sys_ioctl fs/ioctl.c:707 [inline]
> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
> >  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe

This looks like the program that triggered the crash was running
EXT4_IOC_SWAP_BOOT.  It may have been racing against something that's
was using RDMA, but that's not clear at all, since the write command
appears to be some weird ioctl-like interface that requires root.

It's too bad that syzbot wasn't able to come up with a clean
reproducer.  I've been doing some work to robustify the
EXT4_IOC_SWAP_ROOT.  If we had a reproducer I'd see if this patch
would address it.

	http://patchwork.ozlabs.org/patch/978083/

      	      	       	    	    	    - Ted


> > WARNING: CPU: 1 PID: 17203 at fs/ext4/inode.c:3353
> > ext4_invalidatepage+0x1c7/0x5b0 fs/ext4/inode.c:3353
> > Kernel panic - not syncing: panic_on_warn set ...
> >
> > CPU: 1 PID: 17203 Comm: syz-executor5 Not tainted 4.19.0-rc6+ #48
> > kobject: 'loop3' (000000002393f9b0): kobject_uevent_env
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
> > kobject: 'loop3' (000000002393f9b0): fill_kobj_path: path =
> > '/devices/virtual/block/loop3'
> >  panic+0x238/0x4e7 kernel/panic.c:184
> >  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
> >  report_bug+0x254/0x2d0 lib/bug.c:186
> >  fixup_bug arch/x86/kernel/traps.c:178 [inline]
> >  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
> >  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
> >  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
> > RIP: 0010:ext4_invalidatepage+0x1c7/0x5b0 fs/ext4/inode.c:3353
> > Code: 80 3c 02 00 0f 85 a7 03 00 00 4d 8b 6d 00 31 ff 49 c1 ed 11 41 83 e5
> > 01 4c 89 ee e8 43 ea 67 ff 4d 85 ed 74 07 e8 09 e9 67 ff <0f> 0b e8 02 e9 67
> > ff 8b b5 34 ff ff ff 44 89 fa 4c 89 e7 e8 91 3a
> > RSP: 0018:ffff88018590ec78 EFLAGS: 00010212
> > RAX: 0000000000040000 RBX: 1ffff10030b21d91 RCX: ffffc9000dae4000
> > RDX: 0000000000000ece RSI: ffffffff8216ec87 RDI: 0000000000000007
> > RBP: ffff88018590ed50 R08: ffff880183018300 R09: fffff94000ceffc6
> > R10: fffff94000ceffc6 R11: ffffea000677fe33 R12: ffffea000677fe00
> > R13: 0000000000000001 R14: ffffea000677fe08 R15: 0000000000001000
> >  do_invalidatepage mm/truncate.c:165 [inline]
> >  truncate_cleanup_page+0x5ac/0xa90 mm/truncate.c:187
> >  truncate_inode_page+0x107/0x1a0 mm/truncate.c:229
> >  truncate_inode_pages_range+0x1382/0x2d50 mm/truncate.c:451
> >  truncate_inode_pages+0x24/0x30 mm/truncate.c:478
> >  swap_inode_boot_loader fs/ext4/ioctl.c:123 [inline]
> >  ext4_ioctl+0x1e3b/0x4210 fs/ext4/ioctl.c:865
> >  vfs_ioctl fs/ioctl.c:46 [inline]
> >  file_ioctl fs/ioctl.c:501 [inline]
> >  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
> >  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
> >  __do_sys_ioctl fs/ioctl.c:709 [inline]
> >  __se_sys_ioctl fs/ioctl.c:707 [inline]
> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
> >  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x457579
> > Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> > 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007fa151655c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
> > RDX: 0000000020000000 RSI: 0000000000006611 RDI: 0000000000000006
> > RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa1516566d4
> > R13: 00000000004bf60e R14: 00000000004cf4a8 R15: 00000000ffffffff
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> > syzbot.
> >
> > --
> > You received this message because you are subscribed to the Google Groups
> > "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an
> > email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit
> > https://groups.google.com/d/msgid/syzkaller-bugs/0000000000002753c60577b9f707%40google.com.
> > For more options, visit https://groups.google.com/d/optout.
