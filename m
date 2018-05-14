Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbeENOps (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:45:48 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:43968 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbeENOpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:45:46 -0400
X-Google-Smtp-Source: AB8JxZpBY52w7OhU92mfgs8I9c0swUAyE2OIA1L5MKIh9QdIybPKwMEw8T9fberEt06TEMvYTCvhmybV0Wd6cCWSOuQ=
MIME-Version: 1.0
In-Reply-To: <20180226090038.etk5q4pd4rl5dvf6@flea.lan>
References: <20180225135308.GA14561@arx-s1> <20180226090038.etk5q4pd4rl5dvf6@flea.lan>
From: Hao Zhang <hao5781286@gmail.com>
Date: Mon, 14 May 2018 22:45:44 +0800
Message-ID: <CAJeuY7-Dz1u9J8GMu=OdzJ2cJUnE3wEobJoQz6RV-ibjBjoW4A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: PWM: add allwinner sun8i pwm support.
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk,
        Chen-Yu Tsai <wens@csie.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        linux-gpio@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support"
        <linux-arm-kernel@lists.infradead.org>,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4EEjsKc000463

2018-02-26 17:00 GMT+08:00 Maxime Ripard <maxime.ripard@bootlin.com>:
> Hi,
>
> Thanks for respinning this serie. It looks mostly good, but you still
> have a quite significant number of checkpatch (--strict) warnings that
> you should address.

Thanks for reviews :) ,i'm sorry for that, it will be fixed next time.
and, besides, in what situation were the checkpatch warning can be ignore？

>
> On Sun, Feb 25, 2018 at 09:53:08PM +0800, hao_zhang wrote:
>> +#define CAPTURE_IRQ_ENABLE_REG       0x0010
>> +#define CFIE(ch)     BIT(ch << 1 + 1)
>> +#define CRIE(ch)     BIT(ch << 1)
>
> You should also put your argument between parentheses here (and in all
> your other macros).

Do you mean like this ?
#define CFIE(ch)     BIT((ch) << 1 + 1)
#define CRIE(ch)     BIT((ch) << 1)

>
>> +static const u16 div_m_table[] = {
>> +     1,
>> +     2,
>> +     4,
>> +     8,
>> +     16,
>> +     32,
>> +     64,
>> +     128,
>> +     256
>> +};
>
> If this is just a power of two, you can use either the power of two /
> ilog2 to switch back and forth, instead of using that table.

I think using table is more explicit and extended...

>
>> +static int sun8i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +             struct pwm_state *state)
>> +{
>> +     int ret;
>> +     struct sun8i_pwm_chip *sun8i_pwm = to_sun8i_pwm_chip(chip);
>> +     struct pwm_state cstate;
>> +
>> +     pwm_get_state(pwm, &cstate);
>> +     if (!cstate.enabled) {
>> +             ret = clk_prepare_enable(sun8i_pwm->clk);
>> +             if (ret) {
>> +                     dev_err(chip->dev, "Failed to enable PWM clock\n");
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     spin_lock(&sun8i_pwm->ctrl_lock);
>
> What do you need that spinlock for? Can you use a mutex instead?
It should be remove.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
