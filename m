Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755282AbeE2Xmi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 19:42:38 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33959 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbeE2Xmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 19:42:35 -0400
X-Google-Smtp-Source: ADUXVKJ4DboUIujZ46mcWW23XZ8x6gpZnYSerWk/Z7rbdaLQm3lpml6BBkSJejPT1d585eq+i6DDaAs+V5lMde8vzz8=
MIME-Version: 1.0
In-Reply-To: <1527632665-25707-3-git-send-email-eajames@linux.vnet.ibm.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com> <1527632665-25707-3-git-send-email-eajames@linux.vnet.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 May 2018 02:42:34 +0300
Message-ID: <CAHp75VexBiRQ1SPYK6=N-vmCAC9DhtpNKanYXrFshSM9WZb+UA@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] drivers/i2c: Add FSI-attached I2C master algorithm
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Edward A. James" <eajames@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 1:24 AM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> From: "Edward A. James" <eajames@us.ibm.com>
>
> Add register definitions for FSI-attached I2C master and functions to
> access those registers over FSI. Add an FSI driver so that our I2C bus
> is probed up during an FSI scan.

This looks like reinventing a wheel in some ways.

See my comments below.

> +/*
> + * Copyright 2017 IBM Corporation
> + *
> + * Eddie James <eajames@us.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */

We are using SPDX identifiers. Can you?

> +/* Find left shift from first set bit in m */
> +#define MASK_TO_LSH(m)         (__builtin_ffsll(m) - 1ULL)

Oh. What about GENMASK()?

> +/* Extract field m from v */
> +#define GETFIELD(m, v)         (((v) & (m)) >> MASK_TO_LSH(m))
> +
> +/* Set field m of v to val */
> +#define SETFIELD(m, v, val)    \
> +       (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))

Oh, what about https://elixir.bootlin.com/linux/latest/source/include/linux/bitfield.h
?

> +#define I2C_CMD_WITH_START     0x80000000
> +#define I2C_CMD_WITH_ADDR      0x40000000
> +#define I2C_CMD_RD_CONT                0x20000000
> +#define I2C_CMD_WITH_STOP      0x10000000
> +#define I2C_CMD_FORCELAUNCH    0x08000000

BIT() ?

> +#define I2C_CMD_ADDR           0x00fe0000
> +#define I2C_CMD_READ           0x00010000

GENMASK()? Though precisely here it might be good to leave explicit values.

> +#define I2C_CMD_LEN            0x0000ffff

> +#define I2C_MODE_CLKDIV                0xffff0000
> +#define I2C_MODE_PORT          0x0000fc00
> +#define I2C_MODE_ENHANCED      0x00000008
> +#define I2C_MODE_DIAG          0x00000004
> +#define I2C_MODE_PACE_ALLOW    0x00000002
> +#define I2C_MODE_WRAP          0x00000001

What are they? Masks? Bit fields? Just plain numbers?

> +#define I2C_WATERMARK_HI       0x0000f000
> +#define I2C_WATERMARK_LO       0x000000f0

GENMASK() ?

> +#define I2C_INT_INV_CMD                0x00008000
> +#define I2C_INT_PARITY         0x00004000
> +#define I2C_INT_BE_OVERRUN     0x00002000
> +#define I2C_INT_BE_ACCESS      0x00001000
> +#define I2C_INT_LOST_ARB       0x00000800
> +#define I2C_INT_NACK           0x00000400
> +#define I2C_INT_DAT_REQ                0x00000200
> +#define I2C_INT_CMD_COMP       0x00000100
> +#define I2C_INT_STOP_ERR       0x00000080
> +#define I2C_INT_BUSY           0x00000040
> +#define I2C_INT_IDLE           0x00000020

BIT()

> +#define I2C_INT_ENABLE         0x0000ff80
> +#define I2C_INT_ERR            0x0000fcc0

> +#define I2C_STAT_INV_CMD       0x80000000
> +#define I2C_STAT_PARITY                0x40000000
> +#define I2C_STAT_BE_OVERRUN    0x20000000
> +#define I2C_STAT_BE_ACCESS     0x10000000
> +#define I2C_STAT_LOST_ARB      0x08000000
> +#define I2C_STAT_NACK          0x04000000
> +#define I2C_STAT_DAT_REQ       0x02000000
> +#define I2C_STAT_CMD_COMP      0x01000000
> +#define I2C_STAT_STOP_ERR      0x00800000
> +#define I2C_STAT_MAX_PORT      0x000f0000
> +#define I2C_STAT_ANY_INT       0x00008000
> +#define I2C_STAT_SCL_IN                0x00000800
> +#define I2C_STAT_SDA_IN                0x00000400
> +#define I2C_STAT_PORT_BUSY     0x00000200
> +#define I2C_STAT_SELF_BUSY     0x00000100

BIT()

> +#define I2C_STAT_FIFO_COUNT    0x000000ff

GENMASK()

> +
> +#define I2C_STAT_ERR           0xfc800000
> +#define I2C_STAT_ANY_RESP      0xff800000

> +#define I2C_ESTAT_FIFO_SZ      0xff000000

GENMASK()

> +#define I2C_ESTAT_SCL_IN_SY    0x00008000
> +#define I2C_ESTAT_SDA_IN_SY    0x00004000
> +#define I2C_ESTAT_S_SCL                0x00002000
> +#define I2C_ESTAT_S_SDA                0x00001000
> +#define I2C_ESTAT_M_SCL                0x00000800
> +#define I2C_ESTAT_M_SDA                0x00000400
> +#define I2C_ESTAT_HI_WATER     0x00000200
> +#define I2C_ESTAT_LO_WATER     0x00000100
> +#define I2C_ESTAT_PORT_BUSY    0x00000080
> +#define I2C_ESTAT_SELF_BUSY    0x00000040

BIT()

> +#define I2C_ESTAT_VERSION      0x0000001f

GENMASK()

> +       __be32 data_be;

No need to have a suffix. If anything can go wrong we have a tool,
it's called sparse. It will catch out inappropriate use of __bitwise
types.

> +       __be32 data_be = cpu_to_be32(*data);

cpu_to_be32p()  IIUC?

> +static int fsi_i2c_dev_init(struct fsi_i2c_master *i2c)
> +{
> +       int rc;
> +       u32 mode = I2C_MODE_ENHANCED, extended_status, watermark = 0;

> +       u32 interrupt = 0;

Redundant assignment.

> +
> +       /* since we use polling, disable interrupts */
> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_INT_MASK, &interrupt);
> +       if (rc)
> +               return rc;

> +       return rc;

Would be non-zero?

> +}

-- 
With Best Regards,
Andy Shevchenko
