Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB549C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBEA208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBEA208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbeHWRKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:10:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46630 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730895AbeHWRKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:10:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 149B215A2;
        Thu, 23 Aug 2018 06:40:57 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A456A3F675;
        Thu, 23 Aug 2018 06:40:55 -0700 (PDT)
Date:   Thu, 23 Aug 2018 14:40:53 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, riel@surriel.com, jannh@google.com,
        ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm: move tlb_table_flush to tlb_flush_mmu_free
Message-ID: <20180823134052.GC1496@brain-police>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <20180823084709.19717-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823084709.19717-2-npiggin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 06:47:08PM +1000, Nicholas Piggin wrote:
> There is no need to call this from tlb_flush_mmu_tlbonly, it
> logically belongs with tlb_flush_mmu_free. This allows some
> code consolidation with a subsequent fix.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  mm/memory.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Looks good to me, thanks:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/mm/memory.c b/mm/memory.c
> index 19f47d7b9b86..7c58310734eb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -245,9 +245,6 @@ static void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>  
>  	tlb_flush(tlb);
>  	mmu_notifier_invalidate_range(tlb->mm, tlb->start, tlb->end);
> -#ifdef CONFIG_HAVE_RCU_TABLE_FREE
> -	tlb_table_flush(tlb);
> -#endif
>  	__tlb_reset_range(tlb);
>  }
>  
> @@ -255,6 +252,9 @@ static void tlb_flush_mmu_free(struct mmu_gather *tlb)
>  {
>  	struct mmu_gather_batch *batch;
>  
> +#ifdef CONFIG_HAVE_RCU_TABLE_FREE
> +	tlb_table_flush(tlb);
> +#endif
>  	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
>  		free_pages_and_swap_cache(batch->pages, batch->nr);
>  		batch->nr = 0;
> -- 
> 2.17.0
> 
