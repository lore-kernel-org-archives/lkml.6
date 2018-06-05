Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeFEHrd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:47:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51002 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeFEHrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:47:31 -0400
X-Google-Smtp-Source: ADUXVKKO1Wr26IR8M3x4c+U2dujPkM9nvk48nz4DqIqFjYVN+XewRhgHUGRUJFD1kV8Whi6DIruiVA==
Date: Tue, 5 Jun 2018 08:47:27 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 07/10] mfd: da9063: Add custom IRQ map for DA9063L
Message-ID: <20180605074727.GL21163@dell>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-7-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180602101155.26375-7-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Jun 2018, Marek Vasut wrote:

> While the datasheet for DA9063L (2v1, 23-Mar-2017) lists the RTC register
> block, the DA9063L does not have an RTC. Add custom IRQ map for DA9063L to
> ignore the Alarm and Tick IRQs from the PMIC.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V3: New patch
> ---
>  drivers/mfd/da9063-irq.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
> index 5b406ecfc14a..b6a88861cc2e 100644
> --- a/drivers/mfd/da9063-irq.c
> +++ b/drivers/mfd/da9063-irq.c
> @@ -74,8 +74,55 @@ static const struct regmap_irq_chip da9063_irq_chip = {
>  	.init_ack_masked = true,
>  };
>  
> +static const struct regmap_irq da9063l_irqs[] = {
> +	/* DA9063 event A register */
> +	REGMAP_IRQ_REG(DA9063_IRQ_ONKEY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ONKEY),
> +	REGMAP_IRQ_REG(DA9063_IRQ_ADC_RDY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ADC_RDY),
> +	REGMAP_IRQ_REG(DA9063_IRQ_SEQ_RDY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_SEQ_RDY),
> +	/* DA9063 event B register */
> +	REGMAP_IRQ_REG(DA9063_IRQ_WAKE, DA9063_REG_EVENT_B_OFFSET, DA9063_M_WAKE),
> +	REGMAP_IRQ_REG(DA9063_IRQ_TEMP, DA9063_REG_EVENT_B_OFFSET, DA9063_M_TEMP),
> +	REGMAP_IRQ_REG(DA9063_IRQ_COMP_1V2, DA9063_REG_EVENT_B_OFFSET, DA9063_M_COMP_1V2),
> +	REGMAP_IRQ_REG(DA9063_IRQ_LDO_LIM, DA9063_REG_EVENT_B_OFFSET, DA9063_M_LDO_LIM),
> +	REGMAP_IRQ_REG(DA9063_IRQ_REG_UVOV, DA9063_REG_EVENT_B_OFFSET, DA9063_M_UVOV),
> +	REGMAP_IRQ_REG(DA9063_IRQ_DVC_RDY, DA9063_REG_EVENT_B_OFFSET, DA9063_M_DVC_RDY),
> +	REGMAP_IRQ_REG(DA9063_IRQ_VDD_MON, DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_MON),
> +	REGMAP_IRQ_REG(DA9063_IRQ_WARN, DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_WARN),
> +	/* DA9063 event C register */
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI0, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI0),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI1, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI1),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI2, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI2),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI3, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI3),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI4, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI4),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI5, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI5),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI6, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI6),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI7, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI7),
> +	/* DA9063 event D register */
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI8, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI8),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI9, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI9),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI10, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI10),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI11, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI11),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI12, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI12),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI13, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI13),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI14, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI14),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI15, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI15),
> +};

Same here.  Please make checkpatch.pl happen, even if it makes the
code slightly less readable.

> +static const struct regmap_irq_chip da9063l_irq_chip = {
> +	.name = "da9063l-irq",
> +	.irqs = da9063l_irqs,
> +	.num_irqs = DA9063_NUM_IRQ,
> +

Nit: This '\n' is superfluous.

> +	.num_regs = 4,
> +	.status_base = DA9063_REG_EVENT_A,
> +	.mask_base = DA9063_REG_IRQ_MASK_A,
> +	.ack_base = DA9063_REG_EVENT_A,
> +	.init_ack_masked = true,
> +};
> +
>  int da9063_irq_init(struct da9063 *da9063)
>  {
> +	struct regmap_irq_chip *irq_chip;
>  	int ret;
>  
>  	if (!da9063->chip_irq) {
> @@ -83,10 +130,14 @@ int da9063_irq_init(struct da9063 *da9063)
>  		return -EINVAL;
>  	}
>  
> +	if (da9063->type == PMIC_TYPE_DA9063)
> +		irq_chip = &da9063_irq_chip;
> +	else
> +		irq_chip = &da9063l_irq_chip;
> +
>  	ret = regmap_add_irq_chip(da9063->regmap, da9063->chip_irq,
>  			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> -			da9063->irq_base, &da9063_irq_chip,
> -			&da9063->regmap_irq);
> +			da9063->irq_base, irq_chip, &da9063->regmap_irq);
>  	if (ret) {
>  		dev_err(da9063->dev, "Failed to reguest IRQ %d: %d\n",
>  				da9063->chip_irq, ret);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
