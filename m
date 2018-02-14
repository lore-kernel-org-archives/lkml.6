Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935104AbeBNJJp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:09:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934803AbeBNJJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:09:43 -0500
Subject: Re: [PATCH 2/2] vfio: platform: Add generic DT reset support
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1518539815-13774-1-git-send-email-geert+renesas@glider.be>
 <1518539815-13774-3-git-send-email-geert+renesas@glider.be>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ed556509-1460-3e05-b161-f476090ff480@redhat.com>
Date: Wed, 14 Feb 2018 10:09:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1518539815-13774-3-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 13/02/18 17:36, Geert Uytterhoeven wrote:
> Vfio-platform requires reset support, provided either by ACPI, or, on DT
> platforms, by a device-specific reset driver matching against the
> device's compatible value.
> 
> On many SoCs, devices are connected to an SoC-internal reset controller,
> and can be reset in a generic way.  Hence add support to reset such
> devices using the reset controller subsystem, provided the reset
> hierarchy is described correctly in DT using the "resets" property.

I first acknowledge I am not familiar with what those reset controllers
do in practice. My fear is that we may rely on generic SW pieces that
may not be adapted to passthrough constraints. We must guarantee that
any DMA access attempted by the devices are stopped and any interrupts
gets stopped. Can we guarantee that the reset controller always induce
that? Otherwise we may leave the door opened to badly reset assigned
devices.
> 
> Devices that require a more complex reset procedure can still
> provide a device-specific reset driver, as that takes precedence.
> 
> Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
> becomes a no-op if reset controller support is disabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/vfio/platform/vfio_platform_common.c  | 23 +++++++++++++++++++++--
>  drivers/vfio/platform/vfio_platform_private.h |  1 +
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index b60bb5326668498c..5d1e48f96e423508 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -17,6 +17,7 @@
>  #include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> @@ -112,7 +113,13 @@ static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
>  	if (VFIO_PLATFORM_IS_ACPI(vdev))
>  		return vfio_platform_acpi_has_reset(vdev);
>  
> -	return vdev->of_reset ? true : false;
> +	if (vdev->of_reset)
> +		return true;
> +
> +	if (!IS_ERR_OR_NULL(vdev->reset_control))
> +		return true;
> +
> +	return false;
>  }
>  
>  static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
> @@ -127,8 +134,15 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>  		vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>  							&vdev->reset_module);
>  	}
> +	if (vdev->of_reset)
> +		return 0;
> +
> +	vdev->reset_control = __of_reset_control_get(vdev->device->of_node,
> +						     NULL, 0, false, false);
> +	if (!IS_ERR(vdev->reset_control))
> +		return 0;
>  
> -	return vdev->of_reset ? 0 : -ENOENT;
> +	return PTR_ERR(vdev->reset_control);
>  }
>  
>  static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
> @@ -138,6 +152,8 @@ static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
>  
>  	if (vdev->of_reset)
>  		module_put(vdev->reset_module);
> +
if (vdev->reset_control) ?
reset_control_put seems to only check IS_ERR()

Thanks

Eric
> +	reset_control_put(vdev->reset_control);
>  }
>  
>  static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
> @@ -217,6 +233,9 @@ static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
>  	} else if (vdev->of_reset) {
>  		dev_info(vdev->device, "reset\n");
>  		return vdev->of_reset(vdev);
> +	} else if (!IS_ERR_OR_NULL(vdev->reset_control)) {
> +		dev_info(vdev->device, "reset\n");
> +		return reset_control_reset(vdev->reset_control);
>  	}
>  
>  	dev_warn(vdev->device, "no reset function found!\n");
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index 85ffe5d9d1abd94e..a56e80ae5986540b 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -60,6 +60,7 @@ struct vfio_platform_device {
>  	const char			*compat;
>  	const char			*acpihid;
>  	struct module			*reset_module;
> +	struct reset_control		*reset_control;
>  	struct device			*device;
>  
>  	/*
> 
