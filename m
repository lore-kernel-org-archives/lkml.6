Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A714CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3DA20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3DA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbeGXJ1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:27:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58710 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388461AbeGXJ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:27:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: robertfoss)
        with ESMTPSA id CBC3626B847
From:   Robert Foss <robert.foss@collabora.com>
To:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Eric Engestrom <eric.engestrom@intel.com>,
        Brian Paul <brianp@vmware.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Nicolas Norvez <norvez@chromium.org>,
        Robert Foss <robert.foss@collabora.com>
Subject: [RFC] drm: Allow DRM_IOCTL_MODE_MAP_DUMB for render nodes
Date:   Tue, 24 Jul 2018 10:22:13 +0200
Message-Id: <20180724082213.25677-1-robert.foss@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tfiga@chromium.org>

There is no particular reason to prevent userspace for using this IOCTL,
considering that it already has access to other, platform-specific
IOCTLs. This patch makes is possible to have the same userspace code
work regardless on the underlying platform, which significantly
simplifies the stack.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Reviewed-by: Zach Reizner <zachr@chromium.org>
Signed-off-by: Nicolas Norvez <norvez@chromium.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Robert Foss <robert.foss@collabora.com>
---

I've been looking into enabling a kms_swrast based driver for mesa on
the Android platform[1].

But have come up against the issue of dumb buffer related ioctls below 
not being flagged with DRM_RENDER_ALLOW.

DRM_IOCTL_MODE_CREATE_DUMB
DRM_IOCTL_MODE_MAP_DUMB

To be more precise, I've been seeing a failure due to DRM_IOCTL_MODE_MAP_DUMB
not being allowed for /dev/dri/renderD* nodes, and used in mesa
kms_sw_displaytarget_map().


As I understand it the DRM_RENDER_ALLOW flag being unset is a very intentional
restriction placed on dumb buffers in order to minimize its use.
But as far as alternative solutions for software renderers there seems to only
be VGEM and mmap()-ing DMABUFs.

While it would be convenient from the point of view of software renderers if
dumb buffers had more promiscuous permissions, it may be a hard sell upstream.

If dumb buffers aren't the way forward, what is? VGEM? Or are there any other
preferable ways?


[1] https://patchwork.freedesktop.org/series/45966/

 drivers/gpu/drm/drm_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 0d4cfb232576..ef716246baf6 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -642,8 +642,8 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_RMFB, drm_mode_rmfb, DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_PAGE_FLIP, drm_mode_page_flip_ioctl, DRM_MASTER|DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_DIRTYFB, drm_mode_dirtyfb_ioctl, DRM_MASTER|DRM_UNLOCKED),
-	DRM_IOCTL_DEF(DRM_IOCTL_MODE_CREATE_DUMB, drm_mode_create_dumb_ioctl, DRM_UNLOCKED),
-	DRM_IOCTL_DEF(DRM_IOCTL_MODE_MAP_DUMB, drm_mode_mmap_dumb_ioctl, DRM_UNLOCKED),
+	DRM_IOCTL_DEF(DRM_IOCTL_MODE_CREATE_DUMB, drm_mode_create_dumb_ioctl, DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF(DRM_IOCTL_MODE_MAP_DUMB, drm_mode_mmap_dumb_ioctl, DRM_UNLOCKED|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_DESTROY_DUMB, drm_mode_destroy_dumb_ioctl, DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_OBJ_GETPROPERTIES, drm_mode_obj_get_properties_ioctl, DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_OBJ_SETPROPERTY, drm_mode_obj_set_property_ioctl, DRM_MASTER|DRM_UNLOCKED),
-- 
2.17.1

