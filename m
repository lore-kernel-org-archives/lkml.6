Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97ACE21775
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xZbmahRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97ACE21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeHCRxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:53:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43554 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeHCRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=loSAiJAaFJUbHhExwiUYOH+Vn8J+f+PA2MtACblNFnE=; b=xZbmahRII8cEQwQ+m4nocjTAj
        P1Uk+d9Z5mTs5iDcEYvQSFgQDwlXeygQGaKDoOQDEA4016j+I4TxndGbSOyQX8ToHNczGxVXixex6
        0vV2F6FTDB+/avjJWGK3R9JBtjbDWBW8sGE20mG0focFlGdJ3y9WRZ81qI6QyHwldqvWy7DLPq6JS
        j//OICEH5qvKdeFe0gXcqhfvk1l0YeHF2v3kaqlZUlqENdAnZ9DCYV4H++Whn+S9E9+/n3c0wwCAM
        lVndgH9i6ejjwseDsowbw0OYSyyYuTiKvb1WnZLeUQH/EPlgZ8UIjR/FXCHFR9uLMfabMMHrzU/jF
        i94y8BaHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flcR9-000735-Nk; Fri, 03 Aug 2018 15:56:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E63220267E51; Fri,  3 Aug 2018 17:56:18 +0200 (CEST)
Date:   Fri, 3 Aug 2018 17:56:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        luto@kernel.org, x86@kernel.org, efault@gmx.de,
        dave.hansen@intel.com
Subject: Re: [PATCH 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
Message-ID: <20180803155618.GB2494@hirez.programming.kicks-ass.net>
References: <20180801100255.4278-1-riel@surriel.com>
 <20180801100255.4278-12-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801100255.4278-12-riel@surriel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:02:55AM -0400, Rik van Riel wrote:
> Conditionally skip lazy TLB mm refcounting. When an architecture has
> CONFIG_ARCH_NO_ACTIVE_MM_REFCOUNTING enabled, an mm that is used in
> lazy TLB mode anywhere will get shot down from exit_mmap, and there
> in no need to incur the cache line bouncing overhead of refcounting
> a lazy TLB mm.
> 
> Implement this by moving the refcounting of a lazy TLB mm to helper
> functions, which skip the refcounting when it is not necessary.
> 
> Deal with use_mm and unuse_mm by fully splitting out the refcounting
> of the lazy TLB mm a kernel thread may have when entering use_mm from
> the refcounting of the mm that use_mm is about to start using.


> @@ -2803,16 +2803,29 @@ context_switch(struct rq *rq, struct task_struct *prev,
>  	 * membarrier after storing to rq->curr, before returning to
>  	 * user-space.
>  	 */
> +	/*
> +	 * kernel -> kernel	lazy + transfer active
> +	 *   user -> kernel	lazy + grab_lazy_mm active
> +	 *
> +	 * kernel ->   user	switch + drop_lazy_mm active
> +	 *   user ->   user	switch
> +	 */
> +	if (!mm) {				// to kernel
>  		next->active_mm = oldmm;
>  		enter_lazy_tlb(oldmm, next);
> +
> +		if (prev->mm)			// from user
> +			grab_lazy_mm(oldmm);
> +		else
> +			prev->active_mm = NULL;
> +	} else {				// to user
>  		switch_mm_irqs_off(oldmm, mm, next);
>  
> +		if (!prev->mm) {		// from kernel
> +			/* will drop_lazy_mm() in finish_task_switch(). */
> +			rq->prev_mm = oldmm;
> +			prev->active_mm = NULL;
> +		}
>  	}

So this still confuses the heck out of me; and the Changelog doesn't
seem to even mention it. You still track and swizzle ->active_mm but no
longer refcount it.

Why can't we skip the ->active_mm swizzle and keep ->active_mm == ->mm.

Doing the swizzle but not the refcount just makes me itch.
