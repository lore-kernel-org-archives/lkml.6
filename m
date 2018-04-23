Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754715AbeDWKo4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:44:56 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51242 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754078AbeDWKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:44:54 -0400
X-Google-Smtp-Source: AIpwx4+PZLH01oDz7YmAt0iq3/h3cBXbnKd6pQv8gfZY+XYb8mM/8HpRqfBGytxM6+upBaQUo1FzVI6W4bfRH16M10g=
MIME-Version: 1.0
In-Reply-To: <20180419104019.24406-6-enric.balletbo@collabora.com>
References: <20180419104019.24406-1-enric.balletbo@collabora.com> <20180419104019.24406-6-enric.balletbo@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Apr 2018 12:44:52 +0200
Message-ID: <CAPDyKFpQUFSoUC=FjAjfk5An0yCKWEcwjrBxqXYv8GakvWe4mA@mail.gmail.com>
Subject: Re: [PATCH 5/6] devfreq: rk3399_dmc: do not print error when get
 supply and clk defer.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, Linux PM <linux-pm@vger.kernel.org>,
        Derek Basehore <dbasehore@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@google.com>, groek@google.com,
        kernel@collabora.com, Lin Huang <hl@rock-chips.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 April 2018 at 12:40, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: Lin Huang <hl@rock-chips.com>
>
> We just return -EPROBE_DEFER error code to caller and do not
> print error message when try to get center logic regulator
> and DMC clock defer.
>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/devfreq/rk3399_dmc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 44a379657cd5..5bfca028eaaf 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -308,12 +308,18 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>
>         data->vdd_center = devm_regulator_get(dev, "center");
>         if (IS_ERR(data->vdd_center)) {
> +               if (PTR_ERR(data->vdd_center) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +
>                 dev_err(dev, "Cannot get the regulator \"center\"\n");

Doesn't the clock core already print an error message for this?

Maybe a better way is simply to drop the printing instead of trying to
have a special case for it?

>                 return PTR_ERR(data->vdd_center);
>         }
>
>         data->dmc_clk = devm_clk_get(dev, "dmc_clk");
>         if (IS_ERR(data->dmc_clk)) {
> +               if (PTR_ERR(data->dmc_clk) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +
>                 dev_err(dev, "Cannot get the clk dmc_clk\n");
>                 return PTR_ERR(data->dmc_clk);
>         };
> --
> 2.17.0
>

Kind regards
Uffe
