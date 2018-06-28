Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5AFC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EE8279C4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EE8279C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933594AbeF1VC4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:02:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34086 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753042AbeF1VCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:02:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9517620733; Thu, 28 Jun 2018 23:02:50 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id A9CA9206A6;
        Thu, 28 Jun 2018 23:02:38 +0200 (CEST)
Date:   Thu, 28 Jun 2018 23:02:37 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     vitor <Vitor.Soares@synopsys.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH v5 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180628230237.7728a9bf@bbrezillon>
In-Reply-To: <088dc947-da66-cec9-44a8-0f1097690bfd@synopsys.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
        <20180622104930.32050-2-boris.brezillon@bootlin.com>
        <088dc947-da66-cec9-44a8-0f1097690bfd@synopsys.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitor,

On Thu, 28 Jun 2018 16:38:56 +0100
vitor <Vitor.Soares@synopsys.com> wrote:

> Hi Boris,
> 
> 
> On 22-06-2018 11:49, Boris Brezillon wrote:
> > +static int of_i3c_master_add_i3c_dev(struct i3c_master_controller *master,
> > +				     struct device_node *node, u32 *reg)
> > +{
> > +	struct i3c_device_info info = { };
> > +	enum i3c_addr_slot_status addrstatus;
> > +	struct i3c_device *i3cdev;
> > +	u32 init_dyn_addr = 0;
> > +
> > +	if (reg[0]) {
> > +		if (reg[0] > I3C_MAX_ADDR)
> > +			return -EINVAL;
> > +
> > +		addrstatus = i3c_bus_get_addr_slot_status(master->bus, reg[0]);
> > +		if (addrstatus != I3C_ADDR_SLOT_FREE)
> > +			return -EINVAL;
> > +	}
> > +
> > +	info.static_addr = reg[0];
> > +
> > +	if (!of_property_read_u32(node, "assigned-address", &init_dyn_addr)) {
> > +		if (init_dyn_addr > I3C_MAX_ADDR)
> > +			return -EINVAL;
> > +
> > +		addrstatus = i3c_bus_get_addr_slot_status(master->bus,
> > +							  init_dyn_addr);
> > +		if (addrstatus != I3C_ADDR_SLOT_FREE)
> > +			return -EINVAL;
> > +	}
> > +
> > +	info.pid = ((u64)reg[1] << 32) | reg[2];
> > +
> > +	if ((info.pid & GENMASK_ULL(63, 48)) ||
> > +	    I3C_PID_RND_LOWER_32BITS(info.pid))
> > +		return -EINVAL;
> > +
> > +	i3cdev = i3c_master_alloc_i3c_dev(master, &info, &i3c_device_type);
> > +	if (IS_ERR(i3cdev))
> > +		return PTR_ERR(i3cdev);
> > +
> > +	i3cdev->init_dyn_addr = init_dyn_addr;
> > +	i3cdev->dev.of_node = node;
> > +	list_add_tail(&i3cdev->common.node, &master->bus->devs.i3c);
> > +
> > +	return 0;
> > +}
> > +  
> 
> I'm writing the driver for the Synopsys master and but now I getting an 
> issue.
> 
> I use the "slot" of the device to do all transfers, something like you 
> use in DAA. I using the master_priv to save the "slot" per device but 
> the problem is when I call the i3c_master_add_i3c_dev_locked() to 
> retrieve the info I don't have it yet.

Hm, I knew that might become a problem at some point. The Cadence IP
does not need the slot index because it works with addresses and
figure the device slot out of this address, but it looks like others
don't go this road. 

> 
>  From my analysis this can be solve with:
>      - send PID, BCR and DCR when I call i3c_master_add_i3c_dev_locked() 
> or similar function.

Except these are not the only thing we retrieve before attaching the
device. Also, if we go this road, that means we don't have the same path
for devices whose dynamic address is assigned through SETDASA, and those
that are discovered using DAA.

>      - Pre-allocate an i3c_device -> attach it (slot data goes to 
> master_priv) -> retrieve info -> if there is already an i3c_device with 
> same PID destroy the pre-allocated one.

That's the very reason I didn't go this road. It gets messy if we
already know this device. This being said, among all the options you
list here, this is the one I prefer. Let's see if we can standardize
the resource allocation/free process and let ->attach/detach() only
take care of the device/bus configuration.

>      - Replace the info.dyn_address with a structure with dyn_address 
> and slot and use it in CCC structure.

I'd really like to keep the device-slot-id a priv information, because
we don't know how other IPs will deal with I3C device resources.

> 
> This is something that will need to be supported for I3C HCI spec too. 

I agree.

> Do you have any suggestion?

I'll try to come up with something. Need to think a bit more about it.

Thanks,

Boris
