Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFFBC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD6F218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ehsh4xTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfAXPbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:31:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfAXPbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h8Wow38e1xWfn2ravzm+XKlFiamZ5hDUdxW/qYXbZzA=; b=ehsh4xTg9s2QQ6E3xW4Gq5f1t
        Mw2n/Y1on1l+kqzKNLErDRsWUwHrKxOOcN4LWwbYmrEKBmitlelKF6+jT6O2BB/qYefK6sR2m+ymu
        nwKcvX8K4xidlT0Y6iBtB05Hwvjwac4BI0pdtFuBsuTkqsxBlk85yTAx+lcqYWDxUtws4Pdt2vWaT
        HXI4Na0TjIhYEoh5LFkwv24vmtUSJqM2k9U98EANJo0LKVK47M/2uQEM3JsJIuobUIrU5ZdeQPLkv
        i3r+tTN1cPmV8ymc3ILp9tOd9Cb+DGkn3aP41EPLSmRdTrt8CGkzjrt1wCk2PEb0iDgj12YEy55lu
        wnEXER9zQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmgyC-0003pw-Aw; Thu, 24 Jan 2019 15:31:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8EA7420D1512D; Thu, 24 Jan 2019 16:31:06 +0100 (CET)
Date:   Thu, 24 Jan 2019 16:31:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 09/16] sched/cpufreq: uclamp: Add utilization clamping
 for RT tasks
Message-ID: <20190124153106.GQ13777@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-10-patrick.bellasi@arm.com>
 <20190123104944.GX27931@hirez.programming.kicks-ass.net>
 <20190123144011.iid3avb63r5v4r2c@e110439-lin>
 <20190123201146.GH17749@hirez.programming.kicks-ass.net>
 <20190124123009.2yulcf25ld66popd@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124123009.2yulcf25ld66popd@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 12:30:09PM +0000, Patrick Bellasi wrote:
> > So I'll have to go over the code again, but I'm wondering why you're
> > changing uclamp_se::bucket_id on a runnable task.
> 
> We change only the "requested" value, not the "effective" one.
> 
> > Ideally you keep bucket_id invariant between enqueue and dequeue; then
> > dequeue knows where we put it.
> 
> Right, that's what we do for the "effective" value.

So the problem I have is that you first introduce uclamp_se::value and
use that all over the code, and then introduce effective and change all
the usage sites.

That seems daft. Why not keep all the code as-is and add orig_value.

> > Now I suppose actually determining bucket_id is 'expensive' (it
> > certainly is with the whole mapping scheme, but even that integer
> > division is not nice), so we'd like to precompute the bucket_id.
> 
> Yes, although the complexity is mostly in the composition logic
> described above not on mapping at all. We have "mapping" overheads
> only when we change a "request" value and that's from slow-paths.

It's weird though. Esp. when combined with that mapping logic, because
then you get to use additional maps that are not in fact ever used.

> > We can update uclamp_se::value and set uclamp_se::changed, and then the
> > next enqueue will (unlikely) test-and-clear changed and recompute the
> > bucket_id.
> 
> This mean will lazy update the "requested" bucket_id by deferring its
> computation at enqueue time. Which saves us a copy of the bucket_id,
> i.e. we will have only the "effective" value updated at enqueue time.
> 
> But...
> 
> > Would that not be simpler?
> 
> ... although being simpler it does not fully exploit the slow-path,
> a syscall which is usually running from a different process context
> (system management software).
> 
> It also fits better for lazy updates but, in the cgroup case, where we
> wanna enforce an update ASAP for RUNNABLE tasks, we will still have to
> do the updates from the slow-path.
> 
> Will look better into this simplification while working on v7, perhaps
> the linear mapping can really help in that too.

OK. So mostly my complaint is that it seems to do things odd for ill
explained reasons.
