Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeEPJFP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:05:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751182AbeEPJFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:05:12 -0400
Date: Wed, 16 May 2018 11:05:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kwankhede@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/mdev: Check globally for duplicate devices
Message-ID: <20180516110506.40b7516b.cohuck@redhat.com>
In-Reply-To: <20180515195947.12163.49363.stgit@gimli.home>
References: <20180515195947.12163.49363.stgit@gimli.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2018 14:17:04 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> When we create an mdev device, we check for duplicates against the
> parent device and return -EEXIST if found, but the mdev device
> namespace is global since we'll link all devices from the bus.  We do
> catch this later in sysfs_do_create_link_sd() to return -EEXIST, but
> with it comes a kernel warning and stack trace for trying to create
> duplicate sysfs links, which makes it an undesirable response.
> 
> Therefore we should really be looking for duplicates across all mdev
> parent devices, or as implemented here, against our mdev device list.
> 
> Notably, mdev_parent.lock really only seems to be serializing device
> creation and removal per parent.  I'm not sure if this is necessary,
> mdev vendor drivers could easily provide this serialization if it
> is required, but a side-effect of holding the mdev_list_lock to
> protect the namespace is actually greater serialization across the
> create and remove paths, so mdev_parent.lock is removed.  If we can
> show that vendor drivers handle the create/remove paths themselves,
> perhaps we can refine the locking granularity.

I'm not sure whether more locking granularity on the create/remove
paths is really worth the effort.

> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/mdev/mdev_core.c    |   79 ++++++++++----------------------------
>  drivers/vfio/mdev/mdev_private.h |    1 
>  2 files changed, 20 insertions(+), 60 deletions(-)

In general, I think this patch makes sense; some nits below.

> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index 126991046eb7..3d8898a2baaf 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c

> @@ -376,12 +346,13 @@ int mdev_device_remove(struct device *dev, bool force_remove)
>  	struct mdev_device *mdev, *tmp;
>  	struct mdev_parent *parent;
>  	struct mdev_type *type;
> -	int ret;
> +	int ret = 0;

I don't think you need to init this, as ret should either be set to
-ENODEV or the return code of mdev_device_remove_ops(), shouldn't it?

>  	bool found = false;
>  
>  	mdev = to_mdev_device(dev);
>  
>  	mutex_lock(&mdev_list_lock);
> +

unrelated whitespace change

>  	list_for_each_entry(tmp, &mdev_list, next) {
>  		if (tmp == mdev) {
>  			found = true;
> @@ -389,35 +360,25 @@ int mdev_device_remove(struct device *dev, bool force_remove)
>  		}
>  	}
>  
> -	if (found)
> -		list_del(&mdev->next);
> -
> -	mutex_unlock(&mdev_list_lock);
> -
> -	if (!found)
> -		return -ENODEV;
> +	if (!found) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
>  
>  	type = to_mdev_type(mdev->type_kobj);
>  	parent = mdev->parent;
> -	mutex_lock(&parent->lock);
>  
>  	ret = mdev_device_remove_ops(mdev, force_remove);
> -	if (ret) {
> -		mutex_unlock(&parent->lock);
> -
> -		mutex_lock(&mdev_list_lock);
> -		list_add(&mdev->next, &mdev_list);
> -		mutex_unlock(&mdev_list_lock);
> -
> -		return ret;
> -	}
> +	if (ret)
> +		goto out;

This change really simplyfies the code, nice.

>  
> +	list_del(&mdev->next);
>  	mdev_remove_sysfs_files(dev, type);
>  	device_unregister(dev);
> -	mutex_unlock(&parent->lock);
>  	mdev_put_parent(parent);
> -
> -	return 0;
> +out:
> +	mutex_unlock(&mdev_list_lock);
> +	return ret;
>  }
>  
>  static int __init mdev_init(void)
