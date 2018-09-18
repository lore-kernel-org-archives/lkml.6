Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB3BECE566
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D098F2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D098F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeIRMbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:31:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59888 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbeIRMbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:31:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A3B312071D; Tue, 18 Sep 2018 09:00:03 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id E4C7320703;
        Tue, 18 Sep 2018 09:00:02 +0200 (CEST)
Date:   Tue, 18 Sep 2018 09:00:02 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     vitor <Vitor.Soares@synopsys.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        "Alicja Jurasik-Urbaniak" <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "Rafal Ciepiela" <rafalc@cadence.com>,
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
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v7 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180918090002.2e4012e6@bbrezillon>
In-Reply-To: <aa29faa0-237c-3875-64da-b93a1e87ccff@synopsys.com>
References: <20180905154108.20770-1-boris.brezillon@bootlin.com>
        <20180905154108.20770-2-boris.brezillon@bootlin.com>
        <aa29faa0-237c-3875-64da-b93a1e87ccff@synopsys.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitor,

Sorry for the late reply, I was not at the office last week.

On Tue, 11 Sep 2018 11:04:07 +0100
vitor <Vitor.Soares@synopsys.com> wrote:

> Hi Boris,
> 
> On 05-09-2018 16:40, Boris Brezillon wrote:
> > +i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
> > +{
> > +	struct i3c_dev_desc *desc;
> > +	int ret;
> > +
> > +	if (!master->init_done)
> > +		return;
> > +  
> If you have a hot-join and call i3c_master_do_daa this function will 
> return without create the i3c_device.

Hm, you mean if hot-join happens when the I3C master is not yet
registered? That shouldn't be a problem since all devices will be
registered at the end of i3c_master_register(). Am I missing something?
Is this a problem you actually face or just something you found out
doing code inspection?

> 
> > +	i3c_bus_for_each_i3cdev(master->bus, desc) {
> > +		if (desc->dev || !desc->info.dyn_addr || desc == master->this)
> > +			continue;
> > +
> > +		desc->dev = kzalloc(sizeof(*desc->dev), GFP_KERNEL);
> > +		if (!desc->dev)
> > +			continue;
> > +
> > +		desc->dev->bus = master->bus;
> > +		desc->dev->desc = desc;
> > +		desc->dev->dev.parent = &master->bus->dev;
> > +		desc->dev->dev.type = &i3c_device_type;
> > +		desc->dev->dev.bus = &i3c_bus_type;
> > +		desc->dev->dev.release = i3c_device_release;
> > +		dev_set_name(&desc->dev->dev, "%d-%llx", master->bus->id,
> > +			     desc->info.pid);
> > +
> > +		if (desc->boardinfo)
> > +			desc->dev->dev.of_node = desc->boardinfo->of_node;
> > +
> > +		ret = device_register(&desc->dev->dev);
> > +		if (ret)
> > +			dev_err(master->parent,
> > +				"Failed to add I3C device (err = %d)\n", ret);
> > +	}
> > +}

Regards,

Boris
