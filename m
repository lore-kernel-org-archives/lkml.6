Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519CBC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CCA213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BOrnNsay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CCA213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeJAWqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:46:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeJAWqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9+117Ynmkrtkcb6O4zXbACrG8Hrcpv38L/9j0ovojuU=; b=BOrnNsayuDYhhfTxFn/+DBTxT
        nd0bbe79Yk3umHI1vGyepnlcw9JR/GbM/CmUJyfxIiFg+NYOhx/4Teo+V4PzdRg5IG1WdxbwmRUj2
        jlOhuxB2pDLwMa14s0h7PWSL7yQF2Srx9TgWQFOf/oTuJc30pfb7wb4jU9ALPwWrebJpJtt47N5MK
        8xK3L56K4zyFlpIdUGk4Oq3nHOeq57XEDHFxMLLCXIseKPD9/NC0uz77yO3F8kHq9/Lw/Y3katRR6
        XS2Lw6kpWCGog3g5uSwGKowO8gYQkJJhkTlNpLhxKaacI/lQnAGMWAfxgFWZNgVUx2XrCXMbiGf+h
        hyg/+vGvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g70jX-0001DX-FA; Mon, 01 Oct 2018 16:07:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B54862075FAA7; Mon,  1 Oct 2018 18:07:37 +0200 (CEST)
Date:   Mon, 1 Oct 2018 18:07:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        will.deacon@arm.com, songliubraving@fb.com, mingo@kernel.org,
        luto@kernel.org, hpa@zytor.com, npiggin@gmail.com
Subject: Re: [PATCH 7/7] x86/mm/tlb: Make lazy TLB mode lazier
Message-ID: <20181001160737.GL3439@hirez.programming.kicks-ass.net>
References: <20180926035844.1420-1-riel@surriel.com>
 <20180926035844.1420-8-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926035844.1420-8-riel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:58:44PM -0400, Rik van Riel wrote:
> @@ -594,8 +628,23 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
>  					       (void *)info, 1);
>  		return;
>  	}
> -	smp_call_function_many(cpumask, flush_tlb_func_remote,
> +
> +	/*
> +	 * If no page tables were freed, we can skip sending IPIs to
> +	 * CPUs in lazy TLB mode. They will flush the CPU themselves
> +	 * at the next context switch.
> +	 *
> +	 * However, if page tables are getting freed, we need to send the
> +	 * IPI everywhere, to prevent CPUs in lazy TLB mode from tripping
> +	 * up on the new contents of what used to be page tables, while
> +	 * doing a speculative memory access.
> +	 */
> +	if (info->freed_tables)
> +		smp_call_function_many(cpumask, flush_tlb_func_remote,
>  			       (void *)info, 1);
> +	else
> +		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func_remote,
> +				(void *)info, 1, GFP_ATOMIC, cpumask);
>  }

And this is safe vs paravirt, because for native we now do _less_
invalidations.

That might warrant a mention in the Changelog perhaps.


