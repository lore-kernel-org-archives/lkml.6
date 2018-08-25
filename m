Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D2EC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 19:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7881A216FC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 19:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7881A216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeHYWuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 18:50:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726751AbeHYWuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 18:50:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3154ADBDA;
        Sat, 25 Aug 2018 19:10:45 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D130310F1BF9;
        Sat, 25 Aug 2018 19:10:40 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Jan-Marek Glogowski <glogow@fbihome.de>, stable@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] drm/i915: Re-apply "Perform link quality check, unconditionally during long pulse"
Date:   Sat, 25 Aug 2018 15:10:35 -0400
Message-Id: <20180825191035.3945-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sat, 25 Aug 2018 19:10:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sat, 25 Aug 2018 19:10:45 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan-Marek Glogowski <glogow@fbihome.de>

This re-applies the workaround for "some DP sinks, [which] are a
little nuts" from commit 1a36147bb939 ("drm/i915: Perform link
quality check unconditionally during long pulse").
It makes the secondary AOC E2460P monitor connected via DP to an
acer Veriton N4640G usable again.

This hunk was dropped in commit c85d200e8321 ("drm/i915: Move SST
DP link retraining into the ->post_hotplug() hook")

Fixes: c85d200e8321 ("drm/i915: Move SST DP link retraining into the ->post_hotplug() hook")
[Cleaned up commit message, added stable cc]
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
Cc: stable@vger.kernel.org
---
Resending this to update patchwork; will push in a little bit

 drivers/gpu/drm/i915/intel_dp.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index b3f6f04c3c7d..db8515171270 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -4333,18 +4333,6 @@ intel_dp_needs_link_retrain(struct intel_dp *intel_dp)
 	return !drm_dp_channel_eq_ok(link_status, intel_dp->lane_count);
 }
 
-/*
- * If display is now connected check links status,
- * there has been known issues of link loss triggering
- * long pulse.
- *
- * Some sinks (eg. ASUS PB287Q) seem to perform some
- * weird HPD ping pong during modesets. So we can apparently
- * end up with HPD going low during a modeset, and then
- * going back up soon after. And once that happens we must
- * retrain the link to get a picture. That's in case no
- * userspace component reacted to intermittent HPD dip.
- */
 int intel_dp_retrain_link(struct intel_encoder *encoder,
 			  struct drm_modeset_acquire_ctx *ctx)
 {
@@ -5031,7 +5019,8 @@ intel_dp_unset_edid(struct intel_dp *intel_dp)
 }
 
 static int
-intel_dp_long_pulse(struct intel_connector *connector)
+intel_dp_long_pulse(struct intel_connector *connector,
+		    struct drm_modeset_acquire_ctx *ctx)
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
 	struct intel_dp *intel_dp = intel_attached_dp(&connector->base);
@@ -5090,6 +5079,22 @@ intel_dp_long_pulse(struct intel_connector *connector)
 		 */
 		status = connector_status_disconnected;
 		goto out;
+	} else {
+		/*
+		 * If display is now connected check links status,
+		 * there has been known issues of link loss triggering
+		 * long pulse.
+		 *
+		 * Some sinks (eg. ASUS PB287Q) seem to perform some
+		 * weird HPD ping pong during modesets. So we can apparently
+		 * end up with HPD going low during a modeset, and then
+		 * going back up soon after. And once that happens we must
+		 * retrain the link to get a picture. That's in case no
+		 * userspace component reacted to intermittent HPD dip.
+		 */
+		struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
+
+		intel_dp_retrain_link(encoder, ctx);
 	}
 
 	/*
@@ -5151,7 +5156,7 @@ intel_dp_detect(struct drm_connector *connector,
 				return ret;
 		}
 
-		status = intel_dp_long_pulse(intel_dp->attached_connector);
+		status = intel_dp_long_pulse(intel_dp->attached_connector, ctx);
 	}
 
 	intel_dp->detect_done = false;
-- 
2.17.1

