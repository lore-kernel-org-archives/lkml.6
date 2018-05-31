Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeEaGuv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:50:51 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33943 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754020AbeEaGup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:50:45 -0400
X-Google-Smtp-Source: ADUXVKIGw2vU+BBAsqK9hsEMOG+tqVBOg305JYLDhpATtFgzqH7S3k+0a3CxpIIzYbyMGzZPBsiQlAmQ9aajfEjFujE=
MIME-Version: 1.0
In-Reply-To: <1527714464-8642-6-git-send-email-eajames@linux.vnet.ibm.com>
References: <1527714464-8642-1-git-send-email-eajames@linux.vnet.ibm.com> <1527714464-8642-6-git-send-email-eajames@linux.vnet.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 09:50:44 +0300
Message-ID: <CAHp75Vc40R3Mi+eAdhpv--C1WGCdBPGQSsXdJhxFmaxVueWUZg@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] i2c: fsi: Add transfer implementation
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 12:07 AM, Eddie James
<eajames@linux.vnet.ibm.com> wrote:
> Execute I2C transfers from the FSI-attached I2C master. Use polling
> instead of interrupts as we have no hardware IRQ over FSI.
>

Few nitpicks, after addressing them (field definition is up to you though)

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  drivers/i2c/busses/i2c-fsi.c | 196 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 194 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
> index e5dd0f7..f24e4b9 100644
> --- a/drivers/i2c/busses/i2c-fsi.c
> +++ b/drivers/i2c/busses/i2c-fsi.c
> @@ -149,6 +149,7 @@ struct fsi_i2c_port {
>         struct i2c_adapter      adapter;
>         struct fsi_i2c_master   *master;
>         u16                     port;
> +       u16                     xfrd;
>  };
>
>  static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
> @@ -224,6 +225,100 @@ static int fsi_i2c_set_port(struct fsi_i2c_port *port)
>         return fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
>  }
>
> +static int fsi_i2c_start(struct fsi_i2c_port *port, struct i2c_msg *msg,
> +                        bool stop)
> +{
> +       struct fsi_i2c_master *i2c = port->master;
> +       u32 cmd = I2C_CMD_WITH_START | I2C_CMD_WITH_ADDR;
> +
> +       port->xfrd = 0;
> +

> +       if (msg->flags & I2C_M_RD)
> +               cmd |= I2C_CMD_READ;

(1)

> +
> +       if (stop || msg->flags & I2C_M_STOP)
> +               cmd |= I2C_CMD_WITH_STOP;
> +

> +       cmd |= FIELD_PREP(I2C_CMD_ADDR, msg->addr >> 1);

(1) + this looks like:

 // #define I2C_CMD_ADDR           GENMASK(23, 17)
 // #define I2C_CMD_READ           BIT(16)

#define I2C_CMD_8BIT_ADDR           GENMASK(23, 16)
// or even drop I2C_CMD_READ completely

   cmd |= FIELD_PREP(I2C_CMD_8BIT_ADDR, i2c_8bit_addr_from_msg(msg));

> +       cmd |= FIELD_PREP(I2C_CMD_LEN, msg->len);
> +
> +       return fsi_i2c_write_reg(i2c->fsi, I2C_FSI_CMD, &cmd);
> +}
> +
> +static int fsi_i2c_get_op_bytes(int op_bytes)
> +{
> +       /* fsi is limited to max 4 byte aligned ops */
> +       if (op_bytes > 4)
> +               return 4;
> +       else if (op_bytes == 3)
> +               return 2;
> +       else
> +               return op_bytes;

If you have pattern like

if {
 ...
 return;
} else {
 ...
}

'else' is redundant.

> +}

Overall, I think rounddown_pow_of_two() makes sense here.
Though it's your choice.

> +
> +static int fsi_i2c_write_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
> +                             u8 fifo_count)
> +{
> +       int write;
> +       int rc;
> +       struct fsi_i2c_master *i2c = port->master;
> +       int bytes_to_write = i2c->fifo_size - fifo_count;
> +       int bytes_remaining = msg->len - port->xfrd;
> +
> +       bytes_to_write = min(bytes_to_write, bytes_remaining);
> +
> +       while (bytes_to_write) {
> +               write = fsi_i2c_get_op_bytes(bytes_to_write);
> +
> +               rc = fsi_device_write(i2c->fsi, I2C_FSI_FIFO,
> +                                     &msg->buf[port->xfrd], write);
> +               if (rc)
> +                       return rc;
> +
> +               port->xfrd += write;
> +               bytes_to_write -= write;
> +       }
> +
> +       return 0;
> +}
> +
> +static int fsi_i2c_read_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
> +                            u8 fifo_count)
> +{
> +       int read;
> +       int rc;
> +       struct fsi_i2c_master *i2c = port->master;
> +       int bytes_to_read;
> +       int xfr_remaining = msg->len - port->xfrd;
> +       u32 dummy;
> +
> +       bytes_to_read = min_t(int, fifo_count, xfr_remaining);
> +
> +       while (bytes_to_read) {
> +               read = fsi_i2c_get_op_bytes(bytes_to_read);
> +
> +               if (xfr_remaining) {
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
> +               bytes_to_read -= read;
> +       }
> +
> +       return 0;
> +}
> +
>  static int fsi_i2c_reset_bus(struct fsi_i2c_master *i2c)
>  {
>         int i, rc;
> @@ -387,17 +482,114 @@ static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
>         return -ETIMEDOUT;
>  }
>
> +static int fsi_i2c_handle_status(struct fsi_i2c_port *port,
> +                                struct i2c_msg *msg, u32 status)
> +{
> +       int rc;
> +       u8 fifo_count;
> +
> +       if (status & I2C_STAT_ERR) {
> +               rc = fsi_i2c_abort(port, status);
> +               if (rc)
> +                       return rc;
> +
> +               if (status & I2C_STAT_INV_CMD)
> +                       return -EINVAL;
> +
> +               if (status & (I2C_STAT_PARITY | I2C_STAT_BE_OVERRUN |
> +                   I2C_STAT_BE_ACCESS))
> +                       return -EPROTO;
> +
> +               if (status & I2C_STAT_NACK)
> +                       return -ENXIO;
> +
> +               if (status & I2C_STAT_LOST_ARB)
> +                       return -EAGAIN;
> +
> +               if (status & I2C_STAT_STOP_ERR)
> +                       return -EBADMSG;
> +
> +               return -EIO;
> +       }
> +
> +       if (status & I2C_STAT_DAT_REQ) {
> +               fifo_count = FIELD_GET(I2C_STAT_FIFO_COUNT, status);
> +
> +               if (msg->flags & I2C_M_RD)
> +                       return fsi_i2c_read_fifo(port, msg, fifo_count);

> +               else
> +                       return fsi_i2c_write_fifo(port, msg, fifo_count);

Redundant 'else'

> +       }
> +
> +       if (status & I2C_STAT_CMD_COMP) {
> +               if (port->xfrd < msg->len)
> +                       return -ENODATA;

> +               else
> +                       return msg->len;

Ditto.

> +       }
> +
> +       return 0;
> +}
> +
> +static int fsi_i2c_wait(struct fsi_i2c_port *port, struct i2c_msg *msg,
> +                       unsigned long timeout)
> +{
> +       u32 status = 0;
> +       int rc;
> +       unsigned long start = jiffies;
> +
> +       do {
> +               rc = fsi_i2c_read_reg(port->master->fsi, I2C_FSI_STAT,
> +                                     &status);
> +               if (rc)
> +                       return rc;
> +
> +               if (status & I2C_STAT_ANY_RESP) {
> +                       rc = fsi_i2c_handle_status(port, msg, status);
> +                       if (rc < 0)
> +                               return rc;
> +
> +                       /* cmd complete and all data xfrd */
> +                       if (rc == msg->len)
> +                               return 0;
> +
> +                       /* need to xfr more data, but maybe don't need wait */
> +                       continue;
> +               }
> +
> +               usleep_range(I2C_CMD_SLEEP_MIN_US, I2C_CMD_SLEEP_MAX_US);
> +       } while (time_after(start + timeout, jiffies));
> +
> +       return -ETIMEDOUT;
> +}
> +
>  static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>                         int num)
>  {
> -       int rc;
> +       int i, rc;
> +       unsigned long start_time;
>         struct fsi_i2c_port *port = adap->algo_data;
> +       struct i2c_msg *msg;
>
>         rc = fsi_i2c_set_port(port);
>         if (rc)
>                 return rc;
>
> -       return -EOPNOTSUPP;
> +       for (i = 0; i < num; ++i) {

i++

> +               msg = msgs + i;
> +               start_time = jiffies;
> +
> +               rc = fsi_i2c_start(port, msg, i == num - 1);
> +               if (rc)
> +                       return rc;
> +
> +               rc = fsi_i2c_wait(port, msg,
> +                                 adap->timeout - (jiffies - start_time));
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       return 0;
>  }
>
>  static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
> --
> 1.8.3.1
>



-- 
With Best Regards,
Andy Shevchenko
