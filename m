Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0AEFF05FE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF8A20893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y3CpnrC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF8A20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeG2N77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbeG2N77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:59:59 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1F6F20870;
        Sun, 29 Jul 2018 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532867379;
        bh=Qbpa5uJr3hPMkdP1kUrZCBpp5NiTtTv8htInItxkf3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y3CpnrC/rH5EEUmHdD9M4NOLCCa12S4mv+BN5ic3VEE8qRO4iLJPsAErtWotbozCJ
         D9UlXUd4fjPlcukFHk5IUSDsJWcU1VHLq5mbJySpffKydxVyQO6bgV8cdr3W0LBzGk
         bsigo1sjtH427IF8xjs4tLRuqvvQkR6oSPC5ciXc=
Date:   Sun, 29 Jul 2018 13:29:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio: adc: xilinx: Remove platform_get_irq from
 xadc_remove function
Message-ID: <20180729132935.28996ab6@archlinux>
In-Reply-To: <1532358123-23485-4-git-send-email-manish.narani@xilinx.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
        <1532358123-23485-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 20:32:02 +0530
Manish Narani <manish.narani@xilinx.com> wrote:

> This patch avoids getting irq number in xadc_remove function. Instead
> store 'irq' in xadc struct and use xadc->irq wherever needed.
> This patch also resolves a warning reported by coverity where it asks to
> check return value of platform_get_irq() for any errors in xadc_remove.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Applied. 

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 10 +++++-----
>  drivers/iio/adc/xilinx-xadc.h      |  1 +
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 0dd306d..44a2519 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1175,6 +1175,7 @@ static int xadc_probe(struct platform_device *pdev)
>  
>  	xadc = iio_priv(indio_dev);
>  	xadc->ops = id->data;
> +	xadc->irq = irq;
>  	init_completion(&xadc->completion);
>  	mutex_init(&xadc->mutex);
>  	spin_lock_init(&xadc->lock);
> @@ -1225,11 +1226,11 @@ static int xadc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_free_samplerate_trigger;
>  
> -	ret = xadc->ops->setup(pdev, indio_dev, irq);
> +	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
>  	if (ret)
>  		goto err_clk_disable_unprepare;
>  
> -	ret = request_irq(irq, xadc->ops->interrupt_handler, 0,
> +	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
>  			dev_name(&pdev->dev), indio_dev);
>  	if (ret)
>  		goto err_clk_disable_unprepare;
> @@ -1288,7 +1289,7 @@ static int xadc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_free_irq:
> -	free_irq(irq, indio_dev);
> +	free_irq(xadc->irq, indio_dev);
>  err_clk_disable_unprepare:
>  	clk_disable_unprepare(xadc->clk);
>  err_free_samplerate_trigger:
> @@ -1310,7 +1311,6 @@ static int xadc_remove(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct xadc *xadc = iio_priv(indio_dev);
> -	int irq = platform_get_irq(pdev, 0);
>  
>  	iio_device_unregister(indio_dev);
>  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
> @@ -1318,7 +1318,7 @@ static int xadc_remove(struct platform_device *pdev)
>  		iio_trigger_free(xadc->convst_trigger);
>  		iio_triggered_buffer_cleanup(indio_dev);
>  	}
> -	free_irq(irq, indio_dev);
> +	free_irq(xadc->irq, indio_dev);
>  	clk_disable_unprepare(xadc->clk);
>  	cancel_delayed_work(&xadc->zynq_unmask_work);
>  	kfree(xadc->data);
> diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
> index 62edbda..8c00095 100644
> --- a/drivers/iio/adc/xilinx-xadc.h
> +++ b/drivers/iio/adc/xilinx-xadc.h
> @@ -68,6 +68,7 @@ struct xadc {
>  	spinlock_t lock;
>  
>  	struct completion completion;
> +	int irq;
>  };
>  
>  struct xadc_ops {

