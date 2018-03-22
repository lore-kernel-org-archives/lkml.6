Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeCVPz4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:55:56 -0400
Received: from foss.arm.com ([217.140.101.70]:39496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751669AbeCVPzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:55:52 -0400
From: Punit Agrawal <punit.agrawal@arm.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 07/22] x86/mm: Mask out KeyID bits from page table entry pfn
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
        <20180305162610.37510-8-kirill.shutemov@linux.intel.com>
Date: Thu, 22 Mar 2018 15:55:50 +0000
In-Reply-To: <20180305162610.37510-8-kirill.shutemov@linux.intel.com> (Kirill
        A. Shutemov's message of "Mon, 5 Mar 2018 19:25:55 +0300")
Message-ID: <87woy414vt.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

A flyby comment below.

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:

> MKTME claims several upper bits of the physical address in a page table
> entry to encode KeyID. It effectively shrinks number of bits for
> physical address. We should exclude KeyID bits from physical addresses.
>
> For instance, if CPU enumerates 52 physical address bits and number of
> bits claimed for KeyID is 6, bits 51:46 must not be threated as part
> physical address.
>
> This patch adjusts __PHYSICAL_MASK during MKTME enumeration.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index c770689490b5..35436bbadd0b 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -580,6 +580,30 @@ static void detect_tme(struct cpuinfo_x86 *c)
>  		mktme_status = MKTME_ENABLED;
>  	}
>  
> +#ifdef CONFIG_X86_INTEL_MKTME
> +	if (mktme_status == MKTME_ENABLED && nr_keyids) {
> +		/*
> +		 * Mask out bits claimed from KeyID from physical address mask.
> +		 *
> +		 * For instance, if a CPU enumerates 52 physical address bits
> +		 * and number of bits claimed for KeyID is 6, bits 51:46 of
> +		 * physical address is unusable.
> +		 */
> +		phys_addr_t keyid_mask;
> +
> +		keyid_mask = 1ULL << c->x86_phys_bits;
> +		keyid_mask -= 1ULL << (c->x86_phys_bits - keyid_bits);
> +		physical_mask &= ~keyid_mask;

You could use GENMASK_ULL() to construct the keyid_mask instead of
rolling your own here.

Thanks,
Punit


> +	} else {
> +		/*
> +		 * Reset __PHYSICAL_MASK.
> +		 * Maybe needed if there's inconsistent configuation
> +		 * between CPUs.
> +		 */
> +		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> +	}
> +#endif
> +
>  	/*
>  	 * Exclude KeyID bits from physical address bits.
>  	 *
