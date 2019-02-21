Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6BCC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25792086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfBUIDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:03:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51248 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUIDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:03:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C8D3027D486
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Refactor code in
 cros_ec_accel_legacy_probe
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
References: <20190221020633.GA4195@embeddedor>
 <CAGXu5jK1fKaSSfHP1dGFyKVjRM7APvqdOhHNjZnN=+An950J1A@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <946ab58e-ad7e-4815-4dd3-42aeaa3f4299@collabora.com>
Date:   Thu, 21 Feb 2019 09:03:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jK1fKaSSfHP1dGFyKVjRM7APvqdOhHNjZnN=+An950J1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/2/19 8:00, Kees Cook wrote:
> On Wed, Feb 20, 2019 at 6:06 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> Refactor some code in order to fix both the technical implementation
>> and the following warnings:
>>
>> drivers/iio/accel/cros_ec_accel_legacy.c: In function ‘cros_ec_accel_legacy_probe’:
>> drivers/iio/accel/cros_ec_accel_legacy.c:387:36: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>     ec_accel_channels[X].scan_index = Y;
>>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>> drivers/iio/accel/cros_ec_accel_legacy.c:388:3: note: here
>>    case Y:
>>    ^~~~
>> drivers/iio/accel/cros_ec_accel_legacy.c:389:36: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>     ec_accel_channels[Y].scan_index = X;
>>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>> drivers/iio/accel/cros_ec_accel_legacy.c:390:3: note: here
>>    case Z:
>>    ^~~~
>>
>> Notice that neither the for loop nor the switch statement is needed.
>> Also, "state->sign[Y] = 1" should be unconditional.
>>
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric

> -Kees
> 
>> ---
>>  drivers/iio/accel/cros_ec_accel_legacy.c | 27 +++++++++++-------------
>>  1 file changed, 12 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
>> index 063e89eff791..021f9f5cd3bb 100644
>> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
>> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
>> @@ -353,7 +353,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>>         struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
>>         struct iio_dev *indio_dev;
>>         struct cros_ec_accel_legacy_state *state;
>> -       int ret, i;
>> +       int ret;
>>
>>         if (!ec || !ec->ec_dev) {
>>                 dev_warn(&pdev->dev, "No EC device found.\n");
>> @@ -381,20 +381,17 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>>          * Present the channel using HTML5 standard:
>>          * need to invert X and Y and invert some lid axis.
>>          */
>> -       for (i = X ; i < MAX_AXIS; i++) {
>> -               switch (i) {
>> -               case X:
>> -                       ec_accel_channels[X].scan_index = Y;
>> -               case Y:
>> -                       ec_accel_channels[Y].scan_index = X;
>> -               case Z:
>> -                       ec_accel_channels[Z].scan_index = Z;
>> -               }
>> -               if (state->sensor_num == MOTIONSENSE_LOC_LID && i != Y)
>> -                       state->sign[i] = -1;
>> -               else
>> -                       state->sign[i] = 1;
>> -       }
>> +       ec_accel_channels[X].scan_index = Y;
>> +       ec_accel_channels[Y].scan_index = X;
>> +       ec_accel_channels[Z].scan_index = Z;
>> +
>> +       state->sign[Y] = 1;
>> +
>> +       if (state->sensor_num == MOTIONSENSE_LOC_LID)
>> +               state->sign[X] = state->sign[Z] = -1;
>> +       else
>> +               state->sign[X] = state->sign[Z] = 1;
>> +
>>         indio_dev->num_channels = ARRAY_SIZE(ec_accel_channels);
>>         indio_dev->dev.parent = &pdev->dev;
>>         indio_dev->info = &cros_ec_accel_legacy_info;
>> --
>> 2.20.1
>>
> 
> 
