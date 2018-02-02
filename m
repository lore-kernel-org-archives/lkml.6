Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeBBR5L (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:57:11 -0500
Received: from vern.gendns.com ([206.190.152.46]:48197 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752673AbeBBR4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:56:07 -0500
Subject: Re: [PATCH v6 18/41] clk: davinci: New driver for TI DA8XX CFGCHIP
 clocks
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-19-git-send-email-david@lechnology.com>
 <c2138795-edcd-bb7d-094d-47dc049c33df@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <af157fd3-f1da-cf17-8b1a-47223ac3fd39@lechnology.com>
Date: Fri, 2 Feb 2018 11:56:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <c2138795-edcd-bb7d-094d-47dc049c33df@ti.com>
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

On 02/02/2018 07:19 AM, Sekhar Nori wrote:
> On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
>> +static const struct clk_ops da8xx_cfgchip_div4p5_clk_ops = {
>> +	.enable		= da8xx_cfgchip_gate_clk_enable,
>> +	.disable	= da8xx_cfgchip_gate_clk_disable,
>> +	.is_enabled	= da8xx_cfgchip_gate_clk_is_enabled,
> 
> I assume the reason for not using clk-gate.c is lack of regmap support
> there?

Correct.

I couldn't find a way to get a lock from the regmap that could
be passed to clk_register_gate() to prevent non-clock drivers from
trying to use the regmap at the same the the clocks are.

> 
>> +	.recalc_rate	= da8xx_cfgchip_div4p5_recalc_rate,
>> +};
>> +
>> +static struct clk * __init
>> +da8xx_cfgchip_gate_clk_register(const struct da8xx_cfgchip_gate_clk_info *info,
>> +				const char *parent_name,
>> +				struct regmap *regmap)
>> +{
>> +	struct da8xx_cfgchip_gate_clk *gate;
>> +	struct clk_init_data init;
>> +
>> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
>> +	if (!gate)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	init.name = info->name;
>> +	if (info->flags & DA8XX_GATE_CLOCK_IS_DIV4P5)
>> +		init.ops = &da8xx_cfgchip_div4p5_clk_ops;
>> +	else
>> +		init.ops = &da8xx_cfgchip_gate_clk_ops;
> 
> This will be easier to read using ternary operator, I think. But you
> will probably have line breaks.

The names are so long that the ternary operator doesn't make it better IMHO.

	init.ops = (info->flags & DA8XX_GATE_CLOCK_IS_DIV4P5) ?
		&da8xx_cfgchip_div4p5_clk_ops :
		&da8xx_cfgchip_gate_clk_ops;
