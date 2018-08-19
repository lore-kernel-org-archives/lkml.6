Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A4DC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E092F2147E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzi/0wAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E092F2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeHSTxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbeHSTxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:53:07 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 847A120671;
        Sun, 19 Aug 2018 16:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534696864;
        bh=Pn9bTgeyG0d6+bVpH+AKrezJ0+cprSv88safmJwyO3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jzi/0wAJr6FAX3CW/A6rgdzU7ImWOO8LyExFAZBCodL6R1KelqaRmUzga3QkEuBrq
         7hfKF1bj38krlkLbAEyHaq0IV73q8yKuKXaCJgCFZylXBbGYGG+kq4KyHBRlYezIAO
         GqkrDABnEPUBBdcvJCHUdKVAoZ653SVoo5FPmBxc=
Date:   Sun, 19 Aug 2018 17:41:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] iio: dac: max517: avoid using CONFIG_PM_SLEEP
Message-ID: <20180819174100.5d51b991@archlinux>
In-Reply-To: <20180811084709.6640-1-marcus.folkesson@gmail.com>
References: <20180811084709.6640-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2018 10:47:09 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> This is already handled by SIMPLE_DEV_PM_OPS().
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

thanks,

Jonathan

> ---
> Somehow git-send-email messed up (?!) the format for (at least) gmail, so resend it.
> Mutt still read the mail correct though.
> 
>  drivers/iio/dac/max517.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> index 1d853247a205..451d10e323cf 100644
> --- a/drivers/iio/dac/max517.c
> +++ b/drivers/iio/dac/max517.c
> @@ -113,15 +113,14 @@ static int max517_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int max517_suspend(struct device *dev)
> +static int __maybe_unused max517_suspend(struct device *dev)
>  {
>  	u8 outbuf = COMMAND_PD;
>  
>  	return i2c_master_send(to_i2c_client(dev), &outbuf, 1);
>  }
>  
> -static int max517_resume(struct device *dev)
> +static int __maybe_unused max517_resume(struct device *dev)
>  {
>  	u8 outbuf = 0;
>  
> @@ -129,10 +128,6 @@ static int max517_resume(struct device *dev)
>  }
>  
>  static SIMPLE_DEV_PM_OPS(max517_pm_ops, max517_suspend, max517_resume);
> -#define MAX517_PM_OPS (&max517_pm_ops)
> -#else
> -#define MAX517_PM_OPS NULL
> -#endif
>  
>  static const struct iio_info max517_info = {
>  	.read_raw = max517_read_raw,
> @@ -229,7 +224,7 @@ MODULE_DEVICE_TABLE(i2c, max517_id);
>  static struct i2c_driver max517_driver = {
>  	.driver = {
>  		.name	= MAX517_DRV_NAME,
> -		.pm		= MAX517_PM_OPS,
> +		.pm	= &max517_pm_ops,
>  	},
>  	.probe		= max517_probe,
>  	.remove		= max517_remove,

