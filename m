Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A51AC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FD420849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TbehcRkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FD420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeLMNMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:12:20 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48194 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbeLMNMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jK0bViSbpcwPDbuVIf+YwUM1I/uuWFKqioh3ePZh5v8=; b=TbehcRkXOP/CoSU8x9Wo/iFRd
        v5t42UwuUzTQIxXJkjApbzxmjAdHfEweqOi1UvTCww3NbPWARy3pKPQ8TydEpcKQWqg8yV8ZYiFAM
        gYlmvN3TtWl1Spq/AsvK8iMQL7jizOCzr+bybcDIsMY/O2/zTT0f/CGpt5t9CymVn1GQptkTgs2c/
        vcqjmgygACdT7xBNF6LsPNmOhCWe3MUP4c9I7DBWdyZtpA6YAvg5rvAkttFGIHgIvcX34ZFXH/uP0
        I45KQf7owHe+vWpktSFVQ7PRzZF/tVYYn0W0Zodph6HtYHy3FvGvRkMksJ5J3lxn4LSuFUoyl6fcL
        RNGbjlD+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXQmj-0004DK-DH; Thu, 13 Dec 2018 13:12:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B5B1207264E8; Thu, 13 Dec 2018 14:12:11 +0100 (CET)
Date:   Thu, 13 Dec 2018 14:12:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Subject: Re: [PATCH v2] sched/fair: fix 1 task per CPU
Message-ID: <20181213131211.GK2237@hirez.programming.kicks-ass.net>
References: <1536590589-437-1-git-send-email-vincent.guittot@linaro.org>
 <20181213104439.GG5289@hirez.programming.kicks-ass.net>
 <CAKfTPtBG_gcWzi4RUWF_c2aazqxDPHbb2rGWHvWND6pQHQxPGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBG_gcWzi4RUWF_c2aazqxDPHbb2rGWHvWND6pQHQxPGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 12:04:20PM +0100, Vincent Guittot wrote:
> On Thu, 13 Dec 2018 at 11:44, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Sep 10, 2018 at 04:43:09PM +0200, Vincent Guittot wrote:
> > > When CPUs have different capacity because of RT/DL tasks or
> > > micro-architecture or max frequency differences, there are situation where
> > > the imbalance is not correctly set to migrate waiting task on the idle CPU.
> > >
> > > The UC uses the force_balance case:
> > >
> > >       if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> > >           busiest->group_no_capacity)
> > >               goto force_balance;
> > >
> > > But calculate_imbalance fails to set the right amount of load to migrate
> > > a task because of the special condition:
> > >
> > >   busiest->avg_load <= sds->avg_load || local->avg_load >= sds->avg_load)
> > >
> > > Add in fix_small_imbalance, this special case that triggered the force
> > > balance in order to make sure that the amount of load to migrate will be
> > > enough.
> >
> > So I think this patch is going in the wrong direction for a number of
> > reasons:
> >
> >  - we'd like to get rid of fix_small_imbalance(), and this adds to it;
> >
> >  - the whole load_per_task stuff is terminally broken, it _cannot_ work
> >    right.
> >
> >
> > What I've suggested in the past is parameterizing the load balancer and
> > picking different criteria to balance on:
> 
> This patch is clearly a fix of the current implementation.
> What you suggest below makes sense but implies a significant rework in
> the calculate_imbalance and the load_balancer in general and will need
> more time to reach a stable state.
> Nevertheless, I will have a look at that
> 
> I imagine that your feedback for https://lkml.org/lkml/2018/10/2/283
> will be the same ?

No; those actually look ok. It is mostly that I really don't think
load_per_task makes any kind of sense.

It sorta works when all tasks are of the same weight, but if you start
using nice -- or way worse, cgroups -- then the number is complete
bollocks.
