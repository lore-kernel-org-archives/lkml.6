Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC968C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB8D20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB8D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeIJOkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:40:25 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41922 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeIJOkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:40:24 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.123)
 id b684e1a316c13c31; Mon, 10 Sep 2018 11:47:09 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v6 03/14] PM: Introduce an Energy Model management framework
Date:   Mon, 10 Sep 2018 11:44:33 +0200
Message-ID: <1866195.ZKEIBQluJJ@aspire.rjw.lan>
In-Reply-To: <20180820094420.26590-4-quentin.perret@arm.com>
References: <20180820094420.26590-1-quentin.perret@arm.com> <20180820094420.26590-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 20, 2018 11:44:09 AM CEST Quentin Perret wrote:
> Several subsystems in the kernel (task scheduler and/or thermal at the
> time of writing) can benefit from knowing about the energy consumed by
> CPUs. Yet, this information can come from different sources (DT or
> firmware for example), in different formats, hence making it hard to
> exploit without a standard API.
> 
> As an attempt to address this, introduce a centralized Energy Model
> (EM) management framework which aggregates the power values provided
> by drivers into a table for each performance domain in the system. The
> power cost tables are made available to interested clients (e.g. task
> scheduler or thermal) via platform-agnostic APIs. The overall design
> is represented by the diagram below (focused on Arm-related drivers as
> an example, but applicable to any architecture):
> 
>      +---------------+  +-----------------+  +-------------+
>      | Thermal (IPA) |  | Scheduler (EAS) |  |    Other    |
>      +---------------+  +-----------------+  +-------------+
>              |                 | em_pd_energy()     |
>              |                 | em_cpu_get()       |
>              +-----------+     |         +----------+
>                          |     |         |
>                          v     v         v
>                       +---------------------+
>                       |                     |
>                       |    Energy Model     |
>                       |                     |
>                       |     Framework       |
>                       |                     |
>                       +---------------------+
>                          ^       ^       ^
>                          |       |       | em_register_perf_domain()
>               +----------+       |       +---------+
>               |                  |                 |
>       +---------------+  +---------------+  +--------------+
>       |  cpufreq-dt   |  |   arm_scmi    |  |    Other     |
>       +---------------+  +---------------+  +--------------+
>               ^                  ^                 ^
>               |                  |                 |
>       +--------------+   +---------------+  +--------------+
>       | Device Tree  |   |   Firmware    |  |      ?       |
>       +--------------+   +---------------+  +--------------+
> 
> Drivers (typically, but not limited to, CPUFreq drivers) can register
> data in the EM framework using the em_register_perf_domain() API. The
> calling driver must provide a callback function with a standardized
> signature that will be used by the EM framework to build the power
> cost tables of the performance domain. This design should offer a lot of
> flexibility to calling drivers which are free of reading information
> from any location and to use any technique to compute power costs.
> Moreover, the capacity states registered by drivers in the EM framework
> are not required to match real performance states of the target. This
> is particularly important on targets where the performance states are
> not known by the OS.
> 
> The power cost coefficients managed by the EM framework are specified in
> milli-watts. Although the two potential users of those coefficients (IPA
> and EAS) only need relative correctness, IPA specifically needs to
> compare the power of CPUs with the power of other components (GPUs, for
> example), which are still expressed in absolute terms in their
> respective subsystems. Hence, specifiying the power of CPUs in
> milli-watts should help transitioning IPA to using the EM framework
> without introducing new problems by keeping units comparable across
> sub-systems.
> On the longer term, the EM of other devices than CPUs could also be
> managed by the EM framework, which would enable to remove the absolute
> unit. However, this is not absolutely required as a first step, so this
> extension of the EM framework is left for later.
> 
> On the client side, the EM framework offers APIs to access the power
> cost tables of a CPU (em_cpu_get()), and to estimate the energy
> consumed by the CPUs of a performance domain (em_pd_energy()). Clients
> such as the task scheduler can then use these APIs to access the shared
> data structures holding the Energy Model of CPUs.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  include/linux/energy_model.h | 161 ++++++++++++++++++++++++++++
>  kernel/power/Kconfig         |  15 +++
>  kernel/power/Makefile        |   2 +
>  kernel/power/energy_model.c  | 199 +++++++++++++++++++++++++++++++++++
>  4 files changed, 377 insertions(+)
>  create mode 100644 include/linux/energy_model.h
>  create mode 100644 kernel/power/energy_model.c
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> new file mode 100644
> index 000000000000..b89b5596c976
> --- /dev/null
> +++ b/include/linux/energy_model.h
> @@ -0,0 +1,161 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ENERGY_MODEL_H
> +#define _LINUX_ENERGY_MODEL_H
> +#include <linux/cpumask.h>
> +#include <linux/jump_label.h>
> +#include <linux/kobject.h>
> +#include <linux/rcupdate.h>
> +#include <linux/sched/cpufreq.h>
> +#include <linux/sched/topology.h>
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_ENERGY_MODEL

A kerneldoc comment would be useful here IMO.

> +struct em_cap_state {
> +	unsigned long frequency; /* Kilo-hertz */

I wonder if the "frequency" field here could be changed into something a bit
more abstract like "level" or similar?

The reason why is because in some cases we may end up with somewhat artificial
values of "frequency" like when the intel_pstate driver is in use (it uses
abstract "p-state" values internally and only produces "frequency" numbers for
the cpufreq core and the way they are derived from the "p-states" is not always
entirely clean).

The "level" could just be frequency on systems where cpufreq drivers operate on
frequencies directly or something else on the other systems.

> +	unsigned long power; /* Milli-watts */
> +	unsigned long cost; /* power * max_frequency / frequency */
> +};
> +

Like above, a kerneldoc comment documenting the structure below would be useful.

> +struct em_perf_domain {
> +	struct em_cap_state *table; /* Capacity states, in ascending order. */
> +	int nr_cap_states;
> +	unsigned long cpus[0]; /* CPUs of the frequency domain. */
> +};
> +
> +#define EM_CPU_MAX_POWER 0xFFFF
> +
> +struct em_data_callback {
> +	/**
> +	 * active_power() - Provide power at the next capacity state of a CPU
> +	 * @power	: Active power at the capacity state in mW (modified)
> +	 * @freq	: Frequency at the capacity state in kHz (modified)
> +	 * @cpu		: CPU for which we do this operation
> +	 *
> +	 * active_power() must find the lowest capacity state of 'cpu' above
> +	 * 'freq' and update 'power' and 'freq' to the matching active power
> +	 * and frequency.
> +	 *
> +	 * The power is the one of a single CPU in the domain, expressed in
> +	 * milli-watts. It is expected to fit in the [0, EM_CPU_MAX_POWER]
> +	 * range.
> +	 *
> +	 * Return 0 on success.
> +	 */
> +	int (*active_power)(unsigned long *power, unsigned long *freq, int cpu);
> +};
> +#define EM_DATA_CB(_active_power_cb) { .active_power = &_active_power_cb }
> +
> +struct em_perf_domain *em_cpu_get(int cpu);
> +int em_register_perf_domain(cpumask_t *span, unsigned int nr_states,
> +						struct em_data_callback *cb);
> +
> +/**
> + * em_pd_energy() - Estimates the energy consumed by the CPUs of a perf. domain
> + * @pd		: performance domain for which energy has to be estimated
> + * @max_util	: highest utilization among CPUs of the domain
> + * @sum_util	: sum of the utilization of all CPUs in the domain
> + *
> + * Return: the sum of the energy consumed by the CPUs of the domain assuming
> + * a capacity state satisfying the max utilization of the domain.

Well, this confuses energy with power AFAICS.  The comment talks about energy,
but the return value is in the units of power.

I guess this assumes constant power over the next scheduling interval, which is
why energy and power can be treated as equivalent here, but that needs to be
clarified as it is somewhat confusing right now.

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

