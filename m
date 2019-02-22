Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E58AC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AA120645
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfBVKYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:24:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56116 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfBVKY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:24:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 23433263947
Subject: Re: [PATCH] iio: cros_ec: Fix gyro scale calculation
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@collabora.com,
        Hartmut Knaack <knaack.h@gmx.de>
References: <20190220150300.3302-1-enric.balletbo@collabora.com>
 <20190220160126.12568f92@archlinux>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <7d36153b-65e9-6702-e72f-caaeeb032077@collabora.com>
Date:   Fri, 22 Feb 2019 11:24:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190220160126.12568f92@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 20/2/19 17:01, Jonathan Cameron wrote:
> On Wed, 20 Feb 2019 16:03:00 +0100
> Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
> 
>> From: Gwendal Grignou <gwendal@chromium.org>
>>
>> Calculation was copied from IIO_DEGREE_TO_RAD, but offset added to avoid
>> rounding error is wrong. It should be only half of the divider.
>>
>> Fixes: c14dca07a31d ("iio: cros_ec_sensors: add ChromeOS EC Contiguous Sensors driver")
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> This one is kind of interesting. See below.
> 
>> ---
>>
>>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
>> index 89cb0066a6e0..600942af9f9c 100644
>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
>> @@ -103,7 +103,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
>>  			 * Do not use IIO_DEGREE_TO_RAD to avoid precision
>>  			 * loss. Round to the nearest integer.
>>  			 */
>> -			*val = div_s64(val64 * 314159 + 9000000ULL, 1000);
>> +			*val = div_s64(val64 * 314159 + 500ULL, 1000);
> That is only one of two divides going on.  Firstly we divide by 1000 here,
> then we provide it in fractional form which means that the actual value you get
> from sysfs etc is 
> val/val2.  It's this one we are protecting against rounding error on I guess.
> Now this is even less obviously because it's not 18000 either, but 
> 18000 * 2^CROS_EC_SENSOR_BITS.
> 
> Which ultimately means neither answer is correct. Hmm.
> Not totally sure what the right answer actually is..
> 

If I understood well the Gwendal's patch the problem that we're trying to solve
is that current calculation is not closer from the float calculation.

For 1000dps, the result should be:

    (1000 * pi ) / 180 >> 15 ~= 0.000532632218

But with current calculation we get

    $ cat scale
    0.000547890

With that patch (modifying the offset to avoid the rounding error) we get a
closer result

    $ cat scale
    0.000532631

So, what we're trying to do is have val/val2 closer to the real value. Makes
this sense to you or I'm missing something? I can improve the commit message if
it's not clear.

-- Enric

> Jonathan
> 
>>  			*val2 = 18000 << (CROS_EC_SENSOR_BITS - 1);
>>  			ret = IIO_VAL_FRACTIONAL;
>>  			break;
> 
