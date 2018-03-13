Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeCMVNH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:13:07 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45742 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbeCMVNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:13:06 -0400
X-Google-Smtp-Source: AG47ELsafTj6TvJol4wy2fEto31g7Ms+v5bkkwgKdgwUdzsEvjnB8UK3NF6WVKgGeMFYjZAzD8XPtJR1NEkpsS4h29Y=
MIME-Version: 1.0
In-Reply-To: <1520974749-5372-2-git-send-email-eajames@linux.vnet.ibm.com>
References: <1520974749-5372-1-git-send-email-eajames@linux.vnet.ibm.com> <1520974749-5372-2-git-send-email-eajames@linux.vnet.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 23:13:04 +0200
Message-ID: <CAHp75VdOzzmN=6K4H3rVGGaqMJ+q+nXnoY=qksNT6uvHnG6CAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hwmon: (ucd9000) Add gpio chip interface
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 10:59 PM, Eddie James
<eajames@linux.vnet.ibm.com> wrote:
> From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>
> Add a struct gpio_chip and define some methods so that this device's
> I/O can be accessed via /sys/class/gpio.

> +       /*
> +        * Note:
> +        *
> +        * Pinmux support has not been added to the new gpio_chip.
> +        * This support should be added when possible given the mux
> +        * behavior of these IO devices.
> +        */

> +       data->gpio.label = (const char *)&client->name;

Hmm... Why do you need this casting?

> +       data->gpio.get_direction = ucd9000_gpio_get_direction;
> +       data->gpio.direction_input = ucd9000_gpio_direction_input;
> +       data->gpio.direction_output = ucd9000_gpio_direction_output;
> +       data->gpio.get = ucd9000_gpio_get;
> +       data->gpio.set = ucd9000_gpio_set;

> +       data->gpio.can_sleep = 1;

Isn't it type of boolean?

> +       data->gpio.base = -1;

> +       data->gpio.parent = &client->dev;
> +       data->gpio.owner = THIS_MODULE;

> +       data->gpio.of_node = client->dev.of_node;

I think GPIO core does this for you.

> +       if (data->gpio.ngpio) {

Hmm...

I would rather reorganize the above part to a separate helper, like

static int ..._probe_gpio()
{
...
  switch () {
   default:
     return 0; /* GPIO part is optional */
  }
  return 0;
}

ret = _probe_gpio();
if (ret)
 dev_warn();

> +               ret = devm_gpiochip_add_data(&client->dev, &data->gpio,
> +                                            client);
> +               if (ret)
> +                       dev_warn(&client->dev, "Could not add gpiochip: %d\n",
> +                                ret);
> +       }
> +
>         return pmbus_do_probe(client, mid, info);
>  }
>
> --
> 1.8.3.1
>



-- 
With Best Regards,
Andy Shevchenko
