Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00744ECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 09:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E29621476
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 09:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtMmq41R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E29621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeIPPJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 11:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbeIPPJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 11:09:04 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EE572087E;
        Sun, 16 Sep 2018 09:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537091203;
        bh=Xqq+u5bBpnutGq++END9Y0yaYSeesS5CfYbDzXVCbiY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VtMmq41RNTYA+BT3RzGQ3YkohnutWMwZRq+39ZzBEDElPra1n7sWPmxqjor+0gpnE
         FGkR782TT3PeyQBORMyqeVSiUrwthHYmFx1QaEqpItumEdR2/H9vWAIIUpNIKPQc5H
         0a+F+wSOE5pflOMlGgWW+1wxtif1p6OxspWQ9BQo=
Date:   Sun, 16 Sep 2018 10:46:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next] iio: potentiometer: max5481: merge calls to
 of_match_device and of_device_get_match_data
Message-ID: <20180916104645.36302bd9@archlinux>
In-Reply-To: <20180915105033.5928-1-yuehaibing@huawei.com>
References: <20180915105033.5928-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2018 18:50:33 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> Drop call to of_match_device, which is subsumed by the subsequent
> call to of_device_get_match_data.  The code becomes simpler, and a
> temporary variable can be dropped.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Sorry, another one that was waiting in my queue and only just went
towards linux-next - so will be there tomorrow.

Jonathan
> ---
>  drivers/iio/potentiometer/max5481.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
> index ffe2761..6d2f13f 100644
> --- a/drivers/iio/potentiometer/max5481.c
> +++ b/drivers/iio/potentiometer/max5481.c
> @@ -137,7 +137,6 @@ static int max5481_probe(struct spi_device *spi)
>  	struct iio_dev *indio_dev;
>  	struct max5481_data *data;
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> -	const struct of_device_id *match;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> @@ -149,10 +148,8 @@ static int max5481_probe(struct spi_device *spi)
>  
>  	data->spi = spi;
>  
> -	match = of_match_device(of_match_ptr(max5481_match), &spi->dev);
> -	if (match)
> -		data->cfg = of_device_get_match_data(&spi->dev);
> -	else
> +	data->cfg = of_device_get_match_data(&spi->dev);
> +	if (!data->cfg)
>  		data->cfg = &max5481_cfg[id->driver_data];
>  
>  	indio_dev->name = id->name;

