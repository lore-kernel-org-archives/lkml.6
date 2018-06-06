Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZkIHaQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3707560767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932208AbeFFGjl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:39:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53462 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbeFFGjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:39:40 -0400
X-Google-Smtp-Source: ADUXVKLpaJ/KXu7LGOiXaJWG7WVwrNBmEPFK0HCC2B/M9nZCPAgdXNbNbfEX+6oqxn+Wz3i0lw/yEw==
Date: Wed, 6 Jun 2018 07:39:36 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 08/12] mfd: da9063: Add custom regmap for DA9063L
Message-ID: <20180606063936.GY21163@dell>
References: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
 <20180605231013.1803-8-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180605231013.1803-8-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jun 2018, Marek Vasut wrote:

> The DA9063L does not have an RTC. Add custom regmap for DA9063L to
> prevent access into that register block.
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
> V4: Drop mention of buggy datasheet in the commit message
> ---
>  drivers/mfd/da9063-i2c.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
> index 048ce55ebc5b..f0d92a37df6b 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -208,6 +208,93 @@ static const struct regmap_access_table da9063_bb_volatile_table = {
>  	.n_yes_ranges = ARRAY_SIZE(da9063_bb_volatile_ranges),
>  };
>  
> +static const struct regmap_range da9063l_bb_readable_ranges[] = {
> +	{
> +		.range_min = DA9063_REG_PAGE_CON,
> +		.range_max = DA9063_REG_MON_A10_RES,
> +	}, {
> +		.range_min = DA9063_REG_SEQ,
> +		.range_max = DA9063_REG_ID_32_31,
> +	}, {
> +		.range_min = DA9063_REG_SEQ_A,
> +		.range_max = DA9063_REG_AUTO3_LOW,
> +	}, {
> +		.range_min = DA9063_REG_T_OFFSET,
> +		.range_max = DA9063_BB_REG_GP_ID_19,
> +	}, {
> +		.range_min = DA9063_REG_CHIP_ID,
> +		.range_max = DA9063_REG_CHIP_VARIANT,
> +	},
> +};
> +
> +static const struct regmap_range da9063l_bb_writeable_ranges[] = {
> +	{
> +		.range_min = DA9063_REG_PAGE_CON,
> +		.range_max = DA9063_REG_PAGE_CON,
> +	}, {
> +		.range_min = DA9063_REG_FAULT_LOG,
> +		.range_max = DA9063_REG_VSYS_MON,
> +	}, {
> +		.range_min = DA9063_REG_SEQ,
> +		.range_max = DA9063_REG_ID_32_31,
> +	}, {
> +		.range_min = DA9063_REG_SEQ_A,
> +		.range_max = DA9063_REG_AUTO3_LOW,
> +	}, {
> +		.range_min = DA9063_REG_CONFIG_I,
> +		.range_max = DA9063_BB_REG_MON_REG_4,
> +	}, {
> +		.range_min = DA9063_BB_REG_GP_ID_0,
> +		.range_max = DA9063_BB_REG_GP_ID_19,
> +	},
> +};
> +
> +static const struct regmap_range da9063l_bb_volatile_ranges[] = {
> +	{
> +		.range_min = DA9063_REG_PAGE_CON,
> +		.range_max = DA9063_REG_EVENT_D,
> +	}, {
> +		.range_min = DA9063_REG_CONTROL_A,
> +		.range_max = DA9063_REG_CONTROL_B,
> +	}, {
> +		.range_min = DA9063_REG_CONTROL_E,
> +		.range_max = DA9063_REG_CONTROL_F,
> +	}, {
> +		.range_min = DA9063_REG_BCORE2_CONT,
> +		.range_max = DA9063_REG_LDO11_CONT,
> +	}, {
> +		.range_min = DA9063_REG_DVC_1,
> +		.range_max = DA9063_REG_ADC_MAN,
> +	}, {
> +		.range_min = DA9063_REG_ADC_RES_L,
> +		.range_max = DA9063_REG_MON_A10_RES,
> +	}, {
> +		.range_min = DA9063_REG_SEQ,
> +		.range_max = DA9063_REG_SEQ,
> +	}, {
> +		.range_min = DA9063_REG_EN_32K,
> +		.range_max = DA9063_REG_EN_32K,
> +	}, {
> +		.range_min = DA9063_BB_REG_MON_REG_5,
> +		.range_max = DA9063_BB_REG_MON_REG_6,
> +	},
> +};

Not sure why the regmap_reg_range() MACRO is lower case, but still,
please make use of it to save a few lines.

Once changed, please add my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
