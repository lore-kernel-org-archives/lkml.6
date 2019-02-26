Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74608C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359C22083D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551167961;
	bh=Vfpv/pTHyVndV3yzWih+2KxssxNtw75TZ7i0LtXnGcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yQqSYxrhyAJ5ZY6YnjAmOpDIS05F61NsvGt4q5gvRdQNUJinL2+p4pFymlOhSZ8BQ
	 UW3DsViAPnr0Qk/H2dr8qzsiQURmfq6VzI5mv4L/E9ufKxnfYk9SnEpNQceZVEIzPB
	 ed3kkIc3RvoHE64pefi6BTCCJWdrfzHZY0vavuuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfBZH7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:59:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfBZH7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:59:19 -0500
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net [107.3.167.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1E1820684;
        Tue, 26 Feb 2019 07:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551167958;
        bh=Vfpv/pTHyVndV3yzWih+2KxssxNtw75TZ7i0LtXnGcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAxHHzkpEYW6oltaTEvMjA/keGB6uMJwkzMmdk/OTMFTTEyJ7gnkAL0IArySt315m
         6t/J6gmeKtjo/a7ERvWATtCxhHWpCEy13KmNsCF0VwW7yJpI8ZUP0UOMBFK9ZmudHJ
         Lbm94fSat7iT4MONc0ScbmkR+IGBjp1LyT4K8PmY=
Date:   Mon, 25 Feb 2019 23:59:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+43358359519ad16cf05e@syzkaller.appspotmail.com>
Cc:     aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: out-of-bounds Write in tls_push_record
Message-ID: <20190226075915.GG676@sol.localdomain>
References: <0000000000007567f0057072d2e7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007567f0057072d2e7@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 06:29:03PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    526674536360 Add linux-next specific files for 20180706
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17e63968400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
> dashboard link: https://syzkaller.appspot.com/bug?extid=43358359519ad16cf05e
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15790594400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b53f48400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+43358359519ad16cf05e@syzkaller.appspotmail.com
> 
> RDX: 00000000fffffdef RSI: 00000000200005c0 RDI: 0000000000000004
> RBP: 00000000006cb018 R08: 0000000020000000 R09: 000000000000001c
> R10: 0000000000000040 R11: 0000000000000216 R12: 0000000000000005
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> ==================================================================
> BUG: KASAN: out-of-bounds in tls_fill_prepend include/net/tls.h:339 [inline]
> BUG: KASAN: out-of-bounds in tls_push_record+0x1091/0x1400
> net/tls/tls_sw.c:239
> Write of size 1 at addr ffff8801c07b8000 by task syz-executor985/4467
> 
> CPU: 0 PID: 4467 Comm: syz-executor985 Not tainted 4.18.0-rc3-next-20180706+
> #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
>  __asan_report_store1_noabort+0x17/0x20 mm/kasan/report.c:435
>  tls_fill_prepend include/net/tls.h:339 [inline]
>  tls_push_record+0x1091/0x1400 net/tls/tls_sw.c:239
>  tls_sw_push_pending_record+0x22/0x30 net/tls/tls_sw.c:276
>  tls_handle_open_record net/tls/tls_main.c:164 [inline]
>  tls_sk_proto_close+0x74c/0xae0 net/tls/tls_main.c:264
>  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
>  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
>  __sock_release+0xd7/0x260 net/socket.c:600
>  sock_close+0x19/0x20 net/socket.c:1151
>  __fput+0x35d/0x930 fs/file_table.c:215
>  ____fput+0x15/0x20 fs/file_table.c:251
>  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x1b08/0x2750 kernel/exit.c:869
>  do_group_exit+0x177/0x440 kernel/exit.c:972
>  __do_sys_exit_group kernel/exit.c:983 [inline]
>  __se_sys_exit_group kernel/exit.c:981 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:981
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x43f358
> Code: Bad RIP value.
> RSP: 002b:00007ffd4c2414b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f358
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00000000004bf448 R08: 00000000000000e7 R09: ffffffffffffffd0
> R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
> 
> The buggy address belongs to the page:
> page:ffffea000701ee00 count:0 mapcount:-128 mapping:0000000000000000
> index:0x0
> flags: 0x2fffc0000000000()
> raw: 02fffc0000000000 ffffea0006b7be08 ffff88021fffac18 0000000000000000
> raw: 0000000000000000 0000000000000003 00000000ffffff7f 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801c07b7f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff8801c07b7f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > ffff8801c07b8000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                       ^
>  ffff8801c07b8080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff8801c07b8100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==================================================================
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 

(As with the other reports of this...)

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
