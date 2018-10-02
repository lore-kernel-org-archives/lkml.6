Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA83C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858012064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X5Egk+pH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858012064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJBTJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:09:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52878 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeJBTJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SjfZfWAN4+vE6Rw52dmOybXONNGw7izx52NzzbebXBo=; b=X5Egk+pHKnv+5lqdE/mXxRHlo
        tzzU/xMMWUMhbodKfX8gyOqE0TsgSsgHtzuZEM7G2uOJRe5ACYPMqehLtc/g16av8Q1HoxxfI2ffJ
        BAMJ+vCsGFk1Q5KuD71qzUkM2bPXhTG1fLvXl60bzXkpiUjcT30r2vbr8VXI8j0LYV315fsEG6ijA
        3nOaokwTSb3YSed+81hZhwsKai2j8OHk4FHYKulO0sio6nMkjHvY+TEKf4s4xuK/AC0AgORqXcvDH
        9zJfUxAqwfv6uwtlVZ2yyed4xyn3l6gwXcQNmuc2pEL7drmzzcBryKlx4MYizAy3P0lGz2oX3Wyda
        o8UN1niYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7Jk9-0004w5-CT; Tue, 02 Oct 2018 12:25:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04BAE2025A349; Tue,  2 Oct 2018 14:25:36 +0200 (CEST)
Date:   Tue, 2 Oct 2018 14:25:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v7 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20181002122535.GY3439@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912091309.7551-4-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:12:58AM +0100, Quentin Perret wrote:
> +/**
> + * em_pd_energy() - Estimates the energy consumed by the CPUs of a perf. domain
> + * @pd		: performance domain for which energy has to be estimated
> + * @max_util	: highest utilization among CPUs of the domain
> + * @sum_util	: sum of the utilization of all CPUs in the domain
> + *
> + * Return: the sum of the energy consumed by the CPUs of the domain assuming
> + * a capacity state satisfying the max utilization of the domain.
> + */
> +static inline unsigned long em_pd_energy(struct em_perf_domain *pd,
> +				unsigned long max_util, unsigned long sum_util)
> +{
> +	unsigned long freq, scale_cpu;
> +	struct em_cap_state *cs;
> +	int i, cpu;
> +
> +	/*
> +	 * In order to predict the capacity state, map the utilization of the
> +	 * most utilized CPU of the performance domain to a requested frequency,
> +	 * like schedutil.
> +	 */
> +	cpu = cpumask_first(to_cpumask(pd->cpus));
> +	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> +	cs = &pd->table[pd->nr_cap_states - 1];
> +	freq = map_util_freq(max_util, cs->frequency, scale_cpu);
> +
> +	/*
> +	 * Find the lowest capacity state of the Energy Model above the
> +	 * requested frequency.
> +	 */
> +	for (i = 0; i < pd->nr_cap_states; i++) {
> +		cs = &pd->table[i];
> +		if (cs->frequency >= freq)
> +			break;
> +	}
> +
> +	/*
> +	 * The capacity of a CPU in the domain at that capacity state (cs)
> +	 * can be computed as:
> +	 *
> +	 *             cs->freq * scale_cpu
> +	 *   cs->cap = --------------------                          (1)
> +	 *                 cpu_max_freq
> +	 *
> +	 * So, the energy consumed by this CPU at that capacity state is:
> +	 *
> +	 *             cs->power * cpu_util
> +	 *   cpu_nrg = --------------------                          (2)
> +	 *                   cs->cap
> +	 *
> +	 * since 'cpu_util / cs->cap' represents its percentage of busy time.
> +	 *
> +	 *   NOTE: Although the result of this computation actually is in
> +	 *         units of power, it can be manipulated as an energy value
> +	 *         over a scheduling period, since it is assumed to be
> +	 *         constant during that interval.
> +	 *
> +	 * By injecting (1) in (2), 'cpu_nrg' can be re-expressed as a product
> +	 * of two terms:
> +	 *
> +	 *             cs->power * cpu_max_freq   cpu_util
> +	 *   cpu_nrg = ------------------------ * ---------          (3)
> +	 *                    cs->freq            scale_cpu
> +	 *
> +	 * The first term is static, and is stored in the em_cap_state struct
> +	 * as 'cs->cost'.
> +	 *
> +	 * Since all CPUs of the domain have the same micro-architecture, they
> +	 * share the same 'cs->cost', and the same CPU capacity. Hence, the
> +	 * total energy of the domain (which is the simple sum of the energy of
> +	 * all of its CPUs) can be factorized as:
> +	 *
> +	 *            cs->cost * \Sum cpu_util
> +	 *   pd_nrg = ------------------------                       (4)
> +	 *                  scale_cpu
> +	 */
> +	return cs->cost * sum_util / scale_cpu;
> +}

Should we explicitly mention that this ignores idle costs?
