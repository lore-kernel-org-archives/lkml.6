Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEA1C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B5F23E90
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B5F23E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754287AbeGENhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:37:48 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:41290 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753782AbeGENdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:33:22 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id A583ACD5E;
        Thu,  5 Jul 2018 16:33:17 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v2 22/34] media: camss: ispif: Add support for 8x96
Date:   Thu,  5 Jul 2018 16:32:53 +0300
Message-Id: <1530797585-8555-23-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ISPIF hardware modules on 8x16 and 8x96 are similar. However on
8x96 the ISPIF routes data to two VFE hardware modules. Add
separate interrupt handler for 8x96 to handle the additional
interrupts.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-ispif.c | 76 ++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
index 8b04f8a..b124cd3 100644
--- a/drivers/media/platform/qcom/camss/camss-ispif.c
+++ b/drivers/media/platform/qcom/camss/camss-ispif.c
@@ -116,13 +116,77 @@ static const u32 ispif_formats[] = {
 };
 
 /*
- * ispif_isr - ISPIF module interrupt handler
+ * ispif_isr_8x96 - ISPIF module interrupt handler for 8x96
  * @irq: Interrupt line
  * @dev: ISPIF device
  *
  * Return IRQ_HANDLED on success
  */
-static irqreturn_t ispif_isr(int irq, void *dev)
+static irqreturn_t ispif_isr_8x96(int irq, void *dev)
+{
+	struct ispif_device *ispif = dev;
+	u32 value0, value1, value2, value3, value4, value5;
+
+	value0 = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_STATUS_0(0));
+	value1 = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_STATUS_1(0));
+	value2 = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_STATUS_2(0));
+	value3 = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_STATUS_0(1));
+	value4 = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_STATUS_1(1));
+	value5 = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_STATUS_2(1));
+
+	writel_relaxed(value0, ispif->base + ISPIF_VFE_m_IRQ_CLEAR_0(0));
+	writel_relaxed(value1, ispif->base + ISPIF_VFE_m_IRQ_CLEAR_1(0));
+	writel_relaxed(value2, ispif->base + ISPIF_VFE_m_IRQ_CLEAR_2(0));
+	writel_relaxed(value3, ispif->base + ISPIF_VFE_m_IRQ_CLEAR_0(1));
+	writel_relaxed(value4, ispif->base + ISPIF_VFE_m_IRQ_CLEAR_1(1));
+	writel_relaxed(value5, ispif->base + ISPIF_VFE_m_IRQ_CLEAR_2(1));
+
+	writel(0x1, ispif->base + ISPIF_IRQ_GLOBAL_CLEAR_CMD);
+
+	if ((value0 >> 27) & 0x1)
+		complete(&ispif->reset_complete);
+
+	if (unlikely(value0 & ISPIF_VFE_m_IRQ_STATUS_0_PIX0_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE0 pix0 overflow\n");
+
+	if (unlikely(value0 & ISPIF_VFE_m_IRQ_STATUS_0_RDI0_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE0 rdi0 overflow\n");
+
+	if (unlikely(value1 & ISPIF_VFE_m_IRQ_STATUS_1_PIX1_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE0 pix1 overflow\n");
+
+	if (unlikely(value1 & ISPIF_VFE_m_IRQ_STATUS_1_RDI1_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE0 rdi1 overflow\n");
+
+	if (unlikely(value2 & ISPIF_VFE_m_IRQ_STATUS_2_RDI2_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE0 rdi2 overflow\n");
+
+	if (unlikely(value3 & ISPIF_VFE_m_IRQ_STATUS_0_PIX0_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE1 pix0 overflow\n");
+
+	if (unlikely(value3 & ISPIF_VFE_m_IRQ_STATUS_0_RDI0_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE1 rdi0 overflow\n");
+
+	if (unlikely(value4 & ISPIF_VFE_m_IRQ_STATUS_1_PIX1_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE1 pix1 overflow\n");
+
+	if (unlikely(value4 & ISPIF_VFE_m_IRQ_STATUS_1_RDI1_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE1 rdi1 overflow\n");
+
+	if (unlikely(value5 & ISPIF_VFE_m_IRQ_STATUS_2_RDI2_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE1 rdi2 overflow\n");
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * ispif_isr_8x16 - ISPIF module interrupt handler for 8x16
+ * @irq: Interrupt line
+ * @dev: ISPIF device
+ *
+ * Return IRQ_HANDLED on success
+ */
+static irqreturn_t ispif_isr_8x16(int irq, void *dev)
 {
 	struct ispif_device *ispif = dev;
 	u32 value0, value1, value2;
@@ -954,8 +1018,14 @@ int msm_ispif_subdev_init(struct ispif_device *ispif,
 	ispif->irq = r->start;
 	snprintf(ispif->irq_name, sizeof(ispif->irq_name), "%s_%s",
 		 dev_name(dev), MSM_ISPIF_NAME);
-	ret = devm_request_irq(dev, ispif->irq, ispif_isr,
+	if (to_camss(ispif)->version == CAMSS_8x16)
+		ret = devm_request_irq(dev, ispif->irq, ispif_isr_8x16,
 			       IRQF_TRIGGER_RISING, ispif->irq_name, ispif);
+	else if (to_camss(ispif)->version == CAMSS_8x96)
+		ret = devm_request_irq(dev, ispif->irq, ispif_isr_8x96,
+			       IRQF_TRIGGER_RISING, ispif->irq_name, ispif);
+	else
+		ret = -EINVAL;
 	if (ret < 0) {
 		dev_err(dev, "request_irq failed: %d\n", ret);
 		return ret;
-- 
2.7.4

