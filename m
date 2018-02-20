Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeBTXLG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:11:06 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:38076 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbeBTXKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:10:15 -0500
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [PATCH v4 05/16] of: changeset: Add of_changeset_node_move method
Date: Wed, 21 Feb 2018 01:10:35 +0200
Message-Id: <20180220231046.32638-6-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>

Adds a changeset helper for moving a subtree to a different place
in the running tree. This is useful in advances cases of dynamic
device tree construction.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/of/dynamic.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h   |  9 +++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 85e722ed8631..27d9057ef360 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -1132,3 +1132,69 @@ int __of_changeset_add_update_property_string_list(
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__of_changeset_add_update_property_string_list);
+
+static struct device_node *
+__of_changeset_node_move_one(struct of_changeset *ocs,
+		struct device_node *np, struct device_node *new_parent)
+{
+	struct device_node *np2;
+	const char *unitname;
+	int err;
+
+	err = of_changeset_detach_node(ocs, np);
+	if (err)
+		return ERR_PTR(err);
+
+	unitname = strrchr(np->full_name, '/');
+	if (!unitname)
+		unitname = np->full_name;
+
+	np2 = __of_node_dup(np, "%s/%s",
+			new_parent->full_name, unitname);
+	if (!np2)
+		return ERR_PTR(-ENOMEM);
+	np2->parent = new_parent;
+
+	err = of_changeset_attach_node(ocs, np2);
+	if (err)
+		return ERR_PTR(err);
+
+	return np2;
+}
+
+/**
+ * of_changeset_node_move_to - Moves a subtree to a new place in
+ *                             the tree
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer to be moved
+ * @to:		device node of the new parent
+ *
+ * Moves a subtree to a new place in the tree.
+ * Note that a move is a safe operation because the phandles
+ * remain valid.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+int of_changeset_node_move(struct of_changeset *ocs,
+		struct device_node *np, struct device_node *new_parent)
+{
+	struct device_node *npc, *nppc;
+
+	/* move the root first */
+	nppc = __of_changeset_node_move_one(ocs, np, new_parent);
+	if (IS_ERR(nppc))
+		return PTR_ERR(nppc);
+
+	/* move the subtrees next */
+	for_each_child_of_node(np, npc) {
+		nppc = __of_changeset_node_move_one(ocs, npc, nppc);
+		if (IS_ERR(nppc)) {
+			of_node_put(npc);
+			return PTR_ERR(nppc);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_changeset_node_move);
diff --git a/include/linux/of.h b/include/linux/of.h
index 7aef555f9bc2..76197bc75346 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1328,6 +1328,9 @@ int __of_changeset_add_update_property_string_list(
 		struct of_changeset *ocs, struct device_node *np,
 		const char *name, const char **strs, int count, bool update);
 
+int of_changeset_node_move(struct of_changeset *ocs,
+	struct device_node *np, struct device_node *new_parent);
+
 #else /* CONFIG_OF_DYNAMIC */
 static inline int of_reconfig_notifier_register(struct notifier_block *nb)
 {
@@ -1390,6 +1393,12 @@ static inline int __of_changeset_add_update_property_string_list(
 	return -EINVAL;
 }
 
+static inline int of_changeset_node_move(struct of_changeset *ocs,
+		struct device_node *np, struct device_node *new_parent)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_OF_DYNAMIC */
 
 /**
-- 
Regards,

Laurent Pinchart
