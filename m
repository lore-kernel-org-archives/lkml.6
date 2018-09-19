Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08618C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01772151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01772151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbeISSOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:14:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731995AbeISSOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:14:31 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACB623084218;
        Wed, 19 Sep 2018 12:36:46 +0000 (UTC)
Received: from [10.36.116.241] (ovpn-116-241.ams2.redhat.com [10.36.116.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A161E30912F4;
        Wed, 19 Sep 2018 12:36:41 +0000 (UTC)
Subject: Re: [PATCH/RFC v4 2/2] vfio: platform: Add generic reset controller
 support
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180917163955.19023-1-geert+renesas@glider.be>
 <20180917163955.19023-3-geert+renesas@glider.be>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <b7c4f5d1-020b-4a64-d511-b8e89f8c9196@redhat.com>
Date:   Wed, 19 Sep 2018 14:36:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180917163955.19023-3-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 19 Sep 2018 12:36:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 9/17/18 6:39 PM, Geert Uytterhoeven wrote:
> Vfio-platform requires dedicated reset support, provided either by ACPI,
> or, on DT platforms, by a device-specific reset driver matching against
> the device's compatible value.
> 
> On many SoCs, devices are connected to an SoC-internal reset controller.
> If the reset hierarchy is described in DT using "resets" properties, or
> in lookup tables in platform code, such devices can be reset in a
> generic way through the reset controller subsystem.  Hence add support
> for this, avoiding the need to write device-specific reset drivers for
> each single device on affected SoCs.
> 
> Devices that do require a more complex reset procedure can still provide
> a device-specific reset driver, as that takes precedence.
> 
> Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
> becomes a no-op (as in: "No reset function found for device") if reset
> controller support is disabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> v4:
>   - Add Reviewed-by,
>   - Use new RFC reset_control_get_dedicated() instead of
>     of_reset_control_get_exclusive(), to (a) make it more generic, and
>     (b) make sure the reset returned is really a dedicated reset, and
>     does not affect other devices,
> 
> v3:
>   - Add Reviewed-by,
>   - Merge similar checks in vfio_platform_has_reset(),
> 
> v2:
>   - Don't store error values in vdev->reset_control,
>   - Use of_reset_control_get_exclusive() instead of
>     __of_reset_control_get(),
>   - Improve description.
> 
> ---
>  drivers/vfio/platform/vfio_platform_common.c  | 20 +++++++++++++++++--
>  drivers/vfio/platform/vfio_platform_private.h |  1 +
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index c0cd824be2b767be..eb77fe87f3663e3e 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> @@ -113,11 +114,13 @@ static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
>  	if (VFIO_PLATFORM_IS_ACPI(vdev))
>  		return vfio_platform_acpi_has_reset(vdev);
>  
> -	return vdev->of_reset ? true : false;
> +	return vdev->of_reset || vdev->reset_control;
>  }
>  
>  static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>  {
> +	struct reset_control *rstc;
> +
>  	if (VFIO_PLATFORM_IS_ACPI(vdev))
>  		return vfio_platform_acpi_has_reset(vdev) ? 0 : -ENOENT;
>  
> @@ -128,8 +131,16 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>  		vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>  							&vdev->reset_module);
>  	}
> +	if (vdev->of_reset)
> +		return 0;
> +
> +	rstc = reset_control_get_dedicated(vdev->device, NULL);
> +	if (!IS_ERR(rstc)) {
> +		vdev->reset_control = rstc;
> +		return 0;
> +	}
>  
> -	return vdev->of_reset ? 0 : -ENOENT;
> +	return PTR_ERR(rstc);
This changes the returned value as seen by the user (probe returned
valud). Can we keep -ENOENT in case of no reset controller found?

Otherwise looks good to me with the new "dedicated" reset semantics.

Thanks

Eric
>  }
>  
>  static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
> @@ -139,6 +150,8 @@ static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
>  
>  	if (vdev->of_reset)
>  		module_put(vdev->reset_module);
> +
> +	reset_control_put(vdev->reset_control);
>  }
>  
>  static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
> @@ -218,6 +231,9 @@ static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
>  	} else if (vdev->of_reset) {
>  		dev_info(vdev->device, "reset\n");
>  		return vdev->of_reset(vdev);
> +	} else if (vdev->reset_control) {
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
