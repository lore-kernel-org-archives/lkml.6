Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeFDXdy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:33:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:43400 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeFDXdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:33:53 -0400
Message-ID: <414b097e5b8d828ef6dd536e819c2cfab5011912.camel@kernel.crashing.org>
Subject: Re: [PATCH v9 3/7] i2c: fsi: Add port structures
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 05 Jun 2018 09:33:01 +1000
In-Reply-To: <CAHp75VfMsL3rBMT-SMcSCyuQd2YMexXqkrb=zBYEq0=MO=zHNA@mail.gmail.com>
References: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com>
         <1528138850-18259-4-git-send-email-eajames@linux.vnet.ibm.com>
         <CAHp75VfMsL3rBMT-SMcSCyuQd2YMexXqkrb=zBYEq0=MO=zHNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-04 at 22:17 +0300, Andy Shevchenko wrote:
> 
> > +static int fsi_i2c_remove(struct device *dev)
> > +{
> > +       struct fsi_i2c_master *i2c = dev_get_drvdata(dev);
> > +       struct fsi_i2c_port *port;
> > +
> > +       list_for_each_entry(port, &i2c->ports, list) {
> > +               i2c_del_adapter(&port->adapter);
> > +               kfree(port);
> > +       }
> 
> Just to be sure, it will be called if and only if all adapters are not
> busy. Correct?

Actually i2c_del_adapter() will do the right thing. It even waits until
the embedded struct device has been fully released.

As indicated by the comment in there, it should all be turned into
something a bit better, but this is what the i2c layer gives us today.

> > +
> > +       return 0;
> > +}
> > +
> >  static const struct fsi_device_id fsi_i2c_ids[] = {
> >         { FSI_ENGID_I2C, FSI_VERSION_ANY },
> >         { 0 }
> > @@ -224,6 +313,7 @@ static int fsi_i2c_probe(struct device *dev)
> >                 .name = "i2c-fsi",
> >                 .bus = &fsi_bus_type,
> >                 .probe = fsi_i2c_probe,
> > +               .remove = fsi_i2c_remove,
> >         },
> >  };
> > 
> > --
> > 1.8.3.1
> > 
> 
> 
> 
