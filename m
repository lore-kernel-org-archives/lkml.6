Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA59C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D82520657
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="L2ypAFEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfAMPsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 10:48:43 -0500
Received: from onstation.org ([52.200.56.107]:42682 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfAMPro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 10:47:44 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 87E3A16A;
        Sun, 13 Jan 2019 15:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547394463;
        bh=VL7iW6TAeo46fmtpcRGHemUwCRRiLpa3UALjEjkPb0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2ypAFEiDwK82Kp5XZTByqkcvC6FWGTJDJlcnFsp7wb5kh+djIoGgrysUehx2V/Rg
         bHcmZaQAZctJQBk72ruPXLe55eaw5PnKUNI/QJVgyfPSn2N8OViYPp54wkCiLtzEQP
         jts1h5HbbFw8/TfAPAt1nLJpm6IrUuo73GhLo6hs=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 05/14] gpio: add irq domain activate/deactivate functions
Date:   Sun, 13 Jan 2019 10:47:07 -0500
Message-Id: <20190113154716.5145-6-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190113154716.5145-1-masneyb@onstation.org>
References: <20190113154716.5145-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the two new functions gpiochip_irq_domain_activate and
gpiochip_irq_domain_deactivate that can be used as the activate and
deactivate functions in the struct irq_domain_ops. This is for
situations where only gpiochip_{lock,unlock}_as_irq needs to be called.
SPMI and SSBI GPIO are two users that will initially use these
functions.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Suggested-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
Changes since v3:
- Correct kernel doc syntax: 'struct &foo' -> '&struct foo'
  '&func' -> 'func()'

 drivers/gpio/gpiolib.c      | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/gpio/driver.h |  5 +++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1651d7f0a303..ca81252b97b9 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1775,6 +1775,43 @@ static const struct irq_domain_ops gpiochip_domain_ops = {
 	.xlate	= irq_domain_xlate_twocell,
 };
 
+/**
+ * gpiochip_irq_domain_activate() - Lock a GPIO to be used as an IRQ
+ * @domain: The IRQ domain used by this IRQ chip
+ * @data: Outermost irq_data associated with the IRQ
+ * @reserve: If set, only reserve an interrupt vector instead of assigning one
+ *
+ * This function is a wrapper that calls gpiochip_lock_as_irq() and is to be
+ * used as the activate function for the &struct irq_domain_ops. The host_data
+ * for the IRQ domain must be the &struct gpiochip.
+ */
+int gpiochip_irq_domain_activate(struct irq_domain *domain,
+				 struct irq_data *data, bool reserve)
+{
+	struct gpio_chip *chip = domain->host_data;
+
+	return gpiochip_lock_as_irq(chip, data->hwirq);
+}
+EXPORT_SYMBOL_GPL(gpiochip_irq_domain_activate);
+
+/**
+ * gpiochip_irq_domain_deactivate() - Unlock a GPIO used as an IRQ
+ * @domain: The IRQ domain used by this IRQ chip
+ * @data: Outermost irq_data associated with the IRQ
+ *
+ * This function is a wrapper that will call gpiochip_unlock_as_irq() and is to
+ * be used as the deactivate function for the &struct irq_domain_ops. The
+ * host_data for the IRQ domain must be the &struct gpiochip.
+ */
+void gpiochip_irq_domain_deactivate(struct irq_domain *domain,
+				    struct irq_data *data)
+{
+	struct gpio_chip *chip = domain->host_data;
+
+	return gpiochip_unlock_as_irq(chip, data->hwirq);
+}
+EXPORT_SYMBOL_GPL(gpiochip_irq_domain_deactivate);
+
 static int gpiochip_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	if (!gpiochip_irqchip_irq_valid(chip, offset))
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 07cddbf45186..01497910f023 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -472,6 +472,11 @@ int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
 		     irq_hw_number_t hwirq);
 void gpiochip_irq_unmap(struct irq_domain *d, unsigned int irq);
 
+int gpiochip_irq_domain_activate(struct irq_domain *domain,
+				 struct irq_data *data, bool reserve);
+void gpiochip_irq_domain_deactivate(struct irq_domain *domain,
+				    struct irq_data *data);
+
 void gpiochip_set_chained_irqchip(struct gpio_chip *gpiochip,
 		struct irq_chip *irqchip,
 		unsigned int parent_irq,
-- 
2.17.2

