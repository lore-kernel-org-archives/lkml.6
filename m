Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F9FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FA421873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551220492;
	bh=Z1u7HsaDuq0mWyzNouLmygYzjQDjMMAgUZc/0TqeMGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ODBRXBok+tErPaHJdxlGRinVL01o/dfkNEzYpImivJmvZU8CJtn4IYe6QD47PlP/S
	 8tM3c0Kvqe7Uij5V17n536suswbJTOxtN9zhsmroJ5XJSgcEsS5WA8p2QGv3iTzmYb
	 fgquYrAp3566qdnmiA2OfFSoc6cTuFRUx1sQ/As4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfBZWeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:34:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbfBZWee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:34:34 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0E72218A5;
        Tue, 26 Feb 2019 22:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551220473;
        bh=Z1u7HsaDuq0mWyzNouLmygYzjQDjMMAgUZc/0TqeMGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ylWHrXb3cSD4kZBEvx48rLqI2he2epV2kmpcQgJ3woKnmR5gaZrwcJQNLJUZ5W2Zc
         6uetHnFMBNs4tJERXkwPtas0iRDVlFp/d4ePqa+AdZeA+WrncmHsiSHALbPdFL3coF
         b1OmiH9zG7F6Hcu1+QWZLLHXmf9nq2Slg6yez8Vw=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 6/8] clk: Allow parents to be specified without string names
Date:   Tue, 26 Feb 2019 14:34:27 -0800
Message-Id: <20190226223429.193873-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <20190226223429.193873-1-sboyd@kernel.org>
References: <20190226223429.193873-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common clk framework is lacking in ability to describe the clk
topology without specifying strings for every possible parent-child
link. There are a few drawbacks to the current approach:

 1) String comparisons are used for everything, including describing
 topologies that are 'local' to a single clock controller.

 2) clk providers (e.g. i2c clk drivers) need to create globally unique
 clk names to avoid collisions in the clk namespace, leading to awkward
 name generation code in various clk drivers.

 3) DT bindings may not fully describe the clk topology and linkages
 between clk controllers because drivers can easily rely on globally unique
 strings to describe connections between clks.

This leads to confusing DT bindings, complicated clk name generation
code, and inefficient string comparisons during clk registration just so
that the clk framework can detect the topology of the clk tree.
Furthermore, some drivers call clk_get() and then __clk_get_name() to
extract the globally unique clk name just so they can specify the parent
of the clk they're registering. We have of_clk_parent_fill() but that
mostly only works for single clks registered from a DT node, which isn't
the norm. Let's simplify this all by introducing two new ways of
specifying clk parents.

The first method is an array of pointers to clk_hw structures
corresponding to the parents at that index. This works for clks that are
registered when we have access to all the clk_hw pointers for the
parents.

The second method is a mix of clk_hw pointers and strings of local and
global parent clk names. If the .name member of the map is set we'll
look for that clk by performing a DT based lookup of the device the clk
is registered with and the .name specified in the map. If that fails,
we'll fallback to the .fallback member and perform a global clk name
lookup like we've always done before.

Using either one of these new methods is entirely optional. Existing
drivers will continue to work, and they can migrate to this new approach
as they see fit. Eventually, we'll want to get rid of the 'parent_names'
array in struct clk_init_data and use one of these new methods instead.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c            | 260 ++++++++++++++++++++++++++---------
 include/linux/clk-provider.h |  19 +++
 2 files changed, 217 insertions(+), 62 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 937b8d092d17..3d01e8c56400 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -39,6 +39,13 @@ static LIST_HEAD(clk_notifier_list);
 
 /***    private data structures    ***/
 
+struct clk_parent_map {
+	const struct clk_hw	*hw;
+	struct clk_core		*core;
+	const char	 	*fw_name;
+	const char	 	*name;
+};
+
 struct clk_core {
 	const char		*name;
 	const struct clk_ops	*ops;
@@ -46,8 +53,7 @@ struct clk_core {
 	struct module		*owner;
 	struct device		*dev;
 	struct clk_core		*parent;
-	const char		**parent_names;
-	struct clk_core		**parents;
+	struct clk_parent_map	*parents;
 	u8			num_parents;
 	u8			new_parent_index;
 	unsigned long		rate;
@@ -316,17 +322,92 @@ static struct clk_core *clk_core_lookup(const char *name)
 	return NULL;
 }
 
+/**
+ * clk_core_get - Find the parent of a clk using a clock specifier in DT
+ * @core: clk to find parent of
+ * @name: name to search for in 'clock-names' of device providing clk
+ *
+ * This is the preferred method for clk providers to find the parent of a
+ * clk when that parent is external to the clk controller. The parent_names
+ * array is indexed and treated as a local name matching a string in the device
+ * node's 'clock-names' property. This allows clk providers to use their own
+ * namespace instead of looking for a globally unique parent string.
+ *
+ * For example the following DT snippet would allow a clock registered by the
+ * clock-controller@c001 that has a clk_init_data::parent_data array
+ * with 'xtal' in the 'name' member to find the clock provided by the
+ * clock-controller@f00abcd without needing to get the globally unique name of
+ * the xtal clk.
+ *
+ * 	parent: clock-controller@f00abcd {
+ * 		reg = <0xf00abcd 0xabcd>;
+ * 		#clock-cells = <0>;
+ * 	};
+ *
+ * 	clock-controller@c001 {
+ * 		reg = <0xc001 0xf00d>;
+ * 		clocks = <&parent>;
+ * 		clock-names = "xtal";
+ * 		#clock-cells = <1>;
+ * 	};
+ *
+ * Returns: -ENOENT when the provider can't be found or the clk doesn't
+ * exist in the provider. -EINVAL when the name can't be found. NULL when the
+ * provider knows about the clk but it isn't provided on this system.
+ * A valid clk_core pointer when the clk can be found in the provider.
+ */
+static struct clk_core *clk_core_get(struct clk_core *core, const char *name)
+{
+	struct clk_hw *hw;
+	struct device *dev = core->dev;
+
+	if (!dev)
+		return ERR_PTR(-ENOENT);
+
+	/* TODO: Support clkdev clk_lookups */
+	hw = of_clk_get_hw(dev->of_node, -1, name);
+	if (IS_ERR_OR_NULL(hw))
+		return ERR_CAST(hw);
+
+	return hw->core;
+}
+
+static void clk_core_fill_parent_index(struct clk_core *core, u8 index)
+{
+	struct clk_parent_map *entry = &core->parents[index];
+	struct clk_core *parent = ERR_PTR(-ENOENT);
+
+	if (entry->hw) {
+		parent = entry->hw->core;
+		/*
+		 * We have a direct reference but it isn't registered yet? Orphan it
+		 * and let clk_reparent() update the orphan status when the parent
+		 * is registered.
+		 */
+		if (!parent)
+			parent = ERR_PTR(-EPROBE_DEFER);
+	} else {
+		if (entry->fw_name)
+			parent = clk_core_get(core, entry->fw_name);
+		if (IS_ERR(parent) && PTR_ERR(parent) == -ENOENT)
+			parent = clk_core_lookup(entry->name);
+	}
+
+	/* Only cache it if it's not an error */
+	if (!IS_ERR(parent))
+		entry->core = parent;
+}
+
 static struct clk_core *clk_core_get_parent_by_index(struct clk_core *core,
 							 u8 index)
 {
-	if (!core || index >= core->num_parents)
+	if (!core || index >= core->num_parents || !core->parents)
 		return NULL;
 
-	if (!core->parents[index])
-		core->parents[index] =
-				clk_core_lookup(core->parent_names[index]);
+	if (!core->parents[index].core)
+		clk_core_fill_parent_index(core, index);
 
-	return core->parents[index];
+	return core->parents[index].core;
 }
 
 struct clk_hw *
@@ -1516,15 +1597,15 @@ static int clk_fetch_parent_index(struct clk_core *core,
 		return -EINVAL;
 
 	for (i = 0; i < core->num_parents; i++) {
-		if (core->parents[i] == parent)
+		if (core->parents[i].core == parent)
 			return i;
 
-		if (core->parents[i])
+		if (core->parents[i].core)
 			continue;
 
 		/* Fallback to comparing globally unique names */
-		if (!strcmp(parent->name, core->parent_names[i])) {
-			core->parents[i] = parent;
+		if (!strcmp(parent->name, core->parents[i].name)) {
+			core->parents[i].core = parent;
 			return i;
 		}
 	}
@@ -2290,6 +2371,7 @@ void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent)
 bool clk_has_parent(struct clk *clk, struct clk *parent)
 {
 	struct clk_core *core, *parent_core;
+	int i;
 
 	/* NULL clocks should be nops, so return success if either is NULL. */
 	if (!clk || !parent)
@@ -2302,8 +2384,11 @@ bool clk_has_parent(struct clk *clk, struct clk *parent)
 	if (core->parent == parent_core)
 		return true;
 
-	return match_string(core->parent_names, core->num_parents,
-			    parent_core->name) >= 0;
+	for (i = 0; i < core->num_parents; i++)
+		if (!strcmp(core->parents[i].name, parent_core->name))
+			return true;
+
+	return false;
 }
 EXPORT_SYMBOL_GPL(clk_has_parent);
 
@@ -2886,9 +2971,9 @@ static int possible_parents_show(struct seq_file *s, void *data)
 	int i;
 
 	for (i = 0; i < core->num_parents - 1; i++)
-		seq_printf(s, "%s ", core->parent_names[i]);
+		seq_printf(s, "%s ", core->parents[i].name);
 
-	seq_printf(s, "%s\n", core->parent_names[i]);
+	seq_printf(s, "%s\n", core->parents[i].name);
 
 	return 0;
 }
@@ -3022,7 +3107,7 @@ static inline void clk_debug_unregister(struct clk_core *core)
  */
 static int __clk_core_init(struct clk_core *core)
 {
-	int i, ret;
+	int ret;
 	struct clk_core *orphan;
 	struct hlist_node *tmp2;
 	unsigned long rate;
@@ -3076,12 +3161,6 @@ static int __clk_core_init(struct clk_core *core)
 		goto out;
 	}
 
-	/* throw a WARN if any entries in parent_names are NULL */
-	for (i = 0; i < core->num_parents; i++)
-		WARN(!core->parent_names[i],
-				"%s: invalid NULL in %s's .parent_names\n",
-				__func__, core->name);
-
 	core->parent = __clk_init_parent(core);
 
 	/*
@@ -3310,6 +3389,96 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
 	return clk;
 }
 
+static int clk_cpy_name(const char *dst, const char *src, bool must_exist)
+{
+	if (!src) {
+		if (must_exist)
+			return -EINVAL;
+		return 0;
+	}
+
+	dst = kstrdup_const(src, GFP_KERNEL);
+	if (!dst)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int clk_core_populate_parent_map(struct clk_core *core)
+{
+	const struct clk_init_data *init = core->hw->init;
+	u8 num_parents = init->num_parents;
+	const char * const *parent_names = init->parent_names;
+	const struct clk_hw **parent_hws = init->parent_hws;
+	const struct clk_parent_data *parent_data = init->parent_data;
+	int i, ret = 0;
+	struct clk_parent_map *parents, *parent;
+
+	if (!num_parents)
+		return 0;
+
+	/*
+	 * Avoid unnecessary string look-ups of clk_core's possible parents by
+	 * having a cache of names/clk_hw pointers to clk_core pointers.
+	 */
+	parents = kcalloc(num_parents, sizeof(*parents), GFP_KERNEL);
+	core->parents = parents;
+	if (!parents)
+		return -ENOMEM;
+
+	/* Copy everything over because it might be __initdata */
+	for (i = 0, parent = parents; i < num_parents; i++, parent++) {
+		if (parent_names) {
+			/* throw a WARN if any entries are NULL */
+			WARN(!parent_names[i],
+				"%s: invalid NULL in %s's .parent_names\n",
+				__func__, core->name);
+			ret = clk_cpy_name(parent->name, parent_names[i],
+					   true);
+		} else if (parent_data) {
+			parent->hw = parent_data[i].hw;
+			ret = clk_cpy_name(parent->fw_name,
+					   parent_data[i].fw_name, false);
+			if (!ret)
+				ret = clk_cpy_name(parent->name,
+						   parent_data[i].name,
+						   false);
+		} else if (parent_hws) {
+			parent->hw = parent_hws[i];
+		} else {
+			ret = -EINVAL;
+			WARN(1, "Must specify parents if num_parents > 0\n");
+		}
+
+		if (ret) {
+			do {
+				kfree_const(parents[i].name);
+				kfree_const(parents[i].fw_name);
+			} while (--i >= 0);
+			kfree(parents);
+
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void clk_core_free_parent_map(struct clk_core *core)
+{
+	int i = core->num_parents;
+
+	if (!core->num_parents)
+		return;
+
+	while (--i >= 0) {
+		kfree_const(core->parents[i].name);
+		kfree_const(core->parents[i].fw_name);
+	}
+
+	kfree(core->parents);
+}
+
 /**
  * clk_register - allocate a new clock, register it and return an opaque cookie
  * @dev: device that is registering this clock
@@ -3323,7 +3492,7 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
  */
 struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 {
-	int i, ret;
+	int ret;
 	struct clk_core *core;
 
 	core = kzalloc(sizeof(*core), GFP_KERNEL);
@@ -3356,33 +3525,9 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	core->max_rate = ULONG_MAX;
 	hw->core = core;
 
-	/* allocate local copy in case parent_names is __initdata */
-	core->parent_names = kcalloc(core->num_parents, sizeof(char *),
-					GFP_KERNEL);
-
-	if (!core->parent_names) {
-		ret = -ENOMEM;
-		goto fail_parent_names;
-	}
-
-
-	/* copy each string name in case parent_names is __initdata */
-	for (i = 0; i < core->num_parents; i++) {
-		core->parent_names[i] = kstrdup_const(hw->init->parent_names[i],
-						GFP_KERNEL);
-		if (!core->parent_names[i]) {
-			ret = -ENOMEM;
-			goto fail_parent_names_copy;
-		}
-	}
-
-	/* avoid unnecessary string look-ups of clk_core's possible parents. */
-	core->parents = kcalloc(core->num_parents, sizeof(*core->parents),
-				GFP_KERNEL);
-	if (!core->parents) {
-		ret = -ENOMEM;
+	ret = clk_core_populate_parent_map(core);
+	if (ret)
 		goto fail_parents;
-	};
 
 	INIT_HLIST_HEAD(&core->clks);
 
@@ -3393,7 +3538,7 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	hw->clk = alloc_clk(core, NULL, NULL);
 	if (IS_ERR(hw->clk)) {
 		ret = PTR_ERR(hw->clk);
-		goto fail_parents;
+		goto fail_create_clk;
 	}
 
 	clk_core_link_consumer(hw->core, hw->clk);
@@ -3409,13 +3554,9 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	free_clk(hw->clk);
 	hw->clk = NULL;
 
+fail_create_clk:
+	clk_core_free_parent_map(core);
 fail_parents:
-	kfree(core->parents);
-fail_parent_names_copy:
-	while (--i >= 0)
-		kfree_const(core->parent_names[i]);
-	kfree(core->parent_names);
-fail_parent_names:
 fail_ops:
 	kfree_const(core->name);
 fail_name:
@@ -3445,15 +3586,10 @@ EXPORT_SYMBOL_GPL(clk_hw_register);
 static void __clk_release(struct kref *ref)
 {
 	struct clk_core *core = container_of(ref, struct clk_core, ref);
-	int i = core->num_parents;
 
 	lockdep_assert_held(&prepare_lock);
 
-	kfree(core->parents);
-	while (--i >= 0)
-		kfree_const(core->parent_names[i]);
-
-	kfree(core->parent_names);
+	clk_core_free_parent_map(core);
 	kfree_const(core->name);
 	kfree(core);
 }
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index e443fa9fa859..f4de52c6764e 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -250,6 +250,18 @@ struct clk_ops {
 	void		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
 };
 
+/**
+ * struct clk_parent_data - clk parent information
+ * @hw: parent clk_hw pointer (used for clk providers with internal clks)
+ * @fw_name: parent name local to provider registering clk
+ * @name: globally unique parent name (used as a fallback)
+ */
+struct clk_parent_data {
+	const struct clk_hw 	*hw;
+	const char		*fw_name;
+	const char		*name;
+};
+
 /**
  * struct clk_init_data - holds init data that's common to all clocks and is
  * shared between the clock provider and the common clock framework.
@@ -257,13 +269,20 @@ struct clk_ops {
  * @name: clock name
  * @ops: operations this clock supports
  * @parent_names: array of string names for all possible parents
+ * @parent_data: array of parent data for all possible parents (when some
+ *               parents are external to the clk controller)
+ * @parent_hws: array of pointers to all possible parents (when all parents
+ *              are internal to the clk controller)
  * @num_parents: number of possible parents
  * @flags: framework-level hints and quirks
  */
 struct clk_init_data {
 	const char		*name;
 	const struct clk_ops	*ops;
+	/* Only one of the following three should be assigned */
 	const char		* const *parent_names;
+	const struct clk_parent_data	*parent_data;
+	const struct clk_hw		**parent_hws;
 	u8			num_parents;
 	unsigned long		flags;
 };
-- 
Sent by a computer through tubes

