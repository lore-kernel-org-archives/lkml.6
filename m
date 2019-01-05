Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4E5C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 11:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6758B2087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 11:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfAELF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 06:05:58 -0500
Received: from verein.lst.de ([213.95.11.211]:44352 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfAELF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 06:05:58 -0500
Received: by newverein.lst.de (Postfix, from userid 107)
        id 3D8F268DD6; Sat,  5 Jan 2019 12:05:56 +0100 (CET)
Received: from lst.de (p5B33FA9D.dip0.t-ipconnect.de [91.51.250.157])
        by newverein.lst.de (Postfix) with ESMTPSA id 2DDF367329;
        Sat,  5 Jan 2019 12:05:50 +0100 (CET)
Date:   Sat, 5 Jan 2019 12:05:43 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20190105110543.GA4298@lst.de>
References: <20190104141053.360F768D93@newverein.lst.de>
 <20190104175017.GA7157@lakrids.cambridge.arm.com>
 <20190104130648.02657f3f@gandalf.local.home>
 <20190104224145.GA28236@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104224145.GA28236@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> 
> But is this a realistic scenario? All function entries are aligned 8 bytes.
> Are there arm64 implementations out there that fetch only 4 bytes and
> give a chance to mess with the 2nd 4 bytes? You at arm.com should know, and
> I won't be surprised if the answer is a weird "yes". Or maybe it's just
> another erratum lurking somewhere...
> 
> My point is: those 2 insn will _never_ be split by any alignment
> boundary > 8; does that mean anything, have you considered this?

Forget that. Steve mentioned the keyword *interrupt*, which creates a
completely different situation. In short, only the instruction pointer
will be saved; and i-cache and pipeline will be freshly reloaded on return,
so this threat is highly unlikely (interrupt taken exactly after 1st nop),
but not impossible. "Puking horses..." as we say in German.

> > > I wonder if we could solve that by patching the kernel at build-time, to
> > > add the MOV X9, X30 in place of the first NOP. If we were to do that, we
> > > could also update the addresses to pooint at the second NOP, simplifying
> > > the changes to the runtime code.
> > 
> > You can also patch it at boot up when there's only one CPU running, and
> > interrupts are disabled.
> 
> May I remind about possible performance hits? Even the NOPs had a tiny impact
> on certain in-order implementations. I'd rather switch between the mov and
> a "b +2".

This one however still holds.

	Torsten

