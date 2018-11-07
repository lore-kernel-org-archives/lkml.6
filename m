Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46210C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD53D2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD53D2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeKHFJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:09:41 -0500
Received: from mail.bugwerft.de ([46.23.86.59]:55032 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbeKHFJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:09:41 -0500
Received: from [192.168.178.170] (pD95EFA86.dip0.t-ipconnect.de [217.94.250.134])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 3701E2A75B8;
        Wed,  7 Nov 2018 19:35:32 +0000 (UTC)
Subject: Re: [PATCH 08/24] leds: lt3593: Use led_compose_name()
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-9-git-send-email-jacek.anaszewski@gmail.com>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <42d68eae-6905-e787-3797-f0f16b0dfb84@zonque.org>
Date:   Wed, 7 Nov 2018 20:37:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541542052-10081-9-git-send-email-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/2018 11:07 PM, Jacek Anaszewski wrote:
> Switch to using generic LED support for composing LED class
> device name.

Thanks for the rework!

> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> ---
>   drivers/leds/leds-lt3593.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/leds/leds-lt3593.c b/drivers/leds/leds-lt3593.c
> index de3623e..d005abc 100644
> --- a/drivers/leds/leds-lt3593.c
> +++ b/drivers/leds/leds-lt3593.c
> @@ -10,10 +10,10 @@
>   #include <linux/slab.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> -#include <uapi/linux/uleds.h>
> +
> +#define LED_LT3593_NAME "lt3593"
>   
>   struct lt3593_led_data {
> -	char name[LED_MAX_NAME_SIZE];
>   	struct led_classdev cdev;
>   	struct gpio_desc *gpiod;
>   };
> @@ -111,6 +111,7 @@ static int lt3593_led_probe(struct platform_device *pdev)
>   	struct fwnode_handle *child;
>   	int ret, state = LEDS_GPIO_DEFSTATE_OFF;
>   	enum gpiod_flags flags = GPIOD_OUT_LOW;
> +	struct led_init_data init_data;
>   	const char *tmp;
>   
>   	if (dev_get_platdata(dev)) {
> @@ -138,14 +139,11 @@ static int lt3593_led_probe(struct platform_device *pdev)
>   		return PTR_ERR(led_data->gpiod);
>   
>   	child = device_get_next_child_node(dev, NULL);
> +	init_data.fwnode = child;

Not quite following. `fwnode' is the only member of that struct that is 
initialized?

>   
> -	ret = fwnode_property_read_string(child, "label", &tmp);
> -	if (ret < 0)
> -		snprintf(led_data->name, sizeof(led_data->name),
> -			 "lt3593::");
> -	else
> -		snprintf(led_data->name, sizeof(led_data->name),
> -			 "lt3593:%s", tmp);
> +	ret = led_compose_name(child, LED_LT3593_NAME, ":", init_data.name);

... and here, a member that wasn't written before is used? What am I 
missing?


Thanks,
Daniel
