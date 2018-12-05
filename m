Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11552C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AC9206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AC9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeLEIhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:37:38 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36136 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbeLEIhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:37:38 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9825F20E23; Wed,  5 Dec 2018 09:37:35 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 42F6C207BD;
        Wed,  5 Dec 2018 09:37:25 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v4 00/22] drm/sun4i: Support for linear and tiled YUV formats with the frontend
Date:   Wed,  5 Dec 2018 09:36:41 +0100
Message-Id: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
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

Changes since v3:
* Made the BT.601 CSC coefficients common;
* Moved the tiling mode comment next to the associated macro;
* Added collected Acked-by tags.

Changes since v2:
* Removed DRM format helpers taking the format fourcc;
* Passed the DRM format info structure when needed instead of iterating
  through the list;
* Removed the sun4i-specific ioctl for allocating tiled buffers, which
  will be rebranded as a generic one in an upcoming patch;
* Improved comment for X1 tiled offset and simplified its calculation;
* Corrected author email and added SoB where needed;
* Rebased on latest drm-misc next.

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

Paul Kocialkowski (17):
  drm/fourcc: Add format info helpers for checking YUV planes
    disposition
  drm/fourcc: Add format info helpers for checking YUV sub-sampling
  drm/sun4i: backend: Use explicit fourcc helpers for packed YUV422
    check
  drm/sun4i: frontend: Pass DRM format info to input format helpers
  drm/sun4i: frontend: Determine input format based on colorspace
  drm/sun4i: Move the BT.601 CSC coefficients to the frontend
  drm/sun4i: frontend: Configure and enable YUV to RGB CSC when needed
  drm/sun4i: frontend: Add support for packed YUV422 input formats
  drm/sun4i: frontend: Add support for semi-planar YUV input formats
  drm/sun4i: frontend: Add support for planar YUV input formats
  drm/fourcc: Add definitions for Allwinner vendor and VPU tiled format
  drm/sun4i: frontend: Add support for tiled YUV input mode
    configuration
  drm/sun4i: Add buffer stride and offset configuration for tiling mode
  drm/sun4i: frontend: Add and use helper for checking tiling support
  drm/sun4i: layer: Add tiled modifier support and helper
  drm/sun4i: drv: Allow framebuffer modifiers in mode config
  drm/sun4i: frontend: Add A20-specific device-tree compatible and
    quirks

 drivers/gpu/drm/sun4i/sun4i_backend.c  |  25 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c      |   1 +
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 346 ++++++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  52 ++++
 drivers/gpu/drm/sun4i/sun4i_layer.c    |  28 +-
 include/drm/drm_fourcc.h               | 117 +++++++++
 include/uapi/drm/drm_fourcc.h          |  16 ++
 7 files changed, 530 insertions(+), 55 deletions(-)

-- 
2.19.2

