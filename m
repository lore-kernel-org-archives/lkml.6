Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA21CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5A920864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5A920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936133AbeFRIY3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:24:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56022 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935930AbeFRIYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:24:25 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A2502BAD;
        Mon, 18 Jun 2018 08:24:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 196/279] drm/omap: handle alloc failures in omap_connector
Date:   Mon, 18 Jun 2018 10:13:01 +0200
Message-Id: <20180618080617.025673271@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 47aaaec818dfd1009d1358974a2931f05dd57203 ]

Handle memory allocation failures in omap_connector to avoid NULL
derefs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180502091159.7071-5-tomi.valkeinen@ti.com
Reviewed-by: Benoit Parrot <bparrot@ti.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/omapdrm/omap_connector.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -121,6 +121,9 @@ static int omap_connector_get_modes(stru
 	if (dssdrv->read_edid) {
 		void *edid = kzalloc(MAX_EDID, GFP_KERNEL);
 
+		if (!edid)
+			return 0;
+
 		if ((dssdrv->read_edid(dssdev, edid, MAX_EDID) > 0) &&
 				drm_edid_is_valid(edid)) {
 			drm_mode_connector_update_edid_property(
@@ -139,6 +142,9 @@ static int omap_connector_get_modes(stru
 		struct drm_display_mode *mode = drm_mode_create(dev);
 		struct videomode vm = {0};
 
+		if (!mode)
+			return 0;
+
 		dssdrv->get_timings(dssdev, &vm);
 
 		drm_display_mode_from_videomode(&vm, mode);
@@ -200,6 +206,10 @@ static int omap_connector_mode_valid(str
 	if (!r) {
 		/* check if vrefresh is still valid */
 		new_mode = drm_mode_duplicate(dev, mode);
+
+		if (!new_mode)
+			return MODE_BAD;
+
 		new_mode->clock = vm.pixelclock / 1000;
 		new_mode->vrefresh = 0;
 		if (mode->vrefresh == drm_mode_vrefresh(new_mode))


