Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0AB3AC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD1F208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SQSPfZPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD1F208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755163AbeFNTjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:39:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754749AbeFNTjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+wI/3JohTRIKAzZuWdvVrAAcejddZvY8woTyGLxtZJ0=; b=SQSPfZPK1gklzO1wSNeE4hVbW
        wekMYhR2jqJwlbmyXgF4aGvR8aHePiayte4irZovHpLepcBeUs3wkuV/6OwuxscfvhkVy4TDs8aEO
        wz7++JoYaMNuS0fydCEcIUCGYUMvNYrTzJIfUzWH1LJ45owImt4lQ78vWGJYCe/NFALh1lzHrMt+Q
        dUCwDeCtFiqiTwzIhaz1ZpDjbdGxF9HV3KLjqBnhOraMUPQcgTHXLwo5ObmHDMzgUPEFcBzF91aGn
        6Wu1gYdApH2zb4/Nse8Gy4w1S0cGuA9Ecm8FLH8B5aetNBOTWkRNdUMp4BLyhzFpePR5hurpV8RvT
        P8wVKdRgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTY5W-0005Ma-Ur; Thu, 14 Jun 2018 19:39:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C631201EA7C8; Thu, 14 Jun 2018 21:39:17 +0200 (CEST)
Date:   Thu, 14 Jun 2018 21:39:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
Message-ID: <20180614193917.GJ12235@hirez.programming.kicks-ass.net>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
 <20180612075117.65420-5-alexander.shishkin@linux.intel.com>
 <20180614192513.GX12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614192513.GX12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 09:25:13PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 10:51:15AM +0300, Alexander Shishkin wrote:
> > @@ -882,6 +890,7 @@ struct perf_sample_data {
> >  	 */
> >  	u64				addr;
> >  	struct perf_raw_record		*raw;
> > +	struct perf_aux_record		aux;
> >  	struct perf_branch_stack	*br_stack;
> >  	u64				period;
> >  	u64				weight;
> > @@ -933,6 +942,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
> >  	/* remaining struct members initialized in perf_prepare_sample() */
> >  	data->addr = addr;
> >  	data->raw  = NULL;
> > +	data->aux.from = data->aux.to = data->aux.size = 0;
> >  	data->br_stack = NULL;
> >  	data->period = period;
> >  	data->weight = 0;
> 
> You just blew that cacheline...

And since the whole aux_sample thing seems to be purely prepare/output
driven, I really don't see the need why this needs to be here. AFAICT it
should just work fine in the other part of this structure.
