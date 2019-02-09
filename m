Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79EDC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950F521929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549730832;
	bh=iubSI39owbR/5OxgRxZL+pMKjJpk2EgAx+sbCmO8haI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DqiOyQlS+G7Sc8rfOCmGiu8tqRVc851nMUyKJl3E4ntS8KlyKhVWY8GtsZpoe6bUX
	 4FmZ8KA3tmJ+LD21xMJfKtLcfsYDlcW+7zfxgErHTAiztBBjcaqYWT/iXuUoEHj7YQ
	 n67GHrCmNUOYYwZPUdOkoKMd2btGaXX3o9WngWQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfBIQrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:47:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfBIQrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 11:47:09 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F35D218D2;
        Sat,  9 Feb 2019 16:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549730828;
        bh=iubSI39owbR/5OxgRxZL+pMKjJpk2EgAx+sbCmO8haI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B9FUTGyPg6O451fRsNeG4ZwKX9Hnrpvj0eh+G8aQ4YUu4jmD86Uq4bkjnilur/d1Y
         OuI2+ne2rFbXt0fdfWyYoT/QEdtMa63xGzRSkaCeq5mQKbRffeUD3p3wZvgytnhQjn
         S6rx6jRxmjauifsP05eBGjEZAkz6CUJW7xHlDH04=
Date:   Sat, 9 Feb 2019 16:47:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH]  iio: adc: exynos-adc: Fix NULL pointer exception on
 unbind
Message-ID: <20190209164702.697de406@archlinux>
In-Reply-To: <20190208233927.5392-1-krzk@kernel.org>
References: <20190208233927.5392-1-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Feb 2019 00:39:27 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Fix NULL pointer exception on device unbind when device tree does not
> contain "has-touchscreen" property.  In such case the input device is
> not registered so it should not be unregistered.
> 
>     $ echo "12d10000.adc" > /sys/bus/platform/drivers/exynos-adc/unbind
> 
>     Unable to handle kernel NULL pointer dereference at virtual address 00000474
>     ...
>     (input_unregister_device) from [<c0772060>] (exynos_adc_remove+0x20/0x80)
>     (exynos_adc_remove) from [<c0587d5c>] (platform_drv_remove+0x20/0x40)
>     (platform_drv_remove) from [<c05860f0>] (device_release_driver_internal+0xdc/0x1ac)
>     (device_release_driver_internal) from [<c0583ecc>] (unbind_store+0x60/0xd4)
>     (unbind_store) from [<c031b89c>] (kernfs_fop_write+0x100/0x1e0)
>     (kernfs_fop_write) from [<c029709c>] (__vfs_write+0x2c/0x17c)
>     (__vfs_write) from [<c0297374>] (vfs_write+0xa4/0x184)
>     (vfs_write) from [<c0297594>] (ksys_write+0x4c/0xac)
>     (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> 
> Fixes: 2bb8ad9b44c5 ("iio: exynos-adc: add experimental touchscreen support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Given we have had this one for a little while and are late in the
cycle I'm going to queue it up for the coming merge window.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/exynos_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index fa2d2b5767f3..41da522fc673 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -929,7 +929,7 @@ static int exynos_adc_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct exynos_adc *info = iio_priv(indio_dev);
>  
> -	if (IS_REACHABLE(CONFIG_INPUT)) {
> +	if (IS_REACHABLE(CONFIG_INPUT) && info->input) {
>  		free_irq(info->tsirq, info);
>  		input_unregister_device(info->input);
>  	}

