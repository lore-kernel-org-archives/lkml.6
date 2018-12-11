Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672F8C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E87D20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E87D20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeLKLSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:18:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46954 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeLKLSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:18:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 02A52263BCE
Subject: Re: [PATCH v3 7/8] platform/chrome: cros_ec_lightbar: instantiate
 only if the EC has a lightbar.
To:     Guenter Roeck <groeck@google.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-8-enric.balletbo@collabora.com>
 <CABXOdTfagM6sRWYMNs3cEwtjvOe8LVvmZ6=0LfBueT7JJzw-MQ@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <be4b375e-32dd-4b62-f04b-e66c2f6092db@collabora.com>
Date:   Tue, 11 Dec 2018 12:18:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CABXOdTfagM6sRWYMNs3cEwtjvOe8LVvmZ6=0LfBueT7JJzw-MQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/18 19:20, Guenter Roeck wrote:
> On Tue, Nov 27, 2018 at 4:19 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
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
> Nitpicks, otherwise
> 
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> 
>> ---
>>
>> Changes in v3: None
>> Changes in v2:
>> - Removed ec_with_lightbar variable.
>>
>>  drivers/platform/chrome/cros_ec_lightbar.c | 37 ++++++++--------------
>>  1 file changed, 13 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
>> index 80eed6317570..6f6a4cbfc3fc 100644
>> --- a/drivers/platform/chrome/cros_ec_lightbar.c
>> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
>> @@ -43,7 +43,6 @@ static unsigned long lb_interval_jiffies = 50 * HZ / 1000;
>>   * If this is true, we won't do anything during suspend/resume.
>>   */
>>  static bool userspace_control;
>> -static struct cros_ec_dev *ec_with_lightbar;
>>
>>  static ssize_t interval_msec_show(struct device *dev,
>>                                   struct device_attribute *attr, char *buf)
>> @@ -381,9 +380,6 @@ static int lb_manual_suspend_ctrl(struct cros_ec_dev *ec, uint8_t enable)
>>         struct cros_ec_command *msg;
>>         int ret;
>>
>> -       if (ec != ec_with_lightbar)
>> -               return 0;
>> -
>>         msg = alloc_lightbar_cmd_msg(ec);
>>         if (!msg)
>>                 return -ENOMEM;
>> @@ -567,37 +563,26 @@ static struct attribute *__lb_cmds_attrs[] = {
>>         NULL,
>>  };
>>
>> -static bool ec_has_lightbar(struct cros_ec_dev *ec)
>> +static bool cros_ec_has_lightbar(struct cros_ec_dev *ec_dev)
>>  {
>> -       return !!get_lightbar_version(ec, NULL, NULL);
>> -}
>> -
>> -static umode_t cros_ec_lightbar_attrs_are_visible(struct kobject *kobj,
>> -                                                 struct attribute *a, int n)
>> -{
>> -       struct device *dev = container_of(kobj, struct device, kobj);
>> -       struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>> -       struct platform_device *pdev = to_platform_device(ec->dev);
>> +       struct platform_device *pdev = to_platform_device(ec_dev->dev);
>>         struct cros_ec_platform *pdata = pdev->dev.platform_data;
>>         int is_cros_ec;
>>
>>         is_cros_ec = strcmp(pdata->ec_name, CROS_EC_DEV_NAME);
>>
>>         if (is_cros_ec != 0)
>> -               return 0;
>> +               return false;
>>
> FWIW, is_cros_ec is really unnecessary here, though I guess that might
> be a different patch.
> 
>> -       /* Only instantiate this stuff if the EC has a lightbar */
>> -       if (ec_has_lightbar(ec)) {
>> -               ec_with_lightbar = ec;
>> -               return a->mode;
>> -       }
>> -       return 0;
>> +       if (!!get_lightbar_version(ec_dev, NULL, NULL))
>> +               return true;
>> +
>> +       return false;
> 
> Why not just the following ?
>             return !!get_lightbar_version(ec_dev, NULL, NULL);
> or even
>             return !strcmp(pdata->ec_name, CROS_EC_DEV_NAME) &&
>                       !!get_lightbar_version(ec_dev, NULL, NULL);
> 

Ack, I think that we can get rid of the cros_ec_has_lightbar function then. I'll
do in next version.

Thanks,
 Enric

>>  }
>>
>>  struct attribute_group cros_ec_lightbar_attr_group = {
>>         .name = "lightbar",
>>         .attrs = __lb_cmds_attrs,
>> -       .is_visible = cros_ec_lightbar_attrs_are_visible,
>>  };
>>
>>  static int cros_ec_lightbar_probe(struct platform_device *pd)
>> @@ -606,6 +591,10 @@ static int cros_ec_lightbar_probe(struct platform_device *pd)
>>         struct device *dev = &pd->dev;
>>         int ret;
>>
>> +       /* Only instantiate this stuff if the EC has a lightbar */
>> +       if (!cros_ec_has_lightbar(ec_dev))
>> +               return -ENODEV;
>> +
>>         /* Take control of the lightbar from the EC. */
>>         lb_manual_suspend_ctrl(ec_dev, 1);
>>
>> @@ -635,7 +624,7 @@ static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
>>  {
>>         struct cros_ec_dev *ec_dev = dev_get_drvdata(dev);
>>
>> -       if (userspace_control || ec_dev != ec_with_lightbar)
>> +       if (userspace_control)
>>                 return 0;
>>
>>         return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_RESUME);
>> @@ -645,7 +634,7 @@ static int __maybe_unused cros_ec_lightbar_suspend(struct device *dev)
>>  {
>>         struct cros_ec_dev *ec_dev = dev_get_drvdata(dev);
>>
>> -       if (userspace_control || ec_dev != ec_with_lightbar)
>> +       if (userspace_control)
>>                 return 0;
>>
>>         return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_SUSPEND);
>> --
>> 2.19.1
>>
