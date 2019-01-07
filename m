Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57310C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE932085B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="IQA1iwKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfAGCL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:11:59 -0500
Received: from onstation.org ([52.200.56.107]:46952 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfAGCL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:11:56 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id B43E97AE;
        Mon,  7 Jan 2019 02:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1546827115;
        bh=aQ2zKZB/Fs66uwdW26K9mWgE40eFPG85yEbnpwoqDM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQA1iwKmdyEfT8/qoeTov7fkd62vXMr0gIJgO1ZNLtadveBbnM00CskB2CblqrE9F
         Ec9tVU7bzwKlm2l0s5ZhJiz43zlrtlfqC/jgJ2CKJ9NdppuVYI4UiHBtgUr9LyrApb
         dISTLGUCXllRb+pYg4L8A8gwNEud3/fk2RWe4vKc=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        lee.jones@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] spmi: pmic-arb: convert to v2 irq interfaces to support hierarchical IRQ chips
Date:   Sun,  6 Jan 2019 21:11:43 -0500
Message-Id: <20190107021145.6370-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190107021145.6370-1-masneyb@onstation.org>
References: <20190107021145.6370-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the spmi-pmic-arb IRQ code to use the version 2 IRQ interface
in order to support hierarchical IRQ chips. This is necessary so that
spmi-gpio can be setup as a hierarchical IRQ chip with pmic-arb as the
parent. IRQ chips in device tree should be usable from the start without
the consumer having to make an additional call to gpio[d]_to_irq() to
get the proper IRQ on the parent. Driver was tested on a LG Nexus 5
(hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1:
- Add intspec variable to qpnpint_irq_domain_translate to reduce the
  overall diff.
- Remove irq_domain_disassociate hack.

 drivers/spmi/spmi-pmic-arb.c | 58 +++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 360b8218f322..356bc3f66e22 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -666,7 +666,8 @@ static int qpnpint_get_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
-static int qpnpint_irq_request_resources(struct irq_data *d)
+static int qpnpint_irq_domain_activate(struct irq_domain *domain,
+				       struct irq_data *d, bool reserve)
 {
 	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
 	u16 periph = hwirq_to_per(d->hwirq);
@@ -692,27 +693,25 @@ static struct irq_chip pmic_arb_irqchip = {
 	.irq_set_type	= qpnpint_irq_set_type,
 	.irq_set_wake	= qpnpint_irq_set_wake,
 	.irq_get_irqchip_state	= qpnpint_get_irqchip_state,
-	.irq_request_resources = qpnpint_irq_request_resources,
 	.flags		= IRQCHIP_MASK_ON_SUSPEND,
 };
 
-static int qpnpint_irq_domain_dt_translate(struct irq_domain *d,
-					   struct device_node *controller,
-					   const u32 *intspec,
-					   unsigned int intsize,
-					   unsigned long *out_hwirq,
-					   unsigned int *out_type)
+static int qpnpint_irq_domain_translate(struct irq_domain *d,
+					struct irq_fwspec *fwspec,
+					unsigned long *out_hwirq,
+					unsigned int *out_type)
 {
 	struct spmi_pmic_arb *pmic_arb = d->host_data;
+	u32 *intspec = fwspec->param;
 	u16 apid, ppid;
 	int rc;
 
 	dev_dbg(&pmic_arb->spmic->dev, "intspec[0] 0x%1x intspec[1] 0x%02x intspec[2] 0x%02x\n",
 		intspec[0], intspec[1], intspec[2]);
 
-	if (irq_domain_get_of_node(d) != controller)
+	if (irq_domain_get_of_node(d) != pmic_arb->spmic->dev.of_node)
 		return -EINVAL;
-	if (intsize != 4)
+	if (fwspec->param_count != 4)
 		return -EINVAL;
 	if (intspec[0] > 0xF || intspec[1] > 0xFF || intspec[2] > 0x7)
 		return -EINVAL;
@@ -740,17 +739,34 @@ static int qpnpint_irq_domain_dt_translate(struct irq_domain *d,
 	return 0;
 }
 
-static int qpnpint_irq_domain_map(struct irq_domain *d,
-				  unsigned int virq,
-				  irq_hw_number_t hwirq)
-{
-	struct spmi_pmic_arb *pmic_arb = d->host_data;
 
+static void qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
+				   struct irq_domain *domain, unsigned int virq,
+				   irq_hw_number_t hwirq)
+{
 	dev_dbg(&pmic_arb->spmic->dev, "virq = %u, hwirq = %lu\n", virq, hwirq);
 
-	irq_set_chip_and_handler(virq, &pmic_arb_irqchip, handle_level_irq);
-	irq_set_chip_data(virq, d->host_data);
-	irq_set_noprobe(virq);
+	irq_domain_set_info(domain, virq, hwirq, &pmic_arb_irqchip, pmic_arb,
+			    handle_level_irq, NULL, NULL);
+}
+
+static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
+				    unsigned int virq, unsigned int nr_irqs,
+				    void *data)
+{
+	struct spmi_pmic_arb *pmic_arb = domain->host_data;
+	struct irq_fwspec *fwspec = data;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret, i;
+
+	ret = qpnpint_irq_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		qpnpint_irq_domain_map(pmic_arb, domain, virq + i, hwirq + i);
+
 	return 0;
 }
 
@@ -1126,8 +1142,10 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
 };
 
 static const struct irq_domain_ops pmic_arb_irq_domain_ops = {
-	.map	= qpnpint_irq_domain_map,
-	.xlate	= qpnpint_irq_domain_dt_translate,
+	.activate = qpnpint_irq_domain_activate,
+	.alloc = qpnpint_irq_domain_alloc,
+	.free = irq_domain_free_irqs_common,
+	.translate = qpnpint_irq_domain_translate,
 };
 
 static int spmi_pmic_arb_probe(struct platform_device *pdev)
-- 
2.17.2

