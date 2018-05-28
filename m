Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939499AbeE1O5I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:57:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937078AbeE1OzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:55:00 -0400
Subject: Re: [PATCH v2] vfio: platform: Fix using devices in PM Domains
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1526640912-894-1-git-send-email-geert+renesas@glider.be>
Cc: kvm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <10a503da-d431-f2c9-3ddc-91b065563a0d@redhat.com>
Date: Mon, 28 May 2018 16:54:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1526640912-894-1-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 05/18/2018 12:55 PM, Geert Uytterhoeven wrote:
> If a device is part of a PM Domain (e.g. power and/or clock domain), its
> power state is managed using Runtime PM.  Without Runtime PM, the device
> may not be powered up or clocked, causing subtle failures, crashes, or
> system lock-ups when the device is accessed by the guest.
> 
> Fix this by adding Runtime PM support, powering the device when the VFIO
> device is opened by the guest.

I fail to apply this on master branch?
> 
> Note that while more fine-grained power management could be implemented
> on the guest side, if exported by the host, this would be inherently
> unsafe, as abusing it may take down the whole system.
I think I would prefer we get rid of the above paragraph.

Thanks

Eric
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> v2:
>   - Improve wording,
>   - Add Reviewed-by.
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index b60bb5326668498c..41f862f055054543 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -17,6 +17,7 @@
>  #include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> @@ -233,6 +234,8 @@ static void vfio_platform_release(void *device_data)
>  		const char *extra_dbg = NULL;
>  		int ret;
>  
> +		pm_runtime_put(vdev->device);
> +
>  		ret = vfio_platform_call_reset(vdev, &extra_dbg);
>  		if (ret && vdev->reset_required) {
>  			dev_warn(vdev->device, "reset driver is required and reset call failed in release (%d) %s\n",
> @@ -275,6 +278,10 @@ static int vfio_platform_open(void *device_data)
>  				 ret, extra_dbg ? extra_dbg : "");
>  			goto err_rst;
>  		}
> +
> +		ret = pm_runtime_get_sync(vdev->device);
> +		if (ret < 0)
> +			goto err_rst;
>  	}
>  
>  	vdev->refcnt++;
> @@ -690,6 +697,7 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>  
>  	mutex_init(&vdev->igate);
>  
> +	pm_runtime_enable(vdev->device);
>  	return 0;
>  
>  put_iommu:
> @@ -707,6 +715,7 @@ struct vfio_platform_device *vfio_platform_remove_common(struct device *dev)
>  	vdev = vfio_del_group_dev(dev);
>  
>  	if (vdev) {
> +		pm_runtime_disable(vdev->device);
>  		vfio_platform_put_reset(vdev);
>  		vfio_iommu_group_put(dev->iommu_group, dev);
>  	}
> 
