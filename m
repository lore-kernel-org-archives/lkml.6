Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13A5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D9C2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548742254;
	bh=M+W9UixXghcZ2tQo1f3291ReSl8cVMi29InxnarTtdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ooGm5afXnqyEpCQhZRXFfMfp/zduKdSW3NBB26Eol19kXwxghCYxCCWIRF7CbqnFs
	 9jy21aMVJZhIkPWjVzs8SKdfGe4TqTbU5MV4tG8Twrxyft7dbDDMLmnuE787lOYESC
	 5kzUsiNU1kW4L9nK8xey7HO2VHx4DnXYvE/MRqsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfA2GKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:10:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfA2GK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:10:26 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ED102184D;
        Tue, 29 Jan 2019 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548742224;
        bh=M+W9UixXghcZ2tQo1f3291ReSl8cVMi29InxnarTtdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otJTGT/9KbicncNoFfTcIJPsST9iDaNbuERW4fqLWz/bpD/WTuOJokbmivJaoCBNm
         JrWXJ3qYazdCA9ETdJBQmJHtEWLxSPtZsnJ8XydL+JYLNQ+55LbaWbxYdLX2ona6ko
         +l+d+sFLEX4dLKkW4Q8/vtDRac06nudsDwC7fcQE=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 5/9] clk: Inform the core about consumer devices
Date:   Mon, 28 Jan 2019 22:10:17 -0800
Message-Id: <20190129061021.94775-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129061021.94775-1-sboyd@kernel.org>
References: <20190129061021.94775-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'd like to have a pointer to the device that's consuming a particular
clk in the clk framework so we can link the consumer to the clk provider
with a PM device link. Add a device argument to clk_hw_create_clk() for
this so it can be used in subsequent patches to add and remove the link.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c    |  7 +++++--
 drivers/clk/clk.h    |  7 +++++--
 drivers/clk/clkdev.c | 16 +++++++++++-----
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d4c4cab42375..73f8a287bf42 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -85,6 +85,7 @@ struct clk_core {
 
 struct clk {
 	struct clk_core	*core;
+	struct device *dev;
 	const char *dev_id;
 	const char *con_id;
 	unsigned long min_rate;
@@ -3323,6 +3324,7 @@ static void free_clk(struct clk *clk)
 /**
  * clk_hw_create_clk: Allocate and link a clk consumer to a clk_core given
  * a clk_hw
+ * @dev: clk consumer device
  * @hw: clk_hw associated with the clk being consumed
  * @dev_id: string describing device name
  * @con_id: connection ID string on device
@@ -3331,7 +3333,7 @@ static void free_clk(struct clk *clk)
  * consumers. It connects a consumer to the clk_core and clk_hw structures
  * used by the framework and clk provider respectively.
  */
-struct clk *clk_hw_create_clk(struct clk_hw *hw,
+struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
 			      const char *dev_id, const char *con_id)
 {
 	struct clk *clk;
@@ -3345,6 +3347,7 @@ struct clk *clk_hw_create_clk(struct clk_hw *hw,
 	clk = alloc_clk(core, dev_id, con_id);
 	if (IS_ERR(clk))
 		return clk;
+	clk->dev = dev;
 
 	if (!try_module_get(core->owner)) {
 		free_clk(clk);
@@ -4161,7 +4164,7 @@ struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 {
 	struct clk_hw *hw = of_clk_get_hw_from_clkspec(clkspec);
 
-	return clk_hw_create_clk(hw, NULL, __func__);
+	return clk_hw_create_clk(NULL, hw, NULL, __func__);
 }
 EXPORT_SYMBOL_GPL(of_clk_get_from_provider);
 
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index cdac6dfa8094..fda0ad483416 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -10,6 +10,8 @@
  */
 
 struct clk_hw;
+struct device;
+struct of_phandle_args;
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 int of_parse_clkspec(const struct device_node *np, int index, const char *name,
@@ -18,13 +20,14 @@ struct clk_hw *of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec);
 #endif
 
 #ifdef CONFIG_COMMON_CLK
-struct clk *clk_hw_create_clk(struct clk_hw *hw,
+struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
 			      const char *dev_id, const char *con_id);
 void __clk_put(struct clk *clk);
 #else
 /* All these casts to avoid ifdefs in clkdev... */
 static inline struct clk *
-clk_hw_create_clk(struct clk_hw *hw, const char *dev_id, const char *con_id)
+clk_hw_create_clk(struct device *dev, struct clk_hw *hw, const char *dev_id,
+		  const char *con_id)
 {
 	return (struct clk *)hw;
 }
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 5ebb2119c0b9..f2f4f2afd28c 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -51,7 +51,7 @@ static struct clk *__of_clk_get(struct device_node *np,
 {
 	struct clk_hw *hw = of_clk_get_hw(np, index, con_id);
 
-	return clk_hw_create_clk(hw, dev_id, con_id);
+	return clk_hw_create_clk(NULL, hw, dev_id, con_id);
 }
 
 struct clk *of_clk_get(struct device_node *np, int index)
@@ -130,7 +130,8 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 	return cl;
 }
 
-struct clk *clk_get_sys(const char *dev_id, const char *con_id)
+static struct clk *__clk_get_sys(struct device *dev, const char *dev_id,
+				 const char *con_id)
 {
 	struct clk_lookup *cl;
 	struct clk *clk = NULL;
@@ -141,7 +142,7 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 	if (!cl)
 		goto out;
 
-	clk = clk_hw_create_clk(cl->clk_hw, dev_id, con_id);
+	clk = clk_hw_create_clk(dev, cl->clk_hw, dev_id, con_id);
 	if (IS_ERR(clk))
 		cl = NULL;
 out:
@@ -149,6 +150,11 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 
 	return cl ? clk : ERR_PTR(-ENOENT);
 }
+
+struct clk *clk_get_sys(const char *dev_id, const char *con_id)
+{
+	return __clk_get_sys(NULL, dev_id, con_id);
+}
 EXPORT_SYMBOL(clk_get_sys);
 
 struct clk *clk_get(struct device *dev, const char *con_id)
@@ -159,10 +165,10 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 	if (dev && dev->of_node) {
 		hw = of_clk_get_hw(dev->of_node, 0, con_id);
 		if (!IS_ERR(hw) || PTR_ERR(hw) == -EPROBE_DEFER)
-			return clk_hw_create_clk(hw, dev_id, con_id);
+			return clk_hw_create_clk(dev, hw, dev_id, con_id);
 	}
 
-	return clk_get_sys(dev_id, con_id);
+	return __clk_get_sys(dev, dev_id, con_id);
 }
 EXPORT_SYMBOL(clk_get);
 
-- 
Sent by a computer through tubes

