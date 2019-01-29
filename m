Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3892C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877B021916
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548742226;
	bh=i2/x4THMEQuaCq9FeqNFX7loZmXx3MGcTTPWunJFV3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zWh+qyKNJMAstlOPOvQtci0r8WWjw5exum2aqMZ2VXGCkrEt+D/Bmcn4zoU3CA2pJ
	 jGSzG3IPXX5lNbW0Jqa2kTldmg5fBJDtHgAQfyognZ/DTu+vYrZBex3BHxNKzzD6Tr
	 tkCA38tuHy0f7o3nQyHbZtvtfjYOulAsOz7hBBJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfA2GKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfA2GKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:10:24 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B312183F;
        Tue, 29 Jan 2019 06:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548742223;
        bh=i2/x4THMEQuaCq9FeqNFX7loZmXx3MGcTTPWunJFV3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qIJXt5K5UO+J5+NRKWV0ajCMxvEFXgGUuxeeVL3Nu7mwJZ//9OOV4M2z8NVWrhwie
         FUwrlTSVN6FJH5HcxDzPyBYnpwRHoipkUbI8XxSXiN9IIK7I5/D0a5Au4gHRRq3Nc+
         Ck1sxSDOoZ+dsynGsc6HKkuUJ8Yzjr5Bo5d83h/k=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 2/9] clk: Introduce get_parent_hw clk op
Date:   Mon, 28 Jan 2019 22:10:14 -0800
Message-Id: <20190129061021.94775-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129061021.94775-1-sboyd@kernel.org>
References: <20190129061021.94775-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk_ops::get_parent function is limited in ability to return errors
because it returns a u8. A "workaround" to return an error is to return
a number >= the number of parents of a clk. This will in turn cause the
framework to "orphan" the clk and make the parent of the clk NULL. This
isn't really correct, because if an error occurs while reading the
parents of a clk we should fail the clk registration, instead of
orphaning the clk and waiting for the clk to appear later.

We really need to have three different return values from the get_parent
clk op. Something valid for a clk that exists, something invalid for a
clk that doesn't exist and never will exist or can't be determined
because the register operation to read the parent failed, and something
for a clk that doesn't exist because the framework doesn't know about
what it is. Introduce a new clk_op that can express all of this by
returning a pointer to the clk_hw of the parent. It's expected that clk
provider drivers will return a valid pointer when the parent is
findable, an error pointer like EPROBE_DEFER if their parent provider
hasn't probed yet but is valid, a NULL pointer if they can't find the
clk but index is valid, and an error pointer with an appropriate error
code otherwise.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c            | 117 ++++++++++++++++++++++++++---------
 include/linux/clk-provider.h |   9 +++
 2 files changed, 96 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 01b36f0851bd..5d82cf25bb29 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2242,14 +2242,84 @@ struct clk *clk_get_parent(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_get_parent);
 
-static struct clk_core *__clk_init_parent(struct clk_core *core)
+static struct clk_core *
+__clk_init_parent(struct clk_core *core, bool update_orphan)
 {
 	u8 index = 0;
+	struct clk_hw *parent_hw = NULL;
 
-	if (core->num_parents > 1 && core->ops->get_parent)
-		index = core->ops->get_parent(core->hw);
+	if (core->ops->get_parent_hw) {
+		parent_hw = core->ops->get_parent_hw(core->hw);
+		/*
+		 * The provider driver doesn't know what the parent is,
+		 * but it's at least something valid, so it's not an
+		 * orphan, just a clk with some unknown parent.
+		 */
+		if (!parent_hw && update_orphan)
+			core->orphan = false;
+	} else {
+		if (core->num_parents > 1 && core->ops->get_parent)
+			index = core->ops->get_parent(core->hw);
+
+		parent_hw = clk_hw_get_parent_by_index(core->hw, index);
+	}
+
+	if (IS_ERR(parent_hw)) {
+		/* Parent clk provider hasn't probed yet, orphan it */
+		if (PTR_ERR(parent_hw) == -EPROBE_DEFER) {
+			if (update_orphan)
+				core->orphan = true;
+
+			return NULL;
+		}
+
+		return ERR_CAST(parent_hw);
+	}
+
+	if (!parent_hw)
+		return NULL;
+
+	return parent_hw->core;
+}
+
+static int clk_init_parent(struct clk_core *core)
+{
+	core->parent = __clk_init_parent(core, true);
+	if (IS_ERR(core->parent))
+		return PTR_ERR(core->parent);
+
+	/*
+	 * Populate core->parent if parent has already been clk_core_init'd. If
+	 * parent has not yet been clk_core_init'd then place clk in the orphan
+	 * list.  If clk doesn't have any parents then place it in the root
+	 * clk list.
+	 *
+	 * Every time a new clk is clk_init'd then we walk the list of orphan
+	 * clocks and re-parent any that are children of the clock currently
+	 * being clk_init'd.
+	 */
+	if (core->parent) {
+		hlist_add_head(&core->child_node,
+				&core->parent->children);
+		core->orphan = core->parent->orphan;
+	} else if (!core->num_parents) {
+		hlist_add_head(&core->child_node, &clk_root_list);
+		core->orphan = false;
+	} else {
+		hlist_add_head(&core->child_node, &clk_orphan_list);
+	}
+
+	return 0;
+}
 
-	return clk_core_get_parent_by_index(core, index);
+static struct clk_core *clk_find_parent(struct clk_core *core)
+{
+	return __clk_init_parent(core, false);
+}
+
+static bool clk_has_parent_op(const struct clk_ops *ops)
+{
+	return ops->get_parent || ops->get_parent_hw;
 }
 
 static void clk_core_reparent(struct clk_core *core,
@@ -3045,14 +3115,14 @@ static int __clk_core_init(struct clk_core *core)
 		goto out;
 	}
 
-	if (core->ops->set_parent && !core->ops->get_parent) {
+	if (core->ops->set_parent && !clk_has_parent_op(core->ops)) {
 		pr_err("%s: %s must implement .get_parent & .set_parent\n",
 		       __func__, core->name);
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (core->num_parents > 1 && !core->ops->get_parent) {
+	if (core->num_parents > 1 && !clk_has_parent_op(core->ops)) {
 		pr_err("%s: %s must implement .get_parent as it has multi parents\n",
 		       __func__, core->name);
 		ret = -EINVAL;
@@ -3073,29 +3143,9 @@ static int __clk_core_init(struct clk_core *core)
 				"%s: invalid NULL in %s's .parent_names\n",
 				__func__, core->name);
 
-	core->parent = __clk_init_parent(core);
-
-	/*
-	 * Populate core->parent if parent has already been clk_core_init'd. If
-	 * parent has not yet been clk_core_init'd then place clk in the orphan
-	 * list.  If clk doesn't have any parents then place it in the root
-	 * clk list.
-	 *
-	 * Every time a new clk is clk_init'd then we walk the list of orphan
-	 * clocks and re-parent any that are children of the clock currently
-	 * being clk_init'd.
-	 */
-	if (core->parent) {
-		hlist_add_head(&core->child_node,
-				&core->parent->children);
-		core->orphan = core->parent->orphan;
-	} else if (!core->num_parents) {
-		hlist_add_head(&core->child_node, &clk_root_list);
-		core->orphan = false;
-	} else {
-		hlist_add_head(&core->child_node, &clk_orphan_list);
-		core->orphan = true;
-	}
+	ret = clk_init_parent(core);
+	if (ret)
+		goto out;
 
 	/*
 	 * optional platform-specific magic
@@ -3173,7 +3223,14 @@ static int __clk_core_init(struct clk_core *core)
 	 * parent.
 	 */
 	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
-		struct clk_core *parent = __clk_init_parent(orphan);
+		struct clk_core *parent = clk_find_parent(orphan);
+
+		/*
+		 * Error parent should have been caught before and returned
+		 * as an error during registration.
+		 */
+		if (WARN_ON_ONCE(IS_ERR(parent)))
+			continue;
 
 		/*
 		 * We need to use __clk_set_parent_before() and _after() to
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 60c51871b04b..8b84dee942bf 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -155,6 +155,14 @@ struct clk_duty {
  *		multiple parents.  It is optional (and unnecessary) for clocks
  *		with 0 or 1 parents.
  *
+ * @get_parent_hw: Queries the hardware to determine the parent of a clock.  The
+ *		return value is a clk_hw pointer corresponding to
+ *		the parent clock. In short, this function translates the parent
+ *		value read from hardware into a pointer to the clk_hw for that clk.
+ *		Currently only called when the clock is initialized by
+ *		__clk_init.  This callback is mandatory for clocks with
+ *		multiple parents.  It is optional for clocks with 0 or 1 parents.
+ *
  * @set_rate:	Change the rate of this clock. The requested rate is specified
  *		by the second argument, which should typically be the return
  *		of .round_rate call.  The third argument gives the parent rate
@@ -238,6 +246,7 @@ struct clk_ops {
 					  struct clk_rate_request *req);
 	int		(*set_parent)(struct clk_hw *hw, u8 index);
 	u8		(*get_parent)(struct clk_hw *hw);
+	struct clk_hw * (*get_parent_hw)(struct clk_hw *hw);
 	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
 				    unsigned long parent_rate);
 	int		(*set_rate_and_parent)(struct clk_hw *hw,
-- 
Sent by a computer through tubes

