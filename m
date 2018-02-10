Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbeBJQZk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 11:25:40 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35269 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJQZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 11:25:38 -0500
X-Google-Smtp-Source: AH8x226WulxcPCBr6YOhdG5Ab9vkgcNtpZ+Bm/dmX0iRCulowq+IjdfZ2HhbqSaIiAaCW+H1k4cEKHBX0iipq4mWVkw=
MIME-Version: 1.0
In-Reply-To: <20180118235836.17393-1-stefan@agner.ch>
References: <20180118235836.17393-1-stefan@agner.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 10 Feb 2018 14:25:37 -0200
Message-ID: <CAOMZO5CBTTi2QMfM0yDVEMTYm06pGyasUcaLWD8wDHiVi9oshg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: imx6q: support frequencies >528MHz for i.MX6UL/ULL
To: Stefan Agner <stefan@agner.ch>, Yongcai Huang <anson.huang@nxp.com>
Cc: rjw@rjwysocki.net, viresh kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>, max.oss.09@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Octavian Purdila <octavian.purdila@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Thu, Jan 18, 2018 at 9:58 PM, Stefan Agner <stefan@agner.ch> wrote:
> Depending on SKU i.MX6UL/i.MX6ULL support frequencies up to 900MHz.
> Use PLL1 sys clock for all operating points higher than 528MHz.
>
> Note: For higher operating points VDD_SOC_IN needs to be 125mV
> higher than the ARM set-point (see datasheet). Specifically, the
> i.MX6UL/ULL EVK boards have an external DC regulator which needs
> adjustment. The regulator adjustment is not covered with this
> change.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 628fe899cb48..840f6386c780 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -114,12 +114,14 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>                  */
>                 clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
>                 clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> -               if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> -                       clk_set_parent(secondary_sel_clk, pll2_bus_clk);
> -               else
> -                       clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
> -               clk_set_parent(step_clk, secondary_sel_clk);
> -               clk_set_parent(pll1_sw_clk, step_clk);
> +               if (freq_hz <= clk_get_rate(pll2_bus_clk)) {
> +                       if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> +                               clk_set_parent(secondary_sel_clk, pll2_bus_clk);
> +                       else
> +                               clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
> +                       clk_set_parent(step_clk, secondary_sel_clk);
> +                       clk_set_parent(pll1_sw_clk, step_clk);
> +               }
>         } else {
>                 clk_set_parent(step_clk, pll2_pfd2_396m_clk);
>                 clk_set_parent(pll1_sw_clk, step_clk);

Could you please help reviewing this patch?

Thanks
