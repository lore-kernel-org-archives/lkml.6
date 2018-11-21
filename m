Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F407C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF052147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF052147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbeKVCo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:44:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49152 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbeKVCo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:44:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9932D260A1E
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv5 0/6] omapdrm: DSI command mode panel support
Date:   Wed, 21 Nov 2018 17:09:10 +0100
Message-Id: <20181121160916.22017-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is another round of the DSI command mode panel patchset
integrating the feedback from PATCHv4. The patches are based
on 4.20-rc1 + fixes from Laurent and Tony. I dropped the patches
for OMAP3 support (it needs a workaround for a hardware bug) and
for automatic display rotation. They should get their own series,
once this patchset has landed.

Tested on Droid 4:
 * Framebuffer Console, updated at 1Hz due to blinking cursor
 * Display blanking
 * Xorg 1.19 with modesetting driver
 * Weston 5.0 with DRM backend
 * kmstest (static image)
 * No updates send when nothing needs to be sent

Known issues:
 * OMAP3 is untested and most likely broken due to missing
   workaround(s) for hardware bugs.
 * Weston 5.0 with fbdev backend does not work, since it
   uses neither page flip nor dirty ioctl. You need to use
   the drm backend.

Changes since PATCHv4:
 * Apply Acked-/Tested-by received from Tony and Pavel
 * Fix spelling/wording in commit messagess
 * Use proper multi-line comments
 * Restructure patch 4: move the whole HDMI block into a
   static sub-function, that is only called when output
   type is HDMI. Also drop the incorrect check for DVI.

Changes since PATCHv3:
 * Drop all Tested/Acked-by tags
 * Drop the rotation patches for now
 * Rebase to 4.20-rc1 + fixes from Laurent and Tony
 * Add fixes for DSI regressions introduced in 4.20-rc1
 * Store info update manual update mode in omap_crtc_state
 * Lock modesetting in omap_framebuffer_dirty
 * Directly loop through CRTCs instead of connectors in dirty function
 * Properly refresh display during page flips and get Weston working
 * Add more comments about implementation details

Changes since PATCHv2:
 * Drop omap3 quirk patch (OMAP3 should get its own mini-series)
 * Rebase to current linux-next
 * Use existing 'rotation' DT property to set DRM orientation hint
 * Add Tested-by from Tony

Changes since PATCHv1:
 * Drop patches, that were queued by Tomi
 * Rebase to current master
 * Rework the omap3 workaround patch to only affect omap3
 * Add orientation DRM property support

-- Sebastian


Sebastian Reichel (6):
  drm/omap: use DRM_DEBUG_DRIVER instead of CORE
  drm/omap: populate DSI platform bus earlier
  drm/omap: don't check dispc timings for DSI
  drm/omap: fix incorrect union usage
  drm/omap: add framedone interrupt support
  drm/omap: add support for manually updated displays

 drivers/gpu/drm/omapdrm/dss/dsi.c        |  20 +--
 drivers/gpu/drm/omapdrm/omap_connector.c |   8 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c      | 167 ++++++++++++++++++++++-
 drivers/gpu/drm/omapdrm/omap_crtc.h      |   2 +
 drivers/gpu/drm/omapdrm/omap_drv.h       |   4 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c   |  70 ++++++----
 drivers/gpu/drm/omapdrm/omap_fb.c        |  41 ++++++
 drivers/gpu/drm/omapdrm/omap_irq.c       |  25 ++++
 drivers/gpu/drm/omapdrm/omap_irq.h       |   1 +
 9 files changed, 290 insertions(+), 48 deletions(-)

-- 
2.19.1

