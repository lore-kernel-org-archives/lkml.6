Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC78C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5855620867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FAWLrfps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5855620867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeH2QKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:10:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeH2QKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uUHVKWEmOnBG+Cq3BUeka1ScBj2FaACw2lUukbGHpQM=; b=FAWLrfps7fg9BO6MYQ0tNidW7
        Ez/pKLdkku3gFjUyOiLMSODnEVxGnufrAOG+82pzGdJMVoWBDipM0Cy5fQkt3Jt2LWpRBkpZbMTBZ
        pvnCS65x1tsNvbsfEsAXdMbsu2729WsqeRGHnEet23hRI59+HAc0N68N3GDHP6cLyCMOfR9vURpVv
        b+w70AwDXFuwsbqb3WJOgXUz701nVFDBOVZneGI+tkkW+IXgyBuVdV+e18tWuAp1QYouXtnrvpWCT
        s0GUnNaWQWHgUszNsgbVeEV8WpEBmIzYTr+cXa5/qnCxkZXe9v5EpGiZtq9INMxYRDBZZWUEI5Rd9
        hEIZlAu+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuzM7-0001A0-Os; Wed, 29 Aug 2018 12:13:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BC0C2024D706; Wed, 29 Aug 2018 14:13:49 +0200 (CEST)
Date:   Wed, 29 Aug 2018 14:13:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [perf] perf_event.h ABI visibility question
Message-ID: <20180829121349.GT24124@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1808231401440.28868@macbook-air>
 <20180824085042.GL24124@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1808241706120.12717@macbook-air>
 <20180827075246.GX24124@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1808281349210.21658@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808281349210.21658@macbook-air>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:51:29PM -0400, Vince Weaver wrote:
> On Mon, 27 Aug 2018, Peter Zijlstra wrote:
> 
> > Something like so then?
> > 
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index eeb787b1c53c..f35eb72739c0 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -144,7 +144,7 @@ enum perf_event_sample_format {
> >  
> >  	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
> >  
> > -	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
> > +	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
> >  };
> 
> yes, something like that would be fine.
> 
> I am being difficult about this, but from experience when trying to keep 
> the manpage updated, what seems obvious now will not be so obvious 6 
> months from now and trying to dig through the git logs / mailing list 
> archives to verify the purpose of an addition can be a lot of work 
> sometimes.

Yeah, no worries. I appreciate you paying attention to these things.
