Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbeBUIXJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:23:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:48660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbeBUIXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:23:08 -0500
Subject: Re: [PATCH 2/9] drm/xen-front: Implement Xen bus state handling
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-3-git-send-email-andr2000@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <7b302293-a4ca-0225-576f-0cc33f6f56cb@suse.com>
Date: Wed, 21 Feb 2018 09:23:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519200222-20623-3-git-send-email-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/18 09:03, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Initial handling for Xen bus states: implement
> Xen bus state machine for the frontend driver according to
> the state diagram and recovery flow from display para-virtualized
> protocol: xen/interface/io/displif.h.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>  drivers/gpu/drm/xen/xen_drm_front.c | 124 +++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/xen/xen_drm_front.h |  26 ++++++++
>  2 files changed, 149 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front.h
> 
> diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
> index fd372fb464a1..d0306f9d660d 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front.c
> @@ -24,19 +24,141 @@
>  
>  #include <xen/interface/io/displif.h>
>  
> +#include "xen_drm_front.h"
> +
> +static void xen_drv_remove_internal(struct xen_drm_front_info *front_info)
> +{
> +}
> +
> +static int backend_on_initwait(struct xen_drm_front_info *front_info)
> +{
> +	return 0;
> +}
> +
> +static int backend_on_connected(struct xen_drm_front_info *front_info)
> +{
> +	return 0;
> +}
> +
> +static void backend_on_disconnected(struct xen_drm_front_info *front_info)
> +{
> +	xenbus_switch_state(front_info->xb_dev, XenbusStateInitialising);
> +}
> +
>  static void backend_on_changed(struct xenbus_device *xb_dev,
>  		enum xenbus_state backend_state)
>  {
> +	struct xen_drm_front_info *front_info = dev_get_drvdata(&xb_dev->dev);
> +	int ret;
> +
> +	DRM_DEBUG("Backend state is %s, front is %s\n",
> +			xenbus_strstate(backend_state),
> +			xenbus_strstate(xb_dev->state));
> +
> +	switch (backend_state) {
> +	case XenbusStateReconfiguring:
> +		/* fall through */
> +	case XenbusStateReconfigured:
> +		/* fall through */
> +	case XenbusStateInitialised:
> +		break;
> +
> +	case XenbusStateInitialising:
> +		/* recovering after backend unexpected closure */
> +		backend_on_disconnected(front_info);
> +		break;
> +
> +	case XenbusStateInitWait:
> +		/* recovering after backend unexpected closure */
> +		backend_on_disconnected(front_info);
> +		if (xb_dev->state != XenbusStateInitialising)
> +			break;
> +
> +		ret = backend_on_initwait(front_info);
> +		if (ret < 0)
> +			xenbus_dev_fatal(xb_dev, ret, "initializing frontend");
> +		else
> +			xenbus_switch_state(xb_dev, XenbusStateInitialised);
> +		break;
> +
> +	case XenbusStateConnected:
> +		if (xb_dev->state != XenbusStateInitialised)
> +			break;
> +
> +		ret = backend_on_connected(front_info);
> +		if (ret < 0)
> +			xenbus_dev_fatal(xb_dev, ret, "initializing DRM driver");
> +		else
> +			xenbus_switch_state(xb_dev, XenbusStateConnected);
> +		break;
> +
> +	case XenbusStateClosing:
> +		/*
> +		 * in this state backend starts freeing resources,
> +		 * so let it go into closed state, so we can also
> +		 * remove ours
> +		 */
> +		break;
> +
> +	case XenbusStateUnknown:
> +		/* fall through */
> +	case XenbusStateClosed:
> +		if (xb_dev->state == XenbusStateClosed)
> +			break;
> +
> +		backend_on_disconnected(front_info);
> +		break;
> +	}
>  }
>  
>  static int xen_drv_probe(struct xenbus_device *xb_dev,
>  		const struct xenbus_device_id *id)
>  {
> -	return 0;
> +	struct xen_drm_front_info *front_info;
> +
> +	front_info = devm_kzalloc(&xb_dev->dev,
> +			sizeof(*front_info), GFP_KERNEL);
> +	if (!front_info) {
> +		xenbus_dev_fatal(xb_dev, -ENOMEM, "allocating device memory");

No need for message in case of allocation failure: this is
handled in memory allocation already.


Juergen
