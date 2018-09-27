Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6B2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B90216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B90216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeI1BtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:49:04 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:59426 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728278AbeI1BtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:49:04 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 8AE10634C7E;
        Thu, 27 Sep 2018 22:29:13 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1g5byL-0000Eg-9Z; Thu, 27 Sep 2018 22:29:13 +0300
Date:   Thu, 27 Sep 2018 22:29:13 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 4/7] [media] ad5820: Add support for of-autoload
Message-ID: <20180927192912.hecig4ybp2jnh4ou@valkosipuli.retiisi.org.uk>
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
 <20180920204751.29117-4-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920204751.29117-4-ricardo.ribalda@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Thu, Sep 20, 2018 at 10:47:48PM +0200, Ricardo Ribalda Delgado wrote:
> Since kernel 4.16, i2c devices with DT compatible tag are modprobed
> using their DT modalias.
> Without this patch, if this driver is build as module it would never
> be autoprobed.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  drivers/media/i2c/ad5820.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
> index 625867472929..e461d36201a4 100644
> --- a/drivers/media/i2c/ad5820.c
> +++ b/drivers/media/i2c/ad5820.c
> @@ -372,12 +372,21 @@ static const struct i2c_device_id ad5820_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id ad5820_of_table[] = {
> +	{ .compatible = "adi,ad5820" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad5820_of_table);
> +#endif
> +
>  static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
>  
>  static struct i2c_driver ad5820_i2c_driver = {
>  	.driver		= {
>  		.name	= AD5820_NAME,
>  		.pm	= &ad5820_pm,
> +		.of_match_table = of_match_ptr(ad5820_of_table),

No need to use of_match_ptr() or #ifdef above --- not doing so makes this
work on ACPI, too.

>  	},
>  	.probe		= ad5820_probe,
>  	.remove		= ad5820_remove,

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
