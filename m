Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D8AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9572082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbeLPTpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:45:04 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:56600 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbeLPTpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:45:03 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992280AbeLPTpA1mgAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 20:45:00 +0100
Date:   Sun, 16 Dec 2018 19:45:00 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Rich Felker <dalias@libc.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: Fixing MIPS delay slot emulation weakness?
In-Reply-To: <CALCETrXBfQ-EnOD3OjQh_BaiFyvULtmrMHoX0nv+=yrp6uHzgQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1812161911020.11202@eddie.linux-mips.org>
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com> <20181215225009.GB23599@brightrain.aerifal.cx> <alpine.LFD.2.21.1812160054300.11202@eddie.linux-mips.org> <20181216023259.GE23599@brightrain.aerifal.cx>
 <alpine.LFD.2.21.1812160319120.11202@eddie.linux-mips.org> <20181216181336.GG23599@brightrain.aerifal.cx> <CALCETrXBfQ-EnOD3OjQh_BaiFyvULtmrMHoX0nv+=yrp6uHzgQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2018, Andy Lutomirski wrote:

> > I think it suffices to emulate what compilers generate in delay slots,
> > which should be fairly minimal and stable. At the very least we could
> > enumerate everything GCC and LLVM already emit there, and get them to
> > upstream a policy of not adding new insns as fpu-delay-slot-allowed.
> > If someone is writing asm by hand to do ridiculous things in the delay
> > slot with random ISA extensions, they shouldn't expect it to work.
> >
> 
> I feel like I have to ask: the real thing preventing emulation is that
> new nonstandard instructions might get used in FPU delay slots on
> non-FPU-supporting hardware?  This seems utterly nuts.  If you're
> using custom ISA extensions, why on Earth are you also using emulated
> floating point instructions?  You're targetting a specific known CPU
> if you do this, so you should use only instructions that actually work
> on that CPU.

 The FPU is a part of the MIPS/Linux psABI and as far as CPU hardware is 
concerned it is typically an RTL option for the customer to control when 
synthesising hardware, just like say the sizes of the caches.  IOW you'll 
have some hardware with FPU and some without that is otherwise identical, 
and maintaining two sets of binaries for what is a part of the psABI 
anyway is often seen as not technically or commercially justified.

 E.g. the (somewhat dated now) 24KEf and 24KEc are complementing standard
MIPS32r2+DSP processor cores with and without the FPU respectively.  Of 
course you can stick to the soft-float ABI instead, but then you'll be 
wasting the FPU resource on FPU cores, so using the hard-float ABI and 
having instructions emulated on non-FPU cores is usually considered a good 
compromise.

 Of course the FPU emulator should have been left to the userland rather 
than put in the kernel, but that mistake was made many years ago and we 
need to maintain compatibility.  Also someone would actually have to 
implement that userland emulator.

 FAOD both GCC and GAS will happily schedule delay slots themselves as 
long as the candidate instruction is recognised as valid in a delay slot, 
so there's no need for anyone to do anything manually for the less common 
instructions to end up in a delay slot.  They just need to appear right 
before a branch or a jump for that to happen.  I can't speak for LLVM.

  Maciej
