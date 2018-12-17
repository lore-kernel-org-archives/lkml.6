Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55521C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AF3206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbeLQA7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 19:59:23 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:59172 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLQA7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 19:59:22 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gYhFb-0006Mq-00; Mon, 17 Dec 2018 00:59:15 +0000
Date:   Sun, 16 Dec 2018 19:59:15 -0500
From:   Rich Felker <dalias@libc.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: Fixing MIPS delay slot emulation weakness?
Message-ID: <20181217005915.GH23599@brightrain.aerifal.cx>
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
 <20181215225009.GB23599@brightrain.aerifal.cx>
 <alpine.LFD.2.21.1812160054300.11202@eddie.linux-mips.org>
 <20181216023259.GE23599@brightrain.aerifal.cx>
 <alpine.LFD.2.21.1812160319120.11202@eddie.linux-mips.org>
 <20181216181336.GG23599@brightrain.aerifal.cx>
 <CALCETrXBfQ-EnOD3OjQh_BaiFyvULtmrMHoX0nv+=yrp6uHzgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXBfQ-EnOD3OjQh_BaiFyvULtmrMHoX0nv+=yrp6uHzgQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 10:59:19AM -0800, Andy Lutomirski wrote:
> On Sun, Dec 16, 2018 at 10:13 AM Rich Felker <dalias@libc.org> wrote:
> >
> > On Sun, Dec 16, 2018 at 01:50:13PM +0000, Maciej W. Rozycki wrote:
> > > On Sat, 15 Dec 2018, Rich Felker wrote:
> > >
> > >
> > >  It doesn't help that information about that is scattered across many
> > > documents.  You can check for the NODS flag in the opcodes library from
> > > binutils though, which is almost 100% accurate, except for the SYNC
> > > instructions, for semantic reasons (i.e. they are allowed, but we don't
> > > want GAS to reorder them).  Most of the disallowed stuff is in the
> > > microMIPS instruction set, due to encodings that execute as hardware
> > > macros.
> >
> > I think it suffices to emulate what compilers generate in delay slots,
> > which should be fairly minimal and stable. At the very least we could
> > enumerate everything GCC and LLVM already emit there, and get them to
> > upstream a policy of not adding new insns as fpu-delay-slot-allowed.
> > If someone is writing asm by hand to do ridiculous things in the delay
> > slot with random ISA extensions, they shouldn't expect it to work.
> 
> I feel like I have to ask: the real thing preventing emulation is that
> new nonstandard instructions might get used in FPU delay slots on
> non-FPU-supporting hardware?  This seems utterly nuts.  If you're
> using custom ISA extensions, why on Earth are you also using emulated
> floating point instructions?  You're targetting a specific known CPU
> if you do this, so you should use only instructions that actually work
> on that CPU.

Floating point is in the standard ABI, despite some models not having
fpu. This is what mandates floating point emulation. The reason you
have to be able to emulate or execute-out-of-line other instructions
is that there are floating point branch instructions bc1f and bc1t
(maybe others too?) with a delay slot, and if the branch is being
taken, you need some mechanism to cause the instruction in the delay
slot to still get executed. (If the branch is not taken you can just
increment PC and let it happen as a non-delay-slot.)

So in theory it's possible that there's a cpu model with fancy new
core instructions but no fpu. In this case, you would need the
capability to emulate or execute-out-of-line these instructions. But I
have no idea if such cpu models actually exist. If not, the concern
can probably be ignored and it suffices to emulate just the parts of
the base ISA that are valid in delay slots.

Rich
