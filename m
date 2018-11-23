Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE50C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DB820659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DB820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503358AbeKWVVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:21:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58882 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390259AbeKWVVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:21:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2108C27DBCD
Subject: Re: [PATCH 6/7] mfd / platform: cros_ec: instantiate only if th EC
 has a VBC NVRAM.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     lee.jones@linaro.org, gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
References: <20181122113356.23610-1-enric.balletbo@collabora.com>
 <20181122113356.23610-7-enric.balletbo@collabora.com>
 <20181122191401.GA2106@roeck-us.net>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <54b2aa27-2dba-7eba-d414-c7406e80a8c9@collabora.com>
Date:   Fri, 23 Nov 2018 11:37:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181122191401.GA2106@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 22/11/18 20:14, Guenter Roeck wrote:
> On Thu, Nov 22, 2018 at 12:33:55PM +0100, Enric Balletbo i Serra wrote:
>> The cros-ec-vbc driver is DT-only and there is a DT property that
>> indicates if the EC has the VCB NVRAM, in such case instantiate the
>> driver but don't instantiate on the other cases.
>>
>> To do this move the check code to its parent instead of play with the
>> attribute group visibility. This changes a bit the actual behaviour.
>> Before the patch if an EC doesn't have a VBC NVRAM an empty vbc folder
>> is created in /sys/class/chromeos/<ec device>, after the patch the empty
>> folder is not created, so, the folder is only created if the vbc is set.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  drivers/mfd/cros_ec_dev.c             | 24 +++++++++++++++++++++++-
>>  drivers/platform/chrome/cros_ec_vbc.c | 16 ----------------
>>  2 files changed, 23 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
>> index fc235af6da65..a63588953760 100644
>> --- a/drivers/mfd/cros_ec_dev.c
>> +++ b/drivers/mfd/cros_ec_dev.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/mfd/core.h>
>>  #include <linux/module.h>
>>  #include <linux/mod_devicetable.h>
>> +#include <linux/of_platform.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm.h>
>>  #include <linux/slab.h>
>> @@ -400,7 +401,10 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
>>  	{ .name = "cros-ec-debugfs" },
>>  	{ .name = "cros-ec-lightbar" },
>>  	{ .name = "cros-ec-sysfs" },
>> -	{ .name = "cros-ec-vbc" },
>> +};
>> +
>> +static const struct mfd_cell cros_ec_vbc_cells[] = {
>> +	{ .name = "cros-ec-vbc" }
>>  };
>>  
>>  static int ec_device_probe(struct platform_device *pdev)
>> @@ -409,6 +413,7 @@ static int ec_device_probe(struct platform_device *pdev)
>>  	struct device *dev = &pdev->dev;
>>  	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
>>  	struct cros_ec_dev *ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
>> +	struct device_node *node;
>>  
>>  	if (!ec)
>>  		return retval;
>> @@ -492,6 +497,23 @@ static int ec_device_probe(struct platform_device *pdev)
>>  		dev_err(ec->dev,
>>  			"failed to add cros-ec platform devices: %d\n", retval);
>>  
>> +	/* Check whether this EC instance has a VBC NVRAM */
>> +	node = ec->ec_dev->dev->of_node;
>> +	if (IS_ENABLED(CONFIG_OF) && node) {
> 
> Is IS_ENABLED() necessary here ? Seems to me node should always be NULL
> in this case.
> 
>> +		if (of_property_read_bool(node, "google,has-vbc-nvram")) {
>> +			dev_err(dev, "device VBC found.\n");
> 
> dev_err ?
> 

Ups, I added this message only for debugging puposes, I think doesn't make sense
here so I'll remove.

>> +			retval = devm_mfd_add_devices(ec->dev,
>> +					PLATFORM_DEVID_AUTO,
>> +					cros_ec_vbc_cells,
>> +					ARRAY_SIZE(cros_ec_vbc_cells),
>> +					NULL, 0, NULL);
>> +			if (retval)
>> +				dev_err(ec->dev,
>> +					"failed to add VBC devices: %d\n",
>> +					retval);
> 
> Since the error is ignored, maybe better dev_warn() ?
> 

Done in next version.

>> +		}
>> +	}
>> +
>>  	return 0;
>>  
>>  failed:
>> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
>> index 374153e3dc13..b7b81fe0fb25 100644
>> --- a/drivers/platform/chrome/cros_ec_vbc.c
>> +++ b/drivers/platform/chrome/cros_ec_vbc.c
>> @@ -108,21 +108,6 @@ static ssize_t vboot_context_write(struct file *filp, struct kobject *kobj,
>>  	return data_sz;
>>  }
>>  
>> -static umode_t cros_ec_vbc_is_visible(struct kobject *kobj,
>> -				      struct bin_attribute *a, int n)
>> -{
>> -	struct device *dev = container_of(kobj, struct device, kobj);
>> -	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>> -	struct device_node *np = ec->ec_dev->dev->of_node;
>> -
>> -	if (IS_ENABLED(CONFIG_OF) && np) {
>> -		if (of_property_read_bool(np, "google,has-vbc-nvram"))
>> -			return a->attr.mode;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>  static BIN_ATTR_RW(vboot_context, 16);
>>  
>>  static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
>> @@ -133,7 +118,6 @@ static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
>>  struct attribute_group cros_ec_vbc_attr_group = {
>>  	.name = "vbc",
>>  	.bin_attrs = cros_ec_vbc_bin_attrs,
>> -	.is_bin_visible = cros_ec_vbc_is_visible,
>>  };
>>  
>>  static int cros_ec_vbc_probe(struct platform_device *pd)
