Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeFARej (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:34:39 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:41943 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeFAReg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:34:36 -0400
Date: Fri, 1 Jun 2018 10:34:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Rhyland Klein <rklein@nvidia.com>,
        Alexandru Stan <amstan@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/2] power: supply: sbs-battery: don't assume
 MANUFACTURER_DATA formats
Message-ID: <20180601173434.GA22509@roeck-us.net>
References: <20180601172400.50737-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601172400.50737-1-briannorris@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 10:23:59AM -0700, Brian Norris wrote:
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
>    that gives us much useful here
> 2. PRESENT: just send a REG_STATUS command; if it succeeds, then the
>    battery is present
> 
> Also, we stop sending MANUFACTURER_ACCESS_SLEEP to non-TI parts. I have
> no proof that this is useful and supported.
> 
> If someone explicitly provided a 'ti,bq20z75' compatible property, then
> we retain the existing TI command behaviors.
> 
> [1] http://www.ti.com/lit/er/sluu265a/sluu265a.pdf
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v2:
>  * don't stub out POWER_SUPPLY_PROP_PRESENT from sbs_data[]
>  * use if/else instead of switch/case
> ---
>  drivers/power/supply/sbs-battery.c | 54 +++++++++++++++++++++++++-----
>  1 file changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 83d7b4115857..8dea63464a3f 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -23,6 +23,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/power/sbs-battery.h>
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
> @@ -156,6 +157,9 @@ static enum power_supply_property sbs_properties[] = {
>  	POWER_SUPPLY_PROP_MODEL_NAME
>  };
>  
> +/* Supports special manufacturer commands from TI BQ20Z75 IC. */
> +#define SBS_FLAGS_TI_BQ20Z75		BIT(0)
> +
>  struct sbs_info {
>  	struct i2c_client		*client;
>  	struct power_supply		*power_supply;
> @@ -168,6 +172,7 @@ struct sbs_info {
>  	u32				poll_retry_count;
>  	struct delayed_work		work;
>  	struct mutex			mode_lock;
> +	u32				flags;
>  };
>  
>  static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
> @@ -315,6 +320,27 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
>  static int sbs_get_battery_presence_and_health(
>  	struct i2c_client *client, enum power_supply_property psp,
>  	union power_supply_propval *val)
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
> +		return 0;
> +	} else { /* POWER_SUPPLY_PROP_HEALTH */

Static analyzers may complain that else after return is unnecessary.

Other than that

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> +		/* SBS spec doesn't have a general health command. */
> +		val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
> +		return 0;
> +	}
> +}
> +
> +static int sbs_get_ti_battery_presence_and_health(
> +	struct i2c_client *client, enum power_supply_property psp,
> +	union power_supply_propval *val)
>  {
>  	s32 ret;
>  
> @@ -600,7 +626,12 @@ static int sbs_get_property(struct power_supply *psy,
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_PRESENT:
>  	case POWER_SUPPLY_PROP_HEALTH:
> -		ret = sbs_get_battery_presence_and_health(client, psp, val);
> +		if (client->flags & SBS_FLAGS_TI_BQ20Z75)
> +			ret = sbs_get_ti_battery_presence_and_health(client,
> +								     psp, val);
> +		else
> +			ret = sbs_get_battery_presence_and_health(client, psp,
> +								  val);
>  		if (psp == POWER_SUPPLY_PROP_PRESENT)
>  			return 0;
>  		break;
> @@ -806,6 +837,7 @@ static int sbs_probe(struct i2c_client *client,
>  	if (!chip)
>  		return -ENOMEM;
>  
> +	chip->flags = (u32)(uintptr_t)of_device_get_match_data(&client->dev);
>  	chip->client = client;
>  	chip->enable_detection = false;
>  	psy_cfg.of_node = client->dev.of_node;
> @@ -915,12 +947,15 @@ static int sbs_suspend(struct device *dev)
>  	if (chip->poll_time > 0)
>  		cancel_delayed_work_sync(&chip->work);
>  
> -	/*
> -	 * Write to manufacturer access with sleep command.
> -	 * Support is manufacturer dependend, so ignore errors.
> -	 */
> -	sbs_write_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr,
> -		MANUFACTURER_ACCESS_SLEEP);
> +	if (chip->flags & SBS_FLAGS_TI_BQ20Z75) {
> +		/*
> +		 * Write to manufacturer access with sleep command.
> +		 * Support is manufacturer dependent, so ignore errors.
> +		 */
> +		sbs_write_word_data(client,
> +				    sbs_data[REG_MANUFACTURER_DATA].addr,
> +				    MANUFACTURER_ACCESS_SLEEP);
> +	}
>  
>  	return 0;
>  }
> @@ -941,7 +976,10 @@ MODULE_DEVICE_TABLE(i2c, sbs_id);
>  
>  static const struct of_device_id sbs_dt_ids[] = {
>  	{ .compatible = "sbs,sbs-battery" },
> -	{ .compatible = "ti,bq20z75" },
> +	{
> +		.compatible = "ti,bq20z75",
> +		.data = (void *)SBS_FLAGS_TI_BQ20Z75,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sbs_dt_ids);
> -- 
> 2.17.0.921.gf22659ad46-goog
> 
