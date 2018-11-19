Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBEC214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMTLCvAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBEC214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbeKTDKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387731AbeKTDKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:10:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7717214E0;
        Mon, 19 Nov 2018 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645981;
        bh=P5SO6vqNPo/ZIAVEPtN+GY47/gL4oJlCPzDrZLTesVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMTLCvAqeEmQPUo8GfrUDNBpu24rf4M2JlV+eDlaJlyLfP0UOHcyC7BnALM5AlEUm
         5yHhi/KESKj9FYq7eGZgFCC8mnkJuEatHlJJKtI3XI7arMeZI0h1y1Aqc5y3F7LoT9
         3VaIFrKRUccMJc5wNEQz4ldCE/AX2v0o/yTH6J0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Clinton Taylor <clinton.a.taylor@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Alexander Wilson <alexander.wilson@ncf.edu>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.18 155/171] drm/i915/dp: Link train Fallback on eDP only if fallback link BW can fit panels native mode
Date:   Mon, 19 Nov 2018 17:29:11 +0100
Message-Id: <20181119162640.176147180@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

From: Manasi Navare <manasi.d.navare@intel.com>

commit 041444458835d7fb2c9f042598bfe16bf375b15d upstream.

This patch fixes the original commit c0cfb10d9e1de49 ("drm/i915/edp:
Do not do link training fallback or prune modes on EDP") that causes
a blank screen in case of certain eDP panels (Eg: seen on Dell XPS13 9350)
where first link training fails and a retraining is required by falling
back to lower link rate/lane count.
In case of some panels they advertise higher link rate/lane count
than whats required for supporting the panel's native mode.
But we always link train at highest link rate/lane count for eDP
and if that fails we can still fallback to lower link rate/lane count
as long as the fallback link BW still fits the native mode to avoid
pruning the panel's native mode yet retraining at fallback values
to recover from a blank screen.

v3:
* Add const for fixed_mode (Ville)
v2:
* Send uevent if link failure on eDP unconditionally

Fixes: c0cfb10d9e1d ("drm/i915/edp: Do not do link training fallback or prune modes on EDP")
Cc: Clinton Taylor <clinton.a.taylor@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v4.17+
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=107489
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=105338
Signed-off-by: Manasi Navare <manasi.d.navare@intel.com>
Tested-by: Alexander Wilson <alexander.wilson@ncf.edu>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181009212804.702-1-manasi.d.navare@intel.com
(cherry picked from commit 1e712535c51ab025ebc776d4405683d81521996d)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_dp.c               |   30 ++++++++++++++++++++++++++
 drivers/gpu/drm/i915/intel_dp_link_training.c |   26 +++++++---------------
 2 files changed, 39 insertions(+), 17 deletions(-)

--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -387,6 +387,22 @@ static bool intel_dp_link_params_valid(s
 	return true;
 }
 
+static bool intel_dp_can_link_train_fallback_for_edp(struct intel_dp *intel_dp,
+						     int link_rate,
+						     uint8_t lane_count)
+{
+	const struct drm_display_mode *fixed_mode =
+		intel_dp->attached_connector->panel.fixed_mode;
+	int mode_rate, max_rate;
+
+	mode_rate = intel_dp_link_required(fixed_mode->clock, 18);
+	max_rate = intel_dp_max_data_rate(link_rate, lane_count);
+	if (mode_rate > max_rate)
+		return false;
+
+	return true;
+}
+
 int intel_dp_get_link_train_fallback_values(struct intel_dp *intel_dp,
 					    int link_rate, uint8_t lane_count)
 {
@@ -396,9 +412,23 @@ int intel_dp_get_link_train_fallback_val
 				    intel_dp->num_common_rates,
 				    link_rate);
 	if (index > 0) {
+		if (intel_dp_is_edp(intel_dp) &&
+		    !intel_dp_can_link_train_fallback_for_edp(intel_dp,
+							      intel_dp->common_rates[index - 1],
+							      lane_count)) {
+			DRM_DEBUG_KMS("Retrying Link training for eDP with same parameters\n");
+			return 0;
+		}
 		intel_dp->max_link_rate = intel_dp->common_rates[index - 1];
 		intel_dp->max_link_lane_count = lane_count;
 	} else if (lane_count > 1) {
+		if (intel_dp_is_edp(intel_dp) &&
+		    !intel_dp_can_link_train_fallback_for_edp(intel_dp,
+							      intel_dp_max_common_rate(intel_dp),
+							      lane_count >> 1)) {
+			DRM_DEBUG_KMS("Retrying Link training for eDP with same parameters\n");
+			return 0;
+		}
 		intel_dp->max_link_rate = intel_dp_max_common_rate(intel_dp);
 		intel_dp->max_link_lane_count = lane_count >> 1;
 	} else {
--- a/drivers/gpu/drm/i915/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/intel_dp_link_training.c
@@ -335,22 +335,14 @@ intel_dp_start_link_train(struct intel_d
 	return;
 
  failure_handling:
-	/* Dont fallback and prune modes if its eDP */
-	if (!intel_dp_is_edp(intel_dp)) {
-		DRM_DEBUG_KMS("[CONNECTOR:%d:%s] Link Training failed at link rate = %d, lane count = %d",
-			      intel_connector->base.base.id,
-			      intel_connector->base.name,
-			      intel_dp->link_rate, intel_dp->lane_count);
-		if (!intel_dp_get_link_train_fallback_values(intel_dp,
-							     intel_dp->link_rate,
-							     intel_dp->lane_count))
-			/* Schedule a Hotplug Uevent to userspace to start modeset */
-			schedule_work(&intel_connector->modeset_retry_work);
-	} else {
-		DRM_ERROR("[CONNECTOR:%d:%s] Link Training failed at link rate = %d, lane count = %d",
-			  intel_connector->base.base.id,
-			  intel_connector->base.name,
-			  intel_dp->link_rate, intel_dp->lane_count);
-	}
+	DRM_DEBUG_KMS("[CONNECTOR:%d:%s] Link Training failed at link rate = %d, lane count = %d",
+		      intel_connector->base.base.id,
+		      intel_connector->base.name,
+		      intel_dp->link_rate, intel_dp->lane_count);
+	if (!intel_dp_get_link_train_fallback_values(intel_dp,
+						     intel_dp->link_rate,
+						     intel_dp->lane_count))
+		/* Schedule a Hotplug Uevent to userspace to start modeset */
+		schedule_work(&intel_connector->modeset_retry_work);
 	return;
 }


