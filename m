Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtjyW+9A9hx6uqAh0rryBhaq6f62VPvDluFF/EsHPG0m0U51KGswJbw5MJOwHNocyQV9HzP
ARC-Seal: i=1; a=rsa-sha256; t=1520954908; cv=none;
        d=google.com; s=arc-20160816;
        b=ouPmrG99J3j8YyKA2j0WD9IzZix+K1j4yk+0zi5uuIRPJKJOjVMFPmkoTCGT7hMSad
         /yN5ZprjLpSohYjq+S95uUV76Q8TBN6qmV70PUwGuAibzmI8CjLZGWDSJ4MKRkX5RVtx
         CZtNr0a7y5V+WQJ+qtNyboUuzX7N6BNSoG73j3cR8OYfDdVSStixLGfgZ+mLzNyRH8l8
         xjdHMalqz/MthDFkDGuw2D9IC/grtM6MeBgxmt7p2S8tUS1pBEV5TRPPnCd/YKidKGB2
         xuYvQ45pU5Quy4yxSpKj5jochcZ0eL0KZWAAOYDa2n7TuxzoYlaQ9+glWCfAQFMN/Z/e
         DtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wH01SY+iYBQBB3BXffoXDJ8LR7Y6GNixB8zs0cNQIpM=;
        b=rObmJGKBbyoQGazYa04pngBE62NOT2rfmASdME80fkHLLDr2dYyTq09lIT6Y/5My+V
         O0zC7gXZ2QJZ6pt8Hw3qHw+bBuFF7HFpK+QPFSQfBb7sRPBi73Yxuh1mOS575J+J+SPJ
         rhgc2zZWf4FG2aVrhaSw0BkXTAttsZeizq34ODHarJSQyADko7Ci+EWtC+ivBcPVXjBo
         4qu1sbfqK0WPpqhsXpHIZnDYzoaS+qyzjomod5mS1ZUBVf0isD6PnTNk+3+lK3yNYRIQ
         TpBPGJSvutE5KJ5JaEq3LYwEqGnbTxwaE9hQobp5nwn7z6BNE6WdYMFjDedoTA4H7Omu
         ml7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Mike Lothian <mike@fireburn.co.uk>,
	Lyude Paul <lyude@redhat.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.15 024/146] drm/amdgpu: Fix deadlock on runtime suspend
Date: Tue, 13 Mar 2018 16:23:11 +0100
Message-Id: <20180313152322.323324350@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836813269869627?=
X-GMAIL-MSGID: =?utf-8?q?1594836813269869627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -737,9 +737,11 @@ amdgpu_connector_lvds_detect(struct drm_
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
@@ -758,8 +760,12 @@ amdgpu_connector_lvds_detect(struct drm_
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
 
@@ -869,9 +875,11 @@ amdgpu_connector_vga_detect(struct drm_c
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
@@ -925,8 +933,10 @@ amdgpu_connector_vga_detect(struct drm_c
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
@@ -989,9 +999,11 @@ amdgpu_connector_dvi_detect(struct drm_c
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
@@ -1116,8 +1128,10 @@ out:
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
@@ -1360,9 +1374,11 @@ amdgpu_connector_dp_detect(struct drm_co
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
@@ -1430,8 +1446,10 @@ amdgpu_connector_dp_detect(struct drm_co
 
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
