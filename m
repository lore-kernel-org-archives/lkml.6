Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6318C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A2D20652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A2D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbeIMTNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:13:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35372 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeIMTNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:13:48 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1733BD35;
        Thu, 13 Sep 2018 14:04:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH 4.18 170/197] drm/rockchip: vop: split out core clock enablement into separate functions
Date:   Thu, 13 Sep 2018 15:31:59 +0200
Message-Id: <20180913131848.361976379@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Stuebner <heiko@sntech.de>

commit e2810a7167df14c762e085fae5aade38425b71bf upstream.

Judging from the iommu code, both the hclk and aclk are necessary for
register access. Split them off into separate functions from the regular
vop enablement, so that we can use them elsewhere as well.

Fixes: d0b912bd4c23 ("iommu/rockchip: Request irqs in rk_iommu_probe()")
[prerequisite change for the actual fix]
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20180612132028.27490-2-heiko@sntech.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   44 +++++++++++++++++++---------
 1 file changed, 31 insertions(+), 13 deletions(-)

--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -486,6 +486,31 @@ static void vop_line_flag_irq_disable(st
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 }
 
+static int vop_core_clks_enable(struct vop *vop)
+{
+	int ret;
+
+	ret = clk_enable(vop->hclk);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_enable(vop->aclk);
+	if (ret < 0)
+		goto err_disable_hclk;
+
+	return 0;
+
+err_disable_hclk:
+	clk_disable(vop->hclk);
+	return ret;
+}
+
+static void vop_core_clks_disable(struct vop *vop)
+{
+	clk_disable(vop->aclk);
+	clk_disable(vop->hclk);
+}
+
 static int vop_enable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
@@ -497,17 +522,13 @@ static int vop_enable(struct drm_crtc *c
 		return ret;
 	}
 
-	ret = clk_enable(vop->hclk);
+	ret = vop_core_clks_enable(vop);
 	if (WARN_ON(ret < 0))
 		goto err_put_pm_runtime;
 
 	ret = clk_enable(vop->dclk);
 	if (WARN_ON(ret < 0))
-		goto err_disable_hclk;
-
-	ret = clk_enable(vop->aclk);
-	if (WARN_ON(ret < 0))
-		goto err_disable_dclk;
+		goto err_disable_core;
 
 	/*
 	 * Slave iommu shares power, irq and clock with vop.  It was associated
@@ -519,7 +540,7 @@ static int vop_enable(struct drm_crtc *c
 	if (ret) {
 		DRM_DEV_ERROR(vop->dev,
 			      "failed to attach dma mapping, %d\n", ret);
-		goto err_disable_aclk;
+		goto err_disable_dclk;
 	}
 
 	spin_lock(&vop->reg_lock);
@@ -558,12 +579,10 @@ static int vop_enable(struct drm_crtc *c
 
 	return 0;
 
-err_disable_aclk:
-	clk_disable(vop->aclk);
 err_disable_dclk:
 	clk_disable(vop->dclk);
-err_disable_hclk:
-	clk_disable(vop->hclk);
+err_disable_core:
+	vop_core_clks_disable(vop);
 err_put_pm_runtime:
 	pm_runtime_put_sync(vop->dev);
 	return ret;
@@ -609,8 +628,7 @@ static void vop_crtc_atomic_disable(stru
 	rockchip_drm_dma_detach_device(vop->drm_dev, vop->dev);
 
 	clk_disable(vop->dclk);
-	clk_disable(vop->aclk);
-	clk_disable(vop->hclk);
+	vop_core_clks_disable(vop);
 	pm_runtime_put(vop->dev);
 	mutex_unlock(&vop->vop_lock);
 


