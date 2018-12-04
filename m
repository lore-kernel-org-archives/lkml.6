Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84659C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDB4206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDB4206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbeLDTZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:25:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47420 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbeLDTY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:24:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E6313207A8; Tue,  4 Dec 2018 20:24:53 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2747F207AD;
        Tue,  4 Dec 2018 20:24:43 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 2/4] clk: core: link consumer with clock driver
Date:   Tue,  4 Dec 2018 20:24:38 +0100
Message-Id: <20181204192440.12125-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204192440.12125-1-miquel.raynal@bootlin.com>
References: <20181204192440.12125-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One major concern when, for instance, suspending/resuming a platform
is to never access registers before the underlying clock has been
resumed, otherwise most of the time the kernel will just crash. One
solution is to use syscore operations when registering clock drivers
suspend/resume callbacks. One problem of using syscore_ops is that the
suspend/resume scheduling will depend on the order of the
registrations, which brings (unacceptable) randomness in the process.

A feature called device links has been introduced to handle such
situation. It creates dependencies between consumers and providers,
enforcing e.g. the suspend/resume order when needed. Such feature is
already in use for regulators.

Add device links support in the clock subsystem by creating/deleting
the links at get/put time.

Example of a boot (ESPRESSObin, A3700 SoC) with devices linked to clocks:

marvell-armada-3700-tbg-clock d0013200.tbg: Linked as a consumer to d0013800.pinctrl:xtal-clk
marvell-armada-3700-tbg-clock d0013200.tbg: Dropping the link to d0013800.pinctrl:xtal-clk
marvell-armada-3700-tbg-clock d0013200.tbg: Linked as a consumer to d0013800.pinctrl:xtal-clk
marvell-armada-3700-periph-clock d0013000.nb-periph-clk: Linked as a consumer to d0013200.tbg
marvell-armada-3700-periph-clock d0013000.nb-periph-clk: Linked as a consumer to d0013800.pinctrl:xtal-clk
marvell-armada-3700-periph-clock d0018000.sb-periph-clk: Linked as a consumer to d0013200.tbg
mvneta d0030000.ethernet: Linked as a consumer to d0018000.sb-periph-clk
xhci-hcd d0058000.usb: Linked as a consumer to d0018000.sb-periph-clk
xenon-sdhci d00d0000.sdhci: Linked as a consumer to d0013000.nb-periph-clk
xenon-sdhci d00d0000.sdhci: Dropping the link to d0013000.nb-periph-clk
mvebu-uart d0012000.serial: Linked as a consumer to d0013800.pinctrl:xtal-clk
advk-pcie d0070000.pcie: Linked as a consumer to d0018000.sb-periph-clk
xenon-sdhci d00d0000.sdhci: Linked as a consumer to d0013000.nb-periph-clk
xenon-sdhci d00d0000.sdhci: Linked as a consumer to regulator.1
cpu cpu0: Linked as a consumer to d0013000.nb-periph-clk
cpu cpu0: Dropping the link to d0013000.nb-periph-clk
cpu cpu0: Linked as a consumer to d0013000.nb-periph-clk

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c            | 53 ++++++++++++++++++++++++++++++++++--
 drivers/clk/clkdev.c         | 16 +++++++++--
 include/linux/clk-provider.h |  2 ++
 3 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b799347c5fd6..0cc887b43f66 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -77,6 +77,7 @@ struct clk_core {
 	struct hlist_node	debug_node;
 #endif
 	struct kref		ref;
+	struct device_link	*parent_clk_link;
 };
 
 #define CREATE_TRACE_POINTS
@@ -90,6 +91,7 @@ struct clk {
 	unsigned long max_rate;
 	unsigned int exclusive_count;
 	struct hlist_node clks_node;
+	struct device_link *consumer_link;
 };
 
 /***           runtime pm          ***/
@@ -274,6 +276,37 @@ struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(clk_hw_get_parent);
 
+void clk_link_consumer(struct device *consumer, struct clk *clk)
+{
+	if (consumer && clk)
+		clk->consumer_link = device_link_add(consumer, clk->core->dev,
+						     DL_FLAG_STATELESS);
+}
+EXPORT_SYMBOL_GPL(clk_link_consumer);
+
+void clk_unlink_consumer(struct clk *clk)
+{
+	if (clk && clk->consumer_link)
+		device_link_del(clk->consumer_link);
+}
+EXPORT_SYMBOL_GPL(clk_unlink_consumer);
+
+static void clk_link_hierarchy(struct clk_core *consumer,
+			       struct clk_core *provider)
+{
+	if (consumer && provider)
+		consumer->parent_clk_link = device_link_add(consumer->dev,
+							    provider->dev,
+							    DL_FLAG_STATELESS);
+}
+
+static void clk_unlink_hierarchy(struct clk_core *consumer,
+				 struct clk_core *provider)
+{
+	if (consumer && provider && consumer->parent_clk_link)
+		device_link_del(consumer->parent_clk_link);
+}
+
 static struct clk_core *__clk_lookup_subtree(const char *name,
 					     struct clk_core *core)
 {
@@ -1542,6 +1575,9 @@ static void clk_reparent(struct clk_core *core, struct clk_core *new_parent)
 
 	hlist_del(&core->child_node);
 
+	if (core->parent)
+		clk_unlink_hierarchy(core, core->parent);
+
 	if (new_parent) {
 		bool becomes_orphan = new_parent->orphan;
 
@@ -1553,6 +1589,8 @@ static void clk_reparent(struct clk_core *core, struct clk_core *new_parent)
 
 		if (was_orphan != becomes_orphan)
 			clk_core_update_orphan_status(core, becomes_orphan);
+
+		clk_link_hierarchy(core, new_parent);
 	} else {
 		hlist_add_head(&core->child_node, &clk_orphan_list);
 		if (!was_orphan)
@@ -2244,12 +2282,16 @@ EXPORT_SYMBOL_GPL(clk_get_parent);
 
 static struct clk_core *__clk_init_parent(struct clk_core *core)
 {
+	struct clk_core *parent;
 	u8 index = 0;
 
 	if (core->num_parents > 1 && core->ops->get_parent)
 		index = core->ops->get_parent(core->hw);
 
-	return clk_core_get_parent_by_index(core, index);
+	parent = clk_core_get_parent_by_index(core, index);
+	clk_link_hierarchy(core, parent);
+
+	return parent;
 }
 
 static void clk_core_reparent(struct clk_core *core,
@@ -3437,11 +3479,18 @@ void clk_unregister(struct clk *clk)
 	clk->core->ops = &clk_nodrv_ops;
 	clk_enable_unlock(flags);
 
+	clk_unlink_hierarchy(clk->core, clk->core->parent);
+
 	if (!hlist_empty(&clk->core->children)) {
 		struct clk_core *child;
 		struct hlist_node *t;
 
-		/* Reparent all children to the orphan list. */
+		/*
+		 * Reparent all children to the orphan list.
+		 *
+		 * No need to unlink the child clock manually, this will be
+		 * handled by clk_reparent().
+		 */
 		hlist_for_each_entry_safe(child, t, &clk->core->children,
 					  child_node)
 			clk_core_set_parent_nolock(child, NULL);
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8b3988..8c6e087437bf 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -112,6 +112,9 @@ EXPORT_SYMBOL(of_clk_get_by_name);
 
 #else /* defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK) */
 
+void clk_link_consumer(struct device *consumer, struct clk *clk) {}
+void clk_unlink_consumer(struct clk *clk) {}
+
 static struct clk *__of_clk_get_by_name(struct device_node *np,
 					const char *dev_id,
 					const char *name)
@@ -194,20 +197,27 @@ EXPORT_SYMBOL(clk_get_sys);
 struct clk *clk_get(struct device *dev, const char *con_id)
 {
 	const char *dev_id = dev ? dev_name(dev) : NULL;
-	struct clk *clk;
+	struct clk *clk = NULL;
 
 	if (dev && dev->of_node) {
 		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
-		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
+		if (PTR_ERR(clk) == -EPROBE_DEFER)
 			return clk;
 	}
 
-	return clk_get_sys(dev_id, con_id);
+	if (IS_ERR_OR_NULL(clk))
+		clk = clk_get_sys(dev_id, con_id);
+
+	if (!IS_ERR(clk))
+		clk_link_consumer(dev, clk);
+
+	return clk;
 }
 EXPORT_SYMBOL(clk_get);
 
 void clk_put(struct clk *clk)
 {
+	clk_unlink_consumer(clk);
 	__clk_put(clk);
 }
 EXPORT_SYMBOL(clk_put);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 60c51871b04b..721d6b55b2fa 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -781,6 +781,8 @@ void devm_clk_hw_unregister(struct device *dev, struct clk_hw *hw);
 const char *__clk_get_name(const struct clk *clk);
 const char *clk_hw_get_name(const struct clk_hw *hw);
 struct clk_hw *__clk_get_hw(struct clk *clk);
+void clk_link_consumer(struct device *consumer, struct clk *clk);
+void clk_unlink_consumer(struct clk *clk);
 unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
-- 
2.19.1

