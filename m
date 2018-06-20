Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BACC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65472208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65472208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeFTI0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:26:37 -0400
Received: from foss.arm.com ([217.140.101.70]:32846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751376AbeFTI0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:26:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CACF115B2;
        Wed, 20 Jun 2018 01:06:57 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DEB03F246;
        Wed, 20 Jun 2018 01:06:54 -0700 (PDT)
Date:   Wed, 20 Jun 2018 09:06:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     mikelley@microsoft.com
Cc:     will.deacon@arm.com, catalin.marinas@arm.com, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
        jasowang@redhat.com, leann.ogasawara@canonical.com,
        marcelo.cerri@canonical.com, sthemmin@microsoft.com,
        kys@microsoft.com
Subject: Re: [PATCH 1/5] arm64: mm: Add slow_virt_to_phys()
Message-ID: <20180620080648.yteuodd3hl7nrh35@salmiak>
References: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
 <1529443395-20874-2-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529443395-20874-2-git-send-email-mikelley@microsoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 19, 2018 at 02:23:11PM -0700, Michael Kelley wrote:
> Add slow_virt_to_phys() function for ARM64 that parallels the same
> function on x86/x64. This is needed by the architecture independent
> Hyper-V VMbus driver at drivers/hv/channel.c.  The implementation
> directly translates the virtual address using the ARM64 'at'
> instruction.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: James Morris <james.morris@microsoft.com>
> ---
>  arch/arm64/include/asm/memory.h |  6 ++++++
>  arch/arm64/mm/pageattr.c        | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 49d9921..3f68dcf 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -265,6 +265,12 @@ static inline void *phys_to_virt(phys_addr_t x)
>  }
>  
>  /*
> + * For memory where the underlying physical pages may not
> + * be contiguous.
> + */
> +extern phys_addr_t slow_virt_to_phys(void *vaddr);
> +
> +/*
>   * Drivers should NOT use these either.
>   */
>  #define __pa(x)			__virt_to_phys((unsigned long)(x))
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index a563593..8a42cac 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -19,6 +19,8 @@
>  #include <asm/pgtable.h>
>  #include <asm/set_memory.h>
>  #include <asm/tlbflush.h>
> +#include <asm/sysreg.h>
> +#include <asm/barrier.h>
>  
>  struct page_change_data {
>  	pgprot_t set_mask;
> @@ -185,3 +187,38 @@ bool kernel_page_present(struct page *page)
>  }
>  #endif /* CONFIG_HIBERNATION */
>  #endif /* CONFIG_DEBUG_PAGEALLOC */
> +
> +/*
> + * For virtual addresses where the underlyine physical memory may not be
> + * contiguous and the normal virt_to_phys gives the wrong result. This
> + * function does an actual translation using the 'at' instruction.
> + */
> +phys_addr_t slow_virt_to_phys(void *virt_addr)
> +{
> +	phys_addr_t	result;
> +	unsigned long	input = (unsigned long)virt_addr;
> +	char		touch;
> +	int		i;
> +
> +	/* Try up to 3 times (an arbitrary number) */
> +	for (i = 0; i < 3; i++) {
> +		/* Do the translation and check that it worked */
> +		asm volatile("at s1e1r, %0" : : "r" (input));
> +		isb();
> +		result = read_sysreg(par_el1);
> +		if (likely(!(result & 0x1)))
> +			return (result & GENMASK_ULL(51, 12)) |
> +				(input & GENMASK_ULL(11, 0));
> +		/*
> +		 * Something failed. Read the page to fault in anything
> +		 * that isn't resident, then try again. "Anything"
> +		 * could include the page itself or hypervisor page tables.
> +		 */
> +		touch = READ_ONCE(*(char *)input);
> +		dmb(sy);
> +	}
> +
> +	/* Let the caller sort it out. */
> +	return  -1;

AFAICT, callers of slow_virt_to_phys() don't check the value, so this doesn't
seem safe, and I'm concerned by the possibility of spurious failures given we
only retry a fixed number of times.

I think it would be better to walk the page tables, as x86 does, as that's
guaranteed to complete within a fixed bound (i.e. after we read all the levls
of table).

Thanks,
Mark.
