Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447179-1520954911-2-12149968286373965664
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520954909; b=JMsail/ZT0SlYw6xOn1wqIWFKe1VfIYNRvsqxEAQbI6eBET
    RUl/4/47SygW3ZbY1bo+z43GTnoMxEeve2BaNdWavbF8PjEy2CLNaSPre5an7Wwz
    x4h33zPGeMw9K9QvL05/Cs37N3i2jpoLShjcBRfmY2mZtIc/TRgEscMbtcJclJrd
    YSFYAWMlSMdi0Hh/9rvufT0x56ws1OaIWw76AAL27EvxGjaTxOMwx+zNEoJpoB+S
    vgZs9JjFzfvUZ29cfqg8VoxW4UZ6IfwrmcYokMraIF1fPSeAtfOxMJzL/LeiDtPa
    N8+RDmpcVE1qDfF1b3Isqnq+tA5atSUYkpObcew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520954909; bh=i+BxNWZjGlJk30scsHNAgLyALv
    N5B29CPlgxexOGwbQ=; b=oitX6o7Ga+H24B+guubPlddlMxIOxksVEhTA3a2lDh
    wdoolUkzp1KjBAgCw8k+M/UaGmbrgNMQpOOdgvCSjyciBAjXQa8yUVcMeCe1mmm6
    X3Z5ntuiSCyRRvFd2MHtT1FDOKj1ghJI7+KvZfgx3Vnb6qxsF1PyG24KUvBwgnlZ
    Dn8+wTStHyrmAuMihTrmlvjKPVJtRWlhxX9Ov3GHZO5L+EVl2m82ZKhhF/b5ZFVD
    BAKjP4TrdeJqEVjATaNkCmlANCMPGsIYtMgafZ2ASeP73+2x1vSau73jSLcgAKvU
    Km59GGi2s4+5x8nTJC/z0O5qoVj0/swEqpJyW9+L6TjA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932736AbeCMP20 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:28:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57968 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752198AbeCMP2Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:28:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ismo Toijala <ismo.toijala@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.15 023/146] drm/radeon: Fix deadlock on runtime suspend
Date: Tue, 13 Mar 2018 16:23:10 +0100
Message-Id: <20180313152322.259982748@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 15734feff2bdac24aa3266c437cffa42851990e3 upstream.

radeon's ->runtime_suspend hook calls drm_kms_helper_poll_disable(),
which waits for the output poll worker to finish if it's running.

The output poll worker meanwhile calls pm_runtime_get_sync() in
radeon's ->detect hooks, which waits for the ongoing suspend to finish,
causing a deadlock.

Fix by not acquiring a runtime PM ref if the ->detect hooks are called
in the output poll worker's context.  This is safe because the poll
worker is only enabled while runtime active and we know that
->runtime_suspend waits for it to finish.

Stack trace for posterity:

  INFO: task kworker/0:3:31847 blocked for more than 120 seconds
  Workqueue: events output_poll_execute [drm_kms_helper]
  Call Trace:
   schedule+0x3c/0x90
   rpm_resume+0x1e2/0x690
   __pm_runtime_resume+0x3f/0x60
   radeon_lvds_detect+0x39/0xf0 [radeon]
   output_poll_execute+0xda/0x1e0 [drm_kms_helper]
   process_one_work+0x14b/0x440
   worker_thread+0x48/0x4a0

  INFO: task kworker/2:0:10493 blocked for more than 120 seconds.
  Workqueue: pm pm_runtime_work
  Call Trace:
   schedule+0x3c/0x90
   schedule_timeout+0x1b3/0x240
   wait_for_common+0xc2/0x180
   wait_for_completion+0x1d/0x20
   flush_work+0xfc/0x1a0
   __cancel_work_timer+0xa5/0x1d0
   cancel_delayed_work_sync+0x13/0x20
   drm_kms_helper_poll_disable+0x1f/0x30 [drm_kms_helper]
   radeon_pmops_runtime_suspend+0x3d/0xa0 [radeon]
   pci_pm_runtime_suspend+0x61/0x1a0
   vga_switcheroo_runtime_suspend+0x21/0x70
   __rpm_callback+0x32/0x70
   rpm_callback+0x24/0x80
   rpm_suspend+0x12b/0x640
   pm_runtime_work+0x6f/0xb0
   process_one_work+0x14b/0x440
   worker_thread+0x48/0x4a0

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=94147
Fixes: 10ebc0bc0934 ("drm/radeon: add runtime PM support (v2)")
Cc: stable@vger.kernel.org # v3.13+: 27d4ee03078a: workqueue: Allow retrieval of current task's work struct
Cc: stable@vger.kernel.org # v3.13+: 25c058ccaf2e: drm: Allow determining if current task is output poll worker
Cc: Ismo Toijala <ismo.toijala@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Link: https://patchwork.freedesktop.org/patch/msgid/64ea02c44f91dda19bc563902b97bbc699040392.1518338789.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_connectors.c |   74 +++++++++++++++++++----------
 1 file changed, 49 insertions(+), 25 deletions(-)

--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -900,9 +900,11 @@ radeon_lvds_detect(struct drm_connector
 	enum drm_connector_status ret = connector_status_disconnected;
 	int r;
 
-	r = pm_runtime_get_sync(connector->dev->dev);
-	if (r < 0)
-		return connector_status_disconnected;
+	if (!drm_kms_helper_is_poll_worker()) {
+		r = pm_runtime_get_sync(connector->dev->dev);
+		if (r < 0)
+			return connector_status_disconnected;
+	}
 
 	if (encoder) {
 		struct radeon_encoder *radeon_encoder = to_radeon_encoder(encoder);
@@ -925,8 +927,12 @@ radeon_lvds_detect(struct drm_connector
 	/* check acpi lid status ??? */
 
 	radeon_connector_update_scratch_regs(connector, ret);
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
+
 	return ret;
 }
 
@@ -1040,9 +1046,11 @@ radeon_vga_detect(struct drm_connector *
 	enum drm_connector_status ret = connector_status_disconnected;
 	int r;
 
-	r = pm_runtime_get_sync(connector->dev->dev);
-	if (r < 0)
-		return connector_status_disconnected;
+	if (!drm_kms_helper_is_poll_worker()) {
+		r = pm_runtime_get_sync(connector->dev->dev);
+		if (r < 0)
+			return connector_status_disconnected;
+	}
 
 	encoder = radeon_best_single_encoder(connector);
 	if (!encoder)
@@ -1109,8 +1117,10 @@ radeon_vga_detect(struct drm_connector *
 	radeon_connector_update_scratch_regs(connector, ret);
 
 out:
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return ret;
 }
@@ -1174,9 +1184,11 @@ radeon_tv_detect(struct drm_connector *c
 	if (!radeon_connector->dac_load_detect)
 		return ret;
 
-	r = pm_runtime_get_sync(connector->dev->dev);
-	if (r < 0)
-		return connector_status_disconnected;
+	if (!drm_kms_helper_is_poll_worker()) {
+		r = pm_runtime_get_sync(connector->dev->dev);
+		if (r < 0)
+			return connector_status_disconnected;
+	}
 
 	encoder = radeon_best_single_encoder(connector);
 	if (!encoder)
@@ -1188,8 +1200,12 @@ radeon_tv_detect(struct drm_connector *c
 	if (ret == connector_status_connected)
 		ret = radeon_connector_analog_encoder_conflict_solve(connector, encoder, ret, false);
 	radeon_connector_update_scratch_regs(connector, ret);
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
+
 	return ret;
 }
 
@@ -1252,9 +1268,11 @@ radeon_dvi_detect(struct drm_connector *
 	enum drm_connector_status ret = connector_status_disconnected;
 	bool dret = false, broken_edid = false;
 
-	r = pm_runtime_get_sync(connector->dev->dev);
-	if (r < 0)
-		return connector_status_disconnected;
+	if (!drm_kms_helper_is_poll_worker()) {
+		r = pm_runtime_get_sync(connector->dev->dev);
+		if (r < 0)
+			return connector_status_disconnected;
+	}
 
 	if (radeon_connector->detected_hpd_without_ddc) {
 		force = true;
@@ -1437,8 +1455,10 @@ out:
 	}
 
 exit:
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return ret;
 }
@@ -1689,9 +1709,11 @@ radeon_dp_detect(struct drm_connector *c
 	if (radeon_dig_connector->is_mst)
 		return connector_status_disconnected;
 
-	r = pm_runtime_get_sync(connector->dev->dev);
-	if (r < 0)
-		return connector_status_disconnected;
+	if (!drm_kms_helper_is_poll_worker()) {
+		r = pm_runtime_get_sync(connector->dev->dev);
+		if (r < 0)
+			return connector_status_disconnected;
+	}
 
 	if (!force && radeon_check_hpd_status_unchanged(connector)) {
 		ret = connector->status;
@@ -1778,8 +1800,10 @@ radeon_dp_detect(struct drm_connector *c
 	}
 
 out:
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return ret;
 }
