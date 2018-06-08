Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ktkhJ11ZGlsNXAAAmS7hNA
	; Fri, 08 Jun 2018 10:24:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2577B606FA; Fri,  8 Jun 2018 10:24:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BA33260590;
	Fri,  8 Jun 2018 10:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA33260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeFHKYw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:24:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53918 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeFHKYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:24:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id x6-v6so2419180wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 03:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XEpANGmuzWbehI5ia5/9Fl7yF+AKc3lPpM4oM3T5B1A=;
        b=kedBVNJDlEVZTOC3g+bR8Dxg55jGWulDA1wc2bjD9VnNWGsofvTI24SUjmxq/Shh/b
         lZuYq7gJ1y/1yJLRxDnCtGpA6llc0fMQfL51e23MTXk562aHXRiAh6Nq8Q5IT0DSy772
         pRxqF5bd+VApOHdsLZYkU5JcFVP1ru8DO9v5G9itodaJhqb7BuH0Hph2TUY8NcEreQqH
         /WJ3upwmiIjk5Xb+6NF4x94gT95S6YteLIPjxA5DaGWQEpVNhSeMq+u3m2LHDcRs6EeV
         SmJl2JIpAZcWch/Iz5WRR5khEwFwOIN2sRVvvClwf0NUbFV28VpELq1IFxjm0OPrMNag
         Vq9A==
X-Gm-Message-State: APt69E2MWw5zSithLEW2WZunYZRDUtnZ17eHiPrLPcOyyu8UqyoOfwD0
        q/q6T9pd53IpwOxZKcyTdgVB4w==
X-Google-Smtp-Source: ADUXVKKV7EmmJdF3UGQtTWCesz4TihBKTlF83D/Ze6yrahG3vPTOYlxWymaI6Pc8N70fMGJbOtBWhw==
X-Received: by 2002:a1c:b2d0:: with SMTP id b199-v6mr1095591wmf.108.1528453489940;
        Fri, 08 Jun 2018 03:24:49 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id v25-v6sm859839wmh.43.2018.06.08.03.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 03:24:48 -0700 (PDT)
Date: Fri, 8 Jun 2018 12:24:46 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joelaf@google.com, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 09/10] sched/fair: Select an energy-efficient CPU
 on task wake-up
Message-ID: <20180608102446.GE658@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-10-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-10-quentin.perret@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/05/18 15:25, Quentin Perret wrote:

[...]

> +static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> +{
> +	unsigned long cur_energy, prev_energy, best_energy, cpu_cap, task_util;
> +	int cpu, best_energy_cpu = prev_cpu;
> +	struct sched_energy_fd *sfd;
> +	struct sched_domain *sd;
> +
> +	sync_entity_load_avg(&p->se);
> +
> +	task_util = task_util_est(p);
> +	if (!task_util)
> +		return prev_cpu;
> +
> +	/*
> +	 * Energy-aware wake-up happens on the lowest sched_domain starting
> +	 * from sd_ea spanning over this_cpu and prev_cpu.
> +	 */
> +	sd = rcu_dereference(*this_cpu_ptr(&sd_ea));
> +	while (sd && !cpumask_test_cpu(prev_cpu, sched_domain_span(sd)))
> +		sd = sd->parent;
> +	if (!sd)
> +		return -1;

Shouldn't this be return prev_cpu?

> +
> +	if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
> +		prev_energy = best_energy = compute_energy(p, prev_cpu);
> +	else
> +		prev_energy = best_energy = ULONG_MAX;
> +
> +	for_each_freq_domain(sfd) {
> +		unsigned long spare_cap, max_spare_cap = 0;
> +		int max_spare_cap_cpu = -1;
> +		unsigned long util;
> +
> +		/* Find the CPU with the max spare cap in the freq. dom. */

I undestand this being a heuristic to cut some overhead, but shouldn't
the model tell between packing vs. spreading?

Thanks,

 -Juri
