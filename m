Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FE8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5721206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U2ZRKMx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5721206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbeGTLwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:52:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeGTLwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7ouedsEnVmJZXV8iKYA9Gm2tBgsZ9qzzF0EIfIEvWSw=; b=U2ZRKMx0MAJYDKjDby+eP7Dgo
        itPVm3SsKippAICD641iA+sIxjFZnJCmXnG4Velz97S/pYMJVA2mAiNPb+2/u2WhsUJlI2axNbQwI
        QTHWZo6mjn22KMnNy+r+4CYlUYGZO1bsC2SjVkKfxofPxUfW0s64RygtER4uLBNgE5xhVi5sQSoSD
        GtHRT0AH1laG59r87sLMuyCvy1itmp0T3X7ZZcpd+vYWqfVimvnew/APEXxnBP9Im5dgxA/VNr44j
        HbVJGcJ4DZJF+opsvb3HxVA90xCI5ByO1GEq0d5vC9YPZ2wMo2f/eIiGwvAae8XMfVdd2t6Q6XBMl
        2Sca4LwEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgTD1-0006o3-4h; Fri, 20 Jul 2018 11:04:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDAC920275F3E; Fri, 20 Jul 2018 13:04:24 +0200 (CEST)
Date:   Fri, 20 Jul 2018 13:04:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Rik van Riel <riel@surriel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
Message-ID: <20180720110424.GA2512@hirez.programming.kicks-ass.net>
References: <20180716190337.26133-1-riel@surriel.com>
 <20180716190337.26133-5-riel@surriel.com>
 <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
 <B6566AA4-2E8A-43BD-A224-0F6D4747B8FB@surriel.com>
 <F93A3335-4830-4E36-9179-D0FA5D640C8A@amacapital.net>
 <B976CC13-D014-433A-83DE-F8DF9AB4F421@surriel.com>
 <CALCETrWDiMhgiR3f8n0jdWcW31EDJ+Waq0wh5sMDutfigANGnA@mail.gmail.com>
 <20180720093239.GO2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720093239.GO2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 11:32:39AM +0200, Peter Zijlstra wrote:

> +	if (!next->mm) {				// to kernel
> +		enter_lazy_tlb(prev->active_mm, next);
> +
> +#ifdef ARCH_NO_ACTIVE_MM
> +		next->active_mm = prev->active_mm;
> +		if (prev->mm)				// from user
> +			mmgrab(prev->active_mm);
		else
			prev->active_mm = NULL;
> +#endif
> +	} else {					// to user
> +		switch_mm_irqs_off(prev->active_mm, next->mm, next);
> +
> +#ifdef ARCH_NO_ACTIVE_MM
> +		if (!prev->mm) {			// from kernel
> +			/* will mmdrop() in finish_task_switch(). */
> +			rq->prev_mm = prev->active_mm;
> +			prev->active_mm = NULL;
> +		}
> +#endif
>  	}
