Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C90ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5F220825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5F220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeKIDno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:43:44 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36294 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbeKIDnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:43:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8I6mBD008017;
        Thu, 8 Nov 2018 12:06:48 -0600
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8I6mMB117268
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 12:06:48 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 12:06:48 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 12:06:48 -0600
Received: from [172.22.151.38] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8I6lP1030927;
        Thu, 8 Nov 2018 12:06:47 -0600
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <84dd8750-883e-1318-df85-f4c6b46b898f@ti.com>
Date:   Thu, 8 Nov 2018 12:06:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2018 04:07 PM, Jacek Anaszewski wrote:
> Add public led_compose_name() API for composing LED class device
> name basing on fwnode_handle data. The function composes device name
> according to either a new <color:function> pattern or the legacy
> <devicename:color:function> pattern. The decision on using the
> particular pattern is made basing on whether fwnode contains new
> "function" and "color" properties, or the legacy "label" proeprty.
> 
> Backwards compatibility with in-driver hard-coded LED class device
> names is assured thanks to the default_desc argument.
> 
> In case none of the aformentioned properties was found, then, for OF
> nodes, the node name is adopted for LED class device name.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> ---
>  Documentation/leds/leds-class.txt |  2 +-
>  drivers/leds/led-core.c           | 71 +++++++++++++++++++++++++++++++++++++++
>  include/linux/leds.h              | 32 ++++++++++++++++++
>  3 files changed, 104 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/leds-class.txt
> index 836cb16..e9009c4 100644
> --- a/Documentation/leds/leds-class.txt
> +++ b/Documentation/leds/leds-class.txt
> @@ -43,7 +43,7 @@ LED Device Naming
>  
>  Is currently of the form:
>  
> -"devicename:colour:function"
> +"colour:function"
>  
>  There have been calls for LED properties such as colour to be exported as
>  individual led class attributes. As a solution which doesn't incur as much
> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
> index ede4fa0..f7371fc 100644
> --- a/drivers/leds/led-core.c
> +++ b/drivers/leds/led-core.c
> @@ -16,6 +16,8 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
>  #include <linux/rwsem.h>
>  #include "leds.h"
>  
> @@ -327,3 +329,72 @@ void led_sysfs_enable(struct led_classdev *led_cdev)
>  	led_cdev->flags &= ~LED_SYSFS_DISABLE;
>  }
>  EXPORT_SYMBOL_GPL(led_sysfs_enable);
> +
> +static void led_parse_properties(struct fwnode_handle *fwnode,
> +				 struct led_properties *props)
> +{
> +	int ret;
> +
> +	if (!fwnode)
> +		return;
> +
> +	ret = fwnode_property_read_string(fwnode, "label", &props->label);

If we have the label do we need to continue to look for the function and color nodes?

It can be checked and diverted using fwnode_property_present for the "label" property


> +	if (!ret)
> +		return;
> +
> +	ret = fwnode_property_read_string(fwnode, "function", &props->function);
> +	if (ret)
> +		pr_info("Failed to parse function property\n");
> +
> +	ret = fwnode_property_read_string(fwnode, "color", &props->color);
> +	if (ret)
> +		pr_info("Failed to parse color property\n");
> +}
> +
> +int led_compose_name(struct fwnode_handle *fwnode, const char *led_hw_name,
> +		     const char *default_desc, char *led_classdev_name)
> +{
> +	struct led_properties props = {};
> +
> +	if (!led_classdev_name)
> +		return -EINVAL;
> +
> +	led_parse_properties(fwnode, &props);
> +
> +	if (props.label) {
> +		/*
> +		 * Presence of 'label' DT property implies legacy LED name,
> +		 * formatted as <devicename:color:function>, with possible
> +		 * section omission if doesn't apply to given device.
> +		 *
> +		 * If no led_hw_name has been passed, then it indicates that
> +		 * DT label should be used as-is for LED class device name.
> +		 * Otherwise the label is prepended with led_hw_name to compose
> +		 * the final LED class device name.
> +		 */
> +		if (!led_hw_name) {
> +			strncpy(led_classdev_name, props.label,
> +				LED_MAX_NAME_SIZE);
> +		} else {
> +			snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
> +				 led_hw_name, props.label);
> +		}
> +	} else if (props.function || props.color) {
> +		snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
> +			 props.color ?: "", props.function ?: "");
> +	} else if (default_desc) {
> +		if (!led_hw_name) {
> +			pr_err("Legacy LED naming requires devicename segment");
> +			return -EINVAL;
> +		}
> +		snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
> +			 led_hw_name, default_desc);
> +	} else if (is_of_node(fwnode)) {
> +		strncpy(led_classdev_name, to_of_node(fwnode)->name,
> +			LED_MAX_NAME_SIZE);
> +	} else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(led_compose_name);
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 646c49a..ddb4001 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -238,6 +238,32 @@ extern void led_sysfs_disable(struct led_classdev *led_cdev);
>  extern void led_sysfs_enable(struct led_classdev *led_cdev);
>  
>  /**
> + * led_compose_name - compose LED class device name
> + * @child: child fwnode_handle describing a LED,
> + *	   or a group of synchronized LEDs.
> + * @led_hw_name: name of the LED controller, used when falling back to legacy
> + *		 LED naming; it should be set to NULL in new LED class drivers
> + * @default_desc: default <color:function> tuple, for backwards compatibility
> + *		  with in-driver hard-coded LED names used as a fallback when
> + *		  "label" DT property was absent; it should be set to NULL
> + *		  in new LED class drivers
> + * @led_classdev_name: composed LED class device name
> + *
> + * Create LED class device name basing on the configuration provided by the
> + * board firmware. The name can have a legacy form <devicename:color:function>,
> + * or a new form <color:function>. The latter is chosen if at least one of
> + * "color" or "function" properties is present in the fwnode, leaving the
> + * section blank if the related property is absent. The former is applied
> + * when legacy "label" property is present in the fwnode. In case none of the
> + * aformentioned properties was found, then, for OF nodes, the node name

s/aforementioned

> + * is adopted for LED class device name.
> + *
> + * Returns: 0 on success or negative error value on failure
> + */
> +extern int led_compose_name(struct fwnode_handle *child, const char *led_hw_name,
> +			    const char *default_desc, char *led_classdev_name);
> +
> +/**
>   * led_sysfs_is_disabled - check if LED sysfs interface is disabled
>   * @led_cdev: the LED to query
>   *
> @@ -414,6 +440,12 @@ struct led_platform_data {
>  	struct led_info	*leds;
>  };
>  
> +struct led_properties {
> +	const char *color;
> +	const char *function;
> +	const char *label;
> +};
> +
>  struct gpio_desc;
>  typedef int (*gpio_blink_set_t)(struct gpio_desc *desc, int state,
>  				unsigned long *delay_on,
> 


-- 
------------------
Dan Murphy
