Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A641BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A89A217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfAVPeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:34:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56122 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbfAVPeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:34:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C16CDA78;
        Tue, 22 Jan 2019 07:34:20 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B2BA3F589;
        Tue, 22 Jan 2019 07:34:19 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:34:14 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     rafael@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH] PM / EM: Expose the Energy Model in debugfs
Message-ID: <20190122153412.zuehulqwb7ung43u@queper01-lin>
References: <20190107122608.21913-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107122608.21913-1-quentin.perret@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 Jan 2019 at 12:26:08 (+0000), Quentin Perret wrote:
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index d9dc2c38764a..8ef48daa62ff 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/cpu.h>
>  #include <linux/cpumask.h>
> +#include <linux/debugfs.h>
>  #include <linux/energy_model.h>
>  #include <linux/sched/topology.h>
>  #include <linux/slab.h>
> @@ -23,6 +24,88 @@ static DEFINE_PER_CPU(struct em_perf_domain *, em_data);
>   */
>  static DEFINE_MUTEX(em_pd_mutex);
>  
> +#ifdef CONFIG_DEBUG_FS
> +static struct dentry *rootdir;
> +
> +static int em_debug_create_cs(struct em_cap_state *cs, struct dentry *pd)
> +{
> +	struct dentry *d;
> +	char name[24];
> +
> +	snprintf(name, sizeof(name), "cs:%lu", cs->frequency);
> +
> +	d = debugfs_create_dir(name, pd);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	if (!debugfs_create_ulong("frequency", 0444, d, &cs->frequency))
> +		return -ENOMEM;

Looking at the patches Greg just sent I assume all this is wrong.
I'll send a v2 without the 'if' all over.

Thanks,
Quentin

> +
> +	if (!debugfs_create_ulong("power", 0444, d, &cs->power))
> +		return -ENOMEM;
> +
> +	if (!debugfs_create_ulong("cost", 0444, d, &cs->cost))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int em_debug_cpus_show(struct seq_file *s, void *unused)
> +{
> +	seq_printf(s, "%*pbl\n", cpumask_pr_args(to_cpumask(s->private)));
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(em_debug_cpus);
> +
> +static int em_debug_create_pd(struct em_perf_domain *pd, int cpu)
> +{
> +	struct dentry *d;
> +	char name[16];
> +	int i;
> +
> +	if (!rootdir)
> +		return -EINVAL;
> +
> +	snprintf(name, sizeof(name), "pd%d", cpu);
> +
> +	/* Create the directory of the performance domain */
> +	d = debugfs_create_dir(name, rootdir);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	/* Create one file per pd to expose the related CPUs */
> +	if (!debugfs_create_file("cpus", 0444, d, pd->cpus,
> +							&em_debug_cpus_fops))
> +		return -ENOMEM;
> +
> +	/* Create a sub-directory for each capacity state */
> +	for (i = 0; i < pd->nr_cap_states; i++) {
> +		if (em_debug_create_cs(&pd->table[i], d))
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init em_debug_init(void)
> +{
> +	/* Create /sys/kernel/debug/energy_model directory */
> +	rootdir = debugfs_create_dir("energy_model", NULL);
> +	if (!rootdir) {
> +		pr_err("%s: Failed to create root directory\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +core_initcall(em_debug_init);
> +#else /* CONFIG_DEBUG_FS */
> +static int em_debug_create_pd(struct em_perf_domain *pd, int cpu)
> +{
> +	return 0;
> +}
> +#endif
>  static struct em_perf_domain *em_create_pd(cpumask_t *span, int nr_states,
>  						struct em_data_callback *cb)
>  {
> @@ -102,6 +185,9 @@ static struct em_perf_domain *em_create_pd(cpumask_t *span, int nr_states,
>  	pd->nr_cap_states = nr_states;
>  	cpumask_copy(to_cpumask(pd->cpus), span);
>  
> +	if (em_debug_create_pd(pd, cpu))
> +		pr_err("Failed to create debugfs for pd%d\n", cpu);
> +
>  	return pd;
>  
>  free_cs_table:
> -- 
> 2.20.1
> 
