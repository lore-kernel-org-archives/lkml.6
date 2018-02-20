Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeBTXKt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:10:49 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:38070 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeBTXKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:10:16 -0500
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
Subject: [PATCH v4 06/16] of: unittest: changeset helpers
Date: Wed, 21 Feb 2018 01:10:36 +0200
Message-Id: <20180220231046.32638-7-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>

Add a unitest specific for the new changeset helpers.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/of/unittest.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 7a9abaae874d..1b21d2c549a8 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -609,6 +609,59 @@ static void __init of_unittest_changeset(void)
 #endif
 }
 
+static void __init of_unittest_changeset_helper(void)
+{
+#ifdef CONFIG_OF_DYNAMIC
+	struct device_node *n1, *n2, *n21, *parent, *np;
+	struct of_changeset chgset;
+
+	of_changeset_init(&chgset);
+
+	parent = of_find_node_by_path("/testcase-data/changeset");
+
+	unittest(parent, "testcase setup failure\n");
+	n1 = of_changeset_create_device_node(&chgset,
+			parent, "/testcase-data/changeset/n1");
+	unittest(n1, "testcase setup failure\n");
+	n2 = of_changeset_create_device_node(&chgset,
+			parent, "/testcase-data/changeset/n2");
+	unittest(n2, "testcase setup failure\n");
+	n21 = of_changeset_create_device_node(&chgset, n2, "%s/%s",
+			"/testcase-data/changeset/n2", "n21");
+	unittest(n21, "testcase setup failure\n");
+
+	unittest(!of_changeset_add_property_string(&chgset, parent,
+				"prop-add", "foo"), "fail add prop\n");
+
+	unittest(!of_changeset_attach_node(&chgset, n1), "fail n1 attach\n");
+	unittest(!of_changeset_attach_node(&chgset, n2), "fail n2 attach\n");
+	unittest(!of_changeset_attach_node(&chgset, n21), "fail n21 attach\n");
+
+	unittest(!of_changeset_apply(&chgset), "apply failed\n");
+
+	/* Make sure node names are constructed correctly */
+	np = of_find_node_by_path("/testcase-data/changeset/n1");
+	unittest(np, "'%s' not added\n", n1->full_name);
+	of_node_put(np);
+
+	/* Make sure node names are constructed correctly */
+	np = of_find_node_by_path("/testcase-data/changeset/n2");
+	unittest(np, "'%s' not added\n", n2->full_name);
+	of_node_put(np);
+
+	np = of_find_node_by_path("/testcase-data/changeset/n2/n21");
+	unittest(np, "'%s' not added\n", n21->full_name);
+	of_node_put(np);
+
+	unittest(!of_changeset_revert(&chgset), "revert failed\n");
+
+	of_changeset_destroy(&chgset);
+
+	of_node_put(parent);
+#endif
+}
+
+
 static void __init of_unittest_parse_interrupts(void)
 {
 	struct device_node *np;
@@ -2363,6 +2416,7 @@ static int __init of_unittest(void)
 	of_unittest_property_string();
 	of_unittest_property_copy();
 	of_unittest_changeset();
+	of_unittest_changeset_helper();
 	of_unittest_parse_interrupts();
 	of_unittest_parse_interrupts_extended();
 	of_unittest_match_node();
-- 
Regards,

Laurent Pinchart
