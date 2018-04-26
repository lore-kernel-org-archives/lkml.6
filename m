Return-Path: <bjorn.andersson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524766898; cv=none;
        d=google.com; s=arc-20160816;
        b=J423p04XuPhYe39zsfTfGk/TRPRQlaxxHwmcaROp70GiOa8yQwqCm9iijoS9twNuAw
         Ti6qbZukA0PGOyeMRt6tTB8bAcujzR0KBw8/jXyFf7H0xWhds9ycW2zcX4DSP4TlLPZv
         JClcRQDl6scHQ+luaFqj+fQFlIt1WmwoJ8pdSpYKjoCxNjw3Pn88C8JjxtLHyufcw3tK
         jEGE3hPtG9/IfU8W8e6yEvqWUJu24rqU7fVStpN4jVCUWchHrOwBgY2Tuwht4dk7yRSd
         HCr13NXcFmfKSmb9orJdG269tfVWF8H1gApvNudEzdGYfzXTnN8kKxQQZj3+jQJQanWJ
         OyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=vFKE7CeBmJWdjWH3Mk+bKdXPazlInnyr8udThSzYDzk=;
        b=BoBqFGe2W3WNUoCutjbVsCLmw8PmrNLy/XvfYmNiLkWQzWsIhxb+Bd5uWLGMf0B/qA
         39CWHmZQUcm/O2P0MuzNSMMVXM/seYOO1K12H/73Takuc96Ze67AZwYdE15VSyx3OXVO
         +PV0OkCwoqVMn4tdo7rx/vMq2g7zNfmP42NLsOtcBDHYM26L38JGYpg+CkC7oanjg9Eg
         B1OyULl2Xyx9uLSmUT3Ky/oqFCYri5499OgFf6lrgz5bccSK7hWz748NjpdgXrTjeRPH
         ydGwAY7i48LFaf2pkV803/d+gJxFSuH94HlhQHJnqkyyoF100nj7WztwpbO1ttyP+9+p
         65Xw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dLWCCLw2;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dLWCCLw2;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZouaFzxPunNdj4K5e442Eqk7BI2dORwTwbpV4VRT5PdxbRC8ZvBIkx8w1/CauKJShG0Xlbldg==
Date: Thu, 26 Apr 2018 11:21:34 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Craig Tatlor <ctatlor97@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] power: supply: Add support for the Qualcomm Battery
 Monitoring System
Message-ID: <20180426182134.GM18510@minitux>
References: <20180407134712.23131-1-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180407134712.23131-1-ctatlor97@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095374964030475?=
X-GMAIL-MSGID: =?utf-8?q?1598833975271691086?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat 07 Apr 10:57 PDT 2018, Craig Tatlor wrote:

Looks pretty good, just some minor things inline.

[..]
> diff --git a/drivers/power/supply/qcom_bms.c b/drivers/power/supply/qcom_bms.c
> new file mode 100644
> index 000000000000..f31c99c03518
> --- /dev/null
> +++ b/drivers/power/supply/qcom_bms.c
> @@ -0,0 +1,500 @@
> +// SPDX-License-Identifier: GPL
> +
> +/*
> + * Qualcomm Battery Monitoring System driver
> + *
> + * Copyright (C) 2018 Craig Tatlor <ctatlor97@gmail.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/param.h>

param.h unused?

> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/consumer.h>
> +
> +#define REG_BMS_OCV_FOR_SOC_DATA0	0x90
> +#define REG_BMS_SHDW_CC_DATA0		0xA8
> +#define REG_BMS_CC_DATA_CTL		0x42
> +#define REG_BMS_CC_CLEAR_CTL		0x4
> +
> +#define BMS_HOLD_OREG_DATA		BIT(0)
> +#define BMS_CLEAR_SHDW_CC		BIT(6)
> +
> +#define CC_36_BIT_MASK			0xFFFFFFFFFLL

How about GENMASK_ULL() ? 

> +#define SIGN_EXTEND_36_TO_64_MASK	(-1LL ^ CC_36_BIT_MASK)
> +
> +#define BMS_CC_READING_RESOLUTION_N	542535
> +#define BMS_CC_READING_RESOLUTION_D	10000
> +#define BMS_CC_READING_TICKS		56
> +#define BMS_SLEEP_CLK_HZ		32764
> +
> +#define SECONDS_PER_HOUR		3600
> +#define TEMPERATURE_COLS		5
> +#define MAX_CAPACITY_ROWS		50
> +
> +/* lookup table for ocv -> capacity conversion */
> +struct bms_ocv_lut {
> +	int rows;
> +	s8 temp_legend[TEMPERATURE_COLS];
> +	u8 capacity_legend[MAX_CAPACITY_ROWS];
> +	u16 lut[MAX_CAPACITY_ROWS][TEMPERATURE_COLS];
> +};
> +
> +/* lookup table for battery temperature -> fcc conversion */
> +struct bms_fcc_lut {
> +	s8 temp_legend[TEMPERATURE_COLS];
> +	u16 lut[TEMPERATURE_COLS];
> +};
> +
> +struct bms_device_info {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct power_supply *bat;

bat is local to bms_probe.

> +	struct power_supply_desc bat_desc;
> +	struct bms_ocv_lut ocv_lut;
> +	struct bms_fcc_lut fcc_lut;
> +	struct iio_channel *adc;
> +	spinlock_t bms_output_lock;
> +	int base_addr;

u32, as you're passing a pointer to this into of_property_read_u32().

> +
> +	int ocv_thr_irq;
> +	int ocv;
> +};
> +
> +static s64 sign_extend_s36(uint64_t raw)
> +{
> +	raw = raw & CC_36_BIT_MASK;

raw &= 

> +
> +	return (raw >> 35) == 0LL ?
> +		raw : (SIGN_EXTEND_36_TO_64_MASK | raw);
> +}
> +
> +static unsigned int interpolate(int y0, int x0, int y1, int x1, int x)
> +{
> +	if (y0 == y1 || x == x0)
> +		return y0;
> +	if (x1 == x0 || x == x1)
> +		return y1;
> +
> +	return y0 + ((y1 - y0) * (x - x0) / (x1 - x0));
> +}
> +
> +static unsigned int between(int left, int right, int val)

Return bool and use true/false instead.

> +{
> +	if (left <= val && val <= right)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static unsigned int interpolate_capacity(int temp, u16 ocv,
> +				struct bms_ocv_lut ocv_lut)
> +{
> +	unsigned int pcj_minus_one = 0, pcj = 0;
> +	int i, j;
> +
> +	for (j = 0; j < TEMPERATURE_COLS; j++)
> +		if (temp <= ocv_lut.temp_legend[j])
> +			break;
> +
> +	if (ocv >= ocv_lut.lut[0][j])
> +		return ocv_lut.capacity_legend[0];
> +
> +	if (ocv <= ocv_lut.lut[ocv_lut.rows - 1][j - 1])
> +		return ocv_lut.capacity_legend[ocv_lut.rows - 1];
> +
> +	for (i = 0; i < ocv_lut.rows - 1; i++) {
> +		if (pcj == 0 && between(ocv_lut.lut[i][j],
> +					ocv_lut.lut[i+1][j], ocv))
> +			pcj = interpolate(ocv_lut.capacity_legend[i],
> +					  ocv_lut.lut[i][j],
> +					  ocv_lut.capacity_legend[i + 1],
> +					  ocv_lut.lut[i+1][j],
> +					  ocv);
> +
> +		if (pcj_minus_one == 0 && between(ocv_lut.lut[i][j-1],
> +						  ocv_lut.lut[i+1][j-1], ocv))
> +			pcj_minus_one = interpolate(ocv_lut.capacity_legend[i],
> +						    ocv_lut.lut[i][j-1],
> +						    ocv_lut.capacity_legend[i + 1],
> +						    ocv_lut.lut[i+1][j-1],
> +						    ocv);
> +
> +		if (pcj && pcj_minus_one)
> +			return interpolate(pcj_minus_one,
> +					   ocv_lut.temp_legend[j-1],
> +					   pcj,
> +					   ocv_lut.temp_legend[j],
> +					   temp);
> +	}

How about finding the four indices first and then do the three
interpolation steps after that?

> +
> +	if (pcj)
> +		return pcj;
> +
> +	if (pcj_minus_one)
> +		return pcj_minus_one;

Do you need these special cases? Is it even possible that we get out
above loop without pcj and pcj_minus_one assigned?

> +
> +	return 100;
> +}
> +
> +static unsigned long interpolate_fcc(int temp, struct bms_fcc_lut fcc_lut)

Pass fcc_lut by reference, as it's "large".

> +{
> +	int i, fcc_mv;
> +
> +	for (i = 0; i < TEMPERATURE_COLS; i++)
> +		if (temp <= fcc_lut.temp_legend[i])
> +			break;
> +
> +	fcc_mv = interpolate(fcc_lut.lut[i - 1],
> +			     fcc_lut.temp_legend[i - 1],
> +			     fcc_lut.lut[i],
> +			     fcc_lut.temp_legend[i],
> +			     temp);
> +
> +	return fcc_mv * 10000;

What does this function return? Why do you multiply with 10k here? A
comment would be nice.

> +}
> +
> +static int bms_lock_output_data(struct bms_device_info *di)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(di->regmap, di->base_addr +
> +				 REG_BMS_CC_DATA_CTL,
> +				 BMS_HOLD_OREG_DATA, BMS_HOLD_OREG_DATA);
> +	if (ret < 0) {
> +		dev_err(di->dev, "failed to lock bms output: %d", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Sleep for 100 microseconds here to make sure there has
> +	 * been at least three cycles of the sleep clock so that
> +	 * the registers are correctly locked.
> +	 */
> +	udelay(100);

usleep_range(100, 1000); as this is longer than 10us

See Documentation/timers/timers-howto.txt

> +
> +	return 0;
> +}
> +
> +static int bms_unlock_output_data(struct bms_device_info *di)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(di->regmap, di->base_addr +
> +				 REG_BMS_CC_DATA_CTL,
> +				 BMS_HOLD_OREG_DATA, 0);
> +	if (ret < 0) {
> +		dev_err(di->dev, "failed to unlock bms output: %d", ret);
> +		return ret;
> +	}

regmap_update_bits() returns 0 on success, so you can:

ret = regmap_update_bits();
if (ret)
	dev_err();

return ret;

> +
> +	return 0;
> +}
> +
> +static int bms_read_ocv(struct bms_device_info *di, int *ocv)
> +{
> +	unsigned long flags;
> +	int ret;
> +	u16 read_ocv;
> +
> +	spin_lock_irqsave(&di->bms_output_lock, flags);
> +
> +	ret = bms_lock_output_data(di);
> +	if (ret < 0)
> +		goto err_lock;
> +
> +	ret = regmap_bulk_read(di->regmap, di->base_addr +
> +			       REG_BMS_OCV_FOR_SOC_DATA0, &read_ocv, 2);
> +	if (ret < 0) {
> +		dev_err(di->dev, "OCV read failed: %d", ret);

Returning with spinlock and output lock held.

> +		return ret;
> +	}
> +
> +	dev_dbg(di->dev, "read OCV value of: %d", read_ocv);
> +	*ocv = read_ocv;
> +
> +	ret = bms_unlock_output_data(di);
> +
> +err_lock:
> +	spin_unlock_irqrestore(&di->bms_output_lock, flags);
> +
> +	return ret;
> +}
> +
> +static int bms_read_cc(struct bms_device_info *di, s64 *cc_uah)
> +{
> +	unsigned long flags;
> +	int ret;
> +	s64 cc_raw_s36, cc_raw, cc_uv, cc_pvh;
> +
> +	spin_lock_irqsave(&di->bms_output_lock, flags);
> +
> +	ret = bms_lock_output_data(di);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_bulk_read(di->regmap, di->base_addr +
> +			       REG_BMS_SHDW_CC_DATA0,
> +			       &cc_raw_s36, 5);
> +	if (ret < 0) {
> +		dev_err(di->dev, "coulomb counter read failed: %d", ret);

Returning with spinlock and output locked.

> +		return ret;
> +	}
> +
> +	ret = bms_unlock_output_data(di);
> +	if (ret < 0)

Returning with spinlock held.

> +		return ret;
> +
> +	spin_unlock_irqrestore(&di->bms_output_lock, flags);
> +
> +	cc_raw = sign_extend_s36(cc_raw_s36);
> +
> +	/* convert raw to uv */
> +	cc_uv = div_s64(cc_raw * BMS_CC_READING_RESOLUTION_N,
> +			BMS_CC_READING_RESOLUTION_D);
> +
> +	/* convert uv to pvh */
> +	cc_pvh = div_s64(cc_uv * BMS_CC_READING_TICKS * 100000,
> +			 BMS_SLEEP_CLK_HZ * SECONDS_PER_HOUR) * 10;
> +
> +	/* divide by impedance */
> +	*cc_uah = div_s64(cc_pvh, 10000);
> +
> +	dev_dbg(di->dev, "read coulomb counter value of: %lld", *cc_uah);
> +
> +	return 0;
> +}
> +
> +static void bms_reset_cc(struct bms_device_info *di)
> +{
> +	int ret;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&di->bms_output_lock, flags);
> +
> +	ret = regmap_update_bits(di->regmap, di->base_addr +
> +				 REG_BMS_CC_CLEAR_CTL,
> +				 BMS_CLEAR_SHDW_CC,
> +				 BMS_CLEAR_SHDW_CC);
> +	if (ret < 0) {
> +		dev_err(di->dev, "coulomb counter reset failed: %d", ret);
> +		goto err_lock;
> +	}
> +
> +	/* wait two sleep cycles for cc to reset */
> +	udelay(100);

usleep_range(100, 1000);


Perhaps you can make the irq handler threaded, so that you don't have to
spend so long time with irqs disabled.

> +
> +	ret = regmap_update_bits(di->regmap, di->base_addr +
> +				 REG_BMS_CC_CLEAR_CTL,
> +				 BMS_CLEAR_SHDW_CC, 0);
> +	if (ret < 0)
> +		dev_err(di->dev, "coulomb counter re-enable failed: %d", ret);
> +
> +err_lock:
> +	spin_unlock_irqrestore(&di->bms_output_lock, flags);
> +}
> +
> +static int bms_calculate_capacity(struct bms_device_info *di, int *capacity)
> +{
> +	unsigned long ocv_capacity, fcc;
> +	int ret, temp, temp_degc;
> +	s64 cc, capacity_nodiv;
> +
> +	ret = iio_read_channel_raw(di->adc, &temp);
> +	if (ret < 0) {
> +		dev_err(di->dev, "failed to read temperature: %d", ret);
> +		return ret;
> +	}
> +
> +	temp_degc = (temp + 500) / 1000;
> +
> +	ret = bms_read_cc(di, &cc);
> +	if (ret < 0) {
> +		dev_err(di->dev, "failed to read coulomb counter: %d", ret);
> +		return ret;
> +	}
> +
> +	ocv_capacity = interpolate_capacity(temp_degc, (di->ocv + 5) / 10,
> +					    di->ocv_lut);

interpolate_capacity returns unsigned int, but ocv_capacity is unsigned
long. Please pick one.

> +	fcc = interpolate_fcc(temp_degc, di->fcc_lut);
> +
> +	capacity_nodiv = ((fcc * ocv_capacity) / 100 - cc) * 100;
> +	*capacity = div64_ul(capacity_nodiv, fcc);
> +
> +	return 0;
> +}
> +
> +
> +

Remove a few empty lines.

> +/*
> + * Return power_supply property
> + */
> +static int bms_get_property(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   union power_supply_propval *val)
> +{
> +	struct bms_device_info *di = power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret = bms_calculate_capacity(di, &val->intval);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (val->intval == INT_MAX || val->intval == INT_MIN)
> +		ret = -EINVAL;

Can this happen?

> +
> +	return ret;
> +}
[..]
> +static int bms_probe(struct platform_device *pdev)
> +{
> +	struct power_supply_config psy_cfg = {};
> +	struct bms_device_info *di;
> +	int ret;
> +
> +	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
> +	if (!di)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, di);

You don't use this, so no need to set it.

> +
[..]
> +
> +	spin_lock_init(&di->bms_output_lock);

Initialize the spinlock before registering the irq handler, just in case
it would fire immediately.

> +
> +	di->bat_desc.name = "bms";
> +	di->bat_desc.type = POWER_SUPPLY_TYPE_BATTERY;
> +	di->bat_desc.properties = bms_props;
> +	di->bat_desc.num_properties = ARRAY_SIZE(bms_props);
> +	di->bat_desc.get_property = bms_get_property;
> +
> +	psy_cfg.drv_data = di;
> +	di->bat = devm_power_supply_register(di->dev, &di->bat_desc, &psy_cfg);

Replace:

> +	if (IS_ERR(di->bat))
> +		return PTR_ERR(di->bat);
> +
> +	return 0;

with:

	return PTR_ERR_OR_ZERO(di->bat);

> +}
> +
> +static const struct of_device_id bms_of_match[] = {
> +	{.compatible = "qcom,pm8941-bms", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bms_of_match);
> +
> +static struct platform_driver bms_driver = {
> +	.probe = bms_probe,
> +	.driver = {
> +		.name = "qcom-bms",
> +		.of_match_table = of_match_ptr(bms_of_match),
> +	},
> +};
> +module_platform_driver(bms_driver);
> +
> +MODULE_AUTHOR("Craig Tatlor <ctatlor97@gmail.com>");
> +MODULE_DESCRIPTION("Qualcomm BMS driver");
> +MODULE_LICENSE("GPL");

Regards,
Bjorn
