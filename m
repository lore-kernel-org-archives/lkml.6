Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeBZCYz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 21:24:55 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41632 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeBZCXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 21:23:25 -0500
X-Google-Smtp-Source: AH8x227QjWj0PxqwOr9prmsQHiMhBWH8MQnVKuuKXzZY8vu3Tf9Ps9cbsOdNWGD8nrN2e7maIdMLdQ==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: [PATCH 1/6] of: unittest: clean up changeset test
Date: Sun, 25 Feb 2018 18:22:25 -0800
Message-Id: <1519611750-22355-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519611750-22355-1-git-send-email-frowand.list@gmail.com>
References: <1519611750-22355-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

In preparation for fixing __of_node_dup(), clean up the unittest
function that calls it.

Devicetree nodes created from a flattened device tree have a name
property.  Follow this convention for nodes added by a changeset.

For node added by changeset, remove incorrect initialization of
child node pointer.

Add an additional node pointer 'changeset' to more naturally reflect
where in the tree the changeset is added.

Make changeset add property error messages unique.

Add whitespace to break apart logic blocks.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

checkpatch warnings for "line over 80 characters" are for unittest
code in a function with long lines as a normal style.


 drivers/of/unittest.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 7a9abaae874d..490bbee0cf87 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -562,42 +562,72 @@ static void __init of_unittest_property_copy(void)
 static void __init of_unittest_changeset(void)
 {
 #ifdef CONFIG_OF_DYNAMIC
-	struct property *ppadd, padd = { .name = "prop-add", .length = 0, .value = "" };
+	struct property *ppadd, padd = { .name = "prop-add", .length = 1, .value = "" };
+	struct property *ppname_n1,  pname_n1  = { .name = "name", .length = 3, .value = "n1"  };
+	struct property *ppname_n2,  pname_n2  = { .name = "name", .length = 3, .value = "n2"  };
+	struct property *ppname_n21, pname_n21 = { .name = "name", .length = 3, .value = "n21" };
 	struct property *ppupdate, pupdate = { .name = "prop-update", .length = 5, .value = "abcd" };
 	struct property *ppremove;
-	struct device_node *n1, *n2, *n21, *nremove, *parent, *np;
+	struct device_node *n1, *n2, *n21, *nchangeset, *nremove, *parent, *np;
 	struct of_changeset chgset;
 
 	n1 = __of_node_dup(NULL, "/testcase-data/changeset/n1");
 	unittest(n1, "testcase setup failure\n");
+
 	n2 = __of_node_dup(NULL, "/testcase-data/changeset/n2");
 	unittest(n2, "testcase setup failure\n");
+
 	n21 = __of_node_dup(NULL, "%s/%s", "/testcase-data/changeset/n2", "n21");
 	unittest(n21, "testcase setup failure %p\n", n21);
-	nremove = of_find_node_by_path("/testcase-data/changeset/node-remove");
+
+	nchangeset = of_find_node_by_path("/testcase-data/changeset");
+	nremove = of_get_child_by_name(nchangeset, "node-remove");
 	unittest(nremove, "testcase setup failure\n");
+
 	ppadd = __of_prop_dup(&padd, GFP_KERNEL);
 	unittest(ppadd, "testcase setup failure\n");
+
+	ppname_n1  = __of_prop_dup(&pname_n1, GFP_KERNEL);
+	unittest(ppname_n1, "testcase setup failure\n");
+
+	ppname_n2  = __of_prop_dup(&pname_n2, GFP_KERNEL);
+	unittest(ppname_n2, "testcase setup failure\n");
+
+	ppname_n21 = __of_prop_dup(&pname_n21, GFP_KERNEL);
+	unittest(ppname_n21, "testcase setup failure\n");
+
 	ppupdate = __of_prop_dup(&pupdate, GFP_KERNEL);
 	unittest(ppupdate, "testcase setup failure\n");
-	parent = nremove->parent;
+
+	parent = nchangeset;
 	n1->parent = parent;
 	n2->parent = parent;
 	n21->parent = n2;
-	n2->child = n21;
+
 	ppremove = of_find_property(parent, "prop-remove", NULL);
 	unittest(ppremove, "failed to find removal prop");
 
 	of_changeset_init(&chgset);
+
 	unittest(!of_changeset_attach_node(&chgset, n1), "fail attach n1\n");
+	unittest(!of_changeset_add_property(&chgset, n1, ppname_n1), "fail add prop name\n");
+
 	unittest(!of_changeset_attach_node(&chgset, n2), "fail attach n2\n");
+	unittest(!of_changeset_add_property(&chgset, n2, ppname_n2), "fail add prop name\n");
+
 	unittest(!of_changeset_detach_node(&chgset, nremove), "fail remove node\n");
+	unittest(!of_changeset_add_property(&chgset, n21, ppname_n21), "fail add prop name\n");
+
 	unittest(!of_changeset_attach_node(&chgset, n21), "fail attach n21\n");
-	unittest(!of_changeset_add_property(&chgset, parent, ppadd), "fail add prop\n");
+
+	unittest(!of_changeset_add_property(&chgset, parent, ppadd), "fail add prop prop-add\n");
 	unittest(!of_changeset_update_property(&chgset, parent, ppupdate), "fail update prop\n");
 	unittest(!of_changeset_remove_property(&chgset, parent, ppremove), "fail remove prop\n");
+
 	unittest(!of_changeset_apply(&chgset), "apply failed\n");
 
+	of_node_put(nchangeset);
+
 	/* Make sure node names are constructed correctly */
 	unittest((np = of_find_node_by_path("/testcase-data/changeset/n2/n21")),
 		 "'%pOF' not added\n", n21);
-- 
Frank Rowand <frank.rowand@sony.com>
