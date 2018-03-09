Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932082AbeCINop (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 08:44:45 -0500
Received: from foss.arm.com ([217.140.101.70]:51890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeCINoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 08:44:44 -0500
Date: Fri, 9 Mar 2018 13:44:40 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Philip Elcan <pelcan@codeaurora.org>
Subject: Re: [PATCH v7] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
Message-ID: <20180309134439.76b43chxnrw7okrw@lakrids.cambridge.arm.com>
References: <1520434808-29703-1-git-send-email-shankerd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520434808-29703-1-git-send-email-shankerd@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 09:00:08AM -0600, Shanker Donthineni wrote:
>  static inline void __flush_icache_all(void)
>  {
> -	asm("ic	ialluis");
> -	dsb(ish);
> +	/* Instruction cache invalidation is not required for I/D coherence? */
> +	if (!cpus_have_const_cap(ARM64_HAS_CACHE_DIC)) {
> +		asm("ic	ialluis");
> +		dsb(ish);
> +	}
>  }

I don't think we need the comment here. We don't have this in the other
cases we look at the ARM64_HAS_CACHE_{IDC,DIC} caps.

This would also be slightly nicer as an early return:

static inline void __flush_icache_all(void)
{
	if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
		return;
	
	asm("ic ialluis");
	dsb(ish);
}

... which minimizes indentation, and the diffstat.

The rest looks fine to me, so with the above changes:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
