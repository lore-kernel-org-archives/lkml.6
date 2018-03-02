Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427716AbeCBMlr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:41:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:3943 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427652AbeCBMjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:39:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="204989818"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jeremy McNicoll <jmcnicol@redhat.com>,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 12/18] thunderbolt: Add tb_xdomain_find_by_route()
Date: Fri,  2 Mar 2018 15:38:46 +0300
Message-Id: <20180302123852.50463-13-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
References: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radion Mirchevsky <radion.mirchevsky@intel.com>

This is needed by the new ICM interface to find xdomains by route string
instead of link and depth.

While there update existing tb_xdomain_find_* functions to use
tb_xdomain_get() instead of open-coding the same.

Signed-off-by: Radion Mirchevsky <radion.mirchevsky@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/thunderbolt/xdomain.c | 47 ++++++++++++++++++++++++++++++++-----------
 include/linux/thunderbolt.h   | 13 ++++++++++++
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index f25d88d4552b..8abb4e843085 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1255,6 +1255,7 @@ struct tb_xdomain_lookup {
 	const uuid_t *uuid;
 	u8 link;
 	u8 depth;
+	u64 route;
 };
 
 static struct tb_xdomain *switch_find_xdomain(struct tb_switch *sw,
@@ -1275,9 +1276,13 @@ static struct tb_xdomain *switch_find_xdomain(struct tb_switch *sw,
 			if (lookup->uuid) {
 				if (uuid_equal(xd->remote_uuid, lookup->uuid))
 					return xd;
-			} else if (lookup->link == xd->link &&
+			} else if (lookup->link &&
+				   lookup->link == xd->link &&
 				   lookup->depth == xd->depth) {
 				return xd;
+			} else if (lookup->route &&
+				   lookup->route == xd->route) {
+				return xd;
 			}
 		} else if (port->remote) {
 			xd = switch_find_xdomain(port->remote->sw, lookup);
@@ -1313,12 +1318,7 @@ struct tb_xdomain *tb_xdomain_find_by_uuid(struct tb *tb, const uuid_t *uuid)
 	lookup.uuid = uuid;
 
 	xd = switch_find_xdomain(tb->root_switch, &lookup);
-	if (xd) {
-		get_device(&xd->dev);
-		return xd;
-	}
-
-	return NULL;
+	return tb_xdomain_get(xd);
 }
 EXPORT_SYMBOL_GPL(tb_xdomain_find_by_uuid);
 
@@ -1349,13 +1349,36 @@ struct tb_xdomain *tb_xdomain_find_by_link_depth(struct tb *tb, u8 link,
 	lookup.depth = depth;
 
 	xd = switch_find_xdomain(tb->root_switch, &lookup);
-	if (xd) {
-		get_device(&xd->dev);
-		return xd;
-	}
+	return tb_xdomain_get(xd);
+}
 
-	return NULL;
+/**
+ * tb_xdomain_find_by_route() - Find an XDomain by route string
+ * @tb: Domain where the XDomain belongs to
+ * @route: XDomain route string
+ *
+ * Finds XDomain by walking through the Thunderbolt topology below @tb.
+ * The returned XDomain will have its reference count increased so the
+ * caller needs to call tb_xdomain_put() when it is done with the
+ * object.
+ *
+ * This will find all XDomains including the ones that are not yet added
+ * to the bus (handshake is still in progress).
+ *
+ * The caller needs to hold @tb->lock.
+ */
+struct tb_xdomain *tb_xdomain_find_by_route(struct tb *tb, u64 route)
+{
+	struct tb_xdomain_lookup lookup;
+	struct tb_xdomain *xd;
+
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.route = route;
+
+	xd = switch_find_xdomain(tb->root_switch, &lookup);
+	return tb_xdomain_get(xd);
 }
+EXPORT_SYMBOL_GPL(tb_xdomain_find_by_route);
 
 bool tb_xdomain_handle_request(struct tb *tb, enum tb_cfg_pkg_type type,
 			       const void *buf, size_t size)
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 7b69853188b1..27b9be34d4b9 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -237,6 +237,7 @@ int tb_xdomain_enable_paths(struct tb_xdomain *xd, u16 transmit_path,
 			    u16 receive_ring);
 int tb_xdomain_disable_paths(struct tb_xdomain *xd);
 struct tb_xdomain *tb_xdomain_find_by_uuid(struct tb *tb, const uuid_t *uuid);
+struct tb_xdomain *tb_xdomain_find_by_route(struct tb *tb, u64 route);
 
 static inline struct tb_xdomain *
 tb_xdomain_find_by_uuid_locked(struct tb *tb, const uuid_t *uuid)
@@ -250,6 +251,18 @@ tb_xdomain_find_by_uuid_locked(struct tb *tb, const uuid_t *uuid)
 	return xd;
 }
 
+static inline struct tb_xdomain *
+tb_xdomain_find_by_route_locked(struct tb *tb, u64 route)
+{
+	struct tb_xdomain *xd;
+
+	mutex_lock(&tb->lock);
+	xd = tb_xdomain_find_by_route(tb, route);
+	mutex_unlock(&tb->lock);
+
+	return xd;
+}
+
 static inline struct tb_xdomain *tb_xdomain_get(struct tb_xdomain *xd)
 {
 	if (xd)
-- 
2.16.1
