Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A683BC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A0620852
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A0620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbeGLRNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:13:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727455AbeGLRNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:13:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BFE0640200AE;
        Thu, 12 Jul 2018 17:03:05 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-120-214.rdu2.redhat.com [10.10.120.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5971B10FFE4D;
        Thu, 12 Jul 2018 17:03:05 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/nouveau: Remove bogus crtc check in pmops_runtime_idle
Date:   Thu, 12 Jul 2018 13:02:54 -0400
Message-Id: <20180712170256.13018-4-lyude@redhat.com>
In-Reply-To: <20180712170256.13018-1-lyude@redhat.com>
References: <20180712170256.13018-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 17:03:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 17:03:05 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This both uses the legacy modesetting structures in a racy manner, and
additionally also doesn't even check the right variable (enabled != the
CRTC is actually turned on for atomic).

This fixes issues on my P50 regarding the dedicated GPU not entering
runtime suspend.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 0f668e275ee1..c7ec86d6c3c9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -881,22 +881,11 @@ nouveau_pmops_runtime_resume(struct device *dev)
 static int
 nouveau_pmops_runtime_idle(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct nouveau_drm *drm = nouveau_drm(drm_dev);
-	struct drm_crtc *crtc;
-
 	if (!nouveau_pmops_runtime()) {
 		pm_runtime_forbid(dev);
 		return -EBUSY;
 	}
 
-	list_for_each_entry(crtc, &drm->dev->mode_config.crtc_list, head) {
-		if (crtc->enabled) {
-			DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
-			return -EBUSY;
-		}
-	}
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_autosuspend(dev);
 	/* we don't want the main rpm_idle to call suspend - we want to autosuspend */
-- 
2.17.1

