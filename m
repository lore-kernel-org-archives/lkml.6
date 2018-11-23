Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5147C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8AE20659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8AE20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390684AbeKWVyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:54:10 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59578 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387941AbeKWVyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:54:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0D97C26059E
Subject: Re: [PATCH 7/7] platform/chrome: cros_ec_lightbar: instantiate only
 if the EC has a lightbar.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     lee.jones@linaro.org, gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
References: <20181122113356.23610-1-enric.balletbo@collabora.com>
 <20181122113356.23610-8-enric.balletbo@collabora.com>
 <20181122192544.GA2410@roeck-us.net>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5b06a19f-693f-ca9d-cb6f-06d0c3d938d9@collabora.com>
Date:   Fri, 23 Nov 2018 12:10:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181122192544.GA2410@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 22/11/18 20:25, Guenter Roeck wrote:
> On Thu, Nov 22, 2018 at 12:33:56PM +0100, Enric Balletbo i Serra wrote:
>> Due to the way attribute groups visibility work, the function
>> cros_ec_lightbar_attrs_are_visible is called multiple times, once per
>> attribute, and each of these calls makes an EC transaction. For what is
>> worth the EC log reports multiple errors on boot when the lightbar is
>> not available. Instead, check if the EC has a lightbar in the probe
>> function and only instantiate the device.
>>
>> Ideally we should have instantiate the driver only if the
>> EC_FEATURE_LIGHTBAR is defined, but that's not possible because that flag
>> is not in the very first Pixel Chromebook (Link), only on Samus. So, the
>> driver is instantiated by his parent always.
>>
>> This patch changes a bit the actual behaviour. Before the patch if an EC
>> doesn't have a lightbar an empty lightbar folder is created in
>> /sys/class/chromeos/<ec device>, after the patch the empty folder is not
>> created, so, the folder is only created if the lightbar exists.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Guess this is the answer to the suggestion I had before. Maybe the two patches
> should be merged together ? Or do  others think that they should be kept
> separate ?
> 

I did in a separate patch because it changes a bit the current behaviour (i.e
after that patch the lightbar directory will not appear if is not detected).
Having in a separate patch will allow us to revert cleanly if for some weird
reason we still want the old behaviour. So in general, first I moved the
attributes and then I did a follow up patch with the probe change. This also
happens with vbc driver.

Said that, I don't mind to merge the two patches.


> Additional comment below.
> 
> Thanks,
> Guenter
> 
>> ---
>>
>>  drivers/platform/chrome/cros_ec_lightbar.c | 29 +++++++++-------------
>>  1 file changed, 12 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
>> index 31d22f594fac..d255264eb082 100644
>> --- a/drivers/platform/chrome/cros_ec_lightbar.c
>> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
>> @@ -567,37 +567,28 @@ static struct attribute *__lb_cmds_attrs[] = {
>>  	NULL,
>>  };
>>  
>> -static bool ec_has_lightbar(struct cros_ec_dev *ec)
>> +static bool cros_ec_has_lightbar(struct cros_ec_dev *ec_dev)
>>  {
>> -	return !!get_lightbar_version(ec, NULL, NULL);
>> -}
>> -
>> -static umode_t cros_ec_lightbar_attrs_are_visible(struct kobject *kobj,
>> -						  struct attribute *a, int n)
>> -{
>> -	struct device *dev = container_of(kobj, struct device, kobj);
>> -	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>> -	struct platform_device *pdev = to_platform_device(ec->dev);
>> +	struct platform_device *pdev = to_platform_device(ec_dev->dev);
>>  	struct cros_ec_platform *pdata = pdev->dev.platform_data;
>>  	int is_cros_ec;
>>  
>>  	is_cros_ec = strcmp(pdata->ec_name, CROS_EC_DEV_NAME);
>>  
> Can this now ever be false ?
> 

Yes, this happens for example on Samus, where there are two ECs, the first one
is named "cros_ec" and the second one is "cros_pd", so will fail in the second
case. Gwendal, correct me if I am wrong, but AFAIK this is a bit of hack because
some initial versions of Samus (coded Link I guess) have no support for the
EC_LIGHTBAR_FEATURE so we can't really use the features thing.

>>  	if (is_cros_ec != 0)
>> -		return 0;
>> +		return false;
>>  
>> -	/* Only instantiate this stuff if the EC has a lightbar */
>> -	if (ec_has_lightbar(ec)) {
>> -		ec_with_lightbar = ec;
>> -		return a->mode;
>> +	if (!!get_lightbar_version(ec_dev, NULL, NULL)) {
>> +		ec_with_lightbar = ec_dev;
> 
> Is this variable (and the associated check in lb_manual_suspend_ctrl)
> still necessary ?
> 

Hmm, right, I will double check and remove in next version.

>> +		return true;
>>  	}
>> -	return 0;
>> +
>> +	return false;
>>  }
>>  
>>  struct attribute_group cros_ec_lightbar_attr_group = {
>>  	.name = "lightbar",
>>  	.attrs = __lb_cmds_attrs,
>> -	.is_visible = cros_ec_lightbar_attrs_are_visible,
>>  };
>>  
>>  static int cros_ec_lightbar_probe(struct platform_device *pd)
>> @@ -611,6 +602,10 @@ static int cros_ec_lightbar_probe(struct platform_device *pd)
>>  		return -EINVAL;
>>  	}
>>  
>> +	/* Only instantiate this stuff if the EC has a lightbar */
>> +	if (!cros_ec_has_lightbar(ec_dev))
>> +		return -ENODEV;
>> +
>>  	/* Take control of the lightbar from the EC. */
>>  	lb_manual_suspend_ctrl(ec_dev, 1);
>>  
> 
