Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B255EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AF7215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AF7215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeI0Scc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:32:32 -0400
Received: from foss.arm.com ([217.140.101.70]:33804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbeI0Scc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:32:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2C2018A;
        Thu, 27 Sep 2018 05:14:31 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 793B63F5B3;
        Thu, 27 Sep 2018 05:14:29 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:14:26 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com, riel@surriel.com
Subject: Re: [PATCH 05/18] asm-generic/tlb: Provide generic tlb_flush
Message-ID: <20180927121425.GC5028@brain-police>
References: <20180926113623.863696043@infradead.org>
 <20180926114800.770817616@infradead.org>
 <20180926125335.GG2979@brain-police>
 <20180926131141.GA12444@hirez.programming.kicks-ass.net>
 <20180926180727.GA7455@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926180727.GA7455@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 08:07:27PM +0200, Peter Zijlstra wrote:
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -305,7 +305,8 @@ static inline void __tlb_reset_range(str
>  #error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
>  #endif
>  
> -#define tlb_flush tlb_flush
> +#define generic_tlb_flush
> +
>  static inline void tlb_flush(struct mmu_gather *tlb)
>  {
>  	if (tlb->fullmm || tlb->need_flush_all) {
> @@ -391,12 +392,12 @@ static inline unsigned long tlb_get_unma
>   * the vmas are adjusted to only cover the region to be torn down.
>   */
>  #ifndef tlb_start_vma
> -#define tlb_start_vma tlb_start_vma
>  static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  {
>  	if (tlb->fullmm)
>  		return;
>  
> +#ifdef generic_tlb_flush
>  	/*
>  	 * flush_tlb_range() implementations that look at VM_HUGETLB (tile,
>  	 * mips-4k) flush only large pages.
> @@ -410,13 +411,13 @@ static inline void tlb_start_vma(struct
>  	 */
>  	tlb->vma_huge = !!(vma->vm_flags & VM_HUGETLB);
>  	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> +#endif

Alternatively, we could wrap the two assignments above in a macro like:

	tlb_update_vma_flags(tlb, vma)

which could be empty if the generic tlb_flush isn't in use?

Anyway, as long as we resolve this one way or the other, you can add my Ack:

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
