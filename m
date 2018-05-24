Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034751AbeEXW3D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:29:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33553 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966228AbeEXW26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:28:58 -0400
X-Google-Smtp-Source: AB8JxZpV5G7anHsjziLApSow9Wh5Q7QIKA9NFePE6m4wq5XQozVmDlSeQV6mpUsFkgfEGFQc5t8c4w==
Date: Thu, 24 May 2018 15:28:55 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/8] driver core: make deferring probe after init
 optional
Message-ID: <20180524222855.GD14924@minitux>
References: <20180524175024.19874-1-robh@kernel.org>
 <20180524175024.19874-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524175024.19874-2-robh@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 May 10:50 PDT 2018, Rob Herring wrote:

> Deferred probe will currently wait forever on dependent devices to probe,
> but sometimes a driver will never exist. It's also not always critical for
> a driver to exist. Platforms can rely on default configuration from the
> bootloader or reset defaults for things such as pinctrl and power domains.
> This is often the case with initial platform support until various drivers
> get enabled. There's at least 2 scenarios where deferred probe can render
> a platform broken. Both involve using a DT which has more devices and
> dependencies than the kernel supports. The 1st case is a driver may be
> disabled in the kernel config. The 2nd case is the kernel version may
> simply not have the dependent driver. This can happen if using a newer DT
> (provided by firmware perhaps) with a stable kernel version.
> 
> Subsystems or drivers may opt-in to this behavior by calling
> driver_deferred_probe_check_init_done() instead of just returning
> -EPROBE_DEFER. They may use additional information from DT or kernel's
> config to decide whether to continue to defer probe or not.
> 

For builtin drivers this still looks reasonable.

But I would like to have an additional clarification here stating that
drivers that might be targeted by this query must not be compiled as
modules.

And I would prefer to see an ack from e.g. Arnd that arm-soc is okay
that we drop "tristate" on drivers affected by this; e.g. if we put this
in the pinctrl core then all pinctrl drivers should be "bool" and so
should any i2c, ssbi and spmi buses and drivers be.

Regards,
Bjorn

> Cc: Alexander Graf <agraf@suse.de>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/base/dd.c      | 17 +++++++++++++++++
>  include/linux/device.h |  2 ++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index c9f54089429b..d6034718da6f 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -226,6 +226,16 @@ void device_unblock_probing(void)
>  	driver_deferred_probe_trigger();
>  }
>  
> +int driver_deferred_probe_check_init_done(struct device *dev, bool optional)
> +{
> +	if (optional && initcalls_done) {
> +		dev_WARN(dev, "ignoring dependency for device, assuming no driver");
> +		return -ENODEV;
> +	}
> +
> +	return -EPROBE_DEFER;
> +}
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
> @@ -240,6 +250,13 @@ static int deferred_probe_initcall(void)
>  	/* Sort as many dependencies as possible before exiting initcalls */
>  	flush_work(&deferred_probe_work);
>  	initcalls_done = true;
> +
> +	/*
> +	 * Trigger deferred probe again, this time we won't defer anything
> +	 * that is optional
> +	 */
> +	driver_deferred_probe_trigger();
> +	flush_work(&deferred_probe_work);
>  	return 0;
>  }
>  late_initcall(deferred_probe_initcall);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 477956990f5e..f3dafd44c285 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -334,6 +334,8 @@ struct device *driver_find_device(struct device_driver *drv,
>  				  struct device *start, void *data,
>  				  int (*match)(struct device *dev, void *data));
>  
> +int driver_deferred_probe_check_init_done(struct device *dev, bool optional);
> +
>  /**
>   * struct subsys_interface - interfaces to device functions
>   * @name:       name of the device function
> -- 
> 2.17.0
> 
