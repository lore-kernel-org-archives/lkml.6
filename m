Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB35C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 19:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE7320C0F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 19:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jivUtbHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE7320C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeHSWa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 18:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeHSWa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 18:30:29 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BDF920C0C;
        Sun, 19 Aug 2018 19:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534706276;
        bh=mRsRPA6Tpd3bJlq51o3UbNTJMEdp8MLKH9uFc5Y6qZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jivUtbHoJKc0yiysVM1zsRxKAURZvrhn/+1glOBij2qMrGEVOO/5bZ3NaAun4jI0y
         WRFfS64yXawXu6RCkhdk73E3siPnxMQkEw9ehbZfTeIa3/COqaggsJKgIWLmoARnSw
         a4Pq0U3SPEhIqmwBZ51IP96vNLfFdAv8S7A4qVW8=
Date:   Sun, 19 Aug 2018 20:17:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 3/3] iio: potentiometer: merge calls to of_match_device
 and of_device_get_match_data
Message-ID: <20180819201752.2280be76@archlinux>
In-Reply-To: <0a8aff9e-51fe-96a5-bcab-cc472be92dcc@axentia.se>
References: <1526896150-27134-1-git-send-email-Julia.Lawall@lip6.fr>
        <1526896150-27134-4-git-send-email-Julia.Lawall@lip6.fr>
        <0a8aff9e-51fe-96a5-bcab-cc472be92dcc@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Aug 2018 09:02:42 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-05-21 11:49, Julia Lawall wrote:
> > Drop call to of_match_device, which is subsumed by the subsequent
> > call to of_device_get_match_data.  The code becomes simpler, and a
> > temporary variable can be dropped.
> > 
> > The semantic match that makes this change is as follows:
> > (http://coccinelle.lip6.fr/)
> > 
> > // <smpl>
> > @r@
> > local idexpression match;
> > identifier i;
> > expression x, dev, e, e1;
> > @@
> > -        match@i = of_match_device(x, dev);
> > -        if (match) e = of_device_get_match_data(dev);
> > -        else e = e1;
> > +        e = of_device_get_match_data(dev);
> > +        if (!e) e = e1;
> > 
> > @@
> > identifier r.i;
> > @@
> > - const struct of_device_id *i;
> > ... when != i
> > // </smpl>
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>  
> 
> Reviewed-by: Peter Rosin <peda@axentia.se>

Applied to the togreg branch of iio.git.

Glad you replied to this one Peter, it had definitely dropped through the cracks.

Jonathan
> 
> Cheers,
> Peter
> 
> > 
> > ---
> >  drivers/iio/potentiometer/max5481.c |    7 ++-----
> >  drivers/iio/potentiometer/mcp4018.c |    7 ++-----
> >  drivers/iio/potentiometer/mcp4531.c |    7 ++-----
> >  3 files changed, 6 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
> > index 320a7c9..c051ee0 100644
> > --- a/drivers/iio/potentiometer/mcp4018.c
> > +++ b/drivers/iio/potentiometer/mcp4018.c
> > @@ -147,7 +147,6 @@ static int mcp4018_probe(struct i2c_client *client)
> >  	struct device *dev = &client->dev;
> >  	struct mcp4018_data *data;
> >  	struct iio_dev *indio_dev;
> > -	const struct of_device_id *match;
> >  
> >  	if (!i2c_check_functionality(client->adapter,
> >  				     I2C_FUNC_SMBUS_BYTE)) {
> > @@ -162,10 +161,8 @@ static int mcp4018_probe(struct i2c_client *client)
> >  	i2c_set_clientdata(client, indio_dev);
> >  	data->client = client;
> >  
> > -	match = of_match_device(of_match_ptr(mcp4018_of_match), dev);
> > -	if (match)
> > -		data->cfg = of_device_get_match_data(dev);
> > -	else
> > +	data->cfg = of_device_get_match_data(dev);
> > +	if (!data->cfg)
> >  		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)->driver_data];
> >  
> >  	indio_dev->dev.parent = dev;
> > diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
> > index df894af..d87ca85 100644
> > --- a/drivers/iio/potentiometer/mcp4531.c
> > +++ b/drivers/iio/potentiometer/mcp4531.c
> > @@ -360,7 +360,6 @@ static int mcp4531_probe(struct i2c_client *client)
> >  	struct device *dev = &client->dev;
> >  	struct mcp4531_data *data;
> >  	struct iio_dev *indio_dev;
> > -	const struct of_device_id *match;
> >  
> >  	if (!i2c_check_functionality(client->adapter,
> >  				     I2C_FUNC_SMBUS_WORD_DATA)) {
> > @@ -375,10 +374,8 @@ static int mcp4531_probe(struct i2c_client *client)
> >  	i2c_set_clientdata(client, indio_dev);
> >  	data->client = client;
> >  
> > -	match = of_match_device(of_match_ptr(mcp4531_of_match), dev);
> > -	if (match)
> > -		data->cfg = of_device_get_match_data(dev);
> > -	else
> > +	data->cfg = of_device_get_match_data(dev);
> > +	if (!data->cfg)
> >  		data->cfg = &mcp4531_cfg[i2c_match_id(mcp4531_id, client)->driver_data];
> >  
> >  	indio_dev->dev.parent = dev;
> > diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
> > index ffe2761..6d2f13f 100644
> > --- a/drivers/iio/potentiometer/max5481.c
> > +++ b/drivers/iio/potentiometer/max5481.c
> > @@ -137,7 +137,6 @@ static int max5481_probe(struct spi_device *spi)
> >  	struct iio_dev *indio_dev;
> >  	struct max5481_data *data;
> >  	const struct spi_device_id *id = spi_get_device_id(spi);
> > -	const struct of_device_id *match;
> >  	int ret;
> >  
> >  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> > @@ -149,10 +148,8 @@ static int max5481_probe(struct spi_device *spi)
> >  
> >  	data->spi = spi;
> >  
> > -	match = of_match_device(of_match_ptr(max5481_match), &spi->dev);
> > -	if (match)
> > -		data->cfg = of_device_get_match_data(&spi->dev);
> > -	else
> > +	data->cfg = of_device_get_match_data(&spi->dev);
> > +	if (!data->cfg)
> >  		data->cfg = &max5481_cfg[id->driver_data];
> >  
> >  	indio_dev->name = id->name;
> >   
> 

