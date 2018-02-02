Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753927AbeBBSFp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:05:45 -0500
Received: from vern.gendns.com ([206.190.152.46]:48539 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752513AbeBBSFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:05:07 -0500
Subject: Re: [PATCH v6 21/41] ARM: da850: add new clock init using common
 clock framework
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-22-git-send-email-david@lechnology.com>
 <73d2c30d-ee86-1269-dd4b-1ebfe88a3149@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <a54220c3-7108-1b53-9883-b4643eda2ef3@lechnology.com>
Date: Fri, 2 Feb 2018 12:05:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <73d2c30d-ee86-1269-dd4b-1ebfe88a3149@ti.com>
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

On 02/02/2018 08:20 AM, Sekhar Nori wrote:
> On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
>>   void __init da850_init_time(void)
>>   {
>> +#ifdef CONFIG_COMMON_CLK
>> +	void __iomem *pll0, *pll1, *psc0, *psc1;
>> +	struct regmap *cfgchip;
>> +	struct clk *clk;
>> +	struct clk_hw *parent;
>> +
>> +	pll0 = ioremap(DA8XX_PLL0_BASE, SZ_4K);
>> +	pll1 = ioremap(DA850_PLL1_BASE, SZ_4K);
>> +	psc0 = ioremap(DA8XX_PSC0_BASE, SZ_4K);
>> +	psc1 = ioremap(DA8XX_PSC1_BASE, SZ_4K);
>> +
>> +	cfgchip = da8xx_register_cfgchip();
>> +	if (WARN(IS_ERR(cfgchip), "failed to register CFGCHIP syscon"))
>> +		return;
>> +
>> +	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
>> +
>> +	da850_pll_clk_init(pll0, pll1);
>> +
>> +	da8xx_cfgchip_register_div4p5(cfgchip);
>> +
>> +	da8xx_cfgchip_register_async1(cfgchip);
>> +
>> +	clk = clk_register_fixed_factor(NULL, "async2", "pll0_auxclk", 0, 1, 1);
>> +	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
>> +	clk_register_clkdev(clk, "timer0", NULL);
>> +	clk_register_clkdev(clk, NULL, "davinci-wdt");
> 
> I think its better to get these clkdevs registered in
> da850_pll_clk_init() itself.

Sounds good to me.

> 
>> +
>> +	clk = da8xx_cfgchip_register_async3(cfgchip);
>> +
>> +	/* pll1_sysclk2 is not affected by CPU scaling, so use it for async3 */
>> +	parent = clk_hw_get_parent_by_index(__clk_get_hw(clk), 1);
>> +	if (parent)
>> +		clk_set_parent(clk, parent->clk);
>> +	else
>> +		pr_warn("%s: Failed to find async3 parent clock\n", __func__);
>> +
>> +	da850_psc_clk_init(psc0, psc1);
>> +
>> +	clk = clk_register_fixed_factor(NULL, "rmii", "pll0_sysclk7", 0, 1, 1);
>> +	clk_register_clkdev(clk, "rmii", NULL);
> 
> Like in da830, can drop this rmii clock, I think.
> 
> Thanks,
> Sekhar
> 
