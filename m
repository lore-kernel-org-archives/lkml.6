Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6B4C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D37D2147E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdSk+c7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D37D2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbeHSTz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbeHSTz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:55:28 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77D0B20671;
        Sun, 19 Aug 2018 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534697004;
        bh=Viw+TRwiscgE1TPHHhogq234WceJtqkZnJfR/00k3Y4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VdSk+c7wEsqjuQ3g2AVIASfY45W6tXv+IP5lP+SunIycAon5Ejn4fspwqxmHmMjFH
         jDKuF97LTBKnFw1k2S82dqh3ShBuZAkDpeiwyIS1j1p4jhNX8qUBo68iKcvhhcjnaL
         tPr73Egts5zIAwg6C0csJlfqSclPZNfvjULt0NAw=
Date:   Sun, 19 Aug 2018 17:43:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] iio: dac: mcp4725: avoid using CONFIG_PM_SLEEP
Message-ID: <20180819174320.29c8bc31@archlinux>
In-Reply-To: <20180811084725.6742-1-marcus.folkesson@gmail.com>
References: <20180811084725.6742-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2018 10:47:25 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> This is already handled by SIMPLE_DEV_PM_OPS().
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.
> ---
> Somehow git-send-email messed up (?!) the format for (at least) gmail, so resend it.
> Mutt still read the mail correct though.

You have my sympathies ;) oh for all email servers and clients being well behaved.

Thanks,

Jonathan

> 
>  drivers/iio/dac/mcp4725.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 8b5aad4c32d9..6d71fd905e29 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -45,7 +45,7 @@ struct mcp4725_data {
>  	struct regulator *vref_reg;
>  };
>  
> -static int mcp4725_suspend(struct device *dev)
> +static int __maybe_unused mcp4725_suspend(struct device *dev)
>  {
>  	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev)));
> @@ -58,7 +58,7 @@ static int mcp4725_suspend(struct device *dev)
>  	return i2c_master_send(data->client, outbuf, 2);
>  }
>  
> -static int mcp4725_resume(struct device *dev)
> +static int __maybe_unused mcp4725_resume(struct device *dev)
>  {
>  	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev)));
> @@ -71,13 +71,7 @@ static int mcp4725_resume(struct device *dev)
>  
>  	return i2c_master_send(data->client, outbuf, 2);
>  }
> -
> -#ifdef CONFIG_PM_SLEEP
>  static SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend, mcp4725_resume);
> -#define MCP4725_PM_OPS (&mcp4725_pm_ops)
> -#else
> -#define MCP4725_PM_OPS NULL
> -#endif
>  
>  static ssize_t mcp4725_store_eeprom(struct device *dev,
>  	struct device_attribute *attr, const char *buf, size_t len)
> @@ -547,7 +541,7 @@ static struct i2c_driver mcp4725_driver = {
>  	.driver = {
>  		.name	= MCP4725_DRV_NAME,
>  		.of_match_table = of_match_ptr(mcp4725_of_match),
> -		.pm	= MCP4725_PM_OPS,
> +		.pm	= &mcp4725_pm_ops,
>  	},
>  	.probe		= mcp4725_probe,
>  	.remove		= mcp4725_remove,

