Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79781C43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4212087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546706728;
	bh=d4uGYWaRaXbN5bN8zOAvu7q+clbKfknzepFJ/pXx+EA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Y9vFILriLQNqKmv++IlysTanoOkKiOZb+zEmBG454LWQjhbsRmxFjsLA+ABYaLU2H
	 jUvmJ1W1X3klNEs1K5HIfGRLE1VYg1DCB9JY4Mj6VEFmzZqL6ZYuH3hwgP3C0J/s4J
	 92hdaqu75/iBCl2Uah917HicjaWcWMB6trMcmUCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfAEQp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfAEQp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 11:45:27 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6CD620868;
        Sat,  5 Jan 2019 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546706726;
        bh=d4uGYWaRaXbN5bN8zOAvu7q+clbKfknzepFJ/pXx+EA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TaAQXZblzDYx8X1nzk7g20hkvRzpuJBAtFWPWbl9sAiRUx1XoETcmczUC0pgsE9e4
         0kLqa/VEnDQWq1UNhlRqndJs6pEOh9gZCJl6Vp0hpvYE5e0wtbH0Q0xH8RDCbJOnEs
         idCEo3iS4XgutzSzZVF0LIHaIdC2UVz7aVYcDLm8=
Date:   Sat, 5 Jan 2019 16:45:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Aditya Pakki <pakki001@umn.edu>, <kjlu@umn.edu>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Manish Narani <manish.narani@xilinx.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: xilinx: check return value of
 xadc_write_adc_reg
Message-ID: <20190105164521.458a08e8@archlinux>
In-Reply-To: <bfd90c61-233f-b200-a8f2-f1dc2bb4c003@xilinx.com>
References: <20181227195454.26344-1-pakki001@umn.edu>
        <bfd90c61-233f-b200-a8f2-f1dc2bb4c003@xilinx.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2019 12:16:49 +0100
Michal Simek <michal.simek@xilinx.com> wrote:

> On 27. 12. 18 20:54, Aditya Pakki wrote:
> > In function xadc_probe, xadc_write_adc_reg can return an error value
> > when write fails. The fix checks for the return value consistent with
> > other invocations of the latter function.
> > 
> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> > ---
> >  drivers/iio/adc/xilinx-xadc-core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> > index 3f6be5ac049a..b13c61539d46 100644
> > --- a/drivers/iio/adc/xilinx-xadc-core.c
> > +++ b/drivers/iio/adc/xilinx-xadc-core.c
> > @@ -1273,8 +1273,10 @@ static int xadc_probe(struct platform_device *pdev)
> >  			xadc->threshold[i] = 0xffff;
> >  		else
> >  			xadc->threshold[i] = 0;
> > -		xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
> > +		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
> >  			xadc->threshold[i]);
> > +		if (ret)
> > +			goto err_free_irq;
> >  	}
> >  
> >  	/* Go to non-buffered mode */
> >   
> 
> Reviewed-by: Michal Simek <michal.simek@xilinx.com>
> 
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> Thanks,
> Michal

