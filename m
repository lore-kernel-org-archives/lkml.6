Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B234FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D10021564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D10021564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeHXQOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:14:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47757 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbeHXQOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:14:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C8B7322A39; Fri, 24 Aug 2018 14:39:46 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1B60B206DE;
        Fri, 24 Aug 2018 14:39:36 +0200 (CEST)
Date:   Fri, 24 Aug 2018 14:39:34 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     vitor <Vitor.Soares@synopsys.com>, <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>
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
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180824143934.6d6b6487@bbrezillon>
In-Reply-To: <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
        <20180719152930.3715-2-boris.brezillon@bootlin.com>
        <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitor,

On Wed, 22 Aug 2018 17:43:34 +0100
vitor <Vitor.Soares@synopsys.com> wrote:

> Hi Boris,
> 
> 
> On 19-07-2018 16:29, Boris Brezillon wrote:
> > +int i3c_bus_register(struct i3c_bus *i3cbus)
> > +{
> > +	struct i2c_dev_desc *desc;
> > +
> > +	i3c_bus_for_each_i2cdev(i3cbus, desc) {
> > +		switch (desc->boardinfo->lvr & I3C_LVR_I2C_INDEX_MASK) {
> > +		case I3C_LVR_I2C_INDEX(0):
> > +			if (i3cbus->mode < I3C_BUS_MODE_MIXED_FAST)
> > +				i3cbus->mode = I3C_BUS_MODE_MIXED_FAST;
> > +			break;
> > +
> > +		case I3C_LVR_I2C_INDEX(1):
> > +		case I3C_LVR_I2C_INDEX(2):
> > +			if (i3cbus->mode < I3C_BUS_MODE_MIXED_SLOW)
> > +				i3cbus->mode = I3C_BUS_MODE_MIXED_SLOW;
> > +			break;
> > +
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	if (!i3cbus->scl_rate.i3c)
> > +		i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
> > +
> > +	if (!i3cbus->scl_rate.i2c) {
> > +		if (i3cbus->mode == I3C_BUS_MODE_MIXED_SLOW)
> > +			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
> > +		else
> > +			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
> > +	}
> > +
> > +	/*
> > +	 * I3C/I2C frequency may have been overridden, check that user-provided
> > +	 * values are not exceeding max possible frequency.
> > +	 */
> > +	if (i3cbus->scl_rate.i3c > I3C_BUS_MAX_I3C_SCL_RATE ||
> > +	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_RATE) {
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_set_name(&i3cbus->dev, "i3c-%d", i3cbus->id);
> > +
> > +	return device_add(&i3cbus->dev);
> > +}  
> During the tests of the bus with i2c devices I found the i2c_dev_desc 
> objects aren't allocated before this function. This cause i3cbus->mode = 
> I3C_BUS_MODE_PURE.

I just checked and DT parsing (+ I2C descs creation) is done before
i3c_bus_register() is called, so we should be good. How did you declare
your I2C devices (right now, only DT declaration is supported).

> 
> I want to do something for the slave and secondary master, do you 
> already have infrastructure that you can share?

What do you mean?

Regards,

Boris
