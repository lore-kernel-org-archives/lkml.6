Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933451AbeCBVFy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:05:54 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43909 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933386AbeCBVFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:05:48 -0500
X-Google-Smtp-Source: AG47ELs0HcAsuXPfN/dYmDW5gXlaP0ZR/QecR/QChyN+iiXt7fwqxR/696GMCeUuWwjb/xHNZ4O19Q==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, laurent.pinchart+renesas@ideasonboard.com
Subject: [PATCH v6 1/4] of: change overlay apply input data from unflattened to FDT
Date: Fri,  2 Mar 2018 13:04:57 -0800
Message-Id: <1520024700-31315-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520024700-31315-1-git-send-email-frowand.list@gmail.com>
References: <1520024700-31315-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Move duplicating and unflattening of an overlay flattened devicetree
(FDT) into the overlay application code.  To accomplish this,
of_overlay_apply() is replaced by of_overlay_fdt_apply().

The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
code, which is thus responsible for freeing the duplicate FDT.  The
caller of of_overlay_fdt_apply() remains responsible for freeing the
original FDT.

The unflattened devicetree now belongs to devicetree code, which is
thus responsible for freeing the unflattened devicetree.

These ownership changes prevent early freeing of the duplicated FDT
or the unflattened devicetree, which could result in use after free
errors.

of_overlay_fdt_apply() is a private function for the anticipated
overlay loader.

Update unittest.c to use of_overlay_fdt_apply() instead of
of_overlay_apply().

Move overlay fragments from artificial locations in
drivers/of/unittest-data/tests-overlay.dtsi into one devicetree
source file per overlay.  This led to changes in
drivers/of/unitest-data/Makefile and drivers/of/unitest.c.

  - Add overlay directives to the overlay devicetree source files so
    that dtc will compile them as true overlays into one FDT data
    chunk per overlay.

  - Set CFLAGS for drivers/of/unittest-data/testcases.dts so that
    symbols will be generated for overlay resolution of overlays
    that are no longer artificially contained in testcases.dts

  - Unflatten and apply each unittest overlay FDT using
    of_overlay_fdt_apply().

  - Enable the of_resolve_phandles() check for whether the unflattened
    overlay is detached.  This check was previously disabled because the
    overlays from tests-overlay.dtsi were not unflattened into detached
    trees.

  - Other changes to unittest.c infrastructure to manage multiple test
    FDTs built into the kernel image (access by name instead of
    arbitrary number).

  - of_unittest_overlay_high_level(): previously unused code to add
    properties from the overlay_base devicetree to the live tree
    was triggered by the restructuring of tests-overlay.dtsi and thus
    testcases.dts.  This exposed two bugs: (1) the need to dup a
    property before adding it, and (2) property 'name' is
    auto-generated in the unflatten code and thus will be a duplicate
    in the __symbols__ node - do not treat this duplicate as an error.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

There are checkpatch warnings.  I have reviewed them and feel they
can be ignored.  They are "line over 80 characters" for either
pre-existing long lines, or lines in devicetree source files.

Rob, I have added making unittest a loadable module to my todo list.

Changes from v5:
  - Add __init to of_unittest_apply_revert_overlay_check(),
    of_unittest_overlay_5(), and of_unittest_overlay_11() to fix
    compile warnings reported by Geert

Changes from v4:
  - move of_overlay_fdt_apply() prototype from of_private.h to of.h
  - of_overlay_apply(): add kfree(fdt) if resolve phandles or
    initialize changeset fail
  - of_overlay_fdt_apply(): add parameter size of overlay_fdt and use
    it for some additional validation of the overlay fdt
  - update unittest.c with additional parameter to of_overlay_fdt_apply()

Changes from v3:
  - OF_OVERLAY: add select OF_FLATTREE

Changes from v1:
  - rebase on v4.16-rc1

 drivers/of/Kconfig                          |   1 +
 drivers/of/overlay.c                        | 112 ++++++++++-
 drivers/of/resolver.c                       |   6 -
 drivers/of/unittest-data/Makefile           |  28 ++-
 drivers/of/unittest-data/overlay_0.dts      |  14 ++
 drivers/of/unittest-data/overlay_1.dts      |  14 ++
 drivers/of/unittest-data/overlay_10.dts     |  34 ++++
 drivers/of/unittest-data/overlay_11.dts     |  34 ++++
 drivers/of/unittest-data/overlay_12.dts     |  14 ++
 drivers/of/unittest-data/overlay_13.dts     |  14 ++
 drivers/of/unittest-data/overlay_15.dts     |  35 ++++
 drivers/of/unittest-data/overlay_2.dts      |  14 ++
 drivers/of/unittest-data/overlay_3.dts      |  14 ++
 drivers/of/unittest-data/overlay_4.dts      |  23 +++
 drivers/of/unittest-data/overlay_5.dts      |  14 ++
 drivers/of/unittest-data/overlay_6.dts      |  15 ++
 drivers/of/unittest-data/overlay_7.dts      |  15 ++
 drivers/of/unittest-data/overlay_8.dts      |  15 ++
 drivers/of/unittest-data/overlay_9.dts      |  15 ++
 drivers/of/unittest-data/tests-overlay.dtsi | 213 --------------------
 drivers/of/unittest.c                       | 300 ++++++++++++++--------------
 include/linux/of.h                          |   6 +-
 22 files changed, 562 insertions(+), 388 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_0.dts
 create mode 100644 drivers/of/unittest-data/overlay_1.dts
 create mode 100644 drivers/of/unittest-data/overlay_10.dts
 create mode 100644 drivers/of/unittest-data/overlay_11.dts
 create mode 100644 drivers/of/unittest-data/overlay_12.dts
 create mode 100644 drivers/of/unittest-data/overlay_13.dts
 create mode 100644 drivers/of/unittest-data/overlay_15.dts
 create mode 100644 drivers/of/unittest-data/overlay_2.dts
 create mode 100644 drivers/of/unittest-data/overlay_3.dts
 create mode 100644 drivers/of/unittest-data/overlay_4.dts
 create mode 100644 drivers/of/unittest-data/overlay_5.dts
 create mode 100644 drivers/of/unittest-data/overlay_6.dts
 create mode 100644 drivers/of/unittest-data/overlay_7.dts
 create mode 100644 drivers/of/unittest-data/overlay_8.dts
 create mode 100644 drivers/of/unittest-data/overlay_9.dts

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 783e0870bd22..ad3fcad4d75b 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -92,6 +92,7 @@ config OF_RESOLVE
 config OF_OVERLAY
 	bool "Device Tree overlays"
 	select OF_DYNAMIC
+	select OF_FLATTREE
 	select OF_RESOLVE
 	help
 	  Overlays are a method to dynamically modify part of the kernel's
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 3397d7642958..e3d7f69a8333 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -12,10 +12,12 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_fdt.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
+#include <linux/libfdt.h>
 #include <linux/err.h>
 #include <linux/idr.h>
 
@@ -33,7 +35,9 @@ struct fragment {
 
 /**
  * struct overlay_changeset
+ * @id:			changeset identifier
  * @ovcs_list:		list on which we are located
+ * @fdt:		FDT that was unflattened to create @overlay_tree
  * @overlay_tree:	expanded device tree that contains the fragment nodes
  * @count:		count of fragment structures
  * @fragments:		fragment nodes in the overlay expanded device tree
@@ -43,6 +47,7 @@ struct fragment {
 struct overlay_changeset {
 	int id;
 	struct list_head ovcs_list;
+	const void *fdt;
 	struct device_node *overlay_tree;
 	int count;
 	struct fragment *fragments;
@@ -503,7 +508,8 @@ static struct device_node *find_target_node(struct device_node *info_node)
 
 /**
  * init_overlay_changeset() - initialize overlay changeset from overlay tree
- * @ovcs	Overlay changeset to build
+ * @ovcs:	Overlay changeset to build
+ * @fdt:	the FDT that was unflattened to create @tree
  * @tree:	Contains all the overlay fragments and overlay fixup nodes
  *
  * Initialize @ovcs.  Populate @ovcs->fragments with node information from
@@ -514,7 +520,7 @@ static struct device_node *find_target_node(struct device_node *info_node)
  * detected in @tree, or -ENOSPC if idr_alloc() error.
  */
 static int init_overlay_changeset(struct overlay_changeset *ovcs,
-		struct device_node *tree)
+		const void *fdt, struct device_node *tree)
 {
 	struct device_node *node, *overlay_node;
 	struct fragment *fragment;
@@ -535,6 +541,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 		pr_debug("%s() tree is not root\n", __func__);
 
 	ovcs->overlay_tree = tree;
+	ovcs->fdt = fdt;
 
 	INIT_LIST_HEAD(&ovcs->ovcs_list);
 
@@ -606,6 +613,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 	}
 
 	if (!cnt) {
+		pr_err("no fragments or symbols in overlay\n");
 		ret = -EINVAL;
 		goto err_free_fragments;
 	}
@@ -642,11 +650,24 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 	}
 	kfree(ovcs->fragments);
 
+	/*
+	 * TODO
+	 *
+	 * would like to: kfree(ovcs->overlay_tree);
+	 * but can not since drivers may have pointers into this data
+	 *
+	 * would like to: kfree(ovcs->fdt);
+	 * but can not since drivers may have pointers into this data
+	 */
+
 	kfree(ovcs);
 }
 
-/**
+/*
+ * internal documentation
+ *
  * of_overlay_apply() - Create and apply an overlay changeset
+ * @fdt:	the FDT that was unflattened to create @tree
  * @tree:	Expanded overlay device tree
  * @ovcs_id:	Pointer to overlay changeset id
  *
@@ -685,21 +706,29 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * id is returned to *ovcs_id.
  */
 
-int of_overlay_apply(struct device_node *tree, int *ovcs_id)
+static int of_overlay_apply(const void *fdt, struct device_node *tree,
+		int *ovcs_id)
 {
 	struct overlay_changeset *ovcs;
 	int ret = 0, ret_revert, ret_tmp;
 
-	*ovcs_id = 0;
+	/*
+	 * As of this point, fdt and tree belong to the overlay changeset.
+	 * overlay changeset code is responsible for freeing them.
+	 */
 
 	if (devicetree_corrupt()) {
 		pr_err("devicetree state suspect, refuse to apply overlay\n");
+		kfree(fdt);
+		kfree(tree);
 		ret = -EBUSY;
 		goto out;
 	}
 
 	ovcs = kzalloc(sizeof(*ovcs), GFP_KERNEL);
 	if (!ovcs) {
+		kfree(fdt);
+		kfree(tree);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -709,12 +738,17 @@ int of_overlay_apply(struct device_node *tree, int *ovcs_id)
 
 	ret = of_resolve_phandles(tree);
 	if (ret)
-		goto err_free_overlay_changeset;
+		goto err_free_tree;
 
-	ret = init_overlay_changeset(ovcs, tree);
+	ret = init_overlay_changeset(ovcs, fdt, tree);
 	if (ret)
-		goto err_free_overlay_changeset;
+		goto err_free_tree;
 
+	/*
+	 * after overlay_notify(), ovcs->overlay_tree related pointers may have
+	 * leaked to drivers, so can not kfree() tree, aka ovcs->overlay_tree;
+	 * and can not free fdt, aka ovcs->fdt
+	 */
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
 	if (ret) {
 		pr_err("overlay changeset pre-apply notify error %d\n", ret);
@@ -754,6 +788,10 @@ int of_overlay_apply(struct device_node *tree, int *ovcs_id)
 
 	goto out_unlock;
 
+err_free_tree:
+	kfree(fdt);
+	kfree(tree);
+
 err_free_overlay_changeset:
 	free_overlay_changeset(ovcs);
 
@@ -766,7 +804,63 @@ int of_overlay_apply(struct device_node *tree, int *ovcs_id)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(of_overlay_apply);
+
+int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
+			 int *ovcs_id)
+{
+	const void *new_fdt;
+	int ret;
+	u32 size;
+	struct device_node *overlay_root;
+
+	*ovcs_id = 0;
+	ret = 0;
+
+	if (overlay_fdt_size < sizeof(struct fdt_header) ||
+	    fdt_check_header(overlay_fdt)) {
+		pr_err("Invalid overlay_fdt header\n");
+		return -EINVAL;
+	}
+
+	size = fdt_totalsize(overlay_fdt);
+	if (overlay_fdt_size < size)
+		return -EINVAL;
+
+	/*
+	 * Must create permanent copy of FDT because of_fdt_unflatten_tree()
+	 * will create pointers to the passed in FDT in the unflattened tree.
+	 */
+	new_fdt = kmemdup(overlay_fdt, size, GFP_KERNEL);
+	if (!new_fdt)
+		return -ENOMEM;
+
+	of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);
+	if (!overlay_root) {
+		pr_err("unable to unflatten overlay_fdt\n");
+		ret = -EINVAL;
+		goto out_free_new_fdt;
+	}
+
+	ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
+	if (ret < 0) {
+		/*
+		 * new_fdt and overlay_root now belong to the overlay
+		 * changeset.
+		 * overlay changeset code is responsible for freeing them.
+		 */
+		goto out;
+	}
+
+	return 0;
+
+
+out_free_new_fdt:
+	kfree(new_fdt);
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_overlay_fdt_apply);
 
 /*
  * Find @np in @tree.
diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 740d19bde601..b2f645187213 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -269,17 +269,11 @@ int of_resolve_phandles(struct device_node *overlay)
 		goto out;
 	}
 
-#if 0
-	Temporarily disable check so that old style overlay unittests
-	do not fail when of_resolve_phandles() is moved into
-	of_overlay_apply().
-
 	if (!of_node_check_flag(overlay, OF_DETACHED)) {
 		pr_err("overlay not detached\n");
 		err = -EINVAL;
 		goto out;
 	}
-#endif
 
 	phandle_delta = live_tree_max_phandle() + 1;
 	adjust_overlay_phandles(overlay, phandle_delta);
diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index df697976740a..8fd0ea4b92b0 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -1,8 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0
-DTC_FLAGS_testcases := -Wno-interrupts_property
 obj-y += testcases.dtb.o
 
 obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
+			    overlay_0.dtb.o \
+			    overlay_1.dtb.o \
+			    overlay_2.dtb.o \
+			    overlay_3.dtb.o \
+			    overlay_4.dtb.o \
+			    overlay_5.dtb.o \
+			    overlay_6.dtb.o \
+			    overlay_7.dtb.o \
+			    overlay_8.dtb.o \
+			    overlay_9.dtb.o \
+			    overlay_10.dtb.o \
+			    overlay_11.dtb.o \
+			    overlay_12.dtb.o \
+			    overlay_13.dtb.o \
+			    overlay_15.dtb.o \
 			    overlay_bad_phandle.dtb.o \
 			    overlay_bad_symbol.dtb.o \
 			    overlay_base.dtb.o
@@ -10,10 +24,14 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
 targets += $(foreach suffix, dtb dtb.S, $(patsubst %.dtb.o,%.$(suffix),$(obj-y)))
 
 # enable creation of __symbols__ node
-DTC_FLAGS_overlay := -@
-DTC_FLAGS_overlay_bad_phandle := -@
-DTC_FLAGS_overlay_bad_symbol := -@
-DTC_FLAGS_overlay_base := -@
+DTC_FLAGS_overlay += -@
+DTC_FLAGS_overlay_bad_phandle += -@
+DTC_FLAGS_overlay_bad_symbol += -@
+DTC_FLAGS_overlay_base += -@
+DTC_FLAGS_testcases += -@
+
+# suppress warnings about intentional errors
+DTC_FLAGS_testcases += -Wno-interrupts_property
 
 .PRECIOUS: \
 	$(obj)/%.dtb.S \
diff --git a/drivers/of/unittest-data/overlay_0.dts b/drivers/of/unittest-data/overlay_0.dts
new file mode 100644
index 000000000000..ac0f9e0fe65f
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_0.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_0 - enable using absolute target path */
+
+	fragment@0 {
+		target-path = "/testcase-data/overlay-node/test-bus/test-unittest0";
+		__overlay__ {
+			status = "okay";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_1.dts b/drivers/of/unittest-data/overlay_1.dts
new file mode 100644
index 000000000000..e92a626e2948
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_1.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_1 - disable using absolute target path */
+
+	fragment@0 {
+		target-path = "/testcase-data/overlay-node/test-bus/test-unittest1";
+		__overlay__ {
+			status = "disabled";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_10.dts b/drivers/of/unittest-data/overlay_10.dts
new file mode 100644
index 000000000000..445925a10cd3
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_10.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_10 */
+	/* overlays 8, 9, 10, 11 application and removal in bad sequence */
+
+	fragment@0 {
+		target-path = "/testcase-data/overlay-node/test-bus";
+		__overlay__ {
+
+			/* suppress DTC warning */
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			test-unittest10 {
+				compatible = "unittest";
+				status = "okay";
+				reg = <10>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				test-unittest101 {
+					compatible = "unittest";
+					status = "okay";
+					reg = <1>;
+				};
+
+			};
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_11.dts b/drivers/of/unittest-data/overlay_11.dts
new file mode 100644
index 000000000000..c1d14f34359e
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_11.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_11 */
+	/* overlays 8, 9, 10, 11 application and removal in bad sequence */
+
+	fragment@0 {
+		target-path = "/testcase-data/overlay-node/test-bus";
+		__overlay__ {
+
+			/* suppress DTC warning */
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			test-unittest11 {
+				compatible = "unittest";
+				status = "okay";
+				reg = <11>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				test-unittest111 {
+					compatible = "unittest";
+					status = "okay";
+					reg = <1>;
+				};
+
+			};
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_12.dts b/drivers/of/unittest-data/overlay_12.dts
new file mode 100644
index 000000000000..ca3441e2cbec
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_12.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_12 - enable using absolute target path (i2c) */
+
+	fragment@0 {
+		target-path = "/testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest12";
+		__overlay__ {
+			status = "okay";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_13.dts b/drivers/of/unittest-data/overlay_13.dts
new file mode 100644
index 000000000000..3c30dec63894
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_13.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_13 - disable using absolute target path (i2c) */
+
+	fragment@0 {
+		target-path = "/testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest13";
+		__overlay__ {
+			status = "disabled";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_15.dts b/drivers/of/unittest-data/overlay_15.dts
new file mode 100644
index 000000000000..44e44c62b739
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_15.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_15 - mux overlay */
+
+	fragment@0 {
+		target-path = "/testcase-data/overlay-node/test-bus/i2c-test-bus";
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			test-unittest15 {
+				reg = <11>;
+				compatible = "unittest-i2c-mux";
+				status = "okay";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					test-mux-dev {
+						reg = <32>;
+						compatible = "unittest-i2c-dev";
+						status = "okay";
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_2.dts b/drivers/of/unittest-data/overlay_2.dts
new file mode 100644
index 000000000000..cf1e4245b7ce
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_2.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_2 -  enable using label */
+
+	fragment@0 {
+		target = <&unittest2>;
+		__overlay__ {
+			status = "okay";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_3.dts b/drivers/of/unittest-data/overlay_3.dts
new file mode 100644
index 000000000000..158dc44fc20a
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_3.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_3 - disable using label */
+
+	fragment@0 {
+		target = <&unittest3>;
+		__overlay__ {
+			status = "disabled";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_4.dts b/drivers/of/unittest-data/overlay_4.dts
new file mode 100644
index 000000000000..b4a2e6c6b016
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_4.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_4 - test insertion of a full node */
+
+	fragment@0 {
+		target = <&unittestbus>;
+		__overlay__ {
+
+			/* suppress DTC warning */
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			test-unittest4 {
+				compatible = "unittest";
+				status = "okay";
+				reg = <4>;
+			};
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_5.dts b/drivers/of/unittest-data/overlay_5.dts
new file mode 100644
index 000000000000..02ad25c1f19c
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_5.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_5 - test overlay apply revert */
+
+	fragment@0 {
+		target-path = "/testcase-data/overlay-node/test-bus/test-unittest5";
+		__overlay__ {
+			status = "okay";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_6.dts b/drivers/of/unittest-data/overlay_6.dts
new file mode 100644
index 000000000000..a14e965f5497
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_6.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_6 */
+	/* overlays 6, 7 application and removal in sequence */
+
+	fragment@0 {
+		target-path = "/testcase-data/overlay-node/test-bus/test-unittest6";
+		__overlay__ {
+			status = "okay";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_7.dts b/drivers/of/unittest-data/overlay_7.dts
new file mode 100644
index 000000000000..4bd7e423209c
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_7.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_7 */
+	/* overlays 6, 7 application and removal in sequence */
+
+	fragment@0 {
+		target-path = "/testcase-data/overlay-node/test-bus/test-unittest7";
+		__overlay__ {
+			status = "okay";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_8.dts b/drivers/of/unittest-data/overlay_8.dts
new file mode 100644
index 000000000000..5b21c53945a9
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_8.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_8 */
+	/* overlays 8, 9, 10, 11 application and removal in bad sequence */
+
+	fragment@0 {
+		target-path = "/testcase-data/overlay-node/test-bus/test-unittest8";
+		__overlay__ {
+			status = "okay";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_9.dts b/drivers/of/unittest-data/overlay_9.dts
new file mode 100644
index 000000000000..20ff055a5349
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_9.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* overlay_9 */
+	/* overlays 8, 9, 10, 11 application and removal in bad sequence */
+
+	fragment@0 {
+		target-path = "/testcase-data/overlay-node/test-bus/test-unittest8";
+		__overlay__ {
+			property-foo = "bar";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/tests-overlay.dtsi b/drivers/of/unittest-data/tests-overlay.dtsi
index 7b8001ab9f3a..fa2fb43bccac 100644
--- a/drivers/of/unittest-data/tests-overlay.dtsi
+++ b/drivers/of/unittest-data/tests-overlay.dtsi
@@ -113,218 +113,5 @@
 				};
 			};
 		};
-
-		/* test enable using absolute target path */
-		overlay0 {
-			fragment@0 {
-				target-path = "/testcase-data/overlay-node/test-bus/test-unittest0";
-				__overlay__ {
-					status = "okay";
-				};
-			};
-		};
-
-		/* test disable using absolute target path */
-		overlay1 {
-			fragment@0 {
-				target-path = "/testcase-data/overlay-node/test-bus/test-unittest1";
-				__overlay__ {
-					status = "disabled";
-				};
-			};
-		};
-
-		/* test enable using label */
-		overlay2 {
-			fragment@0 {
-				target = <&unittest2>;
-				__overlay__ {
-					status = "okay";
-				};
-			};
-		};
-
-		/* test disable using label */
-		overlay3 {
-			fragment@0 {
-				target = <&unittest3>;
-				__overlay__ {
-					status = "disabled";
-				};
-			};
-		};
-
-		/* test insertion of a full node */
-		overlay4 {
-			fragment@0 {
-				target = <&unittestbus>;
-				__overlay__ {
-
-					/* suppress DTC warning */
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					test-unittest4 {
-						compatible = "unittest";
-						status = "okay";
-						reg = <4>;
-					};
-				};
-			};
-		};
-
-		/* test overlay apply revert */
-		overlay5 {
-			fragment@0 {
-				target-path = "/testcase-data/overlay-node/test-bus/test-unittest5";
-				__overlay__ {
-					status = "okay";
-				};
-			};
-		};
-
-		/* test overlays application and removal in sequence */
-		overlay6 {
-			fragment@0 {
-				target-path = "/testcase-data/overlay-node/test-bus/test-unittest6";
-				__overlay__ {
-					status = "okay";
-				};
-			};
-		};
-		overlay7 {
-			fragment@0 {
-				target-path = "/testcase-data/overlay-node/test-bus/test-unittest7";
-				__overlay__ {
-					status = "okay";
-				};
-			};
-		};
-
-		/* test overlays application and removal in bad sequence */
-		overlay8 {
-			fragment@0 {
-				target-path = "/testcase-data/overlay-node/test-bus/test-unittest8";
-				__overlay__ {
-					status = "okay";
-				};
-			};
-		};
-		overlay9 {
-			fragment@0 {
-				target-path = "/testcase-data/overlay-node/test-bus/test-unittest8";
-				__overlay__ {
-					property-foo = "bar";
-				};
-			};
-		};
-
-		overlay10 {
-			fragment@0 {
-				target-path = "/testcase-data/overlay-node/test-bus";
-				__overlay__ {
-
-					/* suppress DTC warning */
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					test-unittest10 {
-						compatible = "unittest";
-						status = "okay";
-						reg = <10>;
-
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						test-unittest101 {
-							compatible = "unittest";
-							status = "okay";
-							reg = <1>;
-						};
-
-					};
-				};
-			};
-		};
-
-		overlay11 {
-			fragment@0 {
-				target-path = "/testcase-data/overlay-node/test-bus";
-				__overlay__ {
-
-					/* suppress DTC warning */
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					test-unittest11 {
-						compatible = "unittest";
-						status = "okay";
-						reg = <11>;
-
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						test-unittest111 {
-							compatible = "unittest";
-							status = "okay";
-							reg = <1>;
-						};
-
-					};
-				};
-			};
-		};
-
-		/* test enable using absolute target path (i2c) */
-		overlay12 {
-			fragment@0 {
-				target-path = "/testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest12";
-				__overlay__ {
-					status = "okay";
-				};
-			};
-		};
-
-		/* test disable using absolute target path (i2c) */
-		overlay13 {
-			fragment@0 {
-				target-path = "/testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest13";
-				__overlay__ {
-					status = "disabled";
-				};
-			};
-		};
-
-		/* test mux overlay */
-		overlay15 {
-			fragment@0 {
-				target-path = "/testcase-data/overlay-node/test-bus/i2c-test-bus";
-				__overlay__ {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					test-unittest15 {
-						reg = <11>;
-						compatible = "unittest-i2c-mux";
-						status = "okay";
-
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						i2c@0 {
-							#address-cells = <1>;
-							#size-cells = <0>;
-							reg = <0>;
-
-							test-mux-dev {
-								reg = <32>;
-								compatible = "unittest-i2c-dev";
-								status = "okay";
-							};
-						};
-					};
-				};
-			};
-		};
-
 	};
 };
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 7a9abaae874d..a23b54780c7d 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -45,6 +45,8 @@
 	failed; \
 })
 
+static int __init overlay_data_apply(const char *overlay_name, int *overlay_id);
+
 static void __init of_unittest_find_node_by_name(void)
 {
 	struct device_node *np;
@@ -997,8 +999,7 @@ static int __init unittest_data_add(void)
 	}
 
 	/*
-	 * This lock normally encloses of_overlay_apply() as well as
-	 * of_resolve_phandles().
+	 * This lock normally encloses of_resolve_phandles()
 	 */
 	of_overlay_mutex_lock();
 
@@ -1191,12 +1192,12 @@ static int of_unittest_device_exists(int unittest_nr, enum overlay_type ovtype)
 	return 0;
 }
 
-static const char *overlay_path(int nr)
+static const char *overlay_name_from_nr(int nr)
 {
 	static char buf[256];
 
 	snprintf(buf, sizeof(buf) - 1,
-		"/testcase-data/overlay%d", nr);
+		"overlay_%d", nr);
 	buf[sizeof(buf) - 1] = '\0';
 
 	return buf;
@@ -1263,25 +1264,19 @@ static void of_unittest_destroy_tracked_overlays(void)
 	} while (defers > 0);
 }
 
-static int of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
+static int __init of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
 		int *overlay_id)
 {
 	struct device_node *np = NULL;
+	const char *overlay_name;
 	int ret;
 
-	np = of_find_node_by_path(overlay_path(overlay_nr));
-	if (np == NULL) {
-		unittest(0, "could not find overlay node @\"%s\"\n",
-				overlay_path(overlay_nr));
-		ret = -EINVAL;
-		goto out;
-	}
+	overlay_name = overlay_name_from_nr(overlay_nr);
 
-	*overlay_id = 0;
-	ret = of_overlay_apply(np, overlay_id);
-	if (ret < 0) {
-		unittest(0, "could not create overlay from \"%s\"\n",
-				overlay_path(overlay_nr));
+	ret = overlay_data_apply(overlay_name, overlay_id);
+	if (!ret) {
+		unittest(0, "could not apply overlay \"%s\"\n",
+				overlay_name);
 		goto out;
 	}
 	of_unittest_track_overlay(*overlay_id);
@@ -1295,15 +1290,16 @@ static int of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
 }
 
 /* apply an overlay while checking before and after states */
-static int of_unittest_apply_overlay_check(int overlay_nr, int unittest_nr,
-		int before, int after, enum overlay_type ovtype)
+static int __init of_unittest_apply_overlay_check(int overlay_nr,
+		int unittest_nr, int before, int after,
+		enum overlay_type ovtype)
 {
 	int ret, ovcs_id;
 
 	/* unittest device must not be in before state */
 	if (of_unittest_device_exists(unittest_nr, ovtype) != before) {
-		unittest(0, "overlay @\"%s\" with device @\"%s\" %s\n",
-				overlay_path(overlay_nr),
+		unittest(0, "%s with device @\"%s\" %s\n",
+				overlay_name_from_nr(overlay_nr),
 				unittest_path(unittest_nr, ovtype),
 				!before ? "enabled" : "disabled");
 		return -EINVAL;
@@ -1318,8 +1314,8 @@ static int of_unittest_apply_overlay_check(int overlay_nr, int unittest_nr,
 
 	/* unittest device must be to set to after state */
 	if (of_unittest_device_exists(unittest_nr, ovtype) != after) {
-		unittest(0, "overlay @\"%s\" failed to create @\"%s\" %s\n",
-				overlay_path(overlay_nr),
+		unittest(0, "%s failed to create @\"%s\" %s\n",
+				overlay_name_from_nr(overlay_nr),
 				unittest_path(unittest_nr, ovtype),
 				!after ? "enabled" : "disabled");
 		return -EINVAL;
@@ -1329,7 +1325,7 @@ static int of_unittest_apply_overlay_check(int overlay_nr, int unittest_nr,
 }
 
 /* apply an overlay and then revert it while checking before, after states */
-static int of_unittest_apply_revert_overlay_check(int overlay_nr,
+static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 		int unittest_nr, int before, int after,
 		enum overlay_type ovtype)
 {
@@ -1337,8 +1333,8 @@ static int of_unittest_apply_revert_overlay_check(int overlay_nr,
 
 	/* unittest device must be in before state */
 	if (of_unittest_device_exists(unittest_nr, ovtype) != before) {
-		unittest(0, "overlay @\"%s\" with device @\"%s\" %s\n",
-				overlay_path(overlay_nr),
+		unittest(0, "%s with device @\"%s\" %s\n",
+				overlay_name_from_nr(overlay_nr),
 				unittest_path(unittest_nr, ovtype),
 				!before ? "enabled" : "disabled");
 		return -EINVAL;
@@ -1354,8 +1350,8 @@ static int of_unittest_apply_revert_overlay_check(int overlay_nr,
 
 	/* unittest device must be in after state */
 	if (of_unittest_device_exists(unittest_nr, ovtype) != after) {
-		unittest(0, "overlay @\"%s\" failed to create @\"%s\" %s\n",
-				overlay_path(overlay_nr),
+		unittest(0, "%s failed to create @\"%s\" %s\n",
+				overlay_name_from_nr(overlay_nr),
 				unittest_path(unittest_nr, ovtype),
 				!after ? "enabled" : "disabled");
 		return -EINVAL;
@@ -1363,16 +1359,16 @@ static int of_unittest_apply_revert_overlay_check(int overlay_nr,
 
 	ret = of_overlay_remove(&ovcs_id);
 	if (ret != 0) {
-		unittest(0, "overlay @\"%s\" failed to be destroyed @\"%s\"\n",
-				overlay_path(overlay_nr),
+		unittest(0, "%s failed to be destroyed @\"%s\"\n",
+				overlay_name_from_nr(overlay_nr),
 				unittest_path(unittest_nr, ovtype));
 		return ret;
 	}
 
 	/* unittest device must be again in before state */
 	if (of_unittest_device_exists(unittest_nr, PDEV_OVERLAY) != before) {
-		unittest(0, "overlay @\"%s\" with device @\"%s\" %s\n",
-				overlay_path(overlay_nr),
+		unittest(0, "%s with device @\"%s\" %s\n",
+				overlay_name_from_nr(overlay_nr),
 				unittest_path(unittest_nr, ovtype),
 				!before ? "enabled" : "disabled");
 		return -EINVAL;
@@ -1382,7 +1378,7 @@ static int of_unittest_apply_revert_overlay_check(int overlay_nr,
 }
 
 /* test activation of device */
-static void of_unittest_overlay_0(void)
+static void __init of_unittest_overlay_0(void)
 {
 	int ret;
 
@@ -1395,7 +1391,7 @@ static void of_unittest_overlay_0(void)
 }
 
 /* test deactivation of device */
-static void of_unittest_overlay_1(void)
+static void __init of_unittest_overlay_1(void)
 {
 	int ret;
 
@@ -1408,7 +1404,7 @@ static void of_unittest_overlay_1(void)
 }
 
 /* test activation of device */
-static void of_unittest_overlay_2(void)
+static void __init of_unittest_overlay_2(void)
 {
 	int ret;
 
@@ -1421,7 +1417,7 @@ static void of_unittest_overlay_2(void)
 }
 
 /* test deactivation of device */
-static void of_unittest_overlay_3(void)
+static void __init of_unittest_overlay_3(void)
 {
 	int ret;
 
@@ -1434,7 +1430,7 @@ static void of_unittest_overlay_3(void)
 }
 
 /* test activation of a full device node */
-static void of_unittest_overlay_4(void)
+static void __init of_unittest_overlay_4(void)
 {
 	int ret;
 
@@ -1447,7 +1443,7 @@ static void of_unittest_overlay_4(void)
 }
 
 /* test overlay apply/revert sequence */
-static void of_unittest_overlay_5(void)
+static void __init of_unittest_overlay_5(void)
 {
 	int ret;
 
@@ -1460,19 +1456,19 @@ static void of_unittest_overlay_5(void)
 }
 
 /* test overlay application in sequence */
-static void of_unittest_overlay_6(void)
+static void __init of_unittest_overlay_6(void)
 {
-	struct device_node *np;
 	int ret, i, ov_id[2], ovcs_id;
 	int overlay_nr = 6, unittest_nr = 6;
 	int before = 0, after = 1;
+	const char *overlay_name;
 
 	/* unittest device must be in before state */
 	for (i = 0; i < 2; i++) {
 		if (of_unittest_device_exists(unittest_nr + i, PDEV_OVERLAY)
 				!= before) {
-			unittest(0, "overlay @\"%s\" with device @\"%s\" %s\n",
-					overlay_path(overlay_nr + i),
+			unittest(0, "%s with device @\"%s\" %s\n",
+					overlay_name_from_nr(overlay_nr + i),
 					unittest_path(unittest_nr + i,
 						PDEV_OVERLAY),
 					!before ? "enabled" : "disabled");
@@ -1483,18 +1479,12 @@ static void of_unittest_overlay_6(void)
 	/* apply the overlays */
 	for (i = 0; i < 2; i++) {
 
-		np = of_find_node_by_path(overlay_path(overlay_nr + i));
-		if (np == NULL) {
-			unittest(0, "could not find overlay node @\"%s\"\n",
-					overlay_path(overlay_nr + i));
-			return;
-		}
+		overlay_name = overlay_name_from_nr(overlay_nr + i);
 
-		ovcs_id = 0;
-		ret = of_overlay_apply(np, &ovcs_id);
-		if (ret < 0)  {
-			unittest(0, "could not create overlay from \"%s\"\n",
-					overlay_path(overlay_nr + i));
+		ret = overlay_data_apply(overlay_name, &ovcs_id);
+		if (!ret)  {
+			unittest(0, "could not apply overlay \"%s\"\n",
+					overlay_name);
 			return;
 		}
 		ov_id[i] = ovcs_id;
@@ -1506,7 +1496,7 @@ static void of_unittest_overlay_6(void)
 		if (of_unittest_device_exists(unittest_nr + i, PDEV_OVERLAY)
 				!= after) {
 			unittest(0, "overlay @\"%s\" failed @\"%s\" %s\n",
-					overlay_path(overlay_nr + i),
+					overlay_name_from_nr(overlay_nr + i),
 					unittest_path(unittest_nr + i,
 						PDEV_OVERLAY),
 					!after ? "enabled" : "disabled");
@@ -1518,8 +1508,8 @@ static void of_unittest_overlay_6(void)
 		ovcs_id = ov_id[i];
 		ret = of_overlay_remove(&ovcs_id);
 		if (ret != 0) {
-			unittest(0, "overlay @\"%s\" failed destroy @\"%s\"\n",
-					overlay_path(overlay_nr + i),
+			unittest(0, "%s failed destroy @\"%s\"\n",
+					overlay_name_from_nr(overlay_nr + i),
 					unittest_path(unittest_nr + i,
 						PDEV_OVERLAY));
 			return;
@@ -1531,8 +1521,8 @@ static void of_unittest_overlay_6(void)
 		/* unittest device must be again in before state */
 		if (of_unittest_device_exists(unittest_nr + i, PDEV_OVERLAY)
 				!= before) {
-			unittest(0, "overlay @\"%s\" with device @\"%s\" %s\n",
-					overlay_path(overlay_nr + i),
+			unittest(0, "%s with device @\"%s\" %s\n",
+					overlay_name_from_nr(overlay_nr + i),
 					unittest_path(unittest_nr + i,
 						PDEV_OVERLAY),
 					!before ? "enabled" : "disabled");
@@ -1544,29 +1534,23 @@ static void of_unittest_overlay_6(void)
 }
 
 /* test overlay application in sequence */
-static void of_unittest_overlay_8(void)
+static void __init of_unittest_overlay_8(void)
 {
-	struct device_node *np;
 	int ret, i, ov_id[2], ovcs_id;
 	int overlay_nr = 8, unittest_nr = 8;
+	const char *overlay_name;
 
 	/* we don't care about device state in this test */
 
 	/* apply the overlays */
 	for (i = 0; i < 2; i++) {
 
-		np = of_find_node_by_path(overlay_path(overlay_nr + i));
-		if (np == NULL) {
-			unittest(0, "could not find overlay node @\"%s\"\n",
-					overlay_path(overlay_nr + i));
-			return;
-		}
+		overlay_name = overlay_name_from_nr(overlay_nr + i);
 
-		ovcs_id = 0;
-		ret = of_overlay_apply(np, &ovcs_id);
+		ret = overlay_data_apply(overlay_name, &ovcs_id);
 		if (ret < 0)  {
-			unittest(0, "could not create overlay from \"%s\"\n",
-					overlay_path(overlay_nr + i));
+			unittest(0, "could not apply overlay \"%s\"\n",
+					overlay_name);
 			return;
 		}
 		ov_id[i] = ovcs_id;
@@ -1577,8 +1561,8 @@ static void of_unittest_overlay_8(void)
 	ovcs_id = ov_id[0];
 	ret = of_overlay_remove(&ovcs_id);
 	if (ret == 0) {
-		unittest(0, "overlay @\"%s\" was destroyed @\"%s\"\n",
-				overlay_path(overlay_nr + 0),
+		unittest(0, "%s was destroyed @\"%s\"\n",
+				overlay_name_from_nr(overlay_nr + 0),
 				unittest_path(unittest_nr,
 					PDEV_OVERLAY));
 		return;
@@ -1589,8 +1573,8 @@ static void of_unittest_overlay_8(void)
 		ovcs_id = ov_id[i];
 		ret = of_overlay_remove(&ovcs_id);
 		if (ret != 0) {
-			unittest(0, "overlay @\"%s\" not destroyed @\"%s\"\n",
-					overlay_path(overlay_nr + i),
+			unittest(0, "%s not destroyed @\"%s\"\n",
+					overlay_name_from_nr(overlay_nr + i),
 					unittest_path(unittest_nr,
 						PDEV_OVERLAY));
 			return;
@@ -1602,7 +1586,7 @@ static void of_unittest_overlay_8(void)
 }
 
 /* test insertion of a bus with parent devices */
-static void of_unittest_overlay_10(void)
+static void __init of_unittest_overlay_10(void)
 {
 	int ret;
 	char *child_path;
@@ -1625,7 +1609,7 @@ static void of_unittest_overlay_10(void)
 }
 
 /* test insertion of a bus with parent devices (and revert) */
-static void of_unittest_overlay_11(void)
+static void __init of_unittest_overlay_11(void)
 {
 	int ret;
 
@@ -1891,7 +1875,7 @@ static void of_unittest_overlay_i2c_cleanup(void)
 	i2c_del_driver(&unittest_i2c_dev_driver);
 }
 
-static void of_unittest_overlay_i2c_12(void)
+static void __init of_unittest_overlay_i2c_12(void)
 {
 	int ret;
 
@@ -1904,7 +1888,7 @@ static void of_unittest_overlay_i2c_12(void)
 }
 
 /* test deactivation of device */
-static void of_unittest_overlay_i2c_13(void)
+static void __init of_unittest_overlay_i2c_13(void)
 {
 	int ret;
 
@@ -1921,7 +1905,7 @@ static void of_unittest_overlay_i2c_14(void)
 {
 }
 
-static void of_unittest_overlay_i2c_15(void)
+static void __init of_unittest_overlay_i2c_15(void)
 {
 	int ret;
 
@@ -2023,23 +2007,38 @@ static inline void __init of_unittest_overlay(void) { }
 	extern uint8_t __dtb_##name##_begin[]; \
 	extern uint8_t __dtb_##name##_end[]
 
-#define OVERLAY_INFO(name, expected) \
-{	.dtb_begin	 = __dtb_##name##_begin, \
-	.dtb_end	 = __dtb_##name##_end, \
-	.expected_result = expected, \
+#define OVERLAY_INFO(overlay_name, expected)             \
+{	.dtb_begin       = __dtb_##overlay_name##_begin, \
+	.dtb_end         = __dtb_##overlay_name##_end,   \
+	.expected_result = expected,                     \
+	.name            = #overlay_name,                \
 }
 
 struct overlay_info {
-	uint8_t		   *dtb_begin;
-	uint8_t		   *dtb_end;
-	void		   *data;
-	struct device_node *np_overlay;
-	int		   expected_result;
-	int		   overlay_id;
+	uint8_t		*dtb_begin;
+	uint8_t		*dtb_end;
+	int		expected_result;
+	int		overlay_id;
+	char		*name;
 };
 
 OVERLAY_INFO_EXTERN(overlay_base);
 OVERLAY_INFO_EXTERN(overlay);
+OVERLAY_INFO_EXTERN(overlay_0);
+OVERLAY_INFO_EXTERN(overlay_1);
+OVERLAY_INFO_EXTERN(overlay_2);
+OVERLAY_INFO_EXTERN(overlay_3);
+OVERLAY_INFO_EXTERN(overlay_4);
+OVERLAY_INFO_EXTERN(overlay_5);
+OVERLAY_INFO_EXTERN(overlay_6);
+OVERLAY_INFO_EXTERN(overlay_7);
+OVERLAY_INFO_EXTERN(overlay_8);
+OVERLAY_INFO_EXTERN(overlay_9);
+OVERLAY_INFO_EXTERN(overlay_10);
+OVERLAY_INFO_EXTERN(overlay_11);
+OVERLAY_INFO_EXTERN(overlay_12);
+OVERLAY_INFO_EXTERN(overlay_13);
+OVERLAY_INFO_EXTERN(overlay_15);
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
 OVERLAY_INFO_EXTERN(overlay_bad_symbol);
 
@@ -2047,6 +2046,21 @@ struct overlay_info {
 static struct overlay_info overlays[] = {
 	OVERLAY_INFO(overlay_base, -9999),
 	OVERLAY_INFO(overlay, 0),
+	OVERLAY_INFO(overlay_0, 0),
+	OVERLAY_INFO(overlay_1, 0),
+	OVERLAY_INFO(overlay_2, 0),
+	OVERLAY_INFO(overlay_3, 0),
+	OVERLAY_INFO(overlay_4, 0),
+	OVERLAY_INFO(overlay_5, 0),
+	OVERLAY_INFO(overlay_6, 0),
+	OVERLAY_INFO(overlay_7, 0),
+	OVERLAY_INFO(overlay_8, 0),
+	OVERLAY_INFO(overlay_9, 0),
+	OVERLAY_INFO(overlay_10, 0),
+	OVERLAY_INFO(overlay_11, 0),
+	OVERLAY_INFO(overlay_12, 0),
+	OVERLAY_INFO(overlay_13, 0),
+	OVERLAY_INFO(overlay_15, 0),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
 	OVERLAY_INFO(overlay_bad_symbol, -EINVAL),
 	{}
@@ -2077,6 +2091,7 @@ void __init unittest_unflatten_overlay_base(void)
 {
 	struct overlay_info *info;
 	u32 data_size;
+	void *new_fdt;
 	u32 size;
 
 	info = &overlays[0];
@@ -2098,17 +2113,16 @@ void __init unittest_unflatten_overlay_base(void)
 		return;
 	}
 
-	info->data = dt_alloc_memory(size, roundup_pow_of_two(FDT_V17_SIZE));
-	if (!info->data) {
+	new_fdt = dt_alloc_memory(size, roundup_pow_of_two(FDT_V17_SIZE));
+	if (!new_fdt) {
 		pr_err("alloc for dtb 'overlay_base' failed");
 		return;
 	}
 
-	memcpy(info->data, info->dtb_begin, size);
+	memcpy(new_fdt, info->dtb_begin, size);
 
-	__unflatten_device_tree(info->data, NULL, &info->np_overlay,
+	__unflatten_device_tree(new_fdt, NULL, &overlay_base_root,
 				dt_alloc_memory, true);
-	overlay_base_root = info->np_overlay;
 }
 
 /*
@@ -2122,73 +2136,44 @@ void __init unittest_unflatten_overlay_base(void)
  *
  * Return 0 on unexpected error.
  */
-static int __init overlay_data_add(int onum)
+static int __init overlay_data_apply(const char *overlay_name, int *overlay_id)
 {
 	struct overlay_info *info;
+	int found = 0;
 	int k;
 	int ret;
 	u32 size;
-	u32 size_from_header;
 
-	for (k = 0, info = overlays; info; info++, k++) {
-		if (k == onum)
+	for (k = 0, info = overlays; info && info->name; info++, k++) {
+		if (!strcmp(overlay_name, info->name)) {
+			found = 1;
 			break;
+		}
 	}
-	if (onum > k)
+	if (!found) {
+		pr_err("no overlay data for %s\n", overlay_name);
 		return 0;
+	}
 
 	size = info->dtb_end - info->dtb_begin;
 	if (!size) {
-		pr_err("no overlay to attach, %d\n", onum);
+		pr_err("no overlay data for %s\n", overlay_name);
 		ret = 0;
 	}
 
-	size_from_header = fdt_totalsize(info->dtb_begin);
-	if (size_from_header != size) {
-		pr_err("overlay header totalsize != actual size, %d", onum);
-		return 0;
-	}
-
-	/*
-	 * Must create permanent copy of FDT because of_fdt_unflatten_tree()
-	 * will create pointers to the passed in FDT in the EDT.
-	 */
-	info->data = kmemdup(info->dtb_begin, size, GFP_KERNEL);
-	if (!info->data) {
-		pr_err("unable to allocate memory for data, %d\n", onum);
-		return 0;
-	}
-
-	of_fdt_unflatten_tree(info->data, NULL, &info->np_overlay);
-	if (!info->np_overlay) {
-		pr_err("unable to unflatten overlay, %d\n", onum);
-		ret = 0;
-		goto out_free_data;
-	}
-
-	info->overlay_id = 0;
-	ret = of_overlay_apply(info->np_overlay, &info->overlay_id);
-	if (ret < 0) {
-		pr_err("of_overlay_apply() (ret=%d), %d\n", ret, onum);
-		goto out_free_np_overlay;
-	}
-
-	pr_debug("__dtb_overlay_begin applied, overlay id %d\n", ret);
-
-	goto out;
-
-out_free_np_overlay:
-	/*
-	 * info->np_overlay is the unflattened device tree
-	 * It has not been spliced into the live tree.
-	 */
-
-	/* todo: function to free unflattened device tree */
+	ret = of_overlay_fdt_apply(info->dtb_begin, size, &info->overlay_id);
+	if (overlay_id)
+		*overlay_id = info->overlay_id;
+	if (ret < 0)
+		goto out;
 
-out_free_data:
-	kfree(info->data);
+	pr_debug("%s applied\n", overlay_name);
 
 out:
+	if (ret != info->expected_result)
+		pr_err("of_overlay_fdt_apply() expected %d, ret=%d, %s\n",
+		       info->expected_result, ret, overlay_name);
+
 	return (ret == info->expected_result);
 }
 
@@ -2290,18 +2275,29 @@ static __init void of_unittest_overlay_high_level(void)
 		__of_attach_node_sysfs(np);
 
 	if (of_symbols) {
+		struct property *new_prop;
 		for_each_property_of_node(overlay_base_symbols, prop) {
-			ret = __of_add_property(of_symbols, prop);
+
+			new_prop = __of_prop_dup(prop, GFP_KERNEL);
+			if (!new_prop) {
+				unittest(0, "__of_prop_dup() of '%s' from overlay_base node __symbols__",
+					 prop->name);
+				goto err_unlock;
+			}
+			ret = __of_add_property(of_symbols, new_prop);
 			if (ret) {
-				unittest(0,
-					 "duplicate property '%s' in overlay_base node __symbols__",
+				if (!strcmp(new_prop->name, "name")) {
+					/* auto-generated by unflatten */
+					ret = 0;
+					continue;
+				}
+				unittest(0, "duplicate property '%s' in overlay_base node __symbols__",
 					 prop->name);
 				goto err_unlock;
 			}
-			ret = __of_add_property_sysfs(of_symbols, prop);
+			ret = __of_add_property_sysfs(of_symbols, new_prop);
 			if (ret) {
-				unittest(0,
-					 "unable to add property '%s' in overlay_base node __symbols__ to sysfs",
+				unittest(0, "unable to add property '%s' in overlay_base node __symbols__ to sysfs",
 					 prop->name);
 				goto err_unlock;
 			}
@@ -2313,13 +2309,13 @@ static __init void of_unittest_overlay_high_level(void)
 
 	/* now do the normal overlay usage test */
 
-	unittest(overlay_data_add(1),
+	unittest(overlay_data_apply("overlay", NULL),
 		 "Adding overlay 'overlay' failed\n");
 
-	unittest(overlay_data_add(2),
+	unittest(overlay_data_apply("overlay_bad_phandle", NULL),
 		 "Adding overlay 'overlay_bad_phandle' failed\n");
 
-	unittest(overlay_data_add(3),
+	unittest(overlay_data_apply("overlay_bad_symbol", NULL),
 		 "Adding overlay 'overlay_bad_symbol' failed\n");
 
 	return;
diff --git a/include/linux/of.h b/include/linux/of.h
index da1ee95241c1..ebf22dd0860c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1359,8 +1359,8 @@ struct of_overlay_notify_data {
 
 #ifdef CONFIG_OF_OVERLAY
 
-/* ID based overlays; the API for external users */
-int of_overlay_apply(struct device_node *tree, int *ovcs_id);
+int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
+			 int *ovcs_id);
 int of_overlay_remove(int *ovcs_id);
 int of_overlay_remove_all(void);
 
@@ -1369,7 +1369,7 @@ struct of_overlay_notify_data {
 
 #else
 
-static inline int of_overlay_apply(struct device_node *tree, int *ovcs_id)
+static inline int of_overlay_fdt_apply(void *overlay_fdt, int *ovcs_id)
 {
 	return -ENOTSUPP;
 }
-- 
Frank Rowand <frank.rowand@sony.com>
