Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDC9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF8421850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551300890;
	bh=FNiroWBoSPytfCu610/SryGl0TLQVJ5OlCZP7l95iqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zKgEv5CtABIqhBlnbD6LWcd0uxxneKuLGR/uNt9uVP2CKs595frdm9dEUet+dK3Yo
	 pKGacpLLUd8G0faxwXTQuGkk1kfRMKlo+3Z2Ntpe1wz3UH0qzZ1O6jhvGcNHx6LzVN
	 sq/pdrO+3aqDukN1IVHLnDb3f462Iv7S2qFB5Ssk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfB0Uyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:54:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfB0Uys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:54:48 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3DC6217F5;
        Wed, 27 Feb 2019 20:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551300887;
        bh=FNiroWBoSPytfCu610/SryGl0TLQVJ5OlCZP7l95iqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qaBlOMybg9nxM95KhZVU0Xdrj+mlPXGJUxX8ps4Zznu0WmeL7eH1HJiQ0/No2Q8DE
         aZR5wJJRG3ta4O/eD54XPKSDMcvCgYUWAxLcvVwaIOCc0vgJuJ5Ezj9YXj/rLfkYt7
         AJdY7aC/bI+MPTpnkCdA/MUhq5yFZ6xpWT9Y+HmE=
Date:   Wed, 27 Feb 2019 12:54:45 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+a5b71df98b247d973f8c@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: kernel BUG at include/linux/mm.h:LINE! (3)
Message-ID: <20190227205444.GB186986@gmail.com>
References: <000000000000b8bcea0582d9e992@google.com>
 <20190227061143.GA680@sol.localdomain>
 <10ff57b7-5f61-a447-e9af-e883b418f12d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ff57b7-5f61-a447-e9af-e883b418f12d@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 06:13:19AM -0700, Jens Axboe wrote:
> On 2/26/19 11:11 PM, Eric Biggers wrote:
> > On Tue, Feb 26, 2019 at 10:02:04PM -0800, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    8e7f81e2ebc4 Add linux-next specific files for 20190226
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=10381714c00000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=2fa10211b8a4a56e
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=a5b71df98b247d973f8c
> >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eda192c00000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164831e0c00000
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+a5b71df98b247d973f8c@syzkaller.appspotmail.com
> >>
> >> page:ffffea00025c3ac0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> >> flags: 0x1fffc0000000000()
> >> raw: 01fffc0000000000 ffffea00024bf988 ffffea00021dd448 0000000000000000
> >> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> >> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
> >> ------------[ cut here ]------------
> >> kernel BUG at include/linux/mm.h:579!
> >> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> >> CPU: 0 PID: 7779 Comm: syz-executor379 Not tainted 5.0.0-rc8-next-20190226
> >> #43
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> Google 01/01/2011
> >> RIP: 0010:put_page_testzero include/linux/mm.h:579 [inline]
> >> RIP: 0010:put_page include/linux/mm.h:1025 [inline]
> >> RIP: 0010:generic_pipe_buf_release+0x120/0x160 fs/pipe.c:224
> >> Code: bd ff 4c 89 e7 e8 90 43 db ff e8 bb 29 bd ff 5b 41 5c 41 5d 5d c3 e8
> >> af 29 bd ff 48 c7 c6 20 98 75 87 4c 89 e7 e8 c0 db e4 ff <0f> 0b e8 99 29 bd
> >> ff 4d 8d 65 ff e9 3d ff ff ff 48 89 df e8 e8 f8
> >> RSP: 0018:ffff8880a503f920 EFLAGS: 00010293
> >> RAX: ffff88808d2ec6c0 RBX: ffffea00025c3af4 RCX: 0000000000000000
> >> RDX: 0000000000000000 RSI: ffffffff81982852 RDI: ffffea00025c3af8
> >> RBP: ffff8880a503f938 R08: 000000000000003e R09: ffffed1015d05011
> >> R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffffea00025c3ac0
> >> R13: 0000000000000000 R14: ffff88809b6e8a40 R15: ffff8880952c4000
> >> FS:  00000000016a0880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 0000000020f50f90 CR3: 0000000097b89000 CR4: 00000000001406f0
> >> Call Trace:
> >>  pipe_buf_release include/linux/pipe_fs_i.h:129 [inline]
> >>  iter_file_splice_write+0x7d1/0xbe0 fs/splice.c:759
> >>  do_splice_from fs/splice.c:847 [inline]
> >>  direct_splice_actor+0x126/0x1a0 fs/splice.c:1019
> >>  splice_direct_to_actor+0x369/0x970 fs/splice.c:974
> >>  do_splice_direct+0x1da/0x2a0 fs/splice.c:1062
> >>  do_sendfile+0x597/0xd00 fs/read_write.c:1442
> >>  __do_sys_sendfile64 fs/read_write.c:1503 [inline]
> >>  __se_sys_sendfile64 fs/read_write.c:1489 [inline]
> >>  __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1489
> >>  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
> >>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >> RIP: 0033:0x443d29
> >> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> >> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> >> 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> >> RSP: 002b:00007fffc1e47c88 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> >> RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443d29
> >> RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000003
> >> RBP: 00000000006ce018 R08: 00000000004002e0 R09: 00000000004002e0
> >> R10: 0000000102000300 R11: 0000000000000246 R12: 0000000000401a30
> >> R13: 0000000000401ac0 R14: 0000000000000000 R15: 0000000000000000
> >> Modules linked in:
> >> ---[ end trace 9daff95e0e1a45ff ]---
> >> RIP: 0010:put_page_testzero include/linux/mm.h:579 [inline]
> >> RIP: 0010:put_page include/linux/mm.h:1025 [inline]
> >> RIP: 0010:generic_pipe_buf_release+0x120/0x160 fs/pipe.c:224
> >> Code: bd ff 4c 89 e7 e8 90 43 db ff e8 bb 29 bd ff 5b 41 5c 41 5d 5d c3 e8
> >> af 29 bd ff 48 c7 c6 20 98 75 87 4c 89 e7 e8 c0 db e4 ff <0f> 0b e8 99 29 bd
> >> ff 4d 8d 65 ff e9 3d ff ff ff 48 89 df e8 e8 f8
> >> RSP: 0018:ffff8880a503f920 EFLAGS: 00010293
> >> RAX: ffff88808d2ec6c0 RBX: ffffea00025c3af4 RCX: 0000000000000000
> >> RDX: 0000000000000000 RSI: ffffffff81982852 RDI: ffffea00025c3af8
> >> RBP: ffff8880a503f938 R08: 000000000000003e R09: ffffed1015d05011
> >> R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffffea00025c3ac0
> >> R13: 0000000000000000 R14: ffff88809b6e8a40 R15: ffff8880952c4000
> >> FS:  00000000016a0880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 0000000020f50f90 CR3: 0000000097b89000 CR4: 00000000001406f0
> >>
> >>
> >> ---
> >> This bug is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>
> >> syzbot will keep track of this bug report. See:
> >> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> >> syzbot.
> >> syzbot can test patches for this bug, for details see:
> >> https://goo.gl/tpsmEJ#testing-patches
> >>
> > 
> > This is the same bug I already reported here and Jens is working on:
> > https://marc.info/?l=linux-api&m=155115288114046&w=2
> > I'll mark this fixed once the fix is folded in and in linux-next.
> 
> It should already be, I folded in the fix about 24h ago.
> 

Yep, it's fixed in next-20190227.  The fix was folded into
"block: implement bio helper to add iter bvec pages to bio".
Telling syzbot to invalidate this bug report:

#syz invalid

- Eric
