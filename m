Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0536C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9552089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y3+8Q7Fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9552089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbeGIMCN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:02:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52118 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754475AbeGIMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WdwxYOOqHukeqDKuuSDwuBritD59EzgJzVrzckMW3ss=; b=Y3+8Q7FnA+5e6vbdfmAs5j93l
        hdCp2m/EQhDKE7Cgke/Q/tn56HSbaJatH9nES2IcM/szbmSSJ+CQkj59xReNObgdD3CG1mFbkknKF
        AsOFsAJfMdskgens9Hvb/m8IqakDS4TK9ufENI7aP/19Cbuwh1nWQQwqaeeLulXn7blzpFJxXtk+S
        jMgu5KCjnF+lFy8u7m0LJ7D36Ta4q21zvpLpZlwz74biFultbsEwsiordZEmH0Umb4njPXV52EXGp
        MfbjiYXmV4KH1s5TrqHS+BXFTf+ZaH74qcNZj0Ij0SizahCas4p9K1C4DjK2nY5XVn0TLifDubMJz
        OL4JDoomg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcUrN-0008Fu-Bs; Mon, 09 Jul 2018 12:01:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8D892029764D; Mon,  9 Jul 2018 14:01:38 +0200 (CEST)
Date:   Mon, 9 Jul 2018 14:01:38 +0200
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
Message-ID: <20180709120138.GQ2494@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
 <20180706131243.GV2458@hirez.programming.kicks-ass.net>
 <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
 <20180706154949.GO2494@hirez.programming.kicks-ass.net>
 <20180706170443.GE17577@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706170443.GE17577@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 06:04:44PM +0100, Quentin Perret wrote:
> 'max_util' is basically the util we use to request an OPP. 'sum_util' is
> how long the CPUs will be running.

A indeed. But yes bit of a mess, but it wants doing I think.
Perhaps a little something like the below... The alternative is two
separate but closely related functions, not sure which is better.


enum schedutil_type {
	frequency_util,
	energy_util,
};

unsigned long
schedutil_freq_util(int cpu, unsigned long util_cfs, enum schedutil_type type)
{
	struct rq *rq = cpu_rq(cpu);
	unsigned long util, irq, max;

	max = arch_scale_cpu_capacity(NULL, cpu);

	if (type == frequency_util && rt_rq_is_runnable(&rq->rt))
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

	if (type == frequency_util) {
		/*
		 * For frequency selection we do not make cpu_util_dl()
		 * a permanent part of this sum because we want to use
		 * cpu_bw_dl() later on, but we need to check if the
		 * CFS+RT+DL sum is saturated (ie. no idle time) such
		 * that we select f_max when there is no idle time.
		 *
		 * NOTE: numerical errors or stop class might cause us
		 * to not quite hit saturation when we should --
		 * something for later.
		 */
		if ((util + cpu_util_dl(rq)) >= max)
			return max;
	} else {
		/*
		 * OTOH, for energy computation we need the estimated
		 * running time, so include util_dl and ignore dl_bw.
		 */
		util += cpu_util_dl(rq);
		if (util >= max)
			return max;
	}

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

	if (type == frequency_util) {
		/*
		 * Bandwidth required by DEADLINE must always be granted
		 * while, for FAIR and RT, we use blocked utilization of
		 * IDLE CPUs as a mechanism to gracefully reduce the
		 * frequency when no tasks show up for longer periods of
		 * time.
		 *
		 * Ideally we would like to set bw_dl as min/guaranteed
		 * freq and util + bw_dl as requested freq. However,
		 * cpufreq is not yet ready for such an interface. So,
		 * we only do the latter for now.
		 */
		util += cpu_bw_dl(rq);
	}

	return min(max, util);
}
