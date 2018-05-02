Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeEBJVA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:21:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46772 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750895AbeEBJU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:20:56 -0400
Subject: Re: [PATCH v5 2/6] mfd: stm32-timers: add support for dmas
To: <lee.jones@linaro.org>
CC: <alexandre.torgue@st.com>, <dan.carpenter@oracle.com>,
        <thierry.reding@gmail.com>, <benjamin.gaignard@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <benjamin.gaignard@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <1523972313-28765-1-git-send-email-fabrice.gasnier@st.com>
 <1523972313-28765-3-git-send-email-fabrice.gasnier@st.com>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <04b630f0-46c2-b63a-3b1f-f3e28d199d91@st.com>
Date: Wed, 2 May 2018 11:20:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523972313-28765-3-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 03:38 PM, Fabrice Gasnier wrote:
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
> Changes in v5:
> - fix warning on dma_mapping_error() that doesn't return an error code.
> - move stm32_timers_dma struct to header file as discussed with Lee.
>   This allows to remove alloc for this struct in stm32_timers_dma_probe.

Hi Lee,

Gentle reminder to review changes I've made in v5, following our
discussions.

Thanks in advance,
Best Regards,
Fabrice

> 
> Changes in v4:
> - Lee's comments: Add kerneldoc header, better format comments.
> 
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
>  drivers/mfd/stm32-timers.c       | 201 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/stm32-timers.h |  46 +++++++++
>  2 files changed, 245 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> index 1d347e5..efcd4b9 100644
> --- a/drivers/mfd/stm32-timers.c
> +++ b/drivers/mfd/stm32-timers.c
> @@ -4,16 +4,156 @@
>   * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/mfd/stm32-timers.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <linux/reset.h>
>  
> +#define STM32_TIMERS_MAX_REGISTERS	0x3fc
> +
> +/* DIER register DMA enable bits */
> +static const u32 stm32_timers_dier_dmaen[STM32_TIMERS_MAX_DMAS] = {
> +	TIM_DIER_CC1DE,
> +	TIM_DIER_CC2DE,
> +	TIM_DIER_CC3DE,
> +	TIM_DIER_CC4DE,
> +	TIM_DIER_UIE,
> +	TIM_DIER_TDE,
> +	TIM_DIER_COMDE
> +};
> +
> +static void stm32_timers_dma_done(void *p)
> +{
> +	struct stm32_timers_dma *dma = p;
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +
> +	status = dmaengine_tx_status(dma->chan, dma->chan->cookie, &state);
> +	if (status == DMA_COMPLETE)
> +		complete(&dma->completion);
> +}
> +
> +/**
> + * stm32_timers_dma_burst_read - Read from timers registers using DMA.
> + *
> + * Read from STM32 timers registers using DMA on a single event.
> + * @dev: reference to stm32_timers MFD device
> + * @buf: DMA'able destination buffer
> + * @id: stm32_timers_dmas event identifier (ch[1..4], up, trig or com)
> + * @reg: registers start offset for DMA to read from (like CCRx for capture)
> + * @num_reg: number of registers to read upon each DMA request, starting @reg.
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
> +	struct stm32_timers_dma *dma = &ddata->dma;
> +	size_t len = num_reg * bursts * sizeof(u32);
> +	struct dma_async_tx_descriptor *desc;
> +	struct dma_slave_config config;
> +	dma_cookie_t cookie;
> +	dma_addr_t dma_buf;
> +	u32 dbl, dba;
> +	long err;
> +	int ret;
> +
> +	/* Sanity check */
> +	if (id < STM32_TIMERS_DMA_CH1 || id >= STM32_TIMERS_MAX_DMAS)
> +		return -EINVAL;
> +
> +	if (!num_reg || !bursts || reg > STM32_TIMERS_MAX_REGISTERS ||
> +	    (reg + num_reg * sizeof(u32)) > STM32_TIMERS_MAX_REGISTERS)
> +		return -EINVAL;
> +
> +	if (!dma->chans[id])
> +		return -ENODEV;
> +	mutex_lock(&dma->lock);
> +
> +	/* Select DMA channel in use */
> +	dma->chan = dma->chans[id];
> +	dma_buf = dma_map_single(dev, buf, len, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(dev, dma_buf)) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	/* Prepare DMA read from timer registers, using DMA burst mode */
> +	memset(&config, 0, sizeof(config));
> +	config.src_addr = (dma_addr_t)dma->phys_base + TIM_DMAR;
> +	config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	ret = dmaengine_slave_config(dma->chan, &config);
> +	if (ret)
> +		goto unmap;
> +
> +	desc = dmaengine_prep_slave_single(dma->chan, dma_buf, len,
> +					   DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		ret = -EBUSY;
> +		goto unmap;
> +	}
> +
> +	desc->callback = stm32_timers_dma_done;
> +	desc->callback_param = dma;
> +	cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(cookie);
> +	if (ret)
> +		goto dma_term;
> +
> +	reinit_completion(&dma->completion);
> +	dma_async_issue_pending(dma->chan);
> +
> +	/* Setup and enable timer DMA burst mode */
> +	dbl = FIELD_PREP(TIM_DCR_DBL, bursts - 1);
> +	dba = FIELD_PREP(TIM_DCR_DBA, reg >> 2);
> +	ret = regmap_write(regmap, TIM_DCR, dbl | dba);
> +	if (ret)
> +		goto dma_term;
> +
> +	/* Clear pending flags before enabling DMA request */
> +	ret = regmap_write(regmap, TIM_SR, 0);
> +	if (ret)
> +		goto dcr_clr;
> +
> +	ret = regmap_update_bits(regmap, TIM_DIER, stm32_timers_dier_dmaen[id],
> +				 stm32_timers_dier_dmaen[id]);
> +	if (ret)
> +		goto dcr_clr;
> +
> +	err = wait_for_completion_interruptible_timeout(&dma->completion,
> +							timeout);
> +	if (err == 0)
> +		ret = -ETIMEDOUT;
> +	else if (err < 0)
> +		ret = err;
> +
> +	regmap_update_bits(regmap, TIM_DIER, stm32_timers_dier_dmaen[id], 0);
> +	regmap_write(regmap, TIM_SR, 0);
> +dcr_clr:
> +	regmap_write(regmap, TIM_DCR, 0);
> +dma_term:
> +	dmaengine_terminate_all(dma->chan);
> +unmap:
> +	dma_unmap_single(dev, dma_buf, len, DMA_FROM_DEVICE);
> +unlock:
> +	dma->chan = NULL;
> +	mutex_unlock(&dma->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(stm32_timers_dma_burst_read);
> +
>  static const struct regmap_config stm32_timers_regmap_cfg = {
>  	.reg_bits = 32,
>  	.val_bits = 32,
>  	.reg_stride = sizeof(u32),
> -	.max_register = 0x3fc,
> +	.max_register = STM32_TIMERS_MAX_REGISTERS,
>  };
>  
>  static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
> @@ -27,12 +167,45 @@ static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
>  	regmap_write(ddata->regmap, TIM_ARR, 0x0);
>  }
>  
> +static void stm32_timers_dma_probe(struct device *dev,
> +				   struct stm32_timers *ddata)
> +{
> +	int i;
> +	char name[4];
> +
> +	init_completion(&ddata->dma.completion);
> +	mutex_init(&ddata->dma.lock);
> +
> +	/* Optional DMA support: get valid DMA channel(s) or NULL */
> +	for (i = STM32_TIMERS_DMA_CH1; i <= STM32_TIMERS_DMA_CH4; i++) {
> +		snprintf(name, ARRAY_SIZE(name), "ch%1d", i + 1);
> +		ddata->dma.chans[i] = dma_request_slave_channel(dev, name);
> +	}
> +	ddata->dma.chans[STM32_TIMERS_DMA_UP] =
> +		dma_request_slave_channel(dev, "up");
> +	ddata->dma.chans[STM32_TIMERS_DMA_TRIG] =
> +		dma_request_slave_channel(dev, "trig");
> +	ddata->dma.chans[STM32_TIMERS_DMA_COM] =
> +		dma_request_slave_channel(dev, "com");
> +}
> +
> +static void stm32_timers_dma_remove(struct device *dev,
> +				    struct stm32_timers *ddata)
> +{
> +	int i;
> +
> +	for (i = STM32_TIMERS_DMA_CH1; i < STM32_TIMERS_MAX_DMAS; i++)
> +		if (ddata->dma.chans[i])
> +			dma_release_channel(ddata->dma.chans[i]);
> +}
> +
>  static int stm32_timers_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct stm32_timers *ddata;
>  	struct resource *res;
>  	void __iomem *mmio;
> +	int ret;
>  
>  	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
> @@ -43,6 +216,9 @@ static int stm32_timers_probe(struct platform_device *pdev)
>  	if (IS_ERR(mmio))
>  		return PTR_ERR(mmio);
>  
> +	/* Timer physical addr for DMA */
> +	ddata->dma.phys_base = res->start;
> +
>  	ddata->regmap = devm_regmap_init_mmio_clk(dev, "int", mmio,
>  						  &stm32_timers_regmap_cfg);
>  	if (IS_ERR(ddata->regmap))
> @@ -54,9 +230,29 @@ static int stm32_timers_probe(struct platform_device *pdev)
>  
>  	stm32_timers_get_arr_size(ddata);
>  
> +	stm32_timers_dma_probe(dev, ddata);
> +
>  	platform_set_drvdata(pdev, ddata);
>  
> -	return devm_of_platform_populate(&pdev->dev);
> +	ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> +	if (ret)
> +		stm32_timers_dma_remove(dev, ddata);
> +
> +	return ret;
> +}
> +
> +static int stm32_timers_remove(struct platform_device *pdev)
> +{
> +	struct stm32_timers *ddata = platform_get_drvdata(pdev);
> +
> +	/*
> +	 * Don't use devm_ here: enfore of_platform_depopulate() happens before
> +	 * DMA are released, to avoid race on DMA.
> +	 */
> +	of_platform_depopulate(&pdev->dev);
> +	stm32_timers_dma_remove(&pdev->dev, ddata);
> +
> +	return 0;
>  }
>  
>  static const struct of_device_id stm32_timers_of_match[] = {
> @@ -67,6 +263,7 @@ static int stm32_timers_probe(struct platform_device *pdev)
>  
>  static struct platform_driver stm32_timers_driver = {
>  	.probe = stm32_timers_probe,
> +	.remove = stm32_timers_remove,
>  	.driver	= {
>  		.name = "stm32-timers",
>  		.of_match_table = stm32_timers_of_match,
> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index 2aadab6..9596d5c 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -8,6 +8,8 @@
>  #define _LINUX_STM32_GPTIMER_H_
>  
>  #include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/regmap.h>
>  
>  #define TIM_CR1		0x00	/* Control Register 1      */
> @@ -27,6 +29,8 @@
>  #define TIM_CCR3	0x3C	/* Capt/Comp Register 3    */
>  #define TIM_CCR4	0x40	/* Capt/Comp Register 4    */
>  #define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
> +#define TIM_DCR		0x48	/* DMA control register    */
> +#define TIM_DMAR	0x4C	/* DMA register for transfer */
>  
>  #define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
>  #define TIM_CR1_DIR	BIT(4)  /* Counter Direction	   */
> @@ -36,6 +40,13 @@
>  #define TIM_SMCR_SMS	(BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
>  #define TIM_SMCR_TS	(BIT(4) | BIT(5) | BIT(6)) /* Trigger selection */
>  #define TIM_DIER_UIE	BIT(0)	/* Update interrupt	   */
> +#define TIM_DIER_UDE	BIT(8)  /* Update DMA request Enable */
> +#define TIM_DIER_CC1DE	BIT(9)  /* CC1 DMA request Enable  */
> +#define TIM_DIER_CC2DE	BIT(10) /* CC2 DMA request Enable  */
> +#define TIM_DIER_CC3DE	BIT(11) /* CC3 DMA request Enable  */
> +#define TIM_DIER_CC4DE	BIT(12) /* CC4 DMA request Enable  */
> +#define TIM_DIER_COMDE	BIT(13) /* COM DMA request Enable  */
> +#define TIM_DIER_TDE	BIT(14) /* Trigger DMA request Enable */
>  #define TIM_SR_UIF	BIT(0)	/* Update interrupt flag   */
>  #define TIM_EGR_UG	BIT(0)	/* Update Generation       */
>  #define TIM_CCMR_PE	BIT(3)	/* Channel Preload Enable  */
> @@ -56,6 +67,8 @@
>  #define TIM_BDTR_BK2F	(BIT(20) | BIT(21) | BIT(22) | BIT(23))
>  #define TIM_BDTR_BK2E	BIT(24) /* Break 2 input enable	   */
>  #define TIM_BDTR_BK2P	BIT(25) /* Break 2 input polarity  */
> +#define TIM_DCR_DBA	GENMASK(4, 0)	/* DMA base addr */
> +#define TIM_DCR_DBL	GENMASK(12, 8)	/* DMA burst len */
>  
>  #define MAX_TIM_PSC		0xFFFF
>  #define TIM_CR2_MMS_SHIFT	4
> @@ -65,9 +78,42 @@
>  #define TIM_BDTR_BKF_SHIFT	16
>  #define TIM_BDTR_BK2F_SHIFT	20
>  
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
> +/**
> + * struct stm32_timers_dma - STM32 timer DMA handling.
> + * @completion:		end of DMA transfer completion
> + * @phys_base:		control registers physical base address
> + * @lock:		protect DMA access
> + * @chan:		DMA channel in use
> + * @chans:		DMA channels available for this timer instance
> + */
> +struct stm32_timers_dma {
> +	struct completion completion;
> +	phys_addr_t phys_base;
> +	struct mutex lock;
> +	struct dma_chan *chan;
> +	struct dma_chan *chans[STM32_TIMERS_MAX_DMAS];
> +};
> +
>  struct stm32_timers {
>  	struct clk *clk;
>  	struct regmap *regmap;
>  	u32 max_arr;
> +	struct stm32_timers_dma dma; /* Only to be used by the parent */
>  };
> +
> +int stm32_timers_dma_burst_read(struct device *dev, u32 *buf,
> +				enum stm32_timers_dmas id, u32 reg,
> +				unsigned int num_reg, unsigned int bursts,
> +				unsigned long tmo_ms);
>  #endif
> 
