Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEFEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A743B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A743B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437713AbeKWCFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:05:39 -0500
Received: from foss.arm.com ([217.140.101.70]:52110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731109AbeKWCFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:05:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E1BDA78;
        Thu, 22 Nov 2018 07:25:49 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 853F13F575;
        Thu, 22 Nov 2018 07:25:45 -0800 (PST)
Date:   Thu, 22 Nov 2018 15:25:40 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [PATCH v9 09/15] sched: Introduce sched_energy_present static key
Message-ID: <20181122152538.jvgh3uvuo5a6lfs7@queper01-lin>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-10-quentin.perret@arm.com>
 <20181121130822.GE2113@hirez.programming.kicks-ass.net>
 <20181121151444.t3zye5l5iycfni2s@queper01-lin>
 <20181122091715.6kvhcbgoqrd54nbs@queper01-lin>
 <20181122093237.goxmr4p5l4h2izid@queper01-lin>
 <20181122102545.GQ2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122102545.GQ2131@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 Nov 2018 at 11:25:45 (+0100), Peter Zijlstra wrote:
> On Thu, Nov 22, 2018 at 09:32:39AM +0000, Quentin Perret wrote:
> > Hmm, I went too fast, that's totally broken. But there's still something
> > we can do with static_branch_{inc,dec} I think. I'll come back later
> > with a better solution.
> 
> Right; if you count the rd's that have pd set, it should work-ish. Yes,
> much cleaner if you can get it to work.

So, I came up with the following code which seems to work OK. It's not
as I clean as I'd like, though. The fact that free_pd() can be called in
softirq context is annoying to manipulate the static key ...

An alternative to this work item workaround is to do static_branch_dec()
from build_perf_domains() and next to the three call sites of
free_rootdomain() in order to avoid the call_rcu() context. Not very
pretty either.

Or we can just stick with your original suggestion to carry a boolean
around.

Any preference ?

Thanks,
Quentin

--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -232,7 +232,7 @@ int sched_energy_aware_handler(struct ctl_table *table, int write,
 }
 #endif

-static void free_pd(struct perf_domain *pd)
+static void _free_pd(struct perf_domain *pd)
 {
        struct perf_domain *tmp;

@@ -243,6 +243,24 @@ static void free_pd(struct perf_domain *pd)
        }
 }

+static void dec_sched_energy_workfn(struct work_struct *work)
+{
+       static_branch_dec(&sched_energy_present);
+}
+static DECLARE_WORK(dec_sched_energy_work, dec_sched_energy_workfn);
+
+static void free_pd(struct perf_domain *pd)
+{
+       if (pd) {
+               /*
+                * XXX: The static key can't be modified from SOFTIRQ context,
+                * so do it using a work item.
+                */
+               schedule_work(&dec_sched_energy_work);
+               _free_pd(pd);
+       }
+}
+
 static struct perf_domain *find_pd(struct perf_domain *pd, int cpu)
 {
        while (pd) {
@@ -421,13 +410,14 @@ static void build_perf_domains(const struct cpumask *cpu_map)
        /* Attach the new list of performance domains to the root domain. */
        tmp = rd->pd;
        rcu_assign_pointer(rd->pd, pd);
+       static_branch_inc_cpuslocked(&sched_energy_present);
        if (tmp)
                call_rcu(&tmp->rcu, destroy_perf_domain_rcu);

        return;

 free:
-       free_pd(pd);
+       _free_pd(pd);
        tmp = rd->pd;
        rcu_assign_pointer(rd->pd, NULL);
        if (tmp)
@@ -2246,7 +2236,6 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 match3:
                ;
        }
-       sched_energy_start(ndoms_new, doms_new);
 #endif

        /* Remember the new sched domains: */


