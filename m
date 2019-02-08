Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470F3C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1633221916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="DGqyDQXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfBHCRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:17:47 -0500
Received: from onstation.org ([52.200.56.107]:34968 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfBHCQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:16:51 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 3BBC066A;
        Fri,  8 Feb 2019 02:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549592210;
        bh=lOih7rtuGk2GaNrR8Pnk7HSLL+7QCJJAUJTGbDvdAKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DGqyDQXRarhIMnvf2bELMCxu4SducLpTHP/t0iBogzIssjpG2CHxkTdps1gKQs06h
         j9ML24VDXbdZ1jGWlU2tM4pJgadlrIekQI4TFbkTJSEH/PBBOJbaA7x4yD3C53pWEe
         OCCzoK0DP07Ke5YzL+FffHB5fpyf5wcf0U9U2920=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, lee.jones@linaro.org
Cc:     tglx@linutronix.de, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 03/11] genirq: introduce irq_chip_mask_ack_parent()
Date:   Thu,  7 Feb 2019 21:16:23 -0500
Message-Id: <20190208021631.30252-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190208021631.30252-1-masneyb@onstation.org>
References: <20190208021631.30252-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

The hierarchical irqchip never before ran into a situation
where the parent is not "simple", i.e. does not implement
.irq_ack() and .irq_mask() like most, but the qcom-pm8xxx.c
happens to implement only .irq_mask_ack().

Since we want to make ssbi-gpio a hierarchical child of this
irqchip, it must *also* only implement .irq_mask_ack()
and call down to the parent, and for this we of course
need irq_chip_mask_ack_parent().

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Brian Masney <masneyb@onstation.org>
---
This is a new patch introduced in v2.

 include/linux/irq.h |  1 +
 kernel/irq/chip.c   | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index def2b2aac8b1..9a1a67d2e07d 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -605,6 +605,7 @@ extern void irq_chip_disable_parent(struct irq_data *data);
 extern void irq_chip_ack_parent(struct irq_data *data);
 extern int irq_chip_retrigger_hierarchy(struct irq_data *data);
 extern void irq_chip_mask_parent(struct irq_data *data);
+extern void irq_chip_mask_ack_parent(struct irq_data *data);
 extern void irq_chip_unmask_parent(struct irq_data *data);
 extern void irq_chip_eoi_parent(struct irq_data *data);
 extern int irq_chip_set_affinity_parent(struct irq_data *data,
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 086d5a34b5a0..0aefc2e69cf5 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1277,6 +1277,17 @@ void irq_chip_mask_parent(struct irq_data *data)
 }
 EXPORT_SYMBOL_GPL(irq_chip_mask_parent);
 
+/**
+ * irq_chip_mask_ack_parent - Mask and acknowledge the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ */
+void irq_chip_mask_ack_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	data->chip->irq_mask_ack(data);
+}
+EXPORT_SYMBOL_GPL(irq_chip_mask_ack_parent);
+
 /**
  * irq_chip_unmask_parent - Unmask the parent interrupt
  * @data:	Pointer to interrupt specific data
-- 
2.17.2

