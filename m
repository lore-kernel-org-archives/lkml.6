Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224CCC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C87206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C87206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeKUAoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:44:15 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:10136 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725995AbeKUAoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:44:14 -0500
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Nov 2018 23:14:51 +0900
Received: from vbox.ree.adwin.renesas.com (unknown [10.226.37.67])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 19B3840121CB;
        Tue, 20 Nov 2018 23:14:48 +0900 (JST)
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v8] clk: Add (devm_)clk_get_optional() functions
Date:   Tue, 20 Nov 2018 14:14:45 +0000
Message-Id: <20181120141445.21378-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds clk_get_optional() and devm_clk_get_optional() functions to get
optional clocks.
They behave the same as (devm_)clk_get except where there is no clock
producer. In this case, instead of returning -ENOENT, the function
returns NULL. This makes error checking simpler and allows
clk_prepare_enable, etc to be called on the returned reference
without additional checks.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v8:
 - Remove else clause
v7:
 - Instead of messing with the core functions, simply wrap them for the
   _optional() versions. By putting clk_get_optional() inline in the header
   file, we can get rid of the arch specific patches as well.
v6:
 - Add doxygen style comment for devm_clk_get_optional() args
v5:
 - No changes.
v4:
 - No changes.
v3:
 - No changes.
---
 drivers/clk/clk-devres.c | 11 +++++++++++
 include/linux/clk.h      | 27 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 12c87457eca1..c6f4a1a92c5f 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -34,6 +34,17 @@ struct clk *devm_clk_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL(devm_clk_get);
 
+struct clk *devm_clk_get_optional(struct device *dev, const char *id)
+{
+	struct clk *clk = devm_clk_get(dev, id);
+
+	if (clk == ERR_PTR(-ENOENT))
+		clk = NULL;
+
+	return clk;
+}
+EXPORT_SYMBOL(devm_clk_get_optional);
+
 struct clk_bulk_devres {
 	struct clk_bulk_data *clks;
 	int num_clks;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index a7773b5c0b9f..3ea3c78f62dd 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -383,6 +383,17 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
  */
 struct clk *devm_clk_get(struct device *dev, const char *id);
 
+/**
+ * devm_clk_get_optional - lookup and obtain a managed reference to an optional
+ *			   clock producer.
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Behaves the same as devm_clk_get except where there is no clock producer. In
+ * this case, instead of returning -ENOENT, the function returns NULL.
+ */
+struct clk *devm_clk_get_optional(struct device *dev, const char *id);
+
 /**
  * devm_get_clk_from_child - lookup and obtain a managed reference to a
  *			     clock producer from child node.
@@ -718,6 +729,12 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
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
@@ -862,6 +879,16 @@ static inline void clk_bulk_disable_unprepare(int num_clks,
 	clk_bulk_unprepare(num_clks, clks);
 }
 
+static inline struct clk *clk_get_optional(struct device *dev, const char *id)
+{
+	struct clk *clk = clk_get(dev, id);
+
+	if (clk == ERR_PTR(-ENOENT))
+		clk = NULL;
+
+	return clk;
+}
+
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
-- 
2.17.1

