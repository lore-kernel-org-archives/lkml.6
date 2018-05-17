Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeEQOtC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:49:02 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35585 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeEQOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:49:00 -0400
X-Google-Smtp-Source: AB8JxZpTBH4Ge6K4O35n9rMF9XVwjG3BYlUakXd23GcI9xoJfoCth3nKcG6SXRdeLCWW3RGaKyVSjzHS2AR2EKcKF2k=
MIME-Version: 1.0
In-Reply-To: <20180515111711.l2g4vgsal7yr6dbr@flea>
References: <20180225135308.GA14561@arx-s1> <20180226090038.etk5q4pd4rl5dvf6@flea.lan>
 <CAJeuY7-Dz1u9J8GMu=OdzJ2cJUnE3wEobJoQz6RV-ibjBjoW4A@mail.gmail.com> <20180515111711.l2g4vgsal7yr6dbr@flea>
From: Hao Zhang <hao5781286@gmail.com>
Date: Thu, 17 May 2018 22:48:58 +0800
Message-ID: <CAJeuY79ObkssY_=SLG==7xZri10P3yWFhXC3=CUVrdQ+7cBoHA@mail.gmail.com>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4HEn8UG018734

2018-05-15 19:17 GMT+08:00 Maxime Ripard <maxime.ripard@bootlin.com>:
> Hi,
>
> On Mon, May 14, 2018 at 10:45:44PM +0800, Hao Zhang wrote:
>> 2018-02-26 17:00 GMT+08:00 Maxime Ripard <maxime.ripard@bootlin.com>:
>> > Thanks for respinning this serie. It looks mostly good, but you still
>> > have a quite significant number of checkpatch (--strict) warnings that
>> > you should address.
>>
>> Thanks for reviews :) ,i'm sorry for that, it will be fixed next
>> time.  and, besides, in what situation were the checkpatch warning
>> can be ignore？
>
> The only one that can be reasonably be ignored is the long line
> warning, and only if complying to the limit would make it less easy to
> understand.
>
>> >
>> > On Sun, Feb 25, 2018 at 09:53:08PM +0800, hao_zhang wrote:
>> >> +#define CAPTURE_IRQ_ENABLE_REG       0x0010
>> >> +#define CFIE(ch)     BIT(ch << 1 + 1)
>> >> +#define CRIE(ch)     BIT(ch << 1)
>> >
>> > You should also put your argument between parentheses here (and in all
>> > your other macros).
>>
>> Do you mean like this ?
>> #define CFIE(ch)     BIT((ch) << 1 + 1)
>> #define CRIE(ch)     BIT((ch) << 1)
>
> Yep, exactly. Otherwise, if you do something like CRIE(1 + 1), the
> result will be BIT(1 + 1 << 1), which will expand to 3, instead of 4.
>
> Also, CFIE looks a bit weird here, is it the offset that is
> incremented, or the value? You should probably have parentheses to
> make it explicit.

The vallue,
BIT(((ch) << 1) + 1) It seem not very nice...

uhmm...
In CAPTURE_IRQ_ENABLE_REG odd number is CFIE, even number is CRIE
each channel has one CFIE and CRIE.

we can also describe like this:
#define CFIE(ch)     BIT((ch) * 2 + 1)
#define CRIE(ch)     BIT((ch) * 2)

>
>> >
>> >> +static const u16 div_m_table[] = {
>> >> +     1,
>> >> +     2,
>> >> +     4,
>> >> +     8,
>> >> +     16,
>> >> +     32,
>> >> +     64,
>> >> +     128,
>> >> +     256
>> >> +};
>> >
>> > If this is just a power of two, you can use either the power of two /
>> > ilog2 to switch back and forth, instead of using that table.
>>
>> I think using table is more explicit and extended...
>
> If you didn't have a simple mapping between the register values and
> the divider value, then yeah, sure. But it's not the case here.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
