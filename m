Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844D7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FB120867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="K8P0gp4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FB120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lekensteyn.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeIEBfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:35:52 -0400
Received: from lekensteyn.nl ([178.21.112.251]:44485 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbeIEBfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:35:51 -0400
X-Greylist: delayed 2474 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2018 21:35:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=Message-Id:Date:Subject:Cc:To:From; bh=sGJ23fEclMpORbwCZVDGM19HmTiCRATIn0wraawGi0c=;
        b=K8P0gp4WKoGP3jdq+/xXN3MRmh1cJoWoPTXuZ70zACMdfQacWX6jeak0DitvGXBWm7x4m3UHcq6RCobJk1qoJibILrwPgOHt15IxTTMfQHYRnyh/BMyHnXd6vHP6jNuAIVvJrfa9ktN0odGxFtYkL3WAdUFX7jALLm4J5SnCwDH8MmbG6UQMHTGQ3x4GFvfjAlJdhGNmm/5TVgpKYzCeZQlsnoM1q7BZbM2XvAZ4pJWcgFQW1eWsrLlHFPWnGC6YVgBiNTPsf8RRgfdR4irymW5PLC4kw2Oh2egqiK6a+G8xTCXHbzwTPKFyld0zDtlMtapcuFwE8XCN8xDPodgZQQ==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1fxHvN-0002Ox-Fh; Tue, 04 Sep 2018 22:27:45 +0200
From:   Peter Wu <peter@lekensteyn.nl>
To:     Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qxl: fix null-pointer crash during suspend
Date:   Tue,  4 Sep 2018 22:27:47 +0200
Message-Id: <20180904202747.14968-1-peter@lekensteyn.nl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"crtc->helper_private" is not initialized by the QXL driver and thus the
"crtc_funcs->disable" call would crash (resulting in suspend failure).
Fix this by converting the suspend/resume functions to use the
drm_mode_config_helper_* helpers.

Tested system sleep with QEMU 3.0 using "echo mem > /sys/power/state".
During suspend the following message is visible from QEMU:

    spice/server/display-channel.c:2425:display_channel_validate_surface: canvas address is 0x7fd05da68308 for 0 (and is NULL)
    spice/server/display-channel.c:2426:display_channel_validate_surface: failed on 0

This seems to be triggered by QXL_IO_NOTIFY_CMD after
QXL_IO_DESTROY_PRIMARY_ASYNC, but aside from the warning things still
seem to work (tested with both the GTK and -spice options).

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
Hi,

I found this issue while trying to suspend a VM that uses QXL. In order to see
the stack trace over serial, boot with no_console_suspend. Searching for
"qxl_drm_freeze" showed one recent report from Alan:
https://lkml.kernel.org/r/891e334c-cf19-032c-b996-59ac166fcde1@gmail.com

Kind regards,
Peter
---
 drivers/gpu/drm/qxl/qxl_drv.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 2445e75cf7ea..d00f45eed03c 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -136,20 +136,11 @@ static int qxl_drm_freeze(struct drm_device *dev)
 {
 	struct pci_dev *pdev = dev->pdev;
 	struct qxl_device *qdev = dev->dev_private;
-	struct drm_crtc *crtc;
-
-	drm_kms_helper_poll_disable(dev);
-
-	console_lock();
-	qxl_fbdev_set_suspend(qdev, 1);
-	console_unlock();
+	int ret;
 
-	/* unpin the front buffers */
-	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
-		const struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
-		if (crtc->enabled)
-			(*crtc_funcs->disable)(crtc);
-	}
+	ret = drm_mode_config_helper_suspend(dev);
+	if (ret)
+		return ret;
 
 	qxl_destroy_monitors_object(qdev);
 	qxl_surf_evict(qdev);
@@ -175,14 +166,7 @@ static int qxl_drm_resume(struct drm_device *dev, bool thaw)
 	}
 
 	qxl_create_monitors_object(qdev);
-	drm_helper_resume_force_mode(dev);
-
-	console_lock();
-	qxl_fbdev_set_suspend(qdev, 0);
-	console_unlock();
-
-	drm_kms_helper_poll_enable(dev);
-	return 0;
+	return drm_mode_config_helper_resume(dev);
 }
 
 static int qxl_pm_suspend(struct device *dev)
-- 
2.18.0

