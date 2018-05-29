Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935640AbeE2PeG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:34:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43110 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934940AbeE2PeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:34:04 -0400
Subject: Re: [PATCH] drivers/bus: arm-cci: fix build warnings
To: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180528154228.2403116-1-arnd@arndb.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0db1b8cd-b695-6cbf-9b27-f632b76bad11@arm.com>
Date: Tue, 29 May 2018 16:34:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180528154228.2403116-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/18 16:41, Arnd Bergmann wrote:
> When the arm-cci driver is enabled, but both CONFIG_ARM_CCI5xx_PMU and
> CONFIG_ARM_CCI400_PMU are not, we get a warning about how parts of
> the driver are never used:
> 
> drivers/perf/arm-cci.c:1454:29: error: 'cci_pmu_models' defined but not used [-Werror=unused-variable]
> drivers/perf/arm-cci.c:693:16: error: 'cci_pmu_event_show' defined but not used [-Werror=unused-function]
> drivers/perf/arm-cci.c:685:16: error: 'cci_pmu_format_show' defined but not used [-Werror=unused-function]
> 
> Marking all three functions as __maybe_unused avoids the warnings in
> randconfig builds. I'm doing this lacking any ideas for a better fix.

Yeah, it's a bit of a silly configuration to allow building a driver 
supporting no PMU types, but I couldn't find a way to enforce "at least 
one sub-option enabled" logic without introducing mutually-exclusive 
dependencies which kbuild thinks are recursive.

An alternative would be to remove the CCI400/CCI5x0 configurability 
altogether - I've not not looked in detail at how much difference that 
actually makes.

Otherwise, as an immediate quick-fix:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

> Fixes: 3de6be7a3dd8 ("drivers/bus: Split Arm CCI driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/perf/arm-cci.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> index e6fadc8e1178..0d09d8e669cd 100644
> --- a/drivers/perf/arm-cci.c
> +++ b/drivers/perf/arm-cci.c
> @@ -120,9 +120,9 @@ enum cci_models {
>   
>   static void pmu_write_counters(struct cci_pmu *cci_pmu,
>   				 unsigned long *mask);
> -static ssize_t cci_pmu_format_show(struct device *dev,
> +static ssize_t __maybe_unused cci_pmu_format_show(struct device *dev,
>   			struct device_attribute *attr, char *buf);
> -static ssize_t cci_pmu_event_show(struct device *dev,
> +static ssize_t __maybe_unused cci_pmu_event_show(struct device *dev,
>   			struct device_attribute *attr, char *buf);
>   
>   #define CCI_EXT_ATTR_ENTRY(_name, _func, _config) 				\
> @@ -1451,7 +1451,7 @@ static int cci_pmu_offline_cpu(unsigned int cpu)
>   	return 0;
>   }
>   
> -static struct cci_pmu_model cci_pmu_models[] = {
> +static __maybe_unused struct cci_pmu_model cci_pmu_models[] = {
>   #ifdef CONFIG_ARM_CCI400_PMU
>   	[CCI400_R0] = {
>   		.name = "CCI_400",
> 
