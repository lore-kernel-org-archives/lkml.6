Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9120BFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5326D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5326D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeG3KK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:10:26 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:57931 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726520AbeG3KK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:10:26 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie2.idc.renesas.com with ESMTP; 30 Jul 2018 17:36:31 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id BD09784630;
        Mon, 30 Jul 2018 17:36:28 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,422,1526310000"; 
   d="scan'208";a="288300616"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 30 Jul 2018 17:36:25 +0900
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
Subject: [PATCH v2 1/2] clk: Add of_clk_get_by_name_optional() function
Date:   Mon, 30 Jul 2018 09:36:07 +0100
Message-Id: <1532939768-7018-2-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532939768-7018-1-git-send-email-phil.edworthy@renesas.com>
References: <1532939768-7018-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quite a few drivers get an optional clock, e.g. a clock required
to access peripheral's registers that is always enabled on some
devices.

This function behaves the same as of_clk_get_by_name() except that
it will return NULL instead of -ENOENT. This makes error checking
for users easier and allows clk_prepare_enable, etc to be called
on the returned reference without additional checks.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/clk/clkdev.c | 34 ++++++++++++++++++++++++++++++----
 include/linux/clk.h  |  1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8..c1b7262 100644
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
 
@@ -73,6 +74,8 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
 		if (!IS_ERR(clk)) {
 			break;
 		} else if (name && index >= 0) {
+			if (optional && PTR_ERR(clk) == -ENOENT)
+				clk = NULL;
 			if (PTR_ERR(clk) != -EPROBE_DEFER)
 				pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
 					np, name ? name : "", index);
@@ -106,15 +109,38 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
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
+ * This function parses the clocks and clock-names properties,
+ * and uses them to look up the struct clk from the registered list of clock
+ * providers.
+ * It behaves the same as of_clk_get_by_name(), except when no clock is found.
+ * In this case, instead of returning -ENOENT, it returns NULL.
+ */
+struct clk *of_clk_get_by_name_optional(struct device_node *np,
+					const char *name)
+{
+	if (!np)
+		return ERR_PTR(-ENOENT);
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
@@ -197,7 +223,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 	struct clk *clk;
 
 	if (dev && dev->of_node) {
-		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
+		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id, false);
 		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
 			return clk;
 	}
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 4f750c4..8cb5455 100644
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
-- 
2.7.4

