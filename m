Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934764AbeE2OCf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:02:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60757 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933858AbeE2OCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:02:31 -0400
Date: Tue, 29 May 2018 16:02:19 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] rtc: sun6i: Fix bit_idx value for clk_register_gate
Message-ID: <20180529140219.auat656qcl5jdru7@flea.home>
References: <20180528075032.6769-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528075032.6769-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 28, 2018 at 01:20:32PM +0530, Jagan Teki wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> clk-gate core will take bit_idx through clk_register_gate
> and then do clk_gate_ops by using BIT(bit_idx), but rtc-sun6i
> is passing bit_idx as BIT(bit_idx) it becomes BIT(BIT(bit_idx)
> which is wrong and eventually external gate clock is not enabling.
> 
> This patch fixed by passing bit index and the original change
> introduced from below commit.
> "rtc: sun6i: Add support for the external oscillator gate"
> (sha1: 	17ecd246414b3a0fe0cb248c86977a8bda465b7b)
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Cc'ing to stable and adding a Fixes tag would be great.

> ---
>  drivers/rtc/rtc-sun6i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 2e6fb275acc8..a66f40c96582 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -74,7 +74,7 @@
>  #define SUN6I_ALARM_CONFIG_WAKEUP		BIT(0)
>  
>  #define SUN6I_LOSC_OUT_GATING			0x0060
> -#define SUN6I_LOSC_OUT_GATING_EN		BIT(0)
> +#define SUN6I_LOSC_OUT_GATING_EN		0

All the other register definitions in that driver are the actual value
needed, and not the offset. Just to make it obvious that it shouldn't
be used as is, please add an _OFFSET at the end of the defined name

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
