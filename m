Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBE4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCB92250E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCB92250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbeKMXdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:33:35 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:43538 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387557AbeKMXde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:33:34 -0500
Received: from ramsan.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id zRbN1y00U3XaVaC01RbNsL; Tue, 13 Nov 2018 14:35:22 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gMYqg-0006Go-8S; Tue, 13 Nov 2018 14:35:22 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gMYqg-0005Re-6j; Tue, 13 Nov 2018 14:35:22 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] reset: Exclusive resets must be dedicated to a single hardware block
Date:   Tue, 13 Nov 2018 14:35:20 +0100
Message-Id: <20181113133520.20889-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some SoCs multiple hardware blocks may share a reset control.
The reset control API for shared resets will only assert such a reset
when the drivers for all hardware blocks agree.
The exclusive reset control API still allows to assert such a reset, but
that impacts all other hardware blocks sharing the reset.

While the kernel doc comments clearly state that the API for shared
resets applies to reset controls which are shared between hardware
blocks, the exact meaning of exclusive resets is not documented.
Fix the semantic ambiguity with respect to exclusive access vs.
exclusive reset lines by:
  1. Clarifying that exclusive resets really are intended for use with
     reset controls which are dedicated to a single hardware block,
  2. Ensuring that obtaining an exclusive reset control will fail if the
     reset is shared by multiple hardware blocks, for both DT-based and
     lookup-based reset controls.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Question from Philipp for the DT maintainers:

   "I'd still like to hear the device tree maintainers' opinion on
    parsing the whole DT for "resets" phandle properties to find shared
    resets like this."

Thanks!

v3:
  - Make args parameter of __of_reset_is_exclusive() a pointer,
  - Print a warning when detecting a shared reset,
  - Rebase on top of of_node_put() move,

v2:
  - Fix wrong variable in __reset_is_dedicated() loop,
  - Add missing of_node_put() in __of_reset_is_dedicated(),
  - Document that exclusive reset controls imply they are dedicated to a
    single hardware block,
  - Drop new dedicated flag and new API reset_control_get_dedicated(),
    as exclusive already implies dedicated,
  - Rename {__of_,}reset_is_dedicated() to {__of_,}reset_is_exclusive(),
  - Reword description.

Note: Exclusive lookup-based reset controls were not tested.
---
 drivers/reset/core.c  | 67 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/reset.h |  5 +++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index d1887c0ed5d3f2aa..65ad7ed82280c83c 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -459,6 +459,42 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
+static bool __of_reset_is_exclusive(const struct device_node *node,
+				    const struct of_phandle_args *args,
+				    const char *id)
+{
+	struct of_phandle_args args2;
+	struct device_node *node2;
+	int index, ret;
+	bool eq;
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
+			eq = (args2.np == args.np &&
+			      args2.args_count == args.args_count &&
+			      !memcmp(args2.args, args.args,
+				      args.args_count * sizeof(args.args[0])));
+			of_node_put(args2.np);
+			if (eq) {
+				pr_warn("%pOF requests exclusive control over reset %s shared with %pOF on %pOF\n",
+					node, id, node2, args->np);
+				return false;
+			}
+		}
+	}
+
+	return true;
+}
+
 struct reset_control *__of_reset_control_get(struct device_node *node,
 				     const char *id, int index, bool shared,
 				     bool optional)
@@ -513,6 +549,11 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
 		goto out;
 	}
 
+	if (!shared && !__of_reset_is_exclusive(node, &args, id)) {
+		rstc = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
 	/* reset_list_mutex also protects the rcdev's reset_control list */
 	rstc = __reset_control_get_internal(rcdev, rstc_id, shared);
 
@@ -542,6 +583,27 @@ __reset_controller_by_name(const char *name)
 	return NULL;
 }
 
+static bool __reset_is_exclusive(const struct reset_control_lookup *lookup)
+{
+	const struct reset_control_lookup *lookup2;
+
+	list_for_each_entry(lookup2, &reset_lookup_list, list) {
+		if (lookup2 == lookup)
+			continue;
+
+		if (lookup2->provider == lookup->provider &&
+		    lookup2->index == lookup->index) {
+			pr_warn("%s/%s requests exclusive control over reset %s:%u shared with %s/%s",
+				lookup->dev_id, lookup->con_id,
+				lookup->provider, lookup->index,
+				lookup2->dev_id, lookup2->con_id);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static struct reset_control *
 __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 				bool shared, bool optional)
@@ -563,6 +625,11 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 		if ((!con_id && !lookup->con_id) ||
 		    ((con_id && lookup->con_id) &&
 		     !strcmp(con_id, lookup->con_id))) {
+			if (!shared && !__reset_is_exclusive(lookup)) {
+				mutex_unlock(&reset_lookup_mutex);
+				return ERR_PTR(-EINVAL);
+			}
+
 			mutex_lock(&reset_list_mutex);
 			rcdev = __reset_controller_by_name(lookup->provider);
 			if (!rcdev) {
diff --git a/include/linux/reset.h b/include/linux/reset.h
index d01ea059e2beee6e..f0b094130686bf32 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -116,8 +116,11 @@ static inline int device_reset_optional(struct device *dev)
  * @id: reset line name
  *
  * Returns a struct reset_control or IS_ERR() condition containing errno.
- * If this function is called more than once for the same reset_control it will
+ * If this function is called more than once for the same reset control it will
  * return -EBUSY.
+ * This function is intended for use with reset controls which are dedicated
+ * to a single hardware block.  If called for a reset control shared among
+ * multiple hardware blocks, it will return -EINVAL.
  *
  * See reset_control_get_shared for details on shared references to
  * reset-controls.
-- 
2.17.1

