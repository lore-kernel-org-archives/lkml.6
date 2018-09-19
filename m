Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F76C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8999E208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8999E208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbeISL0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:26:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51141 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726825AbeISL0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:26:34 -0400
X-UUID: 0227f40ecbf7480e82cc884489f093c1-20180919
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 964149213; Wed, 19 Sep 2018 13:50:09 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs01n2.mediatek.inc
 (172.21.101.79) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Wed, 19 Sep
 2018 13:50:06 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 19 Sep 2018 13:50:05 +0800
Message-ID: <1537336205.27607.23.camel@mhfsdcap03>
Subject: Re: [PATCH v3 2/3] spis: mediatek: add spi slave for Mediatek MT2712
From:   lei liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <yt.shen@mediatek.com>
Date:   Wed, 19 Sep 2018 13:50:05 +0800
In-Reply-To: <20180918163048.GN2471@sirena.org.uk>
References: <1537150762-7072-1-git-send-email-leilk.liu@mediatek.com>
         <1537150762-7072-3-git-send-email-leilk.liu@mediatek.com>
         <20180918163048.GN2471@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: F26958FC6E835FC5B81EF3B40465F01F1F1F9ACF813C565A4DD30C10D592A3452000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,
  Thanks for your comments.

On Tue, 2018-09-18 at 09:30 -0700, Mark Brown wrote:
> On Mon, Sep 17, 2018 at 10:19:21AM +0800, Leilk Liu wrote:
> 
> This looks overall pretty good, a few smallish comments below:
> 
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.
> 
OK, I'll fix it, thanks.

> >  if SPI_SLAVE
> > +config SPI_SLAVE_MT27XX
> > +	tristate "MediaTek SPI slave device"
> > +	depends on ARCH_MEDIATEK || COMPILE_TEST
> > +	help
> > +	  This selects the MediaTek(R) SPI slave device driver.
> > +	  If you want to use MediaTek(R) SPI slave interface,
> > +	  say Y or M here.If you are not sure, say N.
> > +	  SPI slave drivers for Mediatek MT27XX series ARM SoCs.
> >  
> >  config SPI_SLAVE_TIME
> 
> This is a driver not a slave implementation, it should be with the other
> drivers in the Kconfig.  The slave implementations are for the
> functionality that uses the drivers, not the drivers themselves.
> 
OK, I'll fix it, thanks.

> > +	/* set the tx/rx endian */
> > +#ifdef __LITTLE_ENDIAN
> > +	reg_val &= ~SPIS_TX_ENDIAN;
> > +	reg_val &= ~SPIS_RX_ENDIAN;
> > +#else
> > +	reg_val |= SPIS_TX_ENDIAN;
> > +	reg_val |= SPIS_RX_ENDIAN;
> > +#endif
> > +	writel(reg_val, mdata->base + SPIS_CFG_REG);
> 
> This seems weird - it looks like it's changing the endianess of the
> protocol based on the endianness the processor is running in.  What's
> going on here?  I'd expect the driver to be just treating everything as
> a byte stream and letting the protocol driver handle the endianness
> issues, otherwise we might end up with double converions.
> 
OK, I'll set the endian of SPI the same with the processor. Thanks.

> > +		xfer->tx_dma = dma_map_single(dev, (void *)xfer->tx_buf,
> > +					      xfer->len, DMA_TO_DEVICE);
> 
> Why is there a cast to void here?  That's usually a sign that there's a
> type safety issue, the whole point with void is that it's compatible
> with any other pointer.
> 
tx_buf is a const void*, here it need a void * for the dma mapping.
And I'll remove void * from dma_map_single((void *)rx_buf).
Thanks.

> > +static irqreturn_t mtk_spi_slave_interrupt(int irq, void *dev_id)
> > +{
> > +	struct spi_controller *ctlr = dev_id;
> > +	struct mtk_spi_slave *mdata = spi_controller_get_devdata(ctlr);
> > +	struct spi_transfer *trans = mdata->cur_transfer;
> > +	u32 int_status, reg_val, cnt, remainder;
> > +
> > +	int_status = readl(mdata->base + SPIS_IRQ_ST_REG);
> > +	writel(int_status, mdata->base + SPIS_IRQ_CLR_REG);
> > +
> > +	if (!trans)
> > +		return IRQ_HANDLED;
> 
> Are you sure that this is the right thing to do if we get a spurious
> interrupt - the normal thing would be to return IRQ_NONE, possibly
> logging a warning as well?
> 
OK, it should reture IRQ_NONE here, thanks.

> > +	if (int_status & CMD_INVALID_ST)
> > +		dev_err(&ctlr->dev, "cmd invalid\n");
> 
> If there's an interrupt that doesn't have any of the interrupt status
> flags set I'd expect to see a warning and probably IRQ_NONE being
> returned.  That way if the interrupt line is shared we work correctly
> and if something goes wrong and the interrupt gets stuck on then the
> core interrupt code's error handling can kick in.
OK, I'll fix it, thanks.


