Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7AEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663AB217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="VfBq6dvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeL2LsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 06:48:07 -0500
Received: from onstation.org ([52.200.56.107]:46182 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbeL2LsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 06:48:05 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 4CE3B195;
        Sat, 29 Dec 2018 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1546084083;
        bh=XWIKXWP3FNiXBkA5nUXCoJ2tn/OjcKcD9PdweriBBNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VfBq6dvhPa+6Qb2w+/G5E231PFZfc1mpZG6zOC93uZvo4al5YuWzy47UFQh9oTYXd
         +qeEltcikCnN5u9i6ms86LJ7zhsxuh72rrd4Sbpj4MW7yQL2LleORYyKC8wbk0Howk
         jR02foRDZ9XwzbNnd7W8Q6J6WyWmsJxkMhFtrWf0=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/3] spmi: pmic-arb: convert to v2 irq interfaces to support hierarchical IRQ chips
Date:   Sat, 29 Dec 2018 06:47:53 -0500
Message-Id: <20181229114755.8711-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181229114755.8711-1-masneyb@onstation.org>
References: <20181229114755.8711-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the spmi-pmic-arb IRQ code to use the version 2 IRQ interface
in order to support hierarchical IRQ chips. Code was tested on a LG
Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/spmi/spmi-pmic-arb.c | 91 +++++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 27 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 360b8218f322..c651d19f0623 100644
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
@@ -692,36 +693,37 @@ static struct irq_chip pmic_arb_irqchip = {
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
 	u16 apid, ppid;
 	int rc;
 
-	dev_dbg(&pmic_arb->spmic->dev, "intspec[0] 0x%1x intspec[1] 0x%02x intspec[2] 0x%02x\n",
-		intspec[0], intspec[1], intspec[2]);
+	dev_dbg(&pmic_arb->spmic->dev,
+		"param[0] 0x%1x param[1] 0x%02x param[2] 0x%02x\n",
+		fwspec->param[0], fwspec->param[1], fwspec->param[2]);
 
-	if (irq_domain_get_of_node(d) != controller)
+	if (irq_domain_get_of_node(d) != pmic_arb->spmic->dev.of_node)
 		return -EINVAL;
-	if (intsize != 4)
+	if (fwspec->param_count != 4)
 		return -EINVAL;
-	if (intspec[0] > 0xF || intspec[1] > 0xFF || intspec[2] > 0x7)
+	if (fwspec->param[0] > 0xF || fwspec->param[1] > 0xFF ||
+	    fwspec->param[2] > 0x7)
 		return -EINVAL;
 
-	ppid = intspec[0] << 8 | intspec[1];
+	ppid = fwspec->param[0] << 8 | fwspec->param[1];
 	rc = pmic_arb->ver_ops->ppid_to_apid(pmic_arb, ppid);
 	if (rc < 0) {
-		dev_err(&pmic_arb->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u rc = %d\n",
-		intspec[0], intspec[1], intspec[2], rc);
+		dev_err(&pmic_arb->spmic->dev,
+			"failed to xlate sid = %#x, periph = %#x, irq = %u rc = %d\n",
+			fwspec->param[0], fwspec->param[1], fwspec->param[2],
+			rc);
 		return rc;
 	}
 
@@ -732,25 +734,58 @@ static int qpnpint_irq_domain_dt_translate(struct irq_domain *d,
 	if (apid < pmic_arb->min_apid)
 		pmic_arb->min_apid = apid;
 
-	*out_hwirq = spec_to_hwirq(intspec[0], intspec[1], intspec[2], apid);
-	*out_type  = intspec[3] & IRQ_TYPE_SENSE_MASK;
+	*out_hwirq = spec_to_hwirq(fwspec->param[0], fwspec->param[1],
+				   fwspec->param[2], apid);
+	*out_type  = fwspec->param[3] & IRQ_TYPE_SENSE_MASK;
 
 	dev_dbg(&pmic_arb->spmic->dev, "out_hwirq = %lu\n", *out_hwirq);
 
 	return 0;
 }
 
-static int qpnpint_irq_domain_map(struct irq_domain *d,
-				  unsigned int virq,
-				  irq_hw_number_t hwirq)
+
+static void qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
+				   struct irq_domain *domain, unsigned int virq,
+				   irq_hw_number_t hwirq)
 {
-	struct spmi_pmic_arb *pmic_arb = d->host_data;
+	unsigned int old_virq;
 
 	dev_dbg(&pmic_arb->spmic->dev, "virq = %u, hwirq = %lu\n", virq, hwirq);
 
-	irq_set_chip_and_handler(virq, &pmic_arb_irqchip, handle_level_irq);
-	irq_set_chip_data(virq, d->host_data);
-	irq_set_noprobe(virq);
+	/*
+	 * Check to see if the hwirq is already associated with another virq on
+	 * this IRQ domain. If so, then disassociate it before associating the
+	 * hwirq with the new virq. IRQs are all initially setup without an IRQ
+	 * hierarchy when this driver is probed and when mfd/qcom-spmi-pmic.c is
+	 * probed. Later in the boot process, an IRQ hierarchy is requested by
+	 * pinctrl-spmi-gpio.c, and the same hwirq is now associated with a new
+	 * virq.
+	 */
+	old_virq = irq_find_mapping(domain, hwirq);
+	if (old_virq)
+		irq_domain_disassociate(domain, old_virq);
+
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
 
@@ -1126,8 +1161,10 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
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

