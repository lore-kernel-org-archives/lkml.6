Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD96C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E9620859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbfAPIf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:35:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729346AbfAPIf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:35:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A832381F13;
        Wed, 16 Jan 2019 08:35:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-186.ams2.redhat.com [10.36.117.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E40995D967;
        Wed, 16 Jan 2019 08:35:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EAECF9AD9; Wed, 16 Jan 2019 09:35:21 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/qxl: use kernel mode db
Date:   Wed, 16 Jan 2019 09:35:21 +0100
Message-Id: <20190116083521.22673-4-kraxel@redhat.com>
In-Reply-To: <20190116083521.22673-1-kraxel@redhat.com>
References: <20190116083521.22673-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 16 Jan 2019 08:35:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all standard modes from the kernel's video mode data base.
Keep a few non-standard modes in the qxl mode list.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index b87f72f59e..9e49472872 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -256,34 +256,20 @@ static int qxl_add_monitors_config_modes(struct drm_connector *connector)
 static struct mode_size {
 	int w;
 	int h;
-} common_modes[] = {
-	{ 640,  480},
+} extra_modes[] = {
 	{ 720,  480},
-	{ 800,  600},
-	{ 848,  480},
-	{1024,  768},
 	{1152,  768},
-	{1280,  720},
-	{1280,  800},
 	{1280,  854},
-	{1280,  960},
-	{1280, 1024},
-	{1440,  900},
-	{1400, 1050},
-	{1680, 1050},
-	{1600, 1200},
-	{1920, 1080},
-	{1920, 1200}
 };
 
-static int qxl_add_common_modes(struct drm_connector *connector)
+static int qxl_add_extra_modes(struct drm_connector *connector)
 {
 	int i, ret = 0;
 
-	for (i = 0; i < ARRAY_SIZE(common_modes); i++)
+	for (i = 0; i < ARRAY_SIZE(extra_modes); i++)
 		ret += qxl_add_mode(connector,
-				    common_modes[i].w,
-				    common_modes[i].h,
+				    extra_modes[i].w,
+				    extra_modes[i].h,
 				    false);
 	return ret;
 }
@@ -954,7 +940,8 @@ static int qxl_conn_get_modes(struct drm_connector *connector)
 			pheight = head->height;
 	}
 
-	ret += qxl_add_common_modes(connector);
+	ret += drm_add_modes_noedid(connector, 8192, 8192);
+	ret += qxl_add_extra_modes(connector);
 	ret += qxl_add_monitors_config_modes(connector);
 	drm_set_preferred_mode(connector, pwidth, pheight);
 	return ret;
-- 
2.9.3

