Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834CDFF05FE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3311D20893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT2KYAgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3311D20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeG2OBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 10:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeG2OBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 10:01:14 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ECD720870;
        Sun, 29 Jul 2018 12:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532867455;
        bh=9A0MeOWyiLbolf4vSEiZYeNIhAespnOcfEI9cuEjrQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cT2KYAgrp4yw9K1ll0eM4EcZb82qoAgdvUB2gh0SVGQtTBMZ3FTg6203n8fXKhz0y
         gBZSMgOzJu11J7U/FxSPKGB5J407khlHnKdKJMADiM5rC6zEZUhBCe/TqixlZGSNQi
         iv8tXuL7aMQQISgBVZJF3v4kQXgslNnOag6zHk4U=
Date:   Sun, 29 Jul 2018 13:30:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: adc: xilinx: Move request_irq before
 enabling interrupts
Message-ID: <20180729133050.0c5a38bf@archlinux>
In-Reply-To: <1532358123-23485-5-git-send-email-manish.narani@xilinx.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
        <1532358123-23485-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 20:32:03 +0530
Manish Narani <manish.narani@xilinx.com> wrote:

> Enabling the Interrupts before registering the irq handler is a bad
> idea. This patch corrects the same for XADC driver.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 44a2519..3f6be5a 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1226,15 +1226,15 @@ static int xadc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_free_samplerate_trigger;
>  
> -	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
> -	if (ret)
> -		goto err_clk_disable_unprepare;
> -
>  	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
>  			dev_name(&pdev->dev), indio_dev);
>  	if (ret)
>  		goto err_clk_disable_unprepare;
>  
> +	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
> +	if (ret)
> +		goto err_free_irq;
> +
>  	for (i = 0; i < 16; i++)
>  		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
>  			&xadc->threshold[i]);

