Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753777AbeBBSET (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:04:19 -0500
Received: from vern.gendns.com ([206.190.152.46]:48475 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753828AbeBBSDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:03:35 -0500
Subject: Re: [PATCH v6 20/41] ARM: da830: add new clock init using common
 clock framework
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-21-git-send-email-david@lechnology.com>
 <4b2f45f5-7f0d-f0e6-6854-9992e19f45f2@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <e5eb68e8-eb53-331d-5941-95df7d295074@lechnology.com>
Date: Fri, 2 Feb 2018 12:03:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <4b2f45f5-7f0d-f0e6-6854-9992e19f45f2@ti.com>
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

On 02/02/2018 08:12 AM, Sekhar Nori wrote:
> On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
>>   void __init da830_init_time(void)
>>   {
>> +#ifdef CONFIG_COMMON_CLK
>> +	void __iomem *pll0, *psc0, *psc1;
>> +	struct clk *clk;
>> +
>> +	pll0 = ioremap(DA8XX_PLL0_BASE, SZ_4K);
>> +	psc0 = ioremap(DA8XX_PSC0_BASE, SZ_4K);
>> +	psc1 = ioremap(DA8XX_PSC1_BASE, SZ_4K);
>> +
>> +	da8xx_register_cfgchip();
>> +
>> +	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
>> +
>> +	da830_pll_clk_init(pll0);
>> +
>> +	da830_psc_clk_init(psc0, psc1);
>> +
> 
>> +	clk = clk_register_fixed_factor(NULL, "i2c0", "pll0_aux_clk", 0, 1, 1);
>> +	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
>> +
>> +	clk = clk_register_fixed_factor(NULL, "timer0", "pll0_aux_clk", 0, 1, 1);
>> +	clk_register_clkdev(clk, "timer0", NULL);
>> +
>> +	clk = clk_register_fixed_factor(NULL, "timer1", "pll0_aux_clk", 0, 1, 1);
>> +	clk_register_clkdev(clk, NULL, "davinci-wdt");
> 
> Isn't this better done in da830_pll_clk_init() ? I think we can get rid
> of the dummy fixed factor clock too and directly use the pll0_auxclk.


I considered it, but I kind of like keeping the fixed factor clocks for
debugging purposes. If you just have "pll0_auxclk" the enable count is
not helpful because you don't know which driver did the enabling.

On the other hand, once things are working, you don't really need to
do any debugging.


> That reminds me, is "pll0_aux_clk" above correct, or should it be
> "pll0_auxclk" like in da830_pll_clk_init()?

Yes, it should be "pll0_auxclk".

> 
>> +
>> +	clk = clk_register_fixed_factor(NULL, "rmii", "pll0_sysclk7", 0, 1, 1);
>> +	clk_register_clkdev(clk, "rmii", NULL);
> 
> I don't see any driver looking for this clock using con_id "rmii". I
> know this came from existing code. But its most likely a vestige and can
> be dropped.
> 
> Thanks,
> Sekhar
> 
