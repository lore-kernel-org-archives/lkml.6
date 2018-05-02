Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeEBBqP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:46:15 -0400
Received: from vern.gendns.com ([206.190.152.46]:52579 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbeEBBqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:46:12 -0400
Subject: Re: [PATCH v9 02/27] clk: davinci: da850-pll: change PLL0 to
 CLK_OF_DECLARE
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-3-david@lechnology.com>
 <fe791ecf-ebd0-4e9e-722e-bfa07acc4ea2@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <f92d3a7c-3a1f-d267-6424-af1f38badd76@lechnology.com>
Date: Tue, 1 May 2018 20:46:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <fe791ecf-ebd0-4e9e-722e-bfa07acc4ea2@ti.com>
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

On 05/01/2018 08:46 AM, Sekhar Nori wrote:
> On Friday 27 April 2018 05:47 AM, David Lechner wrote:
>> PLL0 on davinci/da850-type device needs to be registered early in boot
>> because it is needed for clocksource/clockevent. Change the driver
>> to use CLK_OF_DECLARE for this special case.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>
>> v9 changes:
>> - new patch in v9
>>
>>
>>   drivers/clk/davinci/pll-da850.c | 26 ++++++++++++++++++++++----
>>   drivers/clk/davinci/pll.c       |  4 +++-
>>   drivers/clk/davinci/pll.h       |  2 +-
>>   3 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/davinci/pll-da850.c b/drivers/clk/davinci/pll-da850.c
>> index 00a6ece7b524..743527de1da2 100644
>> --- a/drivers/clk/davinci/pll-da850.c
>> +++ b/drivers/clk/davinci/pll-da850.c
>> @@ -12,6 +12,8 @@
>>   #include <linux/init.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mfd/da8xx-cfgchip.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of_address.h>
>>   #include <linux/of.h>
>>   #include <linux/types.h>
>>   
>> @@ -135,11 +137,27 @@ static const struct davinci_pll_sysclk_info *da850_pll0_sysclk_info[] = {
>>   	NULL
>>   };
>>   
>> -int of_da850_pll0_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
>> +void of_da850_pll0_init(struct device_node *node)
>>   {
>> -	return of_davinci_pll_init(dev, dev->of_node, &da850_pll0_info,
>> -				   &da850_pll0_obsclk_info,
>> -				   da850_pll0_sysclk_info, 7, base, cfgchip);
>> +	void __iomem *base;
>> +	struct regmap *cfgchip;
>> +
>> +	base = of_iomap(node, 0);
>> +	if (!base) {
>> +		pr_err("%s: ioremap failed\n", __func__);
>> +		return;
>> +	}
>> +
>> +	cfgchip = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
>> +	if (IS_ERR(cfgchip)) {
>> +		pr_warn("%s: failed to get cfgchip (%ld)\n", __func__,
>> +			PTR_ERR(cfgchip));
>> +		cfgchip = NULL;
>> +	}
> 
> Is this error handling for cfgchip needed here considering
> davinci_pll_clk_register() already checks and warns.

Ah, good point. I'll clean this up.
