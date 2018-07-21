Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBFEECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B348720856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcEuy0Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B348720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeGUSYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbeGUSYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:24:42 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 274AA20854;
        Sat, 21 Jul 2018 17:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532194273;
        bh=kY/aimcV6GcxtbxbI0VG4exPPLIROw1TWyjGNLXqCv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dcEuy0JfutYtEkh44vSmzFTa4cghtFL4QslRA14SmK+0811ScbAXg8k2LvfKrTuDB
         WenHyzDRxluO4xcBn3H6UDg6mC7YmNRpAzYRXEX6PFks94G94gmCnk7YdM40vSF7+L
         4hQtKYJrXGYp6OhJ34eRNkv7fhnUlNhhUMH9v+A8=
Date:   Sat, 21 Jul 2018 18:31:07 +0100
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
Subject: Re: [PATCH v2 1/7] iio: imu: mpu6050: add support for regulator
 framework
Message-ID: <20180721183107.3770295d@archlinux>
In-Reply-To: <20180717084158.23532-2-masneyb@onstation.org>
References: <20180717084158.23532-1-masneyb@onstation.org>
        <20180717084158.23532-2-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 04:41:52 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch adds support for the regulator framework to the mpu6050
> driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

I'm not 100% sure what the purpose of the regulator_enabled
tracking is.  Perhaps you could point out the path where that is
needed?

Also, a missing bit of documentation needs adding.

Jonathan

> ---
> Changes since v1:
> - Use devm_regulator_get() instead of devm_regulator_get_optional()
> - Use devm_add_action() for cleaning up the regulator.
> - Correct ordering of resume code.
> - Add regulator_enabled flag to ensure regulator is not disabled twice,
>   specifically the case where the device is suspended and then the
>   driver is removed.
> 
> Original extra changelog from v1:
> 
> This is a variation of Jonathan Marek's patch from postmarketOS
> https://gitlab.com/postmarketOS/linux-postmarketos/commit/b8ad1ec1859c8bbcbce94944b3f4dd68f8f9fc37
> with the following changes:
> 
> - Stripped out 6515 variant code.
> - Add the regulator to the mpu core instead of only the i2c variant.
> - Add error handling.
> - Release the regulator on suspend, device remove, etc.
> - Device tree documentation.
> 
>  .../bindings/iio/imu/inv_mpu6050.txt          |  1 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 73 +++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  3 +
>  3 files changed, 77 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> index b7def51c8ad9..d39907b12a46 100644
> --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> @@ -21,6 +21,7 @@ Required properties:
>    bindings.
>  
>  Optional properties:
> + - vddio-supply: regulator phandle for VDDIO supply
>   - mount-matrix: an optional 3x3 mounting rotation matrix
>   - i2c-gate node.  These devices also support an auxiliary i2c bus.  This is
>     simple enough to be described using the i2c-gate binding. See
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 12c1b9507007..e1fbab4bc0a0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -23,6 +23,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/acpi.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include "inv_mpu_iio.h"
>  
>  /*
> @@ -926,6 +927,46 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	return result;
>  }
>  
> +static int inv_mpu_core_enable_regulator(struct inv_mpu6050_state *st)
> +{
> +	int result;
> +
> +	result = regulator_enable(st->vddio_supply);
> +	if (result) {
> +		dev_err(regmap_get_device(st->map),
> +			"Failed to enable regulator: %d\n", result);
> +	} else {
> +		st->regulator_enabled = true;
> +
> +		/* Give the device a little bit of time to start up. */
> +		usleep_range(35000, 70000);
> +	}
> +
> +	return result;
> +}
> +
> +static int inv_mpu_core_disable_regulator(struct inv_mpu6050_state *st)
> +{
> +	int result;
> +
> +	if (!st->regulator_enabled)
> +		return 0;
> +
> +	result = regulator_disable(st->vddio_supply);
> +	if (result)
> +		dev_err(regmap_get_device(st->map),
> +			"Failed to disable regulator: %d\n", result);
> +
> +	st->regulator_enabled = false;
> +
> +	return result;
> +}
> +
> +static void inv_mpu_core_disable_regulator_action(void *_data)
> +{
> +	inv_mpu_core_disable_regulator(_data);
> +}
> +
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
>  {
> @@ -990,6 +1031,28 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		return -EINVAL;
>  	}
>  
> +	st->vddio_supply = devm_regulator_get(dev, "vddio");
> +	if (IS_ERR(st->vddio_supply)) {
> +		if (PTR_ERR(st->vddio_supply) != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get vddio regulator %d\n",
> +				(int)PTR_ERR(st->vddio_supply));
> +
> +		return PTR_ERR(st->vddio_supply);
> +	}
> +
> +	result = inv_mpu_core_enable_regulator(st);
> +	if (result)
> +		return result;
> +
> +	result = devm_add_action(dev, inv_mpu_core_disable_regulator_action,
> +				 st);
> +	if (result) {
> +		inv_mpu_core_disable_regulator_action(st);
> +		dev_err(dev, "Failed to setup regulator cleanup action %d\n",
> +			result);
> +		return result;
> +	}
> +
>  	/* power is turned on inside check chip type*/
>  	result = inv_check_and_setup_chip(st);
>  	if (result)
> @@ -1049,7 +1112,12 @@ static int inv_mpu_resume(struct device *dev)
>  	int result;
>  
>  	mutex_lock(&st->lock);
> +	result = inv_mpu_core_enable_regulator(st);
> +	if (result)
> +		goto out_unlock;
> +
>  	result = inv_mpu6050_set_power_itg(st, true);
> +out_unlock:
>  	mutex_unlock(&st->lock);
>  
>  	return result;
> @@ -1062,6 +1130,11 @@ static int inv_mpu_suspend(struct device *dev)
>  
>  	mutex_lock(&st->lock);
>  	result = inv_mpu6050_set_power_itg(st, false);
> +	if (result)
> +		goto out_unlock;
> +
> +	result = inv_mpu_core_disable_regulator(st);
> +out_unlock:
>  	mutex_unlock(&st->lock);
>  
>  	return result;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index e69a59659dbc..01c8fe9b4fa0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -129,6 +129,7 @@ struct inv_mpu6050_hw {
>   *  @chip_period:	chip internal period estimation (~1kHz).
>   *  @it_timestamp:	timestamp from previous interrupt.
>   *  @data_timestamp:	timestamp for next data sample.
> + *  @vddio_supply	voltage regulator for the chip.
Docs missing for regulator_enabled.
>   */
>  struct inv_mpu6050_state {
>  	struct mutex lock;
> @@ -149,6 +150,8 @@ struct inv_mpu6050_state {
>  	s64 chip_period;
>  	s64 it_timestamp;
>  	s64 data_timestamp;
> +	struct regulator *vddio_supply;
> +	bool regulator_enabled;
>  };
>  
>  /*register and associated bit definition*/

