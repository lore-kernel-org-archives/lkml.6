Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C1EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676B320863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676B320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502602AbeKWUKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:10:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49129 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387992AbeKWUKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:05 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A6F0420747; Fri, 23 Nov 2018 10:26:37 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5305220747;
        Fri, 23 Nov 2018 10:26:27 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v2 00/43] drm/sun4i: Support for linear and tiled YUV formats with the frontend
Date:   Fri, 23 Nov 2018 10:24:32 +0100
Message-Id: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements support for YUV formats using the display engine
frontend in the sun4i DRM driver, with various fixes along the way.
Scaling is supported for every format handled by the frontend.

The tiling mode used by the VPU on Allwinner platforms is also supported
by this series and a dedicated fourcc modifier is introduced, along with
a specific ioctl for allocating tiled buffers.

New common fourcc helpers are also introduced in this series, especially
related to YUV formats.

This was tested on the A33 and A20 platforms and all supported features
work properly on both. Framebuffer offsets and source positions are not
supported at this point.

Changes since v1:
* Extended source selected cleanup to both YUV and video channels;
* Split and reworded comment about backend scaling;
* Sorted newly-introduced lists alphabetically;
* Simplified functions to check if a format is supported;
* Reworked frontend selection logic as discussed;
* Made YUV helpers common, with fourcc and drm_info fashions;
* Changed the CREATE_TILED ioctl flags to match the CREATE_DUMB ioctl;
* Reworked YUV dimensions calculations to use drm_format_info;
* Dropped MB32 part in modifier to match V4L2 definition name;
* Improved the description of the tiling modifier;
* Avoided splitting CSC coefficients to avoid introducing a new module;
* Fixed building the driver as modules;
* Various code simplifications and cleanups;
* Split commits into logical changes.

Maxime Ripard (5):
  drm/sun4i: Move access control before setting the register as
    documented
  drm/sun4i: frontend: Add a quirk structure
  drm/sun4i: Set the coef_rdy bit right after the coef have been set
  drm/sun4i: Make COEF_RDY conditional
  drm/sun4i: frontend: Move the FIR filter phases to our quirks

Paul Kocialkowski (38):
  drm/sun4i: Cleanup video/YUV source before enabling a layer
  drm/sun4i: frontend: Replace ARGB with XRGB as supported format
  drm/sun4i: Add TODO comment about supporting scaling with the backend
  drm/sun4i: backend: Add a helper and a list for supported formats
  drm/sun4i: frontend: Add a helper and a list for supported formats
  drm/sun4i: backend: Refine the logic behind using the frontend
  drm/sun4i: backend: Use a specific function to check if a plane is
    supported
  drm/fourcc: Add helper to check if a format uses a YUV colorspace
  drm/fourcc: Add format info helpers for checking YUV planes
    disposition
  drm/fourcc: Add format helpers for checking YUV planes disposition
  drm/fourcc: Add format info helpers for checking YUV sub-sampling
  drm/fourcc: Add format helpers for checking YUV sub-sampling
  drm/sun4i: backend: Use explicit fourcc helpers for packed YUV422
    check
  drm/sun4i: backend: Avoid counting YUV planes that use the frontend
  drm/sun4i: Rename sun4i_backend_layer_formats to sun4i_layer_formats
  drm/sun4i: frontend: Move CSC bypass setup to format update routine
  drm/sun4i: frontend: Add helpers for input data mode and pixel
    sequence
  drm/sun4i: frontend: Add proper definitions for format registers
  drm/sun4i: frontend: Determine input mode based on the number of
    planes
  drm/sun4i: frontend: Determine input format based on colorspace
  drm/sun4i: frontend: Add support for the BGRX8888 input format
  drm/sun4i: frontend: Add support for the BGRX8888 output format
  drm/sun4i: backend: Detail the YUV to RGB values coding explanation
  drm/sun4i: frontend: Configure and enable YUV to RGB CSC when needed
  drm/sun4i: frontend: Apply format sub-sampling to CH1 dimensions
  drm/sun4i: frontend: Add support for packed YUV422 input formats
  drm/sun4i: frontend: Add support for semi-planar YUV input formats
  drm/sun4i: frontend: Add support for planar YUV input formats
  drm/sun4i: Make pitch even for GEM dumb alloc as per hardware
    constraint
  drm/fourcc: Add definitions for Allwinner vendor and VPU tiled format
  drm/sun4i: Add a dedicated ioctl call for allocating tiled buffers
  drm/sun4i: Pass modifier to backend and frontend format support
    helpers
  drm/sun4i: frontend: Add support for tiled YUV input mode
    configuration
  drm/sun4i: Add buffer stride and offset configuration for tiling mode
  drm/sun4i: frontend: Add and use helper for checking tiling support
  drm/sun4i: layer: Add tiled modifier support and helper
  drm/sun4i: drv: Allow framebuffer modifiers in mode config
  drm/sun4i: frontend: Add A20-specific device-tree compatible and
    quirks

 drivers/gpu/drm/drm_fourcc.c           | 184 +++++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.c  | 109 ++++++-
 drivers/gpu/drm/sun4i/sun4i_backend.h  |   3 +
 drivers/gpu/drm/sun4i/sun4i_drv.c      | 102 +++++-
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 415 ++++++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  50 ++-
 drivers/gpu/drm/sun4i/sun4i_layer.c    |  41 ++-
 include/drm/drm_fourcc.h               | 126 ++++++++
 include/uapi/drm/drm_fourcc.h          |  16 +
 include/uapi/drm/sun4i_drm.h           |  42 +++
 10 files changed, 1029 insertions(+), 59 deletions(-)
 create mode 100644 include/uapi/drm/sun4i_drm.h

-- 
2.19.1

