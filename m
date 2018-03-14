Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeCNSzs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:55:48 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43453 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeCNSzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:55:45 -0400
X-Google-Smtp-Source: AG47ELvtf5S0AMOF3zKzVkoGJZjlRbDP8yL16Q43RrOuuEjI8klY2VVa9WrN2/PaVnBdo/GrR+5Ybw==
Date: Wed, 14 Mar 2018 11:55:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Eddie James <eajames@linux.vnet.ibm.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH v2 1/2] hwmon: (ucd9000) Add gpio chip interface
Message-ID: <20180314185542.GA23989@roeck-us.net>
References: <1520974749-5372-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1520974749-5372-2-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75VdOzzmN=6K4H3rVGGaqMJ+q+nXnoY=qksNT6uvHnG6CAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdOzzmN=6K4H3rVGGaqMJ+q+nXnoY=qksNT6uvHnG6CAQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 11:13:04PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 13, 2018 at 10:59 PM, Eddie James
> <eajames@linux.vnet.ibm.com> wrote:
> > From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> >
> > Add a struct gpio_chip and define some methods so that this device's
> > I/O can be accessed via /sys/class/gpio.
> 
> > +       /*
> > +        * Note:
> > +        *
> > +        * Pinmux support has not been added to the new gpio_chip.
> > +        * This support should be added when possible given the mux
> > +        * behavior of these IO devices.
> > +        */
> 
> > +       data->gpio.label = (const char *)&client->name;
> 
> Hmm... Why do you need this casting?
> 
> > +       data->gpio.get_direction = ucd9000_gpio_get_direction;
> > +       data->gpio.direction_input = ucd9000_gpio_direction_input;
> > +       data->gpio.direction_output = ucd9000_gpio_direction_output;
> > +       data->gpio.get = ucd9000_gpio_get;
> > +       data->gpio.set = ucd9000_gpio_set;
> 
> > +       data->gpio.can_sleep = 1;
> 
> Isn't it type of boolean?
> 
You are right.

> > +       data->gpio.base = -1;
> 
> > +       data->gpio.parent = &client->dev;
> > +       data->gpio.owner = THIS_MODULE;
> 
> > +       data->gpio.of_node = client->dev.of_node;
> 
> I think GPIO core does this for you.
> 
Same here. I checked and found that it also sets the owner, so maybe this can be
dropped as well.

> > +       if (data->gpio.ngpio) {
> 
> Hmm...
> 
> I would rather reorganize the above part to a separate helper, like
> 
> static int ..._probe_gpio()
> {
> ...
>   switch () {
>    default:
>      return 0; /* GPIO part is optional */
>   }
>   return 0;
> }
> 
> ret = _probe_gpio();
> if (ret)
>  dev_warn();
> 

I am neutral to positiva on that.
Might as well add the call to devm_gpiochip_add_data()
into that function as well.

> > +               ret = devm_gpiochip_add_data(&client->dev, &data->gpio,
> > +                                            client);
> > +               if (ret)
> > +                       dev_warn(&client->dev, "Could not add gpiochip: %d\n",
> > +                                ret);
> > +       }
> > +
> >         return pmbus_do_probe(client, mid, info);
> >  }
> >
> > --
> > 1.8.3.1
> >
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
