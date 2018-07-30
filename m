Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF276FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6285520870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6285520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbeG3PHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:07:08 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:9407 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730125AbeG3PHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:07:08 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 30 Jul 2018 22:32:05 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id 9394E8810E;
        Mon, 30 Jul 2018 22:32:05 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,422,1526310000"; 
   d="scan'208";a="288321374"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 30 Jul 2018 22:32:02 +0900
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
Subject: [PATCH v3 1/2] clk: Add of_clk_get_by_name_optional() function
Date:   Mon, 30 Jul 2018 14:31:48 +0100
Message-Id: <1532957509-14541-2-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532957509-14541-1-git-send-email-phil.edworthy@renesas.com>
References: <1532957509-14541-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quite a few drivers get an optional clock, e.g. a clock required
to access peripheral's registers that is always enabled on some
devices.

This function behaves the same as of_clk_get_by_name() except that
it will return NULL instead of -EINVAL.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v3:
 - Fix check for clock not present. __of_clk_get() returns -EINVAL
   if it's not there. Cover case of when there is no clock name.
 - of_clk_get_by_name_optional() should return NULL if !np.
 - Add dummy version of of_clk_get_by_name_optional() for the
   !OF || !COMMON_CLK case.
---
 drivers/clk/clkdev.c | 36 ++++++++++++++++++++++++++++++++----
 include/linux/clk.h  |  6 ++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8..a710333 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -54,7 +54,8 @@ EXPORT_SYMBOL(of_clk_get);
 
 static struct clk *__of_clk_get_by_name(struct device_node *np,
 					const char *dev_id,
-					const char *name)
+					const char *name,
+					bool optional)
 {
 	struct clk *clk = ERR_PTR(-ENOENT);
 
@@ -70,6 +71,11 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
 		if (name)
 			index = of_property_match_string(np, "clock-names", name);
 		clk = __of_clk_get(np, index, dev_id, name);
+		if (optional && PTR_ERR(clk) == -EINVAL) {
+			clk = NULL;
+			pr_info("optional clock is not present %pOF:%s\n", np,
+				name ? name : "");
+		}
 		if (!IS_ERR(clk)) {
 			break;
 		} else if (name && index >= 0) {
@@ -106,15 +112,37 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
 	if (!np)
 		return ERR_PTR(-ENOENT);
 
-	return __of_clk_get_by_name(np, np->full_name, name);
+	return __of_clk_get_by_name(np, np->full_name, name, false);
 }
 EXPORT_SYMBOL(of_clk_get_by_name);
 
+/**
+ * of_clk_get_by_name_optional() - Parse and lookup an optional clock referenced
+ * by a device node
+ * @np: pointer to clock consumer node
+ * @name: name of consumer's clock input, or NULL for the first clock reference
+ *
+ * This function parses the clocks and clock-names properties, and uses them to
+ * look up the struct clk from the registered list of clock providers.
+ * It behaves the same as of_clk_get_by_name(), except when np is NULL or no
+ * clock provider is found, when it then returns NULL.
+ */
+struct clk *of_clk_get_by_name_optional(struct device_node *np,
+					const char *name)
+{
+	if (!np)
+		return NULL;
+
+	return __of_clk_get_by_name(np, np->full_name, name, true);
+}
+EXPORT_SYMBOL(of_clk_get_by_name_optional);
+
 #else /* defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK) */
 
 static struct clk *__of_clk_get_by_name(struct device_node *np,
 					const char *dev_id,
-					const char *name)
+					const char *name,
+					bool optional)
 {
 	return ERR_PTR(-ENOENT);
 }
@@ -197,7 +225,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 	struct clk *clk;
 
 	if (dev && dev->of_node) {
-		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
+		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id, false);
 		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
 			return clk;
 	}
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 4f750c4..de0e5e0 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -777,6 +777,7 @@ static inline void clk_bulk_disable_unprepare(int num_clks,
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
+struct clk *of_clk_get_by_name_optional(struct device_node *np, const char *name);
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
 #else
 static inline struct clk *of_clk_get(struct device_node *np, int index)
@@ -788,6 +789,11 @@ static inline struct clk *of_clk_get_by_name(struct device_node *np,
 {
 	return ERR_PTR(-ENOENT);
 }
+static inline struct clk *of_clk_get_by_name_optional(struct device_node *np,
+						      const char *name)
+{
+	return NULL;
+}
 static inline struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 {
 	return ERR_PTR(-ENOENT);
-- 
2.7.4

