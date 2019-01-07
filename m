Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51B0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70392087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfAGLUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:20:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56968 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfAGLUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:20:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A4301596;
        Mon,  7 Jan 2019 03:20:01 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D4193F5A0;
        Mon,  7 Jan 2019 03:19:59 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:19:54 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
Message-ID: <20190107111954.GA11732@lakrids.cambridge.arm.com>
References: <20190104141053.360F768D93@newverein.lst.de>
 <20190104175017.GA7157@lakrids.cambridge.arm.com>
 <20190104130648.02657f3f@gandalf.local.home>
 <20190104224145.GA28236@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104224145.GA28236@lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 11:41:45PM +0100, Torsten Duwe wrote:
> On Fri, Jan 04, 2019 at 01:06:48PM -0500, Steven Rostedt wrote:
> > On Fri, 4 Jan 2019 17:50:18 +0000
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > At Linux Plumbers, I had a conversation with Steve Rostedt, and we came
> > > to the conclusion that (withut heavyweight synchronization) patching two
> > > NOPs at runtime isn't safe, since a CPU might have executed the first
> > > NOP as a NOP before another CPU patches both instructions. So a CPU
> > > might execute:
> > > 
> > > 	NOP
> > > 	BL	ftrace_regs_caller
> > > 
> > > ... rather than the expected:
> > > 
> > > 	MOV	X9, X30
> > > 	BL	ftrace_regs_caller
> > > 
> > > ... and therefore X9 contains some UNKNOWN value, rather than the
> > > original LR value.
> 
> I'm perfectly aware of that; an earlier version had barriers, attempting
> to avoid just that, which Mark(?) wrote weren't neccessary.

The problem was that even with barriers, the only guarantee you get is
that instructions are made visible in order, not what the other CPU has
executed.

For example:	

I.e. 

	CPU#1				CPU#2
					NOP#1
	Patches NOP#1 -> INSN#1
	Cache maintenance
	Barrier
	
					// INSN#1 now visible to CPU#2,
					// but NOP#1 was already
					// executed as a NOP.
	
	Patches NOP#2 -> INSN#2
	Cache maintenance
	Barrier
					INSN#2

> But is this a realistic scenario? All function entries are aligned 8 bytes.
> Are there arm64 implementations out there that fetch only 4 bytes and
> give a chance to mess with the 2nd 4 bytes? You at arm.com should know, and
> I won't be surprised if the answer is a weird "yes". Or maybe it's just
> another erratum lurking somewhere...

The alignment of the instructions provides no guarantee here. Regardless
of what contemporary implementations *may* do, the architecture provides
absolutely no guarantee.

For example, even if CPU#2 fetched both NOPs together, the cache
maintenance and barrier may cause it to throw away any speculative work
after executing NOP#1. Upon re-fetching, it could see both new INSNs,
but as it's already executed the first as a NOP, it will not re-execute
it as INSN#1.

Also consider pre-emption by a hypervisor or firmware may occur
mid-sequence.

> My point is: those 2 insn will _never_ be split by any alignment
> boundary > 8; does that mean anything, have you considered this?

This has no impact whatsoever.

> 
> > > I wonder if we could solve that by patching the kernel at build-time, to
> > > add the MOV X9, X30 in place of the first NOP. If we were to do that, we
> > > could also update the addresses to pooint at the second NOP, simplifying
> > > the changes to the runtime code.
> > 
> > You can also patch it at boot up when there's only one CPU running, and
> > interrupts are disabled.
> 
> May I remind about possible performance hits? 

Sure; please get some numbers either way.

> Even the NOPs had a tiny impact
> on certain in-order implementations. I'd rather switch between the mov and
> a "b +2".

Be careful; the architecture only permits live patching between certain
instructions. Please see ARM DDI 0487D.a, section B2.2.5, "Concurrent
modification and execution of instructions".

Per that, it's not safe to live-patch MOV->B or B->MOV.

It's *also* not safe to live-patch NOP->MOV, or vice-versa.

So I strongly suspect we must unconditionally patch the MOV in early.

Thanks,
Mark.
