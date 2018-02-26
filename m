Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeBZCXk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 21:23:40 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34443 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeBZCX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 21:23:26 -0500
X-Google-Smtp-Source: AH8x224fM3Z9IQm0A6pLPyhvJirDEL884yvhmQzQUCLNTFCX22yqVUaYLnCUQo1i1mQIGReqTImlGA==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: [PATCH 2/6] of: remove kbasename(of->full_name) from overlay related code
Date: Sun, 25 Feb 2018 18:22:26 -0800
Message-Id: <1519611750-22355-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519611750-22355-1-git-send-email-frowand.list@gmail.com>
References: <1519611750-22355-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Struct device_node full_name no longer includes the full path
name.  The overlay node creation code was not modified to
reflect this change.  Fix the node names generate by overlay
code to contain only the basename.

Unittests call an overlay internal function to create new nodes.
Fix up these calls to provide basename only instead of the full
path.

Fixes: a7e4cfb0a7ca ("of/fdt: only store the device node basename
in full_name")

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/dynamic.c    | 21 ++++++++++-----------
 drivers/of/of_private.h |  3 ++-
 drivers/of/overlay.c    |  8 ++------
 drivers/of/resolver.c   |  5 +----
 drivers/of/unittest.c   |  6 +++---
 5 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 7bb33d22b4e2..f4f8ed9b5454 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -383,25 +383,24 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
 
 /**
  * __of_node_dup() - Duplicate or create an empty device node dynamically.
- * @fmt: Format string (plus vargs) for new full name of the device node
+ * @np:		if not NULL, contains properties to be duplicated in new node
+ * @full_name:	string value to be duplicated into new node's full_name field
  *
- * Create an device tree node, either by duplicating an empty node or by allocating
- * an empty one suitable for further modification.  The node data are
- * dynamically allocated and all the node flags have the OF_DYNAMIC &
- * OF_DETACHED bits set. Returns the newly allocated node or NULL on out of
- * memory error.
+ * Create a device tree node, optionally duplicating the properties of
+ * another node.  The node data are dynamically allocated and all the node
+ * flags have the OF_DYNAMIC & OF_DETACHED bits set.
+ *
+ * Returns the newly allocated node or NULL on out of memory error.
  */
-struct device_node *__of_node_dup(const struct device_node *np, const char *fmt, ...)
+struct device_node *__of_node_dup(const struct device_node *np,
+				  const char *full_name)
 {
-	va_list vargs;
 	struct device_node *node;
 
 	node = kzalloc(sizeof(*node), GFP_KERNEL);
 	if (!node)
 		return NULL;
-	va_start(vargs, fmt);
-	node->full_name = kvasprintf(GFP_KERNEL, fmt, vargs);
-	va_end(vargs);
+	node->full_name = kstrdup(full_name, GFP_KERNEL);
 	if (!node->full_name) {
 		kfree(node);
 		return NULL;
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 0c609e7d0334..26bb31beb03e 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -104,7 +104,8 @@ extern void *__unflatten_device_tree(const void *blob,
  * own the devtree lock or work on detached trees only.
  */
 struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags);
-__printf(2, 3) struct device_node *__of_node_dup(const struct device_node *np, const char *fmt, ...);
+struct device_node *__of_node_dup(const struct device_node *np,
+				  const char *full_name);
 
 struct device_node *__of_find_node_by_path(struct device_node *parent,
 						const char *path);
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 3397d7642958..b9df55e0a656 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -323,19 +323,15 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 static int add_changeset_node(struct overlay_changeset *ovcs,
 		struct device_node *target_node, struct device_node *node)
 {
-	const char *node_kbasename;
 	struct device_node *tchild;
 	int ret = 0;
 
-	node_kbasename = kbasename(node->full_name);
-
 	for_each_child_of_node(target_node, tchild)
-		if (!of_node_cmp(node_kbasename, kbasename(tchild->full_name)))
+		if (!of_node_cmp(node->full_name, tchild->full_name))
 			break;
 
 	if (!tchild) {
-		tchild = __of_node_dup(node, "%pOF/%s",
-				       target_node, node_kbasename);
+		tchild = __of_node_dup(node, node->full_name);
 		if (!tchild)
 			return -ENOMEM;
 
diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 740d19bde601..0e0969f58216 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -137,10 +137,7 @@ static int update_usages_of_a_phandle_reference(struct device_node *overlay,
 static int node_name_cmp(const struct device_node *dn1,
 		const struct device_node *dn2)
 {
-	const char *n1 = kbasename(dn1->full_name);
-	const char *n2 = kbasename(dn2->full_name);
-
-	return of_node_cmp(n1, n2);
+	return of_node_cmp(dn1->full_name, dn2->full_name);
 }
 
 /*
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 490bbee0cf87..acf233c34ef7 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -571,13 +571,13 @@ static void __init of_unittest_changeset(void)
 	struct device_node *n1, *n2, *n21, *nchangeset, *nremove, *parent, *np;
 	struct of_changeset chgset;
 
-	n1 = __of_node_dup(NULL, "/testcase-data/changeset/n1");
+	n1 = __of_node_dup(NULL, "n1");
 	unittest(n1, "testcase setup failure\n");
 
-	n2 = __of_node_dup(NULL, "/testcase-data/changeset/n2");
+	n2 = __of_node_dup(NULL, "n2");
 	unittest(n2, "testcase setup failure\n");
 
-	n21 = __of_node_dup(NULL, "%s/%s", "/testcase-data/changeset/n2", "n21");
+	n21 = __of_node_dup(NULL, "n21");
 	unittest(n21, "testcase setup failure %p\n", n21);
 
 	nchangeset = of_find_node_by_path("/testcase-data/changeset");
-- 
Frank Rowand <frank.rowand@sony.com>
