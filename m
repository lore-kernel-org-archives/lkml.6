Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932074AbeBKQRh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 11:17:37 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:54928 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBKQRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 11:17:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Sun, 11 Feb 2018 17:17:32 +0100
From: Stefan Agner <stefan@agner.ch>
To: Anson Huang <anson.huang@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, rjw@rjwysocki.net,
        viresh kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>, max.oss.09@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Octavian Purdila <octavian.purdila@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
 i.MX6UL/ULL
In-Reply-To: <AM3PR04MB1315240E4A77431A58AC8501F5F00@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <20180118235836.17393-1-stefan@agner.ch>
 <CAOMZO5CBTTi2QMfM0yDVEMTYm06pGyasUcaLWD8wDHiVi9oshg@mail.gmail.com>
 <AM3PR04MB1315240E4A77431A58AC8501F5F00@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <79baed40abbcc72920fd133bc43e378a@agner.ch>
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.2018 02:42, Anson Huang wrote:
> Anson Huang
> Best Regards!
> 
> 
>> -----Original Message-----
>> From: Fabio Estevam [mailto:festevam@gmail.com]
>> Sent: Sunday, February 11, 2018 12:26 AM
>> To: Stefan Agner <stefan@agner.ch>; Anson Huang <anson.huang@nxp.com>
>> Cc: rjw@rjwysocki.net; viresh kumar <viresh.kumar@linaro.org>;
>> linux-pm@vger.kernel.org; Marcel Ziswiler <marcel.ziswiler@toradex.com>;
>> max.oss.09@gmail.com; linux-kernel <linux-kernel@vger.kernel.org>; Octavian
>> Purdila <octavian.purdila@nxp.com>; Fabio Estevam
>> <fabio.estevam@nxp.com>; Shawn Guo <shawnguo@kernel.org>; moderated
>> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
>> <linux-arm-kernel@lists.infradead.org>; dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
>> i.MX6UL/ULL
>>
>> Hi Anson,
>>
>> On Thu, Jan 18, 2018 at 9:58 PM, Stefan Agner <stefan@agner.ch> wrote:
>> > Depending on SKU i.MX6UL/i.MX6ULL support frequencies up to 900MHz.
>> > Use PLL1 sys clock for all operating points higher than 528MHz.
>> >
>> > Note: For higher operating points VDD_SOC_IN needs to be 125mV higher
>> > than the ARM set-point (see datasheet). Specifically, the i.MX6UL/ULL
>> > EVK boards have an external DC regulator which needs adjustment. The
>> > regulator adjustment is not covered with this change.
>> >
>> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>> > ---
>> >  drivers/cpufreq/imx6q-cpufreq.c | 14 ++++++++------
>> >  1 file changed, 8 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c
>> > b/drivers/cpufreq/imx6q-cpufreq.c index 628fe899cb48..840f6386c780
>> > 100644
>> > --- a/drivers/cpufreq/imx6q-cpufreq.c
>> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
>> > @@ -114,12 +114,14 @@ static int imx6q_set_target(struct cpufreq_policy
>> *policy, unsigned int index)
>> >                  */
>> >                 clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
>> >                 clk_set_parent(pll1_sw_clk, pll1_sys_clk);
>> > -               if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
>> > -                       clk_set_parent(secondary_sel_clk, pll2_bus_clk);
>> > -               else
>> > -                       clk_set_parent(secondary_sel_clk,
>> pll2_pfd2_396m_clk);
>> > -               clk_set_parent(step_clk, secondary_sel_clk);
>> > -               clk_set_parent(pll1_sw_clk, step_clk);
>> > +               if (freq_hz <= clk_get_rate(pll2_bus_clk)) {
>> > +                       if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
>> > +                               clk_set_parent(secondary_sel_clk,
>> pll2_bus_clk);
>> > +                       else
>> > +                               clk_set_parent(secondary_sel_clk,
>> pll2_pfd2_396m_clk);
>> > +                       clk_set_parent(step_clk, secondary_sel_clk);
>> > +                       clk_set_parent(pll1_sw_clk, step_clk);
>> > +               }
> 
> For cpufreq > 528MHz, ARM PLL needs to be set_rate, I did NOT see
> where sets ARM PLL rate?

This is done unconditionally after the if statement:

	if (of_machine_is_compatible("fsl,imx6ul") ||
	    of_machine_is_compatible("fsl,imx6ull")) {
		/*
		 * When changing pll1_sw_clk's parent to pll1_sys_clk,
		 * CPU may run at higher than 528MHz, this will lead to
		 * the system unstable if the voltage is lower than the
		 * voltage of 528MHz, so lower the CPU frequency to one
		 * half before changing CPU frequency.
		 */
		clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
		clk_set_parent(pll1_sw_clk, pll1_sys_clk);
		if (freq_hz <= clk_get_rate(pll2_bus_clk)) {
			if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
				clk_set_parent(secondary_sel_clk, pll2_bus_clk);
			else
				clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
			clk_set_parent(step_clk, secondary_sel_clk);
			clk_set_parent(pll1_sw_clk, step_clk);
		}
	} else {
		clk_set_parent(step_clk, pll2_pfd2_396m_clk);
		clk_set_parent(pll1_sw_clk, step_clk);
		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
			clk_set_rate(pll1_sys_clk, new_freq * 1000);
			clk_set_parent(pll1_sw_clk, pll1_sys_clk);
		} else {
			/* pll1_sys needs to be enabled for divider rate change to work. */
			pll1_sys_temp_enabled = true;
			clk_prepare_enable(pll1_sys_clk);
		}
	}

	/* Ensure the arm clock divider is what we expect */
	ret = clk_set_rate(arm_clk, new_freq * 1000);


--
Stefan



> 
> Anson.
> 
>> >         } else {
>> >                 clk_set_parent(step_clk, pll2_pfd2_396m_clk);
>> >                 clk_set_parent(pll1_sw_clk, step_clk);
>>
>> Could you please help reviewing this patch?
>>
>> Thanks
