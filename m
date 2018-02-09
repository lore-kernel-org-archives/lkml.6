Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbeBIMFa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:05:30 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:39175 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBIMF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:05:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Feb 2018 13:05:27 +0100
From: Stefan Agner <stefan@agner.ch>
To: fabio.estevam@nxp.com, leonard.crestez@nxp.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org,
        shawnguo@kernel.org, octavian.purdila@nxp.com, max.oss.09@gmail.com,
        marcel.ziswiler@toradex.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
 i.MX6UL/ULL
In-Reply-To: <1619001.eqAapW3X4z@aspire.rjw.lan>
References: <20180118235836.17393-1-stefan@agner.ch>
 <1619001.eqAapW3X4z@aspire.rjw.lan>
Message-ID: <fedd9d818b58e5c19ad3201e68a1e55e@agner.ch>
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.2018 12:52, Rafael J. Wysocki wrote:
> On Friday, January 19, 2018 12:58:36 AM CET Stefan Agner wrote:
>> Depending on SKU i.MX6UL/i.MX6ULL support frequencies up to 900MHz.
>> Use PLL1 sys clock for all operating points higher than 528MHz.
>>
>> Note: For higher operating points VDD_SOC_IN needs to be 125mV
>> higher than the ARM set-point (see datasheet). Specifically, the
>> i.MX6UL/ULL EVK boards have an external DC regulator which needs
>> adjustment. The regulator adjustment is not covered with this
>> change.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> This makes sense to me, but I need someone with the requisite platform
> knowledge to review it.
> 

Fabio, Leonard, maybe one of you could have a look at it?

It is similar to what ("cpufreq: imx: Add support for 700MHz setpoint in
cpufreq") in downstream is doing, it avoids changing pll twice though.

And, as mentioned in the commit log, the dc_reg part is missing. This is
because it is not required on our Colibri iMX6ULL since it uses a higher
(not switchable) VDD_SOC_IN voltage by default.

--
Stefan

>> ---
>>  drivers/cpufreq/imx6q-cpufreq.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
>> index 628fe899cb48..840f6386c780 100644
>> --- a/drivers/cpufreq/imx6q-cpufreq.c
>> +++ b/drivers/cpufreq/imx6q-cpufreq.c
>> @@ -114,12 +114,14 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>>  		 */
>>  		clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
>>  		clk_set_parent(pll1_sw_clk, pll1_sys_clk);
>> -		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
>> -			clk_set_parent(secondary_sel_clk, pll2_bus_clk);
>> -		else
>> -			clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
>> -		clk_set_parent(step_clk, secondary_sel_clk);
>> -		clk_set_parent(pll1_sw_clk, step_clk);
>> +		if (freq_hz <= clk_get_rate(pll2_bus_clk)) {
>> +			if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
>> +				clk_set_parent(secondary_sel_clk, pll2_bus_clk);
>> +			else
>> +				clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
>> +			clk_set_parent(step_clk, secondary_sel_clk);
>> +			clk_set_parent(pll1_sw_clk, step_clk);
>> +		}
>>  	} else {
>>  		clk_set_parent(step_clk, pll2_pfd2_396m_clk);
>>  		clk_set_parent(pll1_sw_clk, step_clk);
>>
