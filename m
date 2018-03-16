Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521221671-2-16589964579577909773
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221670; b=Uzoy60xOoJ5EH6n4/7rck2zPOX2KYf0fbKnPWM3/+YENUcX
    hpVEgwL3869AVlqzsd5/2h59ds208baQpkmQl54f+qu7fYxzBySmnjD0kEyaJ/wh
    B7gPi2paPQS/gI+xKx78ajOMnE5xT70rcoIOOZBoz1BXXj+eLBKi1gMHamX1zIln
    a3cWnMWrzUyx9Wg47UPCHk5fwNcdmYzqthHbs8OQdfPcmC6n60lZmlF0qdJ/w41c
    yekqurHnGsdkCFXzcyDH/P5lpCwv3gQXrszNknZh6S2Sv/cjsQsTwzVIHbtxsqi1
    u+Fo/izZw7VH7wtDcahYJZiyFnv+snNVl4azEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221670; bh=0YdSRuqgC6OTplfVSHGgPFbrPL
    GueWcNwiqkPJAHyRI=; b=qs4UrfouhqFUzoX5AUEQoU85P5dZStptJXoP1sxRAT
    7hxGKXuIaqc55DwOme6MKvUq/UXJb0dF8qdoEo11xfMhzatdmJOLnd070vNxdzkE
    6eAy9ptUCGRW273slHx2dMM1RcN48ghXh/41bE6uziToR9twWCAjoTcquLmescIJ
    q0e3FB9yl/MMi/6N6bNf7kRPSXX24fAFH4EhSj0Vi0cjwmDCKRuJyp3g5Ybp7jTp
    UsB+xmtukvMdaayjf4xUNgM9wvrL5b7G1kV08l6gAVqGb7l3N16B8M2rLYtL/yiw
    N84qPCJTOl0prs1a+OfbNilO12/ZtVZqLE8MaP4JsPdA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S1751014AbeCPReN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 13:34:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34092 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753920AbeCPP1I (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:27:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ismo Toijala <ismo.toijala@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.4 08/63] drm/radeon: Fix deadlock on runtime suspend
Date: Fri, 16 Mar 2018 16:22:40 +0100
Message-Id: <20180316152301.007767775@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -891,9 +891,11 @@ radeon_lvds_detect(struct drm_connector
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
@@ -916,8 +918,12 @@ radeon_lvds_detect(struct drm_connector
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
 
@@ -1020,9 +1026,11 @@ radeon_vga_detect(struct drm_connector *
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
@@ -1089,8 +1097,10 @@ radeon_vga_detect(struct drm_connector *
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
@@ -1153,9 +1163,11 @@ radeon_tv_detect(struct drm_connector *c
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
@@ -1167,8 +1179,12 @@ radeon_tv_detect(struct drm_connector *c
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
 
@@ -1230,9 +1246,11 @@ radeon_dvi_detect(struct drm_connector *
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
@@ -1415,8 +1433,10 @@ out:
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
@@ -1666,9 +1686,11 @@ radeon_dp_detect(struct drm_connector *c
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
@@ -1755,8 +1777,10 @@ radeon_dp_detect(struct drm_connector *c
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
