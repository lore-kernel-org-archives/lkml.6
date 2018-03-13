Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463848-1520955488-2-18418809730857405355
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
    t=1520955487; b=BX3/VVs4LOXkaYEGuKqUSe0uEJIR9p+pWzH9eE3eD1xMU4V
    gSs6zdcieYZeBQ2dvGEHs9ZuB6GTddrn1r4n9IPjEyS35it/hjNnC4hyqPhxJPau
    ACCkHzvxR9WHgK6Xp+d5Fx+8ifQDdud56eXvP6A60D/6LNDP9MQ5R36uYE85Kjze
    X6rRPxHCPNYj4kJkui90HahszjEjEWaP8Iia2X5McQSkTcp58K5yaj+6l28LNPet
    KMG8n9zwd0K7v8VbktFSUdqhjp59/D+IDFDyqZjW5i+G3tuCRz3/IXj4viz51FW2
    XEkxiaWbnyQ0sN5WKvkX3b2WBIALz15lcsPKfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955487; bh=rjXzLVzHA2nj3DLe53tpeMMa+p
    lB9MOzt+oQkiIK3Fg=; b=JZoscJcAdmgwddPDQUOJwBdFcy+1Hj7Urto2igk+Qb
    zIqfuiSIrUinIP7HJdZqisUlKdzMWqb2DWKUvz7DZkMVyCwzkvAnCr/XWsooEeKk
    gEIqIJQf9Vg6zsC10YbgsDcoXmO9nqgQ/WpLKaP4w9i5sjuyHTUjQ2j+riFYu0WO
    c1Hf+aluy+Bbq47XyyaEWvHXI0uYEEz/awUuAcwYtwpefVL2ULNG/3l3HJziYx3G
    h3d9rk/RyMOCr/WWK86kScmU6qy8wPCFK7w97IfsviAgjkW4cZyS5wr5wneUmZfL
    Gc8dHEjCQpEmSxFPW8B1EKB5DFBIJmvZ5fbFXFSJtHPw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S934504AbeCMPiE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:38:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934468AbeCMPiD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:38:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.14 065/140] drm/amdgpu: Fix deadlock on runtime suspend
Date: Tue, 13 Mar 2018 16:24:28 +0100
Message-Id: <20180313152502.572706095@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit aa0aad57909eb321746325951d66af88a83bc956 upstream.

amdgpu's ->runtime_suspend hook calls drm_kms_helper_poll_disable(),
which waits for the output poll worker to finish if it's running.

The output poll worker meanwhile calls pm_runtime_get_sync() in
amdgpu's ->detect hooks, which waits for the ongoing suspend to finish,
causing a deadlock.

Fix by not acquiring a runtime PM ref if the ->detect hooks are called
in the output poll worker's context.  This is safe because the poll
worker is only enabled while runtime active and we know that
->runtime_suspend waits for it to finish.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Cc: stable@vger.kernel.org # v4.2+: 27d4ee03078a: workqueue: Allow retrieval of current task's work struct
Cc: stable@vger.kernel.org # v4.2+: 25c058ccaf2e: drm: Allow determining if current task is output poll worker
Cc: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Mike Lothian <mike@fireburn.co.uk>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Link: https://patchwork.freedesktop.org/patch/msgid/4c9bf72aacae1eef062bd134cd112e0770a7f121.1518338789.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |   58 ++++++++++++++++---------
 1 file changed, 38 insertions(+), 20 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -739,9 +739,11 @@ amdgpu_connector_lvds_detect(struct drm_
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
 		struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
@@ -760,8 +762,12 @@ amdgpu_connector_lvds_detect(struct drm_
 	/* check acpi lid status ??? */
 
 	amdgpu_connector_update_scratch_regs(connector, ret);
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
 
@@ -871,9 +877,11 @@ amdgpu_connector_vga_detect(struct drm_c
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
 
 	encoder = amdgpu_connector_best_single_encoder(connector);
 	if (!encoder)
@@ -927,8 +935,10 @@ amdgpu_connector_vga_detect(struct drm_c
 	amdgpu_connector_update_scratch_regs(connector, ret);
 
 out:
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return ret;
 }
@@ -991,9 +1001,11 @@ amdgpu_connector_dvi_detect(struct drm_c
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
 
 	if (!force && amdgpu_connector_check_hpd_status_unchanged(connector)) {
 		ret = connector->status;
@@ -1118,8 +1130,10 @@ out:
 	amdgpu_connector_update_scratch_regs(connector, ret);
 
 exit:
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return ret;
 }
@@ -1362,9 +1376,11 @@ amdgpu_connector_dp_detect(struct drm_co
 	struct drm_encoder *encoder = amdgpu_connector_best_single_encoder(connector);
 	int r;
 
-	r = pm_runtime_get_sync(connector->dev->dev);
-	if (r < 0)
-		return connector_status_disconnected;
+	if (!drm_kms_helper_is_poll_worker()) {
+		r = pm_runtime_get_sync(connector->dev->dev);
+		if (r < 0)
+			return connector_status_disconnected;
+	}
 
 	if (!force && amdgpu_connector_check_hpd_status_unchanged(connector)) {
 		ret = connector->status;
@@ -1432,8 +1448,10 @@ amdgpu_connector_dp_detect(struct drm_co
 
 	amdgpu_connector_update_scratch_regs(connector, ret);
 out:
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return ret;
 }
