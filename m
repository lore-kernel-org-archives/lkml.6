Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17532C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27EC20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27EC20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967857AbeFRIfQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:35:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967323AbeFRIfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:35:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6C094C8A;
        Mon, 18 Jun 2018 08:35:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Benoit Parrot <bparrot@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 127/189] drm/omap: handle alloc failures in omap_connector
Date:   Mon, 18 Jun 2018 10:13:43 +0200
Message-Id: <20180618081214.348463963@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -123,6 +123,9 @@ static int omap_connector_get_modes(stru
 	if (dssdrv->read_edid) {
 		void *edid = kzalloc(MAX_EDID, GFP_KERNEL);
 
+		if (!edid)
+			return 0;
+
 		if ((dssdrv->read_edid(dssdev, edid, MAX_EDID) > 0) &&
 				drm_edid_is_valid(edid)) {
 			drm_mode_connector_update_edid_property(
@@ -141,6 +144,9 @@ static int omap_connector_get_modes(stru
 		struct drm_display_mode *mode = drm_mode_create(dev);
 		struct videomode vm = {0};
 
+		if (!mode)
+			return 0;
+
 		dssdrv->get_timings(dssdev, &vm);
 
 		drm_display_mode_from_videomode(&vm, mode);
@@ -196,6 +202,10 @@ static int omap_connector_mode_valid(str
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


