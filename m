Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71367C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F182086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544784040;
	bh=azR1yfXPD5jGz6q75rhb3q5TiYrrnMfZOOwhc/j2q8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w00cr8lkkZ1kZqVcph/2s4iYns3LzbedPHEkyY/f+coB/3LeghSdkitFDI8RWatNW
	 u+axSBxE6LECS36hlz8FiMtBcPNhlIfgrSRnV07r2NXyFtx9sgkloYaa1UvaT2GAQ2
	 76NV2tVNC4V4IOIfqztGlGQR1+w5TjUP6G8ba3JE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F182086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbeLNKkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:40:39 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40895 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:40:38 -0500
Received: by mail-oi1-f195.google.com with SMTP id t204so4163683oie.7;
        Fri, 14 Dec 2018 02:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MeCeuzp0TzWYsfPDQjPX7DFN7BWZp3zrbMmpz3lb1Eg=;
        b=WcwysGV1M5FV0Di6u0BV1ULZeqceSfVDjZ7SVJVPBlucO6GpIJiPuboFnKtIDNMYhH
         901srAOR77g03kVu8MS4R/A/ynHyHgX8XnNjlrxbDiU3+D68RvaFzN6mSbQKWt10mrLD
         5Wr6rImWZ9OQw94V/Gs7zS8XXlYJF0R/8jIr3zWu1/axa6TGe76vP+pkwkT23qrbF0GV
         zaJCPqUtJg9eEJ5AEVlp4RKfIevR2N++eygQ5RlcKDg12PTZZ4GurskrWAjsq+oLxjos
         vXyekKRiV26DN+hXdlFpDWQ5aFep+T1oZsp5mJQsZW3OalYP7rBSdVn+ErFDrk8jVBDZ
         gzxg==
X-Gm-Message-State: AA+aEWZbsxA2WmScqKgPCEIU1poCaCdRVJszTFXdkG9LK5OaExdIsjBy
        dQMcllmnJa2Zz6kVOLCFhBFbQyUn36lugkfamBY=
X-Google-Smtp-Source: AFSGD/U49OdCLZkOfkxftoKoNWeX73ewKgqAIy/pOUvqgi/anl3ehuBISidq7T79HOAxiDrx79mJewLrHzj6peYny+E=
X-Received: by 2002:aca:368a:: with SMTP id d132mr1497197oia.193.1544784036863;
 Fri, 14 Dec 2018 02:40:36 -0800 (PST)
MIME-Version: 1.0
References: <154466182249.9126.3905559325944768059.stgit@ahduyck-desk1.jf.intel.com>
 <154466190393.9126.148371211828405339.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154466190393.9126.148371211828405339.stgit@ahduyck-desk1.jf.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Dec 2018 11:40:25 +0100
Message-ID: <CAJZ5v0it33gOgjR8KUqsGtykh7UovZ5MUbJeEavHDa2uQSXM0g@mail.gmail.com>
Subject: Re: [driver-core PATCH v9 2/9] device core: Consolidate locking and
 unlocking of parent and device
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        dave.jiang@intel.com, bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 somOn Thu, Dec 13, 2018 at 1:45 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> Try to consolidate all of the locking and unlocking of both the parent and
> device when attaching or removing a driver from a given device.
>
> To do that I first consolidated the lock pattern into two functions
> __device_driver_lock and __device_driver_unlock. After doing that I then
> created functions specific to attaching and detaching the driver while
> acquiring these locks. By doing this I was able to reduce the number of
> spots where we touch need_parent_lock from 12 down to 4.
>
> This patch should produce no functional changes, it is meant to be a code
> clean-up/consolidation only.
>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/base/base.h |    2 +
>  drivers/base/bus.c  |   23 ++----------
>  drivers/base/dd.c   |   95 ++++++++++++++++++++++++++++++++++++++++-----------
>  3 files changed, 81 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 7a419a7a6235..3f22ebd6117a 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -124,6 +124,8 @@ extern int driver_add_groups(struct device_driver *drv,
>                              const struct attribute_group **groups);
>  extern void driver_remove_groups(struct device_driver *drv,
>                                  const struct attribute_group **groups);
> +int device_driver_attach(struct device_driver *drv, struct device *dev);
> +void device_driver_detach(struct device *dev);
>
>  extern char *make_class_name(const char *name, struct kobject *kobj);
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index b886b15cb53b..74054481007d 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -184,11 +184,7 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
>
>         dev = bus_find_device_by_name(bus, NULL, buf);
>         if (dev && dev->driver == drv) {
> -               if (dev->parent && dev->bus->need_parent_lock)
> -                       device_lock(dev->parent);
> -               device_release_driver(dev);
> -               if (dev->parent && dev->bus->need_parent_lock)
> -                       device_unlock(dev->parent);
> +               device_driver_detach(dev);
>                 err = count;
>         }
>         put_device(dev);
> @@ -211,13 +207,7 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
>
>         dev = bus_find_device_by_name(bus, NULL, buf);
>         if (dev && dev->driver == NULL && driver_match_device(drv, dev)) {
> -               if (dev->parent && bus->need_parent_lock)
> -                       device_lock(dev->parent);
> -               device_lock(dev);
> -               err = driver_probe_device(drv, dev);
> -               device_unlock(dev);
> -               if (dev->parent && bus->need_parent_lock)
> -                       device_unlock(dev->parent);
> +               err = device_driver_attach(drv, dev);
>
>                 if (err > 0) {
>                         /* success */
> @@ -771,13 +761,8 @@ EXPORT_SYMBOL_GPL(bus_rescan_devices);
>   */
>  int device_reprobe(struct device *dev)
>  {
> -       if (dev->driver) {
> -               if (dev->parent && dev->bus->need_parent_lock)
> -                       device_lock(dev->parent);
> -               device_release_driver(dev);
> -               if (dev->parent && dev->bus->need_parent_lock)
> -                       device_unlock(dev->parent);
> -       }
> +       if (dev->driver)
> +               device_driver_detach(dev);
>         return bus_rescan_devices_helper(dev, NULL);
>  }
>  EXPORT_SYMBOL_GPL(device_reprobe);
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 74c194ac99df..f07c16277ed9 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -867,6 +867,64 @@ void device_initial_probe(struct device *dev)
>         __device_attach(dev, true);
>  }
>
> +/*
> + * __device_driver_lock - acquire locks needed to manipulate dev->drv
> + * @dev: Device we will update driver info for
> + * @parent: Parent device. Needed if the bus requires parent lock
> + *
> + * This function will take the required locks for manipulating dev->drv.
> + * Normally this will just be the @dev lock, but when called for a USB
> + * interface, @parent lock will be held as well.
> + */
> +static void __device_driver_lock(struct device *dev, struct device *parent)
> +{
> +       if (parent && dev->bus->need_parent_lock)
> +               device_lock(parent);
> +       device_lock(dev);
> +}
> +
> +/*
> + * __device_driver_unlock - release locks needed to manipulate dev->drv
> + * @dev: Device we will update driver info for
> + * @parent: Parent device. Needed if the bus requires parent lock
> + *
> + * This function will release the required locks for manipulating dev->drv.
> + * Normally this will just be the the @dev lock, but when called for a
> + * USB interface, @parent lock will be released as well.
> + */
> +static void __device_driver_unlock(struct device *dev, struct device *parent)
> +{
> +       device_unlock(dev);
> +       if (parent && dev->bus->need_parent_lock)
> +               device_unlock(parent);
> +}
> +
> +/**
> + * device_driver_attach - attach a specific driver to a specific device
> + * @drv: Driver to attach
> + * @dev: Device to attach it to
> + *
> + * Manually attach driver to a device. Will acquire both @dev lock and
> + * @dev->parent lock if needed.
> + */
> +int device_driver_attach(struct device_driver *drv, struct device *dev)
> +{
> +       int ret = 0;
> +
> +       __device_driver_lock(dev, dev->parent);
> +
> +       /*
> +        * If device has been removed or someone has already successfully
> +        * bound a driver before us just skip the driver probe call.
> +        */
> +       if (!dev->dead && !dev->driver)
> +               ret = driver_probe_device(drv, dev);
> +
> +       __device_driver_unlock(dev, dev->parent);
> +
> +       return ret;
> +}
> +
>  static int __driver_attach(struct device *dev, void *data)
>  {
>         struct device_driver *drv = data;
> @@ -894,14 +952,7 @@ static int __driver_attach(struct device *dev, void *data)
>                 return ret;
>         } /* ret > 0 means positive match */
>
> -       if (dev->parent && dev->bus->need_parent_lock)
> -               device_lock(dev->parent);
> -       device_lock(dev);
> -       if (!dev->dead && !dev->driver)
> -               driver_probe_device(drv, dev);
> -       device_unlock(dev);
> -       if (dev->parent && dev->bus->need_parent_lock)
> -               device_unlock(dev->parent);
> +       device_driver_attach(drv, dev);
>
>         return 0;
>  }
> @@ -932,15 +983,11 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>         drv = dev->driver;
>         if (drv) {
>                 while (device_links_busy(dev)) {
> -                       device_unlock(dev);
> -                       if (parent)
> -                               device_unlock(parent);
> +                       __device_driver_unlock(dev, parent);
>
>                         device_links_unbind_consumers(dev);
> -                       if (parent)
> -                               device_lock(parent);
>
> -                       device_lock(dev);
> +                       __device_driver_lock(dev, parent);
>                         /*
>                          * A concurrent invocation of the same function might
>                          * have released the driver successfully while this one

This change will clash with
https://patchwork.kernel.org/patch/10729571/ somewhat which really
should go it first as a stable-candidate fix.

I would suggest rebasing on top of that one, unless Greg has different
plans here.

> @@ -993,16 +1040,12 @@ void device_release_driver_internal(struct device *dev,
>                                     struct device_driver *drv,
>                                     struct device *parent)
>  {
> -       if (parent && dev->bus->need_parent_lock)
> -               device_lock(parent);
> +       __device_driver_lock(dev, parent);
>
> -       device_lock(dev);
>         if (!drv || drv == dev->driver)
>                 __device_release_driver(dev, parent);
>
> -       device_unlock(dev);
> -       if (parent && dev->bus->need_parent_lock)
> -               device_unlock(parent);
> +       __device_driver_unlock(dev, parent);
>  }
>
>  /**
> @@ -1027,6 +1070,18 @@ void device_release_driver(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(device_release_driver);
>
> +/**
> + * device_driver_detach - detach driver from a specific device
> + * @dev: device to detach driver from
> + *
> + * Detach driver from device. Will acquire both @dev lock and @dev->parent
> + * lock if needed.
> + */
> +void device_driver_detach(struct device *dev)
> +{
> +       device_release_driver_internal(dev, NULL, dev->parent);
> +}
> +
>  /**
>   * driver_detach - detach driver from all devices it controls.
>   * @drv: driver.
>
