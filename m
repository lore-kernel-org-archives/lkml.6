Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933318AbeBVQdg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:33:36 -0500
Received: from foss.arm.com ([217.140.101.70]:44636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933213AbeBVQde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:33:34 -0500
Date: Thu, 22 Feb 2018 16:33:30 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Shanker Donthineni <shankerd@codeaurora.org>,
        Philip Elcan <pelcan@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
Message-ID: <20180222163330.o5lqant4fjenapcz@lakrids.cambridge.arm.com>
References: <1519311090-19998-1-git-send-email-shankerd@codeaurora.org>
 <20180222152244.zozx2tlptgnnfu6b@lakrids.cambridge.arm.com>
 <32c8cfd3-2883-177b-7736-1bb6ab679df4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32c8cfd3-2883-177b-7736-1bb6ab679df4@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 04:28:03PM +0000, Robin Murphy wrote:
> [Apologies to keep elbowing in, and if I'm being thick here...]
> 
> On 22/02/18 15:22, Mark Rutland wrote:
> > On Thu, Feb 22, 2018 at 08:51:30AM -0600, Shanker Donthineni wrote:
> > > +#define CTR_B31_SHIFT		31
> > 
> > Since this is just a RES1 bit, I think we don't need a mnemonic for it,
> > but I'll defer to Will and Catalin on that.
> > 
> > >   ENTRY(invalidate_icache_range)
> > > +#ifdef CONFIG_ARM64_SKIP_CACHE_POU
> > > +alternative_if ARM64_HAS_CACHE_DIC
> > > +	mov	x0, xzr
> > > +	dsb	ishst
> > > +	isb
> > > +	ret
> > > +alternative_else_nop_endif
> > > +#endif
> > 
> > As commented on v3, I don't believe you need the DSB here. If prior
> > stores haven't been completed at this point, the existing implementation
> > would not work correctly here.
> 
> True in terms of ordering between stores prior to entry and the IC IVAU
> itself, but what about the DSH ISH currently issued *after* the IC IVAU
> before returning? Is provably impossible that existing callers might be
> relying on that ordering *anything*, or would we risk losing something
> subtle by effectively removing it?

AFAIK, the only caller of this is KVM, before page table updates occur
to add execute permissions to the page this is applied to.

At least in that case, I do not beleive there would be breakage.

If we're worried about subtleties in callers, then we'd need to stick
with DSB ISH rather than optimising to DSH ISHST.

Thanks,
Mark.
