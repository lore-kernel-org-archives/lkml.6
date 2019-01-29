Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC3EC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B12C2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548742236;
	bh=lqLBOdLs/K2ek01660gtvK/N+IUXOeXI9jrcvENBlWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ioRRLThIoIAPkNUIceNp65pHcbSRjzUoGCMqo620/HZi9N11lhYPERGcOgT4PqGqd
	 Mx7IwaYqzRrbeUjsn4rk5Fk8hoHFK7i60KLOuuZE8TYUN5lZ00TLToCOo1DWualXWD
	 l9TZ+7TNjKnHuxEQjEgSfMDUAI/+DzJntQ2d7XmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfA2GK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:10:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbfA2GK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:10:26 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A847921852;
        Tue, 29 Jan 2019 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548742224;
        bh=lqLBOdLs/K2ek01660gtvK/N+IUXOeXI9jrcvENBlWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chkEP6cppO4jcoYJRpIBRwEPEaqQfaGd2idjH2On/oB7oxgRCVcbTMnfSWQVbsNA6
         z8p+0MM6Km1b2dwN2svWuMhXWQvGTGUwcC2bHP/ZhJcPBABJEwV2gMybJ6/08aMYAt
         /sMBeBBtCvU2vQZtlpaVNKQPK7islN9FscGSRh9Y=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 6/9] clk: Move of_clk_*() APIs into clk.c from clkdev.c
Date:   Mon, 28 Jan 2019 22:10:18 -0800
Message-Id: <20190129061021.94775-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129061021.94775-1-sboyd@kernel.org>
References: <20190129061021.94775-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The API between clk.c and clkdev.c is purely getting the clk_hw
structure (or the struct clk if it's not CCF) and then turning that
struct clk_hw pointer into a struct clk pointer via clk_hw_create_clk().
There's no need to complicate clkdev.c with these DT parsing details
that are only relevant to the common clk framework. Move the DT parsing
logic into the core framework and just expose the APIs to get a clk_hw
pointer and convert it.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c    | 57 ++++++++++++++++++++++++++++++++++++++---
 drivers/clk/clk.h    | 11 +++++---
 drivers/clk/clkdev.c | 60 --------------------------------------------
 3 files changed, 62 insertions(+), 66 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 73f8a287bf42..202902e64799 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4080,8 +4080,8 @@ void devm_of_clk_del_provider(struct device *dev)
 }
 EXPORT_SYMBOL(devm_of_clk_del_provider);
 
-int of_parse_clkspec(const struct device_node *np, int index, const char *name,
-		     struct of_phandle_args *out_args)
+static int of_parse_clkspec(const struct device_node *np, int index,
+			    const char *name, struct of_phandle_args *out_args)
 {
 	int ret = -ENOENT;
 
@@ -4131,7 +4131,8 @@ __of_clk_get_hw_from_provider(struct of_clk_provider *provider,
 	return __clk_get_hw(clk);
 }
 
-struct clk_hw *of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
+static struct clk_hw *
+of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
 {
 	struct of_clk_provider *provider;
 	struct clk_hw *hw = ERR_PTR(-EPROBE_DEFER);
@@ -4168,6 +4169,56 @@ struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 }
 EXPORT_SYMBOL_GPL(of_clk_get_from_provider);
 
+struct clk_hw *of_clk_get_hw(struct device_node *np, int index,
+			     const char *con_id)
+{
+	int ret;
+	struct clk_hw *hw;
+	struct of_phandle_args clkspec;
+
+	ret = of_parse_clkspec(np, index, con_id, &clkspec);
+	if (ret)
+		return ERR_PTR(ret);
+
+	hw = of_clk_get_hw_from_clkspec(&clkspec);
+	of_node_put(clkspec.np);
+
+	return hw;
+}
+
+static struct clk *__of_clk_get(struct device_node *np,
+				int index, const char *dev_id,
+				const char *con_id)
+{
+	struct clk_hw *hw = of_clk_get_hw(np, index, con_id);
+
+	return clk_hw_create_clk(NULL, hw, dev_id, con_id);
+}
+
+struct clk *of_clk_get(struct device_node *np, int index)
+{
+	return __of_clk_get(np, index, np->full_name, NULL);
+}
+EXPORT_SYMBOL(of_clk_get);
+
+/**
+ * of_clk_get_by_name() - Parse and lookup a clock referenced by a device node
+ * @np: pointer to clock consumer node
+ * @name: name of consumer's clock input, or NULL for the first clock reference
+ *
+ * This function parses the clocks and clock-names properties,
+ * and uses them to look up the struct clk from the registered list of clock
+ * providers.
+ */
+struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
+{
+	if (!np)
+		return ERR_PTR(-ENOENT);
+
+	return __of_clk_get(np, -1, np->full_name, name);
+}
+EXPORT_SYMBOL(of_clk_get_by_name);
+
 /**
  * of_clk_get_parent_count() - Count the number of clocks a device node has
  * @np: device node to count
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index fda0ad483416..46e668d64da8 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -14,9 +14,14 @@ struct device;
 struct of_phandle_args;
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
-int of_parse_clkspec(const struct device_node *np, int index, const char *name,
-		     struct of_phandle_args *out_args);
-struct clk_hw *of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec);
+struct clk_hw *of_clk_get_hw(struct device_node *np,
+				    int index, const char *con_id);
+#else /* !CONFIG_COMMON_CLK || !CONFIG_OF */
+static inline struct clk_hw *of_clk_get_hw(struct device_node *np,
+				    int index, const char *con_id)
+{
+	return ERR_PTR(-ENOENT);
+}
 #endif
 
 #ifdef CONFIG_COMMON_CLK
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index f2f4f2afd28c..d3758bf4305c 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -27,66 +27,6 @@
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 
-#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
-static struct clk_hw *of_clk_get_hw(struct device_node *np,
-				    int index, const char *con_id)
-{
-	int ret;
-	struct clk_hw *hw;
-	struct of_phandle_args clkspec;
-
-	ret = of_parse_clkspec(np, index, con_id, &clkspec);
-	if (ret)
-		return ERR_PTR(ret);
-
-	hw = of_clk_get_hw_from_clkspec(&clkspec);
-	of_node_put(clkspec.np);
-
-	return hw;
-}
-
-static struct clk *__of_clk_get(struct device_node *np,
-				int index, const char *dev_id,
-				const char *con_id)
-{
-	struct clk_hw *hw = of_clk_get_hw(np, index, con_id);
-
-	return clk_hw_create_clk(NULL, hw, dev_id, con_id);
-}
-
-struct clk *of_clk_get(struct device_node *np, int index)
-{
-	return __of_clk_get(np, index, np->full_name, NULL);
-}
-EXPORT_SYMBOL(of_clk_get);
-
-/**
- * of_clk_get_by_name() - Parse and lookup a clock referenced by a device node
- * @np: pointer to clock consumer node
- * @name: name of consumer's clock input, or NULL for the first clock reference
- *
- * This function parses the clocks and clock-names properties,
- * and uses them to look up the struct clk from the registered list of clock
- * providers.
- */
-struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
-{
-	if (!np)
-		return ERR_PTR(-ENOENT);
-
-	return __of_clk_get(np, -1, np->full_name, name);
-}
-EXPORT_SYMBOL(of_clk_get_by_name);
-
-#else /* defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK) */
-
-static struct clk_hw *of_clk_get_hw(struct device_node *np,
-				    int index, const char *con_id)
-{
-	return ERR_PTR(-ENOENT);
-}
-#endif
-
 /*
  * Find the correct struct clk for the device and connection ID.
  * We do slightly fuzzy matching here:
-- 
Sent by a computer through tubes

