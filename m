Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270A9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53EC2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53EC2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeH2VNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:13:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:49708 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbeH2VNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:13:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 10:15:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="84420664"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2018 10:15:43 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1fv44E-0003BG-10; Wed, 29 Aug 2018 20:15:42 +0300
Date:   Wed, 29 Aug 2018 20:15:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver core: convert printk(KERN_<LEVEL> ...) to
 pr_<level>
Message-ID: <20180829171542.GF11447@smile.fi.intel.com>
References: <20180827152715.57456-1-andriy.shevchenko@linux.intel.com>
 <4b9c74f372e6b72031e960d32b7d289c74cc6a09.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b9c74f372e6b72031e960d32b7d289c74cc6a09.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:52:27AM -0700, Joe Perches wrote:
> On Mon, 2018-08-27 at 18:27 +0300, Andy Shevchenko wrote:
> > Convert printk:s to pr_* format.
> > 
> > Note, printk(KERN_DEBUG ...) is left untouched due to side effects
> >       of pr_debug().
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/base/dd.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index edfc9f0b1180..f0434695961f 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -321,8 +321,8 @@ bool device_is_bound(struct device *dev)
> >  static void driver_bound(struct device *dev)
> >  {
> >  	if (device_is_bound(dev)) {
> > -		printk(KERN_WARNING "%s: device %s already bound\n",
> > -			__func__, kobject_name(&dev->kobj));
> > +		pr_warn("%s: device %s already bound\n", __func__,
> > +			kobject_name(&dev->kobj));
> _
> While I believe adding __func__ to printks is not generally
> useful, perhaps it's better to use pr_fmt like:
> 
> #define pr_fmt(fmt) "%s: " fmt, __func__
> 
> to make it easier to remove the __func__ uses too.
> 
> Maybe

Your patch LGTM.
Feel free to resend properly with my either Rb or SoB tags.

> ---
>  drivers/base/dd.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index edfc9f0b1180..5ad3a7f77013 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -16,6 +16,8 @@
>   * Copyright (c) 2007-2009 Novell Inc.
>   */
>  
> +#define pr_fmt(fmt) "%s: " fmt, __func__
> +
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> @@ -321,13 +323,12 @@ bool device_is_bound(struct device *dev)
>  static void driver_bound(struct device *dev)
>  {
>  	if (device_is_bound(dev)) {
> -		printk(KERN_WARNING "%s: device %s already bound\n",
> -			__func__, kobject_name(&dev->kobj));
> +		pr_warn("device %s already bound\n", kobject_name(&dev->kobj));
>  		return;
>  	}
>  
> -	pr_debug("driver: '%s': %s: bound to device '%s'\n", dev->driver->name,
> -		 __func__, dev_name(dev));
> +	pr_debug("driver: '%s': bound to device '%s'\n",
> +		 dev->driver->name, dev_name(dev));
>  
>  	klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
>  	device_links_driver_bound(dev);
> @@ -468,8 +469,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  		return ret;
>  
>  	atomic_inc(&probe_count);
> -	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
> -		 drv->bus->name, __func__, drv->name, dev_name(dev));
> +	pr_debug("bus: '%s': probing driver %s with device %s\n",
> +		 drv->bus->name, drv->name, dev_name(dev));
>  	WARN_ON(!list_empty(&dev->devres_head));
>  
>  re_probe:
> @@ -485,8 +486,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  		goto dma_failed;
>  
>  	if (driver_sysfs_add(dev)) {
> -		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
> -			__func__, dev_name(dev));
> +		pr_err("driver_sysfs_add(%s) failed\n", dev_name(dev));
>  		goto probe_failed;
>  	}
>  
> @@ -532,8 +532,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  
>  	driver_bound(dev);
>  	ret = 1;
> -	pr_debug("bus: '%s': %s: bound device %s to driver %s\n",
> -		 drv->bus->name, __func__, dev_name(dev), drv->name);
> +	pr_debug("bus: '%s': bound device %s to driver %s\n",
> +		 drv->bus->name, dev_name(dev), drv->name);
>  	goto done;
>  
>  probe_failed:
> @@ -566,9 +566,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  		break;
>  	default:
>  		/* driver matched but the probe failed */
> -		printk(KERN_WARNING
> -		       "%s: probe of %s failed with error %d\n",
> -		       drv->name, dev_name(dev), ret);
> +		pr_warn("probe of %s failed with error %d\n",
> +			drv->name, dev_name(dev), ret);
>  	}
>  	/*
>  	 * Ignore errors returned by ->probe so that the next driver can try
> @@ -606,8 +605,7 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
>   */
>  int driver_probe_done(void)
>  {
> -	pr_debug("%s: probe_count = %d\n", __func__,
> -		 atomic_read(&probe_count));
> +	pr_debug("probe_count = %d\n", atomic_read(&probe_count));
>  	if (atomic_read(&probe_count))
>  		return -EBUSY;
>  	return 0;
> @@ -648,8 +646,8 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
>  	if (!device_is_registered(dev))
>  		return -ENODEV;
>  
> -	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
> -		 drv->bus->name, __func__, dev_name(dev), drv->name);
> +	pr_debug("bus: '%s': matched device %s with driver %s\n",
> +		 drv->bus->name, dev_name(dev), drv->name);
>  
>  	pm_runtime_get_suppliers(dev);
>  	if (dev->parent)
> 

-- 
With Best Regards,
Andy Shevchenko


