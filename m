Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337D3ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54BA20831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SjcDa/Dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54BA20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeJYJHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:07:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYJHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/V82UfchjbRn+jVT094fp0cw8ZiNYcEUP5bvpPy/uFE=; b=SjcDa/DcpbS2n7zHc1S51O9on
        0X15V9hxqPjWFFpokJB47cE9084Cvkdv2/Nvsik6BHNjNQreskEFnmpiauu3mKQrVsgeqkxPiHgFJ
        vCsmmD+Pi+WFQiEKo06AFp/gDjYlqJoDBERngcs1wFcSHrYM0uWYfP/571Q2lpLDOS3YFKMqvBMvN
        jebJ8eDd+ioIJQPZKcrYy14NmQwBoOgwajOuh9DVdLsJeSuSwlmQZRe7UzPMjfSCRF+IPD4dJd27a
        1K05p/vRiVTq1XoiPacMaI5JHZtfXeCM9BIUMwkQqLrX22uE1VE4A6bt8Aro1tbAA+AcMM7OMexVx
        HOHG+RAig==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFTdY-0002UX-Di; Thu, 25 Oct 2018 00:36:37 +0000
Received: by worktop (Postfix, from userid 1000)
        id C28896E0675; Thu, 25 Oct 2018 02:29:43 +0200 (CEST)
Date:   Thu, 25 Oct 2018 02:29:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH 1/2] perf: Add munmap callback
Message-ID: <20181025002943.GT3109@worktop.c.hoisthospitality.com>
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024151116.30935-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 08:11:15AM -0700, kan.liang@linux.intel.com wrote:
> +void perf_event_munmap(void)
> +{
> +	struct perf_cpu_context *cpuctx;
> +	unsigned long flags;
> +	struct pmu *pmu;
> +
> +	local_irq_save(flags);

It is impossible to get here with IRQs already disabled.

> +	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
> +		pmu = cpuctx->ctx.pmu;
> +
> +		if (!pmu->munmap)
> +			continue;
> +
> +		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> +		perf_pmu_disable(pmu);
> +
> +		pmu->munmap();
> +
> +		perf_pmu_enable(pmu);
> +
> +		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> +	}
> +	local_irq_restore(flags);
> +}
> +
>  static void perf_event_switch(struct task_struct *task,
>  			      struct task_struct *next_prev, bool sched_in);
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5f2b2b184c60..61978ad8c480 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2777,6 +2777,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  	/*
>  	 * Remove the vma's, and unmap the actual pages
>  	 */
> +	perf_event_munmap();

I think that if you add the munmap hook, you should do it right and at
least do it such that we can solve the other munmap problem.

>  	detach_vmas_to_be_unmapped(mm, vma, prev, end);
>  	unmap_region(mm, vma, prev, start, end);
>  
> -- 
> 2.17.1
> 
