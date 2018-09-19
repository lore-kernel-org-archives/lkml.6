Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E4DECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C088A2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C088A2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbeISQuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:50:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeISQuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:50:21 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE4743091D64;
        Wed, 19 Sep 2018 11:12:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C02089F2A;
        Wed, 19 Sep 2018 11:12:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A2BB09C40B; Wed, 19 Sep 2018 13:12:52 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     michel@daenzer.net, imirkin@alum.mit.edu,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/5] drm: use drm_mode_legacy_fb_format2 in drm_gem_fbdev_fb_create
Date:   Wed, 19 Sep 2018 13:12:49 +0200
Message-Id: <20180919111252.7932-3-kraxel@redhat.com>
In-Reply-To: <20180919111252.7932-1-kraxel@redhat.com>
References: <20180919111252.7932-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 19 Sep 2018 11:12:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating framebuffers for fbdev emulation should use the correct format
code too, so switch drm_gem_fbdev_fb_create() over to use the new
drm_mode_legacy_fb_format2() function.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_gem_framebuffer_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index 7607f9cd6f..3619f1c78a 100644
--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -308,6 +308,7 @@ drm_gem_fbdev_fb_create(struct drm_device *dev,
 			const struct drm_framebuffer_funcs *funcs)
 {
 	struct drm_mode_fb_cmd2 mode_cmd = { 0 };
+	bool native = dev->mode_config.quirk_addfb_prefer_host_byte_order;
 
 	mode_cmd.width = sizes->surface_width;
 	mode_cmd.height = sizes->surface_height;
@@ -316,8 +317,9 @@ drm_gem_fbdev_fb_create(struct drm_device *dev,
 	if (pitch_align)
 		mode_cmd.pitches[0] = roundup(mode_cmd.pitches[0],
 					      pitch_align);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
-							sizes->surface_depth);
+	mode_cmd.pixel_format = drm_mode_legacy_fb_format2(sizes->surface_bpp,
+							   sizes->surface_depth,
+							   native);
 	if (obj->size < mode_cmd.pitches[0] * mode_cmd.height)
 		return ERR_PTR(-EINVAL);
 
-- 
2.9.3

