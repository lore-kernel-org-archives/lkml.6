Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 507E26070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeFFNMZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:12:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40346 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751851AbeFFNMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:12:23 -0400
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
To: Quentin Perret <quentin.perret@arm.com>, peterz@infradead.org,
        rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b47cb1f1-6ca1-7674-903f-724be43a57a0@arm.com>
Date: Wed, 6 Jun 2018 15:12:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180521142505.6522-4-quentin.perret@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/2018 04:24 PM, Quentin Perret wrote:
> Several subsystems in the kernel (scheduler and/or thermal at the time
> of writing) can benefit from knowing about the energy consumed by CPUs.
> Yet, this information can come from different sources (DT or firmware for
> example), in different formats, hence making it hard to exploit without
> a standard API.
> 
> This patch attempts to solve this issue by introducing a centralized
> Energy Model (EM) framework which can be used to interface the data
> providers with the client subsystems. This framework standardizes the
> API to expose power costs, and to access them from multiple locations.
> 
> The current design assumes that all CPUs in a frequency domain share the
> same micro-architecture. As such, the EM data is structured in a
> per-frequency-domain fashion. Drivers aware of frequency domains
> (typically, but not limited to, CPUFreq drivers) are expected to register
> data in the EM framework using the em_register_freq_domain() API. To do
> so, the drivers must provide a callback function that will be called by
> the EM framework to populate the tables. As of today, only the active
> power of the CPUs is considered. For each frequency domain, the EM
> includes a list of <frequency, power, capacity> tuples for the capacity
> states of the domain alongside a cpumask covering the involved CPUs.
> 
> The EM framework also provides an API to re-scale the capacity values
> of the model asynchronously, after it has been created. This is required
> for architectures where the capacity scale factor of CPUs can change at
> run-time. This is the case for Arm/Arm64 for example where the
> arch_topology driver recomputes the capacity scale factors of the CPUs
> after the maximum frequency of all CPUs has been discovered. Although
> complex, the process of creating and re-scaling the EM has to be kept in
> two separate steps to fulfill the needs of the different users. The thermal
> subsystem doesn't use the capacity values and shouldn't have dependencies
> on subsystems providing them. On the other hand, the task scheduler needs
> the capacity values, and it will benefit from seeing them up-to-date when
> applicable.
> 
> Because of this need for asynchronous update, the capacity state table
> of each frequency domain is protected by RCU, hence guaranteeing a safe
> modification of the table and a fast access to readers in latency-sensitive
> code paths.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>

[...]

> +static void fd_update_cs_table(struct em_cs_table *cs_table, int cpu)
> +{
> +	unsigned long cmax = arch_scale_cpu_capacity(NULL, cpu);
> +	int max_cap_state = cs_table->nr_cap_states - 1;
> +	unsigned long fmax = cs_table->state[max_cap_state].frequency;
> +	int i;
> +
> +	for (i = 0; i < cs_table->nr_cap_states; i++)
> +		cs_table->state[i].capacity = cmax *
> +					cs_table->state[i].frequency / fmax;
> +}

This has issues on a 32bit system. cs_table->state[i].capacity (unsigned
long) overflows with the frequency values stored in Hz.

Maybe something like this to cure it:

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 6ad53f1cf7e6..c13b3eb8bf35 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -144,9 +144,11 @@ static void fd_update_cs_table(struct em_cs_table *cs_table, int cpu)
 	unsigned long fmax = cs_table->state[max_cap_state].frequency;
 	int i;
 
-	for (i = 0; i < cs_table->nr_cap_states; i++)
-		cs_table->state[i].capacity = cmax *
-					cs_table->state[i].frequency / fmax;
+	for (i = 0; i < cs_table->nr_cap_states; i++) {
+		u64 val = (u64)cmax * cs_table->state[i].frequency;
+		do_div(val, fmax);
+		cs_table->state[i].capacity = (unsigned long)val;
+	}
 }

This brings me to another question. Let's say there are multiple users of
the Energy Model in the system. Shouldn't the units of frequency and power
not standardized, maybe Mhz and mW?
The task scheduler doesn't care since it is only interested in power diffs
but other user might do.

[...]
