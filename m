Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeBEKSd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:18:33 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54713 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeBEKSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:18:24 -0500
X-Google-Smtp-Source: AH8x225cweHgmrWdMXvFSgjiGgurN1BlsvIC81c4xjGVHSPWmrMjYZvVm+i0wKGiJETYtRDNqsFvdg==
Date: Mon, 5 Feb 2018 11:18:22 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Jones <drjones@redhat.com>, Hanjun Guo <guohanjun@huawei.com>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Jon Masters <jcm@redhat.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 12/18] arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast
 handling
Message-ID: <20180205101822.GA16136@cbox>
References: <20180201114657.7323-1-marc.zyngier@arm.com>
 <20180201114657.7323-13-marc.zyngier@arm.com>
 <20180204183907.GP21802@cbox>
 <1d30fe51-22dd-6938-2f8f-c823858a3bbd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d30fe51-22dd-6938-2f8f-c823858a3bbd@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 09:08:31AM +0000, Marc Zyngier wrote:
> On 04/02/18 18:39, Christoffer Dall wrote:
> > On Thu, Feb 01, 2018 at 11:46:51AM +0000, Marc Zyngier wrote:
> >> We want SMCCC_ARCH_WORKAROUND_1 to be fast. As fast as possible.
> >> So let's intercept it as early as we can by testing for the
> >> function call number as soon as we've identified a HVC call
> >> coming from the guest.
> > 
> > Hmmm.  How often is this expected to happen and what is the expected
> > extra cost of doing the early-exit handling in the C code vs. here?
> 
> Pretty often. On each context switch of a Linux guest, for example. It
> is almost as bad as if we were trapping all VM ops. Moving it to C is
> definitely visible on something like hackbench (I remember something
> like a 10-12% degradation on Seattle, but I'd need to rerun the tests to
> give you something accurate). 

If it's that easily visible (although hackbench is clearly the
pathological case here), then we should try to optimize it.  Let's hope
we don't have to add too many of these workarounds in the future.

> It is the whole GPR save/restore dance
> that costs us a lot (31 registers for the guest, 12 for the host), plus
> some the extra SError synchronization that doesn't come for free either.
> 

Fair enough.

> > I think we'd be better off if we only had a single early-exit path (and
> > we should move the FP/SIMD trap to that path as well), but if there's a
> > measurable benefit of having this logic in assembly as opposed to in the
> > C code, then I'm ok with this as well.
> 
> I agree that the multiplication of "earlier than early" paths is
> becoming annoying. Moving the FP/SIMD stuff to C would be less
> problematic, as we have patches to move some of that to load/put, and
> we'd only take the trap once per time slice (as opposed to once per
> entry at the moment).

Yes, and we can even improve on that (see separate discussions around
KVM support for SVE with Dave).

> 
> Here, we're trying hard to do exactly nothing, because each instruction
> is just an extra overhead (we've already nuked the BP). I even
> considered inserting that code as part of the per-CPU-type vectors (and
> leave the rest of the KVM code alone), but it felt like a step too far.
> 

We can always look at adjusting this more in the future if we want.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
