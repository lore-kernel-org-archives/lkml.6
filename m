Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE5EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59DD20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59DD20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbeGRNfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:35:34 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:46209 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726258AbeGRNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:35:34 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie3.idc.renesas.com with ESMTP; 18 Jul 2018 21:57:43 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id AC42D6D359;
        Wed, 18 Jul 2018 21:57:43 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,370,1526310000"; 
   d="scan'208";a="287219760"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 18 Jul 2018 21:57:40 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] clk: Add functions to get optional clocks
Date:   Wed, 18 Jul 2018 13:57:38 +0100
Message-Id: <1531918658-32278-1-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Behaves the same as (devm_)clk_get except where there is no clock
producer. In this case, instead of returning -ENOENT, the function
returns NULL. This makes error checking simpler and allows
clk_prepare_enable, etc to be called on the returned reference
without additional checks.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/clk/clk-devres.c | 11 +++++++++++
 drivers/clk/clkdev.c     | 11 +++++++++++
 include/linux/clk.h      | 27 +++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index d854e26..63295d9 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -34,6 +34,17 @@ struct clk *devm_clk_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL(devm_clk_get);
 
+struct clk *devm_clk_get_optional(struct device *dev, const char *id)
+{
+	struct clk *c = devm_clk_get(dev, id);
+
+	if (PTR_ERR(c) == -ENOENT)
+		return NULL;
+
+	return c;
+}
+EXPORT_SYMBOL(devm_clk_get_optional);
+
 struct clk_bulk_devres {
 	struct clk_bulk_data *clks;
 	int num_clks;
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 7513411..7f2cd1e 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -209,6 +209,17 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 }
 EXPORT_SYMBOL(clk_get);
 
+struct clk *clk_get_optional(struct device *dev, const char *id)
+{
+	struct clk *c = clk_get(dev, id);
+
+	if (PTR_ERR(c) == -ENOENT)
+		return NULL;
+
+	return c;
+}
+EXPORT_SYMBOL(clk_get_optional);
+
 void clk_put(struct clk *clk)
 {
 	__clk_put(clk);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0dbd088..907202b 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -258,6 +258,14 @@ static inline void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks)
 struct clk *clk_get(struct device *dev, const char *id);
 
 /**
+ * clk_get_optional - lookup and obtain a reference to optional clock producer.
+ *
+ * Behaves the same as clk_get except where there is no clock producer. In this
+ * case, instead of returning -ENOENT, the function returns NULL.
+ */
+struct clk *clk_get_optional(struct device *dev, const char *id);
+
+/**
  * clk_bulk_get - lookup and obtain a number of references to clock producer.
  * @dev: device for clock "consumer"
  * @num_clks: the number of clk_bulk_data
@@ -316,6 +324,14 @@ int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 struct clk *devm_clk_get(struct device *dev, const char *id);
 
 /**
+ * devm_clk_get_optional - lookup and obtain a managed reference to an optional
+ *			   clock producer.
+ * Behaves the same as devm_clk_get except where there is no clock producer. In
+ * this case, instead of returning -ENOENT, the function returns NULL.
+ */
+struct clk *devm_clk_get_optional(struct device *dev, const char *id);
+
+/**
  * devm_get_clk_from_child - lookup and obtain a managed reference to a
  *			     clock producer from child node.
  * @dev: device for clock "consumer"
@@ -603,6 +619,11 @@ static inline struct clk *clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
+static inline struct clk *clk_get_optional(struct device *dev, const char *id)
+{
+	return NULL;
+}
+
 static inline int __must_check clk_bulk_get(struct device *dev, int num_clks,
 					    struct clk_bulk_data *clks)
 {
@@ -614,6 +635,12 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
+static inline struct clk *devm_clk_get_optional(struct device *dev,
+						const char *id)
+{
+	return NULL;
+}
+
 static inline int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 						 struct clk_bulk_data *clks)
 {
-- 
2.7.4

