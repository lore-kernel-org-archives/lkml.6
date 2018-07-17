Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FCAECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FB720C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mASrF2Yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FB720C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbeGQMF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:05:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbeGQMF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XtYwwGdPdl8VxPkgMROVyS53GDTk1qvByNuaXHUdN9I=; b=mASrF2YzZfekND4zd+NseKhuP
        dzJjhnG7zC1zXVfZTKngCrjVQliAjzVQtoYAkUQjfKc+iAnBHYbELDYcgvyl/sWb1PvMkHrRGCYkf
        512lQ8/edMG6iKzK+3yJibSCYm3mqAL65KL1I92BjKbksD/8QwX4Q1N2vFOvcAHtfHv7IZbBtqTsC
        u7NiaReEMTJvz+y9NoLtuW1DwTjc/46XKdh3SLpXs/LdQcd6XCxxzqp3H1wvtIEZKOAvsGkFjSMPy
        0bI/lF2jCoSdUWcoAW9OBL6IyAquXLKCdDw9YCQ563xwJPIF7mPFJC4G/CjMmPFa9QePPumwfc0lr
        4AV/xs1Fg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffOEV-0008Oi-GH; Tue, 17 Jul 2018 11:33:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2190C20275F3B; Tue, 17 Jul 2018 13:33:30 +0200 (CEST)
Date:   Tue, 17 Jul 2018 13:33:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     songliubraving@fb.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, hpa@zytor.com, riel@surriel.com,
        tglx@linutronix.de, mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] x86/mm/tlb: Make lazy TLB mode lazier
Message-ID: <20180717113330.GU2476@hirez.programming.kicks-ass.net>
References: <20180716190337.26133-5-riel@surriel.com>
 <tip-ac0315896970d8589291e9d8a1569fc65967b7f1@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-ac0315896970d8589291e9d8a1569fc65967b7f1@git.kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 02:35:08AM -0700, tip-bot for Rik van Riel wrote:
> @@ -242,17 +244,40 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  			   next->context.ctx_id);
>  
>  		/*
> +		 * Even in lazy TLB mode, the CPU should stay set in the
> +		 * mm_cpumask. The TLB shootdown code can figure out from
> +		 * from cpu_tlbstate.is_lazy whether or not to send an IPI.
>  		 */
>  		if (WARN_ON_ONCE(real_prev != &init_mm &&
>  				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
>  			cpumask_set_cpu(cpu, mm_cpumask(next));
>  
> +		/*
> +		 * If the CPU is not in lazy TLB mode, we are just switching
> +		 * from one thread in a process to another thread in the same
> +		 * process. No TLB flush required.
> +		 */
> +		if (!was_lazy)
> +			return;
> +
> +		/*
> +		 * Read the tlb_gen to check whether a flush is needed.
> +		 * If the TLB is up to date, just use it.
> +		 * The barrier synchronizes with the tlb_gen increment in
> +		 * the TLB shootdown code.
> +		 */
> +		smp_mb();

What exactly is this smp_mb() ordering? The above comment is
insufficient. Is it the cpumask_set_cpu() vs the atomic64_read() ?

If so, should this not be smp_mb__after_atomic() (iow a NO-OP on x86)

If it is not so, please fix the comment to explain things.

> +		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
> +		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
> +				next_tlb_gen)
> +			return;
> +
> +		/*
> +		 * TLB contents went out of date while we were in lazy
> +		 * mode. Fall through to the TLB switching code below.
> +		 */
> +		new_asid = prev_asid;
> +		need_flush = true;
