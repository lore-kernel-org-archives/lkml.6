Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88B3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7F021903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r9rV5fwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390041AbeLURJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:09:09 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55490 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729483AbeLURJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=OADIYH0Q3NtJ5r1rb+QbhZCW/KetXV5AxTQ4QMR6ioE=;
        b=r9rV5fwZRQS+u9SHR+wPUjGUOuipFnSn4DcxiSL/r+oRKVPbDufoQ2jQbF4toqgwbN9NLziSl4v5YihXBwXSGjTzwAuC6zPe2s266uZDyQskj21GZnM7X2zr6LIHRAO+X8ynXQEzn6aJmV6D9BPQ2HZg1yr3UgTPQj9CpfRVuMw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gaOIM-0003Lc-9l; Fri, 21 Dec 2018 18:09:06 +0100
Date:   Fri, 21 Dec 2018 18:09:06 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20181221170906.GE5023@lunn.ch>
References: <1545152036-23239-1-git-send-email-andrew@lunn.ch>
 <20181221143505.GQ13248@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221143505.GQ13248@dell>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +config MFD_TQMX86
> > +       tristate "TQ-Systems IO controller TQMX86"
> > +       select MFD_CORE
> > +       help
> > +	  Say yes here to enable support for various functions of the
> > +	  TQ-Systems IO controller and watchdog device, found on their
> > +	  ComExpress CPU modules

Hi Lee

Thanks for the comments. I will try to answer them the best i can.
I'm taking the vendor driver and trying to get it into mainline. So i
did not right this driver, i don't know all the details.

> > new file mode 100644
> > index 000000000000..4eca166db000
> > --- /dev/null
> > +++ b/drivers/mfd/tqmx86.c
> > @@ -0,0 +1,404 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * TQ-Systems PLD MFD core driver
> > + *
> > + * Copyright (c) 2015 TQ-Systems GmbH
> 
> Copyright is out of date.

That is the copyright on the vendor driver. I can add my copyright as
well, which will probably be 2019 i guess.

> > +#define I2C_KIND_SOFT	1	/* Ocores soft controller */
> > +#define I2C_KIND_HARD	2	/* Machxo2 hard controller */
> 
> What is a soft/hard controller?

I'm guessing here, but the hardware is implemented in an FPGA.  There
seems to be a few variants of it, some of which use the OpenCores I2C
bus controller. https://opencores.org/projects/i2c, which i assume is
synthesise as a soft core. The other implementation uses a Machxo2
FPGA which i assume has a hardware core for I2C.

The board i have has the soft i2c bus master.

> > +static uint gpio_irq;
> > +module_param(gpio_irq, uint, 0);
> > +MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (7, 9, 12)");
> 
> I have never seen anything like this.
> 
> This should be set by platform data, not a module parameter.

There is no platform data for this driver. It is loaded via matching
BIOS DMI strings. On x86 it seems like interrupt 7, 9, and 12 are
generally free for IO controllers to use. However, there has to be
some way to configure this, since they are not always available.  On
the board i have 9 is taken by acpi.

> > +static u8 i2c_irq_ctl[16] = {
> > +	[7] = 1,
> > +	[9] = 2,
> > +	[12] = 3
> > +};
> > +
> > +static u8 tqmx86_readb(struct tqmx86_device_data *pld, u32 off)
> > +{
> > +	return ioread8(pld->io_base + off);
> > +}
> > +
> > +static void tqmx86_writeb(struct tqmx86_device_data *pld, u8 val, u32 off)
> > +{
> > +	iowrite8(val, pld->io_base + off);
> > +}
> 
> Don't write needless abstraction layers.
> 
> Use the calls themselves.
> 
> Any reason for not using Regmap?

Notice this is ioread/iowrite, not readb/writeb. These are Intel x86
IO mapped registered, not MMIO registers. regmap does not support such
registers.

> > +enum tqmx86_cells {
> > +	TQMX86_I2C_SOFT = 0,
> > +	TQMX86_WDT,
> > +	TQMX86_GPIO,
> > +	TQMX86_UART,
> > +};
> > +	int i = 0;
> > +	u8 ioeic_val = 0;
> > +
> > +	ioeic_val |= (i2c_irq_ctl[gpio_irq] & 0x3) << 4;
> 
> What is IOEIC?

No idea. This is some sort of mapping from the internal interrupts
from the devices inside the FPGA to interrupts 7, 9 and 12. I'm
assuming this device is on the LPC bus, so it has access to the lower
interrupt numbers of an x86.

> The magic numbers should be defined (*_SHIFT/*_MASK)
> 
> Side note: If I have to ask this many questions, it normally means the
> code is not transparent enough.  There could be many reasons for this;
> variable/function nomenclature, code trying to be too clever or do too
> many things at once, coding style, data structure hacks, etc etc.
> 
> > +	dev_dbg(pld->dev, "ioeic %x\n", ioeic_val);
> 
> Are these really (still - after initial development) helpful to you?

They are never really helpful to me, since i've no documentation, and
i'm just reverse engineering the vendor driver :-)
 
> See other drivers to see how they handle optional cells.
> 
> > +	tqmx_gpio_resources[1].start = gpio_irq;
> 
> What about end?  This is a hack anyway.

Interrupt resources don't have an end. An interrupt is a single
value. But i'm not sure there is a better way to do this.

> > +static int tqmx86_create_platform_device(const struct dmi_system_id *id)
> 
> > +static struct attribute *pld_attributes[] = {
> > +	&dev_attr_board_id.attr,
> > +	&dev_attr_board_rev.attr,
> > +	&dev_attr_pld_rev.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group pld_attr_group = {
> > +	.attrs = pld_attributes,
> > +};
> 
> What are you using sysfs for that requires this information?

I'm not using it at all. The vendor however must think it is useful.
I can remove it.

> > +	pld->info.board_id = board_id;
> > +	pld->info.board_rev = rev >> 4;
> > +	pld->info.pld_rev = rev & 0xf;
> > +
> > +	i2c_det = tqmx86_readb(pld, TQMX86_I2C_DET);
> > +	i2c_ien = tqmx86_readb(pld, TQMX86_I2C_IEN);
> 
> What are these values?

I assume TQMX86_I2C_DET is some sort of identifier or ID for the FPGA.
So a basic sanity check the device really is what we are trying to
find. I assume TQMX86_I2C_IEN is about interrupt enable, but i don't
know.

> More unreadable magic numbers.
> 
> > +		pld->info.i2c_type = I2C_KIND_SOFT;
> > +	else
> > +		pld->info.i2c_type = I2C_KIND_HARD;
> 
> What are these?

The soft I2C device does not support interrupts. That seems to be how
they decided to use the soft ocores driver, or the hard i2c driver
which i'm not mainlining, because i don't have the hardware. Of the
list of devices this driver supports, i've no idea which have soft and
which have hard. So i'm leaving this dynamic detection here.
 
> > +	pld->io_base = devm_ioport_map(dev, ioport->start,
> > +				       resource_size(ioport));
> 
> This is used very little in the kernel.

Correct, because there are few Intel IO drivers using Intel IO
registers. Most tend to platform IO drivers, so serial ports, watchdog
timers, GPIO, etc.

> What is it you're trying to do here?

You are supposed to map the IO registers, just to make sure there are
no overlaps between drivers. The driver name will then appear in
/proc/ioport,

> Is Regmap a better alternative?  Take a look at some other MFD drivers.

For example kempld-core.c, asic3.c. I think this driver has been
somewhat modelled on kempld-core.c. It also uses the same platform
device structure.

Thanks
       Andrew

