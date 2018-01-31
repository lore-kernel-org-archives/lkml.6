Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753568AbeAaCiH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:38:07 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39145 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753440AbeAaCgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:36:32 -0500
X-Google-Smtp-Source: AH8x225FvWnjRuLjzyYBbfQbKSV6c9iWDDxQlhk23fEEdaxdrY8ohSS6IWxYJnDbpbcqhgJtoL3iGQ==
From: Stephen Boyd <stephen.boyd@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        devicetree-spec@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 3/4] of: unittest: Add phandle remapping test
Date: Tue, 30 Jan 2018 18:36:17 -0800
Message-Id: <20180131023618.14292-4-stephen.boyd@linaro.org>
X-Mailer: git-send-email 2.14.GIT
In-Reply-To: <20180131023618.14292-1-stephen.boyd@linaro.org>
References: <20180131023618.14292-1-stephen.boyd@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test the functionality of of_parse_phandle_with_args_map().

Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/of/unittest-data/tests-phandle.dtsi |  25 ++++++
 drivers/of/unittest.c                       | 120 ++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/drivers/of/unittest-data/tests-phandle.dtsi b/drivers/of/unittest-data/tests-phandle.dtsi
index 3c2f09e56b61..6b33be4c4416 100644
--- a/drivers/of/unittest-data/tests-phandle.dtsi
+++ b/drivers/of/unittest-data/tests-phandle.dtsi
@@ -26,6 +26,18 @@
 				#phandle-cells = <3>;
 			};
 
+			provider4: provider4 {
+				#phandle-cells = <2>;
+				phandle-map = <0 1 &provider1 3>,
+					      <4 0 &provider0>,
+					      <16 5 &provider3 3 5 0>,
+					      <200 8 &provider2 23 6>,
+					      <19 0 &provider2 15 0>,
+					      <2 3 &provider3 2 5 3>;
+				phandle-map-mask = <0xff 0xf>;
+				phandle-map-pass-thru = <0x0 0xf0>;
+			};
+
 			consumer-a {
 				phandle-list =	<&provider1 1>,
 						<&provider2 2 0>,
@@ -44,6 +56,19 @@
 				unterminated-string = [40 41 42 43];
 				unterminated-string-list = "first", "second", [40 41 42 43];
 			};
+
+			consumer-b {
+				phandle-list =	<&provider1 1>,
+						<&provider4 2 3>,
+						<0>,
+						<&provider4 4 0x100>,
+						<&provider4 0 0x61>,
+						<&provider0>,
+						<&provider4 19 0x20>;
+				phandle-list-bad-phandle = <12345678 0 0>;
+				phandle-list-bad-args = <&provider2 1 0>,
+							<&provider4 0>;
+			};
 		};
 	};
 };
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 0f8052f1355c..de27f62a8e8d 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -452,6 +452,125 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 }
 
+static void __init of_unittest_parse_phandle_with_args_map(void)
+{
+	struct device_node *np, *p0, *p1, *p2, *p3;
+	struct of_phandle_args args;
+	int i, rc;
+
+	np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-b");
+	if (!np) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	p0 = of_find_node_by_path("/testcase-data/phandle-tests/provider0");
+	if (!p0) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	p1 = of_find_node_by_path("/testcase-data/phandle-tests/provider1");
+	if (!p1) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	p2 = of_find_node_by_path("/testcase-data/phandle-tests/provider2");
+	if (!p2) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	p3 = of_find_node_by_path("/testcase-data/phandle-tests/provider3");
+	if (!p3) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	rc = of_count_phandle_with_args(np, "phandle-list", "#phandle-cells");
+	unittest(rc == 7, "of_count_phandle_with_args() returned %i, expected 7\n", rc);
+
+	for (i = 0; i < 8; i++) {
+		bool passed = true;
+
+		rc = of_parse_phandle_with_args_map(np, "phandle-list",
+						    "phandle", i, &args);
+
+		/* Test the values from tests-phandle.dtsi */
+		switch (i) {
+		case 0:
+			passed &= !rc;
+			passed &= (args.np == p1);
+			passed &= (args.args_count == 1);
+			passed &= (args.args[0] == 1);
+			break;
+		case 1:
+			passed &= !rc;
+			passed &= (args.np == p3);
+			passed &= (args.args_count == 3);
+			passed &= (args.args[0] == 2);
+			passed &= (args.args[1] == 5);
+			passed &= (args.args[2] == 3);
+			break;
+		case 2:
+			passed &= (rc == -ENOENT);
+			break;
+		case 3:
+			passed &= !rc;
+			passed &= (args.np == p0);
+			passed &= (args.args_count == 0);
+			break;
+		case 4:
+			passed &= !rc;
+			passed &= (args.np == p1);
+			passed &= (args.args_count == 1);
+			passed &= (args.args[0] == 3);
+			break;
+		case 5:
+			passed &= !rc;
+			passed &= (args.np == p0);
+			passed &= (args.args_count == 0);
+			break;
+		case 6:
+			passed &= !rc;
+			passed &= (args.np == p2);
+			passed &= (args.args_count == 2);
+			passed &= (args.args[0] == 15);
+			passed &= (args.args[1] == 0x20);
+			break;
+		case 7:
+			passed &= (rc == -ENOENT);
+			break;
+		default:
+			passed = false;
+		}
+
+		unittest(passed, "index %i - data error on node %s rc=%i\n",
+			 i, args.np->full_name, rc);
+	}
+
+	/* Check for missing list property */
+	rc = of_parse_phandle_with_args_map(np, "phandle-list-missing",
+					    "phandle", 0, &args);
+	unittest(rc == -ENOENT, "expected:%i got:%i\n", -ENOENT, rc);
+
+	/* Check for missing cells,map,mask property */
+	rc = of_parse_phandle_with_args_map(np, "phandle-list",
+					    "phandle-missing", 0, &args);
+	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
+
+	/* Check for bad phandle in list */
+	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-phandle",
+					    "phandle", 0, &args);
+	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
+
+	/* Check for incorrectly formed argument list */
+	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-args",
+					    "phandle", 1, &args);
+	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
+}
+
 static void __init of_unittest_property_string(void)
 {
 	const char *strings[4];
@@ -2354,6 +2473,7 @@ static int __init of_unittest(void)
 	of_unittest_find_node_by_name();
 	of_unittest_dynamic();
 	of_unittest_parse_phandle_with_args();
+	of_unittest_parse_phandle_with_args_map();
 	of_unittest_printf();
 	of_unittest_property_string();
 	of_unittest_property_copy();
-- 
2.14.GIT
