Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932072AbeCINr4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 08:47:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51942 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbeCINrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 08:47:55 -0500
Date: Fri, 9 Mar 2018 13:47:59 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Shanker Donthineni <shankerd@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Philip Elcan <pelcan@codeaurora.org>
Subject: Re: [PATCH v7] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
Message-ID: <20180309134759.GB15537@arm.com>
References: <1520434808-29703-1-git-send-email-shankerd@codeaurora.org>
 <20180309134439.76b43chxnrw7okrw@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309134439.76b43chxnrw7okrw@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 01:44:40PM +0000, Mark Rutland wrote:
> On Wed, Mar 07, 2018 at 09:00:08AM -0600, Shanker Donthineni wrote:
> >  static inline void __flush_icache_all(void)
> >  {
> > -	asm("ic	ialluis");
> > -	dsb(ish);
> > +	/* Instruction cache invalidation is not required for I/D coherence? */
> > +	if (!cpus_have_const_cap(ARM64_HAS_CACHE_DIC)) {
> > +		asm("ic	ialluis");
> > +		dsb(ish);
> > +	}
> >  }
> 
> I don't think we need the comment here. We don't have this in the other
> cases we look at the ARM64_HAS_CACHE_{IDC,DIC} caps.
> 
> This would also be slightly nicer as an early return:
> 
> static inline void __flush_icache_all(void)
> {
> 	if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
> 		return;
> 	
> 	asm("ic ialluis");
> 	dsb(ish);
> }
> 
> ... which minimizes indentation, and the diffstat.
> 
> The rest looks fine to me, so with the above changes:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

I've already queued this, but not pushed out yet so I'll fold these changes
in.

Will
