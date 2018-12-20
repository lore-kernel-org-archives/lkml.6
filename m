Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0892FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C011E218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545304345;
	bh=Z1RtiamxNdkQLjthF/Os4scAVy5XWYySiawRDzjW1Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UA6N7xK/7rZ69st8ZYzQ/oeKIRHLIRfD6YMmXJIsVt/aCnWCJSiztmFyiiIs4DT01
	 I5WXuzsI8uDJf30dfgcgXEVPoEOI3iaS+KhooQEMtSu8fR8gRr0lNarfCN6MypAgJ7
	 mqwu05g1FHMR6sOi1JduWUPvgxcak3Jm3T2s4HOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbeLTLMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:12:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729529AbeLTLMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:12:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A3721773;
        Thu, 20 Dec 2018 11:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545304342;
        bh=Z1RtiamxNdkQLjthF/Os4scAVy5XWYySiawRDzjW1Ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSFgg8nZC64+zf+1Et3LXMrQXmWdc+vZJdo3jPHSfFye+nFTldbB4N/d1uido7SYY
         gS5bS/VbxqnPneqxWOLDwtFByJjGEkBbT4heQv+6Qlyoz6llP9f4DBvteT1sDuCJkw
         h44s6SxDL9+RTR2tqQNcgzwoCEN4DlMwAcqrgo8c=
Date:   Thu, 20 Dec 2018 12:12:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 2/3] driver core: add deferring probe reason to
 devices_deferred property
Message-ID: <20181220111220.GA10978@kroah.com>
References: <20181220102247.4911-1-a.hajda@samsung.com>
 <CGME20181220102259eucas1p1884a0b68ce342239c2a43a74cc50725a@eucas1p1.samsung.com>
 <20181220102247.4911-3-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220102247.4911-3-a.hajda@samsung.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:22:46AM +0100, Andrzej Hajda wrote:
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is probe_err function introduced recently,
> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
> will be attached to deferred device and printed when user read devices_deferred
> property.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> v4:
>   - removed NULL check before kfree,
>   - coding style tweaking.
> v3:
>   - adjusted deferred_devs_show, to accept newline ended messages,
>   - changed conditonal check to positive,
>   - added R-b by Andy.
> v2:
>   - changed __deferred_probe_set_msg args - like in __dev_printk, fits better,
>   - use kasprintf instead of bunch of code,
>   - keep consistent format of devices_deferred lines,
>   - added R-Bs (again I hope changes above are not against it).
> ---
> ---
>  drivers/base/base.h |  3 +++
>  drivers/base/core.c |  9 +++++----
>  drivers/base/dd.c   | 21 ++++++++++++++++++++-
>  3 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 7a419a7a6235..effbd5e7f9f1 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -75,6 +75,7 @@ struct device_private {
>  	struct klist_node knode_driver;
>  	struct klist_node knode_bus;
>  	struct list_head deferred_probe;
> +	char *deferred_probe_msg;
>  	struct device *device;
>  };
>  #define to_device_private_parent(obj)	\
> @@ -113,6 +114,8 @@ extern void device_release_driver_internal(struct device *dev,
>  extern void driver_detach(struct device_driver *drv);
>  extern int driver_probe_device(struct device_driver *drv, struct device *dev);
>  extern void driver_deferred_probe_del(struct device *dev);
> +extern void __deferred_probe_set_msg(const struct device *dev,
> +				     struct va_format *vaf);
>  static inline int driver_match_device(struct device_driver *drv,
>  				      struct device *dev)
>  {
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 7f644f3c41d3..d3eb5aeeaa28 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3108,6 +3108,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>   *
>   * This helper implements common pattern present in probe functions for error
>   * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * In case of -EPROBE_DEFER it sets defer probe reason.
>   * It replaces code sequence:
>   * 	if (err != -EPROBE_DEFER)
>   * 		dev_err(dev, ...);
> @@ -3123,14 +3124,14 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
>  	struct va_format vaf;
>  	va_list args;
>  
> -	if (err == -EPROBE_DEFER)
> -		return err;
> -
>  	va_start(args, fmt);
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  
> -	dev_err(dev, "error %d: %pV", err, &vaf);
> +	if (err == -EPROBE_DEFER)
> +		__deferred_probe_set_msg(dev, &vaf);
> +	else
> +		dev_err(dev, "error %d: %pV", err, &vaf);
>  
>  	va_end(args);
>  
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 88713f182086..857aa4d1d45d 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -27,6 +27,7 @@
>  #include <linux/async.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/devinfo.h>
> +#include <linux/slab.h>
>  
>  #include "base.h"
>  #include "power/power.h"
> @@ -132,6 +133,8 @@ void driver_deferred_probe_del(struct device *dev)
>  	if (!list_empty(&dev->p->deferred_probe)) {
>  		dev_dbg(dev, "Removed from deferred list\n");
>  		list_del_init(&dev->p->deferred_probe);
> +		kfree(dev->p->deferred_probe_msg);
> +		dev->p->deferred_probe_msg = NULL;
>  	}
>  	mutex_unlock(&deferred_probe_mutex);
>  }
> @@ -202,6 +205,21 @@ void device_unblock_probing(void)
>  	driver_deferred_probe_trigger();
>  }
>  
> +/*
> + * __deferred_probe_set_msg() - Set defer probe reason message for device
> + */
> +void __deferred_probe_set_msg(const struct device *dev, struct va_format *vaf)
> +{
> +	const char *drv = dev_driver_string(dev);
> +
> +	mutex_lock(&deferred_probe_mutex);
> +
> +	kfree(dev->p->deferred_probe_msg);
> +	dev->p->deferred_probe_msg = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);

Why do you also need the dev driver string here?  Don't you get it
automatically when you print out the list in deferred_devs_show()?

How about we just wait on this patch, it seems very unneeded.  Or at
least I can't see who would need this, what can a user do with this
information?

thanks,

greg k-h
