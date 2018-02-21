Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeBUIfr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:35:47 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:38882 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbeBUIfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:35:45 -0500
X-Google-Smtp-Source: AG47ELv4zj6C7oPiVbELef2+JIhzWcV9VNr7hgh7kGsrVzsZnqIVYIHlAbxeYaIEt5PlcgjbzEdlDbkHtVtfgdBPxZY=
MIME-Version: 1.0
In-Reply-To: <CAGb2v64chOVqp3v9mXUQ13SF0E503e3L+N-zrV8EM2oprknWgw@mail.gmail.com>
References: <20180221081100.17662-1-maxime.ripard@bootlin.com>
 <CACRpkdYkT7TJrhyQoJr=ZK7w8+KY=_fgjrJeaZCsLHA_6WbZbg@mail.gmail.com> <CAGb2v64chOVqp3v9mXUQ13SF0E503e3L+N-zrV8EM2oprknWgw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2018 09:35:44 +0100
Message-ID: <CACRpkda1RQTS4uR0DNHKjJfceCirwEUanXWr_MEZqc7rJ19U2g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Keep returning EPROBE_DEFER when we should
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 9:19 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Wed, Feb 21, 2018 at 4:17 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Wed, Feb 21, 2018 at 9:11 AM, Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>>
>>> Commits c85823390215 ("gpio: of: Support SPI nonstandard GPIO properties")
>>> and 6a537d48461d ("gpio: of: Support regulator nonstandard GPIO
>>> properties") have introduced a regression in the way error codes from
>>> of_get_named_gpiod_flags are handled.
>>>
>>> Previously, those errors codes were returned immediately, but the two
>>> commits mentioned above are now overwriting the error pointer, meaning that
>>> whatever value has been returned will be dropped in favor of whatever the
>>> two new functions will return.
>>>
>>> This might not be a big deal except for EPROBE_DEFER, on which GPIOlib
>>> customers will depend on, and that will now be returned as an hard error
>>> which means that they will not probe anymore, instead of gently deferring
>>> their probe.
>>>
>>> Since EPROBE_DEFER basically means that we have found a valid property but
>>> there was no GPIO controller registered to handle it, fix this issues by
>>> returning it as soon as we encounter it.
>>>
>>> Fixes: c85823390215 ("gpio: of: Support SPI nonstandard GPIO properties")
>>> Fixes: 6a537d48461d ("gpio: of: Support regulator nonstandard GPIO properties")
>>> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>>
>> Whoops sorry for that, patch applied for fixes.
>
> Would this patch be any better?
>
> https://www.spinics.net/lists/linux-gpio/msg28160.html
>
> Not sure if of_find_spi_gpio() and of_find_regulator_gpio() return
> EPROBE_DEFER as well.

Ah sorry I missed the patch, too much patches in my Inbox
again, I wish I was better at this :/

I think Maxime's patch is nice since it clearly bails out of the
loop as soon as we get deferral.

But we want the second part of your patch as well. If
of_find_spi_gpio() returns -EPROBE_DEFER it should
return.

I will look into it.

Yours,
Linus Walleij
