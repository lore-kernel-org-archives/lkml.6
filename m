Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD9CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8B42077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8B42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeHaSPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:15:24 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:9081 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727681AbeHaSPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:15:23 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie3.idc.renesas.com with ESMTP; 31 Aug 2018 23:07:42 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 1045E78C8C;
        Fri, 31 Aug 2018 23:07:42 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,311,1531753200"; 
   d="scan'208";a="291197095"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 31 Aug 2018 23:07:39 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v5 1/2] clk: Add of_clk_get_by_name_optional() function
Date:   Fri, 31 Aug 2018 15:07:22 +0100
Message-Id: <1535724443-21150-2-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535724443-21150-1-git-send-email-phil.edworthy@renesas.com>
References: <1535724443-21150-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quite a few drivers get an optional clock, e.g. a clock required
to access peripheral's registers that is always enabled on some
devices.

This function behaves the same as of_clk_get_by_name() except that
it will return NULL instead of -ENOENT.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v5:
 - Simplified the code by handling all the error conditions on exit
v4:
 - For optional named clocks of_property_match_string() will return
   -EINVAL if the "clock-names" property is missing, or -ENODATA if
   the specified clock name in the "clock-names" property is missing.
   If we then call __of_clk_get() with these errors as the index, we
   get clk = -EINVAL. This is then filtered later on so users don't
   see it. However, if the clock is not named, __of_clk_get() will
   return -ENOENT is the clock provide is not there.
   So for optional named clocks, use index to determine if the clock
   provider is there or not, and for unnamed clocks, simply check if
   __of_clk_get() returns -ENOENT.

v3:
 - Fix check for clock not present. __of_clk_get() returns -EINVAL
   if it's not there. Cover case of when there is no clock name.
 - of_clk_get_by_name_optional() should return NULL if !np.
 - Add dummy version of of_clk_get_by_name_optional() for the
   !OF || !COMMON_CLK case.
---
 drivers/clk/clkdev.c | 59 +++++++++++++++++++++++++++++++++++++++-------------
 include/linux/clk.h  |  6 ++++++
 2 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8..4adb99e 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -54,30 +54,29 @@ EXPORT_SYMBOL(of_clk_get);
 
 static struct clk *__of_clk_get_by_name(struct device_node *np,
 					const char *dev_id,
-					const char *name)
+					const char *name,
+					bool optional)
 {
 	struct clk *clk = ERR_PTR(-ENOENT);
+	struct device_node *child = np;
+	int index = 0;
 
 	/* Walk up the tree of devices looking for a clock that matches */
 	while (np) {
-		int index = 0;
 
 		/*
 		 * For named clocks, first look up the name in the
 		 * "clock-names" property.  If it cannot be found, then
-		 * index will be an error code, and of_clk_get() will fail.
+		 * index will be an error code.
 		 */
 		if (name)
 			index = of_property_match_string(np, "clock-names", name);
-		clk = __of_clk_get(np, index, dev_id, name);
-		if (!IS_ERR(clk)) {
-			break;
-		} else if (name && index >= 0) {
-			if (PTR_ERR(clk) != -EPROBE_DEFER)
-				pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
-					np, name ? name : "", index);
+		if (index >= 0)
+			clk = __of_clk_get(np, index, dev_id, name);
+		if (!IS_ERR(clk))
 			return clk;
-		}
+		if (name && index >= 0)
+			break;
 
 		/*
 		 * No matching clock found on this node.  If the parent node
@@ -89,6 +88,16 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
 			break;
 	}
 
+	/* The clock is not valid, but it could be optional or deferred */
+	if (optional && PTR_ERR(clk) == -ENOENT) {
+		clk = NULL;
+		pr_info("no optional clock %pOF:%s\n", child,
+			name ? name : "");
+	} else if (name && index >= 0 && PTR_ERR(clk) != -EPROBE_DEFER) {
+		pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
+			child, name, index);
+	}
+
 	return clk;
 }
 
@@ -106,15 +115,37 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
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
@@ -197,7 +228,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
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

