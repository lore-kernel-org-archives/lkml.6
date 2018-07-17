Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735CAECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1294F20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1294F20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbeGQVek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:34:40 -0400
Received: from avasout05.plus.net ([84.93.230.250]:46554 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbeGQVej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:34:39 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id fX4nf0w0k05ijfX4ofF3fE; Tue, 17 Jul 2018 22:00:12 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QJJGuDDL c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=IkcTkHD0fZMA:10 a=R9QF1RCXAYgA:10 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8
 a=6TZtSGDV1qYMrcTs3qQA:9 a=nMnXHCmPwxmY64QX:21 a=kPstQwhks1Tn8aqv:21
 a=QEXdDO2ut3YA:10
Received: by hairyalien (sSMTP sendmail emulation); Tue, 17 Jul 2018 22:00:05 +0100
Date:   Tue, 17 Jul 2018 22:00:05 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: atmel_mxt_ts: Add support for  optional
 regulators.
Message-ID: <20180717210005.GA21416@hairyalien>
References: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1531851386-17840-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531851386-17840-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMAE-Envelope: MS4wfBnGOlP2wV8Hd5/1i2glJlyVzj4k10NHH6g5g9hZuijbXArqkYfx/oLqKX9xt9esOhJb87EiYHPctvT8mTLV0qtsZLfC738ou5ivZaRKMlKpSBGQYW8l
 qfJBGYCz9VNX0rnaasi7JCzgdeuTlqcXAhk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 08:16:25PM +0200, Paweł Chmiel wrote:
> This patch adds optional regulators, which can be used to power
> up touchscreen. After enabling regulators, we need to wait 150msec.
> This value is taken from official driver.
> 
> It was tested on Samsung Galaxy i9000 (based on Samsung S5PV210 SOC).
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v1:
>   - Enable regulators only if reset_gpio is present.
>   - Switch from devm_regulator_get_optional to devm_regulator_get
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 46 ++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 54fe190fd4bc..005f0fee9fc8 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -27,6 +27,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/of.h>
>  #include <linux/property.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/property.h>
> @@ -194,10 +195,10 @@ enum t100_type {
>  
>  /* Delay times */
>  #define MXT_BACKUP_TIME		50	/* msec */
> -#define MXT_RESET_GPIO_TIME	20	/* msec */
>  #define MXT_RESET_INVALID_CHG	100	/* msec */
>  #define MXT_RESET_TIME		200	/* msec */
>  #define MXT_RESET_TIMEOUT	3000	/* msec */
> +#define MXT_REGULATOR_DELAY	150	/* msec */
>  #define MXT_CRC_TIMEOUT		1000	/* msec */
>  #define MXT_FW_RESET_TIME	3000	/* msec */
>  #define MXT_FW_CHG_TIMEOUT	300	/* msec */
> @@ -310,6 +311,8 @@ struct mxt_data {
>  	struct t7_config t7_cfg;
>  	struct mxt_dbg dbg;
>  	struct gpio_desc *reset_gpio;
> +	struct regulator *vdd_reg;
> +	struct regulator *avdd_reg;
>  
>  	/* Cached parameters from object table */
>  	u16 T5_address;
> @@ -3076,6 +3079,22 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		return error;
>  	}
>  
> +	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(data->vdd_reg)) {
> +		error = PTR_ERR(data->vdd_reg);
> +		dev_err(&client->dev, "Failed to get vdd regulator: %d\n",
> +			error);
> +		return error;
> +	}
> +
> +	data->avdd_reg = devm_regulator_get(&client->dev, "avdd");
> +	if (IS_ERR(data->avdd_reg)) {
> +		error = PTR_ERR(data->avdd_reg);
> +		dev_err(&client->dev, "Failed to get avdd regulator: %d\n",
> +			error);
> +		return error;
> +	}
> +
>  	error = devm_request_threaded_irq(&client->dev, client->irq,
>  					  NULL, mxt_interrupt, IRQF_ONESHOT,
>  					  client->name, data);
> @@ -3087,7 +3106,26 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	disable_irq(client->irq);
>  
>  	if (data->reset_gpio) {
> -		msleep(MXT_RESET_GPIO_TIME);
> +		error = regulator_enable(data->vdd_reg);
> +		if (error) {
> +			dev_err(&client->dev, "Failed to enable vdd regulator: %d\n",
> +				error);
> +			return error;
> +		}
> +
> +		error = regulator_enable(data->avdd_reg);
> +		if (error) {
> +			dev_err(&client->dev, "Failed to enable avdd regulator: %d\n",
> +				error);
> +			return error;
> +		}
> +
> +		/*
> +		 * According to maXTouch power sequencing specification, RESET line
> +		 * must be kept low until some time after regulators come up to
> +		 * voltage
> +		 */
> +		msleep(MXT_REGULATOR_DELAY);
>  		gpiod_set_value(data->reset_gpio, 1);
>  		msleep(MXT_RESET_INVALID_CHG);

Hi Pawel-

I see you've borrowed some of the logic from the patch I wrote a while
back (see https://github.com/ndyer/linux/commit/8e9687e41ed062 )

The correct behaviour according to Atmel should be:

* Make RESET zero
* Bring up regulators
* Wait for a period to settle (150 msec)
* Release RESET
* Wait for 100 msec whilst device gets through bootloader
* Wait for CHG line assert before reading info block

I can't see the first and last steps in your patch at present.

The only downside with this approach is that there are a lot of
delays during driver probe, but I believe the asynchronous probe stuff
that's landed since I wrote the original patch should address that.

cheers

Nick

>  	}
> @@ -3116,6 +3154,10 @@ static int mxt_remove(struct i2c_client *client)
>  	struct mxt_data *data = i2c_get_clientdata(client);
>  
>  	disable_irq(data->irq);
> +	if (data->reset_gpio) {
> +		regulator_disable(data->avdd_reg);
> +		regulator_disable(data->vdd_reg);
> +	}
>  	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
>  	mxt_free_input_device(data);
>  	mxt_free_object_table(data);
> -- 
> 2.7.4
> 
