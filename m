Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58821C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAA221907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Q8b3YhYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfBHCRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:17:55 -0500
Received: from onstation.org ([52.200.56.107]:34954 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfBHCQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:16:51 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 98F8E591;
        Fri,  8 Feb 2019 02:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549592210;
        bh=CG2oobwYi0o7oTJVRu+ZVBuwGwFSNEfvmyL0YcQrPU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q8b3YhYhR+TgogzCMgRInxsyktN4JYqVF6R+pYeiNMRi7pSAIWWWkjbZVy0LeENpd
         XFRMuJNCZR+yEwwKhTfrgzoVeg/LEE/+FjNtenBfJbIDMuNliyWWtfwwZzCZgXKuXE
         7Ks7EnSnBeXJ7mJT+tPwsx2CDdzWgYZ5iJcI1Svg=
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
Subject: [PATCH v2 02/11] genirq: introduce irq_domain_translate_twocell
Date:   Thu,  7 Feb 2019 21:16:22 -0500
Message-Id: <20190208021631.30252-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190208021631.30252-1-masneyb@onstation.org>
References: <20190208021631.30252-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function irq_domain_translate_twocell() that is to be used as
the translate function in struct irq_domain_ops for the v2 IRQ API.

This patch also changes irq_domain_xlate_twocell() from the v1 IRQ API
to call irq_domain_translate_twocell() in the v2 IRQ API. This required
changes to of_phandle_args_to_fwspec()'s arguments so that it can be
called from multiple places.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1:
- Included Marc Zyngier's changes to irq_domain_xlate_twocell() and
  of_phandle_args_to_fwspec().

 include/linux/irqdomain.h |  5 +++++
 kernel/irq/irqdomain.c    | 45 +++++++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 35965f41d7be..fcefe0c7263f 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -419,6 +419,11 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_node *ctrlr,
 			const u32 *intspec, unsigned int intsize,
 			irq_hw_number_t *out_hwirq, unsigned int *out_type);
 
+int irq_domain_translate_twocell(struct irq_domain *d,
+				 struct irq_fwspec *fwspec,
+				 unsigned long *out_hwirq,
+				 unsigned int *out_type);
+
 /* IPI functions */
 int irq_reserve_ipi(struct irq_domain *domain, const struct cpumask *dest);
 int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 45c74373c7a4..c35434f70e71 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -729,16 +729,17 @@ static int irq_domain_translate(struct irq_domain *d,
 	return 0;
 }
 
-static void of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
+static void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
+				      unsigned int count,
 				      struct irq_fwspec *fwspec)
 {
 	int i;
 
-	fwspec->fwnode = irq_data->np ? &irq_data->np->fwnode : NULL;
-	fwspec->param_count = irq_data->args_count;
+	fwspec->fwnode = np ? &np->fwnode : NULL;
+	fwspec->param_count = count;
 
-	for (i = 0; i < irq_data->args_count; i++)
-		fwspec->param[i] = irq_data->args[i];
+	for (i = 0; i < count; i++)
+		fwspec->param[i] = args[i];
 }
 
 unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
@@ -836,7 +837,9 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 {
 	struct irq_fwspec fwspec;
 
-	of_phandle_args_to_fwspec(irq_data, &fwspec);
+	of_phandle_args_to_fwspec(irq_data->np, irq_data->args,
+				  irq_data->args_count, &fwspec);
+
 	return irq_create_fwspec_mapping(&fwspec);
 }
 EXPORT_SYMBOL_GPL(irq_create_of_mapping);
@@ -928,11 +931,10 @@ int irq_domain_xlate_twocell(struct irq_domain *d, struct device_node *ctrlr,
 			const u32 *intspec, unsigned int intsize,
 			irq_hw_number_t *out_hwirq, unsigned int *out_type)
 {
-	if (WARN_ON(intsize < 2))
-		return -EINVAL;
-	*out_hwirq = intspec[0];
-	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
-	return 0;
+	struct irq_fwspec fwspec;
+
+	of_phandle_args_to_fwspec(ctrlr, intspec, intsize, &fwspec);
+	return irq_domain_translate_twocell(d, &fwspec, out_hwirq, out_type);
 }
 EXPORT_SYMBOL_GPL(irq_domain_xlate_twocell);
 
@@ -968,6 +970,27 @@ const struct irq_domain_ops irq_domain_simple_ops = {
 };
 EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
 
+/**
+ * irq_domain_translate_twocell() - Generic translate for direct two cell
+ * bindings
+ *
+ * Device Tree IRQ specifier translation function which works with two cell
+ * bindings where the cell values map directly to the hwirq number
+ * and linux irq flags.
+ */
+int irq_domain_translate_twocell(struct irq_domain *d,
+				 struct irq_fwspec *fwspec,
+				 unsigned long *out_hwirq,
+				 unsigned int *out_type)
+{
+	if (WARN_ON(fwspec->param_count < 2))
+		return -EINVAL;
+	*out_hwirq = fwspec->param[0];
+	*out_type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(irq_domain_translate_twocell);
+
 int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
 			   int node, const struct irq_affinity_desc *affinity)
 {
-- 
2.17.2

