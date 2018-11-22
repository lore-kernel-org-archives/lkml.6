Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87346C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2B520838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrS+LEnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2B520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406571AbeKWFcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 00:32:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39072 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404536AbeKWFcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 00:32:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so2279832pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 10:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O0vfx+uyRQqAcdBqfEuTqQctH1f5rEonNvzSVKeNXKo=;
        b=CrS+LEnZKxJq0lekl2KIGTyI04LfSGEbHmK54YFOx/vuqsGyS3GPXjZVotvA1sFXo4
         7WoMhY7u0Q9m/Wc77bQVAGGJarLKnRX1+QDJiS6HGokyNh6ybXlFKQsnvD8O8plNVtMl
         RGeJTWoFK88FNcvr+zXmnuujzVmMHzhgCceQTH9EiuyRAiUIlfTSLeqaskG+m08y+lY2
         xNILgBp7KANCNUJczPefhO6E2R76ynEmHVTxDiaFSPSntPXEo9/Nt1T1rV1j7rSvnaLr
         LmKcLWJNrXLIOu1UwVcjYZ4uvaT1wEZl8QPYvl0qM2kRsQ/ZyrrLm9AwsLWBbjrw5WdT
         h3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=O0vfx+uyRQqAcdBqfEuTqQctH1f5rEonNvzSVKeNXKo=;
        b=SAWHhGCf7OBE0WxlrPJx80Tb9Gh1beDy8NoatY+sdIgTNqWCPbd7qg5xDSeAHIyZx4
         4bLBVvr1lQ0K+qCt4k/Oy2iKuo0GPUNdluvzSR+Lgtk17NFmOQeUBxY48HcC+Lp3sFFI
         XMX/6KbNJN4xZAUYGeg3joMmMRS1rPHgwUfNJoVEXqYCchJ3qlAyzntt4bf1pZ+mWNTs
         5OfbZobENw9373a0K/5b+P9INihUTLCFfzrs5g0ZSTDULeXBkLzoTON58FltRRyOtG7t
         w6VucRSKRHZhvIXHabg+FYPlz8fEYBMNOlnr/tEIGDLtBsp6cC7jbzL0mrMWlO7Ru6EH
         o5ZA==
X-Gm-Message-State: AA+aEWZ6/qnQpq1u1lTKO0PlJ2XQ7OvqfRoyu+VYFVMmIQNizEyF9mbM
        JySHENg/yjtN9xBrSRb+spc=
X-Google-Smtp-Source: AFSGD/U3qGba1lAXmM55a23sTczXbxoHBb+m/0La8MMsiEpQy1L+fY/TvoHYuo46dATUqMB8WrJesw==
X-Received: by 2002:a63:d818:: with SMTP id b24mr10882985pgh.174.1542912723318;
        Thu, 22 Nov 2018 10:52:03 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l87sm47098358pfj.179.2018.11.22.10.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 10:52:02 -0800 (PST)
Date:   Thu, 22 Nov 2018 10:52:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lee.jones@linaro.org, gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4/7] mfd / platform: cros_ec: move debugfs attributes to
 its own driver.
Message-ID: <20181122185200.GA809@roeck-us.net>
References: <20181122113356.23610-1-enric.balletbo@collabora.com>
 <20181122113356.23610-5-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122113356.23610-5-enric.balletbo@collabora.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:33:53PM +0100, Enric Balletbo i Serra wrote:
> The entire way how cros debugfs attibutes are created is broken.
> cros_ec_debugfs should be its own driver and its attributes should be
> associated with a debugfs driver not the mfd driver.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/mfd/cros_ec_dev.c                 | 41 +------------------
>  drivers/platform/chrome/Kconfig           | 10 +++++
>  drivers/platform/chrome/Makefile          |  4 +-
>  drivers/platform/chrome/cros_ec_debugfs.c | 49 ++++++++++++++++++-----
>  include/linux/mfd/cros_ec.h               |  6 ---
>  5 files changed, 53 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 790dc28b93f0..8c7ee2a0b50a 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -403,6 +403,7 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
>  };
>  
>  static const struct mfd_cell cros_ec_platform_cells[] = {
> +	{ .name = "cros-ec-debugfs" },
>  	{ .name = "cros-ec-lightbar" },
>  	{ .name = "cros-ec-vbc" },
>  };
> @@ -496,9 +497,6 @@ static int ec_device_probe(struct platform_device *pdev)
>  		dev_err(ec->dev,
>  			"failed to add cros-ec platform devices: %d\n", retval);
>  
> -	if (cros_ec_debugfs_init(ec))
> -		dev_warn(dev, "failed to create debugfs directory\n");
> -
>  	return 0;
>  
>  failed:
> @@ -510,61 +508,24 @@ static int ec_device_remove(struct platform_device *pdev)
>  {
>  	struct cros_ec_dev *ec = dev_get_drvdata(&pdev->dev);
>  
> -	cros_ec_debugfs_remove(ec);
> -
>  	cdev_del(&ec->cdev);
>  	device_unregister(&ec->class_dev);
>  	return 0;
>  }
>  
> -static void ec_device_shutdown(struct platform_device *pdev)
> -{
> -	struct cros_ec_dev *ec = dev_get_drvdata(&pdev->dev);
> -
> -	/* Be sure to clear up debugfs delayed works */
> -	cros_ec_debugfs_remove(ec);
> -}
> -
>  static const struct platform_device_id cros_ec_id[] = {
>  	{ DRV_NAME, 0 },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, cros_ec_id);
>  
> -static __maybe_unused int ec_device_suspend(struct device *dev)
> -{
> -	struct cros_ec_dev *ec = dev_get_drvdata(dev);
> -
> -	cros_ec_debugfs_suspend(ec);
> -
> -	return 0;
> -}
> -
> -static __maybe_unused int ec_device_resume(struct device *dev)
> -{
> -	struct cros_ec_dev *ec = dev_get_drvdata(dev);
> -
> -	cros_ec_debugfs_resume(ec);
> -
> -	return 0;
> -}
> -
> -static const struct dev_pm_ops cros_ec_dev_pm_ops = {
> -#ifdef CONFIG_PM_SLEEP
> -	.suspend = ec_device_suspend,
> -	.resume = ec_device_resume,
> -#endif
> -};
> -
>  static struct platform_driver cros_ec_dev_driver = {
>  	.driver = {
>  		.name = DRV_NAME,
> -		.pm = &cros_ec_dev_pm_ops,
>  	},
>  	.id_table = cros_ec_id,
>  	.probe = ec_device_probe,
>  	.remove = ec_device_remove,
> -	.shutdown = ec_device_shutdown,
>  };
>  
>  static int __init cros_ec_dev_init(void)
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 29bd9837d520..a1239d48c46f 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -131,4 +131,14 @@ config CROS_EC_VBC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cros_ec_vbc.
>  
> +config CROS_EC_DEBUGFS
> +	tristate "Export ChromeOS EC internals in DebugFS"
> +	depends on MFD_CROS_EC_CHARDEV && DEBUG_FS

Maybe "default MFD_CROS_EC_CHARDEV" ?

> +	help
> +	  This option exposes the ChromeOS EC device internals to
> +	  userspace.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called cros_ec_debugfs.
> +
>  endif # CHROMEOS_PLATFORMS
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 4081b7179df7..12a5c4d18c17 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -3,8 +3,7 @@
>  obj-$(CONFIG_CHROMEOS_LAPTOP)		+= chromeos_laptop.o
>  obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
>  obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
> -cros_ec_ctl-objs			:= cros_ec_sysfs.o \
> -					   cros_ec_debugfs.o
> +cros_ec_ctl-objs			:= cros_ec_sysfs.o
>  obj-$(CONFIG_CROS_EC_CTL)		+= cros_ec_ctl.o
>  obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
>  obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
> @@ -15,3 +14,4 @@ obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
>  obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
>  obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
> +obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index c62ee8e610a0..2ae385a27a1d 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -23,12 +23,16 @@
>  #include <linux/fs.h>
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/mfd/cros_ec_commands.h>
> +#include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/platform_device.h>
>  #include <linux/poll.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/wait.h>
>  
> +#define DRV_NAME "cros-ec-debugfs"
> +
>  #define LOG_SHIFT		14
>  #define LOG_SIZE		(1 << LOG_SHIFT)
>  #define LOG_POLL_SEC		10
> @@ -423,8 +427,9 @@ static int cros_ec_create_pdinfo(struct cros_ec_debugfs *debug_info)
>  	return 0;
>  }
>  
> -int cros_ec_debugfs_init(struct cros_ec_dev *ec)
> +static int cros_ec_debugfs_probe(struct platform_device *pd)
>  {
> +	struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
>  	struct cros_ec_platform *ec_platform = dev_get_platdata(ec->dev);
>  	const char *name = ec_platform->ec_name;
>  	struct cros_ec_debugfs *debug_info;
> @@ -459,20 +464,24 @@ int cros_ec_debugfs_init(struct cros_ec_dev *ec)
>  	debugfs_remove_recursive(debug_info->dir);
>  	return ret;
>  }
> -EXPORT_SYMBOL(cros_ec_debugfs_init);
>  
> -void cros_ec_debugfs_remove(struct cros_ec_dev *ec)
> +static int cros_ec_debugfs_remove(struct platform_device *pd)
>  {
> +	struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
> +
>  	if (!ec->debug_info)
> -		return;
> +		return 0;

This should no long be necessary.

>  
>  	debugfs_remove_recursive(ec->debug_info->dir);
>  	cros_ec_cleanup_console_log(ec->debug_info);
> +
> +	return 0;
>  }
> -EXPORT_SYMBOL(cros_ec_debugfs_remove);
>  
> -void cros_ec_debugfs_suspend(struct cros_ec_dev *ec)
> +static int __maybe_unused cros_ec_debugfs_suspend(struct device *dev)
>  {
> +	struct cros_ec_dev *ec = dev_get_drvdata(dev);
> +
>  	/*
>  	 * cros_ec_debugfs_init() failures are non-fatal; it's also possible
>  	 * that we initted things but decided that console log wasn't supported.

The above comment no longer applies. Also, since this is now its own driver,
the if statement should not be necessary anymore.

> @@ -481,12 +490,34 @@ void cros_ec_debugfs_suspend(struct cros_ec_dev *ec)
>  	 */
>  	if (ec->debug_info && ec->debug_info->log_buffer.buf)
>  		cancel_delayed_work_sync(&ec->debug_info->log_poll_work);
> +
> +	return 0;
>  }
> -EXPORT_SYMBOL(cros_ec_debugfs_suspend);
>  
> -void cros_ec_debugfs_resume(struct cros_ec_dev *ec)
> +static int __maybe_unused cros_ec_debugfs_resume(struct device *dev)
>  {
> +	struct cros_ec_dev *ec = dev_get_drvdata(dev);
> +
>  	if (ec->debug_info && ec->debug_info->log_buffer.buf)
>  		schedule_delayed_work(&ec->debug_info->log_poll_work, 0);

As aabove, the if statement should not be necessary anymore.

> +
> +	return 0;
>  }
> -EXPORT_SYMBOL(cros_ec_debugfs_resume);
> +
> +static SIMPLE_DEV_PM_OPS(cros_ec_debugfs_pm_ops,
> +			 cros_ec_debugfs_suspend, cros_ec_debugfs_resume);
> +
> +static struct platform_driver cros_ec_debugfs_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +		.pm = &cros_ec_debugfs_pm_ops,
> +	},
> +	.probe = cros_ec_debugfs_probe,
> +	.remove = cros_ec_debugfs_remove,
> +};
> +
> +module_platform_driver(cros_ec_debugfs_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Debug logs for ChromeOS EC");
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index ddbb7e18a530..1722c2c26143 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -336,12 +336,6 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
>  /* sysfs stuff */
>  extern struct attribute_group cros_ec_attr_group;
>  
> -/* debugfs stuff */
> -int cros_ec_debugfs_init(struct cros_ec_dev *ec);
> -void cros_ec_debugfs_remove(struct cros_ec_dev *ec);
> -void cros_ec_debugfs_suspend(struct cros_ec_dev *ec);
> -void cros_ec_debugfs_resume(struct cros_ec_dev *ec);
> -
>  /* Attach/detach attributes to the cros_class */
>  extern int cros_ec_attach_attribute_group(struct cros_ec_dev *ec,
>  					  struct attribute_group *attrs);
