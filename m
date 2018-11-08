Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A308BECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7724620827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7724620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeKIDxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:53:13 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44034 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeKIDxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:53:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8IGRO9026580;
        Thu, 8 Nov 2018 12:16:27 -0600
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8IGR92126457
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 12:16:27 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 12:16:27 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 12:16:26 -0600
Received: from [172.22.151.38] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8IGQfY032478;
        Thu, 8 Nov 2018 12:16:26 -0600
Subject: Re: [PATCH 10/24] leds: lp8860: Use led_compose_name()
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-11-git-send-email-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <d0d4eff7-5840-95d7-a1a1-104188d1b619@ti.com>
Date:   Thu, 8 Nov 2018 12:16:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541542052-10081-11-git-send-email-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2018 04:07 PM, Jacek Anaszewski wrote:
> Switch to using generic LED support for composing LED class
> device name.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/leds/leds-lp8860.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
> index 39c72a9..7c12ccd 100644
> --- a/drivers/leds/leds-lp8860.c
> +++ b/drivers/leds/leds-lp8860.c
> @@ -22,7 +22,6 @@
>  #include <linux/of_gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/slab.h>
> -#include <uapi/linux/uleds.h>
>  
>  #define LP8860_DISP_CL1_BRT_MSB		0x00
>  #define LP8860_DISP_CL1_BRT_LSB		0x01
> @@ -87,6 +86,8 @@
>  
>  #define LP8860_CLEAR_FAULTS		0x01
>  
> +#define LP8860_NAME			"lp8860"
> +
>  /**
>   * struct lp8860_led -
>   * @lock - Lock for reading/writing the device
> @@ -96,7 +97,6 @@
>   * @eeprom_regmap - EEPROM register map
>   * @enable_gpio - VDDIO/EN gpio to enable communication interface
>   * @regulator - LED supply regulator pointer
> - * @label - LED label
>   */
>  struct lp8860_led {
>  	struct mutex lock;
> @@ -106,7 +106,6 @@ struct lp8860_led {
>  	struct regmap *eeprom_regmap;
>  	struct gpio_desc *enable_gpio;
>  	struct regulator *regulator;
> -	char label[LED_MAX_NAME_SIZE];
>  };
>  
>  struct lp8860_eeprom_reg {
> @@ -387,25 +386,26 @@ static int lp8860_probe(struct i2c_client *client,
>  	struct lp8860_led *led;
>  	struct device_node *np = client->dev.of_node;
>  	struct device_node *child_node;
> -	const char *name;
> +	struct led_init_data init_data;
>  
>  	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
>  	if (!led)
>  		return -ENOMEM;
>  
> -	for_each_available_child_of_node(np, child_node) {
> -		led->led_dev.default_trigger = of_get_property(child_node,
> -						    "linux,default-trigger",
> -						    NULL);
> -
> -		ret = of_property_read_string(child_node, "label", &name);
> -		if (!ret)
> -			snprintf(led->label, sizeof(led->label), "%s:%s",
> -				 id->name, name);
> -		else
> -			snprintf(led->label, sizeof(led->label),
> -				"%s::display_cluster", id->name);
> -	}

We need to keep a loop here looking for additional nodes as this device has string support and just
not cluster support.

Just need to get the other LED patches done.

> +	child_node = of_get_next_available_child(np, NULL);
> +	if (!child_node)
> +		return -EINVAL;
> +
> +	init_data.fwnode = of_fwnode_handle(child_node),
> +
> +	led->led_dev.default_trigger = of_get_property(child_node,
> +					    "linux,default-trigger",
> +					    NULL);
> +
> +	ret = led_compose_name(init_data.fwnode, LP8860_NAME,
> +			       ":display_cluster", init_data.name);

Should we use the #defines here for display_cluster?

> +	if (ret)
> +		return ret;
>  
>  	led->enable_gpio = devm_gpiod_get_optional(&client->dev,
>  						   "enable", GPIOD_OUT_LOW);
> @@ -420,7 +420,6 @@ static int lp8860_probe(struct i2c_client *client,
>  		led->regulator = NULL;
>  
>  	led->client = client;
> -	led->led_dev.name = led->label;
>  	led->led_dev.brightness_set_blocking = lp8860_brightness_set;
>  
>  	mutex_init(&led->lock);
> @@ -447,7 +446,8 @@ static int lp8860_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_led_classdev_register(&client->dev, &led->led_dev);
> +	ret = devm_led_classdev_register_ext(&client->dev, &led->led_dev,
> +					     &init_data);
>  	if (ret) {
>  		dev_err(&client->dev, "led register err: %d\n", ret);
>  		return ret;
> 


-- 
------------------
Dan Murphy
