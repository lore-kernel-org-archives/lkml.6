Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeBVCcw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 21:32:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44678 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbeBVCcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 21:32:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12B646076C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5A8E2BCE.3050509@codeaurora.org>
Date: Wed, 21 Feb 2018 18:32:46 -0800
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Suzuki K Poulose <suzuki.poulose@arm.com>
CC: will.deacon@arm.com, mark.rutland@arm.com, robh@kernel.org,
        sudeep.holla@arm.com, mathieu.poirier@linaro.org, peterz@infradead.org,
        jonathan.cameron@huawei.com, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, leo.yan@linaro.org, frowand.list@gmail.com,
        linux-arm-kernel@lists.infradead.org, avilaj@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
References: <20180102112533.13640-1-suzuki.poulose@arm.com> <20180102112533.13640-9-suzuki.poulose@arm.com>
In-Reply-To: <20180102112533.13640-9-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2018 03:25 AM, Suzuki K Poulose wrote:
> Add support for the Cluster PMU part of the ARM DynamIQ Shared Unit (DSU).
> The DSU integrates one or more cores with an L3 memory system, control
> logic, and external interfaces to form a multicore cluster. The PMU
> allows counting the various events related to L3, SCU etc, along with
> providing a cycle counter.
>
> The PMU can be accessed via system registers, which are common
> to the cores in the same cluster. The PMU registers follow the
> semantics of the ARMv8 PMU, mostly, with the exception that
> the counters record the cluster wide events.
>
> This driver is mostly based on the ARMv8 and CCI PMU drivers.
> The driver only supports ARM64 at the moment. It can be extended
> to support ARM32 by providing register accessors like we do in
> arch/arm64/include/arm_dsu_pmu.h.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V9:
>   - Rely on cpuhp callback for probing the PMU.
>   - Clear the overflow mask whenever the first CPU is brought up.
>   - Remove dsu_pmu_get_online_cpu(), which is not needed anymore.
>   - Flip the order of context migration and setting the active CPU.
>
> Changes since V8:
>   - Include required header files (Mark Rutland)
>   - Remove Kconfig dependency on PERF_EVENTS (Mark Rutland)
>   - Fix typo in event name, bus_acesss => bus_access (Mark Rutland)
>   - Use find_first_zero_bit instead of find_next_zero_bit (Mark Rutland)
>   - Change order of checks in dsu_pmu_event_init (Mark Rutland)
>   - Allow lazy initialisation of DSU PMU to handle cases where CPUs
>     may be brought up later (e.g, maxcpus=N)- Mark Rutland.
>   - Clear the interrupt overflow status upon initialisation (Mark Rutland)
>   - Change the CPU check to "associated_cpus" from "active_cpus",
>     as when we migrate the perf context we will access the DSU
>     from two different CPUs (source and destination).
>   - Fill in the "module" field for the PMU to prevent the module unload
>     when the PMU is active.
> Changes since V6:
>   - Address comments from Jonathan
>   - Add Reviewed-by tags from Jonathan
> Changes since V5:
>   - Address comments on V5 by Mark.
>   - Use IRQ_NOBALANCING for IRQ handler
>   - Don't expose events which could be unimplemented.
>   - Get rid of dsu_pmu_event_supported and allow raw event
>     code to be used without validating whether it is supported.
>   - Rename "supported_cpus" mask to "associated_cpus"
>   - Add Documentation for the PMU driver
>   - Don't disable IRQ for dsu_pmu_{enable/disable}_counters
>   - Use consistent return codes for validate_event/group calls.
>   - Check PERF_ATTACH_TASK flag in event_init.
>   - Allow missing CPUs in dsu_pmu_dt_get_cpus, to handle cases
>     where kernel could have capped nr_cpus.
>   - Cleanup sanity checking for the CPU before accessing DSU
>   - Reject events with counting CPU not associated with the DSU.
> Changes since V4:
>   - Reflect the changed generic helper for mapping CPU id
> Changes since V2:
>   - Cleanup dsu_pmu_device_probe error handling.
>   - Fix event validate_group to invert the result check of validate_event
>   - Return errors if we failed to parse CPUs in the DSU.
>   - Add MODULE_DEVICE_TABLE entry
>   - Use hlist_entry_safe for converting cpuhp_node to dsu_pmu.
> ---
>   Documentation/perf/arm_dsu_pmu.txt   |  28 ++
>   arch/arm64/include/asm/arm_dsu_pmu.h | 129 ++++++
>   drivers/perf/Kconfig                 |   9 +
>   drivers/perf/Makefile                |   1 +
>   drivers/perf/arm_dsu_pmu.c           | 843 +++++++++++++++++++++++++++++++++++
>   5 files changed, 1010 insertions(+)
>   create mode 100644 Documentation/perf/arm_dsu_pmu.txt
>   create mode 100644 arch/arm64/include/asm/arm_dsu_pmu.h
>   create mode 100644 drivers/perf/arm_dsu_pmu.c
>

<SNIP>

> +
> +static int dsu_pmu_event_init(struct perf_event *event)
> +{
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;

You are checking if the caller set the attr.type "correctly".

> +
> +	/* We don't support sampling */
> +	if (is_sampling_event(event)) {
> +		dev_dbg(dsu_pmu->pmu.dev, "Can't support sampling events\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* We cannot support task bound events */
> +	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
> +		dev_dbg(dsu_pmu->pmu.dev, "Can't support per-task counters\n");
> +		return -EINVAL;
> +	}
> +
> +	if (has_branch_stack(event) ||
> +	    event->attr.exclude_user ||
> +	    event->attr.exclude_kernel ||
> +	    event->attr.exclude_hv ||
> +	    event->attr.exclude_idle ||
> +	    event->attr.exclude_host ||
> +	    event->attr.exclude_guest) {
> +		dev_dbg(dsu_pmu->pmu.dev, "Can't support filtering\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!cpumask_test_cpu(event->cpu, &dsu_pmu->associated_cpus)) {
> +		dev_dbg(dsu_pmu->pmu.dev,
> +			 "Requested cpu is not associated with the DSU\n");
> +		return -EINVAL;
> +	}
> +	/*
> +	 * Choose the current active CPU to read the events. We don't want
> +	 * to migrate the event contexts, irq handling etc to the requested
> +	 * CPU. As long as the requested CPU is within the same DSU, we
> +	 * are fine.
> +	 */
> +	event->cpu = cpumask_first(&dsu_pmu->active_cpu);
> +	if (event->cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +	if (!dsu_pmu_validate_group(event))
> +		return -EINVAL;
> +
> +	event->hw.config_base = event->attr.config;
> +	return 0;
> +}
> +

<SNIP>

> +
> +static int dsu_pmu_device_probe(struct platform_device *pdev)
> +{
> +	int irq, rc;
> +	struct dsu_pmu *dsu_pmu;
> +	char *name;
> +	static atomic_t pmu_idx = ATOMIC_INIT(-1);
> +
> +	dsu_pmu = dsu_pmu_alloc(pdev);
> +	if (IS_ERR(dsu_pmu))
> +		return PTR_ERR(dsu_pmu);
> +
> +	rc = dsu_pmu_dt_get_cpus(pdev->dev.of_node, &dsu_pmu->associated_cpus);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "Failed to parse the CPUs\n");
> +		return rc;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_warn(&pdev->dev, "Failed to find IRQ\n");
> +		return -EINVAL;
> +	}
> +
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_%d",
> +				PMUNAME, atomic_inc_return(&pmu_idx));
> +	if (!name)
> +		return -ENOMEM;
> +	rc = devm_request_irq(&pdev->dev, irq, dsu_pmu_handle_irq,
> +			      IRQF_NOBALANCING, name, dsu_pmu);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "Failed to request IRQ %d\n", irq);
> +		return rc;
> +	}
> +
> +	dsu_pmu->irq = irq;
> +	platform_set_drvdata(pdev, dsu_pmu);
> +	rc = cpuhp_state_add_instance(dsu_pmu_cpuhp_state,
> +						&dsu_pmu->cpuhp_node);
> +	if (rc)
> +		return rc;
> +
> +	dsu_pmu->pmu = (struct pmu) {
> +		.task_ctx_nr	= perf_invalid_context,
> +		.module		= THIS_MODULE,
> +		.pmu_enable	= dsu_pmu_enable,
> +		.pmu_disable	= dsu_pmu_disable,
> +		.event_init	= dsu_pmu_event_init,
> +		.add		= dsu_pmu_add,
> +		.del		= dsu_pmu_del,
> +		.start		= dsu_pmu_start,
> +		.stop		= dsu_pmu_stop,
> +		.read		= dsu_pmu_read,
> +
> +		.attr_groups	= dsu_pmu_attr_groups,
> +	};
> +
> +	rc = perf_pmu_register(&dsu_pmu->pmu, name, -1);

You are passing in -1 here. Which means the event type is assigned by 
the perf framework. perf framework uses idr_alloc(&pmu_idr, ...) to get 
the id. So the id assigned is going to depend on the probe order among 
the different PMU drivers in the board/platform. So, this seems pretty 
random.

How is the caller supposed to know what to set the "type" to?

You also can't just delete the check in dsu_pmu_event_init() because the 
event numbers you expose overlap with the per-CPU event numbers.

I'm not exactly sure if we can add entries to perf_type_id. If that's 
allowed maybe we need to add something line PERF_TYPE_DSU and use that?

Or if that's not allowed then would it be better to offset the DSU PMU 
events by some number (say 0x1000) and then delete the event type check 
or pass PERF_TYPE_RAW to perf_pmu_register()?

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
