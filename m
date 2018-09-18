Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DB1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826312146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YdPnNX+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826312146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeISEPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:15:09 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:56134 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeISEPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:15:09 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so5657834itj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 15:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XC9qos4DZLy1LQLFohTxMuo6P6SyCh2w8zZgGWmYjY=;
        b=YdPnNX+skeYKBY10DpJ/gj/xzB2EQNCSV5TmF0UtC3g63foJhfMF2T8d+I6WmfvBMn
         dUfToRfDkU1YtmApzPu+2qvm/sos0XtlMH+MeQWHJP84yrKTHGrRXYkCaQV0gcaxGboC
         I9CsqXDlF2os0Rx9jyAUP8kZaPF2jtLIPeSYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XC9qos4DZLy1LQLFohTxMuo6P6SyCh2w8zZgGWmYjY=;
        b=ALKAyQjnfM+MNwxkuTcXX3rvvJqv6+E/4PXQ3AiXqkUXynpbCvfoXdoRQmtDpQwMW0
         NY60elhTS1KUIo2geQRB3M610426hejHC5DwFLUWazc3XMdGam1kC4wYD/tFNzpfEiK+
         /BqbwdDKtEPJRkxyvmvw0YtS+SZwxkY33XjYNCaHFQjdI/KVd6G/mFPiQj5kWH9oQTQB
         5igaQtmDHUFa8ZlODltVGMFffDbLjaCX99533EBpUD9MiFjpG15gMUQ+pt2xhQ26JrLk
         U4n1r/9GDS60FN24TpzYncFIVtIaPXNEE+11+DeCV3HO7bzJRM7uCHWYZSOIF49MujnU
         h4Pg==
X-Gm-Message-State: APzg51Ar2tdWOw34oWK6FpsgFBI5vwh/1TYHbP9xKDxKhH0eWaBE6pa6
        V5GviXMpnlT4TxFOzd5LoFF72r5iz0jKcPzqzVcwcw==
X-Google-Smtp-Source: ANB0VdalMeiKWQwjh0uo9TnK/qoa7ISM4y1Xqnr8LGlQJ7vjMWHkRDv50pQ7KW3MMpn9Ppb8BCp7jbWOvl2ulMf55is=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr19194347itd.130.1537310423295;
 Tue, 18 Sep 2018 15:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180914070839.4667-1-ricardo.ribalda@gmail.com> <20180914070839.4667-2-ricardo.ribalda@gmail.com>
In-Reply-To: <20180914070839.4667-2-ricardo.ribalda@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 15:40:10 -0700
Message-ID: <CACRpkdbqmK=MzGsOYLdtFO3AAbKHhzy_RD=Gr6wj3WnQunyCGg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Timur Tabi <timur@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 12:08 AM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:

> Current code assumes that the direction is input if direction_input
> function is set.
> This might not be the case on GPIOs with programmable direction.
>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/gpio/gpiolib.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index a57300c1d649..af853749e0bb 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1352,7 +1352,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
>                  * it does, and in case chip->get_direction is not set, we may
>                  * expose the wrong direction in sysfs.
>                  */
> -               desc->flags = !chip->direction_input ? (1 << FLAG_IS_OUT) : 0;
> +               if (chip->get_direction)
> +                       desc->flags = !chip->get_direction(chip, i) ?
> +                                       (1 << FLAG_IS_OUT) : 0;
> +               else
> +                       desc->flags = !chip->direction_input ?
> +                                       (1 << FLAG_IS_OUT) : 0;

We used to do this.

But it breaks Qualcomm hardware.

commit 1ca2a92b2a99323f666f1b669b7484df4bda05e4
Author: Timur Tabi <timur@codeaurora.org>
Date:   Wed Dec 20 13:10:31 2017 -0600

    Revert "gpio: set up initial state from .get_direction()"

    This reverts commit 72d3200061776264941be1b5a9bb8e926b3b30a5.

    We cannot blindly query the direction of all GPIOs when the pins are
    first registered.  The get_direction callback normally triggers a
    read/write to hardware, but we shouldn't be touching the hardware for
    an individual GPIO until after it's been properly claimed.

    Signed-off-by: Timur Tabi <timur@codeaurora.org>
    Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
