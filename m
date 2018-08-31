Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346AEC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4E720839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4E720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeHaSPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:15:37 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:1977 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727447AbeHaSPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:15:37 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 31 Aug 2018 23:07:56 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id 8EA3F845D6;
        Fri, 31 Aug 2018 23:07:56 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,311,1531753200"; 
   d="scan'208";a="291197101"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 31 Aug 2018 23:07:53 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v5 2/2] clk: Add functions to get optional clocks
Date:   Fri, 31 Aug 2018 15:07:23 +0100
Message-Id: <1535724443-21150-3-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535724443-21150-1-git-send-email-phil.edworthy@renesas.com>
References: <1535724443-21150-1-git-send-email-phil.edworthy@renesas.com>
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
v5:
 - No changes.
v4:
 - No changes.
v3:
 - No changes.
---
 drivers/clk/clk-devres.c | 18 ++++++++++++++++--
 drivers/clk/clkdev.c     | 17 +++++++++++++++--
 include/linux/clk.h      | 29 +++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index d854e26..a2bb01a 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -14,7 +14,7 @@ static void devm_clk_release(struct device *dev, void *res)
 	clk_put(*(struct clk **)res);
 }
 
-struct clk *devm_clk_get(struct device *dev, const char *id)
+static struct clk *__devm_clk_get(struct device *dev, const char *id, bool optional)
 {
 	struct clk **ptr, *clk;
 
@@ -22,7 +22,10 @@ struct clk *devm_clk_get(struct device *dev, const char *id)
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	clk = clk_get(dev, id);
+	if (!optional)
+		clk = clk_get(dev, id);
+	else
+		clk = clk_get_optional(dev, id);
 	if (!IS_ERR(clk)) {
 		*ptr = clk;
 		devres_add(dev, ptr);
@@ -32,8 +35,19 @@ struct clk *devm_clk_get(struct device *dev, const char *id)
 
 	return clk;
 }
+
+struct clk *devm_clk_get(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, false);
+}
 EXPORT_SYMBOL(devm_clk_get);
 
+struct clk *devm_clk_get_optional(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, true);
+}
+EXPORT_SYMBOL(devm_clk_get_optional);
+
 struct clk_bulk_devres {
 	struct clk_bulk_data *clks;
 	int num_clks;
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 4adb99e..6355573 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -222,21 +222,34 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 }
 EXPORT_SYMBOL(clk_get_sys);
 
-struct clk *clk_get(struct device *dev, const char *con_id)
+static struct clk *internal_clk_get(struct device *dev, const char *con_id,
+				    bool optional)
 {
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct clk *clk;
 
 	if (dev && dev->of_node) {
-		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id, false);
+		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id,
+					   optional);
 		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
 			return clk;
 	}
 
 	return clk_get_sys(dev_id, con_id);
 }
+
+struct clk *clk_get(struct device *dev, const char *con_id)
+{
+	return internal_clk_get(dev, con_id, false);
+}
 EXPORT_SYMBOL(clk_get);
 
+struct clk *clk_get_optional(struct device *dev, const char *con_id)
+{
+	return internal_clk_get(dev, con_id, true);
+}
+EXPORT_SYMBOL(clk_get_optional);
+
 void clk_put(struct clk *clk)
 {
 	__clk_put(clk);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index de0e5e0..58ec7bc 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -291,6 +291,16 @@ static inline void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks)
 struct clk *clk_get(struct device *dev, const char *id);
 
 /**
+ * clk_get_optional - lookup and obtain a reference to optional clock producer.
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
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
@@ -349,6 +359,14 @@ int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
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
@@ -636,6 +654,11 @@ static inline struct clk *clk_get(struct device *dev, const char *id)
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
@@ -647,6 +670,12 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
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

