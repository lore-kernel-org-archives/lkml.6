Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5659DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE982086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE982086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeKXUeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 15:34:22 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:44136 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeKXUeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 15:34:22 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from sneezy.aussec.com (sneezy.aussec.com [172.16.0.4])
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTP id wAO9k5is006959;
        Sat, 24 Nov 2018 20:46:11 +1100
Received: from c110-21-61-29.farfl4.nsw.optusnet.com.au
 (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29]) by www.aussec.com
 (Horde Framework) with HTTP; Sat, 24 Nov 2018 20:46:00 +1100
Message-ID: <20181124204600.176178e9k4t04sm0@www.aussec.com>
Date:   Sat, 24 Nov 2018 20:46:00 +1100
From:   tom burkart <tom@aussec.com>
To:     Philipp Zabel <philipp.zabel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/4] pps: descriptor-based gpio, capture-clear
 addition
References: <20181117130337.5856-1-tom@aussec.com>
 <20181117130337.5856-2-tom@aussec.com>
 <20181117130337.5856-3-tom@aussec.com>
 <CA+gwMcfQ5cUZPmAJ6Uhb0KQsmwjtoSdRJVnAzk9mwy=-M19M2Q@mail.gmail.com>
In-Reply-To:  <CA+gwMcfQ5cUZPmAJ6Uhb0KQsmwjtoSdRJVnAzk9mwy=-M19M2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.3.9)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Quoting Philipp Zabel <philipp.zabel@gmail.com>:

> On Sat, Nov 17, 2018 at 2:07 PM Tom Burkart <tom@aussec.com> wrote:
>>
>> This patch changes the GPIO access for the pps-gpio driver from the
>> integer based ABI to the descriptor based ABI.  It also adds the
>> extraction of the device tree capture-clear option.
>
> Is the capture-clear property documented in
> Documentation/devicetree/bindings/pps/pps-gpio.txt?
> If not, you should add a binding documentation patch.

Yes, that is in patch 1/4

>> Signed-off-by: Tom Burkart <tom@aussec.com>
>> ---
>>  drivers/pps/clients/pps-gpio.c | 80  
>> +++++++++++++++++++++---------------------
>>  include/linux/pps-gpio.h       |  3 +-
>>  2 files changed, 41 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
>> index 333ad7d5b45b..d2fbc91dc8fc 100644
>> --- a/drivers/pps/clients/pps-gpio.c
>> +++ b/drivers/pps/clients/pps-gpio.c
>> @@ -31,7 +31,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/pps_kernel.h>
>>  #include <linux/pps-gpio.h>
>> -#include <linux/gpio.h>
>> +#include <linux/gpio/consumer.h>
>>  #include <linux/list.h>
>>  #include <linux/of_device.h>
>>  #include <linux/of_gpio.h>
>> @@ -41,9 +41,9 @@ struct pps_gpio_device_data {
>>         int irq;                        /* IRQ used as PPS source */
>>         struct pps_device *pps;         /* PPS source device */
>>         struct pps_source_info info;    /* PPS source information */
>> +       struct gpio_desc *gpio_pin;     /* GPIO port descriptors */
>>         bool assert_falling_edge;
>>         bool capture_clear;
>> -       unsigned int gpio_pin;
>>  };
>>
>>  /*
>> @@ -61,18 +61,49 @@ static irqreturn_t pps_gpio_irq_handler(int  
>> irq, void *data)
>>
>>         info = data;
>>
>> -       rising_edge = gpio_get_value(info->gpio_pin);
>> +       rising_edge = gpiod_get_value(info->gpio_pin);
>>         if ((rising_edge && !info->assert_falling_edge) ||
>>                         (!rising_edge && info->assert_falling_edge))
>>                 pps_event(info->pps, &ts, PPS_CAPTUREASSERT, NULL);
>>         else if (info->capture_clear &&
>>                         ((rising_edge && info->assert_falling_edge) ||
>> -                        (!rising_edge && !info->assert_falling_edge)))
>> +                       (!rising_edge && !info->assert_falling_edge)))
>>                 pps_event(info->pps, &ts, PPS_CAPTURECLEAR, NULL);
>>
>>         return IRQ_HANDLED;
>>  }
>>
>> +static int pps_gpio_setup(struct platform_device *pdev)
>> +{
>> +       struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
>> +       const struct pps_gpio_platform_data *pdata =  
>> pdev->dev.platform_data;
>> +       struct device_node *np = pdev->dev.of_node;
>> +       int ret;
>
> Unused variable?

Oops, yes, in this patch (2/4), but not in patch 4/4

>> +
>> +       if (pdata) {
>> +               data->gpio_pin = pdata->gpio_pin;
>> +
>> +               data->assert_falling_edge = pdata->assert_falling_edge;
>> +               data->capture_clear = pdata->capture_clear;
>
> This is just a matter of personal taste, so feel free to ignore:
> I would keep the pdata branch in pps_gpio_probe and call this function
> pps_gpio_dt_setup, to reduce indentation of the OF branch.

Ok, I am happy to agree as it makes sense.

>> +       } else {
>> +               data->gpio_pin = devm_gpiod_get(&pdev->dev,
>> +                       NULL,   /* request "gpios" */
>> +                       GPIOD_IN);
>> +               if (IS_ERR(data->gpio_pin)) {
>> +                       dev_err(&pdev->dev,
>> +                               "failed to request PPS GPIO\n");
>> +                       return PTR_ERR(data->gpio_pin);
>> +               }
>> +
>> +               if (of_get_property(np, "assert-falling-edge", NULL))
>> +                       data->assert_falling_edge = true;
>> +
>> +               if (of_get_property(np, "capture-clear", NULL))
>> +                       data->capture_clear = true;
>
> Those two should use the of_property_read_bool wrapper.

Thanks.

>> +       }
>> +       return 0;
>> +}
>> +
>>  static unsigned long
>>  get_irqf_trigger_flags(const struct pps_gpio_device_data *data)
>>  {
>> @@ -90,53 +121,23 @@ get_irqf_trigger_flags(const struct  
>> pps_gpio_device_data *data)
>>  static int pps_gpio_probe(struct platform_device *pdev)
>>  {
>>         struct pps_gpio_device_data *data;
>> -       const char *gpio_label;
>>         int ret;
>>         int pps_default_params;
>> -       const struct pps_gpio_platform_data *pdata =  
>> pdev->dev.platform_data;
>> -       struct device_node *np = pdev->dev.of_node;
>>
>>         /* allocate space for device info */
>>         data = devm_kzalloc(&pdev->dev, sizeof(struct pps_gpio_device_data),
>
> Could use sizeof(*data) here. Otherwise,

Fine with me.

> Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>

Is this for patch 2/4 only or the others as well?

Will generate v10 of the patch and post it again.


