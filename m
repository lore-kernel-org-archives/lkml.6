Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6233BECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD1C20833
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BZuxA/u3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD1C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeIUBzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:55:23 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36184 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeIUBzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:55:22 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 200941C86;
        Thu, 20 Sep 2018 22:10:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537474211;
        bh=vrKR2wwYt8Vkjhf+0JGRlOjotHwFj7i7LYAtpL+XxNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZuxA/u3VWgFXMrfcSw7fsciBF1EdIylHbVFh5ziclRbbx3tKXwqHs7gXN6H1gI+A
         uB7PaIgps04+UxMlLDsDvCE6XDMy8ju3keXnaYocYaBIIwTUhNm52xOgO6f2KKYT0M
         rO5dFXDGT1p7Y/axhhWUmSOJpeP7NboLmgZ0XoBE=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: Re: [PATCH v2 4/4] [media] ad5820: Add support for of-autoload
Date:   Thu, 20 Sep 2018 23:10:23 +0300
Message-ID: <2401971.XiI38RXFgU@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180920183151.2933-1-ricardo.ribalda@gmail.com>
References: <20180920161912.17063-4-ricardo.ribalda@gmail.com> <20180920183151.2933-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Thursday, 20 September 2018 21:31:51 EEST Ricardo Ribalda Delgado wrote:
> Since kernel 4.16, i2c devices with DT compatible tag are modprobed
> using their DT modalias.
> Without this patch, if this driver is build as module it would never
> be autoprobed.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/media/i2c/ad5820.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
> index 20931217e3b1..75b9b8aa5533 100644
> --- a/drivers/media/i2c/ad5820.c
> +++ b/drivers/media/i2c/ad5820.c
> @@ -375,12 +375,19 @@ static const struct i2c_device_id ad5820_id_table[] =
> { };
>  MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
> 
> +static const struct of_device_id ad5820_of_table[] = {
> +	{ .compatible = "adi,"AD5820_NAME },

I'd spell this out explicitly, to make it easier to grep for the compatible 
string.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad5820_of_table);
> +
>  static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
> 
>  static struct i2c_driver ad5820_i2c_driver = {
>  	.driver		= {
>  		.name	= AD5820_NAME,
>  		.pm	= &ad5820_pm,
> +		.of_match_table = ad5820_of_table,

As the driver doesn't depend on CONFIG_OF, would it make sense to use 
of_config_ptr() (and to compile the of table conditionally on CONFIG_OF) ?

>  	},
>  	.probe		= ad5820_probe,
>  	.remove		= ad5820_remove,

-- 
Regards,

Laurent Pinchart



