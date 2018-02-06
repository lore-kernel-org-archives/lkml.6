Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeBFOx2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:53:28 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38442 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751837AbeBFOxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:53:20 -0500
Subject: Re: [PATCHv2 1/3] drivers/perf: arm_pmu: Add platform hardware setup
 hooks.
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Ian Ray <ian.ray@ge.com>,
        Rob Herring <robh+dt@kernel.org>, Nandor Han <nandor.han@ge.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180206142629.534-1-sebastian.reichel@collabora.co.uk>
 <20180206142629.534-2-sebastian.reichel@collabora.co.uk>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7920f8f4-8f25-4633-7a17-bdda5351a9e9@arm.com>
Date: Tue, 6 Feb 2018 14:53:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206142629.534-2-sebastian.reichel@collabora.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 06/02/18 14:26, Sebastian Reichel wrote:
> Allow platform specific code to be called when enabling or
> disabling the hardware.

Since arm_pmu_platdata wants to go away[1], does i.MX53 actually need 
all this machinery, or would it suffice to set DBG_EN from platform code 
at boot time and simply leave it that way?

Robin.

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/557838.html

> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> [rebased to v4.12]
> Signed-off-by: Nandor Han <nandor.han@ge.com>
> [Simplify and cleanup for upstreaming]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>   drivers/perf/arm_pmu.c       | 12 ++++++++++++
>   include/linux/perf/arm_pmu.h |  5 +++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 7bc5eee96b31..9c282914ee67 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -452,8 +452,10 @@ static int armpmu_event_init(struct perf_event *event)
>   static void armpmu_enable(struct pmu *pmu)
>   {
>   	struct arm_pmu *armpmu = to_arm_pmu(pmu);
> +	struct arm_pmu_platdata *platdata = armpmu_get_platdata(armpmu);
>   	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
>   	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
> +	int err;
>   
>   	/* For task-bound events we may be called on other CPUs */
>   	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
> @@ -461,17 +463,27 @@ static void armpmu_enable(struct pmu *pmu)
>   
>   	if (enabled)
>   		armpmu->start(armpmu);
> +
> +	if (platdata && platdata->reserve_hardware) {
> +		err = platdata->reserve_hardware(armpmu);
> +		if (err)
> +			dev_warn(&armpmu->plat_device->dev, "Could not reserve PMU hardware!\n");
> +	}
>   }
>   
>   static void armpmu_disable(struct pmu *pmu)
>   {
>   	struct arm_pmu *armpmu = to_arm_pmu(pmu);
> +	struct arm_pmu_platdata *platdata = armpmu_get_platdata(armpmu);
>   
>   	/* For task-bound events we may be called on other CPUs */
>   	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
>   		return;
>   
>   	armpmu->stop(armpmu);
> +
> +	if (platdata && platdata->release_hardware)
> +		platdata->release_hardware(armpmu);
>   }
>   
>   /*
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index af0f44effd44..942ae9bfe971 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -17,6 +17,8 @@
>   #include <linux/sysfs.h>
>   #include <asm/cputype.h>
>   
> +struct arm_pmu;
> +
>   /*
>    * struct arm_pmu_platdata - ARM PMU platform data
>    *
> @@ -31,6 +33,8 @@
>   struct arm_pmu_platdata {
>   	irqreturn_t (*handle_irq)(int irq, void *dev,
>   				  irq_handler_t pmu_handler);
> +	int (*reserve_hardware)(struct arm_pmu *arm_pmu);
> +	void (*release_hardware)(struct arm_pmu *arm_pmu);
>   	unsigned long irq_flags;
>   };
>   
> @@ -112,6 +116,7 @@ struct arm_pmu {
>   	int		(*map_event)(struct perf_event *event);
>   	int		num_events;
>   	u64		max_period;
> +	bool		reserved_hardware;
>   	bool		secure_access; /* 32-bit ARM only */
>   #define ARMV8_PMUV3_MAX_COMMON_EVENTS 0x40
>   	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
> 
