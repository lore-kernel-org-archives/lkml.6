Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LfNoD3hMGVu8YQAAmS7hNA
	; Thu, 07 Jun 2018 15:26:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1DCF86089E; Thu,  7 Jun 2018 15:26:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 69C65601B4;
	Thu,  7 Jun 2018 15:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69C65601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964862AbeFGP0g (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:26:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41135 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932919AbeFGO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:57:49 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvba-0005Zi-J3; Thu, 07 Jun 2018 15:09:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb8-000359-FR; Thu, 07 Jun 2018 15:09:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Lukas Wunner" <lukas@wunner.de>,
        "Lyude Paul" <lyude@redhat.com>,
        "Dave Airlie" <airlied@redhat.com>,
        "Ben Skeggs" <bskeggs@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.289900009@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 256/410] drm/nouveau: Fix deadlock on runtime suspend
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit d61a5c1063515e855bedb1b81e20e50b0ac3541e upstream.

nouveau's ->runtime_suspend hook calls drm_kms_helper_poll_disable(),
which waits for the output poll worker to finish if it's running.

The output poll worker meanwhile calls pm_runtime_get_sync() in
nouveau_connector_detect() which waits for the ongoing suspend to finish,
causing a deadlock.

Fix by not acquiring a runtime PM ref if nouveau_connector_detect() is
called in the output poll worker's context.  This is safe because
the poll worker is only enabled while runtime active and we know that
->runtime_suspend waits for it to finish.

Other contexts calling nouveau_connector_detect() do require a runtime
PM ref, these comprise:

  status_store() drm sysfs interface
  ->fill_modes drm callback
  drm_fb_helper_probe_connector_modes()
  drm_mode_getconnector()
  nouveau_connector_hotplug()
  nouveau_display_hpd_work()
  nv17_tv_set_property()

Stack trace for posterity:

  INFO: task kworker/0:1:58 blocked for more than 120 seconds.
  Workqueue: events output_poll_execute [drm_kms_helper]
  Call Trace:
   schedule+0x28/0x80
   rpm_resume+0x107/0x6e0
   __pm_runtime_resume+0x47/0x70
   nouveau_connector_detect+0x7e/0x4a0 [nouveau]
   nouveau_connector_detect_lvds+0x132/0x180 [nouveau]
   drm_helper_probe_detect_ctx+0x85/0xd0 [drm_kms_helper]
   output_poll_execute+0x11e/0x1c0 [drm_kms_helper]
   process_one_work+0x184/0x380
   worker_thread+0x2e/0x390

  INFO: task kworker/0:2:252 blocked for more than 120 seconds.
  Workqueue: pm pm_runtime_work
  Call Trace:
   schedule+0x28/0x80
   schedule_timeout+0x1e3/0x370
   wait_for_completion+0x123/0x190
   flush_work+0x142/0x1c0
   nouveau_pmops_runtime_suspend+0x7e/0xd0 [nouveau]
   pci_pm_runtime_suspend+0x5c/0x180
   vga_switcheroo_runtime_suspend+0x1e/0xa0
   __rpm_callback+0xc1/0x200
   rpm_callback+0x1f/0x70
   rpm_suspend+0x13c/0x640
   pm_runtime_work+0x6e/0x90
   process_one_work+0x184/0x380
   worker_thread+0x2e/0x390

Bugzilla: https://bugs.archlinux.org/task/53497
Bugzilla: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=870523
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=70388#c33
Fixes: 5addcf0a5f0f ("nouveau: add runtime PM support (v0.9)")
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Link: https://patchwork.freedesktop.org/patch/msgid/b7d2cbb609a80f59ccabfdf479b9d5907c603ea1.1518338789.git.lukas@wunner.de
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -256,9 +256,15 @@ nouveau_connector_detect(struct drm_conn
 		nv_connector->edid = NULL;
 	}
 
-	ret = pm_runtime_get_sync(connector->dev->dev);
-	if (ret < 0 && ret != -EACCES)
-		return conn_status;
+	/* Outputs are only polled while runtime active, so acquiring a
+	 * runtime PM ref here is unnecessary (and would deadlock upon
+	 * runtime suspend because it waits for polling to finish).
+	 */
+	if (!drm_kms_helper_is_poll_worker()) {
+		ret = pm_runtime_get_sync(connector->dev->dev);
+		if (ret < 0 && ret != -EACCES)
+			return conn_status;
+	}
 
 	nv_encoder = nouveau_connector_ddc_detect(connector);
 	if (nv_encoder && (i2c = nv_encoder->i2c) != NULL) {
@@ -326,8 +332,10 @@ detect_analog:
 
  out:
 
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return conn_status;
 }
