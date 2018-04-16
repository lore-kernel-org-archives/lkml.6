Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeDPMWY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:22:24 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46612 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbeDPMWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:22:21 -0400
X-Google-Smtp-Source: AIpwx48V3KNr7Xg8es2R5V+70w3FladQ/SGCU5USXS7oPTC7jV9J3QygTtkVwMii5onTAFsJAf0ImQ==
Date: Mon, 16 Apr 2018 13:22:17 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, alexandre.torgue@st.com,
        benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 2/6] mfd: stm32-timers: add support for dmas
Message-ID: <20180416122217.u7h3wawpdx3kj4wd@dell>
References: <1522404084-24903-1-git-send-email-fabrice.gasnier@st.com>
 <1522404084-24903-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522404084-24903-3-git-send-email-fabrice.gasnier@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018, Fabrice Gasnier wrote:

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
>  drivers/mfd/stm32-timers.c       | 219 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/stm32-timers.h |  32 ++++++
>  2 files changed, 249 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> index 1d347e5..98191ec 100644
> --- a/drivers/mfd/stm32-timers.c
> +++ b/drivers/mfd/stm32-timers.c
> @@ -4,16 +4,165 @@
>   * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
>   */
>  
> +#include <linux/bitfield.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/mfd/stm32-timers.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <linux/reset.h>
>  
> +#define STM32_TIMERS_MAX_REGISTERS	0x3fc
> +
> +struct stm32_timers_dma {
> +	struct completion completion;
> +	phys_addr_t phys_base;
> +	struct mutex lock;		/* protect dma access */

Nit: I like comments to use good grammar i.e. capital letters to
start a sentence and 's/dma/DMA/'.  Or better still, drop the comment,
we know what the lock is for.

> +	struct dma_chan *chan;
> +	struct dma_chan *chans[STM32_TIMERS_MAX_DMAS];

This requires explanation.  Maybe a kerneldoc header would be good here.

[...]

> +/**
> + * stm32_timers_dma_burst_read - Read from timers registers using DMA.
> + *
> + * Read from STM32 timers registers using DMA on a single event.
> + * @dev: reference to stm32_timers MFD device
> + * @buf: dma'able destination buffer
> + * @id: stm32_timers_dmas event identifier (ch[1..4], up, trig or com)
> + * @reg: registers start offset for DMA to read from (like CCRx for capture)
> + * @num_reg: number of registers to read upon each dma request, starting @reg.
> + * @bursts: number of bursts to read (e.g. like two for pwm period capture)
> + * @tmo_ms: timeout (milliseconds)
> + */
> +int stm32_timers_dma_burst_read(struct device *dev, u32 *buf,
> +				enum stm32_timers_dmas id, u32 reg,
> +				unsigned int num_reg, unsigned int bursts,
> +				unsigned long tmo_ms)
> +{
> +	struct stm32_timers *ddata = dev_get_drvdata(dev);
> +	unsigned long timeout = msecs_to_jiffies(tmo_ms);
> +	struct regmap *regmap = ddata->regmap;
> +	struct stm32_timers_dma *dma = ddata->dma;
> +	size_t len = num_reg * bursts * sizeof(u32);
> +	struct dma_async_tx_descriptor *desc;
> +	struct dma_slave_config config;
> +	dma_cookie_t cookie;
> +	dma_addr_t dma_buf;
> +	u32 dbl, dba;
> +	long err;
> +	int ret;
> +
> +	/* sanity check */

Proper grammar in all comments please.

"Sanity check"

[...]

> +	/* select dma channel in use */

Here too.

Etc, etc, etc ...

> +	dma->chan = dma->chans[id];
> +	dma_buf = dma_map_single(dev, buf, len, DMA_FROM_DEVICE);
> +	ret = dma_mapping_error(dev, dma_buf);
> +	if (ret)
> +		goto unlock;
> +
> +	/* Prepare DMA read from timer registers, using DMA burst mode */

This is good.
[...]

[...]

> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index 2aadab6..585a4de 100644
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

> +enum stm32_timers_dmas {
> +	STM32_TIMERS_DMA_CH1,
> +	STM32_TIMERS_DMA_CH2,
> +	STM32_TIMERS_DMA_CH3,
> +	STM32_TIMERS_DMA_CH4,
> +	STM32_TIMERS_DMA_UP,
> +	STM32_TIMERS_DMA_TRIG,
> +	STM32_TIMERS_DMA_COM,
> +	STM32_TIMERS_MAX_DMAS,
> +};
> +
> +struct stm32_timers_dma;

Why don't you move the declaration into here?

Then you don't need to forward declare.

>  struct stm32_timers {
>  	struct clk *clk;
>  	struct regmap *regmap;
>  	u32 max_arr;
> +	struct stm32_timers_dma *dma;
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
