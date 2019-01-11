Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B68C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF2520675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfAKFi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:38:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730093AbfAKFiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:38:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 470A05277D;
        Fri, 11 Jan 2019 05:38:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8FAB1019630;
        Fri, 11 Jan 2019 05:37:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A70189AB2; Fri, 11 Jan 2019 06:37:53 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, noralf@tronnes.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 08/16] drm/bochs: atomic: use suspend/resume helpers
Date:   Fri, 11 Jan 2019 06:37:44 +0100
Message-Id: <20190111053752.4004-9-kraxel@redhat.com>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 11 Jan 2019 05:38:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to atomic helpers: drm_mode_config_helper_suspend/resume().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index f3dd66ae99..08ba6029d2 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -103,11 +103,8 @@ static int bochs_pm_suspend(struct device *dev)
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	struct bochs_device *bochs = drm_dev->dev_private;
 
-	drm_kms_helper_poll_disable(drm_dev);
-
 	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 1);
-
-	return 0;
+	return drm_mode_config_helper_suspend(drm_dev);
 }
 
 static int bochs_pm_resume(struct device *dev)
@@ -116,12 +113,8 @@ static int bochs_pm_resume(struct device *dev)
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	struct bochs_device *bochs = drm_dev->dev_private;
 
-	drm_helper_resume_force_mode(drm_dev);
-
 	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 0);
-
-	drm_kms_helper_poll_enable(drm_dev);
-	return 0;
+	return drm_mode_config_helper_resume(drm_dev);
 }
 #endif
 
-- 
2.9.3

