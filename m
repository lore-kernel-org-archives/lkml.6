Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42078C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FA521522
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cPSGy2df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FA521522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeIVQbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 12:31:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeIVQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 12:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qAv5cwmvc7TyPUSwOapzr0g1vq0NOqMFuJwbTvOo8Lk=; b=cPSGy2dfPQAIiPm8k2I7CK9Wk
        VFSkAGd2eDMXYg86ncbOg8gWl89eshiRnbkFEgSTcYgc4XsljuesIocdF/Gp1JmyAWNXJ2Z6mnYtg
        zwIjl4CAxRMWyLOK+vbbOuiuRXKHmEKvstMWkL0rywj/V1yXi4EOxSwjcwRCoeqP9rZ0fGqzwzNJg
        YgnjxCrvN//ZV6IeHEzSvPOyoNErT5Z53dBR0mfPYV7H6NEVHrmONk9wLb8StsbBK93vMvi27H6U5
        HgV6pfPluGLTqwfyllkwX9aqpIsUgDLCadMKyxxroMTyc2bvvyirCAmQtTD3B5ZTj3v0aJXfYcsSB
        CrH0/qgaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3fIS-0000Ej-Dc; Sat, 22 Sep 2018 10:37:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF6652025483B; Sat, 22 Sep 2018 12:37:52 +0200 (CEST)
Date:   Sat, 22 Sep 2018 12:37:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Bin Yang <bin.yang@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: Re: [PATCH 2/8] x86/mm/cpa: Move flush_tlb_all()
Message-ID: <20180922103752.GI24124@hirez.programming.kicks-ass.net>
References: <20180919085016.164552924@infradead.org>
 <20180919085947.882287392@infradead.org>
 <5ab3ee67-a29b-0f4c-d7cf-2bdedd192ad6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab3ee67-a29b-0f4c-d7cf-2bdedd192ad6@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 02:34:32PM -0700, Dave Hansen wrote:
> On 09/19/2018 01:50 AM, Peter Zijlstra wrote:
> > @@ -1528,28 +1538,8 @@ static int __change_page_attr(struct cpa
> >  	 * We have to split the large page:
> >  	 */
> >  	err = split_large_page(cpa, kpte, address);
> > -	if (!err) {
> ...
> > -		flush_tlb_all();
> > +	if (!err)
> >  		goto repeat;
> > -	}
> 
> I _think_ this is the only use of split_large_page()'s error code.  We
> can just make it return void now, right?

Then how does it decide to goto repeat or error out?

> BTW, I also really like doing the "final" TLB flush as close as possible
> to the actual PTE manipulation.  Makes it much less likely that we break it.

Yes.
