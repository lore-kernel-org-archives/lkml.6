Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34632C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81AF2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551166274;
	bh=XuImi2o4im++Fj3D8C1oGnCfiMsZBO37Z2YxE7XrhRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZMsr0ozvib4QPZIqz7b6pJ2703+F9HuIJksVqYIQOjv/jji8K/rFslOXf+HM9VWSC
	 FLalZ/EE17dwO7O996yDZgC76qfbBxyl5bDPbBivfWEn8A32WlA3JKwZfPNnGHbsBp
	 8TxYwSAJ8hJ1f7LNvNr4TIxcSEkDkBmD/NTE50Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfBZHbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:31:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfBZHbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:31:11 -0500
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net [107.3.167.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B8D1217F9;
        Tue, 26 Feb 2019 07:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551166269;
        bh=XuImi2o4im++Fj3D8C1oGnCfiMsZBO37Z2YxE7XrhRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CGk+90JlU25SAo2sJBLYdTd+Qe+LHZ6laExkEsBhU5rLKnkGPivFiELFziyBzkRaC
         daQJVagX6B0+1ubrX8KB+7cUUZKmHvtUYf0nAUGXxlnlJDnYDmzBLtDaTubHdw/p0X
         almEZFXz9I6zkwFlB4+cFMBLl119NDemFq+eECVk=
Date:   Mon, 25 Feb 2019 23:31:08 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Boris Pismenny <borisp@mellanox.com>
Cc:     syzbot <syzbot+6c4e6ecbf9a2797be67c@syzkaller.appspotmail.com>,
        aviadye@mellanox.com, davejwatson@fb.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Write in tls_push_record (2)
Message-ID: <20190226073107.GC676@sol.localdomain>
References: <000000000000ae783b0570c2ba09@google.com>
 <bb81a2ef-7908-844d-3161-213973342ddb@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb81a2ef-7908-844d-3161-213973342ddb@mellanox.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:44:55AM -0400, Boris Pismenny wrote:
> It seems to me that the crash here is due to write_space being called after
> the close system call. Maybe the correct solution is to move the TX software
> state to be released in sk_destruct. As we already do for the device state
> (see tls_device.c).
> 
> Is anyone looking into this one?
> 
> On 7/11/2018 8:49 PM, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    1e09177acae3 Merge tag 'mips_fixes_4.18_3' of
> > git://git.ke..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=128903b2400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=6c4e6ecbf9a2797be67c
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12312678400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ef76c2400000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+6c4e6ecbf9a2797be67c@syzkaller.appspotmail.com
> > 
> > RDX: 00000000fffffdef RSI: 00000000200005c0 RDI: 0000000000000003
> > RBP: 00000000006cb018 R08: 0000000020000000 R09: 000000000000001c
> > R10: 0000000000000040 R11: 0000000000000212 R12: 0000000000000005
> > R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> > ==================================================================
> > BUG: KASAN: use-after-free in tls_fill_prepend include/net/tls.h:339
> > [inline]
> > BUG: KASAN: use-after-free in tls_push_record+0x1091/0x1400
> > net/tls/tls_sw.c:239
> > Write of size 1 at addr ffff8801ae430000 by task syz-executor589/4567
> > 
> > CPU: 0 PID: 4567 Comm: syz-executor589 Not tainted 4.18.0-rc4+ #141
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
> >   print_address_description+0x6c/0x20b mm/kasan/report.c:256
> >   kasan_report_error mm/kasan/report.c:354 [inline]
> >   kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
> >   __asan_report_store1_noabort+0x17/0x20 mm/kasan/report.c:435
> >   tls_fill_prepend include/net/tls.h:339 [inline]
> >   tls_push_record+0x1091/0x1400 net/tls/tls_sw.c:239
> >   tls_sw_push_pending_record+0x22/0x30 net/tls/tls_sw.c:276
> >   tls_handle_open_record net/tls/tls_main.c:164 [inline]
> >   tls_sk_proto_close+0x74c/0xae0 net/tls/tls_main.c:264
> >   inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
> >   inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
> >   __sock_release+0xd7/0x260 net/socket.c:599
> >   sock_close+0x19/0x20 net/socket.c:1150
> >   __fput+0x355/0x8b0 fs/file_table.c:209
> >   ____fput+0x15/0x20 fs/file_table.c:243
> >   task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
> >   exit_task_work include/linux/task_work.h:22 [inline]
> >   do_exit+0x1b08/0x2750 kernel/exit.c:865
> >   do_group_exit+0x177/0x440 kernel/exit.c:968
> >   __do_sys_exit_group kernel/exit.c:979 [inline]
> >   __se_sys_exit_group kernel/exit.c:977 [inline]
> >   __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
> >   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x43f358
> > Code: Bad RIP value.
> > RSP: 002b:00007fff51750198 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f358
> > RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> > RBP: 00000000004bf448 R08: 00000000000000e7 R09: ffffffffffffffd0
> > R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
> > 
> > The buggy address belongs to the page:
> > page:ffffea0006b90c00 count:0 mapcount:-128 mapping:0000000000000000
> > index:0x0
> > flags: 0x2fffc0000000000()
> > raw: 02fffc0000000000 ffffea0006b96408 ffff88021fffac18 0000000000000000
> > raw: 0000000000000000 0000000000000003 00000000ffffff7f 0000000000000000
> > page dumped because: kasan: bad access detected
> > 
> > Memory state around the buggy address:
> >   ffff8801ae42ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >   ffff8801ae42ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > ffff8801ae430000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >                     ^
> >   ffff8801ae430080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >   ffff8801ae430100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> 

AFAICS this was fixed by this commit:

	commit d829e9c4112b52f4f00195900fd4c685f61365ab
	Author: Daniel Borkmann <daniel@iogearbox.net>
	Date:   Sat Oct 13 02:45:59 2018 +0200

	    tls: convert to generic sk_msg interface

So telling syzbot:

#syz fix: tls: convert to generic sk_msg interface

The issue was that described in this comment in tls_sw_sendmsg():

                /* Open records defined only if successfully copied, otherwise
                 * we would trim the sg but not reset the open record frags.
                 */
                tls_ctx->pending_open_record_frags = true;

Basically, on sendmsg() to a TLS socket, if the message buffer was partially
unmapped, a TLS record would be marked as pending (and then tried to be sent at
sock_release() time) even though it had actually been discarded.

- Eric
