Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeDKIWq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:22:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33765 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeDKIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:22:45 -0400
Message-ID: <1523434945.4739.1.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] vfio: platform: Add generic DT reset controller
 support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 11 Apr 2018 10:22:25 +0200
In-Reply-To: <1523375627-23746-3-git-send-email-geert+renesas@glider.be>
References: <1523375627-23746-1-git-send-email-geert+renesas@glider.be>
         <1523375627-23746-3-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-10 at 17:53 +0200, Geert Uytterhoeven wrote:
> Vfio-platform requires reset support, provided either by ACPI, or, on DT
> platforms, by a device-specific reset driver matching against the
> device's compatible value.
> 
> On many SoCs, devices are connected to an SoC-internal reset controller.
> If the reset hierarchy is described in DT using "resets" properties,
> such devices can be reset in a generic way through the reset controller
> subsystem.  Hence add support for this, avoiding the need to write
> device-specific reset drivers for each single device on affected SoCs.
> 
> Devices that do require a more complex reset procedure can still provide
> a device-specific reset driver, as that takes precedence.
> 
> Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
> becomes a no-op (as in: "No reset function found for device") if reset
> controller support is disabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

> ---
> v2:
>   - Don't store error values in vdev->reset_control,
>   - Use of_reset_control_get_exclusive() instead of
>     __of_reset_control_get(),
>   - Improve description.
> ---
>  drivers/vfio/platform/vfio_platform_common.c  | 26 ++++++++++++++++++++++++--
>  drivers/vfio/platform/vfio_platform_private.h |  1 +
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index b60bb5326668498c..3c13327b2777f8ec 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
[...]
> @@ -127,8 +136,16 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>  		vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>  							&vdev->reset_module);
>  	}
> +	if (vdev->of_reset)
> +		return 0;
> +
> +	rstc = of_reset_control_get_exclusive(vdev->device->of_node, NULL);

If vdev->device->of_node == NULL, this will return -EINVAL ...

> +	if (!IS_ERR(rstc)) {
> +		vdev->reset_control = rstc;
> +		return 0;
> +	}
>  
> -	return vdev->of_reset ? 0 : -ENOENT;
> +	return PTR_ERR(rstc);

... instead of -ENOENT, if that makes any difference.

regards
Philipp
