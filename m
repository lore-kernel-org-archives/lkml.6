Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC9AC00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713AD20895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXU+EDbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713AD20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeJGWPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbeJGWPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:15:10 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3AC620841;
        Sun,  7 Oct 2018 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538924856;
        bh=fkZmFJvHx1zrZQi1tQvugTshno8csFtGyRAw5XWpwCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qXU+EDbq2jeJaNlXk9Q07sSV9dZYuPlZCinpNRrOLLcNs4O5tSC1U2ig9MRJxCDSV
         bhxPSMkEi/a5sHoG+p3FKdC3mqPwO6r+3HwqRfHzmTs0p/w1tsZAnmOIfE6Chgr6Sx
         7arkvD2IB2oN6DSfJsww09ZyDnbP2Pv7clWSCUBo=
Date:   Sun, 7 Oct 2018 16:07:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Phil Reid <preid@electromag.com.au>
Cc:     Song Qiang <songqiang1304521@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, himanshujha199640@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
Message-ID: <20181007160730.4df1010b@archlinux>
In-Reply-To: <b73d2ff2-f93a-1268-67f9-08620f05770d@electromag.com.au>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
        <20181002143812.3661-1-songqiang1304521@gmail.com>
        <20181002143812.3661-4-songqiang1304521@gmail.com>
        <b73d2ff2-f93a-1268-67f9-08620f05770d@electromag.com.au>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 09:42:14 +0800
Phil Reid <preid@electromag.com.au> wrote:

> G'day Song,

Hi Phil. Good point below. One general thing though, if you
could possibly crop down a review email when you are addressing one specific
point it would be very much appreciated!

Saves everyone else scrolling and if they have a rubbish email client
missing the comment entirely!

Thanks,
> 
> Noticed a one more thing below
> 
...
> > +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct rm3100_data *data;
> > +	unsigned int tmp;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->regmap = regmap;
> > +
> > +	mutex_init(&data->lock);
> > +
> > +	indio_dev->dev.parent = dev;
> > +	indio_dev->name = "rm3100";
> > +	indio_dev->info = &rm3100_info;
> > +	indio_dev->channels = rm3100_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->available_scan_masks = rm3100_scan_masks;
> > +
> > +	if (!irq)
> > +		data->use_interrupt = false;
> > +	else {
> > +		data->use_interrupt = true;
> > +		ret = devm_request_irq(dev,
> > +				       irq,
> > +				       rm3100_irq_handler,
> > +				       IRQF_TRIGGER_RISING,
> > +				       indio_dev->name,
> > +				       data);  
> 
> Assuming the irq source is the DRDY pin, this pin is active high.
> Which is automatically cleared when reading the measurement results register.
> 
> Perhaps when using interrupts the irq handler should do the read into data->buffer
> to clear the irq. Would need to use devm_request_threaded_irq instead.

Agreed. With a level interrupt that is the easiest way to handle it.
Grab the data in the threaded handler and complete after that.

Jonathan


> 
> The SOC irq block I use doesn't support edge triggered irqs, so this currently wouldn't work if
> DRDY was connected to that.
> 
> 
> > +		if (ret < 0) {
> > +			dev_err(dev, "request irq line failed.\n");
> > +			return ret;
> > +		}
> > +		init_completion(&data->measuring_done);
> > +	}
> > +
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +					      rm3100_trigger_handler, NULL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
> > +	if (ret < 0)
> > +		return ret;
> > +	/* Initializing max wait time, 3sec more wait time for conversion. */
> > +	data->conversion_time =
> > +		rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2] + 3000;
> > +
...


