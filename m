Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZpDZqEyXK+79S0MVSHRcZoWOT0A1sEJD/UH2rUaWGE9zBJ4XDWdXmSofJczPPgWQ+kL4zDV
ARC-Seal: i=1; a=rsa-sha256; t=1524702375; cv=none;
        d=google.com; s=arc-20160816;
        b=V6eJaUq8iIctRhWyF23djFnjCOK+KMehN3JHSHQYcTMUVcbXqURHwnyhi7CXANjPtw
         y6c31aOJlDVuD1GO3uJ7zk8ekov0wlatw5sxFpwP/W4dRPIAzSIoevW3s0DKPGZSWNE6
         XgZhPO3htPzmGRhhugW47Vt3D2KzOFlu0XxlNcrARQ3gUuMy93lUwCj+76vvxlPhEI9B
         wW9yLAortivlipV/AMXLTMRkD/RRMReV5skkCZDJornzKcwBG86zVEM+exa4cglxzSkv
         N46RiqexHglhOPPwQnj3mgjq4ko+hghyQqG8O4RgRR8ewNhQ3gEhObiRFUzOJdO5CijS
         TKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=xrsfQ0BWSCycXEFadHb8xkRsRzihprvs7q3Zrn2cckM=;
        b=ubiXxxKVdI4NID93at3wMngCLSsc0uUqlHDK5TKA2NjuteE2Ara656rJu/Y+Zt3Bwe
         apwJPAlOgMnuNdWglJvJT5hWyTB8Y/08G/DiRit2JVgfFetClVDzxJ/mbWkohu1NI4hc
         Lemp4y7ZZBQ7bRPQN/gGjlA8CzUSSvxxr0/Q9zr/XAO0knhoe+s/XMbCgyIfmJx1YV8V
         ywEvrA98ttt6wFho/rxf2Jz7v4m3C26U/rzN9xNE9a9tyyYxA5CJ6AzIEwNtTgG/JQiI
         3ydKjg0ZKmFjMJTOo4Txwt5plhDY/YGryxj28979+IBkAZbvX+77f8M38G9yNLlMaFII
         BC2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: Sudeep.Holla@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo.Pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	Will.Deacon@arm.com,
	Catalin.Marinas@arm.com,
	gregkh@linuxfoundation.org,
	Mark.Rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	Dietmar.Eggemann@arm.com,
	Morten.Rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	jhugo@qti.qualcomm.com,
	timur@qti.qualcomm.com,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v8 05/13] ACPI/PPTT: Add Processor Properties Topology Table parsing
Date: Wed, 25 Apr 2018 18:31:13 -0500
Message-Id: <20180425233121.13270-6-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766317939933372?=
X-GMAIL-MSGID: =?utf-8?q?1598766317939933372?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ACPI 6.2 adds a new table, which describes how processing units
are related to each other in tree like fashion. Caches are
also sprinkled throughout the tree and describe the properties
of the caches in relation to other caches and processing units.

Add the code to parse the cache hierarchy and report the total
number of levels of cache for a given core using
acpi_find_last_cache_level() as well as fill out the individual
cores cache information with cache_setup_acpi() once the
cpu_cacheinfo structure has been populated by the arch specific
code.

An additional patch later in the set adds the ability to report
peers in the topology using find_acpi_cpu_topology()
to report a unique ID for each processing unit at a given level
in the tree. These unique id's can then be used to match related
processing units which exist as threads, within a given
package, etc.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/pptt.c | 518 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 518 insertions(+)
 create mode 100644 drivers/acpi/pptt.c

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
new file mode 100644
index 000000000000..cced71ef851a
--- /dev/null
+++ b/drivers/acpi/pptt.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pptt.c - parsing of Processor Properties Topology Table
+ *
+ * Copyright (C) 2018, ARM
+ *
+ * This file implements parsing of Processor Properties Topology Table (PPTT)
+ * which is optionally used to describe the processor and cache topology.
+ * Due to the relative pointers used throughout the table, this doesn't
+ * leverage the existing subtable parsing in the kernel.
+ *
+ * The PPTT structure is an inverted tree, with each node potentially
+ * holding one or two inverted tree data structures describing
+ * the caches available at that level. Each cache structure optionally
+ * contains properties describing the cache at a given level which can be
+ * used to override hardware probed values.
+ */
+#define pr_fmt(fmt) "ACPI PPTT: " fmt
+
+#include <linux/acpi.h>
+#include <linux/cacheinfo.h>
+#include <acpi/processor.h>
+
+/**
+ * fetch_pptt_subtable() - Find/Verify that the PPTT ref is a valid subtable
+ *
+ * Given the PPTT table, find and verify that the subtable entry
+ * is located within the table
+ *
+ * Return: acpi_subtable_header* or NULL
+ */
+static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_table_header *table_hdr,
+							u32 pptt_ref)
+{
+	struct acpi_subtable_header *entry;
+
+	/* there isn't a subtable at reference 0 */
+	if (pptt_ref < sizeof(struct acpi_subtable_header))
+		return NULL;
+
+	if (pptt_ref + sizeof(struct acpi_subtable_header) > table_hdr->length)
+		return NULL;
+
+	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr, pptt_ref);
+
+	if (entry->length == 0)
+		return NULL;
+
+	if (pptt_ref + entry->length > table_hdr->length)
+		return NULL;
+
+	return entry;
+}
+
+static struct acpi_pptt_processor *fetch_pptt_node(struct acpi_table_header *table_hdr,
+						   u32 pptt_ref)
+{
+	return (struct acpi_pptt_processor *)fetch_pptt_subtable(table_hdr, pptt_ref);
+}
+
+static struct acpi_pptt_cache *fetch_pptt_cache(struct acpi_table_header *table_hdr,
+						u32 pptt_ref)
+{
+	return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr, pptt_ref);
+}
+
+static struct acpi_subtable_header *acpi_get_pptt_resource(struct acpi_table_header *table_hdr,
+							   struct acpi_pptt_processor *node,
+							   int resource)
+{
+	u32 *ref;
+
+	if (resource >= node->number_of_priv_resources)
+		return NULL;
+
+	ref = ACPI_ADD_PTR(u32, node, sizeof(struct acpi_pptt_processor));
+	ref += resource;
+
+	return fetch_pptt_subtable(table_hdr, *ref);
+}
+
+/**
+ * acpi_pptt_match_type() - Return true if the PPTT type matches the request
+ *
+ * Match the type passed and special case the TYPE_UNIFIED so that
+ * it match both ACPI_PPTT_CACHE_TYPE_UNIFIED(_ALT) types.
+ *
+ * Return: true for match, false otherwise
+ */
+static inline bool acpi_pptt_match_type(int table_type, int type)
+{
+	return ((table_type & ACPI_PPTT_MASK_CACHE_TYPE) == type ||
+		table_type & ACPI_PPTT_CACHE_TYPE_UNIFIED & type);
+}
+
+/**
+ * acpi_pptt_walk_cache() - Attempt to find the requested acpi_pptt_cache
+ *
+ * Attempt to find a given cache level, while counting the max number
+ * of cache levels for the cache node.
+ *
+ * Given a pptt resource, verify that it is a cache node, then walk
+ * down each level of caches, counting how many levels are found
+ * as well as checking the cache type (icache, dcache, unified). If a
+ * level & type match, then we set found, and continue the search.
+ * Once the entire cache branch has been walked return its max
+ * depth.
+ *
+ * Return: The cache structure and the level we terminated with.
+ */
+static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
+				int local_level,
+				struct acpi_subtable_header *res,
+				struct acpi_pptt_cache **found,
+				int level, int type)
+{
+	struct acpi_pptt_cache *cache;
+
+	if (res->type != ACPI_PPTT_TYPE_CACHE)
+		return 0;
+
+	cache = (struct acpi_pptt_cache *) res;
+	while (cache) {
+		local_level++;
+
+		if (local_level == level &&
+		    cache->flags & ACPI_PPTT_CACHE_TYPE_VALID &&
+		    acpi_pptt_match_type(cache->attributes, type)) {
+			if (*found != NULL && cache != *found)
+				pr_warn("Found duplicate cache level/type unable to determine uniqueness\n");
+
+			pr_debug("Found cache @ level %d\n", level);
+			*found = cache;
+			/*
+			 * continue looking at this node's resource list
+			 * to verify that we don't find a duplicate
+			 * cache node.
+			 */
+		}
+		cache = fetch_pptt_cache(table_hdr, cache->next_level_of_cache);
+	}
+	return local_level;
+}
+
+/**
+ * acpi_find_cache_level() - Given the cpu find a given cache node
+ *
+ * Given a CPU node look for cache levels that exist at this level, and then
+ * for each cache node, count how many levels exist below (logically above) it.
+ * If a level and type are specified, and we find that level/type, abort
+ * processing and return the acpi_pptt_cache structure.
+ *
+ * Return: NULL or the cache node requested.
+ */
+static struct acpi_pptt_cache *acpi_find_cache_level(struct acpi_table_header *table_hdr,
+						     struct acpi_pptt_processor *cpu_node,
+						     int *starting_level, int level,
+						     int type)
+{
+	struct acpi_subtable_header *res;
+	int number_of_levels = *starting_level;
+	int resource = 0;
+	struct acpi_pptt_cache *ret = NULL;
+	int local_level;
+
+	/* walk down from processor node */
+	while ((res = acpi_get_pptt_resource(table_hdr, cpu_node, resource))) {
+		resource++;
+
+		local_level = acpi_pptt_walk_cache(table_hdr, *starting_level,
+						   res, &ret, level, type);
+		/*
+		 * we are looking for the max depth. Since its potentially
+		 * possible for a given node to have resources with differing
+		 * depths verify that the depth we have found is the largest.
+		 */
+		if (number_of_levels < local_level)
+			number_of_levels = local_level;
+	}
+	if (number_of_levels > *starting_level)
+		*starting_level = number_of_levels;
+
+	return ret;
+}
+
+/**
+ * acpi_process_node() - Given a PPTT table, and a cpu node, count the caches
+ *
+ * Given a processor node containing a processing unit, walk into it and count
+ * how many levels exist solely for it, and then walk up each level until we hit
+ * the root node (ignore the package level because it may be possible to have
+ * caches that exist across packages). Count the number of cache levels that
+ * exist at each level on the way up.
+ *
+ * Return: Total number of levels found.
+ */
+static int acpi_process_node(struct acpi_table_header *table_hdr,
+			     struct acpi_pptt_processor *cpu_node)
+{
+	int total_levels = 0;
+
+	do {
+		acpi_find_cache_level(table_hdr, cpu_node, &total_levels, 0, 0);
+		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
+	} while (cpu_node);
+
+	return total_levels;
+}
+
+/**
+ * acpi_pptt_leaf_node() - Given a processor node, determine if its a leaf
+ *
+ * Determine if the *node parameter is a leaf node by iterating the
+ * PPTT table, looking for nodes which reference it.
+ *
+ * Return: 0 if we find a node referencing the passed node (or table error),
+ * or 1 if we don't.
+ */
+static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
+			       struct acpi_pptt_processor *node)
+{
+	struct acpi_subtable_header *entry;
+	unsigned long table_end;
+	u32 node_entry;
+	struct acpi_pptt_processor *cpu_node;
+	u32 proc_sz;
+
+	table_end = (unsigned long)table_hdr + table_hdr->length;
+	node_entry = ACPI_PTR_DIFF(node, table_hdr);
+	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
+			     sizeof(struct acpi_table_pptt));
+	proc_sz = sizeof(struct acpi_pptt_processor *);
+
+	while ((unsigned long)entry + proc_sz < table_end) {
+		cpu_node = (struct acpi_pptt_processor *)entry;
+		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
+		    cpu_node->parent == node_entry)
+			return 0;
+		if (entry->length == 0)
+			return 0;
+		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
+				     entry->length);
+
+	}
+	return 1;
+}
+
+/**
+ * acpi_find_processor_node() - Given a PPTT table find the requested processor
+ *
+ * Find the subtable entry describing the provided processor.
+ * This is done by iterating the PPTT table looking for processor nodes
+ * which have an acpi_processor_id that matches the acpi_cpu_id parameter
+ * passed into the function. If we find a node that matches this criteria
+ * we verify that its a leaf node in the topology rather than depending
+ * on the valid flag, which doesn't need to be set for leaf nodes.
+ *
+ * Return: NULL, or the processors acpi_pptt_processor*
+ */
+static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_header *table_hdr,
+							    u32 acpi_cpu_id)
+{
+	struct acpi_subtable_header *entry;
+	unsigned long table_end;
+	struct acpi_pptt_processor *cpu_node;
+	u32 proc_sz;
+
+	table_end = (unsigned long)table_hdr + table_hdr->length;
+	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
+			     sizeof(struct acpi_table_pptt));
+	proc_sz = sizeof(struct acpi_pptt_processor *);
+
+	/* find the processor structure associated with this cpuid */
+	while ((unsigned long)entry + proc_sz < table_end) {
+		cpu_node = (struct acpi_pptt_processor *)entry;
+
+		if (entry->length == 0) {
+			pr_warn("Invalid zero length subtable\n");
+			break;
+		}
+		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
+		    acpi_cpu_id == cpu_node->acpi_processor_id &&
+		     acpi_pptt_leaf_node(table_hdr, cpu_node)) {
+			return (struct acpi_pptt_processor *)entry;
+		}
+
+		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
+				     entry->length);
+	}
+
+	return NULL;
+}
+
+static int acpi_find_cache_levels(struct acpi_table_header *table_hdr,
+				  u32 acpi_cpu_id)
+{
+	int number_of_levels = 0;
+	struct acpi_pptt_processor *cpu;
+
+	cpu = acpi_find_processor_node(table_hdr, acpi_cpu_id);
+	if (cpu)
+		number_of_levels = acpi_process_node(table_hdr, cpu);
+
+	return number_of_levels;
+}
+
+/* Convert the linux cache_type to a ACPI PPTT cache type value */
+static u8 acpi_cache_type(enum cache_type type)
+{
+	switch (type) {
+	case CACHE_TYPE_DATA:
+		pr_debug("Looking for data cache\n");
+		return ACPI_PPTT_CACHE_TYPE_DATA;
+	case CACHE_TYPE_INST:
+		pr_debug("Looking for instruction cache\n");
+		return ACPI_PPTT_CACHE_TYPE_INSTR;
+	default:
+	case CACHE_TYPE_UNIFIED:
+		pr_debug("Looking for unified cache\n");
+		/*
+		 * It is important that ACPI_PPTT_CACHE_TYPE_UNIFIED
+		 * contains the bit pattern that will match both
+		 * ACPI unified bit patterns because we use it later
+		 * to match both cases.
+		 */
+		return ACPI_PPTT_CACHE_TYPE_UNIFIED;
+	}
+}
+
+/* find the ACPI node describing the cache type/level for the given CPU */
+static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *table_hdr,
+						    u32 acpi_cpu_id,
+						    enum cache_type type,
+						    unsigned int level,
+						    struct acpi_pptt_processor **node)
+{
+	int total_levels = 0;
+	struct acpi_pptt_cache *found = NULL;
+	struct acpi_pptt_processor *cpu_node;
+	u8 acpi_type = acpi_cache_type(type);
+
+	pr_debug("Looking for CPU %d's level %d cache type %d\n",
+		 acpi_cpu_id, level, acpi_type);
+
+	cpu_node = acpi_find_processor_node(table_hdr, acpi_cpu_id);
+
+	while (cpu_node && !found) {
+		found = acpi_find_cache_level(table_hdr, cpu_node,
+					      &total_levels, level, acpi_type);
+		*node = cpu_node;
+		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
+	}
+
+	return found;
+}
+
+/* total number of attributes checked by the properties code */
+#define PPTT_CHECKED_ATTRIBUTES 4
+
+/**
+ * update_cache_properties() - Update cacheinfo for the given processor
+ *
+ * The ACPI spec implies that the fields in the cache structures are used to
+ * extend and correct the information probed from the hardware. Lets only
+ * set fields that we determine are VALID.
+ *
+ * Return: nothing. Side effect of updating the global cacheinfo
+ */
+static void update_cache_properties(struct cacheinfo *this_leaf,
+				    struct acpi_pptt_cache *found_cache,
+				    struct acpi_pptt_processor *cpu_node)
+{
+	int valid_flags = 0;
+
+	this_leaf->fw_token = cpu_node;
+	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID) {
+		this_leaf->size = found_cache->size;
+		valid_flags++;
+	}
+	if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID) {
+		this_leaf->coherency_line_size = found_cache->line_size;
+		valid_flags++;
+	}
+	if (found_cache->flags & ACPI_PPTT_NUMBER_OF_SETS_VALID) {
+		this_leaf->number_of_sets = found_cache->number_of_sets;
+		valid_flags++;
+	}
+	if (found_cache->flags & ACPI_PPTT_ASSOCIATIVITY_VALID) {
+		this_leaf->ways_of_associativity = found_cache->associativity;
+		valid_flags++;
+	}
+	if (found_cache->flags & ACPI_PPTT_WRITE_POLICY_VALID) {
+		switch (found_cache->attributes & ACPI_PPTT_MASK_WRITE_POLICY) {
+		case ACPI_PPTT_CACHE_POLICY_WT:
+			this_leaf->attributes = CACHE_WRITE_THROUGH;
+			break;
+		case ACPI_PPTT_CACHE_POLICY_WB:
+			this_leaf->attributes = CACHE_WRITE_BACK;
+			break;
+		}
+	}
+	if (found_cache->flags & ACPI_PPTT_ALLOCATION_TYPE_VALID) {
+		switch (found_cache->attributes & ACPI_PPTT_MASK_ALLOCATION_TYPE) {
+		case ACPI_PPTT_CACHE_READ_ALLOCATE:
+			this_leaf->attributes |= CACHE_READ_ALLOCATE;
+			break;
+		case ACPI_PPTT_CACHE_WRITE_ALLOCATE:
+			this_leaf->attributes |= CACHE_WRITE_ALLOCATE;
+			break;
+		case ACPI_PPTT_CACHE_RW_ALLOCATE:
+		case ACPI_PPTT_CACHE_RW_ALLOCATE_ALT:
+			this_leaf->attributes |=
+				CACHE_READ_ALLOCATE | CACHE_WRITE_ALLOCATE;
+			break;
+		}
+	}
+	/*
+	 * If the above flags are valid, and the cache type is NOCACHE
+	 * update the cache type as well.
+	 */
+	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
+	    valid_flags == PPTT_CHECKED_ATTRIBUTES)
+		this_leaf->type = CACHE_TYPE_UNIFIED;
+}
+
+/*
+ * Update the kernel cache information for each level of cache
+ * associated with the given acpi cpu.
+ */
+static void cache_setup_acpi_cpu(struct acpi_table_header *table,
+				 unsigned int cpu)
+{
+	struct acpi_pptt_cache *found_cache;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	struct cacheinfo *this_leaf;
+	unsigned int index = 0;
+	struct acpi_pptt_processor *cpu_node = NULL;
+
+	while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
+		this_leaf = this_cpu_ci->info_list + index;
+		found_cache = acpi_find_cache_node(table, acpi_cpu_id,
+						   this_leaf->type,
+						   this_leaf->level,
+						   &cpu_node);
+		pr_debug("found = %p %p\n", found_cache, cpu_node);
+		if (found_cache)
+			update_cache_properties(this_leaf,
+						found_cache,
+						cpu_node);
+
+		index++;
+	}
+}
+
+/**
+ * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
+ * @cpu: Kernel logical cpu number
+ *
+ * Given a logical cpu number, returns the number of levels of cache represented
+ * in the PPTT. Errors caused by lack of a PPTT table, or otherwise, return 0
+ * indicating we didn't find any cache levels.
+ *
+ * Return: Cache levels visible to this core.
+ */
+int acpi_find_last_cache_level(unsigned int cpu)
+{
+	u32 acpi_cpu_id;
+	struct acpi_table_header *table;
+	int number_of_levels = 0;
+	acpi_status status;
+
+	pr_debug("Cache Setup find last level cpu=%d\n", cpu);
+
+	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		pr_warn_once("No PPTT table found, cache topology may be inaccurate\n");
+	} else {
+		number_of_levels = acpi_find_cache_levels(table, acpi_cpu_id);
+		acpi_put_table(table);
+	}
+	pr_debug("Cache Setup find last level level=%d\n", number_of_levels);
+
+	return number_of_levels;
+}
+
+/**
+ * cache_setup_acpi() - Override CPU cache topology with data from the PPTT
+ * @cpu: Kernel logical cpu number
+ *
+ * Updates the global cache info provided by cpu_get_cacheinfo()
+ * when there are valid properties in the acpi_pptt_cache nodes. A
+ * successful parse may not result in any updates if none of the
+ * cache levels have any valid flags set.  Futher, a unique value is
+ * associated with each known CPU cache entry. This unique value
+ * can be used to determine whether caches are shared between cpus.
+ *
+ * Return: -ENOENT on failure to find table, or 0 on success
+ */
+int cache_setup_acpi(unsigned int cpu)
+{
+	struct acpi_table_header *table;
+	acpi_status status;
+
+	pr_debug("Cache Setup ACPI cpu %d\n", cpu);
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		pr_warn_once("No PPTT table found, cache topology may be inaccurate\n");
+		return -ENOENT;
+	}
+
+	cache_setup_acpi_cpu(table, cpu);
+	acpi_put_table(table);
+
+	return status;
+}
-- 
2.13.6
