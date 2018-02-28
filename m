Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965124AbeB1Xde (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:33:34 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:47019 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965097AbeB1XdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:33:07 -0500
X-Google-Smtp-Source: AG47ELtV2KN5vWuikyDxv/IMY528/SZKdRg5WRt2kmq7Em03ZS1X8hE0eRhqPaCoTFRtzvfj81lvjg==
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] scripts/dtc: Update to upstream version v1.4.6-9-gaadd0b65c987
Date: Wed, 28 Feb 2018 17:32:48 -0600
Message-Id: <20180228233249.26281-6-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180228233249.26281-1-robh@kernel.org>
References: <20180228233249.26281-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the following commits from upstream:

aadd0b65c987 checks: centralize printing of property names in failure messages
88960e398907 checks: centralize printing of node path in check_msg
f1879e1a50eb Add limited read-only support for older (V2 and V3) device tree to libfdt.
37dea76e9700 srcpos: drop special handling of tab
65893da4aee0 libfdt: overlay: Add missing license
962a45ca034d Avoid installing pylibfdt when dependencies are missing
cd6ea1b2bea6 Makefile: Split INSTALL out into INSTALL_{PROGRAM,LIB,DATA,SCRIPT}
51b3a16338df Makefile.tests: Add LIBDL make(1) variable for portability sake
333d533a8f4d Attempt to auto-detect stat(1) being used if not given proper invocation
e54388015af1 dtc: Bump version to v1.4.6
a1fe86f380cb fdtoverlay: Switch from using alloca to malloc
c8d5472de3ff tests: Improve compatibility with other platforms
c81d389a10cc checks: add chosen node checks
e671852042a7 checks: add aliases node checks
d0c44ebe3f42 checks: check for #{size,address}-cells without child nodes
18a3d84bb802 checks: add string list check for *-names properties
8fe94fd6f19f checks: add string list check
6c5730819604 checks: add a string check for 'label' property
a384191eba09 checks: fix sound-dai phandle with arg property check
b260c4f610c0 Fix ambiguous grammar for devicetree rule
fe667e382bac tests: Add some basic tests for the pci_bridge checks
7975f6422260 Fix widespread incorrect use of strneq(), replace with new strprefixeq()
fca296445eab Add strstarts() helper function
cc392f089007 tests: Check non-matching cases for fdt_node_check_compatible()
bba26a5291c8 livetree: avoid assertion of orphan phandles with overlays
c8f8194d76cc implement strnlen for systems that need it
c8b38f65fdec libfdt: Remove leading underscores from identifiers
3b62fdaebfe5 Remove leading underscores from identifiers
2d45d1c5c65e Replace FDT_VERSION() with stringify()
2e6fe5a107b5 Fix some errors in comments
b0ae9e4b0ceb tests: Correct warning in sw_tree1.c

Commit c8b38f65fdec upstream ("libfdt: Remove leading underscores from
identifiers") changed the multiple inclusion define protection, so the
kernel's libfdt_env.h needs the corresponding update.

Signed-off-by: Rob Herring <robh@kernel.org>
---

As usual, this is a copy from upstream, so nothing to review here except 
whether the script copied things correctly.

 include/linux/libfdt_env.h           |   6 +-

Except this file I had to fix manually.

 scripts/dtc/checks.c                 | 439 +++++++++++++++++++++++------------
 scripts/dtc/dtc-parser.y             |  17 +-
 scripts/dtc/dtc.c                    |   7 +-
 scripts/dtc/dtc.h                    |  11 +-
 scripts/dtc/flattree.c               |   2 +-
 scripts/dtc/libfdt/fdt.c             |  13 +-
 scripts/dtc/libfdt/fdt.h             |   6 +-
 scripts/dtc/libfdt/fdt_overlay.c     |  51 ++++
 scripts/dtc/libfdt/fdt_ro.c          | 132 ++++++++---
 scripts/dtc/libfdt/fdt_rw.c          |  90 +++----
 scripts/dtc/libfdt/fdt_sw.c          |  24 +-
 scripts/dtc/libfdt/fdt_wip.c         |  10 +-
 scripts/dtc/libfdt/libfdt.h          |  37 +--
 scripts/dtc/libfdt/libfdt_env.h      |  33 ++-
 scripts/dtc/libfdt/libfdt_internal.h |  32 +--
 scripts/dtc/livetree.c               |  10 +-
 scripts/dtc/srcpos.c                 |   5 -
 scripts/dtc/srcpos.h                 |   6 +-
 scripts/dtc/util.h                   |   9 +-
 scripts/dtc/version_gen.h            |   2 +-
 21 files changed, 622 insertions(+), 320 deletions(-)

diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
index 14997285e53d..c6ac1fe7ec68 100644
--- a/include/linux/libfdt_env.h
+++ b/include/linux/libfdt_env.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LIBFDT_ENV_H
-#define _LIBFDT_ENV_H
+#ifndef LIBFDT_ENV_H
+#define LIBFDT_ENV_H
 
 #include <linux/string.h>
 
@@ -15,4 +15,4 @@ typedef __be64 fdt64_t;
 #define fdt64_to_cpu(x) be64_to_cpu(x)
 #define cpu_to_fdt64(x) cpu_to_be64(x)
 
-#endif /* _LIBFDT_ENV_H */
+#endif /* LIBFDT_ENV_H */
diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index e66138449886..c07ba4da9e36 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -53,26 +53,28 @@ struct check {
 	struct check **prereq;
 };
 
-#define CHECK_ENTRY(_nm, _fn, _d, _w, _e, ...)	       \
-	static struct check *_nm##_prereqs[] = { __VA_ARGS__ }; \
-	static struct check _nm = { \
-		.name = #_nm, \
-		.fn = (_fn), \
-		.data = (_d), \
-		.warn = (_w), \
-		.error = (_e), \
+#define CHECK_ENTRY(nm_, fn_, d_, w_, e_, ...)	       \
+	static struct check *nm_##_prereqs[] = { __VA_ARGS__ }; \
+	static struct check nm_ = { \
+		.name = #nm_, \
+		.fn = (fn_), \
+		.data = (d_), \
+		.warn = (w_), \
+		.error = (e_), \
 		.status = UNCHECKED, \
-		.num_prereqs = ARRAY_SIZE(_nm##_prereqs), \
-		.prereq = _nm##_prereqs, \
+		.num_prereqs = ARRAY_SIZE(nm_##_prereqs), \
+		.prereq = nm_##_prereqs, \
 	};
-#define WARNING(_nm, _fn, _d, ...) \
-	CHECK_ENTRY(_nm, _fn, _d, true, false, __VA_ARGS__)
-#define ERROR(_nm, _fn, _d, ...) \
-	CHECK_ENTRY(_nm, _fn, _d, false, true, __VA_ARGS__)
-#define CHECK(_nm, _fn, _d, ...) \
-	CHECK_ENTRY(_nm, _fn, _d, false, false, __VA_ARGS__)
-
-static inline void  PRINTF(3, 4) check_msg(struct check *c, struct dt_info *dti,
+#define WARNING(nm_, fn_, d_, ...) \
+	CHECK_ENTRY(nm_, fn_, d_, true, false, __VA_ARGS__)
+#define ERROR(nm_, fn_, d_, ...) \
+	CHECK_ENTRY(nm_, fn_, d_, false, true, __VA_ARGS__)
+#define CHECK(nm_, fn_, d_, ...) \
+	CHECK_ENTRY(nm_, fn_, d_, false, false, __VA_ARGS__)
+
+static inline void  PRINTF(5, 6) check_msg(struct check *c, struct dt_info *dti,
+					   struct node *node,
+					   struct property *prop,
 					   const char *fmt, ...)
 {
 	va_list ap;
@@ -83,19 +85,33 @@ static inline void  PRINTF(3, 4) check_msg(struct check *c, struct dt_info *dti,
 		fprintf(stderr, "%s: %s (%s): ",
 			strcmp(dti->outname, "-") ? dti->outname : "<stdout>",
 			(c->error) ? "ERROR" : "Warning", c->name);
+		if (node) {
+			fprintf(stderr, "%s", node->fullpath);
+			if (prop)
+				fprintf(stderr, ":%s", prop->name);
+			fputs(": ", stderr);
+		}
 		vfprintf(stderr, fmt, ap);
 		fprintf(stderr, "\n");
 	}
 	va_end(ap);
 }
 
-#define FAIL(c, dti, ...)						\
+#define FAIL(c, dti, node, ...)						\
+	do {								\
+		TRACE((c), "\t\tFAILED at %s:%d", __FILE__, __LINE__);	\
+		(c)->status = FAILED;					\
+		check_msg((c), dti, node, NULL, __VA_ARGS__);		\
+	} while (0)
+
+#define FAIL_PROP(c, dti, node, prop, ...)				\
 	do {								\
 		TRACE((c), "\t\tFAILED at %s:%d", __FILE__, __LINE__);	\
 		(c)->status = FAILED;					\
-		check_msg((c), dti, __VA_ARGS__);			\
+		check_msg((c), dti, node, prop, __VA_ARGS__);		\
 	} while (0)
 
+
 static void check_nodes_props(struct check *c, struct dt_info *dti, struct node *node)
 {
 	struct node *child;
@@ -126,7 +142,7 @@ static bool run_check(struct check *c, struct dt_info *dti)
 		error = error || run_check(prq, dti);
 		if (prq->status != PASSED) {
 			c->status = PREREQ;
-			check_msg(c, dti, "Failed prerequisite '%s'",
+			check_msg(c, dti, NULL, NULL, "Failed prerequisite '%s'",
 				  c->prereq[i]->name);
 		}
 	}
@@ -156,7 +172,7 @@ static bool run_check(struct check *c, struct dt_info *dti)
 static inline void check_always_fail(struct check *c, struct dt_info *dti,
 				     struct node *node)
 {
-	FAIL(c, dti, "always_fail check");
+	FAIL(c, dti, node, "always_fail check");
 }
 CHECK(always_fail, check_always_fail, NULL);
 
@@ -171,14 +187,42 @@ static void check_is_string(struct check *c, struct dt_info *dti,
 		return; /* Not present, assumed ok */
 
 	if (!data_is_one_string(prop->val))
-		FAIL(c, dti, "\"%s\" property in %s is not a string",
-		     propname, node->fullpath);
+		FAIL_PROP(c, dti, node, prop, "property is not a string");
 }
 #define WARNING_IF_NOT_STRING(nm, propname) \
 	WARNING(nm, check_is_string, (propname))
 #define ERROR_IF_NOT_STRING(nm, propname) \
 	ERROR(nm, check_is_string, (propname))
 
+static void check_is_string_list(struct check *c, struct dt_info *dti,
+				 struct node *node)
+{
+	int rem, l;
+	struct property *prop;
+	char *propname = c->data;
+	char *str;
+
+	prop = get_property(node, propname);
+	if (!prop)
+		return; /* Not present, assumed ok */
+
+	str = prop->val.val;
+	rem = prop->val.len;
+	while (rem > 0) {
+		l = strnlen(str, rem);
+		if (l == rem) {
+			FAIL_PROP(c, dti, node, prop, "property is not a string list");
+			break;
+		}
+		rem -= l + 1;
+		str += l + 1;
+	}
+}
+#define WARNING_IF_NOT_STRING_LIST(nm, propname) \
+	WARNING(nm, check_is_string_list, (propname))
+#define ERROR_IF_NOT_STRING_LIST(nm, propname) \
+	ERROR(nm, check_is_string_list, (propname))
+
 static void check_is_cell(struct check *c, struct dt_info *dti,
 			  struct node *node)
 {
@@ -190,8 +234,7 @@ static void check_is_cell(struct check *c, struct dt_info *dti,
 		return; /* Not present, assumed ok */
 
 	if (prop->val.len != sizeof(cell_t))
-		FAIL(c, dti, "\"%s\" property in %s is not a single cell",
-		     propname, node->fullpath);
+		FAIL_PROP(c, dti, node, prop, "property is not a single cell");
 }
 #define WARNING_IF_NOT_CELL(nm, propname) \
 	WARNING(nm, check_is_cell, (propname))
@@ -212,8 +255,7 @@ static void check_duplicate_node_names(struct check *c, struct dt_info *dti,
 		     child2;
 		     child2 = child2->next_sibling)
 			if (streq(child->name, child2->name))
-				FAIL(c, dti, "Duplicate node name %s",
-				     child->fullpath);
+				FAIL(c, dti, node, "Duplicate node name");
 }
 ERROR(duplicate_node_names, check_duplicate_node_names, NULL);
 
@@ -227,8 +269,7 @@ static void check_duplicate_property_names(struct check *c, struct dt_info *dti,
 			if (prop2->deleted)
 				continue;
 			if (streq(prop->name, prop2->name))
-				FAIL(c, dti, "Duplicate property name %s in %s",
-				     prop->name, node->fullpath);
+				FAIL_PROP(c, dti, node, prop, "Duplicate property name");
 		}
 	}
 }
@@ -246,8 +287,8 @@ static void check_node_name_chars(struct check *c, struct dt_info *dti,
 	int n = strspn(node->name, c->data);
 
 	if (n < strlen(node->name))
-		FAIL(c, dti, "Bad character '%c' in node %s",
-		     node->name[n], node->fullpath);
+		FAIL(c, dti, node, "Bad character '%c' in node name",
+		     node->name[n]);
 }
 ERROR(node_name_chars, check_node_name_chars, PROPNODECHARS "@");
 
@@ -257,8 +298,8 @@ static void check_node_name_chars_strict(struct check *c, struct dt_info *dti,
 	int n = strspn(node->name, c->data);
 
 	if (n < node->basenamelen)
-		FAIL(c, dti, "Character '%c' not recommended in node %s",
-		     node->name[n], node->fullpath);
+		FAIL(c, dti, node, "Character '%c' not recommended in node name",
+		     node->name[n]);
 }
 CHECK(node_name_chars_strict, check_node_name_chars_strict, PROPNODECHARSSTRICT);
 
@@ -266,8 +307,7 @@ static void check_node_name_format(struct check *c, struct dt_info *dti,
 				   struct node *node)
 {
 	if (strchr(get_unitname(node), '@'))
-		FAIL(c, dti, "Node %s has multiple '@' characters in name",
-		     node->fullpath);
+		FAIL(c, dti, node, "multiple '@' characters in node name");
 }
 ERROR(node_name_format, check_node_name_format, NULL, &node_name_chars);
 
@@ -285,12 +325,10 @@ static void check_unit_address_vs_reg(struct check *c, struct dt_info *dti,
 
 	if (prop) {
 		if (!unitname[0])
-			FAIL(c, dti, "Node %s has a reg or ranges property, but no unit name",
-			    node->fullpath);
+			FAIL(c, dti, node, "node has a reg or ranges property, but no unit name");
 	} else {
 		if (unitname[0])
-			FAIL(c, dti, "Node %s has a unit name, but no reg property",
-			    node->fullpath);
+			FAIL(c, dti, node, "node has a unit name, but no reg property");
 	}
 }
 WARNING(unit_address_vs_reg, check_unit_address_vs_reg, NULL);
@@ -304,8 +342,8 @@ static void check_property_name_chars(struct check *c, struct dt_info *dti,
 		int n = strspn(prop->name, c->data);
 
 		if (n < strlen(prop->name))
-			FAIL(c, dti, "Bad character '%c' in property name \"%s\", node %s",
-			     prop->name[n], prop->name, node->fullpath);
+			FAIL_PROP(c, dti, node, prop, "Bad character '%c' in property name",
+				  prop->name[n]);
 	}
 }
 ERROR(property_name_chars, check_property_name_chars, PROPNODECHARS);
@@ -336,8 +374,8 @@ static void check_property_name_chars_strict(struct check *c,
 			n = strspn(name, c->data);
 		}
 		if (n < strlen(name))
-			FAIL(c, dti, "Character '%c' not recommended in property name \"%s\", node %s",
-			     name[n], prop->name, node->fullpath);
+			FAIL_PROP(c, dti, node, prop, "Character '%c' not recommended in property name",
+				  name[n]);
 	}
 }
 CHECK(property_name_chars_strict, check_property_name_chars_strict, PROPNODECHARSSTRICT);
@@ -370,7 +408,7 @@ static void check_duplicate_label(struct check *c, struct dt_info *dti,
 		return;
 
 	if ((othernode != node) || (otherprop != prop) || (othermark != mark))
-		FAIL(c, dti, "Duplicate label '%s' on " DESCLABEL_FMT
+		FAIL(c, dti, node, "Duplicate label '%s' on " DESCLABEL_FMT
 		     " and " DESCLABEL_FMT,
 		     label, DESCLABEL_ARGS(node, prop, mark),
 		     DESCLABEL_ARGS(othernode, otherprop, othermark));
@@ -410,8 +448,8 @@ static cell_t check_phandle_prop(struct check *c, struct dt_info *dti,
 		return 0;
 
 	if (prop->val.len != sizeof(cell_t)) {
-		FAIL(c, dti, "%s has bad length (%d) %s property",
-		     node->fullpath, prop->val.len, prop->name);
+		FAIL_PROP(c, dti, node, prop, "bad length (%d) %s property",
+			  prop->val.len, prop->name);
 		return 0;
 	}
 
@@ -422,8 +460,8 @@ static cell_t check_phandle_prop(struct check *c, struct dt_info *dti,
 			/* "Set this node's phandle equal to some
 			 * other node's phandle".  That's nonsensical
 			 * by construction. */ {
-			FAIL(c, dti, "%s in %s is a reference to another node",
-			     prop->name, node->fullpath);
+			FAIL(c, dti, node, "%s is a reference to another node",
+			     prop->name);
 		}
 		/* But setting this node's phandle equal to its own
 		 * phandle is allowed - that means allocate a unique
@@ -436,8 +474,8 @@ static cell_t check_phandle_prop(struct check *c, struct dt_info *dti,
 	phandle = propval_cell(prop);
 
 	if ((phandle == 0) || (phandle == -1)) {
-		FAIL(c, dti, "%s has bad value (0x%x) in %s property",
-		     node->fullpath, phandle, prop->name);
+		FAIL_PROP(c, dti, node, prop, "bad value (0x%x) in %s property",
+		     phandle, prop->name);
 		return 0;
 	}
 
@@ -463,16 +501,16 @@ static void check_explicit_phandles(struct check *c, struct dt_info *dti,
 		return;
 
 	if (linux_phandle && phandle && (phandle != linux_phandle))
-		FAIL(c, dti, "%s has mismatching 'phandle' and 'linux,phandle'"
-		     " properties", node->fullpath);
+		FAIL(c, dti, node, "mismatching 'phandle' and 'linux,phandle'"
+		     " properties");
 
 	if (linux_phandle && !phandle)
 		phandle = linux_phandle;
 
 	other = get_node_by_phandle(root, phandle);
 	if (other && (other != node)) {
-		FAIL(c, dti, "%s has duplicated phandle 0x%x (seen before at %s)",
-		     node->fullpath, phandle, other->fullpath);
+		FAIL(c, dti, node, "duplicated phandle 0x%x (seen before at %s)",
+		     phandle, other->fullpath);
 		return;
 	}
 
@@ -496,8 +534,8 @@ static void check_name_properties(struct check *c, struct dt_info *dti,
 
 	if ((prop->val.len != node->basenamelen+1)
 	    || (memcmp(prop->val.val, node->name, node->basenamelen) != 0)) {
-		FAIL(c, dti, "\"name\" property in %s is incorrect (\"%s\" instead"
-		     " of base node name)", node->fullpath, prop->val.val);
+		FAIL(c, dti, node, "\"name\" property is incorrect (\"%s\" instead"
+		     " of base node name)", prop->val.val);
 	} else {
 		/* The name property is correct, and therefore redundant.
 		 * Delete it */
@@ -531,7 +569,7 @@ static void fixup_phandle_references(struct check *c, struct dt_info *dti,
 			refnode = get_node_by_ref(dt, m->ref);
 			if (! refnode) {
 				if (!(dti->dtsflags & DTSF_PLUGIN))
-					FAIL(c, dti, "Reference to non-existent node or "
+					FAIL(c, dti, node, "Reference to non-existent node or "
 							"label \"%s\"\n", m->ref);
 				else /* mark the entry as unresolved */
 					*((fdt32_t *)(prop->val.val + m->offset)) =
@@ -563,7 +601,7 @@ static void fixup_path_references(struct check *c, struct dt_info *dti,
 
 			refnode = get_node_by_ref(dt, m->ref);
 			if (!refnode) {
-				FAIL(c, dti, "Reference to non-existent node or label \"%s\"\n",
+				FAIL(c, dti, node, "Reference to non-existent node or label \"%s\"\n",
 				     m->ref);
 				continue;
 			}
@@ -586,6 +624,45 @@ WARNING_IF_NOT_CELL(interrupt_cells_is_cell, "#interrupt-cells");
 WARNING_IF_NOT_STRING(device_type_is_string, "device_type");
 WARNING_IF_NOT_STRING(model_is_string, "model");
 WARNING_IF_NOT_STRING(status_is_string, "status");
+WARNING_IF_NOT_STRING(label_is_string, "label");
+
+WARNING_IF_NOT_STRING_LIST(compatible_is_string_list, "compatible");
+
+static void check_names_is_string_list(struct check *c, struct dt_info *dti,
+				       struct node *node)
+{
+	struct property *prop;
+
+	for_each_property(node, prop) {
+		const char *s = strrchr(prop->name, '-');
+		if (!s || !streq(s, "-names"))
+			continue;
+
+		c->data = prop->name;
+		check_is_string_list(c, dti, node);
+	}
+}
+WARNING(names_is_string_list, check_names_is_string_list, NULL);
+
+static void check_alias_paths(struct check *c, struct dt_info *dti,
+				    struct node *node)
+{
+	struct property *prop;
+
+	if (!streq(node->name, "aliases"))
+		return;
+
+	for_each_property(node, prop) {
+		if (!prop->val.val || !get_node_by_path(dti->dt, prop->val.val)) {
+			FAIL_PROP(c, dti, node, prop, "aliases property is not a valid node (%s)",
+				  prop->val.val);
+			continue;
+		}
+		if (strspn(prop->name, LOWERCASE DIGITS "-") != strlen(prop->name))
+			FAIL(c, dti, node, "aliases property name must include only lowercase and '-'");
+	}
+}
+WARNING(alias_paths, check_alias_paths, NULL);
 
 static void fixup_addr_size_cells(struct check *c, struct dt_info *dti,
 				  struct node *node)
@@ -622,21 +699,21 @@ static void check_reg_format(struct check *c, struct dt_info *dti,
 		return; /* No "reg", that's fine */
 
 	if (!node->parent) {
-		FAIL(c, dti, "Root node has a \"reg\" property");
+		FAIL(c, dti, node, "Root node has a \"reg\" property");
 		return;
 	}
 
 	if (prop->val.len == 0)
-		FAIL(c, dti, "\"reg\" property in %s is empty", node->fullpath);
+		FAIL_PROP(c, dti, node, prop, "property is empty");
 
 	addr_cells = node_addr_cells(node->parent);
 	size_cells = node_size_cells(node->parent);
 	entrylen = (addr_cells + size_cells) * sizeof(cell_t);
 
 	if (!entrylen || (prop->val.len % entrylen) != 0)
-		FAIL(c, dti, "\"reg\" property in %s has invalid length (%d bytes) "
-		     "(#address-cells == %d, #size-cells == %d)",
-		     node->fullpath, prop->val.len, addr_cells, size_cells);
+		FAIL_PROP(c, dti, node, prop, "property has invalid length (%d bytes) "
+			  "(#address-cells == %d, #size-cells == %d)",
+			  prop->val.len, addr_cells, size_cells);
 }
 WARNING(reg_format, check_reg_format, NULL, &addr_size_cells);
 
@@ -651,7 +728,7 @@ static void check_ranges_format(struct check *c, struct dt_info *dti,
 		return;
 
 	if (!node->parent) {
-		FAIL(c, dti, "Root node has a \"ranges\" property");
+		FAIL_PROP(c, dti, node, prop, "Root node has a \"ranges\" property");
 		return;
 	}
 
@@ -663,20 +740,20 @@ static void check_ranges_format(struct check *c, struct dt_info *dti,
 
 	if (prop->val.len == 0) {
 		if (p_addr_cells != c_addr_cells)
-			FAIL(c, dti, "%s has empty \"ranges\" property but its "
-			     "#address-cells (%d) differs from %s (%d)",
-			     node->fullpath, c_addr_cells, node->parent->fullpath,
-			     p_addr_cells);
+			FAIL_PROP(c, dti, node, prop, "empty \"ranges\" property but its "
+				  "#address-cells (%d) differs from %s (%d)",
+				  c_addr_cells, node->parent->fullpath,
+				  p_addr_cells);
 		if (p_size_cells != c_size_cells)
-			FAIL(c, dti, "%s has empty \"ranges\" property but its "
-			     "#size-cells (%d) differs from %s (%d)",
-			     node->fullpath, c_size_cells, node->parent->fullpath,
-			     p_size_cells);
+			FAIL_PROP(c, dti, node, prop, "empty \"ranges\" property but its "
+				  "#size-cells (%d) differs from %s (%d)",
+				  c_size_cells, node->parent->fullpath,
+				  p_size_cells);
 	} else if ((prop->val.len % entrylen) != 0) {
-		FAIL(c, dti, "\"ranges\" property in %s has invalid length (%d bytes) "
-		     "(parent #address-cells == %d, child #address-cells == %d, "
-		     "#size-cells == %d)", node->fullpath, prop->val.len,
-		     p_addr_cells, c_addr_cells, c_size_cells);
+		FAIL_PROP(c, dti, node, prop, "\"ranges\" property has invalid length (%d bytes) "
+			  "(parent #address-cells == %d, child #address-cells == %d, "
+			  "#size-cells == %d)", prop->val.len,
+			  p_addr_cells, c_addr_cells, c_size_cells);
 	}
 }
 WARNING(ranges_format, check_ranges_format, NULL, &addr_size_cells);
@@ -696,41 +773,33 @@ static void check_pci_bridge(struct check *c, struct dt_info *dti, struct node *
 
 	node->bus = &pci_bus;
 
-	if (!strneq(node->name, "pci", node->basenamelen) &&
-	    !strneq(node->name, "pcie", node->basenamelen))
-		FAIL(c, dti, "Node %s node name is not \"pci\" or \"pcie\"",
-			     node->fullpath);
+	if (!strprefixeq(node->name, node->basenamelen, "pci") &&
+	    !strprefixeq(node->name, node->basenamelen, "pcie"))
+		FAIL(c, dti, node, "node name is not \"pci\" or \"pcie\"");
 
 	prop = get_property(node, "ranges");
 	if (!prop)
-		FAIL(c, dti, "Node %s missing ranges for PCI bridge (or not a bridge)",
-			     node->fullpath);
+		FAIL(c, dti, node, "missing ranges for PCI bridge (or not a bridge)");
 
 	if (node_addr_cells(node) != 3)
-		FAIL(c, dti, "Node %s incorrect #address-cells for PCI bridge",
-			     node->fullpath);
+		FAIL(c, dti, node, "incorrect #address-cells for PCI bridge");
 	if (node_size_cells(node) != 2)
-		FAIL(c, dti, "Node %s incorrect #size-cells for PCI bridge",
-			     node->fullpath);
+		FAIL(c, dti, node, "incorrect #size-cells for PCI bridge");
 
 	prop = get_property(node, "bus-range");
 	if (!prop) {
-		FAIL(c, dti, "Node %s missing bus-range for PCI bridge",
-			     node->fullpath);
+		FAIL(c, dti, node, "missing bus-range for PCI bridge");
 		return;
 	}
 	if (prop->val.len != (sizeof(cell_t) * 2)) {
-		FAIL(c, dti, "Node %s bus-range must be 2 cells",
-			     node->fullpath);
+		FAIL_PROP(c, dti, node, prop, "value must be 2 cells");
 		return;
 	}
 	cells = (cell_t *)prop->val.val;
 	if (fdt32_to_cpu(cells[0]) > fdt32_to_cpu(cells[1]))
-		FAIL(c, dti, "Node %s bus-range 1st cell must be less than or equal to 2nd cell",
-			     node->fullpath);
+		FAIL_PROP(c, dti, node, prop, "1st cell must be less than or equal to 2nd cell");
 	if (fdt32_to_cpu(cells[1]) > 0xff)
-		FAIL(c, dti, "Node %s bus-range maximum bus number must be less than 256",
-			     node->fullpath);
+		FAIL_PROP(c, dti, node, prop, "maximum bus number must be less than 256");
 }
 WARNING(pci_bridge, check_pci_bridge, NULL,
 	&device_type_is_string, &addr_size_cells);
@@ -760,8 +829,8 @@ static void check_pci_device_bus_num(struct check *c, struct dt_info *dti, struc
 		max_bus = fdt32_to_cpu(cells[0]);
 	}
 	if ((bus_num < min_bus) || (bus_num > max_bus))
-		FAIL(c, dti, "Node %s PCI bus number %d out of range, expected (%d - %d)",
-		     node->fullpath, bus_num, min_bus, max_bus);
+		FAIL_PROP(c, dti, node, prop, "PCI bus number %d out of range, expected (%d - %d)",
+			  bus_num, min_bus, max_bus);
 }
 WARNING(pci_device_bus_num, check_pci_device_bus_num, NULL, &reg_format, &pci_bridge);
 
@@ -778,25 +847,22 @@ static void check_pci_device_reg(struct check *c, struct dt_info *dti, struct no
 
 	prop = get_property(node, "reg");
 	if (!prop) {
-		FAIL(c, dti, "Node %s missing PCI reg property", node->fullpath);
+		FAIL(c, dti, node, "missing PCI reg property");
 		return;
 	}
 
 	cells = (cell_t *)prop->val.val;
 	if (cells[1] || cells[2])
-		FAIL(c, dti, "Node %s PCI reg config space address cells 2 and 3 must be 0",
-			     node->fullpath);
+		FAIL_PROP(c, dti, node, prop, "PCI reg config space address cells 2 and 3 must be 0");
 
 	reg = fdt32_to_cpu(cells[0]);
 	dev = (reg & 0xf800) >> 11;
 	func = (reg & 0x700) >> 8;
 
 	if (reg & 0xff000000)
-		FAIL(c, dti, "Node %s PCI reg address is not configuration space",
-			     node->fullpath);
+		FAIL_PROP(c, dti, node, prop, "PCI reg address is not configuration space");
 	if (reg & 0x000000ff)
-		FAIL(c, dti, "Node %s PCI reg config space address register number must be 0",
-			     node->fullpath);
+		FAIL_PROP(c, dti, node, prop, "PCI reg config space address register number must be 0");
 
 	if (func == 0) {
 		snprintf(unit_addr, sizeof(unit_addr), "%x", dev);
@@ -808,8 +874,8 @@ static void check_pci_device_reg(struct check *c, struct dt_info *dti, struct no
 	if (streq(unitname, unit_addr))
 		return;
 
-	FAIL(c, dti, "Node %s PCI unit address format error, expected \"%s\"",
-	     node->fullpath, unit_addr);
+	FAIL(c, dti, node, "PCI unit address format error, expected \"%s\"",
+	     unit_addr);
 }
 WARNING(pci_device_reg, check_pci_device_reg, NULL, &reg_format, &pci_bridge);
 
@@ -828,7 +894,7 @@ static bool node_is_compatible(struct node *node, const char *compat)
 
 	for (str = prop->val.val, end = str + prop->val.len; str < end;
 	     str += strnlen(str, end - str) + 1) {
-		if (strneq(str, compat, end - str))
+		if (strprefixeq(str, end - str, compat))
 			return true;
 	}
 	return false;
@@ -865,7 +931,7 @@ static void check_simple_bus_reg(struct check *c, struct dt_info *dti, struct no
 
 	if (!cells) {
 		if (node->parent->parent && !(node->bus == &simple_bus))
-			FAIL(c, dti, "Node %s missing or empty reg/ranges property", node->fullpath);
+			FAIL(c, dti, node, "missing or empty reg/ranges property");
 		return;
 	}
 
@@ -875,8 +941,8 @@ static void check_simple_bus_reg(struct check *c, struct dt_info *dti, struct no
 
 	snprintf(unit_addr, sizeof(unit_addr), "%"PRIx64, reg);
 	if (!streq(unitname, unit_addr))
-		FAIL(c, dti, "Node %s simple-bus unit address format error, expected \"%s\"",
-		     node->fullpath, unit_addr);
+		FAIL(c, dti, node, "simple-bus unit address format error, expected \"%s\"",
+		     unit_addr);
 }
 WARNING(simple_bus_reg, check_simple_bus_reg, NULL, &reg_format, &simple_bus_bridge);
 
@@ -892,14 +958,12 @@ static void check_unit_address_format(struct check *c, struct dt_info *dti,
 		return;
 
 	if (!strncmp(unitname, "0x", 2)) {
-		FAIL(c, dti, "Node %s unit name should not have leading \"0x\"",
-		    node->fullpath);
+		FAIL(c, dti, node, "unit name should not have leading \"0x\"");
 		/* skip over 0x for next test */
 		unitname += 2;
 	}
 	if (unitname[0] == '0' && isxdigit(unitname[1]))
-		FAIL(c, dti, "Node %s unit name should not have leading 0s",
-		    node->fullpath);
+		FAIL(c, dti, node, "unit name should not have leading 0s");
 }
 WARNING(unit_address_format, check_unit_address_format, NULL,
 	&node_name_format, &pci_bridge, &simple_bus_bridge);
@@ -922,16 +986,38 @@ static void check_avoid_default_addr_size(struct check *c, struct dt_info *dti,
 		return;
 
 	if (node->parent->addr_cells == -1)
-		FAIL(c, dti, "Relying on default #address-cells value for %s",
-		     node->fullpath);
+		FAIL(c, dti, node, "Relying on default #address-cells value");
 
 	if (node->parent->size_cells == -1)
-		FAIL(c, dti, "Relying on default #size-cells value for %s",
-		     node->fullpath);
+		FAIL(c, dti, node, "Relying on default #size-cells value");
 }
 WARNING(avoid_default_addr_size, check_avoid_default_addr_size, NULL,
 	&addr_size_cells);
 
+static void check_avoid_unnecessary_addr_size(struct check *c, struct dt_info *dti,
+					      struct node *node)
+{
+	struct property *prop;
+	struct node *child;
+	bool has_reg = false;
+
+	if (!node->parent || node->addr_cells < 0 || node->size_cells < 0)
+		return;
+
+	if (get_property(node, "ranges") || !node->children)
+		return;
+
+	for_each_child(node, child) {
+		prop = get_property(child, "reg");
+		if (prop)
+			has_reg = true;
+	}
+
+	if (!has_reg)
+		FAIL(c, dti, node, "unnecessary #address-cells/#size-cells without \"ranges\" or child \"reg\" property");
+}
+WARNING(avoid_unnecessary_addr_size, check_avoid_unnecessary_addr_size, NULL, &avoid_default_addr_size);
+
 static void check_obsolete_chosen_interrupt_controller(struct check *c,
 						       struct dt_info *dti,
 						       struct node *node)
@@ -950,12 +1036,61 @@ static void check_obsolete_chosen_interrupt_controller(struct check *c,
 
 	prop = get_property(chosen, "interrupt-controller");
 	if (prop)
-		FAIL(c, dti, "/chosen has obsolete \"interrupt-controller\" "
-		     "property");
+		FAIL_PROP(c, dti, node, prop,
+			  "/chosen has obsolete \"interrupt-controller\" property");
 }
 WARNING(obsolete_chosen_interrupt_controller,
 	check_obsolete_chosen_interrupt_controller, NULL);
 
+static void check_chosen_node_is_root(struct check *c, struct dt_info *dti,
+				      struct node *node)
+{
+	if (!streq(node->name, "chosen"))
+		return;
+
+	if (node->parent != dti->dt)
+		FAIL(c, dti, node, "chosen node must be at root node");
+}
+WARNING(chosen_node_is_root, check_chosen_node_is_root, NULL);
+
+static void check_chosen_node_bootargs(struct check *c, struct dt_info *dti,
+				       struct node *node)
+{
+	struct property *prop;
+
+	if (!streq(node->name, "chosen"))
+		return;
+
+	prop = get_property(node, "bootargs");
+	if (!prop)
+		return;
+
+	c->data = prop->name;
+	check_is_string(c, dti, node);
+}
+WARNING(chosen_node_bootargs, check_chosen_node_bootargs, NULL);
+
+static void check_chosen_node_stdout_path(struct check *c, struct dt_info *dti,
+					  struct node *node)
+{
+	struct property *prop;
+
+	if (!streq(node->name, "chosen"))
+		return;
+
+	prop = get_property(node, "stdout-path");
+	if (!prop) {
+		prop = get_property(node, "linux,stdout-path");
+		if (!prop)
+			return;
+		FAIL_PROP(c, dti, node, prop, "Use 'stdout-path' instead");
+	}
+
+	c->data = prop->name;
+	check_is_string(c, dti, node);
+}
+WARNING(chosen_node_stdout_path, check_chosen_node_stdout_path, NULL);
+
 struct provider {
 	const char *prop_name;
 	const char *cell_name;
@@ -972,8 +1107,9 @@ static void check_property_phandle_args(struct check *c,
 	int cell, cellsize = 0;
 
 	if (prop->val.len % sizeof(cell_t)) {
-		FAIL(c, dti, "property '%s' size (%d) is invalid, expected multiple of %zu in node %s",
-		     prop->name, prop->val.len, sizeof(cell_t), node->fullpath);
+		FAIL_PROP(c, dti, node, prop,
+			  "property size (%d) is invalid, expected multiple of %zu",
+			  prop->val.len, sizeof(cell_t));
 		return;
 	}
 
@@ -1004,14 +1140,16 @@ static void check_property_phandle_args(struct check *c,
 					break;
 			}
 			if (!m)
-				FAIL(c, dti, "Property '%s', cell %d is not a phandle reference in %s",
-				     prop->name, cell, node->fullpath);
+				FAIL_PROP(c, dti, node, prop,
+					  "cell %d is not a phandle reference",
+					  cell);
 		}
 
 		provider_node = get_node_by_phandle(root, phandle);
 		if (!provider_node) {
-			FAIL(c, dti, "Could not get phandle node for %s:%s(cell %d)",
-			     node->fullpath, prop->name, cell);
+			FAIL_PROP(c, dti, node, prop,
+				  "Could not get phandle node for (cell %d)",
+				  cell);
 			break;
 		}
 
@@ -1021,16 +1159,17 @@ static void check_property_phandle_args(struct check *c,
 		} else if (provider->optional) {
 			cellsize = 0;
 		} else {
-			FAIL(c, dti, "Missing property '%s' in node %s or bad phandle (referred from %s:%s[%d])",
+			FAIL(c, dti, node, "Missing property '%s' in node %s or bad phandle (referred from %s[%d])",
 			     provider->cell_name,
 			     provider_node->fullpath,
-			     node->fullpath, prop->name, cell);
+			     prop->name, cell);
 			break;
 		}
 
 		if (prop->val.len < ((cell + cellsize + 1) * sizeof(cell_t))) {
-			FAIL(c, dti, "%s property size (%d) too small for cell size %d in %s",
-			     prop->name, prop->val.len, cellsize, node->fullpath);
+			FAIL_PROP(c, dti, node, prop,
+				  "property size (%d) too small for cell size %d",
+				  prop->val.len, cellsize);
 		}
 	}
 }
@@ -1066,7 +1205,7 @@ WARNING_PROPERTY_PHANDLE_CELLS(phys, "phys", "#phy-cells");
 WARNING_PROPERTY_PHANDLE_CELLS(power_domains, "power-domains", "#power-domain-cells");
 WARNING_PROPERTY_PHANDLE_CELLS(pwms, "pwms", "#pwm-cells");
 WARNING_PROPERTY_PHANDLE_CELLS(resets, "resets", "#reset-cells");
-WARNING_PROPERTY_PHANDLE_CELLS(sound_dais, "sound-dais", "#sound-dai-cells");
+WARNING_PROPERTY_PHANDLE_CELLS(sound_dai, "sound-dai", "#sound-dai-cells");
 WARNING_PROPERTY_PHANDLE_CELLS(thermal_sensors, "thermal-sensors", "#thermal-sensor-cells");
 
 static bool prop_is_gpio(struct property *prop)
@@ -1132,8 +1271,8 @@ static void check_deprecated_gpio_property(struct check *c,
 		if (!streq(str, "gpio"))
 			continue;
 
-		FAIL(c, dti, "'[*-]gpio' is deprecated, use '[*-]gpios' instead for %s:%s",
-		     node->fullpath, prop->name);
+		FAIL_PROP(c, dti, node, prop,
+			  "'[*-]gpio' is deprecated, use '[*-]gpios' instead");
 	}
 
 }
@@ -1167,9 +1306,8 @@ static void check_interrupts_property(struct check *c,
 		return;
 
 	if (irq_prop->val.len % sizeof(cell_t))
-		FAIL(c, dti, "property '%s' size (%d) is invalid, expected multiple of %zu in node %s",
-		     irq_prop->name, irq_prop->val.len, sizeof(cell_t),
-		     node->fullpath);
+		FAIL_PROP(c, dti, node, irq_prop, "size (%d) is invalid, expected multiple of %zu",
+		     irq_prop->val.len, sizeof(cell_t));
 
 	while (parent && !prop) {
 		if (parent != node && node_is_interrupt_provider(parent)) {
@@ -1187,14 +1325,12 @@ static void check_interrupts_property(struct check *c,
 
 			irq_node = get_node_by_phandle(root, phandle);
 			if (!irq_node) {
-				FAIL(c, dti, "Bad interrupt-parent phandle for %s",
-				     node->fullpath);
+				FAIL_PROP(c, dti, parent, prop, "Bad phandle");
 				return;
 			}
 			if (!node_is_interrupt_provider(irq_node))
-				FAIL(c, dti,
-				     "Missing interrupt-controller or interrupt-map property in %s",
-				     irq_node->fullpath);
+				FAIL(c, dti, irq_node,
+				     "Missing interrupt-controller or interrupt-map property");
 
 			break;
 		}
@@ -1203,23 +1339,21 @@ static void check_interrupts_property(struct check *c,
 	}
 
 	if (!irq_node) {
-		FAIL(c, dti, "Missing interrupt-parent for %s", node->fullpath);
+		FAIL(c, dti, node, "Missing interrupt-parent");
 		return;
 	}
 
 	prop = get_property(irq_node, "#interrupt-cells");
 	if (!prop) {
-		FAIL(c, dti, "Missing #interrupt-cells in interrupt-parent %s",
-		     irq_node->fullpath);
+		FAIL(c, dti, irq_node, "Missing #interrupt-cells in interrupt-parent");
 		return;
 	}
 
 	irq_cells = propval_cell(prop);
 	if (irq_prop->val.len % (irq_cells * sizeof(cell_t))) {
-		FAIL(c, dti,
-		     "interrupts size is (%d), expected multiple of %d in %s",
-		     irq_prop->val.len, (int)(irq_cells * sizeof(cell_t)),
-		     node->fullpath);
+		FAIL_PROP(c, dti, node, prop,
+			  "size is (%d), expected multiple of %d",
+			  irq_prop->val.len, (int)(irq_cells * sizeof(cell_t)));
 	}
 }
 WARNING(interrupts_property, check_interrupts_property, &phandle_references);
@@ -1236,6 +1370,9 @@ static struct check *check_table[] = {
 
 	&address_cells_is_cell, &size_cells_is_cell, &interrupt_cells_is_cell,
 	&device_type_is_string, &model_is_string, &status_is_string,
+	&label_is_string,
+
+	&compatible_is_string_list, &names_is_string_list,
 
 	&property_name_chars_strict,
 	&node_name_chars_strict,
@@ -1253,7 +1390,9 @@ static struct check *check_table[] = {
 	&simple_bus_reg,
 
 	&avoid_default_addr_size,
+	&avoid_unnecessary_addr_size,
 	&obsolete_chosen_interrupt_controller,
+	&chosen_node_is_root, &chosen_node_bootargs, &chosen_node_stdout_path,
 
 	&clocks_property,
 	&cooling_device_property,
@@ -1269,13 +1408,15 @@ static struct check *check_table[] = {
 	&power_domains_property,
 	&pwms_property,
 	&resets_property,
-	&sound_dais_property,
+	&sound_dai_property,
 	&thermal_sensors_property,
 
 	&deprecated_gpio_property,
 	&gpios_property,
 	&interrupts_property,
 
+	&alias_paths,
+
 	&always_fail,
 };
 
diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y
index affc81a8f9ab..44af170abfea 100644
--- a/scripts/dtc/dtc-parser.y
+++ b/scripts/dtc/dtc-parser.y
@@ -166,7 +166,17 @@ devicetree:
 		{
 			$$ = merge_nodes($1, $3);
 		}
-
+	| DT_REF nodedef
+		{
+			/*
+			 * We rely on the rule being always:
+			 *   versioninfo plugindecl memreserves devicetree
+			 * so $-1 is what we want (plugindecl)
+			 */
+			if (!($<flags>-1 & DTSF_PLUGIN))
+				ERROR(&@2, "Label or path %s not found", $1);
+			$$ = add_orphan_node(name_node(build_node(NULL, NULL), ""), $2, $1);
+		}
 	| devicetree DT_LABEL DT_REF nodedef
 		{
 			struct node *target = get_node_by_ref($1, $3);
@@ -209,11 +219,6 @@ devicetree:
 
 			$$ = $1;
 		}
-	| /* empty */
-		{
-			/* build empty node */
-			$$ = name_node(build_node(NULL, NULL), "");
-		}
 	;
 
 nodedef:
diff --git a/scripts/dtc/dtc.c b/scripts/dtc/dtc.c
index 5ed873c72ad1..c36994e6eac5 100644
--- a/scripts/dtc/dtc.c
+++ b/scripts/dtc/dtc.c
@@ -59,8 +59,6 @@ static void fill_fullpaths(struct node *tree, const char *prefix)
 }
 
 /* Usage related data. */
-#define FDT_VERSION(version)	_FDT_VERSION(version)
-#define _FDT_VERSION(version)	#version
 static const char usage_synopsis[] = "dtc [options] <input file>";
 static const char usage_short_opts[] = "qI:O:o:V:d:R:S:p:a:fb:i:H:sW:E:@Ahv";
 static struct option const usage_long_opts[] = {
@@ -98,7 +96,7 @@ static const char * const usage_opts_help[] = {
 	 "\t\tdts - device tree source text\n"
 	 "\t\tdtb - device tree blob\n"
 	 "\t\tasm - assembler source",
-	"\n\tBlob version to produce, defaults to "FDT_VERSION(DEFAULT_FDT_VERSION)" (for dtb and asm output)",
+	"\n\tBlob version to produce, defaults to "stringify(DEFAULT_FDT_VERSION)" (for dtb and asm output)",
 	"\n\tOutput dependency file",
 	"\n\tMake space for <number> reserve map entries (for dtb and asm output)",
 	"\n\tMake the blob at least <bytes> long (extra space)",
@@ -319,13 +317,14 @@ int main(int argc, char *argv[])
 		dti->boot_cpuid_phys = cmdline_boot_cpuid;
 
 	fill_fullpaths(dti->dt, "");
-	process_checks(force, dti);
 
 	/* on a plugin, generate by default */
 	if (dti->dtsflags & DTSF_PLUGIN) {
 		generate_fixups = 1;
 	}
 
+	process_checks(force, dti);
+
 	if (auto_label_aliases)
 		generate_label_tree(dti, "aliases", false);
 
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index 35cf926cc14a..3b18a42b866e 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -1,5 +1,5 @@
-#ifndef _DTC_H
-#define _DTC_H
+#ifndef DTC_H
+#define DTC_H
 
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
@@ -67,7 +67,8 @@ typedef uint32_t cell_t;
 
 
 #define streq(a, b)	(strcmp((a), (b)) == 0)
-#define strneq(a, b, n)	(strncmp((a), (b), (n)) == 0)
+#define strstarts(s, prefix)	(strncmp((s), (prefix), strlen(prefix)) == 0)
+#define strprefixeq(a, n, b)	(strlen(b) == (n) && (memcmp(a, b, n) == 0))
 
 #define ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
 
@@ -203,7 +204,7 @@ struct node *build_node_delete(void);
 struct node *name_node(struct node *node, char *name);
 struct node *chain_node(struct node *first, struct node *list);
 struct node *merge_nodes(struct node *old_node, struct node *new_node);
-void add_orphan_node(struct node *old_node, struct node *new_node, char *ref);
+struct node *add_orphan_node(struct node *old_node, struct node *new_node, char *ref);
 
 void add_property(struct node *node, struct property *prop);
 void delete_property_by_name(struct node *node, char *name);
@@ -289,4 +290,4 @@ struct dt_info *dt_from_source(const char *f);
 
 struct dt_info *dt_from_fs(const char *dirname);
 
-#endif /* _DTC_H */
+#endif /* DTC_H */
diff --git a/scripts/dtc/flattree.c b/scripts/dtc/flattree.c
index fcf71541d8a7..8d268fb785db 100644
--- a/scripts/dtc/flattree.c
+++ b/scripts/dtc/flattree.c
@@ -731,7 +731,7 @@ static char *nodename_from_path(const char *ppath, const char *cpath)
 
 	plen = strlen(ppath);
 
-	if (!strneq(ppath, cpath, plen))
+	if (!strstarts(cpath, ppath))
 		die("Path \"%s\" is not valid as a child of \"%s\"\n",
 		    cpath, ppath);
 
diff --git a/scripts/dtc/libfdt/fdt.c b/scripts/dtc/libfdt/fdt.c
index 22286a1aaeaf..7855a1787763 100644
--- a/scripts/dtc/libfdt/fdt.c
+++ b/scripts/dtc/libfdt/fdt.c
@@ -88,7 +88,7 @@ const void *fdt_offset_ptr(const void *fdt, int offset, unsigned int len)
 		    || ((offset + len) > fdt_size_dt_struct(fdt)))
 			return NULL;
 
-	return _fdt_offset_ptr(fdt, offset);
+	return fdt_offset_ptr_(fdt, offset);
 }
 
 uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
@@ -123,6 +123,9 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
 		/* skip-name offset, length and value */
 		offset += sizeof(struct fdt_property) - FDT_TAGSIZE
 			+ fdt32_to_cpu(*lenp);
+		if (fdt_version(fdt) < 0x10 && fdt32_to_cpu(*lenp) >= 8 &&
+		    ((offset - fdt32_to_cpu(*lenp)) % 8) != 0)
+			offset += 4;
 		break;
 
 	case FDT_END:
@@ -141,7 +144,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
 	return tag;
 }
 
-int _fdt_check_node_offset(const void *fdt, int offset)
+int fdt_check_node_offset_(const void *fdt, int offset)
 {
 	if ((offset < 0) || (offset % FDT_TAGSIZE)
 	    || (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE))
@@ -150,7 +153,7 @@ int _fdt_check_node_offset(const void *fdt, int offset)
 	return offset;
 }
 
-int _fdt_check_prop_offset(const void *fdt, int offset)
+int fdt_check_prop_offset_(const void *fdt, int offset)
 {
 	if ((offset < 0) || (offset % FDT_TAGSIZE)
 	    || (fdt_next_tag(fdt, offset, &offset) != FDT_PROP))
@@ -165,7 +168,7 @@ int fdt_next_node(const void *fdt, int offset, int *depth)
 	uint32_t tag;
 
 	if (offset >= 0)
-		if ((nextoffset = _fdt_check_node_offset(fdt, offset)) < 0)
+		if ((nextoffset = fdt_check_node_offset_(fdt, offset)) < 0)
 			return nextoffset;
 
 	do {
@@ -227,7 +230,7 @@ int fdt_next_subnode(const void *fdt, int offset)
 	return offset;
 }
 
-const char *_fdt_find_string(const char *strtab, int tabsize, const char *s)
+const char *fdt_find_string_(const char *strtab, int tabsize, const char *s)
 {
 	int len = strlen(s) + 1;
 	const char *last = strtab + tabsize - len;
diff --git a/scripts/dtc/libfdt/fdt.h b/scripts/dtc/libfdt/fdt.h
index 526aedb51556..74961f9026d1 100644
--- a/scripts/dtc/libfdt/fdt.h
+++ b/scripts/dtc/libfdt/fdt.h
@@ -1,5 +1,5 @@
-#ifndef _FDT_H
-#define _FDT_H
+#ifndef FDT_H
+#define FDT_H
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
@@ -108,4 +108,4 @@ struct fdt_property {
 #define FDT_V16_SIZE	FDT_V3_SIZE
 #define FDT_V17_SIZE	(FDT_V16_SIZE + sizeof(fdt32_t))
 
-#endif /* _FDT_H */
+#endif /* FDT_H */
diff --git a/scripts/dtc/libfdt/fdt_overlay.c b/scripts/dtc/libfdt/fdt_overlay.c
index bd81241e6658..bf75388ec9a2 100644
--- a/scripts/dtc/libfdt/fdt_overlay.c
+++ b/scripts/dtc/libfdt/fdt_overlay.c
@@ -1,3 +1,54 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2016 Free Electrons
+ * Copyright (C) 2016 NextThing Co.
+ *
+ * libfdt is dual licensed: you can use it either under the terms of
+ * the GPL, or the BSD license, at your option.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this library; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
+ *
+ * Alternatively,
+ *
+ *  b) Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *     1. Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *     2. Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
+ *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
+ *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
 #include "libfdt_env.h"
 
 #include <fdt.h>
diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index 08de2cce674d..dfb3236da388 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -55,12 +55,13 @@
 
 #include "libfdt_internal.h"
 
-static int _fdt_nodename_eq(const void *fdt, int offset,
+static int fdt_nodename_eq_(const void *fdt, int offset,
 			    const char *s, int len)
 {
-	const char *p = fdt_offset_ptr(fdt, offset + FDT_TAGSIZE, len+1);
+	int olen;
+	const char *p = fdt_get_name(fdt, offset, &olen);
 
-	if (!p)
+	if (!p || olen < len)
 		/* short match */
 		return 0;
 
@@ -80,7 +81,7 @@ const char *fdt_string(const void *fdt, int stroffset)
 	return (const char *)fdt + fdt_off_dt_strings(fdt) + stroffset;
 }
 
-static int _fdt_string_eq(const void *fdt, int stroffset,
+static int fdt_string_eq_(const void *fdt, int stroffset,
 			  const char *s, int len)
 {
 	const char *p = fdt_string(fdt, stroffset);
@@ -117,8 +118,8 @@ uint32_t fdt_get_max_phandle(const void *fdt)
 int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size)
 {
 	FDT_CHECK_HEADER(fdt);
-	*address = fdt64_to_cpu(_fdt_mem_rsv(fdt, n)->address);
-	*size = fdt64_to_cpu(_fdt_mem_rsv(fdt, n)->size);
+	*address = fdt64_to_cpu(fdt_mem_rsv_(fdt, n)->address);
+	*size = fdt64_to_cpu(fdt_mem_rsv_(fdt, n)->size);
 	return 0;
 }
 
@@ -126,12 +127,12 @@ int fdt_num_mem_rsv(const void *fdt)
 {
 	int i = 0;
 
-	while (fdt64_to_cpu(_fdt_mem_rsv(fdt, i)->size) != 0)
+	while (fdt64_to_cpu(fdt_mem_rsv_(fdt, i)->size) != 0)
 		i++;
 	return i;
 }
 
-static int _nextprop(const void *fdt, int offset)
+static int nextprop_(const void *fdt, int offset)
 {
 	uint32_t tag;
 	int nextoffset;
@@ -166,7 +167,7 @@ int fdt_subnode_offset_namelen(const void *fdt, int offset,
 	     (offset >= 0) && (depth >= 0);
 	     offset = fdt_next_node(fdt, offset, &depth))
 		if ((depth == 1)
-		    && _fdt_nodename_eq(fdt, offset, name, namelen))
+		    && fdt_nodename_eq_(fdt, offset, name, namelen))
 			return offset;
 
 	if (depth < 0)
@@ -232,17 +233,35 @@ int fdt_path_offset(const void *fdt, const char *path)
 
 const char *fdt_get_name(const void *fdt, int nodeoffset, int *len)
 {
-	const struct fdt_node_header *nh = _fdt_offset_ptr(fdt, nodeoffset);
+	const struct fdt_node_header *nh = fdt_offset_ptr_(fdt, nodeoffset);
+	const char *nameptr;
 	int err;
 
 	if (((err = fdt_check_header(fdt)) != 0)
-	    || ((err = _fdt_check_node_offset(fdt, nodeoffset)) < 0))
+	    || ((err = fdt_check_node_offset_(fdt, nodeoffset)) < 0))
 			goto fail;
 
+	nameptr = nh->name;
+
+	if (fdt_version(fdt) < 0x10) {
+		/*
+		 * For old FDT versions, match the naming conventions of V16:
+		 * give only the leaf name (after all /). The actual tree
+		 * contents are loosely checked.
+		 */
+		const char *leaf;
+		leaf = strrchr(nameptr, '/');
+		if (leaf == NULL) {
+			err = -FDT_ERR_BADSTRUCTURE;
+			goto fail;
+		}
+		nameptr = leaf+1;
+	}
+
 	if (len)
-		*len = strlen(nh->name);
+		*len = strlen(nameptr);
 
-	return nh->name;
+	return nameptr;
 
  fail:
 	if (len)
@@ -254,34 +273,34 @@ int fdt_first_property_offset(const void *fdt, int nodeoffset)
 {
 	int offset;
 
-	if ((offset = _fdt_check_node_offset(fdt, nodeoffset)) < 0)
+	if ((offset = fdt_check_node_offset_(fdt, nodeoffset)) < 0)
 		return offset;
 
-	return _nextprop(fdt, offset);
+	return nextprop_(fdt, offset);
 }
 
 int fdt_next_property_offset(const void *fdt, int offset)
 {
-	if ((offset = _fdt_check_prop_offset(fdt, offset)) < 0)
+	if ((offset = fdt_check_prop_offset_(fdt, offset)) < 0)
 		return offset;
 
-	return _nextprop(fdt, offset);
+	return nextprop_(fdt, offset);
 }
 
-const struct fdt_property *fdt_get_property_by_offset(const void *fdt,
-						      int offset,
-						      int *lenp)
+static const struct fdt_property *fdt_get_property_by_offset_(const void *fdt,
+						              int offset,
+						              int *lenp)
 {
 	int err;
 	const struct fdt_property *prop;
 
-	if ((err = _fdt_check_prop_offset(fdt, offset)) < 0) {
+	if ((err = fdt_check_prop_offset_(fdt, offset)) < 0) {
 		if (lenp)
 			*lenp = err;
 		return NULL;
 	}
 
-	prop = _fdt_offset_ptr(fdt, offset);
+	prop = fdt_offset_ptr_(fdt, offset);
 
 	if (lenp)
 		*lenp = fdt32_to_cpu(prop->len);
@@ -289,23 +308,44 @@ const struct fdt_property *fdt_get_property_by_offset(const void *fdt,
 	return prop;
 }
 
-const struct fdt_property *fdt_get_property_namelen(const void *fdt,
-						    int offset,
-						    const char *name,
-						    int namelen, int *lenp)
+const struct fdt_property *fdt_get_property_by_offset(const void *fdt,
+						      int offset,
+						      int *lenp)
+{
+	/* Prior to version 16, properties may need realignment
+	 * and this API does not work. fdt_getprop_*() will, however. */
+
+	if (fdt_version(fdt) < 0x10) {
+		if (lenp)
+			*lenp = -FDT_ERR_BADVERSION;
+		return NULL;
+	}
+
+	return fdt_get_property_by_offset_(fdt, offset, lenp);
+}
+
+static const struct fdt_property *fdt_get_property_namelen_(const void *fdt,
+						            int offset,
+						            const char *name,
+						            int namelen,
+							    int *lenp,
+							    int *poffset)
 {
 	for (offset = fdt_first_property_offset(fdt, offset);
 	     (offset >= 0);
 	     (offset = fdt_next_property_offset(fdt, offset))) {
 		const struct fdt_property *prop;
 
-		if (!(prop = fdt_get_property_by_offset(fdt, offset, lenp))) {
+		if (!(prop = fdt_get_property_by_offset_(fdt, offset, lenp))) {
 			offset = -FDT_ERR_INTERNAL;
 			break;
 		}
-		if (_fdt_string_eq(fdt, fdt32_to_cpu(prop->nameoff),
-				   name, namelen))
+		if (fdt_string_eq_(fdt, fdt32_to_cpu(prop->nameoff),
+				   name, namelen)) {
+			if (poffset)
+				*poffset = offset;
 			return prop;
+		}
 	}
 
 	if (lenp)
@@ -313,6 +353,25 @@ const struct fdt_property *fdt_get_property_namelen(const void *fdt,
 	return NULL;
 }
 
+
+const struct fdt_property *fdt_get_property_namelen(const void *fdt,
+						    int offset,
+						    const char *name,
+						    int namelen, int *lenp)
+{
+	/* Prior to version 16, properties may need realignment
+	 * and this API does not work. fdt_getprop_*() will, however. */
+	if (fdt_version(fdt) < 0x10) {
+		if (lenp)
+			*lenp = -FDT_ERR_BADVERSION;
+		return NULL;
+	}
+
+	return fdt_get_property_namelen_(fdt, offset, name, namelen, lenp,
+					 NULL);
+}
+
+
 const struct fdt_property *fdt_get_property(const void *fdt,
 					    int nodeoffset,
 					    const char *name, int *lenp)
@@ -324,12 +383,18 @@ const struct fdt_property *fdt_get_property(const void *fdt,
 const void *fdt_getprop_namelen(const void *fdt, int nodeoffset,
 				const char *name, int namelen, int *lenp)
 {
+	int poffset;
 	const struct fdt_property *prop;
 
-	prop = fdt_get_property_namelen(fdt, nodeoffset, name, namelen, lenp);
+	prop = fdt_get_property_namelen_(fdt, nodeoffset, name, namelen, lenp,
+					 &poffset);
 	if (!prop)
 		return NULL;
 
+	/* Handle realignment */
+	if (fdt_version(fdt) < 0x10 && (poffset + sizeof(*prop)) % 8 &&
+	    fdt32_to_cpu(prop->len) >= 8)
+		return prop->data + 4;
 	return prop->data;
 }
 
@@ -338,11 +403,16 @@ const void *fdt_getprop_by_offset(const void *fdt, int offset,
 {
 	const struct fdt_property *prop;
 
-	prop = fdt_get_property_by_offset(fdt, offset, lenp);
+	prop = fdt_get_property_by_offset_(fdt, offset, lenp);
 	if (!prop)
 		return NULL;
 	if (namep)
 		*namep = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
+
+	/* Handle realignment */
+	if (fdt_version(fdt) < 0x10 && (offset + sizeof(*prop)) % 8 &&
+	    fdt32_to_cpu(prop->len) >= 8)
+		return prop->data + 4;
 	return prop->data;
 }
 
diff --git a/scripts/dtc/libfdt/fdt_rw.c b/scripts/dtc/libfdt/fdt_rw.c
index 5c3a2bb0bc6b..9b829051e444 100644
--- a/scripts/dtc/libfdt/fdt_rw.c
+++ b/scripts/dtc/libfdt/fdt_rw.c
@@ -55,8 +55,8 @@
 
 #include "libfdt_internal.h"
 
-static int _fdt_blocks_misordered(const void *fdt,
-			      int mem_rsv_size, int struct_size)
+static int fdt_blocks_misordered_(const void *fdt,
+				  int mem_rsv_size, int struct_size)
 {
 	return (fdt_off_mem_rsvmap(fdt) < FDT_ALIGN(sizeof(struct fdt_header), 8))
 		|| (fdt_off_dt_struct(fdt) <
@@ -67,13 +67,13 @@ static int _fdt_blocks_misordered(const void *fdt,
 		    (fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt)));
 }
 
-static int _fdt_rw_check_header(void *fdt)
+static int fdt_rw_check_header_(void *fdt)
 {
 	FDT_CHECK_HEADER(fdt);
 
 	if (fdt_version(fdt) < 17)
 		return -FDT_ERR_BADVERSION;
-	if (_fdt_blocks_misordered(fdt, sizeof(struct fdt_reserve_entry),
+	if (fdt_blocks_misordered_(fdt, sizeof(struct fdt_reserve_entry),
 				   fdt_size_dt_struct(fdt)))
 		return -FDT_ERR_BADLAYOUT;
 	if (fdt_version(fdt) > 17)
@@ -84,20 +84,20 @@ static int _fdt_rw_check_header(void *fdt)
 
 #define FDT_RW_CHECK_HEADER(fdt) \
 	{ \
-		int __err; \
-		if ((__err = _fdt_rw_check_header(fdt)) != 0) \
-			return __err; \
+		int err_; \
+		if ((err_ = fdt_rw_check_header_(fdt)) != 0) \
+			return err_; \
 	}
 
-static inline int _fdt_data_size(void *fdt)
+static inline int fdt_data_size_(void *fdt)
 {
 	return fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
 }
 
-static int _fdt_splice(void *fdt, void *splicepoint, int oldlen, int newlen)
+static int fdt_splice_(void *fdt, void *splicepoint, int oldlen, int newlen)
 {
 	char *p = splicepoint;
-	char *end = (char *)fdt + _fdt_data_size(fdt);
+	char *end = (char *)fdt + fdt_data_size_(fdt);
 
 	if (((p + oldlen) < p) || ((p + oldlen) > end))
 		return -FDT_ERR_BADOFFSET;
@@ -109,12 +109,12 @@ static int _fdt_splice(void *fdt, void *splicepoint, int oldlen, int newlen)
 	return 0;
 }
 
-static int _fdt_splice_mem_rsv(void *fdt, struct fdt_reserve_entry *p,
+static int fdt_splice_mem_rsv_(void *fdt, struct fdt_reserve_entry *p,
 			       int oldn, int newn)
 {
 	int delta = (newn - oldn) * sizeof(*p);
 	int err;
-	err = _fdt_splice(fdt, p, oldn * sizeof(*p), newn * sizeof(*p));
+	err = fdt_splice_(fdt, p, oldn * sizeof(*p), newn * sizeof(*p));
 	if (err)
 		return err;
 	fdt_set_off_dt_struct(fdt, fdt_off_dt_struct(fdt) + delta);
@@ -122,13 +122,13 @@ static int _fdt_splice_mem_rsv(void *fdt, struct fdt_reserve_entry *p,
 	return 0;
 }
 
-static int _fdt_splice_struct(void *fdt, void *p,
+static int fdt_splice_struct_(void *fdt, void *p,
 			      int oldlen, int newlen)
 {
 	int delta = newlen - oldlen;
 	int err;
 
-	if ((err = _fdt_splice(fdt, p, oldlen, newlen)))
+	if ((err = fdt_splice_(fdt, p, oldlen, newlen)))
 		return err;
 
 	fdt_set_size_dt_struct(fdt, fdt_size_dt_struct(fdt) + delta);
@@ -136,20 +136,20 @@ static int _fdt_splice_struct(void *fdt, void *p,
 	return 0;
 }
 
-static int _fdt_splice_string(void *fdt, int newlen)
+static int fdt_splice_string_(void *fdt, int newlen)
 {
 	void *p = (char *)fdt
 		+ fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
 	int err;
 
-	if ((err = _fdt_splice(fdt, p, 0, newlen)))
+	if ((err = fdt_splice_(fdt, p, 0, newlen)))
 		return err;
 
 	fdt_set_size_dt_strings(fdt, fdt_size_dt_strings(fdt) + newlen);
 	return 0;
 }
 
-static int _fdt_find_add_string(void *fdt, const char *s)
+static int fdt_find_add_string_(void *fdt, const char *s)
 {
 	char *strtab = (char *)fdt + fdt_off_dt_strings(fdt);
 	const char *p;
@@ -157,13 +157,13 @@ static int _fdt_find_add_string(void *fdt, const char *s)
 	int len = strlen(s) + 1;
 	int err;
 
-	p = _fdt_find_string(strtab, fdt_size_dt_strings(fdt), s);
+	p = fdt_find_string_(strtab, fdt_size_dt_strings(fdt), s);
 	if (p)
 		/* found it */
 		return (p - strtab);
 
 	new = strtab + fdt_size_dt_strings(fdt);
-	err = _fdt_splice_string(fdt, len);
+	err = fdt_splice_string_(fdt, len);
 	if (err)
 		return err;
 
@@ -178,8 +178,8 @@ int fdt_add_mem_rsv(void *fdt, uint64_t address, uint64_t size)
 
 	FDT_RW_CHECK_HEADER(fdt);
 
-	re = _fdt_mem_rsv_w(fdt, fdt_num_mem_rsv(fdt));
-	err = _fdt_splice_mem_rsv(fdt, re, 0, 1);
+	re = fdt_mem_rsv_w_(fdt, fdt_num_mem_rsv(fdt));
+	err = fdt_splice_mem_rsv_(fdt, re, 0, 1);
 	if (err)
 		return err;
 
@@ -190,17 +190,17 @@ int fdt_add_mem_rsv(void *fdt, uint64_t address, uint64_t size)
 
 int fdt_del_mem_rsv(void *fdt, int n)
 {
-	struct fdt_reserve_entry *re = _fdt_mem_rsv_w(fdt, n);
+	struct fdt_reserve_entry *re = fdt_mem_rsv_w_(fdt, n);
 
 	FDT_RW_CHECK_HEADER(fdt);
 
 	if (n >= fdt_num_mem_rsv(fdt))
 		return -FDT_ERR_NOTFOUND;
 
-	return _fdt_splice_mem_rsv(fdt, re, 1, 0);
+	return fdt_splice_mem_rsv_(fdt, re, 1, 0);
 }
 
-static int _fdt_resize_property(void *fdt, int nodeoffset, const char *name,
+static int fdt_resize_property_(void *fdt, int nodeoffset, const char *name,
 				int len, struct fdt_property **prop)
 {
 	int oldlen;
@@ -210,7 +210,7 @@ static int _fdt_resize_property(void *fdt, int nodeoffset, const char *name,
 	if (!*prop)
 		return oldlen;
 
-	if ((err = _fdt_splice_struct(fdt, (*prop)->data, FDT_TAGALIGN(oldlen),
+	if ((err = fdt_splice_struct_(fdt, (*prop)->data, FDT_TAGALIGN(oldlen),
 				      FDT_TAGALIGN(len))))
 		return err;
 
@@ -218,7 +218,7 @@ static int _fdt_resize_property(void *fdt, int nodeoffset, const char *name,
 	return 0;
 }
 
-static int _fdt_add_property(void *fdt, int nodeoffset, const char *name,
+static int fdt_add_property_(void *fdt, int nodeoffset, const char *name,
 			     int len, struct fdt_property **prop)
 {
 	int proplen;
@@ -226,17 +226,17 @@ static int _fdt_add_property(void *fdt, int nodeoffset, const char *name,
 	int namestroff;
 	int err;
 
-	if ((nextoffset = _fdt_check_node_offset(fdt, nodeoffset)) < 0)
+	if ((nextoffset = fdt_check_node_offset_(fdt, nodeoffset)) < 0)
 		return nextoffset;
 
-	namestroff = _fdt_find_add_string(fdt, name);
+	namestroff = fdt_find_add_string_(fdt, name);
 	if (namestroff < 0)
 		return namestroff;
 
-	*prop = _fdt_offset_ptr_w(fdt, nextoffset);
+	*prop = fdt_offset_ptr_w_(fdt, nextoffset);
 	proplen = sizeof(**prop) + FDT_TAGALIGN(len);
 
-	err = _fdt_splice_struct(fdt, *prop, 0, proplen);
+	err = fdt_splice_struct_(fdt, *prop, 0, proplen);
 	if (err)
 		return err;
 
@@ -260,7 +260,7 @@ int fdt_set_name(void *fdt, int nodeoffset, const char *name)
 
 	newlen = strlen(name);
 
-	err = _fdt_splice_struct(fdt, namep, FDT_TAGALIGN(oldlen+1),
+	err = fdt_splice_struct_(fdt, namep, FDT_TAGALIGN(oldlen+1),
 				 FDT_TAGALIGN(newlen+1));
 	if (err)
 		return err;
@@ -277,9 +277,9 @@ int fdt_setprop_placeholder(void *fdt, int nodeoffset, const char *name,
 
 	FDT_RW_CHECK_HEADER(fdt);
 
-	err = _fdt_resize_property(fdt, nodeoffset, name, len, &prop);
+	err = fdt_resize_property_(fdt, nodeoffset, name, len, &prop);
 	if (err == -FDT_ERR_NOTFOUND)
-		err = _fdt_add_property(fdt, nodeoffset, name, len, &prop);
+		err = fdt_add_property_(fdt, nodeoffset, name, len, &prop);
 	if (err)
 		return err;
 
@@ -313,7 +313,7 @@ int fdt_appendprop(void *fdt, int nodeoffset, const char *name,
 	prop = fdt_get_property_w(fdt, nodeoffset, name, &oldlen);
 	if (prop) {
 		newlen = len + oldlen;
-		err = _fdt_splice_struct(fdt, prop->data,
+		err = fdt_splice_struct_(fdt, prop->data,
 					 FDT_TAGALIGN(oldlen),
 					 FDT_TAGALIGN(newlen));
 		if (err)
@@ -321,7 +321,7 @@ int fdt_appendprop(void *fdt, int nodeoffset, const char *name,
 		prop->len = cpu_to_fdt32(newlen);
 		memcpy(prop->data + oldlen, val, len);
 	} else {
-		err = _fdt_add_property(fdt, nodeoffset, name, len, &prop);
+		err = fdt_add_property_(fdt, nodeoffset, name, len, &prop);
 		if (err)
 			return err;
 		memcpy(prop->data, val, len);
@@ -341,7 +341,7 @@ int fdt_delprop(void *fdt, int nodeoffset, const char *name)
 		return len;
 
 	proplen = sizeof(*prop) + FDT_TAGALIGN(len);
-	return _fdt_splice_struct(fdt, prop, proplen, 0);
+	return fdt_splice_struct_(fdt, prop, proplen, 0);
 }
 
 int fdt_add_subnode_namelen(void *fdt, int parentoffset,
@@ -369,10 +369,10 @@ int fdt_add_subnode_namelen(void *fdt, int parentoffset,
 		tag = fdt_next_tag(fdt, offset, &nextoffset);
 	} while ((tag == FDT_PROP) || (tag == FDT_NOP));
 
-	nh = _fdt_offset_ptr_w(fdt, offset);
+	nh = fdt_offset_ptr_w_(fdt, offset);
 	nodelen = sizeof(*nh) + FDT_TAGALIGN(namelen+1) + FDT_TAGSIZE;
 
-	err = _fdt_splice_struct(fdt, nh, 0, nodelen);
+	err = fdt_splice_struct_(fdt, nh, 0, nodelen);
 	if (err)
 		return err;
 
@@ -396,15 +396,15 @@ int fdt_del_node(void *fdt, int nodeoffset)
 
 	FDT_RW_CHECK_HEADER(fdt);
 
-	endoffset = _fdt_node_end_offset(fdt, nodeoffset);
+	endoffset = fdt_node_end_offset_(fdt, nodeoffset);
 	if (endoffset < 0)
 		return endoffset;
 
-	return _fdt_splice_struct(fdt, _fdt_offset_ptr_w(fdt, nodeoffset),
+	return fdt_splice_struct_(fdt, fdt_offset_ptr_w_(fdt, nodeoffset),
 				  endoffset - nodeoffset, 0);
 }
 
-static void _fdt_packblocks(const char *old, char *new,
+static void fdt_packblocks_(const char *old, char *new,
 			    int mem_rsv_size, int struct_size)
 {
 	int mem_rsv_off, struct_off, strings_off;
@@ -450,7 +450,7 @@ int fdt_open_into(const void *fdt, void *buf, int bufsize)
 			return struct_size;
 	}
 
-	if (!_fdt_blocks_misordered(fdt, mem_rsv_size, struct_size)) {
+	if (!fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
 		/* no further work necessary */
 		err = fdt_move(fdt, buf, bufsize);
 		if (err)
@@ -478,7 +478,7 @@ int fdt_open_into(const void *fdt, void *buf, int bufsize)
 			return -FDT_ERR_NOSPACE;
 	}
 
-	_fdt_packblocks(fdt, tmp, mem_rsv_size, struct_size);
+	fdt_packblocks_(fdt, tmp, mem_rsv_size, struct_size);
 	memmove(buf, tmp, newsize);
 
 	fdt_set_magic(buf, FDT_MAGIC);
@@ -498,8 +498,8 @@ int fdt_pack(void *fdt)
 
 	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
 		* sizeof(struct fdt_reserve_entry);
-	_fdt_packblocks(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt));
-	fdt_set_totalsize(fdt, _fdt_data_size(fdt));
+	fdt_packblocks_(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt));
+	fdt_set_totalsize(fdt, fdt_data_size_(fdt));
 
 	return 0;
 }
diff --git a/scripts/dtc/libfdt/fdt_sw.c b/scripts/dtc/libfdt/fdt_sw.c
index 2bd15e7aef87..6d33cc29d022 100644
--- a/scripts/dtc/libfdt/fdt_sw.c
+++ b/scripts/dtc/libfdt/fdt_sw.c
@@ -55,7 +55,7 @@
 
 #include "libfdt_internal.h"
 
-static int _fdt_sw_check_header(void *fdt)
+static int fdt_sw_check_header_(void *fdt)
 {
 	if (fdt_magic(fdt) != FDT_SW_MAGIC)
 		return -FDT_ERR_BADMAGIC;
@@ -66,11 +66,11 @@ static int _fdt_sw_check_header(void *fdt)
 #define FDT_SW_CHECK_HEADER(fdt) \
 	{ \
 		int err; \
-		if ((err = _fdt_sw_check_header(fdt)) != 0) \
+		if ((err = fdt_sw_check_header_(fdt)) != 0) \
 			return err; \
 	}
 
-static void *_fdt_grab_space(void *fdt, size_t len)
+static void *fdt_grab_space_(void *fdt, size_t len)
 {
 	int offset = fdt_size_dt_struct(fdt);
 	int spaceleft;
@@ -82,7 +82,7 @@ static void *_fdt_grab_space(void *fdt, size_t len)
 		return NULL;
 
 	fdt_set_size_dt_struct(fdt, offset + len);
-	return _fdt_offset_ptr_w(fdt, offset);
+	return fdt_offset_ptr_w_(fdt, offset);
 }
 
 int fdt_create(void *buf, int bufsize)
@@ -174,7 +174,7 @@ int fdt_begin_node(void *fdt, const char *name)
 
 	FDT_SW_CHECK_HEADER(fdt);
 
-	nh = _fdt_grab_space(fdt, sizeof(*nh) + FDT_TAGALIGN(namelen));
+	nh = fdt_grab_space_(fdt, sizeof(*nh) + FDT_TAGALIGN(namelen));
 	if (! nh)
 		return -FDT_ERR_NOSPACE;
 
@@ -189,7 +189,7 @@ int fdt_end_node(void *fdt)
 
 	FDT_SW_CHECK_HEADER(fdt);
 
-	en = _fdt_grab_space(fdt, FDT_TAGSIZE);
+	en = fdt_grab_space_(fdt, FDT_TAGSIZE);
 	if (! en)
 		return -FDT_ERR_NOSPACE;
 
@@ -197,7 +197,7 @@ int fdt_end_node(void *fdt)
 	return 0;
 }
 
-static int _fdt_find_add_string(void *fdt, const char *s)
+static int fdt_find_add_string_(void *fdt, const char *s)
 {
 	char *strtab = (char *)fdt + fdt_totalsize(fdt);
 	const char *p;
@@ -205,7 +205,7 @@ static int _fdt_find_add_string(void *fdt, const char *s)
 	int len = strlen(s) + 1;
 	int struct_top, offset;
 
-	p = _fdt_find_string(strtab - strtabsize, strtabsize, s);
+	p = fdt_find_string_(strtab - strtabsize, strtabsize, s);
 	if (p)
 		return p - strtab;
 
@@ -227,11 +227,11 @@ int fdt_property_placeholder(void *fdt, const char *name, int len, void **valp)
 
 	FDT_SW_CHECK_HEADER(fdt);
 
-	nameoff = _fdt_find_add_string(fdt, name);
+	nameoff = fdt_find_add_string_(fdt, name);
 	if (nameoff == 0)
 		return -FDT_ERR_NOSPACE;
 
-	prop = _fdt_grab_space(fdt, sizeof(*prop) + FDT_TAGALIGN(len));
+	prop = fdt_grab_space_(fdt, sizeof(*prop) + FDT_TAGALIGN(len));
 	if (! prop)
 		return -FDT_ERR_NOSPACE;
 
@@ -265,7 +265,7 @@ int fdt_finish(void *fdt)
 	FDT_SW_CHECK_HEADER(fdt);
 
 	/* Add terminator */
-	end = _fdt_grab_space(fdt, sizeof(*end));
+	end = fdt_grab_space_(fdt, sizeof(*end));
 	if (! end)
 		return -FDT_ERR_NOSPACE;
 	*end = cpu_to_fdt32(FDT_END);
@@ -281,7 +281,7 @@ int fdt_finish(void *fdt)
 	while ((tag = fdt_next_tag(fdt, offset, &nextoffset)) != FDT_END) {
 		if (tag == FDT_PROP) {
 			struct fdt_property *prop =
-				_fdt_offset_ptr_w(fdt, offset);
+				fdt_offset_ptr_w_(fdt, offset);
 			int nameoff;
 
 			nameoff = fdt32_to_cpu(prop->nameoff);
diff --git a/scripts/dtc/libfdt/fdt_wip.c b/scripts/dtc/libfdt/fdt_wip.c
index 5e859198622b..534c1cbbb2f3 100644
--- a/scripts/dtc/libfdt/fdt_wip.c
+++ b/scripts/dtc/libfdt/fdt_wip.c
@@ -93,7 +93,7 @@ int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
 						   val, len);
 }
 
-static void _fdt_nop_region(void *start, int len)
+static void fdt_nop_region_(void *start, int len)
 {
 	fdt32_t *p;
 
@@ -110,12 +110,12 @@ int fdt_nop_property(void *fdt, int nodeoffset, const char *name)
 	if (!prop)
 		return len;
 
-	_fdt_nop_region(prop, len + sizeof(*prop));
+	fdt_nop_region_(prop, len + sizeof(*prop));
 
 	return 0;
 }
 
-int _fdt_node_end_offset(void *fdt, int offset)
+int fdt_node_end_offset_(void *fdt, int offset)
 {
 	int depth = 0;
 
@@ -129,11 +129,11 @@ int fdt_nop_node(void *fdt, int nodeoffset)
 {
 	int endoffset;
 
-	endoffset = _fdt_node_end_offset(fdt, nodeoffset);
+	endoffset = fdt_node_end_offset_(fdt, nodeoffset);
 	if (endoffset < 0)
 		return endoffset;
 
-	_fdt_nop_region(fdt_offset_ptr_w(fdt, nodeoffset, 0),
+	fdt_nop_region_(fdt_offset_ptr_w(fdt, nodeoffset, 0),
 			endoffset - nodeoffset);
 	return 0;
 }
diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
index 7f83023ee109..1e27780e1185 100644
--- a/scripts/dtc/libfdt/libfdt.h
+++ b/scripts/dtc/libfdt/libfdt.h
@@ -1,5 +1,5 @@
-#ifndef _LIBFDT_H
-#define _LIBFDT_H
+#ifndef LIBFDT_H
+#define LIBFDT_H
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
@@ -54,7 +54,7 @@
 #include "libfdt_env.h"
 #include "fdt.h"
 
-#define FDT_FIRST_SUPPORTED_VERSION	0x10
+#define FDT_FIRST_SUPPORTED_VERSION	0x02
 #define FDT_LAST_SUPPORTED_VERSION	0x11
 
 /* Error codes: informative error codes */
@@ -225,23 +225,23 @@ int fdt_next_subnode(const void *fdt, int offset);
 #define fdt_size_dt_strings(fdt)	(fdt_get_header(fdt, size_dt_strings))
 #define fdt_size_dt_struct(fdt)		(fdt_get_header(fdt, size_dt_struct))
 
-#define __fdt_set_hdr(name) \
+#define fdt_set_hdr_(name) \
 	static inline void fdt_set_##name(void *fdt, uint32_t val) \
 	{ \
 		struct fdt_header *fdth = (struct fdt_header *)fdt; \
 		fdth->name = cpu_to_fdt32(val); \
 	}
-__fdt_set_hdr(magic);
-__fdt_set_hdr(totalsize);
-__fdt_set_hdr(off_dt_struct);
-__fdt_set_hdr(off_dt_strings);
-__fdt_set_hdr(off_mem_rsvmap);
-__fdt_set_hdr(version);
-__fdt_set_hdr(last_comp_version);
-__fdt_set_hdr(boot_cpuid_phys);
-__fdt_set_hdr(size_dt_strings);
-__fdt_set_hdr(size_dt_struct);
-#undef __fdt_set_hdr
+fdt_set_hdr_(magic);
+fdt_set_hdr_(totalsize);
+fdt_set_hdr_(off_dt_struct);
+fdt_set_hdr_(off_dt_strings);
+fdt_set_hdr_(off_mem_rsvmap);
+fdt_set_hdr_(version);
+fdt_set_hdr_(last_comp_version);
+fdt_set_hdr_(boot_cpuid_phys);
+fdt_set_hdr_(size_dt_strings);
+fdt_set_hdr_(size_dt_struct);
+#undef fdt_set_hdr_
 
 /**
  * fdt_check_header - sanity check a device tree or possible device tree
@@ -527,6 +527,9 @@ int fdt_next_property_offset(const void *fdt, int offset);
  * offset.  If lenp is non-NULL, the length of the property value is
  * also returned, in the integer pointed to by lenp.
  *
+ * Note that this code only works on device tree versions >= 16. fdt_getprop()
+ * works on all versions.
+ *
  * returns:
  *	pointer to the structure representing the property
  *		if lenp is non-NULL, *lenp contains the length of the property
@@ -1449,7 +1452,7 @@ int fdt_setprop(void *fdt, int nodeoffset, const char *name,
 		const void *val, int len);
 
 /**
- * fdt_setprop _placeholder - allocate space for a property
+ * fdt_setprop_placeholder - allocate space for a property
  * @fdt: pointer to the device tree blob
  * @nodeoffset: offset of the node whose property to change
  * @name: name of the property to change
@@ -1896,4 +1899,4 @@ int fdt_overlay_apply(void *fdt, void *fdto);
 
 const char *fdt_strerror(int errval);
 
-#endif /* _LIBFDT_H */
+#endif /* LIBFDT_H */
diff --git a/scripts/dtc/libfdt/libfdt_env.h b/scripts/dtc/libfdt/libfdt_env.h
index 952056cddf09..bd2474628775 100644
--- a/scripts/dtc/libfdt/libfdt_env.h
+++ b/scripts/dtc/libfdt/libfdt_env.h
@@ -1,5 +1,5 @@
-#ifndef _LIBFDT_ENV_H
-#define _LIBFDT_ENV_H
+#ifndef LIBFDT_ENV_H
+#define LIBFDT_ENV_H
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
@@ -109,4 +109,31 @@ static inline fdt64_t cpu_to_fdt64(uint64_t x)
 #undef CPU_TO_FDT16
 #undef EXTRACT_BYTE
 
-#endif /* _LIBFDT_ENV_H */
+#ifdef __APPLE__
+#include <AvailabilityMacros.h>
+
+/* strnlen() is not available on Mac OS < 10.7 */
+# if !defined(MAC_OS_X_VERSION_10_7) || (MAC_OS_X_VERSION_MAX_ALLOWED < \
+                                         MAC_OS_X_VERSION_10_7)
+
+#define strnlen fdt_strnlen
+
+/*
+ * fdt_strnlen: returns the length of a string or max_count - which ever is
+ * smallest.
+ * Input 1 string: the string whose size is to be determined
+ * Input 2 max_count: the maximum value returned by this function
+ * Output: length of the string or max_count (the smallest of the two)
+ */
+static inline size_t fdt_strnlen(const char *string, size_t max_count)
+{
+    const char *p = memchr(string, 0, max_count);
+    return p ? p - string : max_count;
+}
+
+#endif /* !defined(MAC_OS_X_VERSION_10_7) || (MAC_OS_X_VERSION_MAX_ALLOWED <
+          MAC_OS_X_VERSION_10_7) */
+
+#endif /* __APPLE__ */
+
+#endif /* LIBFDT_ENV_H */
diff --git a/scripts/dtc/libfdt/libfdt_internal.h b/scripts/dtc/libfdt/libfdt_internal.h
index 02cfa6fb612d..7681e192295b 100644
--- a/scripts/dtc/libfdt/libfdt_internal.h
+++ b/scripts/dtc/libfdt/libfdt_internal.h
@@ -1,5 +1,5 @@
-#ifndef _LIBFDT_INTERNAL_H
-#define _LIBFDT_INTERNAL_H
+#ifndef LIBFDT_INTERNAL_H
+#define LIBFDT_INTERNAL_H
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
@@ -57,27 +57,27 @@
 
 #define FDT_CHECK_HEADER(fdt) \
 	{ \
-		int __err; \
-		if ((__err = fdt_check_header(fdt)) != 0) \
-			return __err; \
+		int err_; \
+		if ((err_ = fdt_check_header(fdt)) != 0) \
+			return err_; \
 	}
 
-int _fdt_check_node_offset(const void *fdt, int offset);
-int _fdt_check_prop_offset(const void *fdt, int offset);
-const char *_fdt_find_string(const char *strtab, int tabsize, const char *s);
-int _fdt_node_end_offset(void *fdt, int nodeoffset);
+int fdt_check_node_offset_(const void *fdt, int offset);
+int fdt_check_prop_offset_(const void *fdt, int offset);
+const char *fdt_find_string_(const char *strtab, int tabsize, const char *s);
+int fdt_node_end_offset_(void *fdt, int nodeoffset);
 
-static inline const void *_fdt_offset_ptr(const void *fdt, int offset)
+static inline const void *fdt_offset_ptr_(const void *fdt, int offset)
 {
 	return (const char *)fdt + fdt_off_dt_struct(fdt) + offset;
 }
 
-static inline void *_fdt_offset_ptr_w(void *fdt, int offset)
+static inline void *fdt_offset_ptr_w_(void *fdt, int offset)
 {
-	return (void *)(uintptr_t)_fdt_offset_ptr(fdt, offset);
+	return (void *)(uintptr_t)fdt_offset_ptr_(fdt, offset);
 }
 
-static inline const struct fdt_reserve_entry *_fdt_mem_rsv(const void *fdt, int n)
+static inline const struct fdt_reserve_entry *fdt_mem_rsv_(const void *fdt, int n)
 {
 	const struct fdt_reserve_entry *rsv_table =
 		(const struct fdt_reserve_entry *)
@@ -85,11 +85,11 @@ static inline const struct fdt_reserve_entry *_fdt_mem_rsv(const void *fdt, int
 
 	return rsv_table + n;
 }
-static inline struct fdt_reserve_entry *_fdt_mem_rsv_w(void *fdt, int n)
+static inline struct fdt_reserve_entry *fdt_mem_rsv_w_(void *fdt, int n)
 {
-	return (void *)(uintptr_t)_fdt_mem_rsv(fdt, n);
+	return (void *)(uintptr_t)fdt_mem_rsv_(fdt, n);
 }
 
 #define FDT_SW_MAGIC		(~FDT_MAGIC)
 
-#endif /* _LIBFDT_INTERNAL_H */
+#endif /* LIBFDT_INTERNAL_H */
diff --git a/scripts/dtc/livetree.c b/scripts/dtc/livetree.c
index 6846ad2fd6d2..57b7db2ed153 100644
--- a/scripts/dtc/livetree.c
+++ b/scripts/dtc/livetree.c
@@ -216,7 +216,7 @@ struct node *merge_nodes(struct node *old_node, struct node *new_node)
 	return old_node;
 }
 
-void add_orphan_node(struct node *dt, struct node *new_node, char *ref)
+struct node * add_orphan_node(struct node *dt, struct node *new_node, char *ref)
 {
 	static unsigned int next_orphan_fragment = 0;
 	struct node *node;
@@ -236,6 +236,7 @@ void add_orphan_node(struct node *dt, struct node *new_node, char *ref)
 	name_node(node, name);
 
 	add_child(dt, node);
+	return dt;
 }
 
 struct node *chain_node(struct node *first, struct node *list)
@@ -507,7 +508,7 @@ struct node *get_node_by_path(struct node *tree, const char *path)
 
 	for_each_child(tree, child) {
 		if (p && (strlen(child->name) == p-path) &&
-				strneq(path, child->name, p-path))
+		    strprefixeq(path, p - path, child->name))
 			return get_node_by_path(child, p+1);
 		else if (!p && streq(path, child->name))
 			return child;
@@ -540,7 +541,10 @@ struct node *get_node_by_phandle(struct node *tree, cell_t phandle)
 {
 	struct node *child, *node;
 
-	assert((phandle != 0) && (phandle != -1));
+	if ((phandle == 0) || (phandle == -1)) {
+		assert(generate_fixups);
+		return NULL;
+	}
 
 	if (tree->phandle == phandle) {
 		if (tree->deleted)
diff --git a/scripts/dtc/srcpos.c b/scripts/dtc/srcpos.c
index 9d38459902f3..cb6ed0e3e5e4 100644
--- a/scripts/dtc/srcpos.c
+++ b/scripts/dtc/srcpos.c
@@ -209,8 +209,6 @@ struct srcpos srcpos_empty = {
 	.file = NULL,
 };
 
-#define TAB_SIZE      8
-
 void srcpos_update(struct srcpos *pos, const char *text, int len)
 {
 	int i;
@@ -224,9 +222,6 @@ void srcpos_update(struct srcpos *pos, const char *text, int len)
 		if (text[i] == '\n') {
 			current_srcfile->lineno++;
 			current_srcfile->colno = 1;
-		} else if (text[i] == '\t') {
-			current_srcfile->colno =
-				ALIGN(current_srcfile->colno, TAB_SIZE);
 		} else {
 			current_srcfile->colno++;
 		}
diff --git a/scripts/dtc/srcpos.h b/scripts/dtc/srcpos.h
index 7caca8257c6d..9ded12a3830a 100644
--- a/scripts/dtc/srcpos.h
+++ b/scripts/dtc/srcpos.h
@@ -17,8 +17,8 @@
  *                                                                   USA
  */
 
-#ifndef _SRCPOS_H_
-#define _SRCPOS_H_
+#ifndef SRCPOS_H
+#define SRCPOS_H
 
 #include <stdio.h>
 #include <stdbool.h>
@@ -114,4 +114,4 @@ extern void PRINTF(3, 4) srcpos_error(struct srcpos *pos, const char *prefix,
 
 extern void srcpos_set_line(char *f, int l);
 
-#endif /* _SRCPOS_H_ */
+#endif /* SRCPOS_H */
diff --git a/scripts/dtc/util.h b/scripts/dtc/util.h
index ad5f41199edb..66fba8ea709b 100644
--- a/scripts/dtc/util.h
+++ b/scripts/dtc/util.h
@@ -1,5 +1,5 @@
-#ifndef _UTIL_H
-#define _UTIL_H
+#ifndef UTIL_H
+#define UTIL_H
 
 #include <stdarg.h>
 #include <stdbool.h>
@@ -35,6 +35,9 @@
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
+#define stringify(s)	stringify_(s)
+#define stringify_(s)	#s
+
 static inline void NORETURN PRINTF(1, 2) die(const char *str, ...)
 {
 	va_list ap;
@@ -260,4 +263,4 @@ void NORETURN util_usage(const char *errmsg, const char *synopsis,
 	case 'V': util_version(); \
 	case '?': usage("unknown option");
 
-#endif /* _UTIL_H */
+#endif /* UTIL_H */
diff --git a/scripts/dtc/version_gen.h b/scripts/dtc/version_gen.h
index 6a4e84798966..ad87849e333b 100644
--- a/scripts/dtc/version_gen.h
+++ b/scripts/dtc/version_gen.h
@@ -1 +1 @@
-#define DTC_VERSION "DTC 1.4.5-gc1e55a55"
+#define DTC_VERSION "DTC 1.4.6-gaadd0b65"
-- 
2.14.1
