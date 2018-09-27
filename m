Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF7AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB08321708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB08321708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeI1BzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:55:01 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:59526 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727621AbeI1BzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:55:01 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 49B8F634C80;
        Thu, 27 Sep 2018 22:35:09 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1g5c45-0000Ew-42; Thu, 27 Sep 2018 22:35:09 +0300
Date:   Thu, 27 Sep 2018 22:35:08 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 6/7] [media] ad5820: Add support for ad5821 and ad5823
Message-ID: <20180927193508.r25owgcwfeui2x7k@valkosipuli.retiisi.org.uk>
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
 <20180920204751.29117-6-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920204751.29117-6-ricardo.ribalda@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Thu, Sep 20, 2018 at 10:47:50PM +0200, Ricardo Ribalda Delgado wrote:
> According to the datasheet, both AD5821 and AD5820 share a compatible
> register-set:
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5821.pdf
> 
> Some camera modules also refer that AD5823 is a replacement of AD5820:
> https://download.kamami.com/p564094-OV8865_DS.pdf

A silly question --- the maximum current of these devices differs from each
other. Is the control value range still the same?

> 
> Suggested-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/media/i2c/ad5820.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
> index 5d1185e7f78d..c52af302d516 100644
> --- a/drivers/media/i2c/ad5820.c
> +++ b/drivers/media/i2c/ad5820.c
> @@ -34,8 +34,6 @@
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-subdev.h>
>  
> -#define AD5820_NAME		"ad5820"
> -
>  /* Register definitions */
>  #define AD5820_POWER_DOWN		(1 << 15)
>  #define AD5820_DAC_SHIFT		4
> @@ -368,7 +366,9 @@ static int ad5820_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id ad5820_id_table[] = {
> -	{ AD5820_NAME, 0 },
> +	{ "ad5820", 0 },
> +	{ "ad5821", 0 },
> +	{ "ad5823", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
> @@ -376,6 +376,8 @@ MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
>  #ifdef CONFIG_OF
>  static const struct of_device_id ad5820_of_table[] = {
>  	{ .compatible = "adi,ad5820" },
> +	{ .compatible = "adi,ad5821" },
> +	{ .compatible = "adi,ad5823" },

You could set the subdev name accordingly as well.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ad5820_of_table);
> @@ -384,6 +386,8 @@ MODULE_DEVICE_TABLE(of, ad5820_of_table);
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id ad5820_acpi_ids[] = {
>  	{ "AD5820" },
> +	{ "AD5821" },
> +	{ "AD5823" },
>  	{ }
>  };
>  
> @@ -394,7 +398,7 @@ static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
>  
>  static struct i2c_driver ad5820_i2c_driver = {
>  	.driver		= {
> -		.name	= AD5820_NAME,
> +		.name	= "ad5820",
>  		.pm	= &ad5820_pm,
>  		.of_match_table = of_match_ptr(ad5820_of_table),
>  		.acpi_match_table = ACPI_PTR(ad5820_acpi_ids),

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
