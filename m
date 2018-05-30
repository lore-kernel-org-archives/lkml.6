Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753757AbeE3VmO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:42:14 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33948 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753604AbeE3VmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:42:12 -0400
X-Google-Smtp-Source: ADUXVKLUCQ4TMKeREvodKoS6krF62e5tVMyHy/gPS8DpyYKKDitbniyrysNTrpDgOuHAsYK3DH8E4aWaRc2+5r3oB3c=
MIME-Version: 1.0
In-Reply-To: <1527714464-8642-5-git-send-email-eajames@linux.vnet.ibm.com>
References: <1527714464-8642-1-git-send-email-eajames@linux.vnet.ibm.com> <1527714464-8642-5-git-send-email-eajames@linux.vnet.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 00:42:11 +0300
Message-ID: <CAHp75Vc9HAQXj0FonR2mEmg0o7fgTPE-4oXS-zB78OG1gvKKEw@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] i2c: fsi: Add abort and hardware reset procedures
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
> Add abort procedure for failed transfers. Add engine and bus reset
> procedures to recover from as many faults as possible.
>

Few small comments, after addressing which

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  drivers/i2c/busses/i2c-fsi.c | 179 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 179 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
> index be8e15c..e5dd0f7 100644
> --- a/drivers/i2c/busses/i2c-fsi.c
> +++ b/drivers/i2c/busses/i2c-fsi.c
> @@ -12,10 +12,12 @@
>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/fsi.h>
>  #include <linux/i2c.h>
> +#include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> @@ -122,6 +124,20 @@
>  #define I2C_ESTAT_SELF_BUSY    BIT(6)
>  #define I2C_ESTAT_VERSION      GENMASK(4, 0)
>
> +/* port busy register */
> +#define I2C_PORT_BUSY_RESET    BIT(31)
> +
> +/* wait for command complete or data request */
> +#define I2C_CMD_SLEEP_MAX_US   500
> +#define I2C_CMD_SLEEP_MIN_US   50
> +
> +/* wait after reset; choose time from legacy driver */
> +#define I2C_RESET_SLEEP_MAX_US 2000
> +#define I2C_RESET_SLEEP_MIN_US 1000
> +
> +/* choose timeout length from legacy driver; it's well tested */
> +#define I2C_ABORT_TIMEOUT      msecs_to_jiffies(100)
> +
>  struct fsi_i2c_master {
>         struct fsi_device       *fsi;
>         u8                      fifo_size;
> @@ -208,6 +224,169 @@ static int fsi_i2c_set_port(struct fsi_i2c_port *port)
>         return fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
>  }
>
> +static int fsi_i2c_reset_bus(struct fsi_i2c_master *i2c)
> +{
> +       int i, rc;
> +       u32 mode, stat, ext, dummy = 0;
> +
> +       rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_MODE, &mode);
> +       if (rc)
> +               return rc;
> +
> +       mode |= I2C_MODE_DIAG;
> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, &mode);
> +       if (rc)
> +               return rc;
> +
> +       for (i = 0; i < 9; ++i) {

i++

> +               rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_SCL, &dummy);
> +               if (rc)
> +                       return rc;
> +
> +               rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_SET_SCL, &dummy);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_SCL, &dummy);
> +       if (rc)
> +               return rc;
> +
> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_SDA, &dummy);
> +       if (rc)
> +               return rc;
> +
> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_SET_SCL, &dummy);
> +       if (rc)
> +               return rc;
> +
> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_SET_SDA, &dummy);
> +       if (rc)
> +               return rc;
> +
> +       mode &= ~I2C_MODE_DIAG;
> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, &mode);
> +       if (rc)
> +               return rc;
> +
> +       rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_STAT, &stat);
> +       if (rc)
> +               return rc;
> +
> +       /* check for hardware fault */
> +       if (!(stat & I2C_STAT_SCL_IN) || !(stat & I2C_STAT_SDA_IN)) {
> +               rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_ESTAT, &ext);
> +               if (rc)
> +                       return rc;
> +
> +               dev_err(&i2c->fsi->dev, "bus stuck status[%08X] ext[%08X]\n",
> +                       stat, ext);
> +       }
> +
> +       return 0;
> +}
> +
> +static int fsi_i2c_reset(struct fsi_i2c_master *i2c, u16 port)
> +{
> +       int rc;
> +       u32 mode, stat, dummy = 0;
> +
> +       /* reset engine */
> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_I2C, &dummy);
> +       if (rc)
> +               return rc;
> +
> +       /* re-init engine */
> +       rc = fsi_i2c_dev_init(i2c);
> +       if (rc)
> +               return rc;
> +
> +       rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_MODE, &mode);
> +       if (rc)
> +               return rc;
> +
> +       /* set port; default after reset is 0 */
> +       if (port) {

> +               mode = (mode & ~I2C_MODE_PORT) | FIELD_PREP(I2C_MODE_PORT,
> +                                                           port);

Hmm... This would look better as two expressions

mode &= ~..._PORT;
mode |= FIELD_PREP(...);

> +               rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, &mode);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       /* reset busy register; hw workaround */
> +       dummy = I2C_PORT_BUSY_RESET;
> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_PORT_BUSY, &dummy);
> +       if (rc)
> +               return rc;
> +
> +       /* force bus reset */
> +       rc = fsi_i2c_reset_bus(i2c);
> +       if (rc)
> +               return rc;
> +
> +       /* reset errors */
> +       dummy = 0;
> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_ERR, &dummy);
> +       if (rc)
> +               return rc;
> +
> +       /* wait for command complete */
> +       usleep_range(I2C_RESET_SLEEP_MIN_US, I2C_RESET_SLEEP_MAX_US);
> +
> +       rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_STAT, &stat);
> +       if (rc)
> +               return rc;
> +
> +       if (stat & I2C_STAT_CMD_COMP)
> +               return rc;
> +
> +       /* failed to get command complete; reset engine again */
> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_I2C, &dummy);
> +       if (rc)
> +               return rc;
> +
> +       /* re-init engine again */
> +       return fsi_i2c_dev_init(i2c);
> +}
> +
> +static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
> +{
> +       int rc;
> +       unsigned long start;
> +       u32 cmd = I2C_CMD_WITH_STOP;
> +       struct fsi_device *fsi = port->master->fsi;
> +
> +       rc = fsi_i2c_reset(port->master, port->port);
> +       if (rc)
> +               return rc;
> +
> +       /* skip final stop command for these errors */
> +       if (status & (I2C_STAT_PARITY | I2C_STAT_LOST_ARB | I2C_STAT_STOP_ERR))
> +               return 0;
> +
> +       /* write stop command */
> +       rc = fsi_i2c_write_reg(fsi, I2C_FSI_CMD, &cmd);
> +       if (rc)
> +               return rc;
> +
> +       /* wait until we see command complete in the master */
> +       start = jiffies;
> +
> +       do {
> +               rc = fsi_i2c_read_reg(fsi, I2C_FSI_STAT, &status);
> +               if (rc)
> +                       return rc;
> +
> +               if (status & I2C_STAT_CMD_COMP)
> +                       return 0;
> +
> +               usleep_range(I2C_CMD_SLEEP_MIN_US, I2C_CMD_SLEEP_MAX_US);
> +       } while (time_after(start + I2C_ABORT_TIMEOUT, jiffies));
> +
> +       return -ETIMEDOUT;
> +}
> +
>  static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>                         int num)
>  {
> --
> 1.8.3.1
>



-- 
With Best Regards,
Andy Shevchenko
