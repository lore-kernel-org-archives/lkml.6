Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335D4C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDB320652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDB320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbeIMTOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:14:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35382 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeIMTOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:14:07 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8A782D35;
        Thu, 13 Sep 2018 14:04:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.18 171/197] drm/rockchip: vop: fix irq disabled after vop driver probed
Date:   Thu, 13 Sep 2018 15:32:00 +0200
Message-Id: <20180913131848.403800354@linuxfoundation.org>
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

From: Sandy Huang <hjc@rock-chips.com>

commit 6456314ff1de246414a43e3132075b70b3e050ac upstream.

The vop irq is shared between vop and iommu and irq probing in the
iommu driver moved to the probe function recently. This can in some
cases lead to a stall if the irq is triggered while the vop driver
still has it disabled, but the vop irq handler gets called.

But there is no real need to disable the irq, as the vop can simply
also track its enabled state and ignore irqs in that case.
For this we can simply check the power-domain state of the vop,
similar to how the iommu driver does it.

So remove the enable/disable handling and add appropriate condition
to the irq handler.

changes in v2:
- move to just check the power-domain state
- add clock handling
changes in v3:
- clarify comment to speak of runtime-pm not power-domain
changes in v4:
- address Marc's comments (clk-enable WARN_ON and style improvement)

Fixes: d0b912bd4c23 ("iommu/rockchip: Request irqs in rk_iommu_probe()")
Cc: stable@vger.kernel.org
Signed-off-by: Sandy Huang <hjc@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180612132028.27490-3-heiko@sntech.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -573,8 +573,6 @@ static int vop_enable(struct drm_crtc *c
 
 	spin_unlock(&vop->reg_lock);
 
-	enable_irq(vop->irq);
-
 	drm_crtc_vblank_on(crtc);
 
 	return 0;
@@ -618,8 +616,6 @@ static void vop_crtc_atomic_disable(stru
 
 	vop_dsp_hold_valid_irq_disable(vop);
 
-	disable_irq(vop->irq);
-
 	vop->is_enabled = false;
 
 	/*
@@ -1196,6 +1192,18 @@ static irqreturn_t vop_isr(int irq, void
 	int ret = IRQ_NONE;
 
 	/*
+	 * The irq is shared with the iommu. If the runtime-pm state of the
+	 * vop-device is disabled the irq has to be targeted at the iommu.
+	 */
+	if (!pm_runtime_get_if_in_use(vop->dev))
+		return IRQ_NONE;
+
+	if (vop_core_clks_enable(vop)) {
+		DRM_DEV_ERROR_RATELIMITED(vop->dev, "couldn't enable clocks\n");
+		goto out;
+	}
+
+	/*
 	 * interrupt register has interrupt status, enable and clear bits, we
 	 * must hold irq_lock to avoid a race with enable/disable_vblank().
 	*/
@@ -1210,7 +1218,7 @@ static irqreturn_t vop_isr(int irq, void
 
 	/* This is expected for vop iommu irqs, since the irq is shared */
 	if (!active_irqs)
-		return IRQ_NONE;
+		goto out_disable;
 
 	if (active_irqs & DSP_HOLD_VALID_INTR) {
 		complete(&vop->dsp_hold_completion);
@@ -1236,6 +1244,10 @@ static irqreturn_t vop_isr(int irq, void
 		DRM_DEV_ERROR(vop->dev, "Unknown VOP IRQs: %#02x\n",
 			      active_irqs);
 
+out_disable:
+	vop_core_clks_disable(vop);
+out:
+	pm_runtime_put(vop->dev);
 	return ret;
 }
 
@@ -1614,9 +1626,6 @@ static int vop_bind(struct device *dev,
 	if (ret)
 		goto err_disable_pm_runtime;
 
-	/* IRQ is initially disabled; it gets enabled in power_on */
-	disable_irq(vop->irq);
-
 	return 0;
 
 err_disable_pm_runtime:


