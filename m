Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F17C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CEE21A54
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EcPcdB7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CEE21A54
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbeHFRwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:52:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbeHFRwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gX+Z6YgQtu9qc8WdWjPwAGN/i9XUDl84YiK9BnmyK4w=; b=EcPcdB7Vbs28nTjI9OMi900wv
        Ktr5+EM3Ij/JeoZ1EsYMHMdpwJ9SlUD8UtHmM50Ih3VhYYrlgPy1Du6f37mxnHlwl8zxQl9PXfHu/
        NPOZwz2dH9U/KRGIPYF0VAZH6lcjbzPjjxAFq6KGtM2E1cqjZhZnqbUqDNNcFOINQXtqCl340QBNn
        b59i2m4BiR4xrRtskmQGvBYDMddqc7jc3vAeMC6ivThn0fUW+Wz2yaHiX5O1Bq7goVNpXtIIih2PY
        7nj948fqWvEgFbd5WpsopO5KkOhGA0KaALdtgHCx9HAZHGemaG77MzUvA7/FhG322Aown713d/exJ
        rP6yEjS0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmheX-0006LT-48; Mon, 06 Aug 2018 15:42:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69964205881D3; Mon,  6 Aug 2018 17:42:35 +0200 (CEST)
Date:   Mon, 6 Aug 2018 17:42:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fubo Chen <fubo.chen@gmail.com>
Cc:     jpoimboe@redhat.com, Ingo Molnar <mingo@kernel.org>,
        bhole_prashant_q7@lab.ntt.co.jp,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/x86/intel: Fix unwind errors from PEBS entries
 (mk-II)
Message-ID: <20180806154235.GO2494@hirez.programming.kicks-ass.net>
References: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
 <20180719153347.buoe6pavpqc75zbb@treble>
 <20180719174311.GK2494@hirez.programming.kicks-ass.net>
 <20180719211954.GZ2512@hirez.programming.kicks-ass.net>
 <CAJAFBLDtRUwYhMaOrgHer4eTvjWL2jC-fy0GGv+Pjd8q3wgywA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJAFBLDtRUwYhMaOrgHer4eTvjWL2jC-fy0GGv+Pjd8q3wgywA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 08:35:07AM -0700, Fubo Chen wrote:
> On Thu, Jul 19, 2018 at 2:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -143,6 +143,8 @@ enum perf_event_sample_format {
> >         PERF_SAMPLE_PHYS_ADDR                   = 1U << 19,
> >
> >         PERF_SAMPLE_MAX = 1U << 20,             /* non-ABI */
> > +
> > +       __PERF_SAMPLE_CALLCHAIN_EARLY           = 1UL << 63,
> >  };
> 
> The above change makes sparse unhappy :-( Sparse reports the following
> complaint about __PERF_SAMPLE_CALLCHAIN_EARLY:

I thought I changed that to 1ULL before commit.
