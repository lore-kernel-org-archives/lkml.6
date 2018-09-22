Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C66BECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB772154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+ljU4lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB772154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbeIVVQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 17:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbeIVVQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 17:16:15 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87B36214C1;
        Sat, 22 Sep 2018 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537629739;
        bh=yWd6Jw6Y5R2i7t11jmG8eg/0oaxFxQ+Q7YNZ8I0PjRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K+ljU4lbM/OsL7pX1GPQ7A2pbjC+DRjBK4PFMkOTV2K9fNN10FWwlLhk1M52oH8u/
         INsdFCCcdHzaCOhXDcIufox828OuYa0idPmLA2zotbzMBGqipUt7sxWmnPhwrq99wf
         IBTiNTAePYPwWHmYrGYIDsiJ4f8kpVYkG9SOf/gY=
Date:   Sat, 22 Sep 2018 16:22:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     r yang <decatf@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: bh1750: Add device tree support
Message-ID: <20180922162214.68682a71@archlinux>
In-Reply-To: <20180918015733.GA19976@r>
References: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
        <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
        <20180916104526.2c386591@archlinux>
        <20180918015733.GA19976@r>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018 21:57:33 -0400
r yang <decatf@gmail.com> wrote:

> On Sun, Sep 16, 2018 at 10:45:26AM +0100, Jonathan Cameron wrote:
> > On Sat, 15 Sep 2018 13:42:14 -0400
> > ryang <decatf@gmail.com> wrote:
> >   
> > > Add device tree support for ROHM BH1750 series ambient light sensors.
> > > 
> > > Signed-off-by: ryang <decatf@gmail.com>  
> > Just to check, how is it picking up on the enum value which is provided
> > in the i2c_device_id entries?
> > 
> > i.e. What is setting id->driver_data in the probe?
> > There may be something in the i2c core that I'm missing that will do the
> > association but I don't remember anything trying to do this.
> > 
> > Jonathan
> >  
> 
> I've looked through it and it is indeed in the i2c core.
> The i2c core probe function picks the id entry based on the i2c client
> name.
> 
> The i2c client name is assigned based on the device tree compatible
> string.
> 
>   of_i2c_register_device()
>     of_i2c_get_board_info()
>       of_modalias_node()
> 
> During probe the i2c_device_id is picked by matching the i2c
> client->name to i2c_device_id->name in the i2c_match_id() function.
> 
>   i2c_device_probe()
>     driver->probe(client, i2c_match_id(driver->id_table, client));
> 
Great!  Thanks for tracking that down.  I'll pick this up once
you've added the MODULE_DEVICE_TABLE as Tomasz suggested.


> I've tested this on device. It's Samsung Galaxy Tab 10.1. It has a
> BH1721.
> 
> > > ---
> > >  drivers/iio/light/bh1750.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> > > index a814828e69f5..50b599abb383 100644
> > > --- a/drivers/iio/light/bh1750.c
> > > +++ b/drivers/iio/light/bh1750.c
> > > @@ -315,9 +315,19 @@ static const struct i2c_device_id bh1750_id[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, bh1750_id);
> > >  
> > > +static const struct of_device_id bh1750_of_match[] = {
> > > +	{ .compatible = "rohm,bh1710", },
> > > +	{ .compatible = "rohm,bh1715", },
> > > +	{ .compatible = "rohm,bh1721", },
> > > +	{ .compatible = "rohm,bh1750", },
> > > +	{ .compatible = "rohm,bh1751", },
> > > +	{ }
> > > +};
> > > +
> > >  static struct i2c_driver bh1750_driver = {
> > >  	.driver = {
> > >  		.name = "bh1750",
> > > +		.of_match_table = of_match_ptr(bh1750_of_match),
> > >  		.pm = BH1750_PM_OPS,
> > >  	},
> > >  	.probe = bh1750_probe,  
> >   

