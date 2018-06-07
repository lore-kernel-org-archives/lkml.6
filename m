Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wy4AHt9HGVsbQQAAmS7hNA
	; Thu, 07 Jun 2018 14:59:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 00BCD607E7; Thu,  7 Jun 2018 14:59:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6BA88606DD;
	Thu,  7 Jun 2018 14:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BA88606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935626AbeFGO7J (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:59:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41244 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935607AbeFGO7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:59:04 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvba-0005Zn-IA; Thu, 07 Jun 2018 15:09:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb8-000354-E4; Thu, 07 Jun 2018 15:09:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Lyude Paul" <lyude@redhat.com>, "Lukas Wunner" <lukas@wunner.de>,
        "Dave Airlie" <airlied@redhat.com>,
        "Ben Skeggs" <bskeggs@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.635888548@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 255/410] drm: Allow determining if current task is
 output poll worker
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

commit 25c058ccaf2ebbc3e250ec1e199e161f91fe27d4 upstream.

Introduce a helper to determine if the current task is an output poll
worker.

This allows us to fix a long-standing deadlock in several DRM drivers
wherein the ->runtime_suspend callback waits for the output poll worker
to finish and the worker in turn calls a ->detect callback which waits
for runtime suspend to finish.  The ->detect callback is invoked from
multiple call sites and waiting for runtime suspend to finish is the
correct thing to do except if it's executing in the context of the
worker.

v2: Expand kerneldoc to specifically mention deadlock between
    output poll worker and autosuspend worker as use case. (Lyude)

Cc: Dave Airlie <airlied@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Link: https://patchwork.freedesktop.org/patch/msgid/3549ce32e7f1467102e70d3e9cbf70c46bfe108e.1518593424.git.lukas@wunner.de
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/drm_probe_helper.c | 20 ++++++++++++++++++++
 include/drm/drm_crtc_helper.h      |  1 +
 2 files changed, 21 insertions(+)

--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -303,6 +303,26 @@ static void output_poll_execute(struct w
 }
 
 /**
+ * drm_kms_helper_is_poll_worker - is %current task an output poll worker?
+ *
+ * Determine if %current task is an output poll worker.  This can be used
+ * to select distinct code paths for output polling versus other contexts.
+ *
+ * One use case is to avoid a deadlock between the output poll worker and
+ * the autosuspend worker wherein the latter waits for polling to finish
+ * upon calling drm_kms_helper_poll_disable(), while the former waits for
+ * runtime suspend to finish upon calling pm_runtime_get_sync() in a
+ * connector ->detect hook.
+ */
+bool drm_kms_helper_is_poll_worker(void)
+{
+	struct work_struct *work = current_work();
+
+	return work && work->func == output_poll_execute;
+}
+EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
+
+/**
  * drm_kms_helper_poll_disable - disable output polling
  * @dev: drm_device
  *
--- a/include/drm/drm_crtc_helper.h
+++ b/include/drm/drm_crtc_helper.h
@@ -176,5 +176,6 @@ extern void drm_kms_helper_hotplug_event
 
 extern void drm_kms_helper_poll_disable(struct drm_device *dev);
 extern void drm_kms_helper_poll_enable(struct drm_device *dev);
+bool drm_kms_helper_is_poll_worker(void);
 
 #endif
