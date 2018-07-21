Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27A8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBAC20858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTsPwIbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBAC20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeGURRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 13:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbeGURRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 13:17:45 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00C3D20849;
        Sat, 21 Jul 2018 16:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532190267;
        bh=FBqHaNnMI76CJjSBNB+WZK7a7Q/O00vS3BuSygmMJ9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FTsPwIbxD0OOAjPmmPZRFDLEHmW3Sx1hAWNf0/U1+K8wVTojCedJs8rc6P2tAobxy
         qw/ZHF+YERbpAWnO/MUefAe+KAlrj89jGjd3U7BCu4MHgeDly1BwN211Qxh9fcXd/o
         grFHmDLP2W61zdAQ8GiYoX1dhfwNyUrEexfTiq08=
Date:   Sat, 21 Jul 2018 17:24:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Manish Narani <manish.narani@xilinx.com>, knaack.h@gmx.de,
        pmeerw@pmeerw.net, michal.simek@xilinx.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anirudh@xilinx.com, sgoud@xilinx.com
Subject: Re: [PATCH 3/4] iio: adc: xilinx: Check for return values in clk
 related functions
Message-ID: <20180721172423.11efb5ea@archlinux>
In-Reply-To: <f4b8e687-217f-15b1-b0b1-b95dbc3dcc2a@metafoo.de>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
        <1531912331-26431-4-git-send-email-manish.narani@xilinx.com>
        <f4b8e687-217f-15b1-b0b1-b95dbc3dcc2a@metafoo.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018 18:40:26 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 07/18/2018 01:12 PM, Manish Narani wrote:
> > This patch adds check for return values from clock related functions.
> > This was reported by static code analysis tool.  
> 
> This patch seems to do something else.
Indeed, definitely doing two things only one of which is mentioned.
Please break it up and resend.

Jonathan

> 
> > 
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  drivers/iio/adc/xilinx-xadc-core.c | 24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> > index 248cffa..47eb364 100644
> > --- a/drivers/iio/adc/xilinx-xadc-core.c
> > +++ b/drivers/iio/adc/xilinx-xadc-core.c
> > @@ -322,6 +322,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
> >  
> >  #define XADC_ZYNQ_TCK_RATE_MAX 50000000
> >  #define XADC_ZYNQ_IGAP_DEFAULT 20
> > +#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
> >  
> >  static int xadc_zynq_setup(struct platform_device *pdev,
> >  	struct iio_dev *indio_dev, int irq)
> > @@ -332,6 +333,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
> >  	unsigned int div;
> >  	unsigned int igap;
> >  	unsigned int tck_rate;
> > +	int ret;
> >  
> >  	/* TODO: Figure out how to make igap and tck_rate configurable */
> >  	igap = XADC_ZYNQ_IGAP_DEFAULT;
> > @@ -341,6 +343,13 @@ static int xadc_zynq_setup(struct platform_device *pdev,
> >  
> >  	pcap_rate = clk_get_rate(xadc->clk);
> >  
> > +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> > +		ret = clk_set_rate(xadc->clk,
> > +				   (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	if (tck_rate > pcap_rate / 2) {
> >  		div = 2;
> >  	} else {
> > @@ -366,6 +375,12 @@ static int xadc_zynq_setup(struct platform_device *pdev,
> >  			XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE |
> >  			tck_div | XADC_ZYNQ_CFG_IGAP(igap));
> >  
> > +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> > +		ret = clk_set_rate(xadc->clk, pcap_rate);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > @@ -887,6 +902,9 @@ static int xadc_write_raw(struct iio_dev *indio_dev,
> >  	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
> >  	unsigned int div;
> >  
> > +	if (!clk_rate)
> > +		return -EINVAL;
> > +
> >  	if (info != IIO_CHAN_INFO_SAMP_FREQ)
> >  		return -EINVAL;
> >  
> > @@ -1239,8 +1257,10 @@ static int xadc_probe(struct platform_device *pdev)
> >  		goto err_free_irq;
> >  
> >  	/* Disable all alarms */
> > -	xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
> > -		XADC_CONF1_ALARM_MASK);
> > +	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
> > +				  XADC_CONF1_ALARM_MASK);
> > +	if (ret)
> > +		goto err_free_irq;
> >  
> >  	/* Set thresholds to min/max */
> >  	for (i = 0; i < 16; i++) {
> >   
> 

