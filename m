Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6520C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CF921873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551220482;
	bh=i5K8ds82P8jDMSn4mpHTSqjSpIRmkq6qgYH1C19FKZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MIcpiyfy6NAV4k1MDO97ROzsGbb21cf7aGqkYeRhPalY8IFQexEjyV1ggzWLRCdQQ
	 sJs5G3lC6kYb0Ah1aBALin6eHB4CAnV8uYKtbTykHsX1E+lSwotbTYkCHmLPkh2HpH
	 ffWVk8sRzyI0pLVuxAaCyc3bb85rWqr5lg+fUJq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfBZWef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:34:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbfBZWed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:34:33 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B932D218A2;
        Tue, 26 Feb 2019 22:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551220472;
        bh=i5K8ds82P8jDMSn4mpHTSqjSpIRmkq6qgYH1C19FKZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wkUTwQ5BDElKpjNh2mVXe3kPESMnmT4gi5StgElzhJ1DxyEdDt0GbgNJm0cu5K8OF
         /DrHEqAJxYHTZleIS9O7n+SLYLv4x9qzFx1++OpTgvXJAUAgC3p8JToO8msl+L+f/z
         jWo4qB2B0m5FZTNGbZCGLR4to9XbMQgouMWTOizc=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 3/8] clk: Introduce of_clk_get_hw_from_clkspec()
Date:   Tue, 26 Feb 2019 14:34:24 -0800
Message-Id: <20190226223429.193873-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <20190226223429.193873-1-sboyd@kernel.org>
References: <20190226223429.193873-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to get struct clk_hw pointers from a DT clk specifier (i.e. a
clocks property) so that we can find parent clks without searching for
globally unique clk names. This should save time by avoiding the global
string search for clks that are external to the clock controller
providing the clk and let us move away from string comparisons in
general.

Introduce of_clk_get_hw_from_clkspec() which is largely the DT parsing
part of finding clks implemented in clkdev.c and have that return a
clk_hw pointer instead of converting that into a clk pointer. This lets
us push up the clk pointer creation to the caller in clk_get() and
avoids the need to push the dev_id and con_id throughout the DT parsing
code.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c    | 46 +++++++++++++++++++++---
 drivers/clk/clk.h    |  5 +--
 drivers/clk/clkdev.c | 83 +++++++++++++-------------------------------
 3 files changed, 69 insertions(+), 65 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d46e8b9b9c9f..04288063847b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4065,6 +4065,42 @@ void devm_of_clk_del_provider(struct device *dev)
 }
 EXPORT_SYMBOL(devm_of_clk_del_provider);
 
+int of_parse_clkspec(const struct device_node *np, int index, const char *name,
+		     struct of_phandle_args *out_args)
+{
+	int ret = -ENOENT;
+
+	/* Walk up the tree of devices looking for a clock property that matches */
+	while (np) {
+		/*
+		 * For named clocks, first look up the name in the
+		 * "clock-names" property.  If it cannot be found, then index
+		 * will be an error code and of_parse_phandle_with_args() will
+		 * return -EINVAL.
+		 */
+		if (name)
+			index = of_property_match_string(np, "clock-names", name);
+		ret = of_parse_phandle_with_args(np, "clocks", "#clock-cells",
+						 index, out_args);
+		if (!ret)
+			break;
+		if (name && index >= 0)
+			break;
+
+		/*
+		 * No matching clock found on this node.  If the parent node
+		 * has a "clock-ranges" property, then we can try one of its
+		 * clocks.
+		 */
+		np = np->parent;
+		if (np && !of_get_property(np, "clock-ranges", NULL))
+			break;
+		index = 0;
+	}
+
+	return ret;
+}
+
 static struct clk_hw *
 __of_clk_get_hw_from_provider(struct of_clk_provider *provider,
 			      struct of_phandle_args *clkspec)
@@ -4080,8 +4116,7 @@ __of_clk_get_hw_from_provider(struct of_clk_provider *provider,
 	return __clk_get_hw(clk);
 }
 
-struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
-				       const char *dev_id, const char *con_id)
+struct clk_hw *of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
 {
 	struct of_clk_provider *provider;
 	struct clk_hw *hw = ERR_PTR(-EPROBE_DEFER);
@@ -4089,7 +4124,6 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 	if (!clkspec)
 		return ERR_PTR(-EINVAL);
 
-	/* Check if we have such a provider in our array */
 	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(provider, &of_clk_providers, link) {
 		if (provider->node == clkspec->np) {
@@ -4100,7 +4134,7 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 	}
 	mutex_unlock(&of_clk_mutex);
 
-	return clk_hw_create_clk(hw, dev_id, con_id);
+	return hw;
 }
 
 /**
@@ -4113,7 +4147,9 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
  */
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 {
-	return __of_clk_get_from_provider(clkspec, NULL, __func__);
+	struct clk_hw *hw = of_clk_get_hw_from_clkspec(clkspec);
+
+	return clk_hw_create_clk(hw, NULL, __func__);
 }
 EXPORT_SYMBOL_GPL(of_clk_get_from_provider);
 
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 4cdf30b0008c..5a0ca0e3c1f1 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -7,8 +7,9 @@
 struct clk_hw;
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
-struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
-				       const char *dev_id, const char *con_id);
+int of_parse_clkspec(const struct device_node *np, int index, const char *name,
+		     struct of_phandle_args *out_args);
+struct clk_hw *of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec);
 #endif
 
 #ifdef CONFIG_COMMON_CLK
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index bdeaffc950ae..5ebb2119c0b9 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -28,69 +28,37 @@ static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
-static struct clk *__of_clk_get(struct device_node *np, int index,
-			       const char *dev_id, const char *con_id)
+static struct clk_hw *of_clk_get_hw(struct device_node *np,
+				    int index, const char *con_id)
 {
+	int ret;
+	struct clk_hw *hw;
 	struct of_phandle_args clkspec;
-	struct clk *clk;
-	int rc;
 
-	rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
-					&clkspec);
-	if (rc)
-		return ERR_PTR(rc);
+	ret = of_parse_clkspec(np, index, con_id, &clkspec);
+	if (ret)
+		return ERR_PTR(ret);
 
-	clk = __of_clk_get_from_provider(&clkspec, dev_id, con_id);
+	hw = of_clk_get_hw_from_clkspec(&clkspec);
 	of_node_put(clkspec.np);
 
-	return clk;
+	return hw;
 }
 
-struct clk *of_clk_get(struct device_node *np, int index)
+static struct clk *__of_clk_get(struct device_node *np,
+				int index, const char *dev_id,
+				const char *con_id)
 {
-	return __of_clk_get(np, index, np->full_name, NULL);
+	struct clk_hw *hw = of_clk_get_hw(np, index, con_id);
+
+	return clk_hw_create_clk(hw, dev_id, con_id);
 }
-EXPORT_SYMBOL(of_clk_get);
 
-static struct clk *__of_clk_get_by_name(struct device_node *np,
-					const char *dev_id,
-					const char *name)
+struct clk *of_clk_get(struct device_node *np, int index)
 {
-	struct clk *clk = ERR_PTR(-ENOENT);
-
-	/* Walk up the tree of devices looking for a clock that matches */
-	while (np) {
-		int index = 0;
-
-		/*
-		 * For named clocks, first look up the name in the
-		 * "clock-names" property.  If it cannot be found, then
-		 * index will be an error code, and of_clk_get() will fail.
-		 */
-		if (name)
-			index = of_property_match_string(np, "clock-names", name);
-		clk = __of_clk_get(np, index, dev_id, name);
-		if (!IS_ERR(clk)) {
-			break;
-		} else if (name && index >= 0) {
-			if (PTR_ERR(clk) != -EPROBE_DEFER)
-				pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
-					np, name ? name : "", index);
-			return clk;
-		}
-
-		/*
-		 * No matching clock found on this node.  If the parent node
-		 * has a "clock-ranges" property, then we can try one of its
-		 * clocks.
-		 */
-		np = np->parent;
-		if (np && !of_get_property(np, "clock-ranges", NULL))
-			break;
-	}
-
-	return clk;
+	return __of_clk_get(np, index, np->full_name, NULL);
 }
+EXPORT_SYMBOL(of_clk_get);
 
 /**
  * of_clk_get_by_name() - Parse and lookup a clock referenced by a device node
@@ -106,15 +74,14 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
 	if (!np)
 		return ERR_PTR(-ENOENT);
 
-	return __of_clk_get_by_name(np, np->full_name, name);
+	return __of_clk_get(np, -1, np->full_name, name);
 }
 EXPORT_SYMBOL(of_clk_get_by_name);
 
 #else /* defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK) */
 
-static struct clk *__of_clk_get_by_name(struct device_node *np,
-					const char *dev_id,
-					const char *name)
+static struct clk_hw *of_clk_get_hw(struct device_node *np,
+				    int index, const char *con_id)
 {
 	return ERR_PTR(-ENOENT);
 }
@@ -187,12 +154,12 @@ EXPORT_SYMBOL(clk_get_sys);
 struct clk *clk_get(struct device *dev, const char *con_id)
 {
 	const char *dev_id = dev ? dev_name(dev) : NULL;
-	struct clk *clk;
+	struct clk_hw *hw;
 
 	if (dev && dev->of_node) {
-		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
-		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
-			return clk;
+		hw = of_clk_get_hw(dev->of_node, 0, con_id);
+		if (!IS_ERR(hw) || PTR_ERR(hw) == -EPROBE_DEFER)
+			return clk_hw_create_clk(hw, dev_id, con_id);
 	}
 
 	return clk_get_sys(dev_id, con_id);
-- 
Sent by a computer through tubes

