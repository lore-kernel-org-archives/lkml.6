Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751079AbeEBBoz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:44:55 -0400
Received: from vern.gendns.com ([206.190.152.46]:52521 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750743AbeEBBox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:44:53 -0400
Subject: Re: [PATCH v9 01/27] clk: davinci: pll: allow dev == NULL
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-2-david@lechnology.com>
 <7f968fd3-eb0e-37ba-9f2d-2b948640ef73@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <5177c1e3-9004-0d6e-6707-caf3c7efc884@lechnology.com>
Date: Tue, 1 May 2018 20:44:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7f968fd3-eb0e-37ba-9f2d-2b948640ef73@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2018 08:27 AM, Sekhar Nori wrote:
> On Friday 27 April 2018 05:47 AM, David Lechner wrote:
>> This modifies the TI DaVinci PLL clock driver to allow for the case
>> when dev == NULL. On some (most) SoCs that use this driver, the PLL
>> clock needs to be registered during early boot because it is used
>> for clocksource/clockevent and there will be no platform device available.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
>> diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
>> index 23a24c944f1d..7c4d808b8fdb 100644
>> --- a/drivers/clk/davinci/pll.c
>> +++ b/drivers/clk/davinci/pll.c
>> @@ -111,6 +111,31 @@ struct davinci_pll_clk {
>>   #define to_davinci_pll_clk(_hw) \
>>   	container_of((_hw), struct davinci_pll_clk, hw)
>>   
>> +static inline void *_devm_kzalloc(struct device *dev, size_t size, gfp_t flags)
>> +{
>> +	if (dev)
>> +		return devm_kzalloc(dev, size, flags);
>> +
>> +	return kzalloc(size, flags);
> 
> I would shift to using kzalloc() only. The utility of devm_kzalloc() is
> gone if you cannot always rely on it since you have to handle the free
> for the other case. Same thing for other devres APIs below.
> 

I omitted the usual unwinding on failure since if a non-platform-device
clock fails to init, then Linux won't boot anyway. I left the devm stuff
in there since there is one case where this driver is still used as a
platform device, thinking that there could be an EPROBE_DEFER. However
I think all uses of these inline functions are after the last possible
EPROBE_DEFER, so doing as you suggest is probably just fine.


>> +}
>> +
>> +static inline void *_devm_kmalloc_array(struct device *dev, size_t n,
>> +					size_t size, gfp_t flags)
>> +{
>> +	if (dev)
>> +		return devm_kmalloc_array(dev, n, size, flags);
>> +
>> +	return kmalloc_array(n, size, flags);
>> +}
>> +
>> +static inline struct clk *_devm_clk_register(struct device *dev, struct clk_hw *hw)
>> +{
>> +	if (dev)
>> +		return devm_clk_register(dev, hw);
>> +
>> +	return clk_register(NULL, hw);
>> +}
>> +
> 
> 
>> diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
>> index b1b6fb23f972..92a0978a7d29 100644
>> --- a/drivers/clk/davinci/pll.h
>> +++ b/drivers/clk/davinci/pll.h
>> @@ -11,6 +11,7 @@
>>   #include <linux/bitops.h>
>>   #include <linux/clk-provider.h>
>>   #include <linux/of.h>
>> +#include <linux/regmap.h>
>>   #include <linux/types.h>
>>   
>>   #define PLL_HAS_CLKMODE			BIT(0) /* PLL has PLLCTL[CLKMODE] */
>> @@ -94,7 +95,8 @@ struct davinci_pll_obsclk_info {
>>   struct clk *davinci_pll_clk_register(struct device *dev,
>>   				     const struct davinci_pll_clk_info *info,
>>   				     const char *parent_name,
>> -				     void __iomem *base);
>> +				     void __iomem *base,
>> +				     struct regmap *cfgchip);
>>   struct clk *davinci_pll_auxclk_register(struct device *dev,
>>   					const char *name,
>>   					void __iomem *base);
>> @@ -110,32 +112,33 @@ davinci_pll_sysclk_register(struct device *dev,
>>   			    const struct davinci_pll_sysclk_info *info,
>>   			    void __iomem *base);
>>   
>> -int of_davinci_pll_init(struct device *dev,
>> +int of_davinci_pll_init(struct device *dev, struct device_node *node,
>>   			const struct davinci_pll_clk_info *info,
>>   			const struct davinci_pll_obsclk_info *obsclk_info,
>>   			const struct davinci_pll_sysclk_info **div_info,
>>   			u8 max_sysclk_id,
>> -			void __iomem *base);
>> +			void __iomem *base,
>> +			struct regmap *cfgchip);
>>   
>>   /* Platform-specific callbacks */
>>   
>> -int da830_pll_init(struct device *dev, void __iomem *base);
>> +int da830_pll_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
>>   
>> -int da850_pll0_init(struct device *dev, void __iomem *base);
>> -int da850_pll1_init(struct device *dev, void __iomem *base);
>> -int of_da850_pll0_init(struct device *dev, void __iomem *base);
>> -int of_da850_pll1_init(struct device *dev, void __iomem *base);
>> +int da850_pll0_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
> 
> Having this declared both here and in include/linux/clk/davinci.h is
> strange. Can we include that file directly where its needed?
> 

Sure thing. There are a number of duplicates that can be eliminated.

>> diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
>> new file mode 100644
>> index 000000000000..1298cca509ac
>> --- /dev/null
>> +++ b/include/linux/clk/davinci.h
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Clock driver for TI Davinci PSC controllers
> 
> PSC/PLL controllers.
> 
> Thanks,
> Sekhar
> 
