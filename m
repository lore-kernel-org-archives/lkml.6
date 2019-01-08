Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B294EC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3A6218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfAHQUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:20:04 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44428 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbfAHQTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:19:44 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AFD82209EF; Tue,  8 Jan 2019 17:19:41 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 62E1C207A3;
        Tue,  8 Jan 2019 17:19:41 +0100 (CET)
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
Subject: [PATCH v4 1/4] clk: core: link consumer with clock driver
Date:   Tue,  8 Jan 2019 17:19:37 +0100
Message-Id: <20190108161940.4814-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108161940.4814-1-miquel.raynal@bootlin.com>
References: <20190108161940.4814-1-miquel.raynal@bootlin.com>
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
 drivers/clk/clk.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e1449db544c7..5c36ff52cb72 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -78,6 +78,7 @@ struct clk_core {
 	struct hlist_node	debug_node;
 #endif
 	struct kref		ref;
+	struct device_link	*parent_clk_link;
 };
 
 #define CREATE_TRACE_POINTS
@@ -92,6 +93,7 @@ struct clk {
 	unsigned long max_rate;
 	unsigned int exclusive_count;
 	struct hlist_node clks_node;
+	struct device_link *consumer_link;
 };
 
 /***           runtime pm          ***/
@@ -276,6 +278,35 @@ struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(clk_hw_get_parent);
 
+static void clk_link_consumer(struct device *consumer, struct clk *clk)
+{
+	if (consumer && clk)
+		clk->consumer_link = device_link_add(consumer, clk->core->dev,
+						     DL_FLAG_STATELESS);
+}
+
+static void clk_unlink_consumer(struct clk *clk)
+{
+	if (clk && clk->consumer_link)
+		device_link_del(clk->consumer_link);
+}
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
@@ -1599,6 +1630,9 @@ static void clk_reparent(struct clk_core *core, struct clk_core *new_parent)
 
 	hlist_del(&core->child_node);
 
+	if (core->parent)
+		clk_unlink_hierarchy(core, core->parent);
+
 	if (new_parent) {
 		bool becomes_orphan = new_parent->orphan;
 
@@ -1610,6 +1644,8 @@ static void clk_reparent(struct clk_core *core, struct clk_core *new_parent)
 
 		if (was_orphan != becomes_orphan)
 			clk_core_update_orphan_status(core, becomes_orphan);
+
+		clk_link_hierarchy(core, new_parent);
 	} else {
 		hlist_add_head(&core->child_node, &clk_orphan_list);
 		if (!was_orphan)
@@ -2336,6 +2372,8 @@ __clk_init_parent(struct clk_core *core, bool update_orphan)
 	if (!parent_hw)
 		return NULL;
 
+	clk_link_hierarchy(core, parent_hw->core);
+
 	return parent_hw->core;
 }
 
@@ -3411,6 +3449,7 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
 	}
 
 	kref_get(&core->ref);
+	clk_link_consumer(dev, clk);
 	clk_core_link_consumer(core, clk);
 
 	return clk;
@@ -3633,11 +3672,18 @@ void clk_unregister(struct clk *clk)
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
@@ -3799,6 +3845,8 @@ void __clk_put(struct clk *clk)
 
 	clk_prepare_lock();
 
+	clk_unlink_consumer(clk);
+
 	/*
 	 * Before calling clk_put, all calls to clk_rate_exclusive_get() from a
 	 * given user should be balanced with calls to clk_rate_exclusive_put()
-- 
2.19.1

