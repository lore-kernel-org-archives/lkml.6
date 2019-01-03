Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5F6C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9174A2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfACKKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:10:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52843 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfACKKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:10:47 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5732E207AD; Thu,  3 Jan 2019 11:10:46 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-29-148.w90-88.abo.wanadoo.fr [90.88.149.148])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0BF5E2074D;
        Thu,  3 Jan 2019 11:10:36 +0100 (CET)
Message-ID: <fc3c7771e4cc25227d97be02efe11173c1350482.camel@bootlin.com>
Subject: Re: [PATCH v4 00/22] drm/sun4i: Support for linear and tiled YUV
 formats with the frontend
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 03 Jan 2019 11:10:36 +0100
In-Reply-To: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-05 at 09:36 +0100, Paul Kocialkowski wrote:
> This series implements support for YUV formats using the display engine
> frontend in the sun4i DRM driver, with various fixes along the way.
> Scaling is supported for every format handled by the frontend.
> 
> The tiling mode used by the VPU on Allwinner platforms is also supported
> by this series and a dedicated fourcc modifier is introduced, along with
> a specific ioctl for allocating tiled buffers.
> 
> New common fourcc helpers are also introduced in this series, especially
> related to YUV formats.

This series should be about ready for merge for the sun4i parts, but
I'd like to get some feedback regarding the new helpers introduced to
drm_fourcc (patches 1/ and 2/) as well as the introduction of the
Allwinner tiling definitions (patch 11/).

Does anyone have any objection or suggestion regarding these patches or
can we go ahead and merge them along with the remaining driver patches
in this series?

Cheers,

Paul

> This was tested on the A33 and A20 platforms and all supported features
> work properly on both. Framebuffer offsets and source positions are not
> supported at this point.
> 
> Changes since v3:
> * Made the BT.601 CSC coefficients common;
> * Moved the tiling mode comment next to the associated macro;
> * Added collected Acked-by tags.
> 
> Changes since v2:
> * Removed DRM format helpers taking the format fourcc;
> * Passed the DRM format info structure when needed instead of iterating
>   through the list;
> * Removed the sun4i-specific ioctl for allocating tiled buffers, which
>   will be rebranded as a generic one in an upcoming patch;
> * Improved comment for X1 tiled offset and simplified its calculation;
> * Corrected author email and added SoB where needed;
> * Rebased on latest drm-misc next.
> 
> Changes since v1:
> * Extended source selected cleanup to both YUV and video channels;
> * Split and reworded comment about backend scaling;
> * Sorted newly-introduced lists alphabetically;
> * Simplified functions to check if a format is supported;
> * Reworked frontend selection logic as discussed;
> * Made YUV helpers common, with fourcc and drm_info fashions;
> * Changed the CREATE_TILED ioctl flags to match the CREATE_DUMB ioctl;
> * Reworked YUV dimensions calculations to use drm_format_info;
> * Dropped MB32 part in modifier to match V4L2 definition name;
> * Improved the description of the tiling modifier;
> * Avoided splitting CSC coefficients to avoid introducing a new module;
> * Fixed building the driver as modules;
> * Various code simplifications and cleanups;
> * Split commits into logical changes.
> 
> Maxime Ripard (5):
>   drm/sun4i: Move access control before setting the register as
>     documented
>   drm/sun4i: frontend: Add a quirk structure
>   drm/sun4i: Set the coef_rdy bit right after the coef have been set
>   drm/sun4i: Make COEF_RDY conditional
>   drm/sun4i: frontend: Move the FIR filter phases to our quirks
> 
> Paul Kocialkowski (17):
>   drm/fourcc: Add format info helpers for checking YUV planes
>     disposition
>   drm/fourcc: Add format info helpers for checking YUV sub-sampling
>   drm/sun4i: backend: Use explicit fourcc helpers for packed YUV422
>     check
>   drm/sun4i: frontend: Pass DRM format info to input format helpers
>   drm/sun4i: frontend: Determine input format based on colorspace
>   drm/sun4i: Move the BT.601 CSC coefficients to the frontend
>   drm/sun4i: frontend: Configure and enable YUV to RGB CSC when needed
>   drm/sun4i: frontend: Add support for packed YUV422 input formats
>   drm/sun4i: frontend: Add support for semi-planar YUV input formats
>   drm/sun4i: frontend: Add support for planar YUV input formats
>   drm/fourcc: Add definitions for Allwinner vendor and VPU tiled format
>   drm/sun4i: frontend: Add support for tiled YUV input mode
>     configuration
>   drm/sun4i: Add buffer stride and offset configuration for tiling mode
>   drm/sun4i: frontend: Add and use helper for checking tiling support
>   drm/sun4i: layer: Add tiled modifier support and helper
>   drm/sun4i: drv: Allow framebuffer modifiers in mode config
>   drm/sun4i: frontend: Add A20-specific device-tree compatible and
>     quirks
> 
>  drivers/gpu/drm/sun4i/sun4i_backend.c  |  25 +-
>  drivers/gpu/drm/sun4i/sun4i_drv.c      |   1 +
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 346 ++++++++++++++++++++++---
>  drivers/gpu/drm/sun4i/sun4i_frontend.h |  52 ++++
>  drivers/gpu/drm/sun4i/sun4i_layer.c    |  28 +-
>  include/drm/drm_fourcc.h               | 117 +++++++++
>  include/uapi/drm/drm_fourcc.h          |  16 ++
>  7 files changed, 530 insertions(+), 55 deletions(-)
> 
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

