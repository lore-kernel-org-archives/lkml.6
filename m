Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50491C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE4921477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xJo5e+UT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE4921477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbeJFFc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeJFFc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:32:56 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA38A20652;
        Fri,  5 Oct 2018 22:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538778728;
        bh=2KGkGjUFC+ui2QvvmjngVRJoERUjMRn1z5RRwNmx2Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xJo5e+UTehiYWbU/mC7Hyga5XWGcIjHPS9uD1SajE1uhH705mxSL84PqIa6bFDo4j
         w4zHKWX3OxHA072MKBL+AipqelDBpRLBfcqUqTI+0b9AELcYygS+p5o6SBPukTRa3x
         AcXDCvuEkB+E640DFsUadcwBPz/2FlxWyaNBbRCg=
Date:   Fri, 5 Oct 2018 15:32:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+87dbe4b17debcec16d71@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        hpa@zytor.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, megha.dey@linux.intel.com,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tim.c.chen@linux.intel.com, x86@kernel.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 sha1_mb_mgr_get_comp_job_avx2
Message-ID: <20181005223206.GA184636@gmail.com>
References: <0000000000002e9bdb0576c70441@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002e9bdb0576c70441@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 07:27:04AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    a38523185b40 erge tag 'libnvdimm-fixes-4.19-rc6' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1767b7fa400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
> dashboard link: https://syzkaller.appspot.com/bug?extid=87dbe4b17debcec16d71
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+87dbe4b17debcec16d71@syzkaller.appspotmail.com
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000034
> PGD 1b8b87067 P4D 1b8b87067 PUD 1b8b88067 PMD 0
> Oops: 0002 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 24 Comm: kworker/1:1 Not tainted 4.19.0-rc5+ #32
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: crypto mcryptd_flusher
> RIP: 0010:sha1_mb_mgr_get_comp_job_avx2+0x62/0xba
> arch/x86/crypto/sha1-mb/sha1_mb_mgr_flush_avx2.S:256
> Code: 04 c4 e2 69 3b d3 c4 c1 79 7e d0 49 f7 c0 f0 ff ff ff 75 6e 49 6b d8
> 08 48 8d 9c 1f 08 01 00 00 48 8b 03 48 c7 03 00 00 00 00 <c7> 40 34 02 00 00
> 00 48 8b 9f 00 01 00 00 48 c1 e3 04 4c 09 c3 48
> kobject: 'loop1' (00000000307f8c2f): kobject_uevent_env
> RSP: 0018:ffff8801d94473c0 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: ffff8801d4818688 RCX: 1ffff1003b2869e1
> RDX: 1ffffd1ffffa2591 RSI: ffffffff81454f3a RDI: ffff8801d4818580
> RBP: ffff8801d9447520 R08: 0000000000000000 R09: 0000000000000006
> kobject: 'loop1' (00000000307f8c2f): fill_kobj_path: path =
> '/devices/virtual/block/loop1'
> R10: 0000000000000000 R11: ffff8801d9434640 R12: ffff8801d94474f8
> R13: 0000000000000001 R14: ffff8801bb509720 R15: 0000000000000200
> FS:  0000000000000000(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kobject: 'loop4' (00000000fa342cfc): kobject_uevent_env
> CR2: 0000000000000034 CR3: 00000001b8b85000 CR4: 00000000001406e0
> kobject: 'loop4' (00000000fa342cfc): fill_kobj_path: path =
> '/devices/virtual/block/loop4'
> Call Trace:
>  sha1_mb_flusher+0x2f4/0x60b arch/x86/crypto/sha1-mb/sha1_mb.c:918
>  mcryptd_flusher+0x3af/0x520 crypto/mcryptd.c:208
>  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
>  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
>  kthread+0x35a/0x420 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
> Modules linked in:
> CR2: 0000000000000034
> ---[ end trace 7d3a48e5625a9543 ]---
> RIP: 0010:sha1_mb_mgr_get_comp_job_avx2+0x62/0xba
> arch/x86/crypto/sha1-mb/sha1_mb_mgr_flush_avx2.S:256
> Code: 04 c4 e2 69 3b d3 c4 c1 79 7e d0 49 f7 c0 f0 ff ff ff 75 6e 49 6b d8
> 08 48 8d 9c 1f 08 01 00 00 48 8b 03 48 c7 03 00 00 00 00 <c7> 40 34 02 00 00
> 00 48 8b 9f 00 01 00 00 48 c1 e3 04 4c 09 c3 48
> RSP: 0018:ffff8801d94473c0 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: ffff8801d4818688 RCX: 1ffff1003b2869e1
> RDX: 1ffffd1ffffa2591 RSI: ffffffff81454f3a RDI: ffff8801d4818580
> RBP: ffff8801d9447520 R08: 0000000000000000 R09: 0000000000000006
> R10: 0000000000000000 R11: ffff8801d9434640 R12: ffff8801d94474f8
> R13: 0000000000000001 R14: ffff8801bb509720 R15: 0000000000000200
> FS:  0000000000000000(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000034 CR3: 00000001b8b85000 CR4: 00000000001406e0
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

The "fix" for this is queued in cryptodev:

#syz fix: crypto: x86 - remove SHA multibuffer routines and mcryptd

- Eric
