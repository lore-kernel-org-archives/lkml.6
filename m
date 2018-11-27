Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACD8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA6B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA6B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeK1AcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:32:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:55944 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbeK1AcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:32:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 05:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="93416820"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga008.fm.intel.com with SMTP; 27 Nov 2018 05:34:19 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 27 Nov 2018 15:34:18 +0200
Date:   Tue, 27 Nov 2018 15:34:18 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, dnicoara@chromium.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        alexandros.frantzis@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tomasz Figa <tfiga@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH] drm: add capability DRM_CAP_ASYNC_UPDATE
Message-ID: <20181127133418.GT9144@intel.com>
References: <20181123215326.14274-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181123215326.14274-1-helen.koike@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 07:53:26PM -0200, Helen Koike wrote:
> Allow userspace to identify if the driver supports async update.

And what exactly is an "async update"?

I keep asking people to come up with the a better name for this, and to
document what it actually means. Recently I've been think we should
maybe just adopt the vulkan terminology (immediate/fifo/mailbox) to
avoid introducing yet another set of names for the same thing. We'd
still want to document things properly though.

> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> [prepared for upstream]
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> 
> ---
> Hi,
> 
> This patch introduces the ASYNC_UPDATE cap, which originated from the
> discussion regarding DRM_MODE_ATOMIC_AMEND on [1], to allow user to
> figure that async_update exists.
> 
> This was tested using a small program that exercises the uAPI for easy
> sanity testing. The program was created by Alexandros and modified by
> Enric to test the capability flag [2].
> 
> The test worked on a rockchip Ficus v1.1 board on top of mainline plus
> the patch to update cursors asynchronously through atomic plus the patch
> that introduces the ATOMIC_AMEND flag for the drm/rockchip driver.
> 
> To test, just build the program and use the --atomic flag to use the cursor
> plane with the ATOMIC_AMEND flag. E.g.
> 
>   drm_cursor --atomic
> 
> [1] https://patchwork.freedesktop.org/patch/243088/
> [2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/async-capability
> 
> Thanks
> Helen
> 
> 
>  drivers/gpu/drm/drm_ioctl.c | 11 +++++++++++
>  include/uapi/drm/drm.h      |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index 94bd872d56c4..4a7e0f874171 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -31,6 +31,7 @@
>  #include <drm/drm_ioctl.h>
>  #include <drm/drmP.h>
>  #include <drm/drm_auth.h>
> +#include <drm/drm_modeset_helper_vtables.h>
>  #include "drm_legacy.h"
>  #include "drm_internal.h"
>  #include "drm_crtc_internal.h"
> @@ -229,6 +230,7 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
>  {
>  	struct drm_get_cap *req = data;
>  	struct drm_crtc *crtc;
> +	struct drm_plane *plane;
>  
>  	req->value = 0;
>  
> @@ -292,6 +294,15 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
>  	case DRM_CAP_CRTC_IN_VBLANK_EVENT:
>  		req->value = 1;
>  		break;
> +	case DRM_CAP_ASYNC_UPDATE:
> +		req->value = 1;
> +		list_for_each_entry(plane, &dev->mode_config.plane_list, head) {
> +			if (!plane->helper_private->atomic_async_update) {
> +				req->value = 0;
> +				break;
> +			}
> +		}
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 300f336633f2..ff01540cbb1d 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -649,6 +649,7 @@ struct drm_gem_open {
>  #define DRM_CAP_PAGE_FLIP_TARGET	0x11
>  #define DRM_CAP_CRTC_IN_VBLANK_EVENT	0x12
>  #define DRM_CAP_SYNCOBJ		0x13
> +#define DRM_CAP_ASYNC_UPDATE		0x14
>  
>  /** DRM_IOCTL_GET_CAP ioctl argument type */
>  struct drm_get_cap {
> -- 
> 2.19.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
