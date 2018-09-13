Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02443C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF1B21477
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GHzXVApy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF1B21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeIMOqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:46:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeIMOqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NjzUUt+slHX66hXSRscAiWx2a/YyKrrpq0J6OsnZlKQ=; b=GHzXVApy+cJnpHPbBdQyZjbjY
        SsgglhGlJsqtR9RupjcVjp5KqNZFWW4qKyxUuYUmkuMu3qxPclsgE4ATXKWvZUexLRj0TC2ElisfJ
        lTSjUYFK6RpWzt+zaQsnAKPTTzjn2LdNSshaqeZ833AYa0ER9n6K1aaiblcbbW2f8pL0JteLLO1h6
        fhVdgx5C1qekXRJokSjuVJWs4Ya3H8HgFHS/5UNlkWAcGccKWrM4CaUqTprQh/PsNSllnQeqS+QLx
        sRyc4yl2sIxIFPZABQ0uvB695iCIKvarme0W8Aod2X8BplIJNYlif8rIwp4t9+FENMydoTWJlcLct
        isHc5KarQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0O4S-00072a-7b; Thu, 13 Sep 2018 09:37:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13C712026833F; Thu, 13 Sep 2018 11:37:54 +0200 (CEST)
Date:   Thu, 13 Sep 2018 11:37:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] perf: Prevent recursion in ring buffer
Message-ID: <20180913093754.GV24124@hirez.programming.kicks-ass.net>
References: <20180912193317.10339-1-jolsa@kernel.org>
 <20180913070740.GT24124@hirez.programming.kicks-ass.net>
 <20180913074607.GB15173@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913074607.GB15173@krava>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 09:46:07AM +0200, Jiri Olsa wrote:
> On Thu, Sep 13, 2018 at 09:07:40AM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 12, 2018 at 09:33:17PM +0200, Jiri Olsa wrote:
> > > Some of the scheduling tracepoints allow the perf_tp_event
> > > code to write to ring buffer under different cpu than the
> > > code is running on.
> > 
> > ARGH.. that is indeed borken.

> I was first thinking to just leave it on the current cpu,
> but not sure current users would be ok with that ;-)

> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index abaed4f8bb7f..9b534a2ecf17 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8308,6 +8308,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
>  				continue;
>  			if (event->attr.config != entry->type)
>  				continue;
> +			if (event->cpu != smp_processor_id())
> +				continue;
>  			if (perf_tp_event_match(event, &data, regs))
>  				perf_swevent_event(event, count, &data, regs);
>  		}

That might indeed be the best we can do.

So the whole TP muck would be responsible for placing only matching
events on the hlist, which is where our normal CPU filter is I think.

The above then does the same for @task. Which without this would also be
getting nr_cpus copies of the event I think.

It does mean not getting any events if the @task only has a per-task
buffer, but there's nothing to be done about that. And I'm not even sure
we can create a useful warning for that :/
