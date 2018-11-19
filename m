Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02F1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93FB21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRONBX5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93FB21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390600AbeKTDQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:16:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389669AbeKTDQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:16:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D1B0208E3;
        Mon, 19 Nov 2018 16:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646349;
        bh=OxlLy00cwR8yO0qkR1EwCOwpsBNlXD+tLHgd7IUxsBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PRONBX5YOo++lY2DA8uE7sFmWjjq0HZwLSEfJqBlWiqFO0rnvVdnAI+GPXbZQzRmO
         BkRBE/AQ+hgJNqJwOZZn+T8UIB4gI2H4/JR8wKCRnPADPndLAKOdocp0VrA3KhBZ/I
         nAGep1Z4PgJGZa4RsqVEXSVgECa8cnY83l5pVYbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.14 114/124] drm/i915: Skip vcpi allocation for MSTB ports that are gone
Date:   Mon, 19 Nov 2018 17:29:28 +0100
Message-Id: <20181119162633.113811886@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit c02ba4ef16eefe663fdefcccaa57fad32d5481bf upstream.

Since we need to be able to allow DPMS on->off prop changes after an MST
port has disappeared from the system, we need to be able to make sure we
can compute a config for the resulting atomic commit. Currently this is
impossible when the port has disappeared, since the VCPI slot searching
we try to do in intel_dp_mst_compute_config() will fail with -EINVAL.

Since the only commits we want to allow on no-longer-present MST ports
are ones that shut off display hardware, we already know that no VCPI
allocations are needed. So, hardcode the VCPI slot count to 0 when
intel_dp_mst_compute_config() is called on an MST port that's gone.

Changes since V4:
- Don't use mst_port_gone at all, just check whether or not the drm
  connector is registered - Daniel Vetter

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/20181008232437.5571-5-lyude@redhat.com
(cherry picked from commit f67207d78ceaf98b7531bc22df6f21328559c8d4)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_dp_mst.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -37,11 +37,11 @@ static bool intel_dp_mst_compute_config(
 	struct intel_dp_mst_encoder *intel_mst = enc_to_mst(&encoder->base);
 	struct intel_digital_port *intel_dig_port = intel_mst->primary;
 	struct intel_dp *intel_dp = &intel_dig_port->dp;
-	struct intel_connector *connector =
-		to_intel_connector(conn_state->connector);
+	struct drm_connector *connector = conn_state->connector;
+	void *port = to_intel_connector(connector)->port;
 	struct drm_atomic_state *state = pipe_config->base.state;
 	int bpp;
-	int lane_count, slots;
+	int lane_count, slots = 0;
 	const struct drm_display_mode *adjusted_mode = &pipe_config->base.adjusted_mode;
 	int mst_pbn;
 	bool reduce_m_n = drm_dp_has_quirk(&intel_dp->desc,
@@ -66,17 +66,23 @@ static bool intel_dp_mst_compute_config(
 
 	pipe_config->port_clock = intel_dp_max_link_rate(intel_dp);
 
-	if (drm_dp_mst_port_has_audio(&intel_dp->mst_mgr, connector->port))
+	if (drm_dp_mst_port_has_audio(&intel_dp->mst_mgr, port))
 		pipe_config->has_audio = true;
 
 	mst_pbn = drm_dp_calc_pbn_mode(adjusted_mode->crtc_clock, bpp);
 	pipe_config->pbn = mst_pbn;
 
-	slots = drm_dp_atomic_find_vcpi_slots(state, &intel_dp->mst_mgr,
-					      connector->port, mst_pbn);
-	if (slots < 0) {
-		DRM_DEBUG_KMS("failed finding vcpi slots:%d\n", slots);
-		return false;
+	/* Zombie connectors can't have VCPI slots */
+	if (READ_ONCE(connector->registered)) {
+		slots = drm_dp_atomic_find_vcpi_slots(state,
+						      &intel_dp->mst_mgr,
+						      port,
+						      mst_pbn);
+		if (slots < 0) {
+			DRM_DEBUG_KMS("failed finding vcpi slots:%d\n",
+				      slots);
+			return false;
+		}
 	}
 
 	intel_link_compute_m_n(bpp, lane_count,


