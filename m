Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBBMx3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:53:29 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50221 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbeBBMwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:52:36 -0500
X-Google-Smtp-Source: AH8x225peWmUVIMAPq1T+0K2EHpjlcUKnOtUICiKkjk1SaS96vnNwwGnIC2l4Tl8ZsLuEXXO3p3vkQ==
Date: Fri, 2 Feb 2018 13:52:31 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: peterz@infradead.org, lizefan@huawei.com, mingo@redhat.com,
        rostedt@goodmis.org, claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, luca.abeni@santannapisa.it,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/7] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20180202125231.GT19535@localhost.localdomain>
References: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
 <1517503869-3179-3-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517503869-3179-3-git-send-email-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 01/02/18 09:51, Mathieu Poirier wrote:
> When the topology of root domains is modified by CPUset or CPUhotplug
> operations information about the current deadline bandwidth held in the
> root domain is lost.
> 
> This patch address the issue by recalculating the lost deadline
> bandwidth information by circling through the deadline tasks held in
> CPUsets and adding their current load to the root domain they are
> associated with.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---

[...]

> +static void update_tasks_root_domain(struct cpuset *cs)
> +{
> +	struct css_task_iter it;
> +	struct task_struct *task;
> +
> +	css_task_iter_start(&cs->css, 0, &it);
> +
> +	while ((task = css_task_iter_next(&it)))
> +		dl_add_task_root_domain(task);
> +
> +	css_task_iter_end(&it);
> +}
> +
> +/*
> + * Called with cpuset_mutex held (rebuild_sched_domains())
> + * Called with hotplug lock held (rebuild_sched_domains_locked())
> + * Called with sched_domains_mutex held (partition_and_rebuild_domains())
> + */
> +static void rebuild_root_domains(void)
> +{
> +	struct cpuset *cs = NULL;
> +	struct cgroup_subsys_state *pos_css;
> +
> +	rcu_read_lock();
> +
> +	/*
> +	 * Clear default root domain DL accounting, it will be computed again
> +	 * if a task belongs to it.
> +	 */
> +	dl_clear_root_domain(&def_root_domain);

Can't a __sched_setscheduler sneak in at this point, set a task to
DEADLINE, add its bandwidth to the rd...

> +
> +	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
> +
> +		if (cpumask_empty(cs->effective_cpus)) {
> +			pos_css = css_rightmost_descendant(pos_css);
> +			continue;
> +		}
> +
> +		css_get(&cs->css);
> +
> +		rcu_read_unlock();
> +
> +		update_tasks_root_domain(cs);

... and this adds it again?

> +
> +		rcu_read_lock();
> +		css_put(&cs->css);
> +	}
> +	rcu_read_unlock();
> +}

Best,

- Juri
