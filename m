Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EB7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671472088E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671472088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbeGWP5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:57:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387859AbeGWP5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:57:08 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 14E7270263243;
        Mon, 23 Jul 2018 22:55:26 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Mon, 23 Jul 2018
 22:55:25 +0800
Date:   Mon, 23 Jul 2018 15:55:14 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: add support for mcp3911
Message-ID: <20180723155514.00006820@huawei.com>
In-Reply-To: <20180722190051.GB27516@gmail.com>
References: <20180721195923.7610-1-marcus.folkesson@gmail.com>
        <alpine.DEB.2.21.1807212259480.13457@vps.pmeerw.net>
        <20180722090838.0080aaf5@archlinux>
        <20180722190051.GB27516@gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jul 2018 21:00:51 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Hi Jonathan,
> 
> Thanks, all good catches.
> 
> On Sun, Jul 22, 2018 at 09:08:38AM +0100, Jonathan Cameron wrote:
> > On Sat, 21 Jul 2018 23:19:48 +0200 (CEST)
> > Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
> >   
> > > Hello,
> > >   
> > > > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > > > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).    
> > > 
> > > some comments below...  
> > 
> > +CC Mark for the unusual SPI addressing stuff.  I'm mostly interested in what
> > precedent there is for bindings etc.
> >   
> 
> Yep, I'm not entirely sure that the SPI framework can handle multiple
> clients on the same CS.
> The reason why we created device-addr is that the chip supports that and
> may have hardcoded chip address from factory.
> The chip address is also part of the protocol so we have to specify it.

It will certainly be 'interesting' if we ever try to support it.

> 
...

...
> > > > +static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 len)
> > > > +{
> > > > +	dev_dbg(&adc->spi->dev, "Writing 0x%x to register 0x%x\n", val, reg);
> > > > +
> > > > +	cpu_to_be32s(&val);
> > > > +	val >>= (3-len)*8;  
> > Hmm. It might be worth considering regmap here to handle all this stuff for
> > you rather than re rolling the same stuff.
> >   
> 
> We were looking at regmap, but it does not seems to support registers of
> different size.
> This chip has register values of 8, 16 and 24 bits.

Fair enough. I thought we were really looking at autoincrement, of
the address for a fixed sized register - which is fine in regmap.
Those wider registers are described as having ADDR and ADDR+1 etc.

> 
> > > > +	val |= REG_WRITE(reg, adc->dev_addr);
> > > > +
> > > > +	return spi_write(adc->spi, &val, len+1);
> > > > +}
> > > > +

> > > > +
> > > > +static int mcp3911_read_raw(struct iio_dev *indio_dev,
> > > > +			    struct iio_chan_spec const *channel, int *val,
> > > > +			    int *val2, long mask)
> > > > +{
> > > > +	struct mcp3911 *adc = iio_priv(indio_dev);
> > > > +	int ret = -EINVAL;
> > > > +
> > > > +	mutex_lock(&adc->lock);
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_RAW:
> > > > +		ret = mcp3911_read(adc,
> > > > +				MCP3911_CHANNEL(channel->channel), val, 3);
> > > > +		if (ret)
> > > > +			goto out;
> > > > +
> > > > +		ret = IIO_VAL_INT;
> > > > +		break;
> > > > +
> > > > +	case IIO_CHAN_INFO_OFFSET:
> > > > +		ret = mcp3911_read(adc,
> > > > +				MCP3911_OFFCAL(channel->channel), val, 3);
> > > > +		if (ret)
> > > > +			goto out;
> > > > +
> > > > +		ret = IIO_VAL_INT;
> > > > +		break;
> > > > +
> > > > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > > > +		ret = mcp3911_get_hwgain(adc, channel->channel, val);  
> > 
> > I'm not convinced it's useful to expose this as it right control for this
> > is scale.
> >   
> 
> Hmm, all other drivers that are using HARDWAREGAIN (ina2xx-adc, stx104 +
> a few more that are not ADC:s) are, what I can tell, exposing it.
> 
> But maybe it should'nt.

Yup, as ever things are a bit messy.  However, best to not expose it unless
there is a very good reason.
> > > > +
> > > > +		break;
> > > > +
> > > > +	case IIO_CHAN_INFO_HARDWAREGAIN:    
> > 
> > Default choice (by precedent) is to control variable gain
> > front ends via the scale parameter.   Hardware gain
> > is not meant to have any 'visible' impact on the output
> > value - most commonly used when the thing we are measuring
> > is not amplitude of anything.  
> 
> Hmm, Ok. I'm not sure I understand how hardware gain is supposed to work
> then.

For this use case it isn't. 

> Maybe I just remove it.

That's the best plan.

...
> > > > +
> > > > +static int mcp3911_config_of(struct mcp3911 *adc)
> > > > +{
> > > > +	u32 configreg;
> > > > +	u32 statuscomreg;
> > > > +	int ret;
> > > > +
> > > > +	of_property_read_u32(adc->np, "device-addr", &adc->dev_addr);  
> > This is 'interesting' - I wonder if there is any precedence for it.
> >   
> 
> I guess we still need it since the device may have a hardcoded (from
> factory) address that we need to deal with.

Fair enough.  Still good to hear from Mark on whether there are other similar
devices so the binding can be consistent.


> > > > +
> > > > +	of_property_read_u32(adc->np, "ch0-width", &adc->width[0]);
> > > > +	switch (adc->width[0]) {
> > > > +	case 24:
> > > > +		statuscomreg &= ~MCP3911_STATUSCOM_CH0_24WIDTH;
> > > > +		dev_dbg(&adc->spi->dev, "set channel 0 into 24bit mode\n");
> > > > +		break;
> > > > +	case 16:
> > > > +		statuscomreg |= MCP3911_STATUSCOM_CH0_24WIDTH;
> > > > +		dev_dbg(&adc->spi->dev, "set channel 0 into 16bit mode\n");
> > > > +		break;
> > > > +	default:
> > > > +		adc->width[0] = 24;
> > > > +		dev_info(&adc->spi->dev, "invalid width for channel 0. Use 24bit.\n");
> > > > +		break;
> > > > +	}  
> > This feels like something that isn't really a dt choice, as it's not down to
> > wiring but rather down to precision desired.  
> 
> You are right. I will remove them and stick to 24bit width.
>
That's the easiest option.  If anyone 'really' wants 16bit we'll figure it out
later.
 
..
Thanks

Jonathan

