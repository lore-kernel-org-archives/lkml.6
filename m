Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B56ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A462083A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KUlKwsfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A462083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeIRMp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:45:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeIRMp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dmzhEnzn6h3pnRO3qMTM9dFGf6vgxoIx8BWFtp8vKMc=; b=KUlKwsfhcA9NPZv9o7zzJGjzm
        2uu2O2GAmQodIsMPZT4oJGCFgx28lid3nh8qiu0JLQQTXT0bht/SANd+tXFmdygnHwBlogthpDzSw
        NCTokEOjdjRC0rsxgCdhX8aHCP9O6LIHFqC68DjVEXnm7qHOcpOqlGlPJSJzRnh9K6TttIKQ8wlbX
        j/bzXekDWKRYw+M20R0DTzBMHTCA4Lm+1v6H3YoM/cXJN57KBjObnXUxD6dG20cE/vCIhiUEuXCoj
        HSnG532QmE10GdDZfICkc9D8DlIgPUgFrSRy+0GAzs56xC62ydreN6/Y7GG1nt87Uva6ULn9twspc
        RkOzTBQ2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2AD5-0000AG-La; Tue, 18 Sep 2018 07:14:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21E70202C1A36; Tue, 18 Sep 2018 09:14:10 +0200 (CEST)
Date:   Tue, 18 Sep 2018 09:14:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: Re: [patch V3 08/11] x86/mm/cpa: Add sanity check for existing
 mappings
Message-ID: <20180918071410.GH24106@hirez.programming.kicks-ass.net>
References: <20180917142906.384767038@linutronix.de>
 <20180917143546.331408643@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917143546.331408643@linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 04:29:14PM +0200, Thomas Gleixner wrote:
> +static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
> +			  pgprot_t ref_prot, unsigned long address,
> +			  unsigned long size)
> +{
> +	unsigned int npg = PFN_DOWN(size);
> +	pgprot_t prot;
> +
> +	/*
> +	 * If try_preserve_large_page() discovered an inconsistent mapping,

You just renamed that thing.. :-)

> +	 * remove the invalid protection in the split mapping.
> +	 */
> +	if (!cpa->force_static_prot)
> +		goto set;
> +
> +	prot = static_protections(ref_prot, address, pfn, npg, CPA_PROTECT);
> +
> +	if (pgprot_val(prot) == pgprot_val(ref_prot))
> +		goto set;
> +
> +	/*
> +	 * If this is splitting a PMD, fix it up. PUD splits cannot be
> +	 * fixed trivially as that would require to rescan the newly
> +	 * installed PMD mappings after returning from split_large_page()
> +	 * so an eventual further split can allocate the necessary PTE
> +	 * pages. Warn for now and revisit it in case this actually
> +	 * happens.
> +	 */
> +	if (size == PAGE_SIZE)
> +		ref_prot = prot;
> +	else
> +		pr_warn_once("CPA: Cannot fixup static protections for PUD split\n");
> +set:
> +	set_pte(pte, pfn_pte(pfn, ref_prot));
> +}
