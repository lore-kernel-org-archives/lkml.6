Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5250BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD2920C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TW4OVh5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD2920C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbeGQML2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:11:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeGQML2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uSl+pg/KU1ajAyGTPkJ3M3FKmuBXeJFv0lcSEru4HfA=; b=TW4OVh5l8vsZaIwDpJ6IH47mt
        2a4TMh83GNBuvKeMljVecBTRJ9zzKdq7Ni1Ru6aQlXVQYGg/zkEsriUJg6RFIvr5knZZpyyTFVAXZ
        TDLlIyjiZH73Yfx5GOiJXcWpsMnrNvf32KblN2oXOen3jLr7HLMpU2r87htJM31rtCBjvNzVLxiqq
        am99yqOzN/M+bl5gDo+mz+PKQzsi5EJV92Z6A6Ze7fjuxN/GavjKWSe5OjBBlZ9cM4qhMZX64q6fH
        cPWaL0FySorH5y9vCyO9wF4mcwWdIkSFtcGw0Dh2RN9zEuZweCFH245UZd5a34nMEWZS9NsIeQ07z
        LRSdMVY6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffOJw-00029R-E3; Tue, 17 Jul 2018 11:39:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF6E920289332; Tue, 17 Jul 2018 13:39:06 +0200 (CEST)
Date:   Tue, 17 Jul 2018 13:39:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, songliubraving@fb.com, hpa@zytor.com,
        tglx@linutronix.de, torvalds@linux-foundation.org, riel@surriel.com
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] x86/mm/tlb: Only send page table free TLB flush to
 lazy TLB CPUs
Message-ID: <20180717113906.GV2476@hirez.programming.kicks-ass.net>
References: <20180716190337.26133-6-riel@surriel.com>
 <tip-64482aafe55fc7e84d0741c356f8176ee7bde357@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-64482aafe55fc7e84d0741c356f8176ee7bde357@git.kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 02:35:41AM -0700, tip-bot for Rik van Riel wrote:
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 26542cc17043..e4156e37aa71 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -712,15 +712,50 @@ void tlb_flush_remove_tables_local(void *arg)
>  	}
>  }
>  
> +static void mm_fill_lazy_tlb_cpu_mask(struct mm_struct *mm,
> +				      struct cpumask *lazy_cpus)
> +{
> +	int cpu;
> +
> +	for_each_cpu(cpu, mm_cpumask(mm)) {
> +		if (!per_cpu(cpu_tlbstate.is_lazy, cpu))
> +			cpumask_set_cpu(cpu, lazy_cpus);

That really wants to be __cpumask_set_cpu(). Using LOCK prefix
instructions to set local bits is kinda pointless and expensive.

> +	}
> +}
> +
>  void tlb_flush_remove_tables(struct mm_struct *mm)
>  {
>  	int cpu = get_cpu();
> +	cpumask_var_t lazy_cpus;
> +
> +	if (cpumask_any_but(mm_cpumask(mm), cpu) >= nr_cpu_ids) {
> +		put_cpu();
> +		return;
> +	}
> +
> +	if (!zalloc_cpumask_var(&lazy_cpus, GFP_ATOMIC)) {
> +		/*
> +		 * If the cpumask allocation fails, do a brute force flush
> +		 * on all the CPUs that have this mm loaded.
> +		 */
> +		smp_call_function_many(mm_cpumask(mm),
> +				tlb_flush_remove_tables_local, (void *)mm, 1);
> +		put_cpu();
> +		return;
> +	}
> +
>  	/*
> -	 * XXX: this really only needs to be called for CPUs in lazy TLB mode.
> +	 * CPUs with !is_lazy either received a TLB flush IPI while the user
> +	 * pages in this address range were unmapped, or have context switched
> +	 * and reloaded %CR3 since then.
> +	 *
> +	 * Shootdown IPIs at page table freeing time only need to be sent to
> +	 * CPUs that may have out of date TLB contents.
>  	 */
> -	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> -		smp_call_function_many(mm_cpumask(mm), tlb_flush_remove_tables_local, (void *)mm, 1);
> -
> +	mm_fill_lazy_tlb_cpu_mask(mm, lazy_cpus);
> +	smp_call_function_many(lazy_cpus,
> +				tlb_flush_remove_tables_local, (void *)mm, 1);
> +	free_cpumask_var(lazy_cpus);
>  	put_cpu();
>  }

Also, was there a reason to re-implement on_each_cpu_cond() ? (which btw
also wants that __cpumask_set_bit fix).
