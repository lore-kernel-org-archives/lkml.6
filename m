Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753059AbeBFMUj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:20:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752810AbeBFMUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:20:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2406621738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x225aK7jXelHwLqW6nQ9G0BM/S9QMoENj6Lvcl2SnXYljH13O4tn44EOOszS1goNPIzZ6Vn5jivM/cXrhp0vGF9g=
MIME-Version: 1.0
In-Reply-To: <20180205154403.13520-3-s.nawrocki@samsung.com>
References: <CGME20180205154511epcas1p14dccb00b68fdb688f2c427c56e01c052@epcas1p1.samsung.com>
 <20180205154403.13520-1-s.nawrocki@samsung.com> <20180205154403.13520-3-s.nawrocki@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 6 Feb 2018 13:20:28 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeUPyX89u1csm98huKLEGX_xjaPr_wuqwuyoQWwurQbUg@mail.gmail.com>
Message-ID: <CAJKOXPeUPyX89u1csm98huKLEGX_xjaPr_wuqwuyoQWwurQbUg@mail.gmail.com>
Subject: Re: [PATCH 2/8] ASoC: samsung: i2s: Ensure names of supplied clocks
 are unique
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, jcsing.lee@samsung.com,
        sbkim73@samsung.com, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 4:43 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> In order to support multiple instances of the I2S IP block the platform
> device name is prepended to each clock registered by the driver.
> The clock-output-names property is now not used, this should not cause
> any issues as, for example, CDCLK clock is referenced through DT 'clocks'
> property, not by name.
>
> This change allows to have both I2S0 and I2S1 enabled simultaneously
> on exynos5433 and working properly when #clock-cells property is specified
> in respective DT nodes.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index aeba0ae890ea..b7d25a63da8b 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -1193,11 +1193,13 @@ static void i2s_unregister_clock_provider(struct platform_device *pdev)
>
>  static int i2s_register_clock_provider(struct platform_device *pdev)
>  {
> -       struct device *dev = &pdev->dev;
> -       struct i2s_dai *i2s = dev_get_drvdata(dev);
> +       const char * const i2s_clk_desc[] = { "cdclk", "rclk_src", "prescaler" };
>         const char *clk_name[2] = { "i2s_opclk0", "i2s_opclk1" };
>         const char *p_names[2] = { NULL };
> +       struct device *dev = &pdev->dev;
> +       struct i2s_dai *i2s = dev_get_drvdata(dev);
>         const struct samsung_i2s_variant_regs *reg_info = i2s->variant_regs;
> +       const char *i2s_clk_name[ARRAY_SIZE(i2s_clk_desc)];
>         struct clk *rclksrc;
>         int ret, i;
>
> @@ -1214,30 +1216,35 @@ static int i2s_register_clock_provider(struct platform_device *pdev)
>                 clk_put(rclksrc);
>         }
>
> +       for (i = 0; i < ARRAY_SIZE(i2s_clk_desc); i++)
> +               i2s_clk_name[i] = devm_kasprintf(dev, GFP_KERNEL, "%s_%s",
> +                                               dev_name(dev), i2s_clk_desc[i]);

kasprintf() might return NULL and later it is being used as clock
name. I think you should handle such error.

Best regards,
Krzysztof

> +
>         if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
>                 /* Activate the prescaler */
>                 u32 val = readl(i2s->addr + I2SPSR);
>                 writel(val | PSR_PSREN, i2s->addr + I2SPSR);
>
>                 i2s->clk_table[CLK_I2S_RCLK_SRC] = clk_register_mux(dev,
> -                               "i2s_rclksrc", p_names, ARRAY_SIZE(p_names),
> +                               i2s_clk_name[CLK_I2S_RCLK_SRC], p_names,
> +                               ARRAY_SIZE(p_names),
>                                 CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>                                 i2s->addr + I2SMOD, reg_info->rclksrc_off,
>                                 1, 0, i2s->lock);
>
>                 i2s->clk_table[CLK_I2S_RCLK_PSR] = clk_register_divider(dev,
> -                               "i2s_presc", "i2s_rclksrc",
> +                               i2s_clk_name[CLK_I2S_RCLK_PSR],
> +                               i2s_clk_name[CLK_I2S_RCLK_SRC],
>                                 CLK_SET_RATE_PARENT,
>                                 i2s->addr + I2SPSR, 8, 6, 0, i2s->lock);
>
> -               p_names[0] = "i2s_presc";
> +               p_names[0] = i2s_clk_name[CLK_I2S_RCLK_PSR];
>                 i2s->clk_data.clk_num = 2;
>         }
> -       of_property_read_string_index(dev->of_node,
> -                               "clock-output-names", 0, &clk_name[0]);
>
> -       i2s->clk_table[CLK_I2S_CDCLK] = clk_register_gate(dev, clk_name[0],
> -                               p_names[0], CLK_SET_RATE_PARENT,
> +       i2s->clk_table[CLK_I2S_CDCLK] = clk_register_gate(dev,
> +                               i2s_clk_name[CLK_I2S_CDCLK], p_names[0],
> +                               CLK_SET_RATE_PARENT,
>                                 i2s->addr + I2SMOD, reg_info->cdclkcon_off,
>                                 CLK_GATE_SET_TO_DISABLE, i2s->lock);
>
> --
> 2.14.2
>
