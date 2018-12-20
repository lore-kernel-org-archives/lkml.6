Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D60C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9422176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbeLTKL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:11:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18047 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbeLTKL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:11:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADFC65D608;
        Thu, 20 Dec 2018 10:11:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A9656063D;
        Thu, 20 Dec 2018 10:11:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1D398753E; Thu, 20 Dec 2018 11:11:22 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     andr2000@gmail.com, daniel.vetter@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] drm/bochs: add edid present check
Date:   Thu, 20 Dec 2018 11:11:21 +0100
Message-Id: <20181220101122.16153-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 20 Dec 2018 10:11:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check header before trying to read the complete edid blob, to avoid the
log being spammed in case qemu has no edid support (old qemu or edid
support turned off).

Fixes: 01f23459cf drm/bochs: add edid support.
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_hw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index c90a0d492f..d0b4e1cee8 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -86,9 +86,16 @@ static int bochs_get_edid_block(void *data, u8 *buf,
 
 int bochs_hw_load_edid(struct bochs_device *bochs)
 {
+	u8 header[8];
+
 	if (!bochs->mmio)
 		return -1;
 
+	/* check header to detect whenever edid support is enabled in qemu */
+	bochs_get_edid_block(bochs, header, 0, ARRAY_SIZE(header));
+	if (drm_edid_header_is_valid(header) != 8)
+		return -1;
+
 	kfree(bochs->edid);
 	bochs->edid = drm_do_get_edid(&bochs->connector,
 				      bochs_get_edid_block, bochs);
-- 
2.9.3

