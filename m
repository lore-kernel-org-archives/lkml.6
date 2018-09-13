Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E194FC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47E620652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47E620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbeIMTOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:14:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35468 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731360AbeIMTOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:14:46 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 45D9CD36;
        Thu, 13 Sep 2018 14:05:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Jan-Marek Glogowski <glogow@fbihome.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.18 181/197] drm/i915: Re-apply "Perform link quality check, unconditionally during long pulse"
Date:   Thu, 13 Sep 2018 15:32:10 +0200
Message-Id: <20180913131848.803046555@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan-Marek Glogowski <glogow@fbihome.de>

commit 399334708b4f07b107094e5db4a390f0f25d2d4f upstream.

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
Link: https://patchwork.freedesktop.org/patch/msgid/20180825191035.3945-1-lyude@redhat.com
(cherry picked from commit 3cf71bc9904d7ee4a25a822c5dcb54c7804ea388)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_dp.c |   33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -4293,18 +4293,6 @@ intel_dp_needs_link_retrain(struct intel
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
@@ -4794,7 +4782,8 @@ intel_dp_unset_edid(struct intel_dp *int
 }
 
 static int
-intel_dp_long_pulse(struct intel_connector *connector)
+intel_dp_long_pulse(struct intel_connector *connector,
+		    struct drm_modeset_acquire_ctx *ctx)
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
 	struct intel_dp *intel_dp = intel_attached_dp(&connector->base);
@@ -4853,6 +4842,22 @@ intel_dp_long_pulse(struct intel_connect
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
@@ -4914,7 +4919,7 @@ intel_dp_detect(struct drm_connector *co
 				return ret;
 		}
 
-		status = intel_dp_long_pulse(intel_dp->attached_connector);
+		status = intel_dp_long_pulse(intel_dp->attached_connector, ctx);
 	}
 
 	intel_dp->detect_done = false;


