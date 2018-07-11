Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5EEC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C06C20881
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C06C20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbeGKPII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:08:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58260 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732605AbeGKPII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:08:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8400F20766; Wed, 11 Jul 2018 17:03:21 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id DDDE52072C;
        Wed, 11 Jul 2018 17:03:20 +0200 (CEST)
Date:   Wed, 11 Jul 2018 17:03:20 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180711170320.5b2b0114@bbrezillon>
In-Reply-To: <20180711164120.3e32fb08@bbrezillon>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-2-boris.brezillon@bootlin.com>
        <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
        <20180711164120.3e32fb08@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 16:41:20 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> > > +/**
> > > + * i3cdev_to_dev() - Returns the device embedded in @i3cdev
> > > + * @i3cdev: I3C device
> > > + *
> > > + * Return: a pointer to a device object.
> > > + */
> > > +struct device *i3cdev_to_dev(struct i3c_device *i3cdev)
> > > +{
> > > +       return &i3cdev->dev;
> > > +}
> > > +EXPORT_SYMBOL_GPL(i3cdev_to_dev);
> > > +
> > > +/**
> > > + * dev_to_i3cdev() - Returns the I3C device containing @dev
> > > + * @dev: device object
> > > + *
> > > + * Return: a pointer to an I3C device object.
> > > + */
> > > +struct i3c_device *dev_to_i3cdev(struct device *dev)
> > > +{
> > > +       return container_of(dev, struct i3c_device, dev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(dev_to_i3cdev);    
> > 
> > Many other subsystems just make the device structure available
> > to all client drivers so this can be an inline operation. Is there
> > a strong reason to hide it here?  
> 
> No, but I think most subsystem do provide dev_to_xxxdev() at least
> (to_platform_device() for instance)
> 

My bad. I misunderstood you question. The main reason I did that was
because I didn't want to expose i3c_device internals to the I3C device
drivers. Anyway, this part will be reworked in my v6 to address one
problem we had when re-attaching a pre-existing device that had lost
its dynamic address and acquired a new one.
Since we want that operation to be transparent to I3C device drivers, I
had to decouple the I3C device driver representation from the I3C master
controller one. I thus end up with struct i3C_dev_desc on the controller
API side, and struct i3c_device on the driver side with a link between
the 2 object that can be updated at runtime. And as you can imagine,
i3c_device does not contain a lot of information now.
