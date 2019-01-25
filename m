Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00551C282C9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49242133D
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Z6knZV/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfAYQXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:23:13 -0500
Received: from onstation.org ([52.200.56.107]:54998 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfAYQXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:23:09 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id AF040312;
        Fri, 25 Jan 2019 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1548433389;
        bh=QRHpER0IAqYyxZzQqcsKlyRMmcnYoLg+de32uGRq4mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6knZV/I4cV7L81xyvrfZYZkCT53ieMtcDh27KlXRwUaMocFx7Q/Zqos2aiTIcAIt
         fYHvJZf/liGsawlxNolxlgNZAnaRZ5I+Izbflmr3x9JKuwDAUz+Q5J8bysyyT8pnGu
         FnB9HGoVCK2FwsPOUfQIcu2f7J5PpItxWpfi18OQ=
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
Subject: [PATCH 2/9] genirq: introduce irq_domain_translate_twocell
Date:   Fri, 25 Jan 2019 11:22:55 -0500
Message-Id: <20190125162302.14036-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190125162302.14036-1-masneyb@onstation.org>
References: <20190125162302.14036-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function irq_domain_translate_twocell() that is to be used as
the translate function in struct irq_domain_ops for v2 IRQ interfaces.
This is based on irq_domain_xlate_twocell().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 include/linux/irqdomain.h |  5 +++++
 kernel/irq/irqdomain.c    | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

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
index 8b0be4bd6565..15c2a291aa3c 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -968,6 +968,27 @@ const struct irq_domain_ops irq_domain_simple_ops = {
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

