Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeFDTRx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:17:53 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38473 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbeFDTRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:17:51 -0400
X-Google-Smtp-Source: ADUXVKJk14ZQNTfgLqNxBTlKgCrFv5mRJh7yD94dwpq17zV7J45FrScfJahC7Txp7chMkEJkHW507Enu2nk9/NE/Qbc=
MIME-Version: 1.0
In-Reply-To: <1528138850-18259-4-git-send-email-eajames@linux.vnet.ibm.com>
References: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com> <1528138850-18259-4-git-send-email-eajames@linux.vnet.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Jun 2018 22:17:49 +0300
Message-ID: <CAHp75VfMsL3rBMT-SMcSCyuQd2YMexXqkrb=zBYEq0=MO=zHNA@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] i2c: fsi: Add port structures
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

On Mon, Jun 4, 2018 at 10:00 PM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> Add and initialize I2C adapters for each port on the FSI-attached I2C
> master. Ports for each master are defined in the devicetree.
>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  drivers/i2c/busses/i2c-fsi.c | 90 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
> index e1b183c..12130c3 100644
> --- a/drivers/i2c/busses/i2c-fsi.c
> +++ b/drivers/i2c/busses/i2c-fsi.c
> @@ -17,7 +17,10 @@
>  #include <linux/fsi.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
>
>  #define FSI_ENGID_I2C          0x7
>
> @@ -123,6 +126,14 @@
>  struct fsi_i2c_master {
>         struct fsi_device       *fsi;
>         u8                      fifo_size;
> +       struct list_head        ports;
> +};
> +
> +struct fsi_i2c_port {
> +       struct list_head        list;
> +       struct i2c_adapter      adapter;
> +       struct fsi_i2c_master   *master;
> +       u16                     port;
>  };
>
>  static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
> @@ -176,9 +187,38 @@ static int fsi_i2c_dev_init(struct fsi_i2c_master *i2c)
>         return fsi_i2c_write_reg(i2c->fsi, I2C_FSI_WATER_MARK, &watermark);
>  }
>
> +static int fsi_i2c_set_port(struct fsi_i2c_port *port)
> +{
> +       int rc;
> +       struct fsi_device *fsi = port->master->fsi;
> +       u32 mode, dummy = 0;
> +
> +       rc = fsi_i2c_read_reg(fsi, I2C_FSI_MODE, &mode);
> +       if (rc)
> +               return rc;
> +
> +       if (FIELD_GET(I2C_MODE_PORT, mode) == port->port)
> +               return 0;
> +

> +       mode = (mode & ~I2C_MODE_PORT) | FIELD_PREP(I2C_MODE_PORT, port->port);

Did you consider to split this to two lines / assignments?

> +       rc = fsi_i2c_write_reg(fsi, I2C_FSI_MODE, &mode);
> +       if (rc)
> +               return rc;
> +
> +       /* reset engine when port is changed */
> +       return fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
> +}
> +
>  static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>                         int num)
>  {
> +       int rc;
> +       struct fsi_i2c_port *port = adap->algo_data;
> +
> +       rc = fsi_i2c_set_port(port);
> +       if (rc)
> +               return rc;
> +
>         return -EOPNOTSUPP;
>  }
>
> @@ -196,23 +236,72 @@ static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
>  static int fsi_i2c_probe(struct device *dev)
>  {
>         struct fsi_i2c_master *i2c;
> +       struct fsi_i2c_port *port;
> +       struct device_node *np;
>         int rc;
> +       u32 port_no;
>
>         i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
>         if (!i2c)
>                 return -ENOMEM;
>
>         i2c->fsi = to_fsi_dev(dev);
> +       INIT_LIST_HEAD(&i2c->ports);
>
>         rc = fsi_i2c_dev_init(i2c);
>         if (rc)
>                 return rc;
>
> +       /* Add adapter for each i2c port of the master. */
> +       for_each_available_child_of_node(dev->of_node, np) {
> +               rc = of_property_read_u32(np, "reg", &port_no);
> +               if (rc || port_no > USHRT_MAX)
> +                       continue;



> +
> +               port = kzalloc(sizeof(*port), GFP_KERNEL);
> +               if (!port)
> +                       break;
> +
> +               port->master = i2c;
> +               port->port = port_no;
> +
> +               port->adapter.owner = THIS_MODULE;
> +               port->adapter.dev.of_node = np;
> +               port->adapter.dev.parent = dev;
> +               port->adapter.algo = &fsi_i2c_algorithm;
> +               port->adapter.algo_data = port;
> +
> +               snprintf(port->adapter.name, sizeof(port->adapter.name),
> +                        "i2c_bus-%u", port_no);
> +
> +               rc = i2c_add_adapter(&port->adapter);
> +               if (rc < 0) {
> +                       dev_err(dev, "Failed to register adapter: %d\n", rc);
> +                       kfree(port);
> +                       continue;
> +               }
> +
> +               list_add(&port->list, &i2c->ports);
> +       }
> +
>         dev_set_drvdata(dev, i2c);
>
>         return 0;
>  }
>
> +static int fsi_i2c_remove(struct device *dev)
> +{
> +       struct fsi_i2c_master *i2c = dev_get_drvdata(dev);
> +       struct fsi_i2c_port *port;
> +
> +       list_for_each_entry(port, &i2c->ports, list) {
> +               i2c_del_adapter(&port->adapter);
> +               kfree(port);
> +       }

Just to be sure, it will be called if and only if all adapters are not
busy. Correct?

> +
> +       return 0;
> +}
> +
>  static const struct fsi_device_id fsi_i2c_ids[] = {
>         { FSI_ENGID_I2C, FSI_VERSION_ANY },
>         { 0 }
> @@ -224,6 +313,7 @@ static int fsi_i2c_probe(struct device *dev)
>                 .name = "i2c-fsi",
>                 .bus = &fsi_bus_type,
>                 .probe = fsi_i2c_probe,
> +               .remove = fsi_i2c_remove,
>         },
>  };
>
> --
> 1.8.3.1
>



-- 
With Best Regards,
Andy Shevchenko
