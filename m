Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756541AbeEASs7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:48:59 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40818 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756404AbeEASs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:48:57 -0400
X-Google-Smtp-Source: AB8JxZpewtgPXduCKFypEa/XYt6XEymUZyzzsPPM65IRd7IoPNMyJL4vlfcSNiX9aDopUuOlDhqGWA==
Date: Tue, 1 May 2018 11:48:53 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nick Dyer <nick@shmanahar.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Input: atmel_mxt_ts - add missing compatible strings to
 OF device table
Message-ID: <20180501184853.GB52077@dtor-ws>
References: <20180410095340.24074-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410095340.24074-1-javierm@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 11:53:40AM +0200, Javier Martinez Canillas wrote:
> Commit af503716ac14 ("i2c: core: report OF style module alias for devices
> registered via OF") fixed how the I2C core reports the module alias when
> devices are registered via OF.
> 
> But the atmel_mxt_ts driver only has an "atmel,maxtouch" compatible in its
> OF device ID table, so if a Device Tree is using a different one, autoload
> won't be working for the module (the matching works because the I2C device
> ID table is used as a fallback).
> 
> So add compatible strings for each of the entries in the I2C device table.
> 
> Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")
> Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  Documentation/devicetree/bindings/input/atmel,maxtouch.txt | 6 +++++-
>  drivers/input/touchscreen/atmel_mxt_ts.c                   | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> index 23e3abc3fdef..cd43fb8bc2ce 100644
> --- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> +++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> @@ -1,8 +1,12 @@
>  Atmel maXTouch touchscreen/touchpad
>  
>  Required properties:
> -- compatible:
> +- compatible: Must be one of the following
> +    atmel,qt602240_ts
> +    atmel,atmel_mxt_ts
> +    atmel,atmel_mxt_tp
>      atmel,maxtouch
> +    atmel,mXT224

I do not think we should document ad-hoc compatible strings that were
introduced by various vendors as the documented ones, so I'd rather
dropped this chunk and leave only "atmel,maxtouch" as compatible that
everyone should be using.

The changes to the driver to support the existing DTSes can of course be
applied.

Rob, any objections?

>  
>  - reg: The I2C address of the device
>  
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 7659bc48f1db..e8ef83f168d6 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -3238,7 +3238,11 @@ static int __maybe_unused mxt_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(mxt_pm_ops, mxt_suspend, mxt_resume);
>  
>  static const struct of_device_id mxt_of_match[] = {
> +	{ .compatible = "atmel,qt602240_ts", },
> +	{ .compatible = "atmel,atmel_mxt_ts", },
> +	{ .compatible = "atmel,atmel_mxt_tp", },
>  	{ .compatible = "atmel,maxtouch", },
> +	{ .compatible = "atmel,mXT224", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, mxt_of_match);
> -- 
> 2.14.3
> 

Thanks.

-- 
Dmitry
