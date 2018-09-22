Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01EAC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A92C2154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uojjWvdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A92C2154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeIVViV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 17:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbeIVViV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 17:38:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BE86206B7;
        Sat, 22 Sep 2018 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537631060;
        bh=q4PX/MII+KI/bLLnq93ambLvI7oQ56v7d1lW4fGti8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uojjWvdc/6egO6BEBpY4W/Xfi+F0ttxrOy8jneFiG9UorWpU+/JTA5wqNFXPGhfzs
         aXRVZdBdHO5WG5U7QsR4z92lMYsrO3MtjXL6SbBKjHrsw+9/Qjlij2AN8o/ZRsLHxF
         YNI3eQnIputrLW3zhP8p8k9EVBGrntkyyw1Aalyo=
Date:   Sat, 22 Sep 2018 16:44:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iio: proximity: Add driver support for ST's
 VL53L0X ToF ranging sensor.
Message-ID: <20180922164415.67a55cb2@archlinux>
In-Reply-To: <20180922152621.GA953@Eros>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
        <20180922154658.752f2fbf@archlinux>
        <20180922152621.GA953@Eros>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2018 23:28:04 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On Sat, Sep 22, 2018 at 03:46:58PM +0100, Jonathan Cameron wrote:
> > On Tue, 18 Sep 2018 16:24:21 +0800
> > Song Qiang <songqiang1304521@gmail.com> wrote:
> >   
> > > This driver was originally written by ST in 2016 as a misc input device
> > > driver, and hasn't been maintained for a long time. I grabbed some code
> > > from it's API and reformed it into an iio proximity device driver.
> > > This version of driver uses i2c bus to talk to the sensor and
> > > polling for measuring completes, so no irq line is needed.
> > > It can be tested with reading from
> > > /sys/bus/iio/devices/iio:deviceX/in_distance_input
> > > 
> > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>  
> > There are a few bits and bobs in here, but as they are all minor and
> > one at least was me giving you wrong advise, I've fixed it up.
> > 
> > Please check I haven't made a mess of it! 
> > 
> > Applied with changes to the togreg branch of iio.git and pushed out
> > as testing (where it should be visible now) for the autobuilders to
> > play with it.
> > 
> > Thanks,
> > 
> > Jonathan  
> > > ---  
> 
> > > +	indio_dev->name = "vl53l0x";
> > > +	indio_dev->info = &vl53l0x_info;
> > > +	indio_dev->channels = vl53l0x_channels;
> > > +	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
> > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > +
> > > +	return devm_iio_device_register(&client->dev, indio_dev);
> > > +}
> > > +
> > > +static const struct of_device_id st_vl53l0x_dt_match[] = {
> > > +	{ .compatible = "st,vl53l0x-i2c", },  
> > 
> > Ah, this suffers from the same thing that was picked up in a driver
> > you sent later in the week.  No need to have -i2c in the compatible
> > as this is clear from the bus type.
> > 
> > (I might just fix this up).
> >   
> 
> Hi Jonathan,
> 
> Sorry for the newbie mistakes you and Himanshu pointed out, I'm just
> writing them down on my little checklist!
> I just checked the code, found that this compatible string was not
> getting corrected in the DT binding doc file, sorry that you have
> to help correct my mistakes, thanks a lot!
Fixed up (and this was my mistake - we all make them - that's what review
is for!)

Thanks,

Jonathan
> 
> yours,
> Song Qiang
> 
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, st_vl53l0x_dt_match);
> > > +
> > > +static struct i2c_driver vl53l0x_driver = {
> > > +	.driver = {
> > > +		.name = "vl53l0x-i2c",
> > > +		.of_match_table = st_vl53l0x_dt_match,
> > > +	},
> > > +	.probe_new = vl53l0x_probe,
> > > +};
> > > +module_i2c_driver(vl53l0x_driver);
> > > +
> > > +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> > > +MODULE_DESCRIPTION("ST vl53l0x ToF ranging sensor driver");
> > > +MODULE_LICENSE("GPL v2");  
> >   

