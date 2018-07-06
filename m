Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434D4C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2AF23F9C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hA78WjOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2AF23F9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933413AbeGFPu2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:50:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50052 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932849AbeGFPu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dfY3oivKMcBdVLctdyJthSVHwUQTF8aaODT32hJl/R8=; b=hA78WjOBHttUg3gG923j7JG1f
        JJAjsOcl8oVeJPefSrLreT5ua8ZTnNjTQDae630m8K0gZGHM06qjQ9cUqr0dJ0hK9A8WawO4cG7OE
        NgUPQY+2Pc2325lgr1FJQjk2y7LCmKVSEpnZ6M5CdRoF02Jm9XUdXst4D1Rq+PcimarYkIjQhuVKs
        hMLk1+W34sifoNoUiG1wXfOTclkvaaJ07BtUeOgmmJXHFzFdKXg5PudGYsDw2IJZIUhaEgOT+n7VQ
        Ansic9InkLqGxNNsrPk4r3oTDJ5mA6Ww5u2u08ojWhzJt+fCOiQhFC2trcxSg4IWF1k4yUtpSgSg0
        Nny7qHz9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbSzX-0002zW-Ll; Fri, 06 Jul 2018 15:49:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B7592028932D; Fri,  6 Jul 2018 17:49:49 +0200 (CEST)
Date:   Fri, 6 Jul 2018 17:49:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180706154949.GO2494@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
 <20180706131243.GV2458@hirez.programming.kicks-ass.net>
 <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 04:12:12PM +0100, Quentin Perret wrote:
> On Friday 06 Jul 2018 at 15:12:43 (+0200), Peter Zijlstra wrote:

> > Did you want to use sugov_get_util() here? There is no way we're going
> > to duplicate all that.
> 
> I need to look into how we can do that ... Sugov looks at the current
> util landscape while EAS tries to predict the _future_ util landscape.
> Merging the two means I need to add a task and a dst_cpu as parameters
> of sugov_get_util() and call cpu_util_next() from there, which doesn't
> feel so clean ...

Just pass in the util_cfs as computed by cpu_util_next(), then schedutil
will pass in cpu_util_cfs(), the rest is all the same I think.

See below.

> Also, if we merge sugov_get_util() and sugov_aggregate_util() with
> Vincent's patch-set I'll need to make sure to return two values with
> sugov_get_util(): 1) the sum of the util of all classes; and 2) the util
> that will be used to request an OPP. 1) should be used in sum_util and
> 2) could (but I don't think it's is a good idea) be used for max_util.

I am confused, the max/sum thing is composed of the same values, just a
different operator. Both take 'util':


+	util = schedutil_get_util(cpu, cpu_util_next(cpu, p, dst_cpu))
+	max_util = max(util, max_util);
+	sum_util += util;


unsigned long schedutil_get_util(int cpu, unsigned long util_cfs)
{
	struct rq *rq = cpu_rq(cpu);
	unsigned long util, irq, max;

	max = arch_scale_cpu_capacity(NULL, cpu);

	if (rt_rq_is_runnable(&rq->rt))
		return max;

	/*
	 * Early check to see if IRQ/steal time saturates the CPU, can be
	 * because of inaccuracies in how we track these -- see
	 * update_irq_load_avg().
	 */
	irq = cpu_util_irq(rq);
	if (unlikely(irq >= max))
		return max;

	/*
	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
	 * CFS tasks and we use the same metric to track the effective
	 * utilization (PELT windows are synchronized) we can directly add them
	 * to obtain the CPU's actual utilization.
	 */
	util = util_cfs;
	util += cpu_util_rt(rq);

	/*
	 * We do not make cpu_util_dl() a permanent part of this sum because we
	 * want to use cpu_bw_dl() later on, but we need to check if the
	 * CFS+RT+DL sum is saturated (ie. no idle time) such that we select
	 * f_max when there is no idle time.
	 *
	 * NOTE: numerical errors or stop class might cause us to not quite hit
	 * saturation when we should -- something for later.
	 */
	if ((util + cpu_util_dl(rq)) >= max)
		return max;

	/*
	 * There is still idle time; further improve the number by using the
	 * irq metric. Because IRQ/steal time is hidden from the task clock we
	 * need to scale the task numbers:
	 *
	 *              1 - irq
	 *   U' = irq + ------- * U
	 *                max
	 */
	util *= (max - irq);
	util /= max;
	util += irq;

	/*
	 * Bandwidth required by DEADLINE must always be granted while, for
	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
	 * to gracefully reduce the frequency when no tasks show up for longer
	 * periods of time.
	 *
	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
	 * an interface. So, we only do the latter for now.
	 */
	return min(max, util + cpu_bw_dl(rq));
}
