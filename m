Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeBUIT4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:19:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:48565 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752230AbeBUITz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:19:55 -0500
Subject: Re: [PATCH 1/9] drm/xen-front: Introduce Xen para-virtualized
 frontend driver
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-2-git-send-email-andr2000@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <c0928eaa-10e7-f047-dfe5-18e7cba76e76@suse.com>
Date: Wed, 21 Feb 2018 09:19:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519200222-20623-2-git-send-email-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/18 09:03, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Introduce skeleton of the para-virtualized Xen display
> frontend driver. This patch only adds required
> essential stubs.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>  drivers/gpu/drm/Kconfig             |  2 +
>  drivers/gpu/drm/Makefile            |  1 +
>  drivers/gpu/drm/xen/Kconfig         | 17 ++++++++
>  drivers/gpu/drm/xen/Makefile        |  5 +++
>  drivers/gpu/drm/xen/xen_drm_front.c | 83 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 108 insertions(+)
>  create mode 100644 drivers/gpu/drm/xen/Kconfig
>  create mode 100644 drivers/gpu/drm/xen/Makefile
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front.c
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index deeefa7a1773..757825ac60df 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -289,6 +289,8 @@ source "drivers/gpu/drm/pl111/Kconfig"
>  
>  source "drivers/gpu/drm/tve200/Kconfig"
>  
> +source "drivers/gpu/drm/xen/Kconfig"
> +
>  # Keep legacy drivers last
>  
>  menuconfig DRM_LEGACY
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 50093ff4479b..9d66657ea117 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -103,3 +103,4 @@ obj-$(CONFIG_DRM_MXSFB)	+= mxsfb/
>  obj-$(CONFIG_DRM_TINYDRM) += tinydrm/
>  obj-$(CONFIG_DRM_PL111) += pl111/
>  obj-$(CONFIG_DRM_TVE200) += tve200/
> +obj-$(CONFIG_DRM_XEN) += xen/
> diff --git a/drivers/gpu/drm/xen/Kconfig b/drivers/gpu/drm/xen/Kconfig
> new file mode 100644
> index 000000000000..4cca160782ab
> --- /dev/null
> +++ b/drivers/gpu/drm/xen/Kconfig
> @@ -0,0 +1,17 @@
> +config DRM_XEN
> +	bool "DRM Support for Xen guest OS"
> +	depends on XEN
> +	help
> +	  Choose this option if you want to enable DRM support
> +	  for Xen.
> +
> +config DRM_XEN_FRONTEND
> +	tristate "Para-virtualized frontend driver for Xen guest OS"
> +	depends on DRM_XEN
> +	depends on DRM
> +	select DRM_KMS_HELPER
> +	select VIDEOMODE_HELPERS
> +	select XEN_XENBUS_FRONTEND
> +	help
> +	  Choose this option if you want to enable a para-virtualized
> +	  frontend DRM/KMS driver for Xen guest OSes.
> diff --git a/drivers/gpu/drm/xen/Makefile b/drivers/gpu/drm/xen/Makefile
> new file mode 100644
> index 000000000000..967074d348f6
> --- /dev/null
> +++ b/drivers/gpu/drm/xen/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +drm_xen_front-objs := xen_drm_front.o
> +
> +obj-$(CONFIG_DRM_XEN_FRONTEND) += drm_xen_front.o
> diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
> new file mode 100644
> index 000000000000..fd372fb464a1
> --- /dev/null
> +++ b/drivers/gpu/drm/xen/xen_drm_front.c
> @@ -0,0 +1,83 @@
> +/*
> + *  Xen para-virtual DRM device
> + *
> + *   This program is free software; you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.

Use SPDX identifier instead (same applies for all other new
sources):

// SPDX-License-Identifier: GPL-2.0

> + *
> + * Copyright (C) 2016-2018 EPAM Systems Inc.
> + *
> + * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> + */
> +
> +#include <drm/drmP.h>
> +
> +#include <xen/platform_pci.h>
> +#include <xen/xen.h>
> +#include <xen/xenbus.h>
> +
> +#include <xen/interface/io/displif.h>
> +
> +static void backend_on_changed(struct xenbus_device *xb_dev,
> +		enum xenbus_state backend_state)
> +{
> +}
> +
> +static int xen_drv_probe(struct xenbus_device *xb_dev,
> +		const struct xenbus_device_id *id)
> +{
> +	return 0;
> +}
> +
> +static int xen_drv_remove(struct xenbus_device *dev)
> +{
> +	return 0;
> +}
> +
> +static const struct xenbus_device_id xen_drv_ids[] = {
> +	{ XENDISPL_DRIVER_NAME },
> +	{ "" }
> +};
> +
> +static struct xenbus_driver xen_driver = {
> +	.ids = xen_drv_ids,
> +	.probe = xen_drv_probe,
> +	.remove = xen_drv_remove,
> +	.otherend_changed = backend_on_changed,
> +};
> +
> +static int __init xen_drv_init(void)
> +{
> +	if (!xen_domain())
> +		return -ENODEV;
> +
> +	if (xen_initial_domain()) {
> +		DRM_ERROR(XENDISPL_DRIVER_NAME " cannot run in initial domain\n");
> +		return -ENODEV;
> +	}

Why not? Wouldn't that be possible in case of the backend living in a
driver domain?


Juergen
