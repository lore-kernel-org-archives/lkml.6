Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A633EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761E420652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfARMUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:20:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfARMU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:20:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6911D9D508;
        Fri, 18 Jan 2019 12:20:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9C815D96F;
        Fri, 18 Jan 2019 12:20:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8B0BB4FD6A; Fri, 18 Jan 2019 13:20:23 +0100 (CET)
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
Subject: [PATCH v3 22/23] drm/qxl: use kernel mode db
Date:   Fri, 18 Jan 2019 13:20:19 +0100
Message-Id: <20190118122020.27596-23-kraxel@redhat.com>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 18 Jan 2019 12:20:28 +0000 (UTC)
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
index 926fcb49b2..df768b0c83 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -262,34 +262,20 @@ static int qxl_add_monitors_config_modes(struct drm_connector *connector)
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
@@ -1010,7 +996,8 @@ static int qxl_conn_get_modes(struct drm_connector *connector)
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

