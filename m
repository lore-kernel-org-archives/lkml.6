Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145FAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9D9214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9D9214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeKLFus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:50:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51182 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730729AbeKLFsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:32 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsr-0000oJ-L8; Sun, 11 Nov 2018 19:59:01 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001jh-Pb; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Lyude Paul" <lyude@redhat.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.339231463@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 259/366] drm/nouveau: Remove bogus crtc check in
 pmops_runtime_idle
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 68fe23a626b67b56c912c496ea43ed537ea9708f upstream.

This both uses the legacy modesetting structures in a racy manner, and
additionally also doesn't even check the right variable (enabled != the
CRTC is actually turned on for atomic).

This fixes issues on my P50 regarding the dedicated GPU not entering
runtime suspend.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
[bwh: Backported to 3.16:
 - Preserve local variables that are still needed
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -927,7 +927,6 @@ static int nouveau_pmops_runtime_idle(st
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	struct nouveau_drm *drm = nouveau_drm(drm_dev);
-	struct drm_crtc *crtc;
 
 	if (nouveau_runtime_pm == 0) {
 		pm_runtime_forbid(dev);
@@ -950,12 +949,6 @@ static int nouveau_pmops_runtime_idle(st
 		}
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

