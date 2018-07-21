Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBFE20863
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj0N+13i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBFE20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeGUS3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbeGUS3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:29:33 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A2F20858;
        Sat, 21 Jul 2018 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532194564;
        bh=MADhKlqLfOSYe54qX7BIt0HGZBgyruP2QwNXkT+RZ10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zj0N+13itID0uudhvVpfAsVDzKU7IFivZDryf5S0I9sbT7wkrma4sz95aIPsLQgT3
         oI5dVlV/2UHnI/BG6CS5FFoX2wgT7J8Qjus7P8HC7tPZgsm7RfNGYEGG0sUT6Y0eZH
         O7T/FQK7bsmxxs3QxTlw00XdV8Rb3w/D9NBTJpPE=
Date:   Sat, 21 Jul 2018 18:35:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        drew.paterson@ams.com
Subject: Re: [PATCH v2 3/7] iio: tsl2772: add support for reading power
 settings from device tree
Message-ID: <20180721183558.47510487@archlinux>
In-Reply-To: <20180717084158.23532-4-masneyb@onstation.org>
References: <20180717084158.23532-1-masneyb@onstation.org>
        <20180717084158.23532-4-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 04:41:54 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch adds support for optionally reading the prox_diode and
> prox_power settings from device tree. This was tested using a LG
> Nexus 5 (hammerhead) which requires a different diode than the driver
> default for the IR LED.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

I think we can make this binding more 'generic' as right now
the amstaos bindings aren't even general enough to apply
to future amstaos devices that need a similar binding.

I'm always anti defines rather than real values in DT (where
possible) and I think there is no reason not to use real values
here.

Jonathan

> ---
> The next patch in the series removes the tsl2772 driver from the
> trivial-devices.txt file. I separated it out so that change can go
> through device tree.
> 
>  .../devicetree/bindings/iio/light/tsl2772.txt | 39 +++++++++++++++++++
>  drivers/iio/light/tsl2772.c                   | 16 ++++++++
>  include/dt-bindings/iio/amstaos,tsl2772.h     | 24 ++++++++++++
>  3 files changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
>  create mode 100644 include/dt-bindings/iio/amstaos,tsl2772.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> new file mode 100644
> index 000000000000..ab553d52b9fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> @@ -0,0 +1,39 @@
> +* AMS/TAOS ALS and proximity sensor
> +
> +Required properties:
> +
> +  - compatible: Should be one of
> +		"amstaos,tsl2571"
> +		"amstaos,tsl2671"
> +		"amstaos,tmd2671"
> +		"amstaos,tsl2771"
> +		"amstaos,tmd2771"
> +		"amstaos,tsl2572"
> +		"amstaos,tsl2672"
> +		"amstaos,tmd2672"
> +		"amstaos,tsl2772"
> +		"amstaos,tmd2772"
> +  - reg: the I2C address of the device
> +
> +Optional properties:
> +
> +  - amstaos,prox_diode - must be TSL2772_DIODE0, TSL2772_DIODE1, or
> +                         TSL2772_DIODE_BOTH.
> +  - amstaos,prox_power - must be TSL2772_100_mA, TSL2772_50_mA, TSL2772_25_mA,
> +                         or TSL2772_13_mA.
> +  - interrupt-parent: should be the phandle for the interrupt controller
> +  - interrupts: the sole interrupt generated by the device
> +
> +  Refer to interrupt-controller/interrupts.txt for generic interrupt client
> +  node bindings.
> +
> +Example:
> +
> +#include <dt-bindings/iio/amstaos,tsl2772.h>
> +
> +tsl2772@39 {
> +	compatible = "amstaos,tsl2772";
> +	reg = <0x39>;
> +	interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
> +	amstaos,prox_diode = <TSL2772_DIODE0>;
> +};
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 34d42a2504c9..0be57f2ecb02 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -515,6 +515,18 @@ static int tsl2772_get_prox(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_OF
> +static void tsl2772_parse_dt(struct tsl2772_chip *chip)
> +{
> +	struct device_node *of_node = chip->client->dev.of_node;
> +
> +	of_property_read_u32(of_node, "amstaos,prox_diode",
> +			     &chip->settings.prox_diode);
> +	of_property_read_u32(of_node, "amstaos,prox_power",
> +			     &chip->settings.prox_power);
> +}
> +#endif
> +
>  /**
>   * tsl2772_defaults() - Populates the device nominal operating parameters
>   *                      with those provided by a 'platform' data struct or
> @@ -541,6 +553,10 @@ static void tsl2772_defaults(struct tsl2772_chip *chip)
>  		memcpy(chip->tsl2772_device_lux,
>  		       tsl2772_default_lux_table_group[chip->id],
>  		       TSL2772_DEFAULT_TABLE_BYTES);
> +
> +#ifdef CONFIG_OF
> +	tsl2772_parse_dt(chip);
> +#endif
>  }
>  
>  /**
> diff --git a/include/dt-bindings/iio/amstaos,tsl2772.h b/include/dt-bindings/iio/amstaos,tsl2772.h
> new file mode 100644
> index 000000000000..ad6f9fbc0845
> --- /dev/null
> +++ b/include/dt-bindings/iio/amstaos,tsl2772.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Device driver for monitoring ambient light intensity (lux)
> + * and proximity (prox) within the TAOS TSL2772 family of devices.
> + *
> + * Copyright (c) 2012 TAOS Corporation.
> + * Copyright (c) 2017-2018 Brian Masney <masneyb@onstation.org>
> + */
> +
> +#ifndef _DT_BINDINGS_AMSTAOS_TSL2772_H
> +#define _DT_BINDINGS_AMSTAOS_TSL2772_H
> +
> +/* Proximity diode to use */
> +#define TSL2772_DIODE0                  0x01
> +#define TSL2772_DIODE1                  0x02
> +#define TSL2772_DIODE_BOTH              0x03

Can we have two separate parameters to enable them?

> +
> +/* LED Power */
> +#define TSL2772_100_mA                  0x00
> +#define TSL2772_50_mA                   0x01
> +#define TSL2772_25_mA                   0x02
> +#define TSL2772_13_mA                   0x03

I'd like to see real numbers rather than defines.  List the valid
values in the binding then match them to register addresses in the 
driver.

A different instance of this binding for a different taos device
might have different values that are valid.


> +
> +#endif /* _DT_BINDINGS_AMSTAOS_TSL2772_H */

