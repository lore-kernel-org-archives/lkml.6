Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeEATmc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 15:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbeEATma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 15:42:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DF82370D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AB8JxZqE1uL+KbUSNDEQHCIlSpVKM6ol2dkLT+5TSWfbe9bMQXWihDgGVH3exoXSzG62Daz3k4ek+kU3mFuUgl2nkRQ=
MIME-Version: 1.0
In-Reply-To: <20180501184853.GB52077@dtor-ws>
References: <20180410095340.24074-1-javierm@redhat.com> <20180501184853.GB52077@dtor-ws>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 1 May 2018 14:42:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ-UTGrPm2tiS1yVFweWB_LH2JSBpOpMtogTYFi7pCsGA@mail.gmail.com>
Message-ID: <CAL_JsqJ-UTGrPm2tiS1yVFweWB_LH2JSBpOpMtogTYFi7pCsGA@mail.gmail.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - add missing compatible strings to
 OF device table
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-input@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nick Dyer <nick@shmanahar.org>, Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 1:48 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Apr 10, 2018 at 11:53:40AM +0200, Javier Martinez Canillas wrote:
>> Commit af503716ac14 ("i2c: core: report OF style module alias for devices
>> registered via OF") fixed how the I2C core reports the module alias when
>> devices are registered via OF.
>>
>> But the atmel_mxt_ts driver only has an "atmel,maxtouch" compatible in its
>> OF device ID table, so if a Device Tree is using a different one, autoload
>> won't be working for the module (the matching works because the I2C device
>> ID table is used as a fallback).
>>
>> So add compatible strings for each of the entries in the I2C device table.
>>
>> Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")
>> Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>  Documentation/devicetree/bindings/input/atmel,maxtouch.txt | 6 +++++-
>>  drivers/input/touchscreen/atmel_mxt_ts.c                   | 4 ++++
>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
>> index 23e3abc3fdef..cd43fb8bc2ce 100644
>> --- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
>> +++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
>> @@ -1,8 +1,12 @@
>>  Atmel maXTouch touchscreen/touchpad
>>
>>  Required properties:
>> -- compatible:
>> +- compatible: Must be one of the following
>> +    atmel,qt602240_ts
>> +    atmel,atmel_mxt_ts
>> +    atmel,atmel_mxt_tp
>>      atmel,maxtouch
>> +    atmel,mXT224
>
> I do not think we should document ad-hoc compatible strings that were
> introduced by various vendors as the documented ones, so I'd rather
> dropped this chunk and leave only "atmel,maxtouch" as compatible that
> everyone should be using.
>
> The changes to the driver to support the existing DTSes can of course be
> applied.
>
> Rob, any objections?

I'd prefer we list them in the binding as deprecated. Then we document
somewhere besides this thread to not use them.

And there are 3 dts changes needed as well:

$ git grep atmel,mXT224
$ git grep atmel,qt6
$ git grep atmel,atmel_mxt
arch/arm/boot/dts/at91-sama5d4ek.dts:
 compatible = "atmel,atmel_mxt_ts";
arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts:
compatible = "atmel,atmel_mxt_tp";
arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts:
compatible = "atmel,atmel_mxt_ts";

Rob
