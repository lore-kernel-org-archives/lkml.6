Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbeCRMsA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:48:00 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46587 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeCRMr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:47:56 -0400
X-Google-Smtp-Source: AG47ELv5aHJHjrlVNg/PhkFy0lcsyuptxY/nGb6IJnj9afUOl/RtRu1DGwvB4cui6AZll+04lf9m7Q==
Date: Sun, 18 Mar 2018 07:47:53 -0500
From: Rob Herring <robh@kernel.org>
To: gabriel.fernandez@st.com
Cc: sboyd@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, gabriel.fernandez.st@gmail.com,
        olivier.bideau@st.com, Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH RESEND 2/2] clk: stm32: Add DSI clock for STM32F469 Board
Message-ID: <20180318124753.nbjbs5deslihl7ir@rob-hp-laptop>
References: <1520578651-28849-1-git-send-email-gabriel.fernandez@st.com>
 <1520578651-28849-3-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520578651-28849-3-git-send-email-gabriel.fernandez@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 07:57:31AM +0100, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch adds DSI clock for STM32F469 board
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  drivers/clk/clk-stm32f4.c                 | 11 ++++++++++-
>  include/dt-bindings/clock/stm32fx-clock.h |  3 ++-
>  2 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
> index 96c6b6b..d15bae6 100644
> --- a/drivers/clk/clk-stm32f4.c
> +++ b/drivers/clk/clk-stm32f4.c
> @@ -521,7 +521,7 @@ struct stm32f4_pll_data {
>  };
>  
>  static const struct stm32f4_pll_data stm32f469_pll[MAX_PLL_DIV] = {
> -	{ PLL,	   50, { "pll",	     "pll-q",    NULL	    } },
> +	{ PLL,	   50, { "pll",	     "pll-q",    "pll-r"    } },
>  	{ PLL_I2S, 50, { "plli2s-p", "plli2s-q", "plli2s-r" } },
>  	{ PLL_SAI, 50, { "pllsai-p", "pllsai-q", "pllsai-r" } },
>  };
> @@ -1047,6 +1047,8 @@ static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
>  	"no-clock", "lse", "lsi", "hse-rtc"
>  };
>  
> +static const char *dsi_parent[2] = { NULL, "pll-r" };
> +
>  static const char *lcd_parent[1] = { "pllsai-r-div" };
>  
>  static const char *i2s_parents[2] = { "plli2s-r", NULL };
> @@ -1156,6 +1158,12 @@ struct stm32f4_clk_data {
>  		NO_GATE, 0,
>  		0
>  	},
> +	{
> +		CLK_F469_DSI, "dsi", dsi_parent, ARRAY_SIZE(dsi_parent),
> +		STM32F4_RCC_DCKCFGR, 29, 1,
> +		STM32F4_RCC_APB2ENR, 27,
> +		CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT
> +	},
>  };
>  
>  static const struct stm32_aux_clk stm32f746_aux_clk[] = {
> @@ -1450,6 +1458,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
>  	stm32f4_gate_map = data->gates_map;
>  
>  	hse_clk = of_clk_get_parent_name(np, 0);
> +	dsi_parent[0] = hse_clk;
>  
>  	i2s_in_clk = of_clk_get_parent_name(np, 1);
>  
> diff --git a/include/dt-bindings/clock/stm32fx-clock.h b/include/dt-bindings/clock/stm32fx-clock.h
> index 4d523b0..58d8b51 100644
> --- a/include/dt-bindings/clock/stm32fx-clock.h
> +++ b/include/dt-bindings/clock/stm32fx-clock.h
> @@ -35,8 +35,9 @@
>  #define CLK_SAIQ_PDIV		13
>  #define CLK_HSI			14
>  #define CLK_SYSCLK		15
> +#define CLK_F469_DSI		16
>  
> -#define END_PRIMARY_CLK		16
> +#define END_PRIMARY_CLK		17
>  
>  #define CLK_HDMI_CEC		16
>  #define CLK_SPDIF		17
> -- 
> 1.9.1
> 
