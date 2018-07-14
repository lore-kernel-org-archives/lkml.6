Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0571ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 09:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CCE20873
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 09:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qX5TwQU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CCE20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeGNJVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 05:21:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeGNJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 05:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DjX+vA0IobqjWniEWexVFNFhaNudjWnwNFHbmpTAbLY=; b=qX5TwQU+PVNWBKxA80Ffz56yc
        GZYlxBHBVHTxiiyMFbEJHKKEkuxW31ZTNyvkfD1HF9Cd7Ukct6YTCnVoMFymNZ+R9euH8mb2pT0PR
        rvZuraM50urQQtpxiRHr3cfkmgfBx73oISZHijxnuIFWDP7Fhc7eMZd7KwDpszO/vy7dynXux0ULR
        HhK3+5UoEzTVE+tj+ucFlYUeVm46CRIF+oi/TpXNwCaOcklovHKdvTCluWOB/mJqe+U94f3eWO8S9
        pxrwRWQX9mL+16zXaiGPoNTEpwNPVHo8gVCSUH0rC7SUTC71Q8fr2ovN6EMvOShtg+Iy4Md1E1Ijm
        V35QtwTXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1feGRy-0002DN-U4; Sat, 14 Jul 2018 09:02:47 +0000
Received: by worktop (Postfix, from userid 1000)
        id CD22D6E093E; Sat, 14 Jul 2018 11:02:44 +0200 (CEST)
Date:   Sat, 14 Jul 2018 11:02:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180714090244.GC4920@worktop.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180713092153.GU2494@hirez.programming.kicks-ass.net>
 <20180713161756.GA21168@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713161756.GA21168@cmpxchg.org>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 12:17:56PM -0400, Johannes Weiner wrote:
> On Fri, Jul 13, 2018 at 11:21:53AM +0200, Peter Zijlstra wrote:
> > On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> > > +static inline void psi_ttwu_dequeue(struct task_struct *p)
> > > +{
> > > +	if (psi_disabled)
> > > +		return;
> > > +	/*
> > > +	 * Is the task being migrated during a wakeup? Make sure to
> > > +	 * deregister its sleep-persistent psi states from the old
> > > +	 * queue, and let psi_enqueue() know it has to requeue.
> > > +	 */
> > > +	if (unlikely(p->in_iowait || (p->flags & PF_MEMSTALL))) {
> > > +		struct rq_flags rf;
> > > +		struct rq *rq;
> > > +		int clear = 0;
> > > +
> > > +		if (p->in_iowait)
> > > +			clear |= TSK_IOWAIT;
> > > +		if (p->flags & PF_MEMSTALL)
> > > +			clear |= TSK_MEMSTALL;
> > > +
> > > +		rq = __task_rq_lock(p, &rf);
> > > +		update_rq_clock(rq);
> > > +		psi_task_change(p, rq_clock(rq), clear, 0);
> > > +		p->sched_psi_wake_requeue = 1;
> > > +		__task_rq_unlock(rq, &rf);
> > > +	}
> > > +}
> > 
> > Still NAK, what happened to this here:

> That's my thought process, anyway. I'd be more than happy to make this
> more lightweight, but I don't see a way to do it without losing
> significant functional precision.

I think you're going to have to. We put a lot of effort into not taking
the old rq->lock on remote wakeups and got a significant performance
benefit from that.

You just utterly destroyed that for workloads with a high number of
iowait wakeups.
