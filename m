Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4705BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEF321A50
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EgVD2YUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEF321A50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbeHFRfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:35:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36636 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732386AbeHFRfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZdfO5PyjZXR150UMtqHm4zxkP/3ep6gC1wezPDd7wUw=; b=EgVD2YUcxlgr5gvaAdGPF1a5X
        bq1RrKJESnu+evMyio23d6fvKcFT0SO6xoEgyGCsKr4rDywUNX8yjV/q4LmRK7uSae7sBmRSXrQXV
        l3fN2NdeMNFQytE9bCEq8Q0HOxQeFaLf1OIEZ2l7AHz+Tib3Q3VJnlhXg9Tr/HtdcHJSyWnWINFYS
        VBP/R0BhbG92VEJbBM1IEqfG0ZfTnJb4VG+CoJiF4sgyknKpZz+q2VOOP01wiIqDPHoEez+rS5gHw
        Lz3YBXs60EsDU12AuBJHtyoQG2rsmN6OeOkEsF7RRDYamoq7nnVxqAfPK0AZFofVl16/JKP480l13
        wmB22YCWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmhNz-0000UQ-1s; Mon, 06 Aug 2018 15:25:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAF442058A21D; Mon,  6 Aug 2018 17:25:28 +0200 (CEST)
Date:   Mon, 6 Aug 2018 17:25:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180806152528.GM2494@hirez.programming.kicks-ass.net>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-9-hannes@cmpxchg.org>
 <20180803165641.GA2476@hirez.programming.kicks-ass.net>
 <20180806150550.GA9888@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806150550.GA9888@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 11:05:50AM -0400, Johannes Weiner wrote:
> Argh, that's right. This needs an explicit count if we want to access
> it locklessly. And you already said you didn't like that this is the
> only state not derived purely from the task counters, so maybe this is
> the way to go after all.
> 
> How about something like this (untested)?


> +static inline void psi_switch(struct rq *rq, struct task_struct *prev,
> +			      struct task_struct *next)
> +{
> +	if (psi_disabled)
> +		return;
> +
> +	if (unlikely(prev->flags & PF_MEMSTALL))
> +		psi_task_change(prev, rq_clock(rq), TSK_RECLAIMING, 0);
> +	if (unlikely(next->flags & PF_MEMSTALL))
> +		psi_task_change(next, rq_clock(rq), 0, TSK_RECLAIMING);
> +}


Urgh... can't say I really like that.

I would really rather do that scheduler_tick() thing to avoid the remote
update. The tick is a lot less hot than the switch path and esp.
next->flags might be a cold line (prev->flags is typically the same line
as prev->state so we already have that, but I don't think anybody now
looks at next->flags or its line, so that'd be cold load).
