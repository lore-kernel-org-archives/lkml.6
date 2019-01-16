Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500D4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9DA20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547665370;
	bh=PnQGuKTG6k+2qORYjisCNyXCFKmSC77B9M7O57HffKQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=CuhbShyqdDRpenxCo7DKKMYWO58Y/6olQcjkufMq0aK16q31nUlrjgb//at+KvBpJ
	 +LlN/iG872o9vcgEXSQuoALbNAnsLK0KoOhkdRbb/+expMCRH5F+uJKutuWMKAVFHF
	 yLCWNnGB0jtCS9nrTTcm78HkPQLqmE+Kr7FhjUQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfAPTCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730114AbfAPTCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:02:45 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BFFA2133D;
        Wed, 16 Jan 2019 19:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547665364;
        bh=PnQGuKTG6k+2qORYjisCNyXCFKmSC77B9M7O57HffKQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=yLc+77PLD/nItCq+yv+i/lzuFhqpG+amzqaADZQRPTEe1jZJhN0m08mxQ60AYtN46
         /5z/FxkUVvcKf2/4i8n1xqhbENLL09SKGIl44a+Iuh8c3uSRNiMk95oY8kejSlxsEB
         hzTppY1AAj3LsNOVSiHgT1tt381BLfMCplHbDrlA=
Message-ID: <1547665362.2464.11.camel@kernel.org>
Subject: Re: [PATCH v12 00/16] tracing: Hist trigger snapshot and onchange
 additions
From:   Tom Zanussi <zanussi@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Date:   Wed, 16 Jan 2019 13:02:42 -0600
In-Reply-To: <20190116064327.GB31070@sejong>
References: <cover.1547589128.git.tom.zanussi@linux.intel.com>
         <20190116064327.GB31070@sejong>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Wed, 2019-01-16 at 15:43 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Tue, Jan 15, 2019 at 04:05:44PM -0600, Tom Zanussi wrote:
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Hi,
> > 
> > This is v12 of the hist trigger snapshot and onchange additions
> > patchset.
> > 
> > It addresses some comments from Namhyung regarding the 'tracing:
> > Add
> > alternative synthetic event trace action syntax' patch to remove
> > parens and change the documentation to emphasize the trace() form
> > of
> > the synthetic event generation command.
> 
> I got below from the following test:
> 
>   # echo 'hist:key=comm:p=prio:onchange($p).snapshot()' > \
>     events/sched/sched_waking/trigger
> 
>   # echo 1 > snapshot
> 

Thanks for reporting this.  If there's a snapshot trigger in effect,
attempting to take a snapshot from the command-line should really
return -EBUSY - I'll update the snapshot code to do that.

Tom

> 
> Thanks,
> Namhyung
> 
> 
> 
> [ 2217.403818] BUG: sleeping function called from invalid context at
> arch/x86/mm/fault.c:1369
> [ 2217.406394] in_atomic(): 0, irqs_disabled(): 1, pid: 65, name: sh
> [ 2217.406394] 3 locks held by sh/65:
> [ 2217.406394]  #0: 000000006082fdb2 (sb_writers#5){.+.+}, at:
> vfs_write+0x109/0x130
> [ 2217.406394]  #1: 000000003e4def73 (trace_types_lock){+.+.}, at:
> tracing_snapshot_write+0x93/0x170
> [ 2217.406394]  #2: 0000000050fd4c4a (&mm->mmap_sem){++++}, at:
> __do_page_fault+0x19a/0x4e0
> [ 2217.406394] irq event stamp: 173368
> [ 2217.406394] hardirqs last  enabled at (173367):
> [<ffffffff815369e9>] _raw_spin_unlock_irq+0x29/0x40
> [ 2217.406394] hardirqs last disabled at (173368):
> [<ffffffff811079b2>] tracing_snapshot_write+0xf2/0x170
> [ 2217.406394] softirqs last  enabled at (173258):
> [<ffffffff81800288>] __do_softirq+0x288/0x47c
> [ 2217.406394] softirqs last disabled at (173253):
> [<ffffffff8105a682>] irq_exit+0x62/0xa0
> [ 2217.406394] CPU: 0 PID: 65 Comm: sh Not tainted 4.20.0-rc3+ #259
> [ 2217.406394] Call Trace:
> [ 2217.406394]  dump_stack+0x67/0x90
> [ 2217.406394]  ___might_sleep.cold.5+0x9f/0xb1
> [ 2217.406394]  __do_page_fault+0x1b7/0x4e0
> [ 2217.406394]  page_fault+0x1e/0x30
> [ 2217.406394] RIP: 0010:cond_snapshot_update+0x26/0xa0
> [ 2217.406394] Code: ff ff 66 90 55 48 89 e5 41 55 41 54 53 48 8b 87
> c8 16 00 00 48 8b 18 48 83 e4 f0 48 85 db 74 20 48 8b 43 50 49 89 f4
> 48 8b 3b <48> 8b 36 48 8b 80 e0 00 00 00 e8 1b 43 6e 00 41 89 c5 84
> c0 75 11
> [ 2217.406394] RSP: 0018:ffffc90000163dc0 EFLAGS: 00010082
> [ 2217.406394] RAX: ffff88803dc07000 RBX: ffff88803df7b720 RCX:
> ffff88800008e408
> [ 2217.406394] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000078
> [ 2217.406394] RBP: ffffc90000163de0 R08: 0000000000000000 R09:
> 0000000000000001
> [ 2217.406394] R10: ffffc90000163e18 R11: 0000000000000002 R12:
> 0000000000000000
> [ 2217.406394] R13: 0000000000000000 R14: ffffc90000163f08 R15:
> 0000000000000000
> [ 2217.406394]  update_max_tr+0x82/0xe0
> [ 2217.406394]  tracing_snapshot_write+0x15c/0x170
> [ 2217.406394]  __vfs_write+0x36/0x180
> [ 2217.406394]  ? rcu_read_lock_sched_held+0x76/0x80
> [ 2217.406394]  ? rcu_sync_lockdep_assert+0x2e/0x60
> [ 2217.406394]  ? __sb_start_write+0x14c/0x1b0
> [ 2217.406394]  ? vfs_write+0x109/0x130
> [ 2217.406394]  vfs_write+0xb7/0x130
> [ 2217.406394]  ksys_write+0x52/0xc0
> [ 2217.406394]  do_syscall_64+0x50/0x180
> [ 2217.406394]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 2217.406394] RIP: 0033:0x7f9bc3170818
> [ 2217.406394] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00
> 00 00 f3 0f 1e fa 48 8d 05 25 6d 0d 00 8b 00 85 c0 75 17 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49
> 89 d4 55
> [ 2217.406394] RSP: 002b:00007ffdef643888 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [ 2217.406394] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
> 00007f9bc3170818
> [ 2217.406394] RDX: 0000000000000002 RSI: 00005651d6bf0db0 RDI:
> 0000000000000001
> [ 2217.406394] RBP: 00005651d6bf0db0 R08: 000000000000000a R09:
> 00007ffdef643410
> [ 2217.406394] R10: 000000000000000a R11: 0000000000000246 R12:
> 00007f9bc32435c0
> [ 2217.406394] R13: 0000000000000002 R14: 00007f9bc323e5c0 R15:
> 0000000000000002
> 
> [ 2217.406394] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000000
> [ 2217.406394] PGD 0 P4D 0 
> [ 2217.406394] Oops: 0000 [#1] SMP PTI
> [ 2217.406394] CPU: 0 PID: 65 Comm: sh Tainted:
> G        W         4.20.0-rc3+ #259
> [ 2217.406394] RIP: 0010:cond_snapshot_update+0x26/0xa0
> [ 2217.406394] Code: ff ff 66 90 55 48 89 e5 41 55 41 54 53 48 8b 87
> c8 16 00 00 48 8b 18 48 83 e4 f0 48 85 db 74 20 48 8b 43 50 49 89 f4
> 48 8b 3b <48> 8b 36 48 8b 80 e0 00 00 00 e8 1b 43 6e 00 41 89 c5 84
> c0 75 11
> [ 2217.406394] RSP: 0018:ffffc90000163dc0 EFLAGS: 00010082
> [ 2217.406394] RAX: ffff88803dc07000 RBX: ffff88803df7b720 RCX:
> ffff88800008e408
> [ 2217.406394] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000078
> [ 2217.406394] RBP: ffffc90000163de0 R08: 0000000000000000 R09:
> 0000000000000001
> [ 2217.406394] R10: ffffc90000163e18 R11: 0000000000000002 R12:
> 0000000000000000
> [ 2217.406394] R13: 0000000000000000 R14: ffffc90000163f08 R15:
> 0000000000000000
> [ 2217.406394] FS:  00007f9bc3013b80(0000) GS:ffff88803e400000(0000)
> knlGS:0000000000000000
> [ 2217.406394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2217.406394] CR2: 0000000000000000 CR3: 000000003d138001 CR4:
> 0000000000060eb0
> [ 2217.406394] Call Trace:
> [ 2217.406394]  update_max_tr+0x82/0xe0
> [ 2217.406394]  tracing_snapshot_write+0x15c/0x170
> [ 2217.406394]  __vfs_write+0x36/0x180
> [ 2217.406394]  ? rcu_read_lock_sched_held+0x76/0x80
> [ 2217.406394]  ? rcu_sync_lockdep_assert+0x2e/0x60
> [ 2217.406394]  ? __sb_start_write+0x14c/0x1b0
> [ 2217.406394]  ? vfs_write+0x109/0x130
> [ 2217.406394]  vfs_write+0xb7/0x130
> [ 2217.406394]  ksys_write+0x52/0xc0
> [ 2217.406394]  do_syscall_64+0x50/0x180
> [ 2217.406394]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 2217.406394] RIP: 0033:0x7f9bc3170818
> [ 2217.406394] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00
> 00 00 f3 0f 1e fa 48 8d 05 25 6d 0d 00 8b 00 85 c0 75 17 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49
> 89 d4 55
> [ 2217.406394] RSP: 002b:00007ffdef643888 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [ 2217.406394] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
> 00007f9bc3170818
> [ 2217.406394] RDX: 0000000000000002 RSI: 00005651d6bf0db0 RDI:
> 0000000000000001
> [ 2217.406394] RBP: 00005651d6bf0db0 R08: 000000000000000a R09:
> 00007ffdef643410
> [ 2217.406394] R10: 000000000000000a R11: 0000000000000246 R12:
> 00007f9bc32435c0
> [ 2217.406394] R13: 0000000000000002 R14: 00007f9bc323e5c0 R15:
> 0000000000000002
> [ 2217.406394] Modules linked in:
> [ 2217.406394] CR2: 0000000000000000
> [ 2217.406394] ---[ end trace 832915071760c624 ]---
> [ 2217.406394] RIP: 0010:cond_snapshot_update+0x26/0xa0
> [ 2217.406394] Code: ff ff 66 90 55 48 89 e5 41 55 41 54 53 48 8b 87
> c8 16 00 00 48 8b 18 48 83 e4 f0 48 85 db 74 20 48 8b 43 50 49 89 f4
> 48 8b 3b <48> 8b 36 48 8b 80 e0 00 00 00 e8 1b 43 6e 00 41 89 c5 84
> c0 75 11
> [ 2217.406394] RSP: 0018:ffffc90000163dc0 EFLAGS: 00010082
> [ 2217.406394] RAX: ffff88803dc07000 RBX: ffff88803df7b720 RCX:
> ffff88800008e408
> [ 2217.406394] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000078
> [ 2217.406394] RBP: ffffc90000163de0 R08: 0000000000000000 R09:
> 0000000000000001
> [ 2217.406394] R10: ffffc90000163e18 R11: 0000000000000002 R12:
> 0000000000000000
> [ 2217.406394] R13: 0000000000000000 R14: ffffc90000163f08 R15:
> 0000000000000000
> [ 2217.406394] FS:  00007f9bc3013b80(0000) GS:ffff88803e400000(0000)
> knlGS:0000000000000000
> [ 2217.406394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2217.406394] CR2: 0000000000000000 CR3: 000000003d138001 CR4:
> 0000000000060eb0
