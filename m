Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbeDJOlU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:41:20 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36866 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754135AbeDJOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:41:16 -0400
X-Google-Smtp-Source: AIpwx49mnShFwqEqyF4gspUCnbCrM9qgew2XW1V5YGXpt9TTGhuxTVwWlnogZ+xj737oosvQwMXzw/rAZ3Rp1R+1GnI=
MIME-Version: 1.0
In-Reply-To: <69ab73657c5e75db94fab027c9957dbbb73047a7.1522868423.git.hns@goldelico.com>
References: <cover.1522868422.git.hns@goldelico.com> <69ab73657c5e75db94fab027c9957dbbb73047a7.1522868423.git.hns@goldelico.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Apr 2018 17:41:14 +0300
Message-ID: <CAHp75Ve5ecXJmMoO5Yy65VqR-FwnD+wMmhP=bOJ_Oxsgz8R1SQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpio: pca953x: add register definitions for
 pcal6524 and fix address calculation
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 10:00 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> PCAL chips ("L" seems to stand for "latched") have additional
> registers starting at address 0x40 to control the latches,
> interrupt mask, pull-up and pull down etc.
>
> The constants are so far defined in a way that they fit for
> the pcal9555a when shifted by the number of banks, i.e. multiplied
> by 2.
>
> Now the pcal6524 has 3 banks which means the relative offset
> must be multiplied by 4 which gives a wrong result if not done
> carefully, since the base offset is already included in the offset.
>
> For the basic registers shared with all pca93xx/tca64xx chips
> there is no such offset.
>
> Therefore, we add code to adjust the register number for exended
> registers in this case.
>
> And we add additional register offset constants (not yet used by
> the driver code) which are specific to the pcal6524.

> -#define PCAL953X_IN_LATCH      34
> -#define PCAL953X_INT_MASK      37
> -#define PCAL953X_INT_STAT      38

I prefer either to change first all the rest to be 2 digit hex values
first, or leave decimal in this patch.

> +#define PCAL953X_OUT_STRENGTH  0x20
> +#define PCAL953X_IN_LATCH      0x22
> +#define PCAL953X_PULL_EN       0x23
> +#define PCAL953X_PULL_SEL      0x24
> +#define PCAL953X_INT_MASK      0x25
> +#define PCAL953X_INT_STAT      0x26
> +#define PCAL953X_OUT_CONF      0x27
> +
> +#define PCAL6524_INT_EDGE      0x28
> +#define PCAL6524_INT_CLR       0x2a
> +#define PCAL6524_IN_STATUS     0x2b
> +#define PCAL6524_OUT_INDCONF   0x2c
> +#define PCAL6524_DEBOUNCE      0x2d

> +       /* adjust register address for pcal6524 */
> +       if (reg >= PCAL953X_OUT_STRENGTH)
> +               reg -= PCAL953X_OUT_STRENGTH >> 1;

I don't like this condition. Can we avoid relying on the register
offset in regard to some flag / compatible string / etc?

> +       /* adjust register address for pcal6524 */
> +       if (reg >= PCAL953X_OUT_STRENGTH)
> +               reg -= PCAL953X_OUT_STRENGTH >> 1;

Ditto.

-- 
With Best Regards,
Andy Shevchenko
