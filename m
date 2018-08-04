Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB1DC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 05:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF2F2178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 05:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF2F2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeHDHd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 03:33:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:32947 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbeHDHdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 03:33:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 472622074F; Sat,  4 Aug 2018 07:33:59 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 81276206A8;
        Sat,  4 Aug 2018 07:33:58 +0200 (CEST)
Date:   Sat, 4 Aug 2018 07:33:58 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     <mshettel@codeaurora.org>
Cc:     "'Wolfram Sang'" <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        "'Jonathan Corbet'" <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Arnd Bergmann'" <arnd@arndb.de>,
        "'Przemyslaw Sroka'" <psroka@cadence.com>,
        "'Arkadiusz Golec'" <agolec@cadence.com>,
        "'Alan Douglas'" <adouglas@cadence.com>,
        "'Bartosz Folta'" <bfolta@cadence.com>,
        "'Damian Kos'" <dkos@cadence.com>,
        "'Alicja Jurasik-Urbaniak'" <alicja@cadence.com>,
        "'Cyprian Wronka'" <cwronka@cadence.com>,
        "'Suresh Punnoose'" <sureshp@cadence.com>,
        "'Rafal Ciepiela'" <rafalc@cadence.com>,
        "'Thomas Petazzoni'" <thomas.petazzoni@bootlin.com>,
        "'Nishanth Menon'" <nm@ti.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Pawel Moll'" <pawel.moll@arm.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Ian Campbell'" <ijc+devicetree@hellion.org.uk>,
        "'Kumar Gala'" <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Vitor Soares'" <Vitor.Soares@synopsys.com>,
        "'Geert Uytterhoeven'" <geert@linux-m68k.org>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        "'Xiang Lin'" <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>, "'Sekhar Nori'" <nsekhar@ti.com>,
        "'Przemyslaw Gaj'" <pgaj@cadence.com>,
        "'Peter Rosin'" <peda@axentia.se>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180804073358.7c5cf3a0@bbrezillon>
In-Reply-To: <023901d42b72$5bc329d0$13497d70$@codeaurora.org>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
        <20180719152930.3715-2-boris.brezillon@bootlin.com>
        <023901d42b72$5bc329d0$13497d70$@codeaurora.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Fri, 3 Aug 2018 15:38:43 -0600
<mshettel@codeaurora.org> wrote:

> > +static void
> > +i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
> > +{
> > +	struct i3c_dev_desc *desc;
> > +	int ret;
> > +
> > +	if (!master->init_done)
> > +		return;
> > +
> > +	i3c_bus_for_each_i3cdev(master->bus, desc) {
> > +		if (desc->dev || !desc->info.dyn_addr)
> > +			continue;
> > +
> > +		desc->dev = kzalloc(sizeof(*desc->dev), GFP_KERNEL);
> > +		if (!desc->dev)
> > +			continue;
> > +
> > +		desc->dev->bus = master->bus;
> > +		desc->dev->desc = desc;
> > +		desc->dev->dev.parent = &master->bus->dev;
> > +		if (desc == master->this)
> > +			desc->dev->dev.type = &i3c_master_type;
> > +		else
> > +			desc->dev->dev.type = &i3c_device_type;
> > +		desc->dev->dev.bus = &i3c_bus_type;
> > +		desc->dev->dev.release = i3c_device_release;
> > +		dev_set_name(&desc->dev->dev, "%d-%llx", master->bus-  
> > >id,  
> > +			     desc->info.pid);
> > +
> > +		if (desc->boardinfo)
> > +			desc->dev->dev.of_node = desc->boardinfo-  
> > >of_node;  
> > +
> > +		pr_info("%s:%i\n", __func__, __LINE__);
> > +		if (ret)
> > +			dev_err(master->parent,
> > +				"Failed to add I3C device (err = %d)\n",  
> ret);
> > +	}
> > +}  
> 
> The compiler gives a warning that "ret" may be used uninitialized in the
> above function, which is true since "ret" is never assigned a value.  Also,
> I wonder about the "pr_info" call here, should there be a more detailed
> message here about the device being registered, other than the file name and
> line number?

Yes, kbuild already reported that problem. I messed up when selecting
the lines to add to my commit and added this trace instead of

		ret = device_register(&desc->dev->dev);

Will be fixed in v7.

> 
> Otherwise, I have gone through the code in the process of writing the first
> iteration of the Qualcomm I3C master driver, and overall the framework looks
> good.  Will update with any additional feedback I have.

Thanks for looking at the framework code. Your driver is in my TODO
list.

Regards,

Boris
