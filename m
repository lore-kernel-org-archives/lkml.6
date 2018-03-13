Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsMFN/VirQsOrDohUtUj/ltRWm37tsmeQvIh4MCBrl1CR4VkJYjTg+eQxbieVLVSRvz1pFs
ARC-Seal: i=1; a=rsa-sha256; t=1520955496; cv=none;
        d=google.com; s=arc-20160816;
        b=H90OS7vdUUnIUr5WgoH/AW/tOkmfLnnLFGOc49GIBoT9K/cPcDSqaC9gOC0fzs1e1r
         4DCK8zj4HtG+snkb53tlIXDZyago8YllijRCzC9BwD7b0SDh6ILWTTN4JF6PzF09Ixms
         S8YxXYdCzcLhmqsXSLs89ceibjp3tgKNk6BFHiY4cVHSLpBFRq3gAM/K1bM4FATuhiMM
         5p3CVPMc7sjpteIc/rmkmRW7U6oFM9i7D3mLmEYxE7F6Oz1p7TU5HwK34sE04YICpm2c
         bXWmKSpEPlup6N8brUcqmtQCXTWeKaZUXLzpMXxl7brUOIh/+gjVG+TcXzyCEHYuyr5N
         Qm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=R92wJAlrnbZAzKTRbYNjfKuMlEEC5kibjPNLPpCos5c=;
        b=tBVSs7mYLgFEnUMQ2mEDm4q6gW/kEL1BaT3safOnoxHRgNKMbCxEhpOQlt19a015dn
         jCRAmDG+eA6XzHN5hg9zNM6F8mFoC1qgkQEHBZwLoZG6Tt4rN5rROjYYfu0C8ew9XhXw
         0dfRjoL+ckbenn+SttJ88zoNoVpSlLwegThz4TEidLgSZviavzmUWyUODAup2sKeNfjX
         uBbNNmjPj6ILmbiu2gGPn+zGUo6Qs4ADCjHT93uPx8SbMaglRlQQROsEhE1IJ2XHp+2o
         lE/j6+1ftYA0ztzQkGeB9npxhAtjntYfhn9yARK3CyC0ktCLb2yLt5/ACPaAbwlzSmx2
         nOig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ismo Toijala <ismo.toijala@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dave Airlie <airlied@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.14 064/140] drm/radeon: Fix deadlock on runtime suspend
Date: Tue, 13 Mar 2018 16:24:27 +0100
Message-Id: <20180313152502.512398916@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836810214398214?=
X-GMAIL-MSGID: =?utf-8?q?1594837430197562929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
