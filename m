Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeB0WaQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:30:16 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:42000 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbeB0WaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:30:12 -0500
X-Google-Smtp-Source: AG47ELvtl1gTmsAjo3uwQFa7E6v60im+QBcwdJL2XyJ7tMYu6sOs2qbBrAWDQptcYW5Tsab8HmnGq3XsXvH7MmpubO8=
MIME-Version: 1.0
In-Reply-To: <20180227212433.2189-4-mylene.josserand@bootlin.com>
References: <20180227212433.2189-1-mylene.josserand@bootlin.com> <20180227212433.2189-4-mylene.josserand@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Feb 2018 19:30:11 -0300
Message-ID: <CAOMZO5C+Ub2R6srR+2jv2pY8zwjwkPSecpO1gbXvmXMTTnhU8Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] ASoC: codecs: pcm179x: Add reset gpio
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        alexandre.belloni@bootlin.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1RMULKu014181

On Tue, Feb 27, 2018 at 6:24 PM, Mylène Josserand
<mylene.josserand@bootlin.com> wrote:

> +       pcm179x->reset = of_get_named_gpio(np, "reset-gpios", 0);
> +       if (gpio_is_valid(pcm179x->reset)) {
> +               ret = devm_gpio_request_one(dev, pcm179x->reset,
> +                                           GPIOF_OUT_INIT_LOW,
> +                                           "pcm179x reset");
> +               if (ret) {
> +                       dev_err(dev,
> +                               "Failed to request GPIO %d as reset pin, error %d\n",
> +                               pcm179x->reset, ret);
> +                       return ret;
> +               }
> +
> +               gpio_set_value(pcm179x->reset, 1);

It would be better to use the gpiod API, which takes the GPIO polarity
into account.

There may be systems that have an inverter connected to this pin, and
this can be changed in dts via GPIO_ACTIVE_HIGH.

Also, as the reset pin can be connected to an I2C expander, for
example, so it is safer to use the cansleep variant:

gpiod_set_value_cansleep(pcm179x->reset, 0);
