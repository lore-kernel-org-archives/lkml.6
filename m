Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD8DC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 17:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AD621710
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 17:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N45kE5AN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AD621710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeHRUMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 16:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeHRUMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 16:12:52 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D6BC21570;
        Sat, 18 Aug 2018 17:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534611869;
        bh=HuLaucXuLEB4Q/aVfI/Mwfc9UWBx/FeN3knoskyVAJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N45kE5AN4Tw3nEIVmlKrgMyxz6r7YZnWbPCzhasa6fa4DwLFure8Ks+RAbHSt9sC7
         K8wTs4PNf+eTq36NuQF225JtFUDMDuOtIGUAVVcYa810uSIRq+PPu62kJMVGd8vRC1
         140McQgtO/KVMpc1bFWdZ15HzQ1wG4VkT8aOmXxw=
Date:   Sat, 18 Aug 2018 18:04:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH v3 3/9] iio: tsl2772: add support for reading proximity
 led settings from device tree
Message-ID: <20180818180423.678a1a09@archlinux>
In-Reply-To: <20180803001900.25371-4-masneyb@onstation.org>
References: <20180803001900.25371-1-masneyb@onstation.org>
        <20180803001900.25371-4-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Aug 2018 20:18:54 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch adds support for optionally reading the proximity led diode
> and current settings from device tree. This was tested using a LG
> Nexus 5 (hammerhead) which requires a different diode than the driver
> default for the IR LED.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with them.

thanks,

Jonathan

> ---
>  drivers/iio/light/tsl2772.c | 81 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index df5b2a0da96c..ae00edf0d87e 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -107,6 +107,8 @@
>  #define TSL2772_ALS_GAIN_TRIM_MIN	250
>  #define TSL2772_ALS_GAIN_TRIM_MAX	4000
>  
> +#define TSL2772_MAX_PROX_LEDS		2
> +
>  /* Device family members */
>  enum {
>  	tsl2571,
> @@ -141,6 +143,14 @@ struct tsl2772_chip_info {
>  	const struct iio_info *info;
>  };
>  
> +static const int tsl2772_led_currents[][2] = {
> +	{ 100000, TSL2772_100_mA },
> +	{  50000, TSL2772_50_mA },
> +	{  25000, TSL2772_25_mA },
> +	{  13000, TSL2772_13_mA },
> +	{      0, 0 }
> +};
> +
>  struct tsl2772_chip {
>  	kernel_ulong_t id;
>  	struct mutex prox_mutex;
> @@ -515,6 +525,75 @@ static int tsl2772_get_prox(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> +static int tsl2772_read_prox_led_current(struct tsl2772_chip *chip)
> +{
> +	struct device_node *of_node = chip->client->dev.of_node;
> +	int ret, tmp, i;
> +
> +	ret = of_property_read_u32(of_node, "led-max-microamp", &tmp);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; tsl2772_led_currents[i][0] != 0; i++) {
> +		if (tmp == tsl2772_led_currents[i][0]) {
> +			chip->settings.prox_power = tsl2772_led_currents[i][1];
> +			return 0;
> +		}
> +	}
> +
> +	dev_err(&chip->client->dev, "Invalid value %d for led-max-microamp\n",
> +		tmp);
> +
> +	return -EINVAL;
> +
> +}
> +
> +static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
> +{
> +	struct device_node *of_node = chip->client->dev.of_node;
> +	int i, ret, num_leds, prox_diode_mask;
> +	u32 leds[TSL2772_MAX_PROX_LEDS];
> +
> +	ret = of_property_count_u32_elems(of_node, "amstaos,proximity-diodes");
> +	if (ret < 0)
> +		return ret;
> +
> +	num_leds = ret;
> +	if (num_leds > TSL2772_MAX_PROX_LEDS)
> +		num_leds = TSL2772_MAX_PROX_LEDS;
> +
> +	ret = of_property_read_u32_array(of_node, "amstaos,proximity-diodes",
> +					 leds, num_leds);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"Invalid value for amstaos,proximity-diodes: %d.\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	prox_diode_mask = 0;
> +	for (i = 0; i < num_leds; i++) {
> +		if (leds[i] == 0)
> +			prox_diode_mask |= TSL2772_DIODE0;
> +		else if (leds[i] == 1)
> +			prox_diode_mask |= TSL2772_DIODE1;
> +		else {
> +			dev_err(&chip->client->dev,
> +				"Invalid value %d in amstaos,proximity-diodes.\n",
> +				leds[i]);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void tsl2772_parse_dt(struct tsl2772_chip *chip)
> +{
> +	tsl2772_read_prox_led_current(chip);
> +	tsl2772_read_prox_diodes(chip);
> +}
> +
>  /**
>   * tsl2772_defaults() - Populates the device nominal operating parameters
>   *                      with those provided by a 'platform' data struct or
> @@ -541,6 +620,8 @@ static void tsl2772_defaults(struct tsl2772_chip *chip)
>  		memcpy(chip->tsl2772_device_lux,
>  		       tsl2772_default_lux_table_group[chip->id],
>  		       TSL2772_DEFAULT_TABLE_BYTES);
> +
> +	tsl2772_parse_dt(chip);
>  }
>  
>  /**

