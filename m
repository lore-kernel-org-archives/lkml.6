Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeDQEa5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 00:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750744AbeDQEa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 00:30:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618FC2175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1523263306-28665-4-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
References: <1523263306-28665-1-git-send-email-tdas@codeaurora.org>
 <1523263306-28665-4-git-send-email-tdas@codeaurora.org>
Message-ID: <152393945465.51482.14681802799278909180@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 3/3] clk: qcom: gdsc: Add support to poll CFG register to
 check GDSC state
Date: Mon, 16 Apr 2018 21:30:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-04-09 01:41:46)
> @@ -64,18 +69,43 @@ static int gdsc_hwctrl(struct gdsc *sc, bool en)
>         return regmap_update_bits(sc->regmap, sc->gdscr, HW_CONTROL_MASK, val);
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
> +
> +       return !(val & GDSC_POWER_DOWN_COMPLETE);
> +}
> +
>  static int gdsc_poll_status(struct gdsc *sc, unsigned int reg, bool en)
>  {
>         ktime_t start;
> 
>         start = ktime_get();
>         do {
> -               if (gdsc_is_enabled(sc, reg) == en)
> -                       return 0;
> +               if (sc->flags & POLL_CFG_GDSCR) {
> +                       if (gdsc_is_enabled_by_poll_cfg_reg(sc, en) == en)
> +                               return 0;
> +               } else {
> +                       if (gdsc_is_enabled(sc, reg) == en)
> +                               return 0;

Ok, I thought you would bury the is_enabled_by_poll_cfg_reg() stuff into
gdsc_is_enabled() directly. Because that function is used in one more
place than here, in gdsc_init(), to figure out if a GDSC is on at boot
time. The sc->gds_hw_ctrl check should be able to get buried into
gdsc_is_enabled() as well so that the function doesn't have to take a
register at all.

> +               }
>         } while (ktime_us_delta(ktime_get(), start) < TIMEOUT_US);
> 
> -       if (gdsc_is_enabled(sc, reg) == en)
> -               return 0;
> +       if (sc->flags & POLL_CFG_GDSCR) {
> +               if (gdsc_is_enabled_by_poll_cfg_reg(sc, en) == en)
> +                       return 0;
> +       } else {
> +               if (gdsc_is_enabled(sc, reg) == en)
> +                       return 0;
> +       }

And then this duplicate diff wouldn't happen either.

> 
>         return -ETIMEDOUT;
>  }
> @@ -254,6 +284,7 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>                 udelay(1);
> 
>                 reg = sc->gds_hw_ctrl ? sc->gds_hw_ctrl : sc->gdscr;
> +

This change shouldn't be here?

>                 ret = gdsc_poll_status(sc, reg, true);
>                 if (ret)
>                         return ret;
