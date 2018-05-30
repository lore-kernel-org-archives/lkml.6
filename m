Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967971AbeE3AIK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 20:08:10 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34022 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755408AbeE3AIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 20:08:04 -0400
X-Google-Smtp-Source: ADUXVKJ1KacTEq5+oNGsEDn5cJTL7rV9dwg8/RM2Jx8zRY4s2smNpjkRixhbwd8irlVmVz229oNiKVqkigSdB7MnFgo=
MIME-Version: 1.0
In-Reply-To: <1527632665-25707-6-git-send-email-eajames@linux.vnet.ibm.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com> <1527632665-25707-6-git-send-email-eajames@linux.vnet.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 May 2018 03:08:02 +0300
Message-ID: <CAHp75Vch1uEVvXadVR68tsDY-51=U+7FGr=5k0N5QtpcXpE_3A@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] drivers/i2c: Add transfer implementation for FSI algorithm
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
> Execute I2C transfers from the FSI-attached I2C master. Use polling
> instead of interrupts as we have no hardware IRQ over FSI.

> +       if (msg->flags & I2C_M_RD)
> +               cmd |= I2C_CMD_READ;

I think we have a helper for this, though not sure.

> +static int fsi_i2c_write_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
> +                             u8 fifo_count)
> +{
> +       int write;

> +       int rc = 0;

Redundant assignment.

> +       struct fsi_i2c_master *i2c = port->master;
> +       int bytes_to_write = i2c->fifo_size - fifo_count;
> +       int bytes_remaining = msg->len - port->xfrd;

> +       if (bytes_to_write > bytes_remaining)
> +               bytes_to_write = bytes_remaining;

_write = min(_write, _remaining);

> +       while (bytes_to_write > 0) {

> +               write = bytes_to_write;
> +               /* fsi limited to max 4 byte aligned ops */
> +               if (bytes_to_write > 4)
> +                       write = 4;
> +               else if (write == 3)
> +                       write = 2;

write = min_t(int, 4, rounddown_pow_of_two(bytes_to_write));

Also check it carefully, it might be optimized even more, though I
didn't think much.

> +       }

> +       return rc;

How it can be non-zero?

> +}

> +
> +static int fsi_i2c_read_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
> +                            u8 fifo_count)
> +{
> +       int read;

> +       int rc = 0;

Redundant assignment.

> +       struct fsi_i2c_master *i2c = port->master;
> +       int xfr_remaining = msg->len - port->xfrd;
> +       u32 dummy;
> +
> +       while (fifo_count) {

> +               read = fifo_count;
> +               /* fsi limited to max 4 byte aligned ops */
> +               if (fifo_count > 4)
> +                       read = 4;
> +               else if (read == 3)
> +                       read = 2;

See above for write case and do in similar way.

> +
> +               if (xfr_remaining) {

> +                       if (xfr_remaining < read)
> +                               read = xfr_remaining;

read = min(read, _remaining);

> +
> +                       rc = fsi_device_read(i2c->fsi, I2C_FSI_FIFO,
> +                                            &msg->buf[port->xfrd], read);
> +                       if (rc)
> +                               return rc;
> +
> +                       port->xfrd += read;
> +                       xfr_remaining -= read;
> +               } else {
> +                       /* no more buffer but data in fifo, need to clear it */
> +                       rc = fsi_device_read(i2c->fsi, I2C_FSI_FIFO, &dummy,
> +                                            read);
> +                       if (rc)
> +                               return rc;
> +               }
> +
> +               fifo_count -= read;
> +       }
> +

> +       return rc;

How non-zero possible here?

> +}

> +               if (port->xfrd < msg->len)
> +                       rc = -ENODATA;
> +               else
> +                       rc = msg->len;
> +
> +               return rc;

if (...)
  return -ENODATA;
return msg->len;
 ?

> +       u32 status = 0;

Redundant assignment.

> +       return -ETIME;

ETIMEDOUT ?


-- 
With Best Regards,
Andy Shevchenko
