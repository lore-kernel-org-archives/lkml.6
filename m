Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596A5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72332404C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYp2dlLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72332404C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753978AbeGFJ5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:57:51 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52514 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbeGFJ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:57:49 -0400
Received: by mail-it0-f66.google.com with SMTP id p4-v6so15809784itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 02:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qJgQ0E0MXIvjhhxT/n/rxEQ/VbW2MlPFa/GRdoBj2g=;
        b=bYp2dlLxCzmeLi4obK2YlYoselw+u1lI6zWamLrJsQQXo7UsXnf4f7p7pLG2NmX9/k
         O8WlEBvxzUMP2PUOULeDhxHnkQwP8XEPV8hFbgF5KeBNngelC3lF2+suD3JAjlfbejy7
         eqmxAfyWd8CYDydaqEV5vPk8eqKxD9WevKChI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qJgQ0E0MXIvjhhxT/n/rxEQ/VbW2MlPFa/GRdoBj2g=;
        b=ne222VGCxgfubMoWeGs88g7/TSRDaFRg6x/QTAwUWz1EoCa/DK2R2iSFSvfTRVYb/H
         fXQdmCjBgsPqHj3Sc0rptTMNTh6BG54izysHnlWNbla0EqpBuxxVeuH0iKk5eZT+srXn
         /bKgYwY2Oo/dOp/mB+kGi7b2PnxeTQXXtI4WgazQx3tPr/67zMyy9fpmcA4zZUU2yNgA
         6l9pYsutLA9fuQf5McQKcJURR9+a8ZddtlGhXVRqidpIAvg+vaGvk7PEqeX0iRgz/Vvk
         DOsS6VFaMT5/oqmKwIkOrEStEmS08qygmPWlzMIhT4y1vcat2qdfhB/BjysE002iDt3h
         ctPA==
X-Gm-Message-State: APt69E1rCeoMgcf9/WoqkLvsPxVRmYsxOd4n9QyJf71z1Chc6ZKDdfoc
        lYLGU2UHzmnERPBp6/nItcCHMeu/P3B8m6ByO0ARaw==
X-Google-Smtp-Source: AAOMgpdP1Hd4qAQ1GLHFsP0vyfrexDFKK21Lha61L9DM/L4ULnVXHPznhg2X/+LiI9CHHhXktIsh+lN6x5gsLiT0Ko8=
X-Received: by 2002:a24:99c4:: with SMTP id a187-v6mr7400163ite.148.1530871068702;
 Fri, 06 Jul 2018 02:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180628114043.24724-1-quentin.perret@arm.com> <20180628114043.24724-4-quentin.perret@arm.com>
In-Reply-To: <20180628114043.24724-4-quentin.perret@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Jul 2018 11:57:37 +0200
Message-ID: <CAKfTPtCxt-O8uMOYgAjY7daujXwXyZQ-3BYe=DONL7R95T7nmQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management framework
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018 at 13:41, Quentin Perret <quentin.perret@arm.com> wrote:
>
> Several subsystems in the kernel (task scheduler and/or thermal at the
> time of writing) can benefit from knowing about the energy consumed by
> CPUs. Yet, this information can come from different sources (DT or
> firmware for example), in different formats, hence making it hard to
> exploit without a standard API.
>
> As an attempt to address this, introduce a centralized Energy Model
> (EM) management framework which aggregates the power values provided
> by drivers into a table for each frequency domain in the system. The
> power cost tables are made available to interested clients (e.g. task
> scheduler or thermal) via platform-agnostic APIs. The overall design
> is represented by the diagram below (focused on Arm-related drivers as
> an example, but hopefully applicable to any architecture):
>
>      +---------------+  +-----------------+  +---------+
>      | Thermal (IPA) |  | Scheduler (EAS) |  | Other ? |
>      +---------------+  +-----------------+  +---------+
>              |                 | em_fd_energy()   |
>              |                 | em_cpu_get()     |
>              +-----------+     |         +--------+
>                          |     |         |
>                          v     v         v
>                       +---------------------+
>                       |                     |         +---------------+
>                       |    Energy Model     |         | arch_topology |
>                       |                     |<--------|    driver     |
>                       |     Framework       |         +---------------+
>                       |                     | em_rescale_cpu_capacity()
>                       +---------------------+
>                          ^       ^       ^
>                          |       |       | em_register_freq_domain()
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
> data in the EM framework using the em_register_freq_domain() API. The
> calling driver must provide a callback function with a standardized
> signature that will be used by the EM framework to build the power
> cost tables of the frequency domain. This design should offer a lot of
> flexibility to calling drivers which are free of reading information
> from any location and to use any technique to compute power costs.
> Moreover, the capacity states registered by drivers in the EM framework
> are not required to match real performance states of the target. This
> is particularly important on targets where the performance states are
> not known by the OS.
>
> On the client side, the EM framework offers APIs to access the power
> cost tables of a CPU (em_cpu_get()), and to estimate the energy
> consumed by the CPUs of a frequency domain (em_fd_energy()). Clients
> such as the task scheduler can then use these APIs to access the shared
> data structures holding the Energy Model of CPUs.
>
> The EM framework also provides an API (em_rescale_cpu_capacity()) to
> re-scale the capacity values of the model asynchronously, after it has
> been created. This is required for architectures where the capacity
> scale factor of CPUs can change at run-time. This is the case for
> Arm/Arm64 for example where the arch_topology driver recomputes the
> capacity scale factors of the CPUs after the maximum frequency of all
> CPUs has been discovered. Although complex, the process of creating and
> re-scaling the EM has to be kept in two separate steps to fulfill the
> needs of the different users. The thermal subsystem doesn't use the
> capacity values and shouldn't have dependencies on subsystems providing
> them. On the other hand, the task scheduler needs the capacity values,
> and it will benefit from seeing them up-to-date when applicable.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  include/linux/energy_model.h | 140 ++++++++++++++++++
>  kernel/power/Kconfig         |  15 ++
>  kernel/power/Makefile        |   2 +
>  kernel/power/energy_model.c  | 273 +++++++++++++++++++++++++++++++++++
>  4 files changed, 430 insertions(+)
>  create mode 100644 include/linux/energy_model.h
>  create mode 100644 kernel/power/energy_model.c
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> new file mode 100644
> index 000000000000..88c2f0b9bcb3
> --- /dev/null
> +++ b/include/linux/energy_model.h
> @@ -0,0 +1,140 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ENERGY_MODEL_H
> +#define _LINUX_ENERGY_MODEL_H
> +#include <linux/cpumask.h>
> +#include <linux/jump_label.h>
> +#include <linux/kobject.h>
> +#include <linux/rcupdate.h>
> +#include <linux/sched/cpufreq.h>
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_ENERGY_MODEL
> +struct em_cap_state {
> +       unsigned long capacity;
> +       unsigned long frequency; /* Kilo-hertz */
> +       unsigned long power; /* Milli-watts */
> +};
> +
> +struct em_cs_table {
> +       struct em_cap_state *state; /* Capacity states, in ascending order. */
> +       int nr_cap_states;
> +       struct rcu_head rcu;
> +};
> +
> +struct em_freq_domain {
> +       struct em_cs_table *cs_table; /* Capacity state table, RCU-protected */
> +       unsigned long cpus[0]; /* CPUs of the frequency domain. */
> +};
> +
> +#define EM_CPU_MAX_POWER 0xFFFF
> +
> +struct em_data_callback {
> +       /**
> +        * active_power() - Provide power at the next capacity state of a CPU
> +        * @power       : Active power at the capacity state in mW (modified)
> +        * @freq        : Frequency at the capacity state in kHz (modified)
> +        * @cpu         : CPU for which we do this operation
> +        *
> +        * active_power() must find the lowest capacity state of 'cpu' above
> +        * 'freq' and update 'power' and 'freq' to the matching active power
> +        * and frequency.
> +        *
> +        * The power is the one of a single CPU in the domain, expressed in
> +        * milli-watts. It is expected to fit in the [0, EM_CPU_MAX_POWER]
> +        * range.
> +        *
> +        * Return 0 on success.
> +        */
> +       int (*active_power) (unsigned long *power, unsigned long *freq, int cpu);
> +};
> +#define EM_DATA_CB(_active_power_cb) { .active_power = &_active_power_cb }
> +
> +void em_rescale_cpu_capacity(void);
> +struct em_freq_domain *em_cpu_get(int cpu);
> +int em_register_freq_domain(cpumask_t *span, unsigned int nr_states,
> +                                               struct em_data_callback *cb);
> +
> +/**
> + * em_fd_energy() - Estimates the energy consumed by the CPUs of a freq. domain
> + * @fd         : frequency domain for which energy has to be estimated
> + * @max_util   : highest utilization among CPUs of the domain
> + * @sum_util   : sum of the utilization of all CPUs in the domain
> + *
> + * em_fd_energy() dereferences the capacity state table of the frequency
> + * domain, so it must be called under RCU read lock.
> + *
> + * Return: the sum of the energy consumed by the CPUs of the domain assuming
> + * a capacity state satisfying the max utilization of the domain.
> + */
> +static inline unsigned long em_fd_energy(struct em_freq_domain *fd,
> +                               unsigned long max_util, unsigned long sum_util)
> +{
> +       struct em_cs_table *cs_table;
> +       struct em_cap_state *cs;
> +       unsigned long freq;
> +       int i;
> +
> +       cs_table = rcu_dereference(fd->cs_table);
> +       if (!cs_table)
> +               return 0;
> +
> +       /* Map the utilization value to a frequency */
> +       cs = &cs_table->state[cs_table->nr_cap_states - 1];
> +       freq = map_util_freq(max_util, cs->frequency, cs->capacity);

The 2 lines above deserve more explanation:
1st, you get the max capacity of the freq domain
Then, you estimate what will be the selected frequency according to
the max_utilization.
Might worth to mention that we must keep sync how sched_util and EM
select a freq for a given capacity which is the reason of patch 02

> +
> +       /* Find the lowest capacity state above this frequency */
> +       for (i = 0; i < cs_table->nr_cap_states; i++) {
> +               cs = &cs_table->state[i];
> +               if (cs->frequency >= freq)
> +                       break;
> +       }
> +
> +       return cs->power * sum_util / cs->capacity;

IIUC the formula above, you consider that all CPUs in a frequency
domain has the same capacity. This sounds a reasonable assumption but
it would be good to write that somewhere

> +}
> +
