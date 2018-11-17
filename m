Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E68FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 13:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFEC20818
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 13:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC3Li+kY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFEC20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeKQXxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 18:53:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbeKQXxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 18:53:10 -0500
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A6920815;
        Sat, 17 Nov 2018 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542461787;
        bh=fvTaDa6YrAUeIj12DCaFAmzV+gt817/48vJLaARFNik=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VC3Li+kYZrFDPYrsxSKipojOBerD8hrWOu2n0p225GQXT3pdUm5tsuEAF1hHEhZpc
         mPzES6HmD3IlT/yO7ou3ruCrhZsW61bsnJjf7gb+VSfxoSd8DDcT401a6iI0r9Lstn
         IJtS9ceDXXRjNL+hAxiQSZd8Sh66IlQc6R4O2hv8=
Message-ID: <d357df98f4ba728f0252ac32861593b547af0d27.camel@kernel.org>
Subject: Re: KASAN: stack-out-of-bounds Read in locks_remove_flock
From:   Jeff Layton <jlayton@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+1818cd833edc063452c6@syzkaller.appspotmail.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        NeilBrown <neilb@suse.com>
Date:   Sat, 17 Nov 2018 08:36:25 -0500
In-Reply-To: <CACT4Y+Zh4GmqecF0ftBjGUg0Zvi2Gto7QLzFcDe_+LGASxX5BQ@mail.gmail.com>
References: <00000000000082cc8d057a0c0877@google.com>
         <CACT4Y+Zh4GmqecF0ftBjGUg0Zvi2Gto7QLzFcDe_+LGASxX5BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 12:40 -0800, Dmitry Vyukov wrote:
> On Tue, Nov 6, 2018 at 9:03 PM, syzbot
> <syzbot+1818cd833edc063452c6@syzkaller.appspotmail.com> wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    d881de30d29e Add linux-next specific files for 20181107
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14aa485d400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=caa433e1c8778437
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1818cd833edc063452c6
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+1818cd833edc063452c6@syzkaller.appspotmail.com
> 
> This is another manifestation of the following report, right?
> 
> #syz dup: KASAN: use-after-free Read in locks_delete_block
> 

Slightly different manifestation in this case, but the same bug, yes.

> > ==================================================================
> > BUG: KASAN: stack-out-of-bounds in locks_remove_flock+0x33c/0x350
> > fs/locks.c:2567
> > Read of size 8 at addr ffff8801c71c7a08 by task syz-executor5/20562
> > 
> > CPU: 0 PID: 20562 Comm: syz-executor5 Not tainted 4.20.0-rc1-next-20181107+
> > #107
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x244/0x39d lib/dump_stack.c:113
> >  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
> >  kasan_report_error mm/kasan/report.c:354 [inline]
> >  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
> >  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> >  locks_remove_flock+0x33c/0x350 fs/locks.c:2567
> >  locks_remove_file+0x148/0x5c0 fs/locks.c:2607
> >  __fput+0x2f0/0xa70 fs/file_table.c:271
> >  ____fput+0x15/0x20 fs/file_table.c:312
> >  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
> >  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
> >  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
> >  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
> >  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
> >  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x411021
> > Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48
> > 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89
> > c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
> > RSP: 002b:00007ffdb42509a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> > RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000411021
> > RDX: 0000000000000000 RSI: 0000000000732ea0 RDI: 0000000000000004
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > R10: 00007ffdb42508c0 R11: 0000000000000293 R12: 0000000000000000
> > R13: 0000000000000001 R14: 0000000000000201 R15: 0000000000000005
> > 
> > The buggy address belongs to the page:
> > page:ffffea00071c71c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> > flags: 0x2fffc0000000000()
> > raw: 02fffc0000000000 0000000000000000 ffffffff071c0101 0000000000000000
> > raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> > 
> > Memory state around the buggy address:
> >  ffff8801c71c7900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  ffff8801c71c7980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 
> > > ffff8801c71c7a00: f2 f2 f2 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 
> >                       ^
> >  ffff8801c71c7a80: 00 f1 f1 f1 f1 00 00 f2 f2 f2 f2 f2 f2 f8 f2 f2
> >  ffff8801c71c7b00: f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00 00 00 00
> > ==================================================================
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
> > https://groups.google.com/d/msgid/syzkaller-bugs/00000000000082cc8d057a0c0877%40google.com.
> > For more options, visit https://groups.google.com/d/optout.

-- 
Jeff Layton <jlayton@kernel.org>

