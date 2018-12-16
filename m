Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C260C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 02:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3E9206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 02:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeLPCdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 21:33:07 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:59130 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbeLPCdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 21:33:06 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gYMEl-0002cY-00; Sun, 16 Dec 2018 02:32:59 +0000
Date:   Sat, 15 Dec 2018 21:32:59 -0500
From:   Rich Felker <dalias@libc.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: Fixing MIPS delay slot emulation weakness?
Message-ID: <20181216023259.GE23599@brightrain.aerifal.cx>
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
 <20181215225009.GB23599@brightrain.aerifal.cx>
 <alpine.LFD.2.21.1812160054300.11202@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1812160054300.11202@eddie.linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 02:15:38AM +0000, Maciej W. Rozycki wrote:
> On Sat, 15 Dec 2018, Rich Felker wrote:
> 
> > > A possibly nicer way to accomplish more or less the same thing would
> > > be to allocate the area with _install_special_mapping() and arrange to
> > > keep a reference to the struct page around.
> > > 
> > > The really nice but less compatible fix would be to let processes or
> > > even the whole system opt out by promising not to put anything in FPU
> > > branch delay slots, of course.
> > 
> > As I noted on Twitter when Mudge brought this topic back up, there's a
> > much more compatible, elegant, and safe fix possible that does not
> > involve any W+X memory. Emulate the delay slot in kernel-space. This
> > is trivial to do safely for pretty much everything but loads/stores.
> 
>  I think "trivial" is an understatement, you at least need to decode the 
> delay-slot instruction enough to tell privileged and user instructions 
> apart and send SIGILL where appropriate.  Some user instructions send 
> exceptions too and you need to handle them accordingly.

I meant simply that making them safe is trivial if they're not
accessing memory, only modifying the regisster file in the signal
context. Not that emulating them is trivial.

On the other hand it might be cleaner, safer, and easier to simply
write a full mips ISA emulator, put it in the vdso, and have the
kernel immediately return-to-userspace on hitting floating point
instructions and let the emulator code there take care of it all and
then return to the normal flow of execution.

>  OTOH, for things like ADDIUPC you need to interpret the instruction 
> anyway, as the value of the PC used for calculation will be wrong except 
> in the original location.

Indeed. Assuming arbitrary ISA extensions including stuff that does
PC-relative arithmetic, there's no way to execute it out-of-place
without knowing how to interpret it.

> > For loads/stores, where you want them to execute with user privilege
> > level, what you do is compute the effective address in kernel-space,
> > then return to a fixed instruction in the vdso page that performs a
> > generic load/store using the register the kernel put the effective
> > address result in, then restores registers off the stack and jumps to
> > the branch destination.
> 
>  What about all the odd and especially vendor-specific load/store 
> instructions like ASET, SAA or SWAPW?  Would we need to have all the 
> possible encodings provided in the VDSO?

Can all kinds of weird stuff like this go in delay slots? I'm more
familiar with SH delay slots where lots of instructions are
slot-illegal. If so perhaps the full-emulator-in-userspace approach is
better.

Rich
