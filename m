Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10E9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C95521A38
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cSDOBcVm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c5GHEexv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C95521A38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeHQTnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:43:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48154 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbeHQTnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:43:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8DA96621E6; Fri, 17 Aug 2018 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534523960;
        bh=ENAVc3R5FTrYnDKyvx6U7tW772rhwQ86OJD8wGGgBIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cSDOBcVm0/QuOA9tqLykKIiy/mg9b9Q9H0qSstBm4x5RPwAJ020sSCD5DQCHs1/L7
         osqw5W43PIkPbaO6mRPmiRCqPw7o0nhdhlaJUaJ5V6+iymSkLR/2NRKphD0rN+/LUr
         r8XWrsP1QLHKDY2nb3HsSYH1W+rUoFWC4C9uc5zE=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3448A62454;
        Fri, 17 Aug 2018 16:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534523957;
        bh=ENAVc3R5FTrYnDKyvx6U7tW772rhwQ86OJD8wGGgBIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5GHEexvV5On1/IgjNVsXJ2nAavwa3eBlvP6xzlcdtWQSawCGY3wT1ZbkQO/zo9XR
         37Xz4/BPI9ZQk9jJzwPE8E+rEIFvlsZYfhnajHTyKDfc7s10sg6+BrQvPSpbMYMVSx
         AnlxNjvz9Zw3AlR4/4ffHsDLjgnoLtgkUh6uqZlc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3448A62454
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2 3/5] drivers: pinctrl: msm: enable PDC interrupt only during suspend
Date:   Fri, 17 Aug 2018 10:38:47 -0600
Message-Id: <20180817163849.30750-4-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817163849.30750-1-ilina@codeaurora.org>
References: <20180817163849.30750-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During suspend the system may power down some of the system rails. As a
result, the TLMM hw block may not be operational anymore and wakeup
capable GPIOs will not be detected. The PDC however will be operational
and the GPIOs that are routed to the PDC as IRQs can wake the system up.

To avoid being interrupted twice (for TLMM and once for PDC IRQ) when a
GPIO trips, use TLMM for active and switch to PDC for suspend. When
entering suspend, disable the TLMM wakeup interrupt and instead enable
the PDC IRQ and revert upon resume.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 60 +++++++++++++++++++++++++++++-
 drivers/pinctrl/qcom/pinctrl-msm.h |  3 ++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 03ef1d29d078..17e541f8f09d 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -37,6 +37,7 @@
 #include "../pinctrl-utils.h"
 
 #define MAX_NR_GPIO 300
+#define MAX_PDC_IRQ 1024
 #define PS_HOLD_OFFSET 0x820
 
 /**
@@ -51,6 +52,7 @@
  * @enabled_irqs:   Bitmap of currently enabled irqs.
  * @dual_edge_irqs: Bitmap of irqs that need sw emulated dual edge
  *                  detection.
+ * @pdc_irqs:       Bitmap of wakeup capable irqs.
  * @soc;            Reference to soc_data of platform specific data.
  * @regs:           Base address for the TLMM register map.
  */
@@ -68,11 +70,14 @@ struct msm_pinctrl {
 
 	DECLARE_BITMAP(dual_edge_irqs, MAX_NR_GPIO);
 	DECLARE_BITMAP(enabled_irqs, MAX_NR_GPIO);
+	DECLARE_BITMAP(pdc_irqs, MAX_PDC_IRQ);
 
 	const struct msm_pinctrl_soc_data *soc;
 	void __iomem *regs;
 };
 
+static bool in_suspend;
+
 static int msm_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
@@ -787,8 +792,11 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
-	if (pdc_irqd)
+	if (pdc_irqd && !in_suspend) {
 		irq_set_irq_wake(pdc_irqd->irq, on);
+		on ? set_bit(pdc_irqd->irq, pctrl->pdc_irqs) :
+		     clear_bit(pdc_irqd->irq, pctrl->pdc_irqs);
+	}
 
 	irq_set_irq_wake(pctrl->irq, on);
 
@@ -920,6 +928,8 @@ static int msm_gpio_pdc_pin_request(struct irq_data *d)
 	}
 
 	irq_set_handler_data(d->irq, irq_get_irq_data(irq));
+	irq_set_handler_data(irq, d);
+	irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
 	disable_irq(irq);
 
 	return 0;
@@ -1070,6 +1080,54 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
 		}
 }
 
+int __maybe_unused msm_pinctrl_suspend_late(struct device *dev)
+{
+	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
+	struct irq_data *irqd;
+	int i;
+
+	in_suspend = true;
+	for_each_set_bit(i, pctrl->pdc_irqs, MAX_PDC_IRQ) {
+		irqd = irq_get_handler_data(i);
+		/*
+		 * We don't know if the TLMM will be functional
+		 * or not, during the suspend. If its functional,
+		 * we do not want duplicate interrupts from PDC.
+		 * Hence disable the GPIO IRQ and enable PDC IRQ.
+		 */
+		if (irqd_is_wakeup_set(irqd)) {
+			irq_set_irq_wake(irqd->irq, false);
+			disable_irq(irqd->irq);
+			enable_irq(i);
+		}
+	}
+
+	return 0;
+}
+
+int __maybe_unused msm_pinctrl_resume_late(struct device *dev)
+{
+	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
+	struct irq_data *irqd;
+	int i;
+
+	for_each_set_bit(i, pctrl->pdc_irqs, MAX_PDC_IRQ) {
+		irqd = irq_get_handler_data(i);
+		/*
+		 * The TLMM will be operational now, so disable
+		 * the PDC IRQ.
+		 */
+		if (irqd_is_wakeup_set(irq_get_irq_data(i))) {
+			disable_irq_nosync(i);
+			irq_set_irq_wake(irqd->irq, true);
+			enable_irq(irqd->irq);
+		}
+	}
+	in_suspend = false;
+
+	return 0;
+}
+
 int msm_pinctrl_probe(struct platform_device *pdev,
 		      const struct msm_pinctrl_soc_data *soc_data)
 {
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 9b9feea540ff..21b56fb5dae9 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -123,4 +123,7 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 		      const struct msm_pinctrl_soc_data *soc_data);
 int msm_pinctrl_remove(struct platform_device *pdev);
 
+int msm_pinctrl_suspend_late(struct device *dev);
+int msm_pinctrl_resume_late(struct device *dev);
+
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

