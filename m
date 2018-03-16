Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsxsyKdIYPMzUe8eIh+QaJ9TgyWSC6D9dBMWdHetIFNmk6EYxYEvm3Z4aMDYqxPTOu2PkhJ
ARC-Seal: i=1; a=rsa-sha256; t=1521214117; cv=none;
        d=google.com; s=arc-20160816;
        b=bZ7QRX2uK9fS9Lp1ifueJ1shFy6Rvpz/wbqo7eE2jDoA0G7cwH8hc8cTKIH8qYF4aO
         81SKR2j+hB9CdDuWRjL8Lf00aQyoi9Wp2i8pqJgRdxFLCVI1MhBQBdEq9bMKfHGof3sT
         dnhRh09Z8XzY0AsZMgFHpe3Pt+14R6ZMa2Bc8UB7IuDowUf9sRYoC8FbZHn4WyeGa5ST
         oU44A/6Px6L2W5Ye3J34d+rUg0jG4bBgmhXXxHCQ9znxLUDiSWuHWMQCesmYa329NQNF
         PRPoa0KpLcJLwQNN4bqKn+/Epg4jr6lZAELwxdI8ym/9ooV6sWPSl21bFR9krx7YXYy9
         3Cpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=I+k/01ryMVhD99kKBnlJpkU3m28xNSTYkfZ8us25ZTs=;
        b=pYYT67PK8BVq0neFHZvoKl4ZvfxjexIoYn6zsTgOm0F28/AUGlMk7u5T7h2Qma8nvE
         1V+xs/Ux9TxntLfIUwl4da8TJMSeB/wdTAFLac7RanhVgl4HwcCIhZzxvW1QqWxSaH4s
         hg6sRHcC8DpxkdVIdJM82NhK2fPZOSnWUzCl1FqMbMAqYMXxpjutYgtSJC3E6MEsP0d7
         KhdrVtFEYzE1MexjIOxdQ3PD1XX7dUqZmy1r7917OxweT8MKe4gNCjPDSDodwSwtxIZG
         QxyeWNYAlempEXKLqgwd823zJag/YEatxiQYOg2If9Pl0OgcaNXheNmvmYFOMmK+ZXW+
         q4rQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Mike Lothian <mike@fireburn.co.uk>,
	Lyude Paul <lyude@redhat.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.4 09/63] drm/amdgpu: Fix deadlock on runtime suspend
Date: Fri, 16 Mar 2018 16:22:41 +0100
Message-Id: <20180316152301.110599992@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108614541590658?=
X-GMAIL-MSGID: =?utf-8?q?1595108614541590658?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -862,9 +868,11 @@ amdgpu_connector_vga_detect(struct drm_c
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
@@ -918,8 +926,10 @@ amdgpu_connector_vga_detect(struct drm_c
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
@@ -981,9 +991,11 @@ amdgpu_connector_dvi_detect(struct drm_c
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
@@ -1108,8 +1120,10 @@ out:
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
@@ -1351,9 +1365,11 @@ amdgpu_connector_dp_detect(struct drm_co
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
@@ -1421,8 +1437,10 @@ amdgpu_connector_dp_detect(struct drm_co
 
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
