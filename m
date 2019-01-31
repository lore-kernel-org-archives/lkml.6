Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DD9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695EA2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lJyADiHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbfAaMhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:37:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60644 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaMhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5mShMl/xHZFVU+Iroom9bfOXCGvno2SIouMHgZuzrO0=; b=lJyADiHLbRp4brooBNGlQk8/4
        LZsJnOu80JBzbu1Nm2l+YNvFsG4RRDt3oYt4v4ikJQAXrWs7qKfVw+qVeyA0IejP9sTjBsfvIureR
        KX9j7TjXomBe6nmA057xiuqjjfkkshqn+cBY5nsjsi0EPWwFkDBhjIpJWRj+TdYX6E6O/o3AjX44d
        xAFaNM4wEr1b5VVPbQbnvfoGmAJK6hRANbvb4DJ3CZIxB1UQUA+QtiNNr5fI1QJAJdEI3nv1fh7z7
        zeqCMO+bLaOJUTP9N/2JQbE1MFaAve0KRhqmx1ZxtNGtoqC56gGX87xf5nQkTUUXDdwc90kgSIegG
        er6GmpVUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpBax-0005Ra-KN; Thu, 31 Jan 2019 12:37:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 579C7202E5207; Thu, 31 Jan 2019 13:37:25 +0100 (CET)
Date:   Thu, 31 Jan 2019 13:37:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH V3 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20190131123725.GB31516@hirez.programming.kicks-ass.net>
References: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:23:42AM -0800, kan.liang@linux.intel.com wrote:
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 374a197..03bf45d 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2578,3 +2578,45 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
>  	cap->events_mask_len	= x86_pmu.events_mask_len;
>  }
>  EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
> +
> +/*
> + * map x86 page levels to perf page sizes
> + */
> +static const enum perf_page_size perf_page_size_map[PG_LEVEL_NUM] = {
> +	[PG_LEVEL_NONE] = PERF_PAGE_SIZE_NONE,
> +	[PG_LEVEL_4K]   = PERF_PAGE_SIZE_4K,
> +	[PG_LEVEL_2M]   = PERF_PAGE_SIZE_2M,
> +	[PG_LEVEL_1G]   = PERF_PAGE_SIZE_1G,
> +	[PG_LEVEL_512G] = PERF_PAGE_SIZE_512G,
> +};
> +
> +u64 perf_get_page_size(u64 virt)
> +{
> +	unsigned long flags;
> +	unsigned int level;
> +	pte_t *pte;
> +
> +	if (!virt)
> +		return 0;
> +
> +	/*
> +	 * Interrupts are disabled, so it prevents any tear down
> +	 * of the page tables.
> +	 * See the comment near struct mmu_table_batch.
> +	 */
> +	local_irq_save(flags);
> +	if (virt >= TASK_SIZE)
> +		pte = lookup_address(virt, &level);
> +	else {
> +		if (current->mm)
> +			pte = lookup_address_in_pgd(pgd_offset(current->mm, virt),
> +						    virt, &level);

Aside from all the missin {}, I'm fairly sure this is broken since this
happens from NMI context. This can interrupt switch_mm() and things like
use_temporary_mm().

Also; why does this live in the x86 code and not in the generic code?

> +		else
> +			level = PG_LEVEL_NUM;
> +	}
> +	local_irq_restore(flags);
> +	if (level >= PG_LEVEL_NUM)
> +		return PERF_PAGE_SIZE_NONE;
> +
> +	return (u64)perf_page_size_map[level];
> +}

> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 7198ddd..79daacd 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -141,8 +141,9 @@ enum perf_event_sample_format {
>  	PERF_SAMPLE_TRANSACTION			= 1U << 17,
>  	PERF_SAMPLE_REGS_INTR			= 1U << 18,
>  	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
> +	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 20,
>  
> -	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
> +	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
>  
>  	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>  };
> @@ -863,6 +864,7 @@ enum perf_event_type {
>  	 *	{ u64			abi; # enum perf_sample_regs_abi
>  	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
>  	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
> +	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
>  	 * };
>  	 */
>  	PERF_RECORD_SAMPLE			= 9,
> @@ -1150,6 +1152,18 @@ union perf_mem_data_src {
>  #define PERF_MEM_S(a, s) \
>  	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>  
> +
> +enum perf_page_size {
> +	PERF_PAGE_SIZE_NONE,
> +	PERF_PAGE_SIZE_4K,
> +	PERF_PAGE_SIZE_8K,
> +	PERF_PAGE_SIZE_16K,
> +	PERF_PAGE_SIZE_64K,
> +	PERF_PAGE_SIZE_2M,
> +	PERF_PAGE_SIZE_1G,
> +	PERF_PAGE_SIZE_512G,
> +};

Since you have a u64 to store this in, WTH do you use this limited enum?
Are you very sure this covers all the possible page sizes for all
architectures?

Why not simply report the page size in bytes?
