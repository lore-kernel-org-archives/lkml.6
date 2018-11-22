Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA14C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8110E20663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U2uQOThz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F8JAq5a5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8110E20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393373AbeKVTpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:45:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35272 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbeKVTpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:45:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 80CEC60714; Thu, 22 Nov 2018 09:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542877632;
        bh=Ls7JldJerK/b84A6LtiFBPZIThOxbflUt7BZzPt45QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2uQOThzs7ykEKBL0/VN6tDYp8fAS0igh0pvme8L944QGYLGis9/kQxQ7cIahzo1J
         0d7YX0js/6TLl9+9jdsuXYwtUZpKTCYFdArkWGS54kTsM+DFg0TP9nzuKhq5R1LPGx
         dZSKrPGoQCWLU/Pa2nP3R6mTbuzygwxr54UxEp1o=
Received: from skolluku-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: skolluku@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DAB9260B19;
        Thu, 22 Nov 2018 09:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542877629;
        bh=Ls7JldJerK/b84A6LtiFBPZIThOxbflUt7BZzPt45QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8JAq5a5Fvci0Ik0mCbTwHLz5RJIaevQ0uxneR67WGJjGK5v/hDEFgaWYcbkG0c8L
         Naod9c3OudWthXZPPm4qs4NgZaMWWKUsdg5JjGnRQaeB2fGSDW6MTT0JcMoBrBBMi8
         dUfkSkFBjn7T+m0HZAkotlinqHLOG+78jtd2j2c0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAB9260B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skolluku@codeaurora.org
From:   Sravanthi Kollukuduru <skolluku@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, sean@poorly.run
Subject: [PATCH v3 1/3] drm/msm/dpu: clean up references of DPU custom bus scaling
Date:   Thu, 22 Nov 2018 14:36:51 +0530
Message-Id: <20181122090653.3523-2-skolluku@codeaurora.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181122090653.3523-1-skolluku@codeaurora.org>
References: <20181122090653.3523-1-skolluku@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the upstream interconnect bus framework has landed
upstream, the existing references of custom bus scaling
needs to be cleaned up.

Changes in v2:
	- Fixed build error due to partial clean up

Changes in v3:
	- Condense multiple lines into a single line (Sean Paul)

Signed-off-by: Sravanthi Kollukuduru <skolluku@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c    | 174 +++++++++--------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h    |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c         |  13 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c |  47 ++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h |  68 ---------
 drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h        |  22 +--
 6 files changed, 89 insertions(+), 239 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
index 22e84b3d7f98..c75536ece3ed 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
@@ -84,7 +84,6 @@ static void _dpu_core_perf_calc_crtc(struct dpu_kms *kms,
 		struct dpu_core_perf_params *perf)
 {
 	struct dpu_crtc_state *dpu_cstate;
-	int i;
 
 	if (!kms || !kms->catalog || !crtc || !state || !perf) {
 		DPU_ERROR("invalid parameters\n");
@@ -95,35 +94,24 @@ static void _dpu_core_perf_calc_crtc(struct dpu_kms *kms,
 	memset(perf, 0, sizeof(struct dpu_core_perf_params));
 
 	if (!dpu_cstate->bw_control) {
-		for (i = 0; i < DPU_POWER_HANDLE_DBUS_ID_MAX; i++) {
-			perf->bw_ctl[i] = kms->catalog->perf.max_bw_high *
+		perf->bw_ctl = kms->catalog->perf.max_bw_high *
 					1000ULL;
-			perf->max_per_pipe_ib[i] = perf->bw_ctl[i];
-		}
+		perf->max_per_pipe_ib = perf->bw_ctl;
 		perf->core_clk_rate = kms->perf.max_core_clk_rate;
 	} else if (kms->perf.perf_tune.mode == DPU_PERF_MODE_MINIMUM) {
-		for (i = 0; i < DPU_POWER_HANDLE_DBUS_ID_MAX; i++) {
-			perf->bw_ctl[i] = 0;
-			perf->max_per_pipe_ib[i] = 0;
-		}
+		perf->bw_ctl = 0;
+		perf->max_per_pipe_ib = 0;
 		perf->core_clk_rate = 0;
 	} else if (kms->perf.perf_tune.mode == DPU_PERF_MODE_FIXED) {
-		for (i = 0; i < DPU_POWER_HANDLE_DBUS_ID_MAX; i++) {
-			perf->bw_ctl[i] = kms->perf.fix_core_ab_vote;
-			perf->max_per_pipe_ib[i] = kms->perf.fix_core_ib_vote;
-		}
+		perf->bw_ctl = kms->perf.fix_core_ab_vote;
+		perf->max_per_pipe_ib = kms->perf.fix_core_ib_vote;
 		perf->core_clk_rate = kms->perf.fix_core_clk_rate;
 	}
 
 	DPU_DEBUG(
-		"crtc=%d clk_rate=%llu core_ib=%llu core_ab=%llu llcc_ib=%llu llcc_ab=%llu mem_ib=%llu mem_ab=%llu\n",
+		"crtc=%d clk_rate=%llu core_ib=%llu core_ab=%llu\n",
 			crtc->base.id, perf->core_clk_rate,
-			perf->max_per_pipe_ib[DPU_POWER_HANDLE_DBUS_ID_MNOC],
-			perf->bw_ctl[DPU_POWER_HANDLE_DBUS_ID_MNOC],
-			perf->max_per_pipe_ib[DPU_POWER_HANDLE_DBUS_ID_LLCC],
-			perf->bw_ctl[DPU_POWER_HANDLE_DBUS_ID_LLCC],
-			perf->max_per_pipe_ib[DPU_POWER_HANDLE_DBUS_ID_EBI],
-			perf->bw_ctl[DPU_POWER_HANDLE_DBUS_ID_EBI]);
+			perf->max_per_pipe_ib, perf->bw_ctl);
 }
 
 int dpu_core_perf_crtc_check(struct drm_crtc *crtc,
@@ -136,7 +124,6 @@ int dpu_core_perf_crtc_check(struct drm_crtc *crtc,
 	struct dpu_crtc_state *dpu_cstate;
 	struct drm_crtc *tmp_crtc;
 	struct dpu_kms *kms;
-	int i;
 
 	if (!crtc || !state) {
 		DPU_ERROR("invalid crtc\n");
@@ -158,31 +145,25 @@ int dpu_core_perf_crtc_check(struct drm_crtc *crtc,
 	/* obtain new values */
 	_dpu_core_perf_calc_crtc(kms, crtc, state, &dpu_cstate->new_perf);
 
-	for (i = DPU_POWER_HANDLE_DBUS_ID_MNOC;
-			i < DPU_POWER_HANDLE_DBUS_ID_MAX; i++) {
-		bw_sum_of_intfs = dpu_cstate->new_perf.bw_ctl[i];
-		curr_client_type = dpu_crtc_get_client_type(crtc);
+	bw_sum_of_intfs = dpu_cstate->new_perf.bw_ctl;
+	curr_client_type = dpu_crtc_get_client_type(crtc);
 
-		drm_for_each_crtc(tmp_crtc, crtc->dev) {
-			if (_dpu_core_perf_crtc_is_power_on(tmp_crtc) &&
-			    (dpu_crtc_get_client_type(tmp_crtc) ==
-					    curr_client_type) &&
-			    (tmp_crtc != crtc)) {
-				struct dpu_crtc_state *tmp_cstate =
-					to_dpu_crtc_state(tmp_crtc->state);
-
-				DPU_DEBUG("crtc:%d bw:%llu ctrl:%d\n",
-					tmp_crtc->base.id,
-					tmp_cstate->new_perf.bw_ctl[i],
-					tmp_cstate->bw_control);
-				/*
-				 * For bw check only use the bw if the
-				 * atomic property has been already set
-				 */
-				if (tmp_cstate->bw_control)
-					bw_sum_of_intfs +=
-						tmp_cstate->new_perf.bw_ctl[i];
-			}
+	drm_for_each_crtc(tmp_crtc, crtc->dev) {
+		if (_dpu_core_perf_crtc_is_power_on(tmp_crtc) &&
+		    (dpu_crtc_get_client_type(tmp_crtc) ==
+				curr_client_type) && (tmp_crtc != crtc)) {
+			struct dpu_crtc_state *tmp_cstate =
+				to_dpu_crtc_state(tmp_crtc->state);
+
+			DPU_DEBUG("crtc:%d bw:%llu ctrl:%d\n",
+				tmp_crtc->base.id, tmp_cstate->new_perf.bw_ctl,
+				tmp_cstate->bw_control);
+			/*
+			 * For bw check only use the bw if the
+			 * atomic property has been already set
+			 */
+			if (tmp_cstate->bw_control)
+				bw_sum_of_intfs += tmp_cstate->new_perf.bw_ctl;
 		}
 
 		/* convert bandwidth to kb */
@@ -213,9 +194,9 @@ int dpu_core_perf_crtc_check(struct drm_crtc *crtc,
 }
 
 static int _dpu_core_perf_crtc_update_bus(struct dpu_kms *kms,
-		struct drm_crtc *crtc, u32 bus_id)
+		struct drm_crtc *crtc)
 {
-	struct dpu_core_perf_params perf = { { 0 } };
+	struct dpu_core_perf_params perf = { 0 };
 	enum dpu_crtc_client_type curr_client_type
 					= dpu_crtc_get_client_type(crtc);
 	struct drm_crtc *tmp_crtc;
@@ -228,13 +209,11 @@ static int _dpu_core_perf_crtc_update_bus(struct dpu_kms *kms,
 				dpu_crtc_get_client_type(tmp_crtc)) {
 			dpu_cstate = to_dpu_crtc_state(tmp_crtc->state);
 
-			perf.max_per_pipe_ib[bus_id] =
-				max(perf.max_per_pipe_ib[bus_id],
-				dpu_cstate->new_perf.max_per_pipe_ib[bus_id]);
+			perf.max_per_pipe_ib = max(perf.max_per_pipe_ib,
+					dpu_cstate->new_perf.max_per_pipe_ib);
 
-			DPU_DEBUG("crtc=%d bus_id=%d bw=%llu\n",
-				tmp_crtc->base.id, bus_id,
-				dpu_cstate->new_perf.bw_ctl[bus_id]);
+			DPU_DEBUG("crtc=%d bw=%llu\n", tmp_crtc->base.id,
+					dpu_cstate->new_perf.bw_ctl);
 		}
 	}
 	return ret;
@@ -254,7 +233,6 @@ void dpu_core_perf_crtc_release_bw(struct drm_crtc *crtc)
 	struct dpu_crtc *dpu_crtc;
 	struct dpu_crtc_state *dpu_cstate;
 	struct dpu_kms *kms;
-	int i;
 
 	if (!crtc) {
 		DPU_ERROR("invalid crtc\n");
@@ -290,10 +268,8 @@ void dpu_core_perf_crtc_release_bw(struct drm_crtc *crtc)
 	if (kms->perf.enable_bw_release) {
 		trace_dpu_cmd_release_bw(crtc->base.id);
 		DPU_DEBUG("Release BW crtc=%d\n", crtc->base.id);
-		for (i = 0; i < DPU_POWER_HANDLE_DBUS_ID_MAX; i++) {
-			dpu_crtc->cur_perf.bw_ctl[i] = 0;
-			_dpu_core_perf_crtc_update_bus(kms, crtc, i);
-		}
+		dpu_crtc->cur_perf.bw_ctl = 0;
+		_dpu_core_perf_crtc_update_bus(kms, crtc);
 	}
 }
 
@@ -336,11 +312,10 @@ int dpu_core_perf_crtc_update(struct drm_crtc *crtc,
 		int params_changed, bool stop_req)
 {
 	struct dpu_core_perf_params *new, *old;
-	int update_bus = 0, update_clk = 0;
+	bool update_bus = false, update_clk = false;
 	u64 clk_rate = 0;
 	struct dpu_crtc *dpu_crtc;
 	struct dpu_crtc_state *dpu_cstate;
-	int i;
 	struct msm_drm_private *priv;
 	struct dpu_kms *kms;
 	int ret;
@@ -367,62 +342,49 @@ int dpu_core_perf_crtc_update(struct drm_crtc *crtc,
 	new = &dpu_cstate->new_perf;
 
 	if (_dpu_core_perf_crtc_is_power_on(crtc) && !stop_req) {
-		for (i = 0; i < DPU_POWER_HANDLE_DBUS_ID_MAX; i++) {
-			/*
-			 * cases for bus bandwidth update.
-			 * 1. new bandwidth vote - "ab or ib vote" is higher
-			 *    than current vote for update request.
-			 * 2. new bandwidth vote - "ab or ib vote" is lower
-			 *    than current vote at end of commit or stop.
-			 */
-			if ((params_changed && ((new->bw_ctl[i] >
-						old->bw_ctl[i]) ||
-				  (new->max_per_pipe_ib[i] >
-						old->max_per_pipe_ib[i]))) ||
-			    (!params_changed && ((new->bw_ctl[i] <
-						old->bw_ctl[i]) ||
-				  (new->max_per_pipe_ib[i] <
-						old->max_per_pipe_ib[i])))) {
-				DPU_DEBUG(
-					"crtc=%d p=%d new_bw=%llu,old_bw=%llu\n",
-					crtc->base.id, params_changed,
-					new->bw_ctl[i], old->bw_ctl[i]);
-				old->bw_ctl[i] = new->bw_ctl[i];
-				old->max_per_pipe_ib[i] =
-						new->max_per_pipe_ib[i];
-				update_bus |= BIT(i);
-			}
+		/*
+		 * cases for bus bandwidth update.
+		 * 1. new bandwidth vote - "ab or ib vote" is higher
+		 *    than current vote for update request.
+		 * 2. new bandwidth vote - "ab or ib vote" is lower
+		 *    than current vote at end of commit or stop.
+		 */
+		if ((params_changed && ((new->bw_ctl > old->bw_ctl) ||
+			(new->max_per_pipe_ib > old->max_per_pipe_ib)))	||
+			(!params_changed && ((new->bw_ctl < old->bw_ctl) ||
+			(new->max_per_pipe_ib < old->max_per_pipe_ib)))) {
+			DPU_DEBUG("crtc=%d p=%d new_bw=%llu,old_bw=%llu\n",
+				crtc->base.id, params_changed,
+				new->bw_ctl, old->bw_ctl);
+			old->bw_ctl = new->bw_ctl;
+			old->max_per_pipe_ib = new->max_per_pipe_ib;
+			update_bus = true;
 		}
 
 		if ((params_changed &&
-				(new->core_clk_rate > old->core_clk_rate)) ||
-				(!params_changed &&
-				(new->core_clk_rate < old->core_clk_rate))) {
+			(new->core_clk_rate > old->core_clk_rate)) ||
+			(!params_changed &&
+			(new->core_clk_rate < old->core_clk_rate))) {
 			old->core_clk_rate = new->core_clk_rate;
-			update_clk = 1;
+			update_clk = true;
 		}
 	} else {
 		DPU_DEBUG("crtc=%d disable\n", crtc->base.id);
 		memset(old, 0, sizeof(*old));
 		memset(new, 0, sizeof(*new));
-		update_bus = ~0;
-		update_clk = 1;
+		update_bus = true;
+		update_clk = true;
 	}
-	trace_dpu_perf_crtc_update(crtc->base.id,
-				new->bw_ctl[DPU_POWER_HANDLE_DBUS_ID_MNOC],
-				new->bw_ctl[DPU_POWER_HANDLE_DBUS_ID_LLCC],
-				new->bw_ctl[DPU_POWER_HANDLE_DBUS_ID_EBI],
-				new->core_clk_rate, stop_req,
-				update_bus, update_clk);
-
-	for (i = 0; i < DPU_POWER_HANDLE_DBUS_ID_MAX; i++) {
-		if (update_bus & BIT(i)) {
-			ret = _dpu_core_perf_crtc_update_bus(kms, crtc, i);
-			if (ret) {
-				DPU_ERROR("crtc-%d: failed to update bw vote for bus-%d\n",
-					  crtc->base.id, i);
-				return ret;
-			}
+
+	trace_dpu_perf_crtc_update(crtc->base.id, new->bw_ctl,
+		new->core_clk_rate, stop_req, update_bus, update_clk);
+
+	if (update_bus) {
+		ret = _dpu_core_perf_crtc_update_bus(kms, crtc);
+		if (ret) {
+			DPU_ERROR("crtc-%d: failed to update bus bw vote\n",
+				  crtc->base.id);
+			return ret;
 		}
 	}
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
index fbcbe0c7527a..0fb276929dc5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
@@ -30,8 +30,8 @@
  * @core_clk_rate: core clock rate request
  */
 struct dpu_core_perf_params {
-	u64 max_per_pipe_ib[DPU_POWER_HANDLE_DBUS_ID_MAX];
-	u64 bw_ctl[DPU_POWER_HANDLE_DBUS_ID_MAX];
+	u64 max_per_pipe_ib;
+	u64 bw_ctl;
 	u64 core_clk_rate;
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index ed84cf44a222..5f022e88d9a3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1373,21 +1373,14 @@ static int dpu_crtc_debugfs_state_show(struct seq_file *s, void *v)
 {
 	struct drm_crtc *crtc = (struct drm_crtc *) s->private;
 	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
-	int i;
 
 	seq_printf(s, "client type: %d\n", dpu_crtc_get_client_type(crtc));
 	seq_printf(s, "intf_mode: %d\n", dpu_crtc_get_intf_mode(crtc));
 	seq_printf(s, "core_clk_rate: %llu\n",
 			dpu_crtc->cur_perf.core_clk_rate);
-	for (i = DPU_POWER_HANDLE_DBUS_ID_MNOC;
-			i < DPU_POWER_HANDLE_DBUS_ID_MAX; i++) {
-		seq_printf(s, "bw_ctl[%s]: %llu\n",
-				dpu_power_handle_get_dbus_name(i),
-				dpu_crtc->cur_perf.bw_ctl[i]);
-		seq_printf(s, "max_per_pipe_ib[%s]: %llu\n",
-				dpu_power_handle_get_dbus_name(i),
-				dpu_crtc->cur_perf.max_per_pipe_ib[i]);
-	}
+	seq_printf(s, "bw_ctl: %llu\n", dpu_crtc->cur_perf.bw_ctl);
+	seq_printf(s, "max_per_pipe_ib: %llu\n",
+				dpu_crtc->cur_perf.max_per_pipe_ib);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c
index fc14116789f2..d58d01544731 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c
@@ -24,20 +24,6 @@
 #include "dpu_power_handle.h"
 #include "dpu_trace.h"
 
-static const char *data_bus_name[DPU_POWER_HANDLE_DBUS_ID_MAX] = {
-	[DPU_POWER_HANDLE_DBUS_ID_MNOC] = "qcom,dpu-data-bus",
-	[DPU_POWER_HANDLE_DBUS_ID_LLCC] = "qcom,dpu-llcc-bus",
-	[DPU_POWER_HANDLE_DBUS_ID_EBI] = "qcom,dpu-ebi-bus",
-};
-
-const char *dpu_power_handle_get_dbus_name(u32 bus_id)
-{
-	if (bus_id < DPU_POWER_HANDLE_DBUS_ID_MAX)
-		return data_bus_name[bus_id];
-
-	return NULL;
-}
-
 static void dpu_power_event_trigger_locked(struct dpu_power_handle *phandle,
 		u32 event_type)
 {
@@ -66,7 +52,6 @@ struct dpu_power_client *dpu_power_client_create(
 
 	mutex_lock(&phandle->phandle_lock);
 	strlcpy(client->name, client_name, MAX_CLIENT_NAME_LEN);
-	client->usecase_ndx = VOTE_INDEX_DISABLE;
 	client->id = id;
 	client->active = true;
 	pr_debug("client %s created:%pK id :%d\n", client_name,
@@ -143,8 +128,6 @@ int dpu_power_resource_enable(struct dpu_power_handle *phandle,
 	struct dpu_power_client *pclient, bool enable)
 {
 	bool changed = false;
-	u32 max_usecase_ndx = VOTE_INDEX_DISABLE, prev_usecase_ndx;
-	struct dpu_power_client *client;
 	u32 event_type;
 
 	if (!phandle || !pclient) {
@@ -153,31 +136,19 @@ int dpu_power_resource_enable(struct dpu_power_handle *phandle,
 	}
 
 	mutex_lock(&phandle->phandle_lock);
-	if (enable)
+	if (enable) {
 		pclient->refcount++;
-	else if (pclient->refcount)
+		if (pclient->refcount == 1)
+			changed = true;
+	} else if (pclient->refcount) {
 		pclient->refcount--;
-
-	if (pclient->refcount)
-		pclient->usecase_ndx = VOTE_INDEX_LOW;
-	else
-		pclient->usecase_ndx = VOTE_INDEX_DISABLE;
-
-	list_for_each_entry(client, &phandle->power_client_clist, list) {
-		if (client->usecase_ndx < VOTE_INDEX_MAX &&
-		    client->usecase_ndx > max_usecase_ndx)
-			max_usecase_ndx = client->usecase_ndx;
-	}
-
-	if (phandle->current_usecase_ndx != max_usecase_ndx) {
-		changed = true;
-		prev_usecase_ndx = phandle->current_usecase_ndx;
-		phandle->current_usecase_ndx = max_usecase_ndx;
+		if (!pclient->refcount)
+			changed = true;
 	}
 
-	pr_debug("%pS: changed=%d current idx=%d request client %s id:%u enable:%d refcount:%d\n",
-		__builtin_return_address(0), changed, max_usecase_ndx,
-		pclient->name, pclient->id, enable, pclient->refcount);
+	pr_debug("%pS:changed=%d client %s id:%u enable:%d refcount:%d\n",
+		__builtin_return_address(0), changed, pclient->name,
+		pclient->id, enable, pclient->refcount);
 
 	if (!changed)
 		goto end;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h
index a65b7a297f21..b1a5ae4d6f4e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h
@@ -16,76 +16,28 @@
 
 #define MAX_CLIENT_NAME_LEN 128
 
-#define DPU_POWER_HANDLE_ENABLE_BUS_AB_QUOTA	0
-#define DPU_POWER_HANDLE_DISABLE_BUS_AB_QUOTA	0
-#define DPU_POWER_HANDLE_ENABLE_BUS_IB_QUOTA	1600000000
-#define DPU_POWER_HANDLE_DISABLE_BUS_IB_QUOTA	0
-
 #include "dpu_io_util.h"
 
 /* events will be triggered on power handler enable/disable */
 #define DPU_POWER_EVENT_DISABLE	BIT(0)
 #define DPU_POWER_EVENT_ENABLE	BIT(1)
 
-/**
- * mdss_bus_vote_type: register bus vote type
- * VOTE_INDEX_DISABLE: removes the client vote
- * VOTE_INDEX_LOW: keeps the lowest vote for register bus
- * VOTE_INDEX_MAX: invalid
- */
-enum mdss_bus_vote_type {
-	VOTE_INDEX_DISABLE,
-	VOTE_INDEX_LOW,
-	VOTE_INDEX_MAX,
-};
-
-/**
- * enum dpu_power_handle_data_bus_client - type of axi bus clients
- * @DPU_POWER_HANDLE_DATA_BUS_CLIENT_RT: core real-time bus client
- * @DPU_POWER_HANDLE_DATA_BUS_CLIENT_NRT: core non-real-time bus client
- * @DPU_POWER_HANDLE_DATA_BUS_CLIENT_MAX: maximum number of bus client type
- */
-enum dpu_power_handle_data_bus_client {
-	DPU_POWER_HANDLE_DATA_BUS_CLIENT_RT,
-	DPU_POWER_HANDLE_DATA_BUS_CLIENT_NRT,
-	DPU_POWER_HANDLE_DATA_BUS_CLIENT_MAX
-};
-
-/**
- * enum DPU_POWER_HANDLE_DBUS_ID - data bus identifier
- * @DPU_POWER_HANDLE_DBUS_ID_MNOC: DPU/MNOC data bus
- * @DPU_POWER_HANDLE_DBUS_ID_LLCC: MNOC/LLCC data bus
- * @DPU_POWER_HANDLE_DBUS_ID_EBI: LLCC/EBI data bus
- */
-enum DPU_POWER_HANDLE_DBUS_ID {
-	DPU_POWER_HANDLE_DBUS_ID_MNOC,
-	DPU_POWER_HANDLE_DBUS_ID_LLCC,
-	DPU_POWER_HANDLE_DBUS_ID_EBI,
-	DPU_POWER_HANDLE_DBUS_ID_MAX,
-};
-
 /**
  * struct dpu_power_client: stores the power client for dpu driver
  * @name:	name of the client
- * @usecase_ndx: current regs bus vote type
  * @refcount:	current refcount if multiple modules are using same
  *              same client for enable/disable. Power module will
  *              aggregate the refcount and vote accordingly for this
  *              client.
  * @id:		assigned during create. helps for debugging.
  * @list:	list to attach power handle master list
- * @ab:         arbitrated bandwidth for each bus client
- * @ib:         instantaneous bandwidth for each bus client
  * @active:	inidcates the state of dpu power handle
  */
 struct dpu_power_client {
 	char name[MAX_CLIENT_NAME_LEN];
-	short usecase_ndx;
 	short refcount;
 	u32 id;
 	struct list_head list;
-	u64 ab[DPU_POWER_HANDLE_DATA_BUS_CLIENT_MAX];
-	u64 ib[DPU_POWER_HANDLE_DATA_BUS_CLIENT_MAX];
 	bool active;
 };
 
@@ -112,14 +64,12 @@ struct dpu_power_event {
  * @client_clist: master list to store all clients
  * @phandle_lock: lock to synchronize the enable/disable
  * @dev: pointer to device structure
- * @usecase_ndx: current usecase index
  * @event_list: current power handle event list
  */
 struct dpu_power_handle {
 	struct list_head power_client_clist;
 	struct mutex phandle_lock;
 	struct device *dev;
-	u32 current_usecase_ndx;
 	struct list_head event_list;
 };
 
@@ -172,17 +122,6 @@ void dpu_power_client_destroy(struct dpu_power_handle *phandle,
 int dpu_power_resource_enable(struct dpu_power_handle *pdata,
 	struct dpu_power_client *pclient, bool enable);
 
-/**
- * dpu_power_data_bus_bandwidth_ctrl() - control data bus bandwidth enable
- * @phandle:  power handle containing the resources
- * @client: client information to bandwidth control
- * @enable: true to enable bandwidth for data base
- *
- * Return: none
- */
-void dpu_power_data_bus_bandwidth_ctrl(struct dpu_power_handle *phandle,
-		struct dpu_power_client *pclient, int enable);
-
 /**
  * dpu_power_handle_register_event - register a callback function for an event.
  *	Clients can register for multiple events with a single register.
@@ -207,11 +146,4 @@ struct dpu_power_event *dpu_power_handle_register_event(
 void dpu_power_handle_unregister_event(struct dpu_power_handle *phandle,
 		struct dpu_power_event *event);
 
-/**
- * dpu_power_handle_get_dbus_name - get name of given data bus identifier
- * @bus_id:	data bus identifier
- * Return:	Pointer to name string if success; NULL otherwise
- */
-const char *dpu_power_handle_get_dbus_name(u32 bus_id);
-
 #endif /* _DPU_POWER_HANDLE_H_ */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
index 0c122e173892..7c8a92d2a2f0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
@@ -167,16 +167,12 @@ TRACE_EVENT(dpu_trace_counter,
 )
 
 TRACE_EVENT(dpu_perf_crtc_update,
-	TP_PROTO(u32 crtc, u64 bw_ctl_mnoc, u64 bw_ctl_llcc,
-			u64 bw_ctl_ebi, u32 core_clk_rate,
-			bool stop_req, u32 update_bus, u32 update_clk),
-	TP_ARGS(crtc, bw_ctl_mnoc, bw_ctl_llcc, bw_ctl_ebi, core_clk_rate,
-		stop_req, update_bus, update_clk),
+	TP_PROTO(u32 crtc, u64 bw_ctl, u32 core_clk_rate,
+			bool stop_req, bool update_bus, bool update_clk),
+	TP_ARGS(crtc, bw_ctl, core_clk_rate, stop_req, update_bus, update_clk),
 	TP_STRUCT__entry(
 			__field(u32, crtc)
-			__field(u64, bw_ctl_mnoc)
-			__field(u64, bw_ctl_llcc)
-			__field(u64, bw_ctl_ebi)
+			__field(u64, bw_ctl)
 			__field(u32, core_clk_rate)
 			__field(bool, stop_req)
 			__field(u32, update_bus)
@@ -184,20 +180,16 @@ TRACE_EVENT(dpu_perf_crtc_update,
 	),
 	TP_fast_assign(
 			__entry->crtc = crtc;
-			__entry->bw_ctl_mnoc = bw_ctl_mnoc;
-			__entry->bw_ctl_llcc = bw_ctl_llcc;
-			__entry->bw_ctl_ebi = bw_ctl_ebi;
+			__entry->bw_ctl = bw_ctl;
 			__entry->core_clk_rate = core_clk_rate;
 			__entry->stop_req = stop_req;
 			__entry->update_bus = update_bus;
 			__entry->update_clk = update_clk;
 	),
 	 TP_printk(
-		"crtc=%d bw_mnoc=%llu bw_llcc=%llu bw_ebi=%llu clk_rate=%u stop_req=%d u_bus=%d u_clk=%d",
+		"crtc=%d bw_ctl=%llu clk_rate=%u stop_req=%d u_bus=%d u_clk=%d",
 			__entry->crtc,
-			__entry->bw_ctl_mnoc,
-			__entry->bw_ctl_llcc,
-			__entry->bw_ctl_ebi,
+			__entry->bw_ctl,
 			__entry->core_clk_rate,
 			__entry->stop_req,
 			__entry->update_bus,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

