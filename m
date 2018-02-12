Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933201AbeBLMCB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:02:01 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:36697 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbeBLMCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:02:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Feb 2018 13:01:57 +0100
From: Stefan Agner <stefan@agner.ch>
To: "Rafael J. Wysocki" <rafael@kernel.org>, anson.huang@nxp.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Octavian Purdila <octavian.purdila@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, max.oss.09@gmail.com,
        marcel.ziswiler@toradex.com, Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rjwysocki@gmail.com
Subject: Re: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
 i.MX6UL/ULL
In-Reply-To: <CAJZ5v0jGCzb3q5q6QxZWK7kTKHj66oHvdq=VKVXJ3TeDW_EmEA@mail.gmail.com>
References: <20180118235836.17393-1-stefan@agner.ch>
 <CAJZ5v0jGCzb3q5q6QxZWK7kTKHj66oHvdq=VKVXJ3TeDW_EmEA@mail.gmail.com>
Message-ID: <6935d5dee61697743a7cb9f0760f33d5@agner.ch>
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.02.2018 11:18, Rafael J. Wysocki wrote:
> On Fri, Jan 19, 2018 at 12:58 AM, Stefan Agner <stefan@agner.ch> wrote:
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
> Can you please rebase this on top of 4.16-rc1?  It doesn't apply for me as is.
> 

Oh I see, Anson actually already submitted a patch which makes higher
CPU rates working.

My solution is slightly different in that it avoids unnecessary parent
changes...

I will rework this patch to apply this simplification to the current
state of the driver.

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
>>                  */
>>                 clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
>>                 clk_set_parent(pll1_sw_clk, pll1_sys_clk);
>> -               if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
>> -                       clk_set_parent(secondary_sel_clk, pll2_bus_clk);
>> -               else
>> -                       clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
>> -               clk_set_parent(step_clk, secondary_sel_clk);
>> -               clk_set_parent(pll1_sw_clk, step_clk);
>> +               if (freq_hz <= clk_get_rate(pll2_bus_clk)) {
>> +                       if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
>> +                               clk_set_parent(secondary_sel_clk, pll2_bus_clk);
>> +                       else
>> +                               clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
>> +                       clk_set_parent(step_clk, secondary_sel_clk);
>> +                       clk_set_parent(pll1_sw_clk, step_clk);
>> +               }
>>         } else {
>>                 clk_set_parent(step_clk, pll2_pfd2_396m_clk);
>>                 clk_set_parent(pll1_sw_clk, step_clk);
>> --
>> 2.15.1
>>
