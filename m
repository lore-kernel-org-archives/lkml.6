Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D19C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE4F21A17
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE4F21A17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbeGEJao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:30:44 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:58970 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeGEJam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:30:42 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 32BF741F98; Thu,  5 Jul 2018 11:30:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 2A29D41F62;
        Thu,  5 Jul 2018 11:30:37 +0200 (CEST)
Date:   Thu, 5 Jul 2018 11:30:37 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
X-X-Sender: nv@fox.voss.local
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     "Voss, Dr. Nikolaus" <Nikolaus.Dr.Voss@loewensteinmedical.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] IIO: st_accel_i2c.c: Simplify access to driver
 data
In-Reply-To: <CAHp75VfJOhX3+eL-ppvT7SPfDE_S7ht1drjobvFqmXPYApMETg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807051129060.21087@fox.voss.local>
References: <cover.1530710826.git.nikolaus.voss@loewensteinmedical.de> <e8cb86f843d6b524b671f8fd79fece02475a61c0.1530710826.git.nikolaus.voss@loewensteinmedical.de> <CAHp75VfJOhX3+eL-ppvT7SPfDE_S7ht1drjobvFqmXPYApMETg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Andy Shevchenko wrote:
> On Tue, Jul 3, 2018 at 8:41 AM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>> Use device_get_match_data API to simplify access to driver data.
>> Let acpi_device_id table entries point to the same driver data as
>> of_device_id table entries and uniquify access to driver data by using
>> device_get_match_data API. Remove unused i2c_device_id .driver_data
>> fields.
>>
>
> Couple of comments below, otherwise
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>> ---
>>  drivers/iio/accel/st_accel_i2c.c | 56 ++++++++++++++------------------
>>  1 file changed, 24 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
>> index 6bdec8c451e0..c6e08c834f11 100644
>> --- a/drivers/iio/accel/st_accel_i2c.c
>> +++ b/drivers/iio/accel/st_accel_i2c.c
>> @@ -14,8 +14,8 @@
>>  #include <linux/acpi.h>
>>  #include <linux/i2c.h>
>>  #include <linux/iio/iio.h>
>> +#include <linux/property.h>
>>
>> -#include <linux/iio/common/st_sensors.h>
>>  #include <linux/iio/common/st_sensors_i2c.h>
>>  #include "st_accel.h"
>>
>> @@ -107,7 +107,7 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
>>
>>  #ifdef CONFIG_ACPI
>>  static const struct acpi_device_id st_accel_acpi_match[] = {
>> -       {"SMO8A90", LNG2DM},
>> +       {"SMO8A90", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
>>         { },
>
> Is it done against iio-next?
>
> I see two records in this table.

No, I'll rebase onto linux-next and resend...

Niko

...

