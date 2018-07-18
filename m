Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1679ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BF82075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f16n0w2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BF82075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbeGRQ6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:58:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbeGRQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8aHzsSXrGGr+5xdQy9q7aeiPxVuQ0YjIec6iZn4AWG0=; b=f16n0w2/Ynlw6OF1saludT12F
        m9sy6MQDMCKWxguE82TkU6lc31SnNs086xmbY1CRkqpXsD2zHt+/7sa70n8IKCHBNi3DIHFsyiQTf
        hgKG15WsdDHQAwjd5pDOZzSDH5bGfoi3I1OlxAa7kof/eopDJJKhgZNwmWzcv0669T5H8+Wf6DZq3
        s6eiPE9KNkQptP/inP1lkvCCPQ2DMmkRHgTl3YHM77ESH0yzw0Jnx0+F+wXdePGDHFAxb4bjWcPom
        jvQCXdb/hVtpcT0zyHVCPWZIbmhwNwvMJTntFKJ08sK7GbCn9h393JnfG81YXMf2NW/RH6ICSa1WN
        gm0HfAN8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffpBE-0002R5-43; Wed, 18 Jul 2018 16:19:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69C1B20277352; Wed, 18 Jul 2018 18:19:54 +0200 (CEST)
Date:   Wed, 18 Jul 2018 18:19:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, songliubraving@fb.com, hpa@zytor.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] x86/mm/tlb: Only send page table free TLB flush to
 lazy TLB CPUs
Message-ID: <20180718161954.GU2494@hirez.programming.kicks-ass.net>
References: <20180716190337.26133-6-riel@surriel.com>
 <tip-64482aafe55fc7e84d0741c356f8176ee7bde357@git.kernel.org>
 <20180717113906.GV2476@hirez.programming.kicks-ass.net>
 <1F8BDD25-864D-4105-B872-2109AA417454@surriel.com>
 <24AA4367-22A1-450E-8F6A-3CBF39518384@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24AA4367-22A1-450E-8F6A-3CBF39518384@surriel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:50:33AM -0400, Rik van Riel wrote:
> > On Jul 18, 2018, at 11:42 AM, Rik van Riel <riel@surriel.com> wrote:
> >> On Jul 17, 2018, at 7:39 AM, Peter Zijlstra <peterz@infradead.org <mailto:peterz@infradead.org>> wrote:

> >> Also, was there a reason to re-implement on_each_cpu_cond() ? (which btw
> >> also wants that __cpumask_set_bit fix).
> > 
> > I did not use on_each_cpu_cond() because I had no idea it
> > existed.  A quick grep suggests very few users of that function :)

Yeah, only reason I know it existed was because I helped write it or
something like that :-)

> > I'll make sure things are done the right way.
> > 
> OK, looking at it some more, I think open coding may be faster in
> case of the TLB shootdown code, because that way we only iterate
> over the CPUs in the mm_cpumask, instead of iterating over every
> single online CPU in the system, and calling the helper function for
> every CPU, like on_each_cpu_cond() does.
> 
> However, the difference in overhead might be small enough that
> we might not notice. Preferences?

Yeah, so the difference is the case where the mask allocation fails; in
that case we're under severe memory pressure and performance sucks
anyway, right?

In which case using on_each_cpu_cond() seems the simpler option.
