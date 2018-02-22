Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeBVAF7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 19:05:59 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:54809 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeBVAE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 19:04:58 -0500
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
Subject: [PATCH v5 3/8] of: dynamic: Add __of_node_dupv()
Date: Thu, 22 Feb 2018 02:05:26 +0200
Message-Id: <20180222000531.19448-4-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222000531.19448-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20180222000531.19448-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>

Add an __of_node_dupv() private method and make __of_node_dup() use it.
This is required for the subsequent changeset accessors which will
make use of it.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
[Make __of_node_dupv() static]
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/of/dynamic.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 7bb33d22b4e2..a2f0c45836f9 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -382,8 +382,9 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
 }
 
 /**
- * __of_node_dup() - Duplicate or create an empty device node dynamically.
- * @fmt: Format string (plus vargs) for new full name of the device node
+ * __of_node_dupv() - Duplicate or create an empty device node dynamically.
+ * @fmt: Format string for new full name of the device node
+ * @vargs: va_list containing the arugments for the node full name
  *
  * Create an device tree node, either by duplicating an empty node or by allocating
  * an empty one suitable for further modification.  The node data are
@@ -391,17 +392,15 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
  * OF_DETACHED bits set. Returns the newly allocated node or NULL on out of
  * memory error.
  */
-struct device_node *__of_node_dup(const struct device_node *np, const char *fmt, ...)
+static struct device_node *__of_node_dupv(const struct device_node *np,
+		const char *fmt, va_list vargs)
 {
-	va_list vargs;
 	struct device_node *node;
 
 	node = kzalloc(sizeof(*node), GFP_KERNEL);
 	if (!node)
 		return NULL;
-	va_start(vargs, fmt);
 	node->full_name = kvasprintf(GFP_KERNEL, fmt, vargs);
-	va_end(vargs);
 	if (!node->full_name) {
 		kfree(node);
 		return NULL;
@@ -433,6 +432,24 @@ struct device_node *__of_node_dup(const struct device_node *np, const char *fmt,
 	return NULL;
 }
 
+/**
+ * __of_node_dup() - Duplicate or create an empty device node dynamically.
+ * @fmt: Format string (plus vargs) for new full name of the device node
+ *
+ * See: __of_node_dupv()
+ */
+struct device_node *__of_node_dup(const struct device_node *np,
+		const char *fmt, ...)
+{
+	va_list vargs;
+	struct device_node *node;
+
+	va_start(vargs, fmt);
+	node = __of_node_dupv(np, fmt, vargs);
+	va_end(vargs);
+	return node;
+}
+
 static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 {
 	of_node_put(ce->np);
-- 
Regards,

Laurent Pinchart
