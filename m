Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbeCUPat (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:30:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47231 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbeCUPar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:30:47 -0400
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 00/10] drm/sun4i: Frontend YUV and MB32 tile modifier support
Date: Wed, 21 Mar 2018 16:28:54 +0100
Message-Id: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces support for YUV formats in the sun4i DRM driver, through
the frontend. In addition to regular YUV formats, a modifier for the
Allwinner MB32 tiling format is introduced along with a dedicated ioctl
for allocating buffers (through CMA) with the appropriate constraints.

This ioctl must always be used when allocating buffers to be used with
the MB32 tiling modifier, as dumb GEM buffer allocation is reserved for
linear planes.

This series is based on (and requires) the following series:
* drm/sun4i: backend: Support interleaved YUV planes,
  from Maxime Ripard: https://patchwork.freedesktop.org/series/39232/
* drm/sun4i: Support the Display Engine frontend,
  from Maxime Ripard: https://patchwork.freedesktop.org/series/35292/
* drm/sun4i: Support more planes, zpos and plane-wide alpha,
  from Maxime Ripard: https://patchwork.freedesktop.org/series/36183/

Paul Kocialkowski (10):
  drm/sun4i: Disable frontend video channel before enabling a layer
  drm/sun4i: Disable YUV channel when using the frontend and set
    interlace
  drm/sun4i: Don't pretend to handle ARGB8888 with the frontend
  drm/sun4i: Explicitly list and check formats supported by the backend
  drm/sun4i: Explicitly list and check formats supported by the frontend
  drm/sun4i: Move and extend format-related helpers and tables
  drm/sun4i: Add support for YUV formats through the frontend
  drm/fourcc: Add definitions for Allwinner vendor and MB32 tiled format
  drm/sun4i: Add a dedicated ioctl call for allocating tiled buffers
  drm/sun4i: Add support for YUV-based formats in MB32 tiles

 drivers/gpu/drm/sun4i/Makefile         |   1 +
 drivers/gpu/drm/sun4i/sun4i_backend.c  | 148 +++++++++-----
 drivers/gpu/drm/sun4i/sun4i_backend.h  |   6 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c      | 108 +++++++++-
 drivers/gpu/drm/sun4i/sun4i_drv.h      |   6 +
 drivers/gpu/drm/sun4i/sun4i_format.c   | 193 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_format.h   |  35 ++++
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 359 +++++++++++++++++++++++++++++----
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  50 ++++-
 drivers/gpu/drm/sun4i/sun4i_layer.c    |  58 ++++--
 include/uapi/drm/drm_fourcc.h          |  10 +
 include/uapi/drm/sun4i_drm.h           |  42 ++++
 12 files changed, 910 insertions(+), 106 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_format.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_format.h
 create mode 100644 include/uapi/drm/sun4i_drm.h

-- 
2.16.2
