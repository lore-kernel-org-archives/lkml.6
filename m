Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F74C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E403A2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mM+LnKp0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mM+LnKp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E403A2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeIEBpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:45:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50772 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbeIEBpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:45:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D0D4F609D1; Tue,  4 Sep 2018 21:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536095907;
        bh=ygZ/fitggKIxUU9kYNf/gcHQbC6/lkjp9de2O9maM9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mM+LnKp0Pt8wVudaC8aIi3RRRboAiS0kPXxOPKZLm/ez9qtMG3pFjeniHu+R8jgby
         +CTlzxcz5/5RqzRvHkMujeO4D/nP18+88G/TqVqFBdCOtzU/H4nb0GX30d2EKnD/2Z
         2PFcsKQPUYi2NEJDDxLFafVSTZx0gjs4HpzqvgI0=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E9DB608BF;
        Tue,  4 Sep 2018 21:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536095907;
        bh=ygZ/fitggKIxUU9kYNf/gcHQbC6/lkjp9de2O9maM9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mM+LnKp0Pt8wVudaC8aIi3RRRboAiS0kPXxOPKZLm/ez9qtMG3pFjeniHu+R8jgby
         +CTlzxcz5/5RqzRvHkMujeO4D/nP18+88G/TqVqFBdCOtzU/H4nb0GX30d2EKnD/2Z
         2PFcsKQPUYi2NEJDDxLFafVSTZx0gjs4HpzqvgI0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E9DB608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 3/5] drivers: pinctrl: msm: enable PDC interrupt only during suspend
Date:   Tue,  4 Sep 2018 15:18:08 -0600
Message-Id: <20180904211810.5506-4-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904211810.5506-1-ilina@codeaurora.org>
References: <20180904211810.5506-1-ilina@codeaurora.org>
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
Changes in v3:
	- Enable PDC-IRQ swap only for edge interrupts
Changes in v2:
	- Fix PDC IRQ max port, 126 is the max supported in h/w
	- Use PDC hwirq in bitmap, linux numbers could be large
	- Setup DISABLE_UNLAZY for both TLMM and PDC IRQs
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 73 +++++++++++++++++++++++++++++-
 drivers/pinctrl/qcom/pinctrl-msm.h |  3 ++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 6527a0a9edd1..01a455f86fcd 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -37,6 +37,7 @@
 #include "../pinctrl-utils.h"
 
 #define MAX_NR_GPIO 300
+#define MAX_PDC_HWIRQ 126
 #define PS_HOLD_OFFSET 0x820
 
 /**
@@ -51,6 +52,7 @@
  * @enabled_irqs:   Bitmap of currently enabled irqs.
  * @dual_edge_irqs: Bitmap of irqs that need sw emulated dual edge
  *                  detection.
+ * @pdc_hwirqs:     Bitmap of wakeup capable irqs.
  * @soc;            Reference to soc_data of platform specific data.
  * @regs:           Base address for the TLMM register map.
  */
@@ -68,11 +70,15 @@ struct msm_pinctrl {
 
 	DECLARE_BITMAP(dual_edge_irqs, MAX_NR_GPIO);
 	DECLARE_BITMAP(enabled_irqs, MAX_NR_GPIO);
+	DECLARE_BITMAP(pdc_hwirqs, MAX_PDC_HWIRQ);
 
 	const struct msm_pinctrl_soc_data *soc;
 	void __iomem *regs;
+	struct irq_domain *pdc_irq_domain;
 };
 
+static bool in_suspend;
+
 static int msm_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
@@ -787,8 +793,13 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
-	if (pdc_irqd)
+	if (pdc_irqd && !in_suspend) {
 		irq_set_irq_wake(pdc_irqd->irq, on);
+		if (on)
+			set_bit(pdc_irqd->hwirq, pctrl->pdc_hwirqs);
+		else
+			clear_bit(pdc_irqd->hwirq, pctrl->pdc_hwirqs);
+	}
 
 	irq_set_irq_wake(pctrl->irq, on);
 
@@ -919,7 +930,12 @@ static int msm_gpio_pdc_pin_request(struct irq_data *d)
 	}
 
 	irq_set_handler_data(d->irq, irq_get_irq_data(irq));
+	irq_set_handler_data(irq, d);
+	irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
+	irq_set_status_flags(d->irq, IRQ_DISABLE_UNLAZY);
 	disable_irq(irq);
+	if (!pctrl->pdc_irq_domain)
+		pctrl->pdc_irq_domain = irq_get_irq_data(irq)->domain;
 
 	return 0;
 }
@@ -1071,6 +1087,61 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
 		}
 }
 
+int __maybe_unused msm_pinctrl_suspend_late(struct device *dev)
+{
+	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
+	struct irq_data *irqd;
+	unsigned int irq;
+	int i;
+
+	in_suspend = true;
+	for_each_set_bit(i, pctrl->pdc_hwirqs, MAX_PDC_HWIRQ) {
+		irq = irq_find_mapping(pctrl->pdc_irq_domain, i);
+		irqd = irq_get_handler_data(irq);
+		/*
+		 * We don't know if the TLMM will be functional
+		 * or not, during the suspend. If its functional,
+		 * we do not want duplicate interrupts from PDC.
+		 * Hence disable the GPIO IRQ and enable PDC IRQ
+		 * for edge interrupt only.
+		 */
+		if (irqd_is_wakeup_set(irqd) && !irqd_is_level_type(irqd)) {
+			disable_irq_wake(irqd->irq);
+			disable_irq(irqd->irq);
+			enable_irq(irq);
+		}
+	}
+
+	return 0;
+}
+
+int __maybe_unused msm_pinctrl_resume_late(struct device *dev)
+{
+	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
+	struct irq_data *irqd, *pdc_irqd;
+	unsigned int irq;
+	int i;
+
+	for_each_set_bit(i, pctrl->pdc_hwirqs, MAX_PDC_HWIRQ) {
+		irq = irq_find_mapping(pctrl->pdc_irq_domain, i);
+		irqd = irq_get_handler_data(irq);
+		pdc_irqd = irq_get_irq_data(irq);
+		/*
+		 * The TLMM will be operational now, so disable
+		 * the PDC IRQ for edge interrupts only.
+		 */
+		if (irqd_is_wakeup_set(pdc_irqd) &&
+		    !irqd_is_level_type(pdc_irqd)) {
+			disable_irq_nosync(irq);
+			enable_irq_wake(irqd->irq);
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

