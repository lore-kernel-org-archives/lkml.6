Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F53C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACD62086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547312579;
	bh=5/ODI8/PPQq1OJQJDtispd9AyGSlrSHuN0ar/3JzOLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zhHzKoNuq2eaqIgVHTtg41V1A2dxxgUvhTD4mj41VtyZR+FdpIIV9oSKzhKGlZO+G
	 8YPgbZsxttMhknV4W+T4+g96NniTl0aTDbS+1MHYoStrbza38cS28626VmtrQJwx2G
	 XPCW5EchJ2uh5IiZGRYcaAp0TxnHrd37FZTtV+y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfALRC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:02:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfALRC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:02:58 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9802084C;
        Sat, 12 Jan 2019 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547312577;
        bh=5/ODI8/PPQq1OJQJDtispd9AyGSlrSHuN0ar/3JzOLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1PJCE0D6N6jCmqtqUbZWBTAXZr6qg7EG52QS2cX5AS6vurHjOged0uTTOTKB7LvWX
         9131bjqIXta0cBv2T/D80ol/YKAE0L8u9sSl4g9x6n5u5i+FvoCc299mIz4Kb591AQ
         lvm5maV0q3nnm1NefJ+LRDPg35AyrVAtGPOqAAWc=
Date:   Sat, 12 Jan 2019 17:02:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: adt7316: Add regmap support
Message-ID: <20190112170252.56406302@archlinux>
In-Reply-To: <20190105220413.GA3449@r2700x.localdomain>
References: <20181223140224.10958-1-shreeya.patel23498@gmail.com>
        <20190105172037.7cc5006b@archlinux>
        <20190105220413.GA3449@r2700x.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...  
> > > diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
> > > index fd7c5c92b599..2c72cf3f71cd 100644
> > > --- a/drivers/staging/iio/addac/adt7316.h
> > > +++ b/drivers/staging/iio/addac/adt7316.h
> > > @@ -11,16 +11,13 @@
> > >  
> > >  #include <linux/types.h>
> > >  #include <linux/pm.h>
> > > +#include <linux/regmap.h>
> > >  
> > >  #define ADT7316_REG_MAX_ADDR		0x3F
> > >  
> > > -struct adt7316_bus {
> > > -	void *client;
> > > -	int irq;
> > > -	int (*read)(void *client, u8 reg, u8 *data);
> > > -	int (*write)(void *client, u8 reg, u8 val);
> > > -	int (*multi_read)(void *client, u8 first_reg, u8 count, u8 *data);
> > > -	int (*multi_write)(void *client, u8 first_reg, u8 count, u8 *data);
> > > +static const struct regmap_config adt7316_regmap_config = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 10,  
> 
> I wonder if val_bits should be 8. The driver can read and write 8, 10,
> or 12 bit values. In the 10 and 12 bit cases, the driver currently
> (including with this patch) does two separate reads or writes and expects
> an 8 bit result from each. It then parses these two values to come up with
> the 10 or 12 bit value. I don't think the logic for this calculation is
> known to regmap, so with the current form of the patch, I think val_bits
> should be 8. Maybe there is a better way to do it though?

Good point. I would assume they should be 8 as well.


> 
> I would have tested this but I couldn't get the patch to apply. Shreeya,
> I think if you rebase against iio/testing that might take care of it. I
> can then do some testing with v2.
>
Great.

Jonathan 
> Jeremy
