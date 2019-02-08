Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D71C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234602177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IQktueD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfBHUHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:07:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56938 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBHUHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WtDEoaHSuGZAetWKBZPTZndD6PT7PBHEnEJoKrr4c9w=; b=IQktueD1OkK116dUBP6B2XRnZ
        56rU8JEbDfvvLD16GgZXT20g7dOsQaNSsu8/edPtnv7Kvz1zQPOUbHQnIL4ekG9M04zUWutRKWsam
        ba4BfCFVR25ygWs+67G5IJjPWT7Aad1QgWmc5S9S2lXgUrJP3vB3M2rKIwpFo+cAZLioShzpwvcMY
        6GkSfMw2dU11YOglvbZ9tTJcfkbC/qAHbu3RVGleP1dcrglfih+SRj3AHz23+7xxbbZ8LOHpIQylg
        NrMfxtnzms+Ywb0PZSN/AfH4RPT6Cp0SVRBPt3PGWjj+BexlL/Rutslr5o6NVSK7M/QIKsAU3SJde
        K1r6rgW5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gsCQx-0007JD-NJ; Fri, 08 Feb 2019 20:07:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC79520D0BED0; Fri,  8 Feb 2019 21:07:31 +0100 (CET)
Date:   Fri, 8 Feb 2019 21:07:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, luto@amacapital.net,
        vbabka@suse.cz, will.deacon@arm.com, kirill@shutemov.name
Subject: Re: [PATCH V5 02/14] perf/x86: Add perf_get_page_size support
Message-ID: <20190208200731.GN32511@hirez.programming.kicks-ass.net>
References: <1549648509-12704-1-git-send-email-kan.liang@linux.intel.com>
 <1549648509-12704-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549648509-12704-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:54:57AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Implement a x86 specific version of perf_get_page_size(), which do full
> page-table walk of a given virtual address to retrieve page size.
> For x86, disabling IRQs over the walk is sufficient to prevent any tear
> down of the page tables.
> 
> The new sample type requires collecting the virtual address. The virtual
> address will not be output unless SAMPLE_ADDR is applied.
> 
> The large PEBS will be disabled with this sample type. Because we need
> to track munmap to flush the PEBS buffer for large PEBS. Perf doesn't
> support munmap tracking yet. The large PEBS can be enabled later
> separately when munmap tracking is supported.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> Changes since V4
> - Split patch 1 of V4 into two patches.
>   This patch add the x86 implementation
> 
>  arch/x86/events/core.c     | 31 +++++++++++++++++++++++++++++++
>  arch/x86/events/intel/ds.c |  3 ++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 374a197..229a73b 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2578,3 +2578,34 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
>  	cap->events_mask_len	= x86_pmu.events_mask_len;
>  }
>  EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
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
> +		if (current->mm) {
> +			pte = lookup_address_in_pgd(pgd_offset(current->mm, virt),
> +						    virt, &level);
> +		} else
> +			level = PG_LEVEL_NUM;
> +	}
> +	local_irq_restore(flags);
> +	if (level >= PG_LEVEL_NUM)
> +		return 0;
> +
> +	return (u64)page_level_size(level);
> +}

Full NAK on a pure x86 implementation.
