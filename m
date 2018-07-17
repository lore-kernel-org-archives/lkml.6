Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D95ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85853206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85853206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbeGQXDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:03:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59089 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731429AbeGQXDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:03:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EB75D20884; Wed, 18 Jul 2018 00:28:26 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 53502208C4;
        Wed, 18 Jul 2018 00:28:08 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 07/16] clk: at91: add pmc_data struct and helpers
Date:   Wed, 18 Jul 2018 00:27:48 +0200
Message-Id: <20180717222757.10253-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new strut to handle references to all the PMC clocks and implement
allocation/free helpers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/pmc.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/at91/pmc.h | 15 ++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 1fa27f4ea538..0f8b3add1b04 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -47,6 +47,50 @@ int of_at91_get_clk_range(struct device_node *np, const char *propname,
 }
 EXPORT_SYMBOL_GPL(of_at91_get_clk_range);
 
+void pmc_data_free(struct pmc_data *pmc_data)
+{
+	kfree(pmc_data->chws);
+	kfree(pmc_data->shws);
+	kfree(pmc_data->phws);
+	kfree(pmc_data->ghws);
+}
+
+struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
+				   unsigned int nperiph, unsigned int ngck)
+{
+	struct pmc_data *pmc_data = kzalloc(sizeof(*pmc_data), GFP_KERNEL);
+
+	if (!pmc_data)
+		return NULL;
+
+	pmc_data->ncore = ncore;
+	pmc_data->chws = kcalloc(ncore, sizeof(struct clk_hw *), GFP_KERNEL);
+	if (!pmc_data->chws)
+		goto err;
+
+	pmc_data->nsystem = nsystem;
+	pmc_data->shws = kcalloc(nsystem, sizeof(struct clk_hw *), GFP_KERNEL);
+	if (!pmc_data->shws)
+		goto err;
+
+	pmc_data->nperiph = nperiph;
+	pmc_data->phws = kcalloc(nperiph, sizeof(struct clk_hw *), GFP_KERNEL);
+	if (!pmc_data->phws)
+		goto err;
+
+	pmc_data->ngck = ngck;
+	pmc_data->ghws = kcalloc(ngck, sizeof(struct clk_hw *), GFP_KERNEL);
+	if (!pmc_data->ghws)
+		goto err;
+
+	return pmc_data;
+
+err:
+	pmc_data_free(pmc_data);
+
+	return NULL;
+}
+
 #ifdef CONFIG_PM
 static struct regmap *pmcreg;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 3dc50267a458..fa4fd3fc7c32 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -19,6 +19,17 @@
 
 extern spinlock_t pmc_pcr_lock;
 
+struct pmc_data {
+	unsigned int ncore;
+	struct clk_hw **chws;
+	unsigned int nsystem;
+	struct clk_hw **shws;
+	unsigned int nperiph;
+	struct clk_hw **phws;
+	unsigned int ngck;
+	struct clk_hw **ghws;
+};
+
 struct clk_range {
 	unsigned long min;
 	unsigned long max;
@@ -69,6 +80,10 @@ extern const struct clk_programmable_layout at91rm9200_programmable_layout;
 extern const struct clk_programmable_layout at91sam9g45_programmable_layout;
 extern const struct clk_programmable_layout at91sam9x5_programmable_layout;
 
+struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
+				   unsigned int nperiph, unsigned int ngck);
+void pmc_data_free(struct pmc_data *pmc_data);
+
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range);
 
-- 
2.18.0

