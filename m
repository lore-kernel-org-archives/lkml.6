Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbeEOPnA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 11:43:00 -0400
Received: from vern.gendns.com ([206.190.152.46]:36095 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752318AbeEOPm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 11:42:58 -0400
Subject: Re: [PATCH v10 02/27] clk: davinci: da850-pll: change PLL0 to
 CLK_OF_DECLARE
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <20180509172606.29387-1-david@lechnology.com>
 <20180509172606.29387-3-david@lechnology.com>
 <9203489d-0a5a-103a-67ea-d3e89bb7ebc4@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <88dec9b1-5f4d-a1ac-2b63-b30ae7665851@lechnology.com>
Date: Tue, 15 May 2018 10:42:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9203489d-0a5a-103a-67ea-d3e89bb7ebc4@ti.com>
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

On 05/15/2018 08:31 AM, Sekhar Nori wrote:
> On Wednesday 09 May 2018 10:55 PM, David Lechner wrote:
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

In your previous review, you pointed out that the error did not need to
be handled here because it is handled later in davinci_pll_clk_register().

We get a warning there because cfgchip is only needed for unlocking the
PLL for CPU frequency scaling and is not critical for operation of the
clocks.

> 
> It will be nice to handle the error case here.
> 
>> +
>> +	of_davinci_pll_init(NULL, node, &da850_pll0_info,
>> +			    &da850_pll0_obsclk_info,
>> +			    da850_pll0_sysclk_info, 7, base, cfgchip);
> 
> Apart from that, it looks good to me.
> 
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
> 
> Thanks,
> Sekhar
> 
