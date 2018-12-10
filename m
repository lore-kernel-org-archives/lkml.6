Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CADC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE4D2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544476715;
	bh=YWhYiJE4CRyzUEbP6iNgffWEAynq36sTo6lVIxB5xwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1BHX0QxE2n3Jx2JOCirRqGnvk3PsGVv5yoh/dorBUVTSzMNeH4TgD+0OkyN0InUte
	 xpvdox4zKRssJv7xh8eLMx2upKw4LY07LoPsnOvLuXkx/WsmiTaOD9eL/5JY+lGCT6
	 Sj8MK/jYzt3QTodOB+UmC/r8c5I52JpP9aX2DAHk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE4D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeLJVSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeLJVSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:18:33 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E364D20672;
        Mon, 10 Dec 2018 21:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544476713;
        bh=YWhYiJE4CRyzUEbP6iNgffWEAynq36sTo6lVIxB5xwA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cfks1aG/YoNXsA6nxUD7B9YKCMX7u9dfe+y57qBsw71eI/rKDjnIp4QU7xof1hRLU
         YQKv6jCM3f0jLOBFkevwV4fHYGnP62Ap85bXMht6EhXYbkYgRLM83aR5ZeEd8kZdGP
         hGiwKyfizmAagF1sS5Xvqff8MkQVqEcNuYmGzGJs=
Date:   Mon, 10 Dec 2018 21:18:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma9551_core: prevent using uninitialized
 variable
Message-ID: <20181210211829.44c83cbf@archlinux>
In-Reply-To: <20181210142532.15315-1-martink@posteo.de>
References: <20181210142532.15315-1-martink@posteo.de>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 15:25:32 +0100
Martin Kepplinger <martink@posteo.de> wrote:

> mma9551_gpio_config()'s switch statement sets the uninitialized pol_mask
> variable but doesn't have default settings. Said function can therefore
> be called in a way to use the uninitialized variable (at least in case
> enum mma9551_gpio_pin is extended with unhandled values).
> 
> While things should be fine now, this initializes pol_mask just to prevent
> failure.
I'm unconvinced by this approach.  Should the enum be extended and have
unhandled values then the value of reg will be garbage as well.  
I'd much rather see the switch statement have a default with
appropriate error return.

Jonathan

> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  drivers/iio/accel/mma9551_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> index c34c5ce8123b..2fc79b14888b 100644
> --- a/drivers/iio/accel/mma9551_core.c
> +++ b/drivers/iio/accel/mma9551_core.c
> @@ -539,7 +539,8 @@ EXPORT_SYMBOL(mma9551_update_config_bits);
>  int mma9551_gpio_config(struct i2c_client *client, enum mma9551_gpio_pin pin,
>  			u8 app_id, u8 bitnum, int polarity)
>  {
> -	u8 reg, pol_mask, pol_val;
> +	u8 reg, pol_val;
> +	u8 pol_mask = 0;
>  	int ret;
>  
>  	if (pin > mma9551_gpio_max) {

