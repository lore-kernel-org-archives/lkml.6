Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754353AbeBNIhF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:37:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750947AbeBNIhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:37:03 -0500
Subject: Re: [PATCH 1/2] vfio: platform: Fix reset module leak in error path
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1518539815-13774-1-git-send-email-geert+renesas@glider.be>
 <1518539815-13774-2-git-send-email-geert+renesas@glider.be>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2fe86be6-a3e2-9bd6-1d72-63cf0fe3a731@redhat.com>
Date: Wed, 14 Feb 2018 09:36:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1518539815-13774-2-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 13/02/18 17:36, Geert Uytterhoeven wrote:
> If the IOMMU group setup fails, the reset module is not released.
> 
> Fixes: b5add544d677d363 ("vfio, platform: make reset driver a requirement by default")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 35469af87f88678e..b60bb5326668498c 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -680,18 +680,23 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,

Thanks for fixing this.

If I am not wrong we also leak the reset_module if
vfio_platform_get_reset() fails to find the reset function (of_reset ==
NULL), in which case we should do the module_put() in
vfio_platform_get_reset().

Thanks

Eric
>  	group = vfio_iommu_group_get(dev);
>  	if (!group) {
>  		pr_err("VFIO: No IOMMU group for device %s\n", vdev->name);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto put_reset;
>  	}
>  
>  	ret = vfio_add_group_dev(dev, &vfio_platform_ops, vdev);
> -	if (ret) {
> -		vfio_iommu_group_put(group, dev);
> -		return ret;
> -	}
> +	if (ret)
> +		goto put_iommu;
>  
>  	mutex_init(&vdev->igate);
>  
>  	return 0;
> +
> +put_iommu:
> +	vfio_iommu_group_put(group, dev);
> +put_reset:
> +	vfio_platform_put_reset(vdev);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(vfio_platform_probe_common);
>  
> 
