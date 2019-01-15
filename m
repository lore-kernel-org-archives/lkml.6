Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D33C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C2D20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfAOKkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:40:04 -0500
Received: from [217.140.106.52] ([217.140.106.52]:58957 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727231AbfAOKkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:40:03 -0500
X-Greylist: delayed 1453 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 05:40:03 EST
Received: from e110455-lin.cambridge.arm.com (e110455-lin.cambridge.arm.com [10.2.131.2])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id x0FAFiBw007271;
        Tue, 15 Jan 2019 10:15:44 GMT
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     James Wang <james.qian.wang@arm.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH] drm: arm/komeda: Remove IRQ parsing from initial series
Date:   Tue, 15 Jan 2019 10:15:44 +0000
Message-Id: <20190115101544.8653-1-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial series is only introducing the basic components and not
implementing IRQ handling. Remove the left over code that touches
IRQs until the proper implementation is introduced in a later series.

Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 5 -----
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 3 ---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 4 +---
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
index 84fdf707f2107..16f4e72abc1a3 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -59,11 +59,6 @@ static int komeda_parse_dt(struct device *dev, struct komeda_dev *mdev)
 		return PTR_ERR(clk);
 
 	mdev->mclk = clk;
-	mdev->irq  = platform_get_irq(pdev, 0);
-	if (mdev->irq < 0) {
-		DRM_ERROR("could not get IRQ number.\n");
-		return mdev->irq;
-	}
 
 	for_each_available_child_of_node(np, child) {
 		if (of_node_cmp(child->name, "pipeline") == 0) {
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
index a0bf7050037a0..0f77dead6a237 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -81,9 +81,6 @@ struct komeda_dev {
 	/** @mck: HW main engine clk */
 	struct clk *mclk;
 
-	/** @irq: irq number */
-	u32 irq;
-
 	int n_pipelines;
 	struct komeda_pipeline *pipelines[KOMEDA_MAX_PIPELINES];
 
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
index f41b20235130b..3fc096d3883e8 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -142,12 +142,10 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
 
 	err = drm_dev_register(drm, 0);
 	if (err)
-		goto uninstall_irq;
+		goto cleanup_mode_config;
 
 	return kms;
 
-uninstall_irq:
-	drm_irq_uninstall(drm);
 cleanup_mode_config:
 	drm_mode_config_cleanup(drm);
 free_kms:
-- 
2.20.1

