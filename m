Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A58EC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A748920862
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGQWEHQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A748920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeIBNdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 09:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbeIBNdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 09:33:11 -0400
Received: from archlinux (82-132-217-68.dab.02.net [82.132.217.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 805D220841;
        Sun,  2 Sep 2018 09:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535879886;
        bh=8Gz7pwSl5Cn5J+bpfRstmDRTgYYSJzfvxi5Gp7iFChM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KGQWEHQ3ujij5Q6yOWidarfcjiYyp5QM/inlNnveyNGClxlAKvfTHgpXZ0tXnN7nR
         JGhw1x0ra7bjPHHC1N80B9JykLVnYHhOd0sBlMt60StjELZNrmHoN/4XLO5tDZLIiq
         EKZJ2Jgr7rs0ySbIAUiPaX7WR+rjnQf621OT8wTs=
Date:   Sun, 2 Sep 2018 10:18:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Afonso Bordado <afonsobordado@az8.co>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: gyro: add support for fxas21002c
Message-ID: <20180902101800.4165005f@archlinux>
In-Reply-To: <d6c71f8699a0ee8eb09417381e301246b864e69e.camel@az8.co>
References: <20180825211910.22929-1-afonsobordado@az8.co>
        <20180827180805.7d4b9f4e@archlinux>
        <d6c71f8699a0ee8eb09417381e301246b864e69e.camel@az8.co>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 07:43:48 +0100
Afonso Bordado <afonsobordado@az8.co> wrote:

> On Mon, 2018-08-27 at 18:08 +0100, Jonathan Cameron wrote:
> > On Sat, 25 Aug 2018 22:19:07 +0100
> > Afonso Bordado <afonsobordado@az8.co> wrote:
> >   
> > > FXAS21002C is a 3 axis gyroscope with integrated temperature sensor
> > > 
> > > Signed-off-by: Afonso Bordado <afonsobordado@az8.co>  
> > 
> > Hi,
> > 
> > Driver is pretty clean so only a few minor comments inline.
> > If we were late in a cycle I'd probably just have taken it and fixed
> > up
> > but as we have lots of time and I'm inherently lazy I'll let you do a
> > v2 :)
> > 
> > Good job, thanks!
> > 
> > Jonathan  
> 
> Great!
> 
> 
> > > +
> > > +static const struct regmap_access_table fxas21002c_volatile_table
> > > = {
> > > +	.yes_ranges = fxas21002c_volatile_ranges,
> > > +	.n_yes_ranges = ARRAY_SIZE(fxas21002c_volatile_ranges),
> > > +};
> > > +
> > > +const struct regmap_config fxas21002c_regmap_config = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +
> > > +	.max_register = FXAS21002C_REG_CTRL_REG3,
> > > +	// We don't specify a .rd_table because everything is readable  
> > 
> > /* ... */
> > 
> > Please run checkpatch as IIRC it complains about this.  
> 
> I've replaced all instances of C99 comments with ANSI comments.
> However, has Joe Perches mentioned. Checkpatch did not warn me about
> this.
> 
Yup, thanks to Joe for clarifying this I had missed the change.
> 
> > > +
> > > +static int fxas21002c_remove(struct i2c_client *client)
> > > +{
> > > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > > +	struct fxas21002c_data *data = iio_priv(indio_dev);
> > > +
> > > +	iio_device_unregister(indio_dev);
> > > +
> > > +	fxas21002c_set_operating_mode(data, FXAS21002C_OM_STANDBY);  
> > 
> > You could have used the devm_add_action to allow the managed cleanup
> > to handle
> > this and hence gotten rid of the remove function.
> > 
> > (minor suggestion and somewhat a matter of personal taste).  
> 
> I didn't know this existed! Changed in v2.

Nor me until someone used it in a driver a few months back ;)
One of the advantages of doing a lot of review is that you get to see
any new stuff other people use.

Jonathan
