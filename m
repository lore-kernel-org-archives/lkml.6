Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B97C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E27204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E27204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeJ3CDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:03:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52404 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbeJ3CDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:03:10 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHB6e-0007e1-Pv; Mon, 29 Oct 2018 18:13:37 +0100
Date:   Mon, 29 Oct 2018 18:13:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH V2 1/2] x86/efi: Unmap EFI boot services code/data regions
 from efi_pgd
In-Reply-To: <20181026213845.28166-2-sai.praneeth.prakhya@intel.com>
Message-ID: <alpine.DEB.2.21.1810291809490.5984@nanos.tec.linutronix.de>
References: <20181026213845.28166-1-sai.praneeth.prakhya@intel.com> <20181026213845.28166-2-sai.praneeth.prakhya@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sai,

On Fri, 26 Oct 2018, Sai Praneeth Prakhya wrote:
>  
> +int kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
> +			      unsigned long numpages)
> +{
> +	int retval;
> +
> +	/*
> +	 * The typical sequence for unmapping is to find a pte through
> +	 * lookup_address_in_pgd() (ideally, it should never return NULL because
> +	 * the address is already mapped) and change it's protections.
> +	 * As pfn is the *target* of a mapping, it's not useful while unmapping.
> +	 */
> +	struct cpa_data cpa = {
> +		.vaddr		= &address,
> +		.pgd		= pgd,
> +		.numpages	= numpages,
> +		.mask_set	= __pgprot(0),
> +		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
> +		.flags		= 0,
> +	};
> +
> +	retval = __change_page_attr_set_clr(&cpa, 0);
> +	__flush_tlb_all();

So this looks like you copied it from kernel_map_pages_in_pgd() which has
been discussed before to be not sufficient, but it can't be changed right
now due to locking issues.

For this particular use case, this should not be an issue at all, so please
use the proper cpa_flush_*() variant.

> +
> +	return retval;
> +}
> +
>  /*
>   * The testcases use internal knowledge of the implementation that shouldn't
>   * be exposed to the rest of the kernel. Include these directly here.
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 669babcaf245..fb1c44b11235 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c

While you are at it, can you please split the EFI part out into a separate
patch?

Thanks,

	tglx
