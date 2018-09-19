Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9983C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF5421508
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CNYZsiSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF5421508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbeISOwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:52:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeISOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i5h+2OisngGCOv9A4OuZ2xnp4PuGuj3fKShnZrRMaag=; b=CNYZsiSyRITke+NEyGj/lITNv
        RovF98Z0vLUyy6mdOCO20afFi++3L6gPz2KweiUHhbOb9LSC1iKMHiwI6xSOl8RfUBfGpelap2Lr+
        mLZLcJYUo6F6oBoZFFkFt0ZNPsQa4RU1Y/0s0BgeL3hOvL5UdfhqOwk0KRoZjwtF7IKdAKTaOQ1V6
        ciTO5aCUNF212fakVXCYi8nZycibwQ3LbSr9+Jx8kOYd7r7Tku/KN7kh94R0k+oH+xpBbdPvC51xo
        ZX4YAG5JtCsU2+uAI5wB5zCQRsRJgGNAYSYgN4rR3rRiBl88bblt5ET6hQY7r6CwDEIgg5XAkVyZk
        VdA3Usacg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2YZw-0004tF-2K; Wed, 19 Sep 2018 09:15:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E3BB202C1A33; Wed, 19 Sep 2018 11:15:17 +0200 (CEST)
Date:   Wed, 19 Sep 2018 11:15:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: Re: [PATCH 1/8] x86/mm/cpa: Use flush_tlb_all()
Message-ID: <20180919091517.GX24124@hirez.programming.kicks-ass.net>
References: <20180919085016.164552924@infradead.org>
 <20180919085947.831102058@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919085947.831102058@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:50:17AM +0200, Peter Zijlstra wrote:
> Instead of open-coding it..
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/mm/pageattr.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -285,16 +285,6 @@ static void cpa_flush_all(unsigned long
>  	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
>  }
>  
> -static void __cpa_flush_range(void *arg)
> -{
> -	/*
> -	 * We could optimize that further and do individual per page
> -	 * tlb invalidates for a low number of pages. Caveat: we must
> -	 * flush the high aliases on 64bit as well.
> -	 */
> -	__flush_tlb_all();
> -}

Hmm,.. so in patch #4 I do switch to flush_tlb_kernel_range(). What are
those high aliases that comment talks about?
