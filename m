Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58159C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C489213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C489213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeJLPXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:23:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34086 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeJLPXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:23:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id v2so4403259otk.1;
        Fri, 12 Oct 2018 00:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UtLMv2ZYUDb6cjred02Ty+Kh+xYn7vbSRp8snPMDRX0=;
        b=Y9r9FMlDTY4wRg12pm7ZQuybaHVk3i44PHlxwlVGf7hssWaqORuSiWyjbKUV+kMsNc
         DAG9ThtJ8OU7dB1cwvDWzqro/MfgQTa0defGEcLXZSq0kfZWtya1tsdZAhSB78SGJDnB
         MHv72mgKqlAZxQl0yg3woWvKGCXQIHgeqS767a5sp4bCzXkj8hmTKK6hKDZqOhsaVmWY
         3GAc5IfpZuIi1m6Rm9OZxWlBIwPVnkY3+ApaiuDPx6oIOSPtldxTZDEHPEY/YtE+rN7d
         0QVxoSBuQXb2XQL8HUSXlZ7YPQ20/RBKFtd/2xnlVwAqCaRostWu04Vw/qXzyMTdZ3mI
         FmGg==
X-Gm-Message-State: ABuFfoiRTveTx6tz6sRnfn5Mk5P/GzY2X8rGUWXHDpbOoicaYSk4pO8B
        Rf1BzwDPxPH+h5gzcIj1hQbcNVWEGiZyAf6xIvA=
X-Google-Smtp-Source: ACcGV62FGj2yzP+4HHDAus8Oe6xcnTOc0iEsudEVPVNNendrIS9psWdL3W+0u8G1xh5hOgbYM5wk0FxqwQhB8ik5L2s=
X-Received: by 2002:a9d:4c90:: with SMTP id m16mr2980711otf.124.1539330745101;
 Fri, 12 Oct 2018 00:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181011220134.1408.63391.stgit@localhost.localdomain> <20181011220933.1408.6882.stgit@localhost.localdomain>
In-Reply-To: <20181011220933.1408.6882.stgit@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Oct 2018 09:52:12 +0200
Message-ID: <CAJZ5v0gEssyHx-Ao+PfopHziBQ=WnU2cspSPpvEN=B_E-EVDPA@mail.gmail.com>
Subject: Re: [driver-core PATCH v3 3/5] driver core: Probe devices
 asynchronously instead of the driver
To:     alexander.h.duyck@linux.intel.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, zwisler@kernel.org,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:10 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This change makes it so that we probe devices asynchronously instead of the
> driver. This results in us seeing the same behavior if the device is
> registered before the driver or after. This way we can avoid serializing
> the initialization should the driver not be loaded until after the devices
> have already been added.
>
> The motivation behind this is that if we have a set of devices that
> take a significant amount of time to load we can greatly reduce the time to
> load by processing them in parallel instead of one at a time. In addition,
> each device can exist on a different node so placing a single thread on one
> CPU to initialize all of the devices for a given driver can result in poor
> performance on a system with multiple nodes.
>
> One issue I can see with this patch is that I am using the
> dev_set/get_drvdata functions to store the driver in the device while I am
> waiting on the asynchronous init to complete. For now I am protecting it by
> using the lack of a dev->driver and the device lock.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/base/bus.c |   23 +++--------------------
>  drivers/base/dd.c  |   42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 8bfd27ec73d6..2a17bed657ec 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -616,17 +616,6 @@ static ssize_t uevent_store(struct device_driver *drv, const char *buf,
>  }
>  static DRIVER_ATTR_WO(uevent);
>
> -static void driver_attach_async(void *_drv, async_cookie_t cookie)
> -{
> -       struct device_driver *drv = _drv;
> -       int ret;
> -
> -       ret = driver_attach(drv);
> -
> -       pr_debug("bus: '%s': driver %s async attach completed: %d\n",
> -                drv->bus->name, drv->name, ret);
> -}
> -
>  /**
>   * bus_add_driver - Add a driver to the bus.
>   * @drv: driver.
> @@ -659,15 +648,9 @@ int bus_add_driver(struct device_driver *drv)
>
>         klist_add_tail(&priv->knode_bus, &bus->p->klist_drivers);
>         if (drv->bus->p->drivers_autoprobe) {
> -               if (driver_allows_async_probing(drv)) {
> -                       pr_debug("bus: '%s': probing driver %s asynchronously\n",
> -                               drv->bus->name, drv->name);
> -                       async_schedule(driver_attach_async, drv);
> -               } else {
> -                       error = driver_attach(drv);
> -                       if (error)
> -                               goto out_unregister;
> -               }
> +               error = driver_attach(drv);
> +               if (error)
> +                       goto out_unregister;
>         }
>         module_add_driver(drv->owner, drv);
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 169412ee4ae8..5ba366c1cb83 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -864,6 +864,29 @@ void device_initial_probe(struct device *dev)
>         __device_attach(dev, true);
>  }
>
> +static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
> +{
> +       struct device *dev = _dev;
> +
> +       if (dev->parent && dev->bus->need_parent_lock)
> +               device_lock(dev->parent);
> +       device_lock(dev);
> +
> +       if (!dev->driver) {
> +               struct device_driver *drv = dev_get_drvdata(dev);
> +
> +               driver_probe_device(drv, dev);
> +       }
> +
> +       dev_dbg(dev, "async probe completed\n");
> +
> +       device_unlock(dev);
> +       if (dev->parent && dev->bus->need_parent_lock)
> +               device_unlock(dev->parent);

The above duplicates some code from __driver_attach().

You could avoid that by adding one more function to call directly from
__driver_attach() in the "sync" case and from here, along the lines of
what the PM code does.

> +
> +       put_device(dev);
> +}
> +
>  static int __driver_attach(struct device *dev, void *data)
>  {
>         struct device_driver *drv = data;
> @@ -891,6 +914,25 @@ static int __driver_attach(struct device *dev, void *data)
>                 return ret;
>         } /* ret > 0 means positive match */
>
> +       if (driver_allows_async_probing(drv)) {
> +               /*
> +                * Instead of probing the device synchronously we will
> +                * probe it asynchronously to allow for more parallelism.
> +                *
> +                * We only take the device lock here in order to guarantee
> +                * that the dev->driver and driver_data fields are protected
> +                */
> +               dev_dbg(dev, "scheduling asynchronous probe\n");
> +               device_lock(dev);
> +               if (!dev->driver) {
> +                       get_device(dev);
> +                       dev_set_drvdata(dev, drv);
> +                       async_schedule(__driver_attach_async_helper, dev);
> +               }
> +               device_unlock(dev);
> +               return 0;
> +       }
> +
>         if (dev->parent && dev->bus->need_parent_lock)
>                 device_lock(dev->parent);
>         device_lock(dev);
>
