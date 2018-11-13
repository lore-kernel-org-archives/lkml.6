Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5B0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E73F223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E73F223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbeKMUiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:38:03 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21690 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732104AbeKMUiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:38:02 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wADAdF2j002842;
        Tue, 13 Nov 2018 11:40:11 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nnnp28rq5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 13 Nov 2018 11:40:11 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1464431;
        Tue, 13 Nov 2018 10:40:11 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D9F36291B;
        Tue, 13 Nov 2018 10:40:10 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 13 Nov
 2018 11:40:10 +0100
Subject: Re: [PATCH 2/3] pinctrl: stm32: protect configuration registers with
 a hwspinlock
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20181113095142.32015-1-benjamin.gaignard@st.com>
 <20181113095142.32015-3-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e6bab4d5-851b-e283-5240-f7e4f81fd5bc@st.com>
Date:   Tue, 13 Nov 2018 11:40:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113095142.32015-3-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

On 11/13/18 10:51 AM, Benjamin Gaignard wrote:
> If a hwspinlock if defined in device tree use it to protect
> configuration registers.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   drivers/pinctrl/stm32/pinctrl-stm32.c | 71 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
> index a9bec6e6fdd1..dce9dabaf4d5 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -8,6 +8,7 @@


Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>



>    */
>   #include <linux/clk.h>
>   #include <linux/gpio/driver.h>
> +#include <linux/hwspinlock.h>
>   #include <linux/io.h>
>   #include <linux/irq.h>
>   #include <linux/mfd/syscon.h>
> @@ -51,6 +52,8 @@
>   #define gpio_range_to_bank(chip) \
>   		container_of(chip, struct stm32_gpio_bank, range)
>   
> +#define HWSPINLOCK_TIMEOUT	5 /* msec */
> +
>   static const char * const stm32_gpio_functions[] = {
>   	"gpio", "af0", "af1",
>   	"af2", "af3", "af4",
> @@ -91,6 +94,7 @@ struct stm32_pinctrl {
>   	struct irq_domain	*domain;
>   	struct regmap		*regmap;
>   	struct regmap_field	*irqmux[STM32_GPIO_PINS_PER_BANK];
> +	struct hwspinlock *hwlock;
>   };
>   
>   static inline int stm32_gpio_pin(int gpio)
> @@ -576,14 +580,24 @@ static int stm32_pmx_get_func_groups(struct pinctrl_dev *pctldev,
>   static void stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
>   		int pin, u32 mode, u32 alt)
>   {
> +	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
>   	u32 val;
>   	int alt_shift = (pin % 8) * 4;
>   	int alt_offset = STM32_GPIO_AFRL + (pin / 8) * 4;
>   	unsigned long flags;
> +	int err = 0;
>   
>   	clk_enable(bank->clk);
>   	spin_lock_irqsave(&bank->lock, flags);
>   
> +	if (pctl->hwlock)
> +		err = hwspin_lock_timeout(pctl->hwlock, HWSPINLOCK_TIMEOUT);
> +
> +	if (err) {
> +		dev_err(pctl->dev, "Can't get hwspinlock\n");
> +		goto unlock;
> +	}
> +
>   	val = readl_relaxed(bank->base + alt_offset);
>   	val &= ~GENMASK(alt_shift + 3, alt_shift);
>   	val |= (alt << alt_shift);
> @@ -594,6 +608,10 @@ static void stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
>   	val |= mode << (pin * 2);
>   	writel_relaxed(val, bank->base + STM32_GPIO_MODER);
>   
> +	if (pctl->hwlock)
> +		hwspin_unlock(pctl->hwlock);
> +
> +unlock:
>   	spin_unlock_irqrestore(&bank->lock, flags);
>   	clk_disable(bank->clk);
>   }
> @@ -683,17 +701,31 @@ static const struct pinmux_ops stm32_pmx_ops = {
>   static void stm32_pconf_set_driving(struct stm32_gpio_bank *bank,
>   	unsigned offset, u32 drive)
>   {
> +	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
>   	unsigned long flags;
>   	u32 val;
> +	int err = 0;
>   
>   	clk_enable(bank->clk);
>   	spin_lock_irqsave(&bank->lock, flags);
>   
> +	if (pctl->hwlock)
> +		err = hwspin_lock_timeout(pctl->hwlock, HWSPINLOCK_TIMEOUT);
> +
> +	if (err) {
> +		dev_err(pctl->dev, "Can't get hwspinlock\n");
> +		goto unlock;
> +	}
> +
>   	val = readl_relaxed(bank->base + STM32_GPIO_TYPER);
>   	val &= ~BIT(offset);
>   	val |= drive << offset;
>   	writel_relaxed(val, bank->base + STM32_GPIO_TYPER);
>   
> +	if (pctl->hwlock)
> +		hwspin_unlock(pctl->hwlock);
> +
> +unlock:
>   	spin_unlock_irqrestore(&bank->lock, flags);
>   	clk_disable(bank->clk);
>   }
> @@ -719,17 +751,31 @@ static u32 stm32_pconf_get_driving(struct stm32_gpio_bank *bank,
>   static void stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
>   	unsigned offset, u32 speed)
>   {
> +	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
>   	unsigned long flags;
>   	u32 val;
> +	int err = 0;
>   
>   	clk_enable(bank->clk);
>   	spin_lock_irqsave(&bank->lock, flags);
>   
> +	if (pctl->hwlock)
> +		err = hwspin_lock_timeout(pctl->hwlock, HWSPINLOCK_TIMEOUT);
> +
> +	if (err) {
> +		dev_err(pctl->dev, "Can't get hwspinlock\n");
> +		goto unlock;
> +	}
> +
>   	val = readl_relaxed(bank->base + STM32_GPIO_SPEEDR);
>   	val &= ~GENMASK(offset * 2 + 1, offset * 2);
>   	val |= speed << (offset * 2);
>   	writel_relaxed(val, bank->base + STM32_GPIO_SPEEDR);
>   
> +	if (pctl->hwlock)
> +		hwspin_unlock(pctl->hwlock);
> +
> +unlock:
>   	spin_unlock_irqrestore(&bank->lock, flags);
>   	clk_disable(bank->clk);
>   }
> @@ -755,17 +801,31 @@ static u32 stm32_pconf_get_speed(struct stm32_gpio_bank *bank,
>   static void stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
>   	unsigned offset, u32 bias)
>   {
> +	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
>   	unsigned long flags;
>   	u32 val;
> +	int err = 0;
>   
>   	clk_enable(bank->clk);
>   	spin_lock_irqsave(&bank->lock, flags);
>   
> +	if (pctl->hwlock)
> +		err = hwspin_lock_timeout(pctl->hwlock, HWSPINLOCK_TIMEOUT);
> +
> +	if (err) {
> +		dev_err(pctl->dev, "Can't get hwspinlock\n");
> +		goto unlock;
> +	}
> +
>   	val = readl_relaxed(bank->base + STM32_GPIO_PUPDR);
>   	val &= ~GENMASK(offset * 2 + 1, offset * 2);
>   	val |= bias << (offset * 2);
>   	writel_relaxed(val, bank->base + STM32_GPIO_PUPDR);
>   
> +	if (pctl->hwlock)
> +		hwspin_unlock(pctl->hwlock);
> +
> +unlock:
>   	spin_unlock_irqrestore(&bank->lock, flags);
>   	clk_disable(bank->clk);
>   }
> @@ -1140,7 +1200,7 @@ int stm32_pctl_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct stm32_pinctrl *pctl;
>   	struct pinctrl_pin_desc *pins;
> -	int i, ret, banks = 0;
> +	int i, ret, hwlock_id, banks = 0;
>   
>   	if (!np)
>   		return -EINVAL;
> @@ -1160,6 +1220,15 @@ int stm32_pctl_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, pctl);
>   
> +	/* hwspinlock is optional */
> +	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
> +	if (hwlock_id < 0) {
> +		if (hwlock_id == -EPROBE_DEFER)
> +			return hwlock_id;
> +	} else {
> +		pctl->hwlock = hwspin_lock_request_specific(hwlock_id);
> +	}
> +
>   	pctl->dev = dev;
>   	pctl->match_data = match->data;
>   	ret = stm32_pctrl_build_state(pdev);
> 
