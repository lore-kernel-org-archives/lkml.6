Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeC1PJb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:09:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51956 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753897AbeC1PJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:09:30 -0400
X-Google-Smtp-Source: AIpwx48571j+e4ONtIquNHkksHtHoL8cXV9InhVmEcPJjheEsztwh9/vYG7wv8LumjFphTgLxGf0sw==
Date: Wed, 28 Mar 2018 17:09:26 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, intel-gfx@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH] drm: Use srcu to protect drm_device.unplugged
Message-ID: <20180328150926.GC3881@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, intel-gfx@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1522222715-11814-1-git-send-email-andr2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522222715-11814-1-git-send-email-andr2000@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 10:38:35AM +0300, Oleksandr Andrushchenko wrote:
> From: Noralf Trønnes <noralf@tronnes.org>
> 
> Use srcu to protect drm_device.unplugged in a race free manner.
> Drivers can use drm_dev_enter()/drm_dev_exit() to protect and mark
> sections preventing access to device resources that are not available
> after the device is gone.
> 
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Tested-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: intel-gfx@lists.freedesktop.org

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Oleksandr, please push to drm-misc-next once you have dim tools setup up
and everything.

Thanks, Daniel

> ---
>  drivers/gpu/drm/drm_drv.c | 54 ++++++++++++++++++++++++++++++++++++++++++-----
>  include/drm/drm_device.h  |  9 +++++++-
>  include/drm/drm_drv.h     | 15 +++++++++----
>  3 files changed, 68 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index a1b9338736e3..32a83b41ab61 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -32,6 +32,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/mount.h>
>  #include <linux/slab.h>
> +#include <linux/srcu.h>
>  
>  #include <drm/drm_drv.h>
>  #include <drm/drmP.h>
> @@ -75,6 +76,8 @@ static bool drm_core_init_complete = false;
>  
>  static struct dentry *drm_debugfs_root;
>  
> +DEFINE_STATIC_SRCU(drm_unplug_srcu);
> +
>  /*
>   * DRM Minors
>   * A DRM device can provide several char-dev interfaces on the DRM-Major. Each
> @@ -318,18 +321,51 @@ void drm_put_dev(struct drm_device *dev)
>  }
>  EXPORT_SYMBOL(drm_put_dev);
>  
> -static void drm_device_set_unplugged(struct drm_device *dev)
> +/**
> + * drm_dev_enter - Enter device critical section
> + * @dev: DRM device
> + * @idx: Pointer to index that will be passed to the matching drm_dev_exit()
> + *
> + * This function marks and protects the beginning of a section that should not
> + * be entered after the device has been unplugged. The section end is marked
> + * with drm_dev_exit(). Calls to this function can be nested.
> + *
> + * Returns:
> + * True if it is OK to enter the section, false otherwise.
> + */
> +bool drm_dev_enter(struct drm_device *dev, int *idx)
> +{
> +	*idx = srcu_read_lock(&drm_unplug_srcu);
> +
> +	if (dev->unplugged) {
> +		srcu_read_unlock(&drm_unplug_srcu, *idx);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(drm_dev_enter);
> +
> +/**
> + * drm_dev_exit - Exit device critical section
> + * @idx: index returned from drm_dev_enter()
> + *
> + * This function marks the end of a section that should not be entered after
> + * the device has been unplugged.
> + */
> +void drm_dev_exit(int idx)
>  {
> -	smp_wmb();
> -	atomic_set(&dev->unplugged, 1);
> +	srcu_read_unlock(&drm_unplug_srcu, idx);
>  }
> +EXPORT_SYMBOL(drm_dev_exit);
>  
>  /**
>   * drm_dev_unplug - unplug a DRM device
>   * @dev: DRM device
>   *
>   * This unplugs a hotpluggable DRM device, which makes it inaccessible to
> - * userspace operations. Entry-points can use drm_dev_is_unplugged(). This
> + * userspace operations. Entry-points can use drm_dev_enter() and
> + * drm_dev_exit() to protect device resources in a race free manner. This
>   * essentially unregisters the device like drm_dev_unregister(), but can be
>   * called while there are still open users of @dev.
>   */
> @@ -338,10 +374,18 @@ void drm_dev_unplug(struct drm_device *dev)
>  	drm_dev_unregister(dev);
>  
>  	mutex_lock(&drm_global_mutex);
> -	drm_device_set_unplugged(dev);
>  	if (dev->open_count == 0)
>  		drm_dev_put(dev);
>  	mutex_unlock(&drm_global_mutex);
> +
> +	/*
> +	 * After synchronizing any critical read section is guaranteed to see
> +	 * the new value of ->unplugged, and any critical section which might
> +	 * still have seen the old value of ->unplugged is guaranteed to have
> +	 * finished.
> +	 */
> +	dev->unplugged = true;
> +	synchronize_srcu(&drm_unplug_srcu);
>  }
>  EXPORT_SYMBOL(drm_dev_unplug);
>  
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index 7c4fa32f3fc6..3a0eac2885b7 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -46,7 +46,14 @@ struct drm_device {
>  	/* currently active master for this device. Protected by master_mutex */
>  	struct drm_master *master;
>  
> -	atomic_t unplugged;			/**< Flag whether dev is dead */
> +	/**
> +	 * @unplugged:
> +	 *
> +	 * Flag to tell if the device has been unplugged.
> +	 * See drm_dev_enter() and drm_dev_is_unplugged().
> +	 */
> +	bool unplugged;
> +
>  	struct inode *anon_inode;		/**< inode for private address-space */
>  	char *unique;				/**< unique name of the device */
>  	/*@} */
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index d23dcdd1bd95..7e545f5f94d3 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -624,6 +624,8 @@ void drm_dev_get(struct drm_device *dev);
>  void drm_dev_put(struct drm_device *dev);
>  void drm_dev_unref(struct drm_device *dev);
>  void drm_put_dev(struct drm_device *dev);
> +bool drm_dev_enter(struct drm_device *dev, int *idx);
> +void drm_dev_exit(int idx);
>  void drm_dev_unplug(struct drm_device *dev);
>  
>  /**
> @@ -635,11 +637,16 @@ void drm_dev_unplug(struct drm_device *dev);
>   * unplugged, these two functions guarantee that any store before calling
>   * drm_dev_unplug() is visible to callers of this function after it completes
>   */
> -static inline int drm_dev_is_unplugged(struct drm_device *dev)
> +static inline bool drm_dev_is_unplugged(struct drm_device *dev)
>  {
> -	int ret = atomic_read(&dev->unplugged);
> -	smp_rmb();
> -	return ret;
> +	int idx;
> +
> +	if (drm_dev_enter(dev, &idx)) {
> +		drm_dev_exit(idx);
> +		return false;
> +	}
> +
> +	return true;
>  }
>  
>  
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
