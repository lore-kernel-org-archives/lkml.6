Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbeDFQkI convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbeDFQkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:40:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E2B217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1522665945-28147-4-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
References: <1522665945-28147-1-git-send-email-tdas@codeaurora.org>
 <1522665945-28147-4-git-send-email-tdas@codeaurora.org>
Message-ID: <152303280515.143116.7021012753371503067@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/3] clk: qcom: gdsc: Add support to poll CFG register to check
 GDSC state
Date: Fri, 06 Apr 2018 09:40:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-04-02 03:45:45)
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index e89584e..e0c83ba 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -83,6 +88,38 @@ static int gdsc_poll_status(struct gdsc *sc, unsigned int reg, bool en)
>         return -ETIMEDOUT;
>  }
> 
> +static int gdsc_is_enabled_by_poll_cfg_reg(struct gdsc *sc, bool en)
> +{
> +       u32 val;
> +       int ret;
> +
> +       ret = regmap_read(sc->regmap, sc->gdscr + CFG_GDSCR_OFFSET, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (en)
> +               return !!(val & GDSC_POWER_UP_COMPLETE);
> +       else
> +               return !(val & GDSC_POWER_DOWN_COMPLETE);

Make this into

	if (en)
		return ...

	return ...

> +}
> +
> +static int gdsc_poll_cfg_status(struct gdsc *sc, bool en)
> +{
> +       ktime_t start = ktime_get();
> +       ktime_t timeout =
> +               (sc->flags & GDS_TIMEOUT) ? TIMEOUT_US_GDS : TIMEOUT_US;
> +
> +       do {
> +               if (gdsc_is_enabled_by_poll_cfg_reg(sc, en) == en)
> +                       return 0;
> +       } while (ktime_us_delta(ktime_get(), start) < timeout);
> +
> +       if (gdsc_is_enabled_by_poll_cfg_reg(sc, en) == en)
> +               return 0;
> +
> +       return -ETIMEDOUT;
> +}
> +
>  static int gdsc_toggle_logic(struct gdsc *sc, bool en)
>  {
>         int ret;
> @@ -106,6 +143,9 @@ static int gdsc_toggle_logic(struct gdsc *sc, bool en)
>                 return 0;
>         }
> 
> +       if (sc->flags & POLL_CFG_GDSCR)
> +               return gdsc_poll_cfg_status(sc, en);
> +
>         if (sc->gds_hw_ctrl) {
>                 status_reg = sc->gds_hw_ctrl;
>                 /*
> @@ -258,8 +298,12 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>                  */
>                 udelay(1);
> 
> -               reg = sc->gds_hw_ctrl ? sc->gds_hw_ctrl : sc->gdscr;
> -               ret = gdsc_poll_status(sc, reg, true);
> +               if (sc->flags & POLL_CFG_GDSCR) {
> +                       ret = gdsc_poll_cfg_status(sc, true);
> +               } else {
> +                       reg = sc->gds_hw_ctrl ? sc->gds_hw_ctrl : sc->gdscr;
> +                       ret = gdsc_poll_status(sc, reg, true);
> +               }

Maybe this can be pushed into the gdsc_poll_status() function so that
we can keep the "how do we poll status bit" logic in one place.

>                 if (ret)
>                         return ret;
>         }
