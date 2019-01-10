Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FF5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0DF2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfAJI3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:29:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbfAJI2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:28:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 792012DACDA;
        Thu, 10 Jan 2019 08:28:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E83385C883;
        Thu, 10 Jan 2019 08:28:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 41C039D8B; Thu, 10 Jan 2019 09:28:46 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 04/15] drm/bochs: atomic: add mode_set_nofb callback.
Date:   Thu, 10 Jan 2019 09:28:34 +0100
Message-Id: <20190110082845.3453-5-kraxel@redhat.com>
In-Reply-To: <20190110082845.3453-1-kraxel@redhat.com>
References: <20190110082845.3453-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 10 Jan 2019 08:28:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion to atomic modesetting, step two.
Add mode_set_nofb crtc helper callback.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 2cbd406b1f..56fd7be933 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -86,6 +86,14 @@ static int bochs_crtc_mode_set(struct drm_crtc *crtc,
 	return 0;
 }
 
+static void bochs_crtc_mode_set_nofb(struct drm_crtc *crtc)
+{
+	struct bochs_device *bochs =
+		container_of(crtc, struct bochs_device, crtc);
+
+	bochs_hw_setmode(bochs, &crtc->mode);
+}
+
 static void bochs_crtc_prepare(struct drm_crtc *crtc)
 {
 }
@@ -149,6 +157,7 @@ static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
 	.dpms = bochs_crtc_dpms,
 	.mode_set = bochs_crtc_mode_set,
 	.mode_set_base = bochs_crtc_mode_set_base,
+	.mode_set_nofb = bochs_crtc_mode_set_nofb,
 	.prepare = bochs_crtc_prepare,
 	.commit = bochs_crtc_commit,
 	.atomic_enable = bochs_crtc_atomic_enable,
-- 
2.9.3

