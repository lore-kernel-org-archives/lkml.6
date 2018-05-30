Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755410AbeE3AUL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 20:20:11 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38106 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755130AbeE3AUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 20:20:05 -0400
X-Google-Smtp-Source: ADUXVKLYPTMq/AdhM29LO2s8S0GeBGVnKkf6BCfAOwwy/zVqUOZJaBbx4FoeFuvDkAkI6VoU77WIPqMBMp5Y0im1sCI=
MIME-Version: 1.0
In-Reply-To: <1527632665-25707-5-git-send-email-eajames@linux.vnet.ibm.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com> <1527632665-25707-5-git-send-email-eajames@linux.vnet.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 May 2018 03:20:04 +0300
Message-ID: <CAHp75VfZHCDzsmF3=Nauy2ftPNs+5yOqBY9oBkrmLrus1BnK8A@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] drivers/i2c: Add abort and hardware reset procedures
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
> Add abort procedure for failed transfers. Add engine and bus reset
> procedures to recover from as many faults as possible.

> +#define I2C_PORT_BUSY_RESET    0x80000000

BIT() ?

> +       for (i = 0; i < 9; ++i) {

i++ would work as well.

> +               rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_SCL, &dummy);
> +               if (rc)
> +                       return rc;
> +
> +               rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_SET_SCL, &dummy);
> +               if (rc)
> +                       return rc;
> +       }

> +       /* reset errors */
> +       dummy = 0;
> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_ERR, &dummy);
> +       if (rc)
> +               return rc;

Ah, okay, discard my previous comments on dummy assignments. It seems
input and output.

> +       msleep(1);

msleep(1) usually a bad idea.
usleep_range() I guess what you need here.

> +}

> +       return -ETIME;

ETIMEDOUT ?

-- 
With Best Regards,
Andy Shevchenko
