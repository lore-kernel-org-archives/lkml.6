Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06554C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE270206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbeLQBzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:55:31 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:44646 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeLQBzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 20:55:31 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992280AbeLQBz2KRwHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:55:28 +0100
Date:   Mon, 17 Dec 2018 01:55:28 +0000 (GMT)
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
In-Reply-To: <20181217005915.GH23599@brightrain.aerifal.cx>
Message-ID: <alpine.LFD.2.21.1812170106120.11202@eddie.linux-mips.org>
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com> <20181215225009.GB23599@brightrain.aerifal.cx> <alpine.LFD.2.21.1812160054300.11202@eddie.linux-mips.org> <20181216023259.GE23599@brightrain.aerifal.cx>
 <alpine.LFD.2.21.1812160319120.11202@eddie.linux-mips.org> <20181216181336.GG23599@brightrain.aerifal.cx> <CALCETrXBfQ-EnOD3OjQh_BaiFyvULtmrMHoX0nv+=yrp6uHzgQ@mail.gmail.com> <20181217005915.GH23599@brightrain.aerifal.cx>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2018, Rich Felker wrote:

> So in theory it's possible that there's a cpu model with fancy new
> core instructions but no fpu. In this case, you would need the
> capability to emulate or execute-out-of-line these instructions. But I
> have no idea if such cpu models actually exist. If not, the concern
> can probably be ignored and it suffices to emulate just the parts of
> the base ISA that are valid in delay slots.

 What do you call "a cpu model with fancy new core instructions"?

 We've gone through 4 legacy MIPS base ISA revisions (I to IV) and then 4 
modern ones that matter (R1 to R5; R4 was left out and R6 actually does 
not have FPU branch delay slots), plus a bunch of ASEs (Application 
Specific Extensions), such as DSP, MDMX, MIPS-3D, MSA, etc., each defining 
further instructions.  And then the microMIPS R3 and R5 ISAs (R6 uses a 
different instruction encoding and does not have delay slots at all).  
The MIPS16 ISA does not count however, even though it has delay slots and 
we support it, because it does not have FPU instructions, let alone ones 
that require delay slot emulation.

 Some of the ASEs do not matter, e.g. we don't support MDMX in Linux as it 
has user state we don't handle with context switches, and MIPS-3D and MSA 
both imply an FPU, so software making use of them won't run with our FPU 
emulation anyway as these ASEs' instructions are not emulated.  Anything 
else is potentially required.

 As to actual implementations I believe all the Cavium Octeon line CPUs 
(David, please correct me if I am wrong) have no FPU and they have vendor 
extensions beyond the base ISA + ASE instruction set.  Arguably you could 
say that their additional instructions should not be scheduled into FPU 
branch delay slots then, however the toolchain will happily do that, as I 
wrote before.

 I don't fully remember what the situation is WRT NetLogic/Broadcom XLR 
and XLP chips.  They do have vendor extensions, though IIRC they do have 
an FPU too.

 But then we have the "nofpu" kernel parameter anyway, which forces FPU 
emulation for any hardware, so we need to emulate delay slots in that mode 
with any hardware.

 I'm afraid the problem is complex to solve overall, which is why we still 
have issues, 18 years on from the inclusion of the FPU emulator:

commit 4c55adaa6d06e5533aebaceea7640ecf10952231
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Sat Nov 25 04:49:46 2000 +0000

    Kernel FPU emulator, chain saw edition.

(in the LMO GIT repo) and I think actually running the delay-slot 
instruction (with a possible exception for things like ADDIUPC) rather 
than interpreting it is the only feasible solution.

 I'm not involved with MIPS architecture development anymore though and at 
this point I only care about the few legacy platforms I have been taking 
care of since forever, such as the DECstation port, for which our current 
emulation solution suffices, so I am not going to commit myself to making 
any inventions in this area.  I hope my input is valuable though and will 
help someone working on this.

  Maciej
