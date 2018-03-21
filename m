Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCUC3G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbeCUCV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3632183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022125.143851826@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 12/46] tracing: Add per-element variable support to tracing_map
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0012-tracing-Add-per-element-variable-support-to-tracing_.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

In order to allow information to be passed between trace events, add
support for per-element variables to tracing_map.  This provides a
means for histograms to associate a value or values with an entry when
it's saved or updated, and retrieved by a subsequent event occurrences.

Variables can be set using tracing_map_set_var() and read using
tracing_map_read_var().  tracing_map_var_set() returns true or false
depending on whether or not the variable has been set or not, which is
important for event-matching applications.

tracing_map_read_var_once() reads the variable and resets it to the
'unset' state, implementing read-once variables, which are also
important for event-matching uses.

Link: http://lkml.kernel.org/r/7fa001108252556f0c6dd9d63145eabfe3370d1a.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/tracing_map.c | 108 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/tracing_map.h |  11 +++++
 2 files changed, 119 insertions(+)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index f47a4d54bcf0..5cadb1b8b5fe 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -66,6 +66,73 @@ u64 tracing_map_read_sum(struct tracing_map_elt *elt, unsigned int i)
 	return (u64)atomic64_read(&elt->fields[i].sum);
 }
 
+/**
+ * tracing_map_set_var - Assign a tracing_map_elt's variable field
+ * @elt: The tracing_map_elt
+ * @i: The index of the given variable associated with the tracing_map_elt
+ * @n: The value to assign
+ *
+ * Assign n to variable i associated with the specified tracing_map_elt
+ * instance.  The index i is the index returned by the call to
+ * tracing_map_add_var() when the tracing map was set up.
+ */
+void tracing_map_set_var(struct tracing_map_elt *elt, unsigned int i, u64 n)
+{
+	atomic64_set(&elt->vars[i], n);
+	elt->var_set[i] = true;
+}
+
+/**
+ * tracing_map_var_set - Return whether or not a variable has been set
+ * @elt: The tracing_map_elt
+ * @i: The index of the given variable associated with the tracing_map_elt
+ *
+ * Return true if the variable has been set, false otherwise.  The
+ * index i is the index returned by the call to tracing_map_add_var()
+ * when the tracing map was set up.
+ */
+bool tracing_map_var_set(struct tracing_map_elt *elt, unsigned int i)
+{
+	return elt->var_set[i];
+}
+
+/**
+ * tracing_map_read_var - Return the value of a tracing_map_elt's variable field
+ * @elt: The tracing_map_elt
+ * @i: The index of the given variable associated with the tracing_map_elt
+ *
+ * Retrieve the value of the variable i associated with the specified
+ * tracing_map_elt instance.  The index i is the index returned by the
+ * call to tracing_map_add_var() when the tracing map was set
+ * up.
+ *
+ * Return: The variable value associated with field i for elt.
+ */
+u64 tracing_map_read_var(struct tracing_map_elt *elt, unsigned int i)
+{
+	return (u64)atomic64_read(&elt->vars[i]);
+}
+
+/**
+ * tracing_map_read_var_once - Return and reset a tracing_map_elt's variable field
+ * @elt: The tracing_map_elt
+ * @i: The index of the given variable associated with the tracing_map_elt
+ *
+ * Retrieve the value of the variable i associated with the specified
+ * tracing_map_elt instance, and reset the variable to the 'not set'
+ * state.  The index i is the index returned by the call to
+ * tracing_map_add_var() when the tracing map was set up.  The reset
+ * essentially makes the variable a read-once variable if it's only
+ * accessed using this function.
+ *
+ * Return: The variable value associated with field i for elt.
+ */
+u64 tracing_map_read_var_once(struct tracing_map_elt *elt, unsigned int i)
+{
+	elt->var_set[i] = false;
+	return (u64)atomic64_read(&elt->vars[i]);
+}
+
 int tracing_map_cmp_string(void *val_a, void *val_b)
 {
 	char *a = val_a;
@@ -170,6 +237,28 @@ int tracing_map_add_sum_field(struct tracing_map *map)
 	return tracing_map_add_field(map, tracing_map_cmp_atomic64);
 }
 
+/**
+ * tracing_map_add_var - Add a field describing a tracing_map var
+ * @map: The tracing_map
+ *
+ * Add a var to the map and return the index identifying it in the map
+ * and associated tracing_map_elts.  This is the index used for
+ * instance to update a var for a particular tracing_map_elt using
+ * tracing_map_update_var() or reading it via tracing_map_read_var().
+ *
+ * Return: The index identifying the var in the map and associated
+ * tracing_map_elts, or -EINVAL on error.
+ */
+int tracing_map_add_var(struct tracing_map *map)
+{
+	int ret = -EINVAL;
+
+	if (map->n_vars < TRACING_MAP_VARS_MAX)
+		ret = map->n_vars++;
+
+	return ret;
+}
+
 /**
  * tracing_map_add_key_field - Add a field describing a tracing_map key
  * @map: The tracing_map
@@ -280,6 +369,11 @@ static void tracing_map_elt_clear(struct tracing_map_elt *elt)
 		if (elt->fields[i].cmp_fn == tracing_map_cmp_atomic64)
 			atomic64_set(&elt->fields[i].sum, 0);
 
+	for (i = 0; i < elt->map->n_vars; i++) {
+		atomic64_set(&elt->vars[i], 0);
+		elt->var_set[i] = false;
+	}
+
 	if (elt->map->ops && elt->map->ops->elt_clear)
 		elt->map->ops->elt_clear(elt);
 }
@@ -306,6 +400,8 @@ static void tracing_map_elt_free(struct tracing_map_elt *elt)
 	if (elt->map->ops && elt->map->ops->elt_free)
 		elt->map->ops->elt_free(elt);
 	kfree(elt->fields);
+	kfree(elt->vars);
+	kfree(elt->var_set);
 	kfree(elt->key);
 	kfree(elt);
 }
@@ -333,6 +429,18 @@ static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing_map *map)
 		goto free;
 	}
 
+	elt->vars = kcalloc(map->n_vars, sizeof(*elt->vars), GFP_KERNEL);
+	if (!elt->vars) {
+		err = -ENOMEM;
+		goto free;
+	}
+
+	elt->var_set = kcalloc(map->n_vars, sizeof(*elt->var_set), GFP_KERNEL);
+	if (!elt->var_set) {
+		err = -ENOMEM;
+		goto free;
+	}
+
 	tracing_map_elt_init_fields(elt);
 
 	if (map->ops && map->ops->elt_alloc) {
diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index de57887c0670..053eb92b2d31 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -10,6 +10,7 @@
 #define TRACING_MAP_VALS_MAX		3
 #define TRACING_MAP_FIELDS_MAX		(TRACING_MAP_KEYS_MAX + \
 					 TRACING_MAP_VALS_MAX)
+#define TRACING_MAP_VARS_MAX		16
 #define TRACING_MAP_SORT_KEYS_MAX	2
 
 typedef int (*tracing_map_cmp_fn_t) (void *val_a, void *val_b);
@@ -137,6 +138,8 @@ struct tracing_map_field {
 struct tracing_map_elt {
 	struct tracing_map		*map;
 	struct tracing_map_field	*fields;
+	atomic64_t			*vars;
+	bool				*var_set;
 	void				*key;
 	void				*private_data;
 };
@@ -192,6 +195,7 @@ struct tracing_map {
 	int				key_idx[TRACING_MAP_KEYS_MAX];
 	unsigned int			n_keys;
 	struct tracing_map_sort_key	sort_key;
+	unsigned int			n_vars;
 	atomic64_t			hits;
 	atomic64_t			drops;
 };
@@ -241,6 +245,7 @@ tracing_map_create(unsigned int map_bits,
 extern int tracing_map_init(struct tracing_map *map);
 
 extern int tracing_map_add_sum_field(struct tracing_map *map);
+extern int tracing_map_add_var(struct tracing_map *map);
 extern int tracing_map_add_key_field(struct tracing_map *map,
 				     unsigned int offset,
 				     tracing_map_cmp_fn_t cmp_fn);
@@ -260,7 +265,13 @@ extern int tracing_map_cmp_none(void *val_a, void *val_b);
 
 extern void tracing_map_update_sum(struct tracing_map_elt *elt,
 				   unsigned int i, u64 n);
+extern void tracing_map_set_var(struct tracing_map_elt *elt,
+				unsigned int i, u64 n);
+extern bool tracing_map_var_set(struct tracing_map_elt *elt, unsigned int i);
 extern u64 tracing_map_read_sum(struct tracing_map_elt *elt, unsigned int i);
+extern u64 tracing_map_read_var(struct tracing_map_elt *elt, unsigned int i);
+extern u64 tracing_map_read_var_once(struct tracing_map_elt *elt, unsigned int i);
+
 extern void tracing_map_set_field_descr(struct tracing_map *map,
 					unsigned int i,
 					unsigned int key_offset,
-- 
2.15.1
