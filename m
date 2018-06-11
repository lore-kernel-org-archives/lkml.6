Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4na0A8PdHVvhJAAAmS7hNA
	; Mon, 11 Jun 2018 02:27:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AB6BE605A5; Mon, 11 Jun 2018 02:27:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CA4CA605A5;
	Mon, 11 Jun 2018 02:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA4CA605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=electromag.com.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753888AbeFKC1t (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 22:27:49 -0400
Received: from anchovy2.45ru.net.au ([203.30.46.146]:36103 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753778AbeFKC1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 22:27:47 -0400
Received: (qmail 5021 invoked by uid 5089); 11 Jun 2018 02:27:45 -0000
Received: by simscan 1.2.0 ppid: 4927, pid: 4928, t: 0.0797s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 11 Jun 2018 02:27:44 -0000
Subject: Re: [PATCH v4 1/2] power: supply: sbs-battery: don't assume
 MANUFACTURER_DATA formats
To: Brian Norris <briannorris@chromium.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Rhyland Klein <rklein@nvidia.com>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>
References: <20180608223655.33565-1-briannorris@chromium.org>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <977e492a-13b1-6888-d030-e55595a844f2@electromag.com.au>
Date: Mon, 11 Jun 2018 10:27:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608223655.33565-1-briannorris@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/06/2018 06:36, Brian Norris wrote:
> This driver was originally submitted for the TI BQ20Z75 battery IC
> (commit a7640bfa10c5 ("power_supply: Add driver for TI BQ20Z75 gas gauge
> IC")) and later renamed to express generic SBS support. While it's
> mostly true that this driver implemented a standard SBS command set, it
> takes liberties with the REG_MANUFACTURER_DATA register. This register
> is specified in the SBS spec, but it doesn't make any mention of what
> its actual contents are.
> 
> We've sort of noticed this optionality previously, with commit
> 17c6d3979e5b ("sbs-battery: make writes to ManufacturerAccess
> optional"), where we found that some batteries NAK writes to this
> register.
> 
> What this really means is that so far, we've just been lucky that most
> batteries have either been compatible with the TI chip, or else at least
> haven't reported highly-unexpected values.
> 
> For instance, one battery I have here seems to report either 0x0000 or
> 0x0100 to the MANUFACTURER_ACCESS_STATUS command -- while this seems to
> match either Wake Up (bits[11:8] = 0000b) or Normal Discharge
> (bits[11:8] = 0001b) status for the TI part [1], they don't seem to
> actually correspond to real states (for instance, I never see 0101b =
> Charge, even when charging).
> 
> On other batteries, I'm getting apparently random data in return, which
> means that occasionally, we interpret this as "battery not present" or
> "battery is not healthy".
> 
> All in all, it seems to be a really bad idea to make assumptions about
> REG_MANUFACTURER_DATA, unless we already know what battery we're using.
> Therefore, this patch reimplements the "present" and "health" checks to
> the following on most SBS batteries:
> 
> 1. HEALTH: report "unknown" -- I couldn't find a standard SBS command
>     that gives us much useful here
> 2. PRESENT: just send a REG_STATUS command; if it succeeds, then the
>     battery is present
> 
> Also, we stop sending MANUFACTURER_ACCESS_SLEEP to non-TI parts. I have
> no proof that this is useful and supported.
> 
> If someone explicitly provided a 'ti,bq20z75' compatible property, then
> we continue to use the existing TI command behaviors, and we effectively
> revert commit 17c6d3979e5b ("sbs-battery: make writes to
> ManufacturerAccess optional") to again make these commands required.
> 
> [1] http://www.ti.com/lit/er/sluu265a/sluu265a.pdf
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Rhyland Klein <rklein@nvidia.com>
Reviewed-by: Phil Reid <preid@electromag.com.au>
> ---
> v2:
>   * don't stub out POWER_SUPPLY_PROP_PRESENT from sbs_data[]
>   * use if/else instead of switch/case
> 
> v3:
>   * pull 'return 0' out of if/else, to satisfy braindead tooling
> 
> v4:
>   * make ManufacturerAccess non-optional for TI parts again
> ---
>   drivers/power/supply/sbs-battery.c | 67 ++++++++++++++++++++++++------
>   1 file changed, 54 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 83d7b4115857..8ba6abf584de 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -23,6 +23,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_device.h>
>   #include <linux/power/sbs-battery.h>
>   #include <linux/power_supply.h>
>   #include <linux/slab.h>
> @@ -156,6 +157,9 @@ static enum power_supply_property sbs_properties[] = {
>   	POWER_SUPPLY_PROP_MODEL_NAME
>   };
>   
> +/* Supports special manufacturer commands from TI BQ20Z75 IC. */
> +#define SBS_FLAGS_TI_BQ20Z75		BIT(0)
> +
>   struct sbs_info {
>   	struct i2c_client		*client;
>   	struct power_supply		*power_supply;
> @@ -168,6 +172,7 @@ struct sbs_info {
>   	u32				poll_retry_count;
>   	struct delayed_work		work;
>   	struct mutex			mode_lock;
> +	u32				flags;
>   };
>   
>   static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
> @@ -315,17 +320,41 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
>   static int sbs_get_battery_presence_and_health(
>   	struct i2c_client *client, enum power_supply_property psp,
>   	union power_supply_propval *val)
> +{
> +	int ret;
> +
> +	if (psp == POWER_SUPPLY_PROP_PRESENT) {
> +		/* Dummy command; if it succeeds, battery is present. */
> +		ret = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
> +		if (ret < 0)
> +			val->intval = 0; /* battery disconnected */
> +		else
> +			val->intval = 1; /* battery present */
> +	} else { /* POWER_SUPPLY_PROP_HEALTH */
> +		/* SBS spec doesn't have a general health command. */
> +		val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sbs_get_ti_battery_presence_and_health(
> +	struct i2c_client *client, enum power_supply_property psp,
> +	union power_supply_propval *val)
>   {
>   	s32 ret;
>   
>   	/*
>   	 * Write to ManufacturerAccess with ManufacturerAccess command
> -	 * and then read the status. Do not check for error on the write
> -	 * since not all batteries implement write access to this command,
> -	 * while others mandate it.
> +	 * and then read the status.
>   	 */
> -	sbs_write_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr,
> -			    MANUFACTURER_ACCESS_STATUS);
> +	ret = sbs_write_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr,
> +				  MANUFACTURER_ACCESS_STATUS);
> +	if (ret < 0) {
> +		if (psp == POWER_SUPPLY_PROP_PRESENT)
> +			val->intval = 0; /* battery removed */
> +		return ret;
> +	}
>   
>   	ret = sbs_read_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr);
>   	if (ret < 0) {
> @@ -600,7 +629,12 @@ static int sbs_get_property(struct power_supply *psy,
>   	switch (psp) {
>   	case POWER_SUPPLY_PROP_PRESENT:
>   	case POWER_SUPPLY_PROP_HEALTH:
> -		ret = sbs_get_battery_presence_and_health(client, psp, val);
> +		if (client->flags & SBS_FLAGS_TI_BQ20Z75)
> +			ret = sbs_get_ti_battery_presence_and_health(client,
> +								     psp, val);
> +		else
> +			ret = sbs_get_battery_presence_and_health(client, psp,
> +								  val);
>   		if (psp == POWER_SUPPLY_PROP_PRESENT)
>   			return 0;
>   		break;
> @@ -806,6 +840,7 @@ static int sbs_probe(struct i2c_client *client,
>   	if (!chip)
>   		return -ENOMEM;
>   
> +	chip->flags = (u32)(uintptr_t)of_device_get_match_data(&client->dev);
>   	chip->client = client;
>   	chip->enable_detection = false;
>   	psy_cfg.of_node = client->dev.of_node;
> @@ -911,16 +946,19 @@ static int sbs_suspend(struct device *dev)
>   {
>   	struct i2c_client *client = to_i2c_client(dev);
>   	struct sbs_info *chip = i2c_get_clientdata(client);
> +	int ret;
>   
>   	if (chip->poll_time > 0)
>   		cancel_delayed_work_sync(&chip->work);
>   
> -	/*
> -	 * Write to manufacturer access with sleep command.
> -	 * Support is manufacturer dependend, so ignore errors.
> -	 */
> -	sbs_write_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr,
> -		MANUFACTURER_ACCESS_SLEEP);
> +	if (chip->flags & SBS_FLAGS_TI_BQ20Z75) {
> +		/* Write to manufacturer access with sleep command. */
> +		ret = sbs_write_word_data(client,
> +					  sbs_data[REG_MANUFACTURER_DATA].addr,
> +					  MANUFACTURER_ACCESS_SLEEP);
> +		if (chip->is_present && ret < 0)
> +			return ret;
> +	}
>   
>   	return 0;
>   }
> @@ -941,7 +979,10 @@ MODULE_DEVICE_TABLE(i2c, sbs_id);
>   
>   static const struct of_device_id sbs_dt_ids[] = {
>   	{ .compatible = "sbs,sbs-battery" },
> -	{ .compatible = "ti,bq20z75" },
> +	{
> +		.compatible = "ti,bq20z75",
> +		.data = (void *)SBS_FLAGS_TI_BQ20Z75,
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, sbs_dt_ids);
> 


-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

3 The Avenue, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid@electromag.com.au
