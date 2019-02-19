Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5D1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F252146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfBSMrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:47:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44826 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfBSMrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:47:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 566D9EBD;
        Tue, 19 Feb 2019 04:47:20 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 887213F720;
        Tue, 19 Feb 2019 04:47:18 -0800 (PST)
Date:   Tue, 19 Feb 2019 12:47:16 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com, riel@surriel.com
Subject: Re: [PATCH v6 05/18] asm-generic/tlb: Provide generic tlb_flush()
 based on flush_tlb_mm()
Message-ID: <20190219124716.GB8501@fuggles.cambridge.arm.com>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.148854086@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219103233.148854086@infradead.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:31:53AM +0100, Peter Zijlstra wrote:
> When an architecture does not have (an efficient) flush_tlb_range(),
> but instead always uses full TLB invalidates, the current generic
> tlb_flush() is sub-optimal, for it will generate extra flushes in
> order to keep the range small.
> 
> But if we cannot do range flushes, that is a moot concern. Optionally
> provide this simplified default.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/asm-generic/tlb.h |   41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -114,7 +114,8 @@
>   *    returns the smallest TLB entry size unmapped in this range.
>   *
>   * If an architecture does not provide tlb_flush() a default implementation
> - * based on flush_tlb_range() will be used.
> + * based on flush_tlb_range() will be used, unless MMU_GATHER_NO_RANGE is
> + * specified, in which case we'll default to flush_tlb_mm().
>   *
>   * Additionally there are a few opt-in features:
>   *
> @@ -140,6 +141,9 @@
>   *  the page-table pages. Required if you use HAVE_RCU_TABLE_FREE and your
>   *  architecture uses the Linux page-tables natively.
>   *
> + *  MMU_GATHER_NO_RANGE
> + *
> + *  Use this if your architecture lacks an efficient flush_tlb_range().
>   */
>  #define HAVE_GENERIC_MMU_GATHER
>  
> @@ -302,12 +306,45 @@ static inline void __tlb_reset_range(str
>  	 */
>  }
>  
> +#ifdef CONFIG_MMU_GATHER_NO_RANGE
> +
> +#if defined(tlb_flush) || defined(tlb_start_vma) || defined(tlb_end_vma)
> +#error MMU_GATHER_NO_RANGE relies on default tlb_flush(), tlb_start_vma() and tlb_end_vma()
> +#endif
> +
> +/*
> + * When an architecture does not have efficient means of range flushing TLBs
> + * there is no point in doing intermediate flushes on tlb_end_vma() to keep the
> + * range small. We equally don't have to worry about page granularity or other
> + * things.
> + *
> + * All we need to do is issue a full flush for any !0 range.
> + */
> +static inline void tlb_flush(struct mmu_gather *tlb)
> +{
> +	if (tlb->end)
> +		flush_tlb_mm(tlb->mm);
> +}

I guess another way we could handle these architectures is by
unconditionally resetting tlb->fullmm to 1, but this works too.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
