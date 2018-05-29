Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968056AbeE2XT2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 19:19:28 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35225 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965084AbeE2XT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 19:19:26 -0400
X-Google-Smtp-Source: ADUXVKIxhWpceYkdBFRgGnpy7qur8ao3tijCUGw7o8uZvC2PyZLRKVUlqXeocklLsFfCVN810kxmrTl/3B21imRY47w=
MIME-Version: 1.0
In-Reply-To: <1527632665-25707-4-git-send-email-eajames@linux.vnet.ibm.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com> <1527632665-25707-4-git-send-email-eajames@linux.vnet.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 May 2018 02:19:25 +0300
Message-ID: <CAHp75Vd38BrJcULxoqj1mTKCEvMh9ZVYEvzCMAg2t9onZrSR6w@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] drivers/i2c: Add port structure to FSI algorithm
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
> Add and initialize I2C adapters for each port on the FSI-attached I2C
> master. Ports for each master are defined in the devicetree.

> +#include <linux/of.h>


> +static int fsi_i2c_set_port(struct fsi_i2c_port *port)
> +{
> +       int rc;
> +       struct fsi_device *fsi = port->master->fsi;
> +       u32 mode, dummy = 0;
> +       u16 old_port;
> +
> +       rc = fsi_i2c_read_reg(fsi, I2C_FSI_MODE, &mode);
> +       if (rc)
> +               return rc;
> +

> +       old_port = GETFIELD(I2C_MODE_PORT, mode);
> +
> +       if (old_port != port->port) {

Why not simple

if (port->port == GETFIELD())
  return 0;

?

> +               /* reset engine when port is changed */
> +               rc = fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
> +               if (rc)
> +                       return rc;
> +       }

> +       return rc;

It's hardly would be non-zero, right?

> +}

>  static int fsi_i2c_probe(struct device *dev)
>  {

Isn't below somehow repeats of_i2c_register_devices() ?
Why not to use it?

> +       /* Add adapter for each i2c port of the master. */
> +       for_each_available_child_of_node(dev->of_node, np) {
> +               rc = of_property_read_u32(np, "reg", &port_no);
> +               if (rc || port_no > USHRT_MAX)
> +                       continue;
> +
> +               port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
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

> +                       devm_kfree(dev, port);

This hurts my eyes. Why?!

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

> +       if (!list_empty(&i2c->ports)) {

My gosh, this is done already in list_for_each*()

> +               list_for_each_entry(port, &i2c->ports, list) {
> +                       i2c_del_adapter(&port->adapter);
> +               }

> +       }



-- 
With Best Regards,
Andy Shevchenko
