Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2285C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7453F218CD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551220507;
	bh=sM9+js7IZRf/8Ngn8rWh/XzWSauHe7ffLH25ayUuXrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h710QZbzGK1HzuilKokC7qccQIfVgVGd763Vu5pI/HZa4VCCBfU+NcD7xMr6t1whj
	 66uhMVP6owfM9wlBnmw5NVBRrLtnPMUv2EqFcyVB2sawvYDvCKeUPoy7fo1J766fPT
	 auHTO1Tkcb1qFS6ZXeJeb+Wq7EIu44uvjlSXAoa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfBZWfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbfBZWec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:34:32 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB5D21874;
        Tue, 26 Feb 2019 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551220471;
        bh=sM9+js7IZRf/8Ngn8rWh/XzWSauHe7ffLH25ayUuXrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tS/Dluldv5tItK/ZCT/aFvsozKFPWoMnj6uC3G/kdEo98dv8QlLt7tSrfNxIWmop+
         7AkfoAHpca4an4vLhJHPiXnq8Ed2GTVZBt2VF9mIRDa4FfngRNvC6qu+LRpPrL71EH
         k0EQgBIZ6rmawbEC3nVsPoSrTdBIp8A1G00Ef+0o=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 1/8] clk: Combine __clk_get() and __clk_create_clk()
Date:   Tue, 26 Feb 2019 14:34:22 -0800
Message-Id: <20190226223429.193873-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <20190226223429.193873-1-sboyd@kernel.org>
References: <20190226223429.193873-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __clk_get() function is practically a private clk implementation
detail now. No architecture defines it, and given that new code should
be using the common clk framework there isn't a need for it to keep
existing just to serve clkdev purposes. Let's fold it into the
__clk_create_clk() function and make that a little more generic by
renaming it to clk_hw_create_clk(). This will allow the framework to
create a struct clk handle to a particular clk_hw pointer and link it up
as a consumer wherever that's needed.

Doing this also lets us get rid of the __clk_free_clk() API that had to
be kept in sync with __clk_put(). Splitting that API up into the "link
and unlink from consumer list" phase and "free the clk pointer" phase
allows us to reuse that logic in a couple places, simplifying the code.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c    | 140 +++++++++++++++++++++++++++++--------------
 drivers/clk/clk.h    |  10 +---
 drivers/clk/clkdev.c |   9 +--
 3 files changed, 98 insertions(+), 61 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d2477a5058ac..fef937ea44f4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3209,42 +3209,103 @@ static int __clk_core_init(struct clk_core *core)
 	return ret;
 }
 
-struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
+/**
+ * clk_core_link_consumer - Add a clk consumer to the list of consumers in a clk_core
+ * @core: clk to add consumer to
+ * @clk: consumer to link to a clk
+ */
+static void clk_core_link_consumer(struct clk_core *core, struct clk *clk)
+{
+	clk_prepare_lock();
+	hlist_add_head(&clk->clks_node, &core->clks);
+	clk_prepare_unlock();
+}
+
+/**
+ * clk_core_unlink_consumer - Remove a clk consumer from the list of consumers in a clk_core
+ * @clk: consumer to unlink
+ */
+static void clk_core_unlink_consumer(struct clk *clk)
+{
+	lockdep_assert_held(&prepare_lock);
+	hlist_del(&clk->clks_node);
+}
+
+/**
+ * alloc_clk - Allocate a clk consumer, but leave it unlinked to the clk_core
+ * @core: clk to allocate a consumer for
+ * @dev_id: string describing device name
+ * @con_id: connection ID string on device
+ *
+ * Returns: clk consumer left unlinked from the consumer list
+ */
+static struct clk *alloc_clk(struct clk_core *core, const char *dev_id,
 			     const char *con_id)
 {
 	struct clk *clk;
 
-	/* This is to allow this function to be chained to others */
-	if (IS_ERR_OR_NULL(hw))
-		return ERR_CAST(hw);
-
 	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
 	if (!clk)
 		return ERR_PTR(-ENOMEM);
 
-	clk->core = hw->core;
+	clk->core = core;
 	clk->dev_id = dev_id;
 	clk->con_id = kstrdup_const(con_id, GFP_KERNEL);
 	clk->max_rate = ULONG_MAX;
 
-	clk_prepare_lock();
-	hlist_add_head(&clk->clks_node, &hw->core->clks);
-	clk_prepare_unlock();
-
 	return clk;
 }
 
-/* keep in sync with __clk_put */
-void __clk_free_clk(struct clk *clk)
+/**
+ * free_clk - Free a clk consumer
+ * @clk: clk consumer to free
+ *
+ * Note, this assumes the clk has been unlinked from the clk_core consumer
+ * list.
+ */
+static void free_clk(struct clk *clk)
 {
-	clk_prepare_lock();
-	hlist_del(&clk->clks_node);
-	clk_prepare_unlock();
-
 	kfree_const(clk->con_id);
 	kfree(clk);
 }
 
+/**
+ * clk_hw_create_clk: Allocate and link a clk consumer to a clk_core given
+ * a clk_hw
+ * @hw: clk_hw associated with the clk being consumed
+ * @dev_id: string describing device name
+ * @con_id: connection ID string on device
+ *
+ * This is the main function used to create a clk pointer for use by clk
+ * consumers. It connects a consumer to the clk_core and clk_hw structures
+ * used by the framework and clk provider respectively.
+ */
+struct clk *clk_hw_create_clk(struct clk_hw *hw,
+			      const char *dev_id, const char *con_id)
+{
+	struct clk *clk;
+	struct clk_core *core;
+
+	/* This is to allow this function to be chained to others */
+	if (IS_ERR_OR_NULL(hw))
+		return ERR_CAST(hw);
+
+	core = hw->core;
+	clk = alloc_clk(core, dev_id, con_id);
+	if (IS_ERR(clk))
+		return clk;
+
+	if (!try_module_get(core->owner)) {
+		free_clk(clk);
+		return ERR_PTR(-ENOENT);
+	}
+
+	kref_get(&core->ref);
+	clk_core_link_consumer(core, clk);
+
+	return clk;
+}
+
 /**
  * clk_register - allocate a new clock, register it and return an opaque cookie
  * @dev: device that is registering this clock
@@ -3320,17 +3381,27 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 
 	INIT_HLIST_HEAD(&core->clks);
 
-	hw->clk = __clk_create_clk(hw, NULL, NULL);
+	/*
+	 * Don't call clk_hw_create_clk() here because that would pin the
+	 * provider module to itself and prevent it from ever being removed.
+	 */
+	hw->clk = alloc_clk(core, NULL, NULL);
 	if (IS_ERR(hw->clk)) {
 		ret = PTR_ERR(hw->clk);
 		goto fail_parents;
 	}
 
+	clk_core_link_consumer(hw->core, hw->clk);
+
 	ret = __clk_core_init(core);
 	if (!ret)
 		return hw->clk;
 
-	__clk_free_clk(hw->clk);
+	clk_prepare_lock();
+	clk_core_unlink_consumer(hw->clk);
+	clk_prepare_unlock();
+
+	free_clk(hw->clk);
 	hw->clk = NULL;
 
 fail_parents:
@@ -3601,20 +3672,7 @@ EXPORT_SYMBOL_GPL(devm_clk_hw_unregister);
 /*
  * clkdev helpers
  */
-int __clk_get(struct clk *clk)
-{
-	struct clk_core *core = !clk ? NULL : clk->core;
-
-	if (core) {
-		if (!try_module_get(core->owner))
-			return 0;
-
-		kref_get(&core->ref);
-	}
-	return 1;
-}
 
-/* keep in sync with __clk_free_clk */
 void __clk_put(struct clk *clk)
 {
 	struct module *owner;
@@ -3648,8 +3706,7 @@ void __clk_put(struct clk *clk)
 
 	module_put(owner);
 
-	kfree_const(clk->con_id);
-	kfree(clk);
+	free_clk(clk);
 }
 
 /***        clk rate change notifiers        ***/
@@ -4025,8 +4082,7 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 				       const char *dev_id, const char *con_id)
 {
 	struct of_clk_provider *provider;
-	struct clk *clk = ERR_PTR(-EPROBE_DEFER);
-	struct clk_hw *hw;
+	struct clk_hw *hw = ERR_PTR(-EPROBE_DEFER);
 
 	if (!clkspec)
 		return ERR_PTR(-EINVAL);
@@ -4036,21 +4092,13 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 	list_for_each_entry(provider, &of_clk_providers, link) {
 		if (provider->node == clkspec->np) {
 			hw = __of_clk_get_hw_from_provider(provider, clkspec);
-			clk = __clk_create_clk(hw, dev_id, con_id);
-		}
-
-		if (!IS_ERR(clk)) {
-			if (!__clk_get(clk)) {
-				__clk_free_clk(clk);
-				clk = ERR_PTR(-ENOENT);
-			}
-
-			break;
+			if (!IS_ERR(hw))
+				break;
 		}
 	}
 	mutex_unlock(&of_clk_mutex);
 
-	return clk;
+	return clk_hw_create_clk(hw, dev_id, con_id);
 }
 
 /**
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index b02f5e604e69..4cdf30b0008c 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -12,24 +12,20 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 #endif
 
 #ifdef CONFIG_COMMON_CLK
-struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
-			     const char *con_id);
-void __clk_free_clk(struct clk *clk);
-int __clk_get(struct clk *clk);
+struct clk *clk_hw_create_clk(struct clk_hw *hw,
+			      const char *dev_id, const char *con_id);
 void __clk_put(struct clk *clk);
 #else
 /* All these casts to avoid ifdefs in clkdev... */
 static inline struct clk *
-__clk_create_clk(struct clk_hw *hw, const char *dev_id, const char *con_id)
+clk_hw_create_clk(struct clk_hw *hw, const char *dev_id, const char *con_id)
 {
 	return (struct clk *)hw;
 }
-static inline void __clk_free_clk(struct clk *clk) { }
 static struct clk_hw *__clk_get_hw(struct clk *clk)
 {
 	return (struct clk_hw *)clk;
 }
-static inline int __clk_get(struct clk *clk) { return 1; }
 static inline void __clk_put(struct clk *clk) { }
 
 #endif
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8b3988..bdeaffc950ae 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -174,16 +174,9 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 	if (!cl)
 		goto out;
 
-	clk = __clk_create_clk(cl->clk_hw, dev_id, con_id);
+	clk = clk_hw_create_clk(cl->clk_hw, dev_id, con_id);
 	if (IS_ERR(clk))
-		goto out;
-
-	if (!__clk_get(clk)) {
-		__clk_free_clk(clk);
 		cl = NULL;
-		goto out;
-	}
-
 out:
 	mutex_unlock(&clocks_mutex);
 
-- 
Sent by a computer through tubes

