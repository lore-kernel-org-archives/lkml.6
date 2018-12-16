Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F2BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9C72086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbeLPNuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:50:17 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:45114 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbeLPNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:50:17 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990828AbeLPNuOBAVbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:50:14 +0100
Date:   Sun, 16 Dec 2018 13:50:13 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Rich Felker <dalias@libc.org>
cc:     Andy Lutomirski <luto@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: Fixing MIPS delay slot emulation weakness?
In-Reply-To: <20181216023259.GE23599@brightrain.aerifal.cx>
Message-ID: <alpine.LFD.2.21.1812160319120.11202@eddie.linux-mips.org>
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com> <20181215225009.GB23599@brightrain.aerifal.cx> <alpine.LFD.2.21.1812160054300.11202@eddie.linux-mips.org> <20181216023259.GE23599@brightrain.aerifal.cx>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2018, Rich Felker wrote:

> >  I think "trivial" is an understatement, you at least need to decode the 
> > delay-slot instruction enough to tell privileged and user instructions 
> > apart and send SIGILL where appropriate.  Some user instructions send 
> > exceptions too and you need to handle them accordingly.
> 
> I meant simply that making them safe is trivial if they're not
> accessing memory, only modifying the regisster file in the signal
> context. Not that emulating them is trivial.

 OK, fair enough.

> On the other hand it might be cleaner, safer, and easier to simply
> write a full mips ISA emulator, put it in the vdso, and have the
> kernel immediately return-to-userspace on hitting floating point
> instructions and let the emulator code there take care of it all and
> then return to the normal flow of execution.

 The problem is matching hardware being run on and then maintaining that 
stuff.  I'd call that a maintenance nightmare, I'm afraid.  See what pain 
we have to go through already to get FPU emulation right, and there's much 
less variation.

> >  OTOH, for things like ADDIUPC you need to interpret the instruction 
> > anyway, as the value of the PC used for calculation will be wrong except 
> > in the original location.
> 
> Indeed. Assuming arbitrary ISA extensions including stuff that does
> PC-relative arithmetic, there's no way to execute it out-of-place
> without knowing how to interpret it.

 Well, ADDIUPC is a standard microMIPS instruction.  Then R6 has more 
stuff like that in the regular MIPS instruction set, e.g. AUIPC, LWPC.

> >  What about all the odd and especially vendor-specific load/store 
> > instructions like ASET, SAA or SWAPW?  Would we need to have all the 
> > possible encodings provided in the VDSO?
> 
> Can all kinds of weird stuff like this go in delay slots? I'm more
> familiar with SH delay slots where lots of instructions are
> slot-illegal. If so perhaps the full-emulator-in-userspace approach is
> better.

 I've double-checked and ASET is actually not allowed in a delay slot, 
because it uses multiple bus cycles for data access.  This is also why 
LWP, LWM, etc. are not allowed either.  Also control transfer instructions 
are not allowed (unlike with SPARC), such as branches, ERET or YIELD (not 
that the two latter instructions matter for us).  Most of stuff is allowed 
in delay slots though.

 It doesn't help that information about that is scattered across many 
documents.  You can check for the NODS flag in the opcodes library from 
binutils though, which is almost 100% accurate, except for the SYNC 
instructions, for semantic reasons (i.e. they are allowed, but we don't 
want GAS to reorder them).  Most of the disallowed stuff is in the 
microMIPS instruction set, due to encodings that execute as hardware 
macros.

  Maciej
