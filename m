Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE738C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF0A2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF0A2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbeH2UU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:20:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57746 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbeH2UU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:20:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D1F015BF;
        Wed, 29 Aug 2018 09:22:45 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C8C53F557;
        Wed, 29 Aug 2018 09:22:40 -0700 (PDT)
Date:   Wed, 29 Aug 2018 17:22:38 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v6 05/14] sched/topology: Reference the Energy Model of
 CPUs when available
Message-ID: <20180829162238.GQ2960@e110439-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-6-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820094420.26590-6-quentin.perret@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,
likely the organization and naming on this file would require some
lovely refactoring and cleanup... but of course that's outside of the
scope of this patch.

Still, maybe we can improve a bit its current status according to the
following comments ?

On 20-Aug 10:44, Quentin Perret wrote:
> The existing scheduling domain hierarchy is defined to map to the cache
> topology of the system. However, Energy Aware Scheduling (EAS) requires
> more knowledge about the platform, and specifically needs to know about
> the span of Performance Domains (PD), which do not always align with
> caches.
> 
> To address this issue, use the Energy Model (EM) of the system to extend
> the scheduler topology code with a representation of the PDs, alongside
> the scheduling domains. More specifically, a linked list of PDs is
> attached to each root domain. When multiple root domains are in use,
> each list contains only the PDs covering the CPUs of its root domain. If
> a PD spans over CPUs of two different root domains, it will be
> duplicated in both lists.
> 
> The lists are fully maintained by the scheduler from
> partition_sched_domains() in order to cope with hotplug and cpuset
> changes. As for scheduling domains, the list are protected by RCU to
> ensure safe concurrent updates.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  kernel/sched/sched.h    |  21 +++++++
>  kernel/sched/topology.c | 134 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 151 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 481e6759441b..97d79429e755 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -44,6 +44,7 @@
>  #include <linux/ctype.h>
>  #include <linux/debugfs.h>
>  #include <linux/delayacct.h>
> +#include <linux/energy_model.h>
>  #include <linux/init_task.h>
>  #include <linux/kprobes.h>
>  #include <linux/kthread.h>
> @@ -700,6 +701,12 @@ static inline bool sched_asym_prefer(int a, int b)
>  	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
>  }
>  
> +struct perf_domain {
> +	struct em_perf_domain *obj;
> +	struct perf_domain *next;
> +	struct rcu_head rcu;
> +};
> +
>  /*
>   * We add the notion of a root-domain which will be used to define per-domain
>   * variables. Each exclusive cpuset essentially defines an island domain by
> @@ -752,6 +759,12 @@ struct root_domain {
>  	struct cpupri		cpupri;
>  
>  	unsigned long		max_cpu_capacity;
> +
> +	/*
> +	 * NULL-terminated list of performance domains intersecting with the
> +	 * CPUs of the rd. Protected by RCU.
> +	 */
> +	struct perf_domain	*pd;
>  };
>  
>  extern struct root_domain def_root_domain;
> @@ -2228,3 +2241,11 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
>  	return util;
>  }
>  #endif
> +
> +#ifdef CONFIG_SMP
> +#ifdef CONFIG_ENERGY_MODEL
> +#define perf_domain_span(pd) (to_cpumask(((pd)->obj->cpus)))
> +#else
> +#define perf_domain_span(pd) NULL
> +#endif
> +#endif
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index c4444ed77a55..545e2c7b6e66 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -201,6 +201,116 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
>  	return 1;
>  }
>  
> +#ifdef CONFIG_ENERGY_MODEL
> +static void free_pd(struct perf_domain *pd)
> +{
> +	struct perf_domain *tmp;
> +
> +	while (pd) {
> +		tmp = pd->next;
> +		kfree(pd);
> +		pd = tmp;
> +	}
> +}
> +
> +static struct perf_domain *find_pd(struct perf_domain *pd, int cpu)
> +{
> +	while (pd) {
> +		if (cpumask_test_cpu(cpu, perf_domain_span(pd)))
> +			return pd;
> +		pd = pd->next;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct perf_domain *pd_init(int cpu)
> +{
> +	struct em_perf_domain *obj = em_cpu_get(cpu);
> +	struct perf_domain *pd;
> +
> +	if (!obj) {
> +		if (sched_debug())
> +			pr_info("%s: no EM found for CPU%d\n", __func__, cpu);
> +		return NULL;
> +	}
> +
> +	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> +	if (!pd)
> +		return NULL;
> +	pd->obj = obj;
> +
> +	return pd;
> +}
> +
> +
> +static void perf_domain_debug(const struct cpumask *cpu_map,
> +						struct perf_domain *pd)
> +{
> +	if (!sched_debug() || !pd)
> +		return;
> +
> +	printk(KERN_DEBUG "root_domain %*pbl: ", cpumask_pr_args(cpu_map));
> +
> +	while (pd) {
> +		printk(KERN_CONT " pd%d:{ cpus=%*pbl nr_cstate=%d }",
> +				cpumask_first(perf_domain_span(pd)),
> +				cpumask_pr_args(perf_domain_span(pd)),
> +				em_pd_nr_cap_states(pd->obj));
> +		pd = pd->next;
> +	}
> +
> +	printk(KERN_CONT "\n");
> +}
> +
> +static void destroy_perf_domain_rcu(struct rcu_head *rp)
> +{
> +	struct perf_domain *pd;
> +
> +	pd = container_of(rp, struct perf_domain, rcu);
> +	free_pd(pd);
> +}
> +
> +static void build_perf_domains(const struct cpumask *cpu_map)
> +{
> +	struct perf_domain *pd = NULL, *tmp;
> +	int cpu = cpumask_first(cpu_map);
> +	struct root_domain *rd = cpu_rq(cpu)->rd;
> +	int i;
> +
> +	for_each_cpu(i, cpu_map) {
> +		/* Skip already covered CPUs. */
> +		if (find_pd(pd, i))
> +			continue;
> +
> +		/* Create the new pd and add it to the local list. */
> +		tmp = pd_init(i);
> +		if (!tmp)
> +			goto free;
> +		tmp->next = pd;
> +		pd = tmp;
> +	}
> +
> +	perf_domain_debug(cpu_map, pd);
> +
> +	/* Attach the new list of performance domains to the root domain. */
> +	tmp = rd->pd;
> +	rcu_assign_pointer(rd->pd, pd);
> +	if (tmp)
> +		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);

We have:

  sched_cpu_activate/cpuset_cpu_inactive
    cpuset_cpu_active/sched_cpu_deactivate
      partition_sched_domains
        build_perf_domains

thus here we are building new SDs and, specifically, above we are
attaching the local list "pd" to a _new_ root domain... thus, there
cannot be already users of this new SDs and root domain at this stage,
isn't it ?

Do we really need that rcu_assign_pointer ?
Is the rcu_assign_pointer there just to "match" the following call_rcu ?

What about this path:

  sched_init_domains
     partition_sched_domains

in which case we do not call build_perf_domains... is that intended ?

> +
> +	return;
> +
> +free:
> +	free_pd(pd);
> +	tmp = rd->pd;
> +	rcu_assign_pointer(rd->pd, NULL);
> +	if (tmp)
> +		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
> +}

All the above functions use different naming conventions:

   "_pd" suffix, "pd_" prefix and "perf_domain_" prefix.

and you do it like that because it better matches the corresponding
call sites following down the file.

However, since we are into a "CONFIG_ENERGY_MODEL" guarded section,
why not start using a common prefix for all PD related functions?

I very like "perf_domain_" (or "pd_") as a prefix and I would try to
use it for all the functions you defined above:

   perf_domain_free
   perf_domain_find
   perf_domain_debug
   perf_domain_destroy_rcu
   perf_domain_build

> +#else
> +static void free_pd(struct perf_domain *pd) { }
> +#endif

Maybe better:

  #endif /* CONFIG_ENERGY_MODEL */

> +
>  static void free_rootdomain(struct rcu_head *rcu)
>  {
>  	struct root_domain *rd = container_of(rcu, struct root_domain, rcu);
> @@ -211,6 +321,7 @@ static void free_rootdomain(struct rcu_head *rcu)
>  	free_cpumask_var(rd->rto_mask);
>  	free_cpumask_var(rd->online);
>  	free_cpumask_var(rd->span);
> +	free_pd(rd->pd);
>  	kfree(rd);
>  }
>  
> @@ -1964,8 +2075,8 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>  	/* Destroy deleted domains: */
>  	for (i = 0; i < ndoms_cur; i++) {
>  		for (j = 0; j < n && !new_topology; j++) {
> -			if (cpumask_equal(doms_cur[i], doms_new[j])
> -			    && dattrs_equal(dattr_cur, i, dattr_new, j))
> +			if (cpumask_equal(doms_cur[i], doms_new[j]) &&
> +			    dattrs_equal(dattr_cur, i, dattr_new, j))

This chunk looks more like a cleanup which is not really changing
anything: is it intentional?

>  				goto match1;
>  		}
>  		/* No match - a current sched domain not in new doms_new[] */
> @@ -1985,8 +2096,8 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>  	/* Build new domains: */
>  	for (i = 0; i < ndoms_new; i++) {
>  		for (j = 0; j < n && !new_topology; j++) {
> -			if (cpumask_equal(doms_new[i], doms_cur[j])
> -			    && dattrs_equal(dattr_new, i, dattr_cur, j))
> +			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
> +			    dattrs_equal(dattr_new, i, dattr_cur, j))


Same comment for the chunk above

>  				goto match2;
>  		}
>  		/* No match - add a new doms_new */
> @@ -1995,6 +2106,21 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>  		;
>  	}
>  
> +#ifdef CONFIG_ENERGY_MODEL
> +	/* Build perf. domains: */
> +	for (i = 0; i < ndoms_new; i++) {
> +		for (j = 0; j < n; j++) {
> +			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
> +			    cpu_rq(cpumask_first(doms_cur[j]))->rd->pd)
> +				goto match3;
> +		}
> +		/* No match - add perf. domains for a new rd */
> +		build_perf_domains(doms_new[i]);
> +match3:
> +		;
> +	}
> +#endif
> +


Since we already have a CONFIG_ENERGY_MODEL guarded section above,
maybe we can s/build_perf_domains/build_perf_root_domain/ and use
build_perf_domains to provide an inline function for the chunk above
in the guarded section at the beginning of the file ?

The #else section will then provide just an empty implementation.

Something like The diff below seems to work and it should do the
"cleanup" job by also moving at the beginning of the source file the
definition of the global variables (required by some functions).

Perhaps that's a bit of cleanup code that maintainer can accept...
but... to be verified. ;)

---8<---
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 2b6df8edca2a..647667b89180 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -10,6 +10,22 @@ DEFINE_MUTEX(sched_domains_mutex);
 cpumask_var_t sched_domains_tmpmask;
 cpumask_var_t sched_domains_tmpmask2;
 
+/* Current sched domains: */
+static cpumask_var_t			*doms_cur;
+
+/* Number of sched domains in 'doms_cur': */
+static int				ndoms_cur;
+
+/* Attribues of custom domains in 'doms_cur' */
+static struct sched_domain_attr		*dattr_cur;
+
+/*
+ * Special case: If a kmalloc() of a doms_cur partition (array of
+ * cpumask) fails, then fallback to a single sched domain,
+ * as determined by the single cpumask fallback_doms.
+ */
+static cpumask_var_t			fallback_doms;
+
 #ifdef CONFIG_SCHED_DEBUG
 
 static int __init sched_debug_setup(char *str)
@@ -294,7 +310,7 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
 #define EM_MAX_COMPLEXITY 2048
 
 extern struct cpufreq_governor schedutil_gov;
-static void build_perf_domains(const struct cpumask *cpu_map)
+static void build_perf_root_domain(const struct cpumask *cpu_map)
 {
 	int i, nr_pd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
 	struct perf_domain *pd = NULL, *tmp;
@@ -395,9 +411,30 @@ static void sched_energy_start(int ndoms_new, cpumask_var_t doms_new[])
 		static_branch_enable_cpuslocked(&sched_energy_present);
 	}
 }
+
+static void build_perf_domains(int ndoms_new, cpumask_var_t doms_new[])
+{
+	int i, j;
+
+	/* Build perf. domains: */
+	for (i = 0; i < ndoms_new; i++) {
+		for (j = 0; j < ndoms_cur; j++) {
+			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
+			    cpu_rq(cpumask_first(doms_cur[j]))->rd->pd)
+				goto done;
+		}
+		build_perf_root_domain(doms_new[i]);
+done:
+		;
+	}
+	sched_energy_start(ndoms_new, doms_new);
+}
+
 #else
 static void free_pd(struct perf_domain *pd) { }
-#endif
+static void build_perf_domains(int ndoms_new, cpumask_var_t doms_new[]) { }
+#endif /* CONFIG_ENERGY_MODEL */
 
 static void free_rootdomain(struct rcu_head *rcu)
 {
@@ -2004,22 +2041,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	return ret;
 }
 
-/* Current sched domains: */
-static cpumask_var_t			*doms_cur;
-
-/* Number of sched domains in 'doms_cur': */
-static int				ndoms_cur;
-
-/* Attribues of custom domains in 'doms_cur' */
-static struct sched_domain_attr		*dattr_cur;
-
-/*
- * Special case: If a kmalloc() of a doms_cur partition (array of
- * cpumask) fails, then fallback to a single sched domain,
- * as determined by the single cpumask fallback_doms.
- */
-static cpumask_var_t			fallback_doms;
-
 /*
  * arch_update_cpu_topology lets virtualized architectures update the
  * CPU core maps. It is supposed to return 1 if the topology changed
@@ -2198,21 +2219,7 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 		;
 	}
 
-#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
-	/* Build perf. domains: */
-	for (i = 0; i < ndoms_new; i++) {
-		for (j = 0; j < n && !sched_energy_update; j++) {
-			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
-			    cpu_rq(cpumask_first(doms_cur[j]))->rd->pd)
-				goto match3;
-		}
-		/* No match - add perf. domains for a new rd */
-		build_perf_domains(doms_new[i]);
-match3:
-		;
-	}
-	sched_energy_start(ndoms_new, doms_new);
-#endif
+	build_perf_domains(ndoms_new, n, doms_new);
 
 	/* Remember the new sched domains: */
 	if (doms_cur != &fallback_doms)
---8<---



>  	/* Remember the new sched domains: */
>  	if (doms_cur != &fallback_doms)
>  		free_sched_domains(doms_cur, ndoms_cur);
> -- 
> 2.17.1
> 

-- 
#include <best/regards.h>

Patrick Bellasi
