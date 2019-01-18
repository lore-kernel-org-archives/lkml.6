Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63479C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37ACA2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfARVOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:14:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50444 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbfARVOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:14:09 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gkbSj-0007sA-W2; Fri, 18 Jan 2019 22:14:02 +0100
Date:   Fri, 18 Jan 2019 22:14:01 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 05/22] x86/fpu: Remove fpu->initialized usage in
 copy_fpstate_to_sigframe()
Message-ID: <20190118211401.4komqsnvuof7563p@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-6-bigeasy@linutronix.de>
 <20190116193603.GK15409@zn.tnic>
 <20190116224037.xkfnevzkwrck5dtt@linutronix.de>
 <20190117122253.GC5023@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117122253.GC5023@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tl;dr
The kernel saves task's FPU registers on user's signal stack before
entering the signal handler. Can we avoid that and have in-kernel memory
for that? Does someone rely on the FPU registers from the task in the
signal handler?

On 2019-01-17 13:22:53 [+0100], Borislav Petkov wrote:
> > The task is running and using FPU registers. Then an evil mind sends a
> > signal. The task goes into kernel, prepares itself and is about to
> > handle the signal in userland. It saves its FPU registers on the stack
> > frame. It zeros its current FPU registers (ready for a fresh start),
> > loads the address of the signal handler and returns to user land
> > handling the signal.
> > 
> > Now. The signal handler may use FPU registers and the signal handler
> > maybe be preempted so you need to save the FPU registers of the signal
> > handler and you can't mix them up with the FPU register's of the task
> > (before it started handling the signal).
> > 
> > So in order to avoid a second FPU struct it saves them on user's stack
> > frame. I *think* this (avoiding a second FPU struct) is the primary
> > motivation.
> 
> Yah, makes sense. Sounds like something we'd do :-)
> 
> > A bonus point might be that the signal handler has a third
> > argument the `context'. That means you can use can access the task's FPU
> > registers from the signal handler. Not sure *why* you want to do so but
> > yo can.
> 
> For <raisins>.
> 
> > I can't imagine a use case and I was looking for a user and expecting it
> > to be glibc but I didn't find anything in the glibc that would explain
> > it. Intel even defines a few bytes as "user reserved" which are used by
> > "struct _fpx_sw_bytes" to add a marker in the signal and recognise it on
> > restore.
> > The only user that seems to make use of that is `criu' (or it looked
> > like it does use it). I would prefer to add a second struct-FPU and use
> > that for the signal handler. This would avoid the whole dance here.
> 
> That would be interesting from the perspective of making the code
> straight-forward and not having to document all that dance somewhere.
> 
> > And `criu' could maybe become a proper interface. I don't think as of
> > now that it will break something in userland if the signal handler
> > suddenly does not have a pointer to the FPU struct.
> 
> Well, but allocating a special FPU pointer for the signal handler
> context sounds simple and clean, no? Or are we afraid that that would
> slowdown signal handling, the whole allocation and assignment and
> stuff...?

So I *think* we could allocate a second struct fpu for the signal
handler at task creation time and use it.
It should not slow-down signal handling. So instead saving it to user's
stack we would save it to "our" memory. On the restore path we could
trust our buffer and simply load it again.

Sebastian
