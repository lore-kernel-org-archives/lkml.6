Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25803C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5682075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XiY0iWCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5682075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbeIGRgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:36:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbeIGRgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uGlsiIycJ0dvn9XAAii1VUSmpffVIgJru/y83Jg6K5c=; b=XiY0iWCZ4J+joMB5wjxWFS8l3g
        ZuD2oBlh9Q/WXiZvIIiXeZhyRAlFTNnwj1EguXcw0Z74yznALdypo7Bhqw0qpg+zgUyWP1+wEwfPk
        5cUOFXkaoSua/zM8e6CuLkOsI2vKB4H3ito8j17wb0yj/3XyRMEuyD6Byl34SIgFfkUTPRRAB+d05
        pyjq2p6CThNToDHaIaMylDR7dyMLqMGj8R+5aR0wOWB+MbZzaZhzoVI2cTkfPVB7CVQljS/W0XjAQ
        Fccw+AvkpEgY0eukZEBUctUY+r0t2E2s0SkYmYIap3PbdFj/YgFCuJEvYZBqA8sQ5irp0OzTV5dFk
        ZL0eGuzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyGIm-0005O5-HO; Fri, 07 Sep 2018 12:55:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D057320593806; Fri,  7 Sep 2018 14:55:54 +0200 (CEST)
Date:   Fri, 7 Sep 2018 14:55:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, jhugo@codeaurora.org
Subject: Re: [PATCH] sched/fair: fix load_balance redo for null imbalance
Message-ID: <20180907125554.GA24106@hirez.programming.kicks-ass.net>
References: <1536306664-29827-1-git-send-email-vincent.guittot@linaro.org>
 <20180907113748.GV24106@hirez.programming.kicks-ass.net>
 <20180907123551.GA9955@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907123551.GA9955@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 02:35:51PM +0200, Vincent Guittot wrote:
> Le Friday 07 Sep 2018 à 13:37:49 (+0200), Peter Zijlstra a écrit :
> > On Fri, Sep 07, 2018 at 09:51:04AM +0200, Vincent Guittot wrote:
> > > It can happen that load_balance finds a busiest group and then a busiest rq
> > > but the calculated imbalance is in fact null.
> > 
> > Cute. Does that happen often?
> 
> I have a use case with RT tasks that reproduces the problem regularly.
> It happens at least when we have CPUs with different capacity either because
> of heterogeous CPU or because of RT/DL reducing available capacity for cfs
> I have put the call path that trigs the problem below and accroding to the
> comment it seems that we can reach similar state when playing with priority.
> 
> > 
> > > If the calculated imbalance is null, it's useless to try to find a busiest
> > > rq as no task will be migrated and we can return immediately.
> > > 
> > > This situation can happen with heterogeneous system or smp system when RT
> > > tasks are decreasing the capacity of some CPUs.
> > 
> > Is it the result of one of those "force_balance" conditions in
> > find_busiest_group() ? Should we not fix that to then return NULL
> > instead?
> 
> The UC is:
> We have a newly_idle load balance that is triggered when RT task becomes idle
> ( but I think that I have seen that with idle load balance too)
> 
> we trigs:
> 	if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> 	    busiest->group_no_capacity)
> 		goto force_balance;
> 
> In calculate_imbalance we use the path
> 	/*
> 	 * Avg load of busiest sg can be less and avg load of local sg can
> 	 * be greater than avg load across all sgs of sd because avg load
> 	 * factors in sg capacity and sgs with smaller group_type are
> 	 * skipped when updating the busiest sg:
> 	 */
> 	if (busiest->avg_load <= sds->avg_load ||
> 	    local->avg_load >= sds->avg_load) {
> 		env->imbalance = 0;
> 		return fix_small_imbalance(env, sds);
> 	}
> 
> but fix_small_imbalance finally decides to return without modifying imbalance
> like here
> 	if (busiest->avg_load + scaled_busy_load_per_task >=
> 	    local->avg_load + (scaled_busy_load_per_task * imbn)) {
> 		env->imbalance = busiest->load_per_task;
> 		return;
> 	}

That one actually does modify imbalance :-) But I get your point.

> Beside this patch, I'm preparing another patch in fix small imbalance to
> ensure 1 task per CPU in similar situation but according to the comment above,
> we can reach this situation because of tasks priority

Didn't we all hate fix_small_imbalance() ?

Anyway, I think I'd prefer something like the below; although it might
be nicer to thread the return value through calculate_imbalance() and
fix_small_imbalance(), but looking at them that's not going to be
particularly nicer.

Do you agree with this?, If so, I'll stick your orignal Changelog on it
and pretend this is what you send me :-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b39fb596f6c1..0596a29f3d2a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8269,7 +8269,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 force_balance:
 	/* Looks like there is an imbalance. Compute it */
 	calculate_imbalance(env, &sds);
-	return sds.busiest;
+	return env->imbalance ? sds.busiest : NULL;
 
 out_balanced:
 	env->imbalance = 0;
