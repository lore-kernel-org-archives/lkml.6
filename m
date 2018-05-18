Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeERTiX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:38:23 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17995 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeERTiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:38:17 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 18 May 2018 12:38:17 -0700
Subject: Re: [PATCH v4 2/2] vfio/mdev: Re-order sysfs attribute creation
To: Alex Williamson <alex.williamson@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cohuck@redhat.com>, <pasic@linux.ibm.com>
References: <20180518190145.3187.7620.stgit@gimli.home>
 <20180518191035.3187.77957.stgit@gimli.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <30699b42-a587-7235-5fec-e745cd5c925d@nvidia.com>
Date: Sat, 19 May 2018 01:08:07 +0530
MIME-Version: 1.0
In-Reply-To: <20180518191035.3187.77957.stgit@gimli.home>
X-Originating-IP: [10.24.70.199]
X-ClientProxiedBy: DRBGMAIL104.nvidia.com (10.18.16.23) To
 bgmail102.nvidia.com (10.25.59.11)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/2018 12:40 AM, Alex Williamson wrote:
> There exists a gap at the end of mdev_device_create() where the device
> is visible to userspace, but we're not yet ready to handle removal, as
> triggered through the 'remove' attribute.  We handle this properly in
> mdev_device_remove() with an -EAGAIN return, but we can marginally
> reduce this gap by adding this attribute as a final step of our sysfs
> setup.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Looks good.

Reviewed by: Kirti Wankhede <kwankhede@nvidia.com>

> ---
>  drivers/vfio/mdev/mdev_sysfs.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
> index 802df210929b..249472f05509 100644
> --- a/drivers/vfio/mdev/mdev_sysfs.c
> +++ b/drivers/vfio/mdev/mdev_sysfs.c
> @@ -257,24 +257,24 @@ int  mdev_create_sysfs_files(struct device *dev, struct mdev_type *type)
>  {
>  	int ret;
>  
> -	ret = sysfs_create_files(&dev->kobj, mdev_device_attrs);
> -	if (ret)
> -		return ret;
> -
>  	ret = sysfs_create_link(type->devices_kobj, &dev->kobj, dev_name(dev));
>  	if (ret)
> -		goto device_link_failed;
> +		return ret;
>  
>  	ret = sysfs_create_link(&dev->kobj, &type->kobj, "mdev_type");
>  	if (ret)
>  		goto type_link_failed;
>  
> +	ret = sysfs_create_files(&dev->kobj, mdev_device_attrs);
> +	if (ret)
> +		goto create_files_failed;
> +
>  	return ret;
>  
> +create_files_failed:
> +	sysfs_remove_link(&dev->kobj, "mdev_type");
>  type_link_failed:
>  	sysfs_remove_link(type->devices_kobj, dev_name(dev));
> -device_link_failed:
> -	sysfs_remove_files(&dev->kobj, mdev_device_attrs);
>  	return ret;
>  }
>  
> 
