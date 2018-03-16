Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvXapTzIYzGm7pnsn8pOfupypr6VOx/o7/Ggtz+YxWxTXw5byf0u+so0xliAS00AtOkGtI9
ARC-Seal: i=1; a=rsa-sha256; t=1521214280; cv=none;
        d=google.com; s=arc-20160816;
        b=LRZX9QS9VDCMuKAd49hdxi1KgHmATSysxIIFtQcTbBs/XdJn/coijWkLjD8TI6tAZP
         Jibr/RgjPymcK5k6gp28ezift8pn6RgVIpkzD7rno3TTKutTjC1uIdFUMXc5Dp7c15vD
         e77d8M/1pvDM+wzqlegdbBmyeBOpcRJCJ4v/gHWWplGYNq51mJik814F+hqDZKZ8yauq
         chBYH7L91/+Fc3wbqgYQefGXZ9cRLWY5HqwFffaUueJU9e/AwAAigx/bvWjbcWBRe4tv
         8w4WcGRLP2MpG65ONcxJRBo/EwWNeSrTE1VZ7sm9M8l6bsy7d8nAyjH7/WFPb9NV9oBJ
         Y2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=estYgUq/Roa9NGGeO9yQf8r2tAGROpzeaEn6EmdxT+0=;
        b=tDPHrjH/j/0gmW6VCfGF8wQFMFf5OJkUN4EPrJ/koJ/NBWl5IMnvmbUNc6u/QTAKHg
         LvTV+DzuGwoa+ZOrc54kYfSd0RHgpcMmfB9vveWYVbvYlZbbpuipJqZzXJ2gdmL99rvA
         G1aRBxv7kgFi9itsZH8uER2t7p3jsrc/z2/dU4DdYeDgW4qUvqZgPtAYBjUHffYp0Y2i
         XLsTWN4921hWpFjY3LNx+IvQLva0kFoMbWiCr0fBb2SOOQ1debWzKbdhuaw+cW7m/7Wc
         JGm5K/B0D5WJqZXZmRGZ/bQlWgpPBPvqVMtJQi+5qE3mV2PVu5W2j8JmUK2OlMCnpD0I
         jJmw==
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
Subject: [PATCH 4.9 11/86] drm/amdgpu: Fix deadlock on runtime suspend
Date: Fri, 16 Mar 2018 16:22:34 +0100
Message-Id: <20180316152318.034552608@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108614541590658?=
X-GMAIL-MSGID: =?utf-8?q?1595108784738161294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
