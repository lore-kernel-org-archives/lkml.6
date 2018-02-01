Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754641AbeBATEJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:04:09 -0500
Received: from vern.gendns.com ([206.190.152.46]:52977 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753341AbeBATED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:04:03 -0500
Subject: Re: [PATCH v6 04/41] clk: davinci: Add platform information for TI
 DA850 PLL
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-5-git-send-email-david@lechnology.com>
 <834cb7ce-9406-a806-3ec1-a59766bd8a9d@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <6f0146e4-72bc-7bc2-2135-44950949cd77@lechnology.com>
Date: Thu, 1 Feb 2018 13:04:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <834cb7ce-9406-a806-3ec1-a59766bd8a9d@ti.com>
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

On 02/01/2018 02:58 AM, Sekhar Nori wrote:
> On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
>> This adds platform-specific declarations for the PLL clocks on TI DA850/
>> OMAP-L138/AM18XX SoCs.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
>> +static const struct davinci_pll_clk_info da850_pll1_info __initconst = {
>> +	.name = "pll1",
>> +	.unlock_reg = CFGCHIP(3),
>> +	.unlock_mask = CFGCHIP3_PLL1_MASTER_LOCK,
> 
> I guess this will change with the cfgchip handling discussion last week.

Actually no, there really weren't any changes to the clock drivers because
of this change. Only a small change in mach-davinci.

> 
>> +	.pllm_mask = GENMASK(4, 0),
>> +	.pllm_min = 4,
>> +	.pllm_max = 32,
>> +	.pllout_min_rate = 300000000,
>> +	.pllout_max_rate = 600000000,
>> +	.flags = PLL_HAS_POSTDIV,
>> +};
>> +
> 
> [...]
> 
>> +void __init da850_pll_clk_init(void __iomem *pll0, void __iomem *pll1)
>> +{
>> +	const struct davinci_pll_sysclk_info *info;
>> +
>> +	davinci_pll_clk_register(&da850_pll0_info, "ref_clk", pll0);
>> +
>> +	davinci_pll_auxclk_register("pll0_auxclk", pll0);
>> +
>> +	for (info = da850_pll0_sysclk_info; info->name; info++)
>> +		davinci_pll_sysclk_register(info, pll0);
>> +
>> +	davinci_pll_obsclk_register(&da850_pll0_obsclk_info, pll0);
>> +
>> +	davinci_pll_clk_register(&da850_pll1_info, "oscin", pll1);
> 
> Both PLL0 and PLL1 use the same reference clock. So this should be
> "ref_clk". I dont think we ever need to register a clock called oscin
> along with "ref_clk". There is only one reference clock. It can either
> be obtained using internal oscillator or external oscillator.
> 

As per my response to the previous path, this depends on which both
which SoC and which diagram in the TRM for that SoC you are looking at.
It works either way.
