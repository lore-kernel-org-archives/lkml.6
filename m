Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C44EECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3379206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3379206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbeGQXDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:03:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59097 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731438AbeGQXDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:03:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 487CE208FB; Wed, 18 Jul 2018 00:28:27 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id D97C4208FF;
        Wed, 18 Jul 2018 00:28:08 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 09/16] clk: at91: add new DT lookup function
Date:   Wed, 18 Jul 2018 00:27:50 +0200
Message-Id: <20180717222757.10253-10-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new DT lookup function to lookup for PMC clocks.

Note that the #ifndef AT91_PMC_MOSCS section will be removed once all the
platforms are converted.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/pmc.c           | 34 ++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/at91.h | 14 +++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 0f8b3add1b04..f5697092ec52 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -19,6 +19,8 @@
 
 #include <asm/proc-fns.h>
 
+#include <dt-bindings/clock/at91.h>
+
 #include "pmc.h"
 
 #define PMC_MAX_IDS 128
@@ -47,6 +49,38 @@ int of_at91_get_clk_range(struct device_node *np, const char *propname,
 }
 EXPORT_SYMBOL_GPL(of_at91_get_clk_range);
 
+struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args *clkspec, void *data)
+{
+	unsigned int type = clkspec->args[0];
+	unsigned int idx = clkspec->args[1];
+	struct pmc_data *pmc_data = data;
+
+	switch (type) {
+	case PMC_TYPE_CORE:
+		if (idx >= pmc_data->ncore)
+			return ERR_PTR(-EINVAL);
+		return pmc_data->chws[idx];
+	case PMC_TYPE_SYSTEM:
+		if (idx >= pmc_data->nsystem)
+			return ERR_PTR(-EINVAL);
+		return pmc_data->shws[idx];
+	case PMC_TYPE_PERIPHERAL:
+		if (idx >= pmc_data->nperiph)
+			return ERR_PTR(-EINVAL);
+		return pmc_data->phws[idx];
+	case PMC_TYPE_GCK:
+		if (idx >= pmc_data->ngck)
+			return ERR_PTR(-EINVAL);
+		return pmc_data->ghws[idx];
+	default:
+		break;
+	}
+
+	pr_err("%s: invalid type (%u) or index (%u)\n", __func__, type, idx);
+
+	return ERR_PTR(-EINVAL);
+}
+
 void pmc_data_free(struct pmc_data *pmc_data)
 {
 	kfree(pmc_data->chws);
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index ab3ee241d10c..c007adcb5512 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -9,6 +9,19 @@
 #ifndef _DT_BINDINGS_CLK_AT91_H
 #define _DT_BINDINGS_CLK_AT91_H
 
+#define PMC_TYPE_CORE		0
+#define PMC_TYPE_SYSTEM		1
+#define PMC_TYPE_PERIPHERAL	2
+#define PMC_TYPE_GCK		3
+
+#define PMC_MCK			0
+#define PMC_UTMI		1
+#define PMC_MCK2		2
+#define PMC_MAIN		3
+#define PMC_I2S0_MUX		4
+#define PMC_I2S1_MUX		5
+
+#ifndef AT91_PMC_MOSCS
 #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
 #define AT91_PMC_LOCKA		1		/* PLLA Lock */
 #define AT91_PMC_LOCKB		2		/* PLLB Lock */
@@ -19,5 +32,6 @@
 #define AT91_PMC_MOSCRCS	17		/* Main On-Chip RC */
 #define AT91_PMC_CFDEV		18		/* Clock Failure Detector Event */
 #define AT91_PMC_GCKRDY		24		/* Generated Clocks */
+#endif
 
 #endif
-- 
2.18.0

