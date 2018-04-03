Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755278AbeDCKhC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:37:02 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36007 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754915AbeDCKg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:36:59 -0400
X-Google-Smtp-Source: AIpwx49r5qJJefzgiO6P0CSqXQ2bEHVgzeHIe08+/pjAV/4vXLL8WnyQm/KkOvBzFqvObjgJKxadnA==
Date: Tue, 3 Apr 2018 12:36:55 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        David Laight <David.Laight@ACULAB.COM>,
        "'Rahul Lakkireddy'" <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Fenghua Yu <fenghua.yu@intel.com>, Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Message-ID: <20180403103655.oa235p3h65twf4ct@gmail.com>
References: <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
 <alpine.DEB.2.21.1803200933320.6506@nanos.tec.linutronix.de>
 <20180320090802.qw4tqjmhy6yfd6sf@gmail.com>
 <alpine.DEB.2.21.1803201039460.6506@nanos.tec.linutronix.de>
 <20180320105427.bm4od7cpessbraag@gmail.com>
 <20180403084932.GA3926@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403084932.GA3926@amd>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> > > > Yeah, so generic memcpy() replacement is only feasible I think if the most 
> > > > optimistic implementation is actually correct:
> > > > 
> > > >  - if no preempt disable()/enable() is required
> > > > 
> > > >  - if direct access to the AVX[2] registers does not disturb legacy FPU state in 
> > > >    any fashion
> > > > 
> > > >  - if direct access to the AVX[2] registers cannot raise weird exceptions or have
> > > >    weird behavior if the FPU control word is modified to non-standard values by 
> > > >    untrusted user-space
> > > > 
> > > > If we have to touch the FPU tag or control words then it's probably only good for 
> > > > a specialized API.
> > > 
> > > I did not mean to have a general memcpy replacement. Rather something like
> > > magic_memcpy() which falls back to memcpy when AVX is not usable or the
> > > length does not justify the AVX stuff at all.
> > 
> > OK, fair enough.
> > 
> > Note that a generic version might still be worth trying out, if and only if it's 
> > safe to access those vector registers directly: modern x86 CPUs will do their 
> > non-constant memcpy()s via the common memcpy_erms() function - which could in 
> > theory be an easy common point to be (cpufeatures-) patched to an AVX2 variant, if 
> > size (and alignment, perhaps) is a multiple of 32 bytes or so.
> 
> How is AVX2 supposed to help the memcpy speed?
> 
> If the copy is small, constant overhead will dominate, and I don't
> think AVX2 is going to be win there.

There are several advantages:

1)

"REP; MOVS" (also called ERMS) has a significant constant "setup cost".

In the scheme I suggested (and if it's possible) then single-register AVX2 access 
on the other hand has a setup cost on the "few cycles" order of magnitude.

2)

AVX2 have various non-temporary load and store behavioral variants - while "REP; 
MOVS" doesn't (or rather, any such caching optimizations, to the extent they 
exist, are hidden in the microcode).

> If the copy is big, well, the copy loop will likely run out of L1 and maybe even 
> out of L2, and at that point speed of the loop does not matter because memory is 
> slow...?

In many cases "memory" will be something very fast, such as another level of 
cache. Also, on NUMA "memory" can also be something locally wired to the CPU - 
again accessible at ridiculous bandwidths.

Nevertheless ERMS is probably wins for the regular bulk memcpy by a few percentage 
points, so I don't think AVX2 is a win in the generic large-memcpy case, as long 
as continued caching of both the loads and the stores is beneficial.

Thanks,

	Ingo
