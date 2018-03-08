Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbeCHX7I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:59:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeCHX7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:59:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB7ED601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5AA1CE48.5030203@codeaurora.org>
Date: Thu, 08 Mar 2018 15:59:04 -0800
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Suzuki K Poulose <suzuki.poulose@arm.com>
CC: will.deacon@arm.com, mark.rutland@arm.com, robh@kernel.org,
        sudeep.holla@arm.com, mathieu.poirier@linaro.org, peterz@infradead.org,
        jonathan.cameron@huawei.com, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, leo.yan@linaro.org, frowand.list@gmail.com,
        linux-arm-kernel@lists.infradead.org, rananta@codeaurora.org,
        avilaj@codeaurora.org
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

Looking at the code, I didn't see any specific handling of cluster power 
collapse. AFAIK, the HW counters do not retain config (what event they 
are counting) or value (the current count) across power collapse. 
Wouldn't you need to register for some kind of PM_ENTER/EXIT notifiers 
to handle that?

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
