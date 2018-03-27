Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeC0PGv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:06:51 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37612 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752526AbeC0PGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:06:49 -0400
X-Google-Smtp-Source: AG47ELt/YKaDibIrMoO16P3dC4k197vN+XVfsw7+BCtsJhB6/3643Mro75gGLlWzL5q08bkQhl/Brw==
Date: Tue, 27 Mar 2018 10:06:47 -0500
From: Rob Herring <robh@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: daniel.lezcano@linaro.org, tglx@linutronix.de, mark.rutland@arm.com,
        aisheng.dong@nxp.com, Linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] clocksource/drivers/imx-tpm: correct some registers
 operation flow
Message-ID: <20180327150647.l3qyrngxehpdwm7e@rob-hp-laptop>
References: <1522050461-19043-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522050461-19043-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 03:47:40PM +0800, Anson Huang wrote:
> According to i.MX7ULP reference manual, TPM_SC_CPWMS can ONLY be
> written when counter is disabled, TPM_SC_TOF is write-1-clear,
> TPM_C0SC_CHF is also write-1-clear, correct these registers
> initialization flow;
> 
> Replace incorret clock name igp with ipg.

incorrect

This looks like an unrelated change.

> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt |  2 +-

Though you have the same typo, this should be a separate change from the 
driver.

>  drivers/clocksource/timer-imx-tpm.c                       | 10 ++++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
> index b4aa7dd..f82087b 100644
> --- a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
> @@ -15,7 +15,7 @@ Required properties:
>  - interrupts :	Should be the clock event device interrupt.
>  - clocks :	The clocks provided by the SoC to drive the timer, must contain
>  		an entry for each entry in clock-names.
> -- clock-names : Must include the following entries: "igp" and "per".
> +- clock-names : Must include the following entries: "ipg" and "per".
>  
>  Example:
>  tpm5: tpm@40260000 {
> diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
> index 21bffdc..7403e49 100644
> --- a/drivers/clocksource/timer-imx-tpm.c
> +++ b/drivers/clocksource/timer-imx-tpm.c
> @@ -20,6 +20,7 @@
>  #define TPM_SC				0x10
>  #define TPM_SC_CMOD_INC_PER_CNT		(0x1 << 3)
>  #define TPM_SC_CMOD_DIV_DEFAULT		0x3
> +#define TPM_SC_TOF_MASK			(0x1 << 7)
>  #define TPM_CNT				0x14
>  #define TPM_MOD				0x18
>  #define TPM_STATUS			0x1c
> @@ -29,6 +30,7 @@
>  #define TPM_C0SC_MODE_SHIFT		2
>  #define TPM_C0SC_MODE_MASK		0x3c
>  #define TPM_C0SC_MODE_SW_COMPARE	0x4
> +#define TPM_C0SC_CHF_MASK		(0x1 << 7)
>  #define TPM_C0V				0x24
>  
>  static void __iomem *timer_base;
> @@ -179,7 +181,7 @@ static int __init tpm_timer_init(struct device_node *np)
>  	ipg = of_clk_get_by_name(np, "ipg");
>  	per = of_clk_get_by_name(np, "per");
>  	if (IS_ERR(ipg) || IS_ERR(per)) {
> -		pr_err("tpm: failed to get igp or per clk\n");
> +		pr_err("tpm: failed to get ipg or per clk\n");
>  		ret = -ENODEV;
>  		goto err_clk_get;
>  	}
> @@ -205,9 +207,13 @@ static int __init tpm_timer_init(struct device_node *np)
>  	 * 4) Channel0 disabled
>  	 * 5) DMA transfers disabled
>  	 */
> +	/* make sure counter is disabled */
>  	writel(0, timer_base + TPM_SC);
> +	/* TOF is W1C */
> +	writel(TPM_SC_TOF_MASK, timer_base + TPM_SC);
>  	writel(0, timer_base + TPM_CNT);
> -	writel(0, timer_base + TPM_C0SC);
> +	/* CHF is W1C */
> +	writel(TPM_C0SC_CHF_MASK, timer_base + TPM_C0SC);
>  
>  	/* increase per cnt, div 8 by default */
>  	writel(TPM_SC_CMOD_INC_PER_CNT | TPM_SC_CMOD_DIV_DEFAULT,
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
