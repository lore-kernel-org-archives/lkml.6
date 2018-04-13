Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDMW1n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 18:27:43 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37384 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbeDMW1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 18:27:41 -0400
X-Google-Smtp-Source: AIpwx49Bc2VMpPfUkZeDdMKToJgApOiVf86He0kBOUNtoIYnjOWR5ULQ21hvcZivUfmXmHw9m3VpxA==
Date: Fri, 13 Apr 2018 15:27:38 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] input: touchscreen mc13xxx: Add mc34708 support
Message-ID: <20180413222738.GB27465@dtor-ws>
References: <20180411141340.30939-1-lukma@denx.de>
 <20180411141340.30939-2-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411141340.30939-2-lukma@denx.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 04:13:40PM +0200, Lukasz Majewski wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The mc34708 has a different bit to enable pen detection. This
> adds the driver data and devtype necessary to probe the device
> and to distinguish between the mc13783 and the mc34708.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---
> Changes from the original patch:
> - Simplify the mcXXXXX_set_pen_detection functions
> - Fix checkpatch warnings
> ---
>  drivers/input/touchscreen/mc13783_ts.c | 65 +++++++++++++++++++++++++++++++---
>  1 file changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
> index 610f10e6aadf..9fcc7069f633 100644
> --- a/drivers/input/touchscreen/mc13783_ts.c
> +++ b/drivers/input/touchscreen/mc13783_ts.c
> @@ -33,6 +33,8 @@ MODULE_PARM_DESC(sample_tolerance,
>  		"is supposed to be wrong and is discarded.  Set to 0 to "
>  		"disable this check.");
>  
> +struct mc13xxx_driver_data;
> +
>  struct mc13783_ts_priv {
>  	struct input_dev *idev;
>  	struct mc13xxx *mc13xxx;
> @@ -40,6 +42,43 @@ struct mc13783_ts_priv {
>  	unsigned int sample[4];
>  	u8 ato;
>  	bool atox;
> +	struct mc13xxx_driver_data *drvdata;
> +};
> +
> +enum mc13xxx_type {
> +	MC13XXX_TYPE_MC13783,
> +	MC13XXX_TYPE_MC34708,
> +};
> +
> +struct mc13xxx_driver_data {
> +	int (*set_pen_detection)(struct mc13783_ts_priv *priv, bool enable);
> +	enum mc13xxx_type type;
> +};
> +
> +static int mc13783_set_pen_detection(struct mc13783_ts_priv *priv, bool enable)
> +{
> +	return mc13xxx_reg_rmw(priv->mc13xxx, MC13XXX_ADC0,
> +			       MC13XXX_ADC0_TSMOD_MASK,
> +			       enable ? MC13XXX_ADC0_TSMOD0 : 0);
> +}
> +
> +#define MC34708_ADC0_TSPENDETEN		(1 << 20)
> +
> +static int mc34708_set_pen_detection(struct mc13783_ts_priv *priv, bool enable)
> +{
> +	return mc13xxx_reg_rmw(priv->mc13xxx, MC13XXX_ADC0,
> +			       MC34708_ADC0_TSPENDETEN,
> +			       enable ? MC34708_ADC0_TSPENDETEN : 0);
> +}

Instead of having separate functions, can we have register mask and
value in mc13xxx_driver_data structure?

> +
> +static struct mc13xxx_driver_data mc13783_driver_data = {
> +	.type = MC13XXX_TYPE_MC13783,
> +	.set_pen_detection = mc13783_set_pen_detection,
> +};
> +
> +static struct mc13xxx_driver_data mc34708_driver_data = {
> +	.type = MC13XXX_TYPE_MC34708,
> +	.set_pen_detection = mc34708_set_pen_detection,
>  };
>  
>  static irqreturn_t mc13783_ts_handler(int irq, void *data)
> @@ -96,6 +135,10 @@ static void mc13783_ts_report_sample(struct mc13783_ts_priv *priv)
>  
>  	cr0 = (cr0 + cr1) / 2;
>  
> +	if (priv->drvdata->type == MC13XXX_TYPE_MC34708)
> +		if (cr0 > 4080)
> +			cr0 = 0;

4080 is the max resistance for MC34708, right? I'd put it into drvdata
as well (and 4096 for the rest), and used

	input_report_abs(idev, ABS_PRESSURE,
			 cr0 ? priv->drvdata->max_resistance - cr0 : 0);

down below.

> +
>  	if (!cr0 || !sample_tolerance ||
>  			(x2 - x0 < sample_tolerance &&
>  			 y2 - y0 < sample_tolerance)) {
> @@ -148,8 +191,7 @@ static int mc13783_ts_open(struct input_dev *dev)
>  	if (ret)
>  		goto out;
>  
> -	ret = mc13xxx_reg_rmw(priv->mc13xxx, MC13XXX_ADC0,
> -			MC13XXX_ADC0_TSMOD_MASK, MC13XXX_ADC0_TSMOD0);
> +	ret = priv->drvdata->set_pen_detection(priv, 1);
>  	if (ret)
>  		mc13xxx_irq_free(priv->mc13xxx, MC13XXX_IRQ_TS, priv);
>  out:
> @@ -162,8 +204,7 @@ static void mc13783_ts_close(struct input_dev *dev)
>  	struct mc13783_ts_priv *priv = input_get_drvdata(dev);
>  
>  	mc13xxx_lock(priv->mc13xxx);
> -	mc13xxx_reg_rmw(priv->mc13xxx, MC13XXX_ADC0,
> -			MC13XXX_ADC0_TSMOD_MASK, 0);
> +	priv->drvdata->set_pen_detection(priv, 0);
>  	mc13xxx_irq_free(priv->mc13xxx, MC13XXX_IRQ_TS, priv);
>  	mc13xxx_unlock(priv->mc13xxx);
>  
> @@ -175,6 +216,7 @@ static int __init mc13783_ts_probe(struct platform_device *pdev)
>  	struct mc13783_ts_priv *priv;
>  	struct mc13xxx_ts_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	struct input_dev *idev;
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
>  	int ret = -ENOMEM;
>  
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> @@ -185,6 +227,7 @@ static int __init mc13783_ts_probe(struct platform_device *pdev)
>  	INIT_DELAYED_WORK(&priv->work, mc13783_ts_work);
>  	priv->mc13xxx = dev_get_drvdata(pdev->dev.parent);
>  	priv->idev = idev;
> +	priv->drvdata = (void *)id->driver_data;
>  
>  	if (pdata) {
>  		priv->atox = pdata->atox;
> @@ -231,7 +274,21 @@ static int mc13783_ts_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct platform_device_id mc13xxx_ts_idtable[] = {
> +	{
> +		.name = "mc13783-ts",
> +		.driver_data = (kernel_ulong_t)&mc13783_driver_data,
> +	}, {
> +		.name = "mc34708-ts",
> +		.driver_data = (kernel_ulong_t)&mc34708_driver_data,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(platform, mc13xxx_ts_idtable);
> +
>  static struct platform_driver mc13783_ts_driver = {
> +	.id_table	= mc13xxx_ts_idtable,
>  	.remove		= mc13783_ts_remove,
>  	.driver		= {
>  		.name	= MC13783_TS_NAME,
> -- 
> 2.11.0
> 

Thanks.

-- 
Dmitry
