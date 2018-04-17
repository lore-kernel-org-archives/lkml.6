Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeDQHM5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:12:57 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40940 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeDQHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:12:55 -0400
X-Google-Smtp-Source: AIpwx4/PRZelIwFnLEjfH8aBfSyOQG5gXg26Shz526jg3T8ar4jLHn5vvAr75dTZrIamW2fUr5cIgw==
Date: Tue, 17 Apr 2018 08:12:50 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: alexandre.torgue@st.com, thierry.reding@gmail.com,
        benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 2/6] mfd: stm32-timers: add support for dmas
Message-ID: <20180417071250.yhgl7c7apn7w53xf@dell>
References: <1523895561-4073-1-git-send-email-fabrice.gasnier@st.com>
 <1523895561-4073-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523895561-4073-3-git-send-email-fabrice.gasnier@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018, Fabrice Gasnier wrote:

> STM32 Timers can support up to 7 DMA requests:
> - 4 channels, update, compare and trigger.
> Optionally request part, or all DMAs from stm32-timers MFD core.
> 
> Also add routine to implement burst reads using DMA from timer registers.
> This is exported. So, it can be used by child drivers, PWM capture
> for instance (but not limited to).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
> Changes in v4:
> - Lee's comments: Add kerneldoc header, better format comments.
> Changes in v3:
> - Basically Lee's comments:
> - rather create a struct stm32_timers_dma, and place a reference to it
>   in existing ddata (instead of adding priv struct).
> - rather use a struct device in exported routine prototype, and use
>   standard helpers instead of ddata. Get rid of to_stm32_timers_priv().
> - simplify error handling in probe (remove a goto)
> - comment on devm_of_platform_*populate() usage.
> 
> Changes in v2:
> - Abstract DMA handling from child driver: move it to MFD core
> - Add comments on optional dma support
> ---
>  drivers/mfd/stm32-timers.c       | 227 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/stm32-timers.h |  32 ++++++
>  2 files changed, 257 insertions(+), 2 deletions(-)

[...]

> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index 2aadab6..a04d7a1 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -8,6 +8,8 @@
>  #define _LINUX_STM32_GPTIMER_H_
>  
>  #include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/regmap.h>

[...]

> +struct stm32_timers_dma;
> +
>  struct stm32_timers {
>  	struct clk *clk;
>  	struct regmap *regmap;
>  	u32 max_arr;
> +	struct stm32_timers_dma *dma; /* Only to be used by the parent */

I'm confused.  I thought the point of putting this comment in was so
that you could place the definition of 'stm32_timers_dma' and remove
the forward declaration?

>  };
> +
> +int stm32_timers_dma_burst_read(struct device *dev, u32 *buf,
> +				enum stm32_timers_dmas id, u32 reg,
> +				unsigned int num_reg, unsigned int bursts,
> +				unsigned long tmo_ms);
>  #endif

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
