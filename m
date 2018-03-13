Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932622AbeCMKVA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:21:00 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7487 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbeCMKU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:20:58 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 13 Mar 2018 03:20:55 -0700
Subject: Re: [PATCH v3 09/11] cpufreq: tegra124-cpufreq: extend to support
 Tegra210
To: Peter De Schrijver <pdeschrijver@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-10-git-send-email-pdeschrijver@nvidia.com>
 <85edea04-6aaf-3609-1da9-0d542ac98e7d@nvidia.com>
 <20180313095117.GX6190@tbergstrom-lnx.Nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f50eaa7b-3ce3-c18f-ca8c-e035a4f6aa7d@nvidia.com>
Date: Tue, 13 Mar 2018 10:20:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313095117.GX6190@tbergstrom-lnx.Nvidia.com>
X-Originating-IP: [10.26.11.148]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To UKMAIL101.nvidia.com
 (10.26.138.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/03/18 09:51, Peter De Schrijver wrote:
> On Mon, Mar 12, 2018 at 12:15:22PM +0000, Jon Hunter wrote:
>>
>> On 06/02/18 16:34, Peter De Schrijver wrote:
>>> Tegra210 has a very similar CPU clocking scheme than Tegra124. So add
>>> support in this driver. Also allow for the case where the CPU voltage is
>>> controlled directly by the DFLL rather than by a separate regulator object.
>>>
>>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>> ---
>>>  drivers/cpufreq/tegra124-cpufreq.c | 15 ++++++++-------
>>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
>>> index 4353025..f8e01a8 100644
>>> --- a/drivers/cpufreq/tegra124-cpufreq.c
>>> +++ b/drivers/cpufreq/tegra124-cpufreq.c
>>> @@ -64,7 +64,8 @@ static void tegra124_cpu_switch_to_pllx(struct tegra124_cpufreq_priv *priv)
>>>  {
>>>  	clk_set_parent(priv->cpu_clk, priv->pllp_clk);
>>>  	clk_disable_unprepare(priv->dfll_clk);
>>> -	regulator_sync_voltage(priv->vdd_cpu_reg);
>>> +	if (priv->vdd_cpu_reg)
>>> +		regulator_sync_voltage(priv->vdd_cpu_reg);
>>>  	clk_set_parent(priv->cpu_clk, priv->pllx_clk);
>>>  }
>>
>> OK, so this bit does not make sense to me. In the above we are switching
>> from the DFLL to the PLL (ie. disabling the DFLL) and so to ensure we
>> are operating at the correct voltage after disabling the DFLL we need to
>> sync the voltage. Seems we would need to do this for all devices, no?
>> How is the different between Tegra124 and Tegra210?
> 
> Yes. So in case of i2c the regulator framework will reapply the voltage it
> knows which in our case is the boot voltage for VDD_CPU because noone else
> from a regulator framework pov has ever changed the voltage. In case of PWM
> putting the PWM output pad in tri state will cause the OVR regulator to output
> a hardware defined voltage. This is done as part of the dfll_clk_disable()
> function. To summarize:

So this is the piece of information I was missing. Maybe add this to the
changelog so it is clear why we do not need to handle the cpu rail in
the case of PWM.

Cheers
Jon

-- 
nvpublic
