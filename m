Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965529AbeBMRNf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:13:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:30085 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964794AbeBMRAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:00:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,508,1511856000";
   d="scan'208";a="17418845"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 11/18] thunderbolt: Add tb_switch_find_by_route()
Date: Tue, 13 Feb 2018 20:00:11 +0300
Message-Id: <20180213170018.9780-12-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radion Mirchevsky <radion.mirchevsky@intel.com>

With the new ICM messaging there is need for find switch by route string
instead of link and depth. Add new function that makes it possible.

Signed-off-by: Radion Mirchevsky <radion.mirchevsky@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 33 +++++++++++++++++++++++++++++++++
 drivers/thunderbolt/tb.h     |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 2a0bded44922..4e2b2097bbfc 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1479,6 +1479,7 @@ struct tb_sw_lookup {
 	u8 link;
 	u8 depth;
 	const uuid_t *uuid;
+	u64 route;
 };
 
 static int tb_switch_match(struct device *dev, void *data)
@@ -1494,6 +1495,11 @@ static int tb_switch_match(struct device *dev, void *data)
 	if (lookup->uuid)
 		return !memcmp(sw->uuid, lookup->uuid, sizeof(*lookup->uuid));
 
+	if (lookup->route) {
+		return sw->config.route_lo == lower_32_bits(lookup->route) &&
+		       sw->config.route_hi == upper_32_bits(lookup->route);
+	}
+
 	/* Root switch is matched only by depth */
 	if (!lookup->depth)
 		return !sw->depth;
@@ -1551,6 +1557,33 @@ struct tb_switch *tb_switch_find_by_uuid(struct tb *tb, const uuid_t *uuid)
 	return NULL;
 }
 
+/**
+ * tb_switch_find_by_route() - Find switch by route string
+ * @tb: Domain the switch belongs
+ * @route: Route string to look for
+ *
+ * Returned switch has reference count increased so the caller needs to
+ * call tb_switch_put() when done with the switch.
+ */
+struct tb_switch *tb_switch_find_by_route(struct tb *tb, u64 route)
+{
+	struct tb_sw_lookup lookup;
+	struct device *dev;
+
+	if (!route)
+		return tb_switch_get(tb->root_switch);
+
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.tb = tb;
+	lookup.route = route;
+
+	dev = bus_find_device(&tb_bus_type, NULL, &lookup, tb_switch_match);
+	if (dev)
+		return tb_to_switch(dev);
+
+	return NULL;
+}
+
 void tb_switch_exit(void)
 {
 	ida_destroy(&nvm_ida);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index c7bd77e9c2c3..2cd6085a6e10 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -386,6 +386,7 @@ struct tb_switch *get_switch_at_route(struct tb_switch *sw, u64 route);
 struct tb_switch *tb_switch_find_by_link_depth(struct tb *tb, u8 link,
 					       u8 depth);
 struct tb_switch *tb_switch_find_by_uuid(struct tb *tb, const uuid_t *uuid);
+struct tb_switch *tb_switch_find_by_route(struct tb *tb, u64 route);
 
 static inline struct tb_switch *tb_switch_get(struct tb_switch *sw)
 {
-- 
2.15.1
