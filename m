Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F12ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9789A20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9789A20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbeGQAj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 20:39:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729466AbeGQAjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 20:39:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F36D40122A1;
        Mon, 16 Jul 2018 23:59:55 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-27.rdu2.redhat.com [10.10.124.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB52F2026D65;
        Mon, 16 Jul 2018 23:59:54 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <karolherbst@gmail.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/nouveau: Prevent RPM callback recursion in suspend/resume paths
Date:   Mon, 16 Jul 2018 19:59:25 -0400
Message-Id: <20180716235936.11268-2-lyude@redhat.com>
In-Reply-To: <20180716235936.11268-1-lyude@redhat.com>
References: <20180716235936.11268-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 16 Jul 2018 23:59:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 16 Jul 2018 23:59:55 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to fix all of the spots that need to have runtime PM get/puts()
added, we need to ensure that it's possible for us to call
pm_runtime_get/put() in any context, regardless of how deep, since
almost all of the spots that are currently missing refs can potentially
get called in the runtime suspend/resume path. Otherwise, we'll try to
resume the GPU as we're trying to resume the GPU (and vice-versa) and
cause the kernel to deadlock.

With this, it should be safe to call the pm runtime functions in any
context in nouveau with one condition: any point in the driver that
calls pm_runtime_get*() cannot hold any locks owned by nouveau that
would be acquired anywhere inside nouveau_pmops_runtime_resume().
This includes modesetting locks, i2c bus locks, etc.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <karolherbst@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index c7ec86d6c3c9..e851ef7b6373 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -835,6 +835,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
 		return -EBUSY;
 	}
 
+	dev->power.disable_depth++;
+
 	drm_kms_helper_poll_disable(drm_dev);
 	nouveau_switcheroo_optimus_dsm();
 	ret = nouveau_do_suspend(drm_dev, true);
@@ -843,6 +845,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
 	pci_ignore_hotplug(pdev);
 	pci_set_power_state(pdev, PCI_D3cold);
 	drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
+
+	dev->power.disable_depth--;
 	return ret;
 }
 
@@ -859,11 +863,13 @@ nouveau_pmops_runtime_resume(struct device *dev)
 		return -EBUSY;
 	}
 
+	dev->power.disable_depth++;
+
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	ret = pci_enable_device(pdev);
 	if (ret)
-		return ret;
+		goto out;
 	pci_set_master(pdev);
 
 	ret = nouveau_do_resume(drm_dev, true);
@@ -875,6 +881,8 @@ nouveau_pmops_runtime_resume(struct device *dev)
 	/* Monitors may have been connected / disconnected during suspend */
 	schedule_work(&nouveau_drm(drm_dev)->hpd_work);
 
+out:
+	dev->power.disable_depth--;
 	return ret;
 }
 
-- 
2.17.1

