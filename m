Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kTfsBV5GGVtjNwAAmS7hNA
	; Thu, 07 Jun 2018 14:51:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EF3C8608BA; Thu,  7 Jun 2018 14:51:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F3E16074D;
	Thu,  7 Jun 2018 14:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F3E16074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934909AbeFGOvL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:51:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40813 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933084AbeFGOrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:47:41 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbG-0005Zo-7X; Thu, 07 Jun 2018 15:09:14 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0003Fy-2S; Thu, 07 Jun 2018 15:09:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "=?UTF-8?q?Michel=20D=C3=A4nzer?=" <michel.daenzer@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.198838328@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 363/410] drm/radeon: Don't turn off DP sink when
 disconnected
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michel Dänzer <michel.daenzer@amd.com>

commit 2681bc79eeb640562c932007bfebbbdc55bf6a7d upstream.

Turning off the sink in this case causes various issues, because
userspace expects it to stay on until it turns it off explicitly.

Instead, turn the sink off and back on when a display is connected
again. This dance seems necessary for link training to work correctly.

Bugzilla: https://bugs.freedesktop.org/105308
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 31 +++++++++-------------
 1 file changed, 12 insertions(+), 19 deletions(-)

--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -66,25 +66,18 @@ void radeon_connector_hotplug(struct drm
 		/* don't do anything if sink is not display port, i.e.,
 		 * passive dp->(dvi|hdmi) adaptor
 		 */
-		if (dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT) {
-			int saved_dpms = connector->dpms;
-			/* Only turn off the display if it's physically disconnected */
-			if (!radeon_hpd_sense(rdev, radeon_connector->hpd.hpd)) {
-				drm_helper_connector_dpms(connector, DRM_MODE_DPMS_OFF);
-			} else if (radeon_dp_needs_link_train(radeon_connector)) {
-				/* Don't try to start link training before we
-				 * have the dpcd */
-				if (!radeon_dp_getdpcd(radeon_connector))
-					return;
+		if (dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT &&
+		    radeon_hpd_sense(rdev, radeon_connector->hpd.hpd) &&
+		    radeon_dp_needs_link_train(radeon_connector)) {
+			/* Don't start link training before we have the DPCD */
+			if (!radeon_dp_getdpcd(radeon_connector))
+				return;
 
-				/* set it to OFF so that drm_helper_connector_dpms()
-				 * won't return immediately since the current state
-				 * is ON at this point.
-				 */
-				connector->dpms = DRM_MODE_DPMS_OFF;
-				drm_helper_connector_dpms(connector, DRM_MODE_DPMS_ON);
-			}
-			connector->dpms = saved_dpms;
+			/* Turn the connector off and back on immediately, which
+			 * will trigger link training
+			 */
+			drm_helper_connector_dpms(connector, DRM_MODE_DPMS_OFF);
+			drm_helper_connector_dpms(connector, DRM_MODE_DPMS_ON);
 		}
 	}
 }
