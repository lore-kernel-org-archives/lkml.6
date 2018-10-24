Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4432AC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096132081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096132081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeJXRvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:51:39 -0400
Received: from linux-outbound-1.webhostbox.net ([207.174.213.190]:54657 "EHLO
        linux-outbound-1.webhostbox.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726256AbeJXRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:51:38 -0400
Received: from bh-25.webhostbox.net (unknown [172.16.210.78])
        by linux-outbound-1.webhostbox.net (Postfix) with ESMTP id 0866D241531;
        Wed, 24 Oct 2018 07:37:29 +0000 (GMT)
Received: from [127.0.0.1] (port=58739 helo=bh-25.webhostbox.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <linux@roeck-us.net>)
        id 1gFFOk-00Db5d-N0; Wed, 24 Oct 2018 09:24:19 +0000
Received: from 185.7.230.214 ([185.7.230.214]) by cp2.active-venture.com
 (Horde Framework) with HTTP; Wed, 24 Oct 2018 09:24:18 +0000
Date:   Wed, 24 Oct 2018 09:24:18 +0000
Message-ID: <20181024092418.Horde.x5q-8wat9jjHp8dU00-w2gW@cp2.active-venture.com>
From:   linux@roeck-us.net
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] hwmon: (ina3221) Add PM runtime support
References: <20181024023623.4231-1-nicoleotsuka@gmail.com>
 <20181024023623.4231-6-nicoleotsuka@gmail.com>
In-Reply-To: <20181024023623.4231-6-nicoleotsuka@gmail.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Nicolin Chen <nicoleotsuka@gmail.com>:

> If all three channels are disabled via in[123]_enable ABI,
> the driver could suspend the chip for power saving purpose.
>
> So this patch addsd the PM runtime support in order to gain
> more power control than system suspend and resume use case.
>
> For PM runtime, there are a few related changes happening:
> 1) Added a new explicit hdev device pointer for all the pm
>    runtime callbacks. This is because hwmon core registers
>    a child device for each hwmon driver. So there might be
>    a mismatch between two device pointers in the driver if
>    mixing using them.
> 2) Added a check in ina3221_is_enabled() to make sure that
>    the chip is resumed.
> 3) Bypassed the unchanged status in ina3221_write_enable()
>    in order to keep the pm runtime refcount being matched.
> 4) Removed the reset routine in the probe() by calling the
>    resume() via pm_runtime_get_sync(), as they're similar.
>    It's also necessary to do so to match initial refcount
>    with the number of enabled channels.
> 5) Bypassed the system suspend/resume callbacks from the
>    i2c_client->dev, because both the i2c_client->dev and
>    the ina->hdev coexist and share the same pair of system
>    suspend/resume callback functions, which means there'd
>    be two suspend() calls during the system suspend while
>    the second one will fail.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changelog
> v1->v2:
>  * Bypassed i2c_client->dev in suspend/resume()
>  * Added a missing '\n' in one dev_err()
>
>  drivers/hwmon/ina3221.c | 112 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 90 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index 9bbac826e50b..2cdc37ab0cf3 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -21,6 +21,7 @@
>  #include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/regmap.h>
> +#include <linux/pm_runtime.h>
>
>  #define INA3221_DRIVER_NAME		"ina3221"
>
> @@ -53,6 +54,7 @@
>  #define INA3221_CONFIG_CHs_EN_MASK	GENMASK(14, 12)
>  #define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
>
> +#define INA3221_CONFIG_DEFAULT		0x7127
>  #define INA3221_RSHUNT_DEFAULT		10000
>
>  enum ina3221_fields {
> @@ -103,6 +105,7 @@ struct ina3221_input {
>
>  /**
>   * struct ina3221_data - device specific information
> + * @hdev: Device pointer of hwmon child device, used for pm runtime
>   * @regmap: Register map of the device
>   * @fields: Register fields of the device
>   * @inputs: Array of channel input source specific structures
> @@ -110,6 +113,7 @@ struct ina3221_input {
>   * @reg_config: Register value of INA3221_CONFIG
>   */
>  struct ina3221_data {
> +	struct device *hdev;
>  	struct regmap *regmap;
>  	struct regmap_field *fields[F_MAX_FIELDS];
>  	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
> @@ -119,7 +123,8 @@ struct ina3221_data {
>
>  static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
>  {
> -	return ina->reg_config & INA3221_CONFIG_CHx_EN(channel);
> +	return pm_runtime_active(ina->hdev) &&
> +	       (ina->reg_config & INA3221_CONFIG_CHx_EN(channel));
>  }
>
>  /* Lookup table for Bus and Shunt conversion times in usec */
> @@ -294,21 +299,48 @@ static int ina3221_write_enable(struct device  
> *dev, int channel, bool enable)
>  {
>  	struct ina3221_data *ina = dev_get_drvdata(dev);
>  	u16 config, mask = INA3221_CONFIG_CHx_EN(channel);
> +	u16 config_old = ina->reg_config & mask;
>  	int ret;
>
>  	config = enable ? mask : 0;
>
> +	/* Bypass if enable status is not being changed */
> +	if (config_old == config)
> +		return 0;
> +
> +	/* For enabling routine, increase refcount and resume() at first */
> +	if (enable) {
> +		ret = pm_runtime_get_sync(ina->hdev);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to get PM runtime\n");
> +			return ret;
> +		}
> +	}
> +
>  	/* Enable or disable the channel */
>  	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, config);
>  	if (ret)
> -		return ret;
> +		goto fail;
>
>  	/* Cache the latest config register value */
>  	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
>  	if (ret)
> -		return ret;
> +		goto fail;
> +
> +	/* For disabling routine, decrease refcount or suspend() at last */
> +	if (!enable)
> +		pm_runtime_put_sync(ina->hdev);
>
>  	return 0;
> +
> +fail:
> +	if (enable) {
> +		dev_err(dev, "Reverting channel%d enabling: %d\n",
> +			channel, ret);

This message is confusing. Something like "Failed to enable channel %d:
error %d" would be much better.

> +		pm_runtime_put_sync(ina->hdev);
> +	}
> +
> +	return ret;
>  }
>
>  static int ina3221_read(struct device *dev, enum hwmon_sensor_types type,
> @@ -603,7 +635,6 @@ static int ina3221_probe(struct i2c_client *client,
>  {
>  	struct device *dev = &client->dev;
>  	struct ina3221_data *ina;
> -	struct device *hwmon_dev;
>  	int i, ret;
>
>  	ina = devm_kzalloc(dev, sizeof(*ina), GFP_KERNEL);
> @@ -635,44 +666,71 @@ static int ina3221_probe(struct i2c_client *client,
>  		return ret;
>  	}
>
> -	ret = regmap_field_write(ina->fields[F_RST], true);
> -	if (ret) {
> -		dev_err(dev, "Unable to reset device\n");
> -		return ret;
> -	}
> -
> -	/* Sync config register after reset */
> -	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
> -	if (ret)
> -		return ret;
> +	/* The driver will be reset, so use reset value */
> +	ina->reg_config = INA3221_CONFIG_DEFAULT;
>
>  	/* Disable channels if their inputs are disconnected */
>  	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
>  		if (ina->inputs[i].disconnected)
>  			ina->reg_config &= ~INA3221_CONFIG_CHx_EN(i);
>  	}
> -	ret = regmap_write(ina->regmap, INA3221_CONFIG, ina->reg_config);
> -	if (ret)
> -		return ret;
>
>  	mutex_init(&ina->lock);
>  	dev_set_drvdata(dev, ina);
>
> -	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, ina,
> +	/* Fence sysfs nodes till pm_runtime is resumed */
> +	mutex_lock(&ina->lock);
> +
> +	/* Use the returned hdev for pm_runtime */
> +	ina->hdev = devm_hwmon_device_register_with_info(dev, client->name, ina,
>  							 &ina3221_chip_info,
>  							 ina3221_groups);
> -	if (IS_ERR(hwmon_dev)) {
> +	if (IS_ERR(ina->hdev)) {
>  		dev_err(dev, "Unable to register hwmon device\n");
> -		mutex_destroy(&ina->lock);
> -		return PTR_ERR(hwmon_dev);
> +		ret = PTR_ERR(ina->hdev);
> +		goto fail_lock;
>  	}
>
> +	/* Enable PM runtime -- status is suspended by default */
> +	pm_runtime_enable(ina->hdev);
> +
> +	/* Initialize (resume) the device */
> +	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
> +		if (ina->inputs[i].disconnected)
> +			continue;
> +		/* Match the refcount with number of enabled channels */
> +		ret = pm_runtime_get_sync(ina->hdev);
> +		if (ret < 0)
> +			goto fail_pm;
> +	}
> +
> +	mutex_unlock(&ina->lock);
> +
>  	return 0;
> +
> +fail_pm:
> +	pm_runtime_disable(ina->hdev);
> +	pm_runtime_set_suspended(ina->hdev);
> +	for (i = 0; i < INA3221_NUM_CHANNELS; i++)
> +		pm_runtime_put_noidle(ina->hdev);

The count here doesn't match the count above if some channels
are disabled, or if the enable loop above aborted.

> +fail_lock:
> +	mutex_unlock(&ina->lock);
> +	mutex_destroy(&ina->lock);
> +
> +	return ret;
>  }
>
>  static int ina3221_remove(struct i2c_client *client)
>  {
>  	struct ina3221_data *ina = dev_get_drvdata(&client->dev);
> +	int i;
> +
> +	pm_runtime_disable(ina->hdev);
> +	pm_runtime_set_suspended(ina->hdev);
> +
> +	/* Decrease the PM refcount */
> +	for (i = 0; i < INA3221_NUM_CHANNELS; i++)
> +		pm_runtime_put_noidle(ina->hdev);
>
As above, this doesn't take disabled channels into account. Maybe that
doesn't matter; if so, there needs to be a comment indicating that
negative use counts don't matter. If that is the case, make sure that
this is acceptable use of the pm API (if it works but is not documented,
the PM core may change and complain about it at a later time).

>  	mutex_destroy(&ina->lock);
>
> @@ -684,6 +742,10 @@ static int __maybe_unused  
> ina3221_suspend(struct device *dev)
>  	struct ina3221_data *ina = dev_get_drvdata(dev);
>  	int ret;
>
> +	/* Let hdev control all PM runtime callbacks */
> +	if (dev != ina->hdev)
> +		return 0;
> +
>  	/* Save config register value and enable cache-only */
>  	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
>  	if (ret)
> @@ -707,6 +769,10 @@ static int __maybe_unused ina3221_resume(struct  
> device *dev)
>  	struct ina3221_data *ina = dev_get_drvdata(dev);
>  	int ret;
>
> +	/* Let hdev control all PM runtime callbacks */
> +	if (dev != ina->hdev)
> +		return 0;
> +
>  	regcache_cache_only(ina->regmap, false);
>
>  	/* Software reset the chip */
> @@ -730,7 +796,9 @@ static int __maybe_unused ina3221_resume(struct  
> device *dev)
>  }
>
>  static const struct dev_pm_ops ina3221_pm = {
> -	SET_SYSTEM_SLEEP_PM_OPS(ina3221_suspend, ina3221_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(ina3221_suspend, ina3221_resume, NULL)
>  };
>
>  static const struct of_device_id ina3221_of_match_table[] = {
> --
> 2.17.1



