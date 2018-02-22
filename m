Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932611AbeBVNoS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:44:18 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:36629 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932467AbeBVNoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:44:15 -0500
X-Google-Smtp-Source: AG47ELsYF3C3PxLCod15QVGC+xPsX+QrZOcUwBRjApDdS+w1B+m08V2nJNAc20K+bfPl/8OXF1vWCxMdEMbx7Azk9aA=
MIME-Version: 1.0
In-Reply-To: <1518100057-23234-3-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com> <1518100057-23234-3-git-send-email-amelie.delaunay@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 14:44:14 +0100
Message-ID: <CACRpkdbcEv3PyqjhzteKhx9pDfoJntKReVT2kBNY+-HSpaXh2A@mail.gmail.com>
Subject: Re: [PATCH 2/6] mfd: Add ST Multi-Function eXpander core driver
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:

Thanks for working on this complex expander driver.
It is a bit daunting. Sorry if there are lots of comments and
considerations, but it reflects the complexity of the hardware.

> +enum mfx_block {
> +       MFX_BLOCK_GPIO          = BIT(0),
> +       MFX_BLOCK_TS            = BIT(1),
> +       MFX_BLOCK_IDD           = BIT(2),
> +       MFX_BLOCK_ALTGPIO       = BIT(3),
> +};

This looks suspiciously similar to this:

enum stmpe_block {
        STMPE_BLOCK_GPIO        = 1 << 0,
        STMPE_BLOCK_KEYPAD      = 1 << 1,
        STMPE_BLOCK_TOUCHSCREEN = 1 << 2,
        STMPE_BLOCK_ADC         = 1 << 3,
        STMPE_BLOCK_PWM         = 1 << 4,
        STMPE_BLOCK_ROTATOR     = 1 << 5,
};

Apparently the same hardware designers are involved.

> +int mfx_reg_write(struct mfx *mfx, u8 reg, u8 data);
> +int mfx_reg_read(struct mfx *mfx, u8 reg);
> +int mfx_block_read(struct mfx *mfx, u8 reg, u8 length, u8 *values);
> +int mfx_block_write(struct mfx *mfx, u8 reg, u8 length, const u8 *values);
> +int mfx_set_bits(struct mfx *mfx, u8 reg, u8 mask, u8 val);

Do you need this? Can't you just use regmap and pass
around a struct regmap *map to access registers?

You don't necessarily need to use the default I2C regmap
(like, e.g. drivers/mfd/stw481x.c) but even if a more
complex access pattern is used to read/write registers
I am pretty sure you can use regmap for it.

> +int mfx_enable(struct mfx *mfx, unsigned int blocks);
> +int mfx_disable(struct mfx *mfx, unsigned int blocks);

This is similar to
extern int stmpe_enable(struct stmpe *stmpe, unsigned int blocks);
extern int stmpe_disable(struct stmpe *stmpe, unsigned int blocks);

So again I am suspicious about duplication of driver code.

It even looks a bit like this driver started as a copy of
the STMPE driver, which is not a good sign. It might be
that it was copied from there because the hardware is
actually very similar.

> +/* General */
> +#define MFX_REG_CHIP_ID                        0x00 /* R */
> +#define MFX_REG_FW_VERSION_MSB         0x01 /* R */
> +#define MFX_REG_FW_VERSION_LSB         0x02 /* R */
> +#define MFX_REG_SYS_CTRL               0x40 /* RW */

The STMPE driver defines enumerated registers in
include/linux/mfd/stmpe.h
then assign each variant using the model specifics in
drivers/mfd/stmpe.h

This doesn't seem super much different.

Even if the old STMPE driver may be a bad fit, is is better
to improve that (e.g. migrate it to use regmap and rewrite the
stmpe-gpio.c driver to use pin control) and use also for this
driver, or write a new driver from scratch like this?

I'm not so sure.

I do know that developers not always like to take out old
hardware and old development boards and start hacking
away before they can get some nice new hardware going
but I am worried that this may be one of those cases where
a serious cleanup of the aging STMPE driver may be a
first necessary step.

> +/* IRQ output management */
> +#define MFX_REG_IRQ_OUT_PIN            0x41 /* RW */
> +#define MFX_REG_IRQ_SRC_EN             0x42 /* RW */
> +#define MFX_REG_IRQ_PENDING            0x08 /* R */
> +#define MFX_REG_IRQ_ACK                        0x44 /* RW */

Very similar to STMPE it seems.

> +/* MFX_REG_SYS_CTRL bitfields */
> +#define MFX_REG_SYS_CTRL_GPIO_EN       BIT(0)
> +#define MFX_REG_SYS_CTRL_TS_EN         BIT(1)
> +#define MFX_REG_SYS_CTRL_IDD_EN                BIT(2)
> +#define MFX_REG_SYS_CTRL_ALTGPIO_EN    BIT(3)

I guess these blocks works the same as with STMPE,
that you can only use one of them at the time?

What is altgpio?

> +/* MFX_REG_IRQ_OUT_PIN bitfields */
> +#define MFX_REG_IRQ_OUT_PIN_TYPE       BIT(0) /* 0-OD 1-PP */
> +#define MFX_REG_IRQ_OUT_PIN_POL                BIT(1) /* 0-active LOW 1-active HIGH */

I have not read the patch yet. But just for notice:
This output IRQ type needs to be handled as well.

Check the code in
drivers/iio/common/st_sensors/st_sensors_trigger.c

To see how you can detect the properties of an IRQ
to set the right polarity, and handling of open drain
IRQ lines.

Yours,
Linus Walleij
