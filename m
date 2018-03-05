Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbeCEJHw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:07:52 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:46299 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932721AbeCEJHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:07:48 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: wxt@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <0cb5a31dd94c1a5f9978dd28e37b77fc>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, shawn.lin@rock-chips.com,
        dmitry.torokhov@gmail.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, wxt@rock-chips.com
Subject: Re: [PATCH] soc: rockchip: power-domain: use clk_bulk APIs
To: Heiko Stuebner <heiko@sntech.de>
References: <20180228124143.8364-1-jeffy.chen@rock-chips.com>
 <2683576.o9hXnVZqaR@phil>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <709dc2eb-e34b-9603-3a49-3e61afb073e4@rock-chips.com>
Date: Mon, 5 Mar 2018 17:05:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2683576.o9hXnVZqaR@phil>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 2018/3/2 23:43, Heiko Stuebner wrote:
> Hi Jeffy,
> 
> Am Mittwoch, 28. Februar 2018, 13:41:43 CET schrieb Jeffy Chen:
>> Use clk_bulk APIs, and also add error handling for clk enable.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> [...]
> 
>> -	for (i = 0; i < clk_cnt; i++) {
>> -		clk = of_clk_get(node, i);
>> -		if (IS_ERR(clk)) {
>> -			error = PTR_ERR(clk);
>> +	pd->num_clks = of_count_phandle_with_args(node, "clocks",
>> +						  "#clock-cells");
>> +
>> +	pd->clks = devm_kzalloc(pmu->dev, pd->num_clks * sizeof(pd->clks[0]),

This doesn't work for rk3399, as the pd_vio doesn't have any clocks
attached.

[    0.713241] rockchip-pm-domain 
ff310000.power-management:power-controller: failed to handle node 
pd_vio: -12
[    0.714615] rockchip-pm-domain: probe of 
ff310000.power-management:power-controller failed with error -12


I think Jeffy's v2 is coming, so I assume you will drop this version?


> 
> applied for 4.17, after changing to devm_kcalloc like below:
> 
> pd->clks = devm_kcalloc(pmu->dev, pd->num_clks, sizeof(*pd->clks),
> 
> 
> Thanks
> Heiko
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> 
> 
