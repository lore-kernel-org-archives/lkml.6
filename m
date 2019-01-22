Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEEDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D755A20855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hRlytScT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfAVN2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:28:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60102 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfAVN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oaCtCQ6kT+by/muHzdDYBJDKqa8IRmfEauxvMMTSVZk=; b=hRlytScTE44qPk9wpY/NS5oJx
        d/uSvL+++Xynwf9V61OYBDeoG5zitCKJpc9imtTFLA1Rbdg/ckocKlJsUpMvVtFj95KsuifrTj6wL
        tah3begys5mED55FbfbIZOS6yWL3f6DP9UwKDr23NJa48SxU1NDDVQ9xPJapmDN0y6XJSZHxWg7qt
        pdwjnN7zol6zcYtw39P2tq262gxqv6JHYcvRB/Gj/jsc+ARJxnNLrE68Cjao08pyfRh+CfB5YL+92
        i3K/qvdIaSKS5VR4JGhrF8jMpFkb50/3ApPKNRdh9gka9NRKlUjRDyu/kHcsJMiRFsD4ihFFWwpZm
        e2qKEZI8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glw6G-0001i0-37; Tue, 22 Jan 2019 13:28:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B1F82042CFC3; Tue, 22 Jan 2019 14:28:17 +0100 (CET)
Date:   Tue, 22 Jan 2019 14:28:17 +0100
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
Subject: Re: [PATCH v6 05/16] sched/core: uclamp: Update CPU's refcount on
 clamp changes
Message-ID: <20190122132817.GG13777@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-6-patrick.bellasi@arm.com>
 <20190121153308.GL27931@hirez.programming.kicks-ass.net>
 <20190121154412.fak2t2iquj3aixtu@e110439-lin>
 <20190122093704.GM27931@hirez.programming.kicks-ass.net>
 <20190122104305.6vjx37muqsxm536t@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122104305.6vjx37muqsxm536t@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:43:05AM +0000, Patrick Bellasi wrote:
> On 22-Jan 10:37, Peter Zijlstra wrote:

> > Sure, I get that. What I don't get is why you're adding that (2) here.
> > Like said, __sched_setscheduler() already does a dequeue/enqueue under
> > rq->lock, which should already take care of that.
> 
> Oh, ok... got it what you mean now.
> 
> With:
> 
>    [PATCH v6 01/16] sched/core: Allow sched_setattr() to use the current policy
>    <20190115101513.2822-2-patrick.bellasi@arm.com>
> 
> we can call __sched_setscheduler() with:
> 
>    attr->sched_flags & SCHED_FLAG_KEEP_POLICY
> 
> whenever we want just to change the clamp values of a task without
> changing its class. Thus, we can end up returning from
> __sched_setscheduler() without doing an actual dequeue/enqueue.

I don't see that happening.. when KEEP_POLICY we set attr.sched_policy =
SETPARAM_POLICY. That is then checked again in __setscheduler_param(),
which is in the middle of that dequeue/enqueue.

Also, and this might be 'broken', SETPARAM_POLICY _does_ reset all the
other attributes, it only preserves policy, but it will (re)set nice
level for example (see that same function).

So maybe we want to introduce another (few?) FLAG_KEEP flag(s) that
preserve the other bits; I'm thinking at least KEEP_PARAM and KEEP_UTIL
or something.

