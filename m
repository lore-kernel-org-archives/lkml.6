Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755278AbeEHNv4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:51:56 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39743 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755183AbeEHNvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:51:53 -0400
X-Google-Smtp-Source: AB8JxZoS8tqtk8RJLYEiLQMk48E2x+naVV6noUA/3lS4hssPymXpPJP0n8V7c3jnyNkfyLFbXqHBsw==
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] scripts/dtc: Update to upstream version v1.4.6-21-g84e414b0b5bc
Date: Tue,  8 May 2018 08:51:49 -0500
Message-Id: <20180508135150.27762-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the following commits from upstream:

84e414b0b5bc tests: Add a test case for the omit-if-no-ref keyword
4038fd90056e dtc: add ability to make nodes conditional on them being referenced
e1f139ea4900 checks: drop warning for missing PCI bridge bus-range
f4eba68d89ee checks: Print duplicate node name instead of parent name
46df1fb1b211 .travis.yml: Run valgrind checks via Travis
14a3002a1aee tests: Update valgrind suppressions for sw_tree1
02c5fe9debc0 tests: Remove valgrind error from tests/get_path
df536831d02c checks: add graph binding checks
2347c96edcbe checks: add a check for duplicate unit-addresses of child nodes
8f1b35f88395 Correct overlay syntactic sugar for generating target-path fragments
afbddcd418fb Suppress warnings on overlay fragments
119e27300359 Improve tests for dtc overlay generation

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/dtc/checks.c      | 204 +++++++++++++++++++++++++++++++++++++-
 scripts/dtc/dtc-lexer.l   |   7 ++
 scripts/dtc/dtc-parser.y  |  39 ++++++--
 scripts/dtc/dtc.h         |   4 +
 scripts/dtc/livetree.c    |  26 ++++-
 scripts/dtc/version_gen.h |   2 +-
 6 files changed, 263 insertions(+), 19 deletions(-)

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index c07ba4da9e36..a2cc1036c915 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -255,7 +255,7 @@ static void check_duplicate_node_names(struct check *c, struct dt_info *dti,
 		     child2;
 		     child2 = child2->next_sibling)
 			if (streq(child->name, child2->name))
-				FAIL(c, dti, node, "Duplicate node name");
+				FAIL(c, dti, child2, "Duplicate node name");
 }
 ERROR(duplicate_node_names, check_duplicate_node_names, NULL);
 
@@ -317,6 +317,11 @@ static void check_unit_address_vs_reg(struct check *c, struct dt_info *dti,
 	const char *unitname = get_unitname(node);
 	struct property *prop = get_property(node, "reg");
 
+	if (get_subnode(node, "__overlay__")) {
+		/* HACK: Overlay fragments are a special case */
+		return;
+	}
+
 	if (!prop) {
 		prop = get_property(node, "ranges");
 		if (prop && !prop->val.len)
@@ -579,6 +584,8 @@ static void fixup_phandle_references(struct check *c, struct dt_info *dti,
 
 			phandle = get_node_phandle(dt, refnode);
 			*((fdt32_t *)(prop->val.val + m->offset)) = cpu_to_fdt32(phandle);
+
+			reference_node(refnode);
 		}
 	}
 }
@@ -609,11 +616,21 @@ static void fixup_path_references(struct check *c, struct dt_info *dti,
 			path = refnode->fullpath;
 			prop->val = data_insert_at_marker(prop->val, m, path,
 							  strlen(path) + 1);
+
+			reference_node(refnode);
 		}
 	}
 }
 ERROR(path_references, fixup_path_references, NULL, &duplicate_node_names);
 
+static void fixup_omit_unused_nodes(struct check *c, struct dt_info *dti,
+				    struct node *node)
+{
+	if (node->omit_if_unused && !node->is_referenced)
+		delete_node(node);
+}
+ERROR(omit_unused_nodes, fixup_omit_unused_nodes, NULL, &phandle_references, &path_references);
+
 /*
  * Semantic checks
  */
@@ -787,10 +804,9 @@ static void check_pci_bridge(struct check *c, struct dt_info *dti, struct node *
 		FAIL(c, dti, node, "incorrect #size-cells for PCI bridge");
 
 	prop = get_property(node, "bus-range");
-	if (!prop) {
-		FAIL(c, dti, node, "missing bus-range for PCI bridge");
+	if (!prop)
 		return;
-	}
+
 	if (prop->val.len != (sizeof(cell_t) * 2)) {
 		FAIL_PROP(c, dti, node, prop, "value must be 2 cells");
 		return;
@@ -1018,6 +1034,36 @@ static void check_avoid_unnecessary_addr_size(struct check *c, struct dt_info *d
 }
 WARNING(avoid_unnecessary_addr_size, check_avoid_unnecessary_addr_size, NULL, &avoid_default_addr_size);
 
+static void check_unique_unit_address(struct check *c, struct dt_info *dti,
+					      struct node *node)
+{
+	struct node *childa;
+
+	if (node->addr_cells < 0 || node->size_cells < 0)
+		return;
+
+	if (!node->children)
+		return;
+
+	for_each_child(node, childa) {
+		struct node *childb;
+		const char *addr_a = get_unitname(childa);
+
+		if (!strlen(addr_a))
+			continue;
+
+		for_each_child(node, childb) {
+			const char *addr_b = get_unitname(childb);
+			if (childa == childb)
+				break;
+
+			if (streq(addr_a, addr_b))
+				FAIL(c, dti, childb, "duplicate unit-address (also used in node %s)", childa->fullpath);
+		}
+	}
+}
+WARNING(unique_unit_address, check_unique_unit_address, NULL, &avoid_default_addr_size);
+
 static void check_obsolete_chosen_interrupt_controller(struct check *c,
 						       struct dt_info *dti,
 						       struct node *node)
@@ -1358,6 +1404,152 @@ static void check_interrupts_property(struct check *c,
 }
 WARNING(interrupts_property, check_interrupts_property, &phandle_references);
 
+static const struct bus_type graph_port_bus = {
+	.name = "graph-port",
+};
+
+static const struct bus_type graph_ports_bus = {
+	.name = "graph-ports",
+};
+
+static void check_graph_nodes(struct check *c, struct dt_info *dti,
+			      struct node *node)
+{
+	struct node *child;
+
+	for_each_child(node, child) {
+		if (!(strprefixeq(child->name, child->basenamelen, "endpoint") ||
+		      get_property(child, "remote-endpoint")))
+			continue;
+
+		node->bus = &graph_port_bus;
+
+		/* The parent of 'port' nodes can be either 'ports' or a device */
+		if (!node->parent->bus &&
+		    (streq(node->parent->name, "ports") || get_property(node, "reg")))
+			node->parent->bus = &graph_ports_bus;
+
+		break;
+	}
+
+}
+WARNING(graph_nodes, check_graph_nodes, NULL);
+
+static void check_graph_child_address(struct check *c, struct dt_info *dti,
+				      struct node *node)
+{
+	int cnt = 0;
+	struct node *child;
+
+	if (node->bus != &graph_ports_bus && node->bus != &graph_port_bus)
+		return;
+
+	for_each_child(node, child) {
+		struct property *prop = get_property(child, "reg");
+
+		/* No error if we have any non-zero unit address */
+		if (prop && propval_cell(prop) != 0)
+			return;
+
+		cnt++;
+	}
+
+	if (cnt == 1 && node->addr_cells != -1)
+		FAIL(c, dti, node, "graph node has single child node '%s', #address-cells/#size-cells are not necessary",
+		     node->children->name);
+}
+WARNING(graph_child_address, check_graph_child_address, NULL, &graph_nodes);
+
+static void check_graph_reg(struct check *c, struct dt_info *dti,
+			    struct node *node)
+{
+	char unit_addr[9];
+	const char *unitname = get_unitname(node);
+	struct property *prop;
+
+	prop = get_property(node, "reg");
+	if (!prop || !unitname)
+		return;
+
+	if (!(prop->val.val && prop->val.len == sizeof(cell_t))) {
+		FAIL(c, dti, node, "graph node malformed 'reg' property");
+		return;
+	}
+
+	snprintf(unit_addr, sizeof(unit_addr), "%x", propval_cell(prop));
+	if (!streq(unitname, unit_addr))
+		FAIL(c, dti, node, "graph node unit address error, expected \"%s\"",
+		     unit_addr);
+
+	if (node->parent->addr_cells != 1)
+		FAIL_PROP(c, dti, node, get_property(node, "#address-cells"),
+			  "graph node '#address-cells' is %d, must be 1",
+			  node->parent->addr_cells);
+	if (node->parent->size_cells != 0)
+		FAIL_PROP(c, dti, node, get_property(node, "#size-cells"),
+			  "graph node '#size-cells' is %d, must be 0",
+			  node->parent->size_cells);
+}
+
+static void check_graph_port(struct check *c, struct dt_info *dti,
+			     struct node *node)
+{
+	if (node->bus != &graph_port_bus)
+		return;
+
+	if (!strprefixeq(node->name, node->basenamelen, "port"))
+		FAIL(c, dti, node, "graph port node name should be 'port'");
+
+	check_graph_reg(c, dti, node);
+}
+WARNING(graph_port, check_graph_port, NULL, &graph_nodes);
+
+static struct node *get_remote_endpoint(struct check *c, struct dt_info *dti,
+					struct node *endpoint)
+{
+	int phandle;
+	struct node *node;
+	struct property *prop;
+
+	prop = get_property(endpoint, "remote-endpoint");
+	if (!prop)
+		return NULL;
+
+	phandle = propval_cell(prop);
+	/* Give up if this is an overlay with external references */
+	if (phandle == 0 || phandle == -1)
+		return NULL;
+
+	node = get_node_by_phandle(dti->dt, phandle);
+	if (!node)
+		FAIL_PROP(c, dti, endpoint, prop, "graph phandle is not valid");
+
+	return node;
+}
+
+static void check_graph_endpoint(struct check *c, struct dt_info *dti,
+				 struct node *node)
+{
+	struct node *remote_node;
+
+	if (!node->parent || node->parent->bus != &graph_port_bus)
+		return;
+
+	if (!strprefixeq(node->name, node->basenamelen, "endpoint"))
+		FAIL(c, dti, node, "graph endpont node name should be 'endpoint'");
+
+	check_graph_reg(c, dti, node);
+
+	remote_node = get_remote_endpoint(c, dti, node);
+	if (!remote_node)
+		return;
+
+	if (get_remote_endpoint(c, dti, remote_node) != node)
+		FAIL(c, dti, node, "graph connection to node '%s' is not bidirectional",
+		     remote_node->fullpath);
+}
+WARNING(graph_endpoint, check_graph_endpoint, NULL, &graph_nodes);
+
 static struct check *check_table[] = {
 	&duplicate_node_names, &duplicate_property_names,
 	&node_name_chars, &node_name_format, &property_name_chars,
@@ -1367,6 +1559,7 @@ static struct check *check_table[] = {
 
 	&explicit_phandles,
 	&phandle_references, &path_references,
+	&omit_unused_nodes,
 
 	&address_cells_is_cell, &size_cells_is_cell, &interrupt_cells_is_cell,
 	&device_type_is_string, &model_is_string, &status_is_string,
@@ -1391,6 +1584,7 @@ static struct check *check_table[] = {
 
 	&avoid_default_addr_size,
 	&avoid_unnecessary_addr_size,
+	&unique_unit_address,
 	&obsolete_chosen_interrupt_controller,
 	&chosen_node_is_root, &chosen_node_bootargs, &chosen_node_stdout_path,
 
@@ -1417,6 +1611,8 @@ static struct check *check_table[] = {
 
 	&alias_paths,
 
+	&graph_nodes, &graph_child_address, &graph_port, &graph_endpoint,
+
 	&always_fail,
 };
 
diff --git a/scripts/dtc/dtc-lexer.l b/scripts/dtc/dtc-lexer.l
index fd825ebba69c..615b7ec6588f 100644
--- a/scripts/dtc/dtc-lexer.l
+++ b/scripts/dtc/dtc-lexer.l
@@ -153,6 +153,13 @@ static void PRINTF(1, 2) lexical_error(const char *fmt, ...);
 			return DT_DEL_NODE;
 		}
 
+<*>"/omit-if-no-ref/"	{
+			DPRINT("Keyword: /omit-if-no-ref/\n");
+			DPRINT("<PROPNODENAME>\n");
+			BEGIN(PROPNODENAME);
+			return DT_OMIT_NO_REF;
+		}
+
 <*>{LABEL}:	{
 			DPRINT("Label: %s\n", yytext);
 			yylval.labelref = xstrdup(yytext);
diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y
index 44af170abfea..011a5b25539a 100644
--- a/scripts/dtc/dtc-parser.y
+++ b/scripts/dtc/dtc-parser.y
@@ -63,6 +63,7 @@ extern bool treesource_error;
 %token DT_BITS
 %token DT_DEL_PROP
 %token DT_DEL_NODE
+%token DT_OMIT_NO_REF
 %token <propnodename> DT_PROPNODENAME
 %token <integer> DT_LITERAL
 %token <integer> DT_CHAR_LITERAL
@@ -190,18 +191,18 @@ devicetree:
 		}
 	| devicetree DT_REF nodedef
 		{
-			struct node *target = get_node_by_ref($1, $2);
-
-			if (target) {
-				merge_nodes(target, $3);
+			/*
+			 * We rely on the rule being always:
+			 *   versioninfo plugindecl memreserves devicetree
+			 * so $-1 is what we want (plugindecl)
+			 */
+			if ($<flags>-1 & DTSF_PLUGIN) {
+				add_orphan_node($1, $3, $2);
 			} else {
-				/*
-				 * We rely on the rule being always:
-				 *   versioninfo plugindecl memreserves devicetree
-				 * so $-1 is what we want (plugindecl)
-				 */
-				if ($<flags>-1 & DTSF_PLUGIN)
-					add_orphan_node($1, $3, $2);
+				struct node *target = get_node_by_ref($1, $2);
+
+				if (target)
+					merge_nodes(target, $3);
 				else
 					ERROR(&@2, "Label or path %s not found", $2);
 			}
@@ -217,6 +218,18 @@ devicetree:
 				ERROR(&@3, "Label or path %s not found", $3);
 
 
+			$$ = $1;
+		}
+	| devicetree DT_OMIT_NO_REF DT_REF ';'
+		{
+			struct node *target = get_node_by_ref($1, $3);
+
+			if (target)
+				omit_node_if_unused(target);
+			else
+				ERROR(&@3, "Label or path %s not found", $3);
+
+
 			$$ = $1;
 		}
 	;
@@ -523,6 +536,10 @@ subnode:
 		{
 			$$ = name_node(build_node_delete(), $2);
 		}
+	| DT_OMIT_NO_REF subnode
+		{
+			$$ = omit_node_if_unused($2);
+		}
 	| DT_LABEL subnode
 		{
 			add_label(&$2->labels, $1);
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index 3b18a42b866e..6d667701ab6a 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -168,6 +168,8 @@ struct node {
 
 	struct label *labels;
 	const struct bus_type *bus;
+
+	bool omit_if_unused, is_referenced;
 };
 
 #define for_each_label_withdel(l0, l) \
@@ -202,6 +204,8 @@ struct property *reverse_properties(struct property *first);
 struct node *build_node(struct property *proplist, struct node *children);
 struct node *build_node_delete(void);
 struct node *name_node(struct node *node, char *name);
+struct node *omit_node_if_unused(struct node *node);
+struct node *reference_node(struct node *node);
 struct node *chain_node(struct node *first, struct node *list);
 struct node *merge_nodes(struct node *old_node, struct node *new_node);
 struct node *add_orphan_node(struct node *old_node, struct node *new_node, char *ref);
diff --git a/scripts/dtc/livetree.c b/scripts/dtc/livetree.c
index 57b7db2ed153..6e4c367f54b3 100644
--- a/scripts/dtc/livetree.c
+++ b/scripts/dtc/livetree.c
@@ -134,6 +134,20 @@ struct node *name_node(struct node *node, char *name)
 	return node;
 }
 
+struct node *omit_node_if_unused(struct node *node)
+{
+	node->omit_if_unused = 1;
+
+	return node;
+}
+
+struct node *reference_node(struct node *node)
+{
+	node->is_referenced = 1;
+
+	return node;
+}
+
 struct node *merge_nodes(struct node *old_node, struct node *new_node)
 {
 	struct property *new_prop, *old_prop;
@@ -224,10 +238,16 @@ struct node * add_orphan_node(struct node *dt, struct node *new_node, char *ref)
 	struct data d = empty_data;
 	char *name;
 
-	d = data_add_marker(d, REF_PHANDLE, ref);
-	d = data_append_integer(d, 0xffffffff, 32);
+	if (ref[0] == '/') {
+		d = data_append_data(d, ref, strlen(ref) + 1);
 
-	p = build_property("target", d);
+		p = build_property("target-path", d);
+	} else {
+		d = data_add_marker(d, REF_PHANDLE, ref);
+		d = data_append_integer(d, 0xffffffff, 32);
+
+		p = build_property("target", d);
+	}
 
 	xasprintf(&name, "fragment@%u",
 			next_orphan_fragment++);
diff --git a/scripts/dtc/version_gen.h b/scripts/dtc/version_gen.h
index ad87849e333b..b00f14ff7a17 100644
--- a/scripts/dtc/version_gen.h
+++ b/scripts/dtc/version_gen.h
@@ -1 +1 @@
-#define DTC_VERSION "DTC 1.4.6-gaadd0b65"
+#define DTC_VERSION "DTC 1.4.6-g84e414b0"
-- 
2.17.0
