Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9045AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66522214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeLZVCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 16:02:23 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:36977 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeLZVCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 16:02:22 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 59A50803E9;
        Wed, 26 Dec 2018 22:02:17 +0100 (CET)
Date:   Wed, 26 Dec 2018 22:02:15 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 0/7] drm: minimize drmP.h dependencies
Message-ID: <20181226210215.GA27610@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=d4V9eucdeLooxy6TkNsA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal with this small series is to remove the last bits
that prevents us from removing drmP.h file by file.

- drmP.h is now stripped down to include files and forward declarations.
- All header files in include/drm/ no longer include drmP.h.

The series was made on top of 4.20.
Build tested using arm and x86 all{yes,mod}config

Most of the work was to remove the include and fix fallout.

The patches are trivial but touches a lot of files,
so a lot of people on cc: for the individual patches.

I expect the full series to be applied to drm-misc.

There are still ~900 uses of drmP.h so a long way ahead of
us to get rid of the header file.

	Sam

Sam Ravnborg (7):
      drm: move DRM_IF_VERSION to drm_internal.h
      drm: move DRM_SWITCH_POWER defines to drm_device.h
      drm: move drm_can_sleep() to drm_util.h
      drm: remove include of drmP.h from bridge/dw_hdmi.h
      drm: remove include of drmP.h from drm_encoder_slave.h
      drm: remove include of drmP.h from drm_modeset_helper.h
      drm: remove include of drmP.h from drm_gem_cma_helper.h

 drivers/gpu/drm/amd/amdgpu/atom.c                   |  2 ++
 drivers/gpu/drm/arc/arcpgu_crtc.c                   |  2 ++
 drivers/gpu/drm/arc/arcpgu_drv.c                    |  6 ++++++
 drivers/gpu/drm/arc/arcpgu_sim.c                    |  1 +
 drivers/gpu/drm/ast/ast_fb.c                        |  1 +
 drivers/gpu/drm/bridge/cdns-dsi.c                   |  2 ++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c |  4 ++++
 drivers/gpu/drm/cirrus/cirrus_fbdev.c               |  1 +
 drivers/gpu/drm/drm_flip_work.c                     |  1 +
 drivers/gpu/drm/drm_internal.h                      |  2 ++
 drivers/gpu/drm/drm_modeset_helper.c                |  2 ++
 drivers/gpu/drm/mgag200/mgag200_fb.c                |  1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c            |  1 +
 drivers/gpu/drm/omapdrm/omap_fbdev.c                |  1 +
 drivers/gpu/drm/qxl/qxl_cmd.c                       |  2 ++
 drivers/gpu/drm/radeon/atom.c                       |  2 ++
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c     |  1 +
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c              |  1 +
 drivers/gpu/drm/rcar-du/rcar_lvds.c                 |  1 +
 drivers/gpu/drm/stm/drv.c                           |  3 +++
 drivers/gpu/drm/stm/ltdc.c                          |  9 ++++++++-
 drivers/gpu/drm/tinydrm/core/tinydrm-core.c         |  1 +
 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c      |  2 ++
 drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c         |  1 +
 drivers/gpu/drm/tinydrm/ili9225.c                   |  1 +
 drivers/gpu/drm/tinydrm/mipi-dbi.c                  |  3 +++
 drivers/gpu/drm/vc4/vc4_drv.h                       |  1 +
 include/drm/bridge/dw_hdmi.h                        |  5 ++++-
 include/drm/drmP.h                                  | 15 ---------------
 include/drm/drm_device.h                            |  9 +++++++++
 include/drm/drm_encoder_slave.h                     |  1 -
 include/drm/drm_file.h                              |  1 +
 include/drm/drm_gem_cma_helper.h                    |  5 ++++-
 include/drm/drm_modeset_helper.h                    |  2 --
 include/drm/drm_util.h                              | 13 +++++++++++++
 include/drm/tinydrm/tinydrm.h                       |  1 +
 36 files changed, 86 insertions(+), 21 deletions(-)
