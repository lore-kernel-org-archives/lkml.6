Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755315AbeEHTUK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 15:20:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35703 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbeEHTUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 15:20:08 -0400
Date: Tue, 8 May 2018 21:19:56 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rtc: ds1307: add calibration of_ for mt41txx chips.
Message-ID: <20180508191956.GP10960@piout.net>
References: <20180508145611.49072-1-giulio.benetti@micronovasrl.com>
 <20180508145611.49072-3-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508145611.49072-3-giulio.benetti@micronovasrl.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a sysfs interface for calibration, please use it. this is
especially useful since the calibration value probably depend on
temperature so it has to be updated dynamically to be really useful.

See https://elixir.bootlin.com/linux/v4.16.7/source/Documentation/ABI/testing/sysfs-class-rtc#L68
and https://elixir.bootlin.com/linux/v4.16.7/source/drivers/rtc/interface.c#L999

On 08/05/2018 16:56:10+0200, Giulio Benetti wrote:
> m41txx chips can hold a calibration value to get really near to real
> tick value.
> 
> Add calibration property(ranging between (-31) and 31), so on every probe
> calibration value will be written to rtc.
> This is because ic could loose supply due to low battery.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../devicetree/bindings/rtc/rtc-ds1307.txt    |  2 ++
>  drivers/rtc/rtc-ds1307.c                      | 33 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
> index ce6469c1a516..d3d70a5495c5 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
> @@ -34,6 +34,8 @@ Optional properties:
>  - trickle-diode-disable : ds1339, ds1340 and ds 1388 only
>  	Do not use internal trickle charger diode
>  	Should be given if internal trickle charger diode should be disabled
> +- calibration: m41t0, m41t00, m41t11 only
> +	Set calibration value to correct external bias, ranging between (-31) and 31.
>  
>  Example:
>  	rtc1: ds1339@68 {
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 0ab0c166da83..9cda52589c0f 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -114,6 +114,12 @@ enum ds_type {
>  #	define RX8025_BIT_VDET		0x40
>  #	define RX8025_BIT_XST		0x20
>  
> +#define M41TXX_REG_CONTROL	0x07
> +#	define M41TXX_BIT_OUT		0x80
> +#	define M41TXX_BIT_FT		0x40
> +#	define M41TXX_BIT_CALIB_SIGN	0x20
> +#	define M41TXX_M_CALIBRATION	0x1f
> +
>  struct ds1307 {
>  	enum ds_type		type;
>  	unsigned long		flags;
> @@ -1397,6 +1403,7 @@ static int ds1307_probe(struct i2c_client *client,
>  	unsigned char		regs[8];
>  	struct ds1307_platform_data *pdata = dev_get_platdata(&client->dev);
>  	u8			trickle_charger_setup = 0;
> +	s32			calib;
>  
>  	ds1307 = devm_kzalloc(&client->dev, sizeof(struct ds1307), GFP_KERNEL);
>  	if (!ds1307)
> @@ -1460,6 +1467,32 @@ static int ds1307_probe(struct i2c_client *client,
>  	if (chip->alarm && of_property_read_bool(client->dev.of_node,
>  						 "wakeup-source"))
>  		ds1307_can_wakeup_device = true;
> +
> +	/* retrieve calibration value if provided */
> +	if (!of_property_read_s32(client->dev.of_node, "calibration",
> +				 &calib)) {
> +		switch (ds1307->type) {
> +		case m41t0:
> +		case m41t00:
> +		case m41t11:
> +		{
> +			/*
> +			 * Set calibration value every power-on since rtc
> +			 * could have shut off(low battery)
> +			 */
> +			u8 out_byte = abs(calib) & M41TXX_M_CALIBRATION;
> +
> +			if (calib >= 0)
> +				out_byte |= M41TXX_BIT_CALIB_SIGN;
> +
> +			regmap_write(ds1307->regmap, M41TXX_REG_CONTROL,
> +					out_byte);
> +		}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
>  #endif
>  
>  	switch (ds1307->type) {
> -- 
> 2.17.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
