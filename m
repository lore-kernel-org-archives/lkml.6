Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4171ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409D92088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409D92088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbeIQWIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:08:15 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:42716 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbeIQWIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:08:15 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id cgg41y00Y3XaVaC06gg4HS; Mon, 17 Sep 2018 18:40:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g1wZA-0006bC-9h; Mon, 17 Sep 2018 18:40:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g1wZA-0004xk-88; Mon, 17 Sep 2018 18:40:04 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v4 1/2] reset: Add support for dedicated reset controls
Date:   Mon, 17 Sep 2018 18:39:54 +0200
Message-Id: <20180917163955.19023-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180917163955.19023-1-geert+renesas@glider.be>
References: <20180917163955.19023-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some SoCs multiple hardware blocks may share a reset control.
The existing reset control API for shared resets will only assert such a
reset when the drivers for all hardware blocks agree.
The existing exclusive reset control API still allows to assert such a
reset, but that impacts all other hardware blocks sharing the reset.

Sometimes a driver needs to reset a specific hardware block, and be 100%
sure it has no impact on other hardware blocks.  This is e.g. the case
for virtualization with device pass-through, where the host wants to
reset any exported device before and after exporting it for use by the
guest, for isolation.

Hence a new flag for dedicated resets is added to the internal methods,
with a new public reset_control_get_dedicated() method, to obtain an
exclusive handle to a reset that is dedicated to one specific hardware
block.

This supports both DT-based and lookup-based reset controls.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.

Notes:
  - Dedicated lookup-based reset controls were not tested,
  - Several internal functions now take 3 boolean flags, and should
    probably be converted to take a bitmask instead,
  - I think __device_reset() should call __reset_control_get() with
    dedicated=true.  However, that will impact existing users,
  - Should a different error than -EINVAL be returned on failure?
---
 drivers/reset/core.c  | 76 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/reset.h | 60 ++++++++++++++++++++++------------
 2 files changed, 107 insertions(+), 29 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 225e34c56b94a2e3..5bc4eeca70c0fcc2 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -459,9 +459,38 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
+static bool __of_reset_is_dedicated(const struct device_node *node,
+				    const struct of_phandle_args args)
+{
+	struct of_phandle_args args2;
+	struct device_node *node2;
+	int index, ret;
+
+	for_each_node_with_property(node2, "resets") {
+		if (node == node2)
+			continue;
+
+		for (index = 0; ; index++) {
+			ret = of_parse_phandle_with_args(node2, "resets",
+							 "#reset-cells", index,
+							 &args2);
+			if (ret)
+				break;
+
+			if (args2.np == args.np &&
+			    args2.args_count == args.args_count &&
+			    !memcmp(args2.args, args.args,
+				    args.args_count * sizeof(args.args[0])))
+				return false;
+		}
+	}
+
+	return true;
+}
+
 struct reset_control *__of_reset_control_get(struct device_node *node,
 				     const char *id, int index, bool shared,
-				     bool optional)
+				     bool optional, bool dedicated)
 {
 	struct reset_control *rstc;
 	struct reset_controller_dev *r, *rcdev;
@@ -514,6 +543,11 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
 		return ERR_PTR(rstc_id);
 	}
 
+	if (dedicated && !__of_reset_is_dedicated(node, args)) {
+		mutex_unlock(&reset_list_mutex);
+		return ERR_PTR(-EINVAL);
+	}
+
 	/* reset_list_mutex also protects the rcdev's reset_control list */
 	rstc = __reset_control_get_internal(rcdev, rstc_id, shared);
 
@@ -541,9 +575,25 @@ __reset_controller_by_name(const char *name)
 	return NULL;
 }
 
+static bool __reset_is_dedicated(const struct reset_control_lookup *lookup)
+{
+	const struct reset_control_lookup *lookup2;
+
+	list_for_each_entry(lookup, &reset_lookup_list, list) {
+		if (lookup2 == lookup)
+			continue;
+
+		if (lookup2->provider == lookup->provider &&
+		    lookup2->index == lookup->index)
+			return false;
+	}
+
+	return true;
+}
+
 static struct reset_control *
 __reset_control_get_from_lookup(struct device *dev, const char *con_id,
-				bool shared, bool optional)
+				bool shared, bool optional, bool dedicated)
 {
 	const struct reset_control_lookup *lookup;
 	struct reset_controller_dev *rcdev;
@@ -562,6 +612,11 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 		if ((!con_id && !lookup->con_id) ||
 		    ((con_id && lookup->con_id) &&
 		     !strcmp(con_id, lookup->con_id))) {
+			if (dedicated && !__reset_is_dedicated(lookup)) {
+				mutex_unlock(&reset_lookup_mutex);
+				return ERR_PTR(-EINVAL);
+			}
+
 			mutex_lock(&reset_list_mutex);
 			rcdev = __reset_controller_by_name(lookup->provider);
 			if (!rcdev) {
@@ -588,13 +643,15 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 }
 
 struct reset_control *__reset_control_get(struct device *dev, const char *id,
-					  int index, bool shared, bool optional)
+					  int index, bool shared,
+					  bool optional, bool dedicated)
 {
 	if (dev->of_node)
 		return __of_reset_control_get(dev->of_node, id, index, shared,
-					      optional);
+					      optional, dedicated);
 
-	return __reset_control_get_from_lookup(dev, id, shared, optional);
+	return __reset_control_get_from_lookup(dev, id, shared, optional,
+					       dedicated);
 }
 EXPORT_SYMBOL_GPL(__reset_control_get);
 
@@ -635,7 +692,7 @@ static void devm_reset_control_release(struct device *dev, void *res)
 
 struct reset_control *__devm_reset_control_get(struct device *dev,
 				     const char *id, int index, bool shared,
-				     bool optional)
+				     bool optional, bool dedicated)
 {
 	struct reset_control **ptr, *rstc;
 
@@ -644,7 +701,7 @@ struct reset_control *__devm_reset_control_get(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	rstc = __reset_control_get(dev, id, index, shared, optional);
+	rstc = __reset_control_get(dev, id, index, shared, optional, dedicated);
 	if (!IS_ERR(rstc)) {
 		*ptr = rstc;
 		devres_add(dev, ptr);
@@ -671,7 +728,7 @@ int __device_reset(struct device *dev, bool optional)
 	struct reset_control *rstc;
 	int ret;
 
-	rstc = __reset_control_get(dev, NULL, 0, 0, optional);
+	rstc = __reset_control_get(dev, NULL, 0, false, optional, false);
 	if (IS_ERR(rstc))
 		return PTR_ERR(rstc);
 
@@ -735,7 +792,8 @@ of_reset_control_array_get(struct device_node *np, bool shared, bool optional)
 		return ERR_PTR(-ENOMEM);
 
 	for (i = 0; i < num; i++) {
-		rstc = __of_reset_control_get(np, NULL, i, shared, optional);
+		rstc = __of_reset_control_get(np, NULL, i, shared, optional,
+					      false);
 		if (IS_ERR(rstc))
 			goto err_rst;
 		resets->rstc[i] = rstc;
diff --git a/include/linux/reset.h b/include/linux/reset.h
index 09732c36f3515a1e..6ca6e108b612f923 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -17,15 +17,15 @@ int reset_control_status(struct reset_control *rstc);
 
 struct reset_control *__of_reset_control_get(struct device_node *node,
 				     const char *id, int index, bool shared,
-				     bool optional);
+				     bool optional, bool dedicated);
 struct reset_control *__reset_control_get(struct device *dev, const char *id,
 					  int index, bool shared,
-					  bool optional);
+					  bool optional, bool dedicated);
 void reset_control_put(struct reset_control *rstc);
 int __device_reset(struct device *dev, bool optional);
 struct reset_control *__devm_reset_control_get(struct device *dev,
 				     const char *id, int index, bool shared,
-				     bool optional);
+				     bool optional, bool dedicated);
 
 struct reset_control *devm_reset_control_array_get(struct device *dev,
 						   bool shared, bool optional);
@@ -66,21 +66,23 @@ static inline int __device_reset(struct device *dev, bool optional)
 static inline struct reset_control *__of_reset_control_get(
 					struct device_node *node,
 					const char *id, int index, bool shared,
-					bool optional)
+					bool optional, bool dedicated)
 {
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
 static inline struct reset_control *__reset_control_get(
 					struct device *dev, const char *id,
-					int index, bool shared, bool optional)
+					int index, bool shared, bool optional,
+					bool dedicated)
 {
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
 static inline struct reset_control *__devm_reset_control_get(
 					struct device *dev, const char *id,
-					int index, bool shared, bool optional)
+					int index, bool shared, bool optional,
+					bool dedicated)
 {
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
@@ -127,7 +129,25 @@ static inline int device_reset_optional(struct device *dev)
 static inline struct reset_control *
 __must_check reset_control_get_exclusive(struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, false, false);
+	return __reset_control_get(dev, id, 0, false, false, false);
+}
+
+/**
+ * reset_control_get_dedicated - Lookup and obtain an exclusive reference
+ *                               to a dedicated reset controller.
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Returns a struct reset_control or IS_ERR() condition containing errno.
+ * If this function is called more than once for the same reset_control it will
+ * return -EBUSY.
+ *
+ * Use of id names is optional.
+ */
+static inline struct reset_control *
+__must_check reset_control_get_dedicated(struct device *dev, const char *id)
+{
+	return __reset_control_get(dev, id, 0, false, false, true);
 }
 
 /**
@@ -155,19 +175,19 @@ __must_check reset_control_get_exclusive(struct device *dev, const char *id)
 static inline struct reset_control *reset_control_get_shared(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, true, false);
+	return __reset_control_get(dev, id, 0, true, false, false);
 }
 
 static inline struct reset_control *reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, false, true);
+	return __reset_control_get(dev, id, 0, false, true, false);
 }
 
 static inline struct reset_control *reset_control_get_optional_shared(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, true, true);
+	return __reset_control_get(dev, id, 0, true, true, false);
 }
 
 /**
@@ -183,7 +203,7 @@ static inline struct reset_control *reset_control_get_optional_shared(
 static inline struct reset_control *of_reset_control_get_exclusive(
 				struct device_node *node, const char *id)
 {
-	return __of_reset_control_get(node, id, 0, false, false);
+	return __of_reset_control_get(node, id, 0, false, false, false);
 }
 
 /**
@@ -208,7 +228,7 @@ static inline struct reset_control *of_reset_control_get_exclusive(
 static inline struct reset_control *of_reset_control_get_shared(
 				struct device_node *node, const char *id)
 {
-	return __of_reset_control_get(node, id, 0, true, false);
+	return __of_reset_control_get(node, id, 0, true, false, false);
 }
 
 /**
@@ -225,7 +245,7 @@ static inline struct reset_control *of_reset_control_get_shared(
 static inline struct reset_control *of_reset_control_get_exclusive_by_index(
 					struct device_node *node, int index)
 {
-	return __of_reset_control_get(node, NULL, index, false, false);
+	return __of_reset_control_get(node, NULL, index, false, false, false);
 }
 
 /**
@@ -253,7 +273,7 @@ static inline struct reset_control *of_reset_control_get_exclusive_by_index(
 static inline struct reset_control *of_reset_control_get_shared_by_index(
 					struct device_node *node, int index)
 {
-	return __of_reset_control_get(node, NULL, index, true, false);
+	return __of_reset_control_get(node, NULL, index, true, false, false);
 }
 
 /**
@@ -272,7 +292,7 @@ static inline struct reset_control *
 __must_check devm_reset_control_get_exclusive(struct device *dev,
 					      const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, false);
+	return __devm_reset_control_get(dev, id, 0, false, false, false);
 }
 
 /**
@@ -287,19 +307,19 @@ __must_check devm_reset_control_get_exclusive(struct device *dev,
 static inline struct reset_control *devm_reset_control_get_shared(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, true, false);
+	return __devm_reset_control_get(dev, id, 0, true, false, false);
 }
 
 static inline struct reset_control *devm_reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, true);
+	return __devm_reset_control_get(dev, id, 0, false, true, false);
 }
 
 static inline struct reset_control *devm_reset_control_get_optional_shared(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, true, true);
+	return __devm_reset_control_get(dev, id, 0, true, true, false);
 }
 
 /**
@@ -317,7 +337,7 @@ static inline struct reset_control *devm_reset_control_get_optional_shared(
 static inline struct reset_control *
 devm_reset_control_get_exclusive_by_index(struct device *dev, int index)
 {
-	return __devm_reset_control_get(dev, NULL, index, false, false);
+	return __devm_reset_control_get(dev, NULL, index, false, false, false);
 }
 
 /**
@@ -333,7 +353,7 @@ devm_reset_control_get_exclusive_by_index(struct device *dev, int index)
 static inline struct reset_control *
 devm_reset_control_get_shared_by_index(struct device *dev, int index)
 {
-	return __devm_reset_control_get(dev, NULL, index, true, false);
+	return __devm_reset_control_get(dev, NULL, index, true, false, false);
 }
 
 /*
-- 
2.17.1

