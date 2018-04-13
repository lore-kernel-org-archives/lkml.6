Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754056AbeDMJOf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:14:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752446AbeDMJOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:14:33 -0400
Subject: Re: [PATCH] vfio: platform: Fix using devices in PM Domains
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1523438648-17672-1-git-send-email-geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kvm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0cc6cead-cd75-0a18-7a53-5ce16b03e823@redhat.com>
Date: Fri, 13 Apr 2018 11:14:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1523438648-17672-1-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 11/04/18 11:24, Geert Uytterhoeven wrote:
> If a device is part of a PM Domain (e.g. power and/or clock domain), its
> power state is managed using Runtime PM.  Without Runtime PM, the device
> may not be powered up, causing subtle failures, crashes, or system
> lock-ups when the device is accessed by the guest.
the device may not be powered up/clcoked or power/clock may be switched
off while the guest uses it.
> 
> Fix this by adding Runtime PM support, powering the device when the VFIO
> device is opened by the guest.
> 
> Note that while more fine-grained power management could be implemented
> on the guest side, if exported, this would be inherently unsafe, as
> abusing it may kill the whole system.
Please can you elaborate on this remark please?

Thanks

Eric
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on "[PATCH v3 2/2] vfio: platform: Add generic DT reset
> support" due to a small contextual change (addition of "#include
> <linux/reset.h>").
> 
>  drivers/vfio/platform/vfio_platform_common.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index ef9b9e3220ebe939..4db0a143992c3353 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -17,6 +17,7 @@
>  #include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -249,6 +250,8 @@ static void vfio_platform_release(void *device_data)
>  		const char *extra_dbg = NULL;
>  		int ret;
>  
> +		pm_runtime_put(vdev->device);
> +
>  		ret = vfio_platform_call_reset(vdev, &extra_dbg);
>  		if (ret && vdev->reset_required) {
>  			dev_warn(vdev->device, "reset driver is required and reset call failed in release (%d) %s\n",
> @@ -291,6 +294,10 @@ static int vfio_platform_open(void *device_data)
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
> @@ -706,6 +713,7 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>  
>  	mutex_init(&vdev->igate);
>  
> +	pm_runtime_enable(vdev->device);
>  	return 0;
>  
>  put_iommu:
> @@ -723,6 +731,7 @@ struct vfio_platform_device *vfio_platform_remove_common(struct device *dev)
>  	vdev = vfio_del_group_dev(dev);
>  
>  	if (vdev) {
> +		pm_runtime_disable(vdev->device);
>  		vfio_platform_put_reset(vdev);
>  		vfio_iommu_group_put(dev->iommu_group, dev);
>  	}
> 
