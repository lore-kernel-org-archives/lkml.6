Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB8DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1A9218F0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545229684;
	bh=jnQpV7irGw0FJ2r3Y80pM0h1727LBPrPecduTGnppsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TcHjbQPavGAb9vVcsU4+eP7//NtBPqkDDn5BMbzvAHJK/43bOIR/1MgcNgQxTUtO2
	 z/S9HZFKyxaeddhtiEiWaIt0u/GprHn+JjgzNRubTGaA3WvhHyQR3FMM/Yt79a+mFc
	 xpskG1JUkiC+0RfQKye0wMDGCUqjWyTPdKXNVv2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbeLSO2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:28:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45755 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbeLSO2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:28:02 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so19210429ota.12;
        Wed, 19 Dec 2018 06:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJjU9G59ggOYuSLlOYWVrtyQIwxGuTNLC8frx+ycooQ=;
        b=ZiDPeR2uTAYQrOip1hD2UCFFUNt/h366JoTYW7lc25jvUsPy8OzvkgA+DmFysp4+Ik
         A01tvTFNK/9FCgvK2n3ud236KfLX1whsxGJVhsndYwOhMd4cgz4s6CEdgDZWRIo8EdG4
         71O9PBR8ioS6vUmTFINt1pPRGq0weLx391l9OfFPMZ+b6ZB3DVUx4Fl6QnNrIPDkFPHn
         3BRkaXno4CqUzLqnUpUKTJ1B3vr7ADypTRnFBD55sD4lCT0TGvEsU7rRmoftX1hCj4Zn
         CFTrUqqFIbMRyZDfuNCk+3mw0UMznncqUE+ke1gggaKKmOqSueUQ0vtIQma18ioYG3+B
         i5gA==
X-Gm-Message-State: AA+aEWYKUu7Wv0WWCXADKlfUz15FhsxD/qalH+jX5q7grEN2lciau8nK
        hDeGPcZHpzhmAbzpMR0MaJFOq5huw7H86Ba3Tc8=
X-Google-Smtp-Source: AFSGD/XasW5rW8BZqQBryCial26Kytt2Zw7vtqs4nqFCLqP5DrrS/TSSnHq4Gy4rhYP/+KHXZ+ln0Bkvabyp8nGuYVk=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr14075278otf.124.1545229681323;
 Wed, 19 Dec 2018 06:28:01 -0800 (PST)
MIME-Version: 1.0
References: <154466182249.9126.3905559325944768059.stgit@ahduyck-desk1.jf.intel.com>
 <154466189880.9126.10737761541647369077.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154466189880.9126.10737761541647369077.stgit@ahduyck-desk1.jf.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Dec 2018 15:27:48 +0100
Message-ID: <CAJZ5v0hSWOb4b7FWJmfi86mYY+T1kedtC=ydS8VMUvpH4ctzbw@mail.gmail.com>
Subject: Re: [driver-core PATCH v9 1/9] driver core: Establish order of
 operations for device_add and device_del via bitflag
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

On Thu, Dec 13, 2018 at 1:45 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> Add an additional bit flag to the device struct named "dead".
>
> This additional flag provides a guarantee that when a device_del is
> executed on a given interface an async worker will not attempt to attach
> the driver following the earlier device_del call. Previously this
> guarantee was not present and could result in the device_del call
> attempting to remove a driver from an interface only to have the async
> worker attempt to probe the driver later when it finally completes the
> asynchronous probe call.
>
> One additional change added was that I pulled the check for dev->driver
> out of the __device_attach_driver call and instead placed it in the
> __device_attach_async_helper call. This was motivated by the fact that the
> only other caller of this, __device_attach, had already taken the
> device_lock() and checked for dev->driver. Instead of testing for this
> twice in this path it makes more sense to just consolidate the dev->dead
> and dev->driver checks together into one set of checks.
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/core.c    |   11 +++++++++++
>  drivers/base/dd.c      |   22 +++++++++++-----------
>  include/linux/device.h |    5 +++++
>  3 files changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 0073b09bb99f..950e25495726 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2080,6 +2080,17 @@ void device_del(struct device *dev)
>         struct kobject *glue_dir = NULL;
>         struct class_interface *class_intf;
>
> +       /*
> +        * Hold the device lock and set the "dead" flag to guarantee that
> +        * the update behavior is consistent with the other bitfields near
> +        * it and that we cannot have an asynchronous probe routine trying
> +        * to run while we are tearing out the bus/class/sysfs from
> +        * underneath the device.
> +        */
> +       device_lock(dev);
> +       dev->dead = true;
> +       device_unlock(dev);
> +
>         /* Notify clients of device removal.  This call must come
>          * before dpm_sysfs_remove().
>          */
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 88713f182086..74c194ac99df 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -731,15 +731,6 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>         bool async_allowed;
>         int ret;
>
> -       /*
> -        * Check if device has already been claimed. This may
> -        * happen with driver loading, device discovery/registration,
> -        * and deferred probe processing happens all at once with
> -        * multiple threads.
> -        */
> -       if (dev->driver)
> -               return -EBUSY;
> -
>         ret = driver_match_device(drv, dev);
>         if (ret == 0) {
>                 /* no match */
> @@ -774,6 +765,15 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
>
>         device_lock(dev);
>
> +       /*
> +        * Check if device has already been removed or claimed. This may
> +        * happen with driver loading, device discovery/registration,
> +        * and deferred probe processing happens all at once with
> +        * multiple threads.
> +        */
> +       if (dev->dead || dev->driver)
> +               goto out_unlock;
> +
>         if (dev->parent)
>                 pm_runtime_get_sync(dev->parent);
>
> @@ -784,7 +784,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
>
>         if (dev->parent)
>                 pm_runtime_put(dev->parent);
> -
> +out_unlock:
>         device_unlock(dev);
>
>         put_device(dev);
> @@ -897,7 +897,7 @@ static int __driver_attach(struct device *dev, void *data)
>         if (dev->parent && dev->bus->need_parent_lock)
>                 device_lock(dev->parent);
>         device_lock(dev);
> -       if (!dev->driver)
> +       if (!dev->dead && !dev->driver)
>                 driver_probe_device(drv, dev);
>         device_unlock(dev);
>         if (dev->parent && dev->bus->need_parent_lock)
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 1b25c7a43f4c..f73dad81e811 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -957,6 +957,10 @@ struct dev_links_info {
>   *              device.
>   * @dma_coherent: this particular device is dma coherent, even if the
>   *             architecture supports non-coherent devices.
> + * @dead:      This device is currently either in the process of or has
> + *             been removed from the system. Any asynchronous events
> + *             scheduled for this device should exit without taking any
> + *             action.
>   *
>   * At the lowest level, every device in a Linux system is represented by an
>   * instance of struct device. The device structure contains the information
> @@ -1051,6 +1055,7 @@ struct device {
>      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>         bool                    dma_coherent:1;
>  #endif
> +       bool                    dead:1;
>  };
>
>  static inline struct device *kobj_to_dev(struct kobject *kobj)
>
