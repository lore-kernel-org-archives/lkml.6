Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D30C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB7A206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfAPR7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:59:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:8977 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbfAPR7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:59:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 09:59:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="117227786"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2019 09:59:38 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 06/13] acpi/hmat: Register processor domain to its memory
Date:   Wed, 16 Jan 2019 10:57:57 -0700
Message-Id: <20190116175804.30196-7-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190116175804.30196-1-keith.busch@intel.com>
References: <20190116175804.30196-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the HMAT Subsystem Address Range provides a valid processor proximity
domain for a memory domain, or a processor domain with the highest
performing access exists, register the memory target with that initiator
so this relationship will be visible under the node's sysfs directory.

Since HMAT requires valid address ranges have an equivalent SRAT entry,
verify each memory target satisfies this requirement.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/acpi/hmat/hmat.c | 143 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 136 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index 833a783868d5..efb33c74d1a3 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -17,6 +17,43 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
+static LIST_HEAD(targets);
+
+struct memory_target {
+	struct list_head node;
+	unsigned int memory_pxm;
+	unsigned long p_nodes[BITS_TO_LONGS(MAX_NUMNODES)];
+};
+
+static __init struct memory_target *find_mem_target(unsigned int m)
+{
+	struct memory_target *t;
+
+	list_for_each_entry(t, &targets, node)
+		if (t->memory_pxm == m)
+			return t;
+	return NULL;
+}
+
+static __init void alloc_memory_target(unsigned int mem_pxm)
+{
+	struct memory_target *t;
+
+	if (pxm_to_node(mem_pxm) == NUMA_NO_NODE)
+		return;
+
+	t = find_mem_target(mem_pxm);
+	if (t)
+		return;
+
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return;
+
+	t->memory_pxm = mem_pxm;
+	list_add_tail(&t->node, &targets);
+}
+
 static __init const char *hmat_data_type(u8 type)
 {
 	switch (type) {
@@ -53,11 +90,30 @@ static __init const char *hmat_data_type_suffix(u8 type)
 	};
 }
 
+static __init void hmat_update_access(u8 type, u32 value, u32 *best)
+{
+	switch (type) {
+	case ACPI_HMAT_ACCESS_LATENCY:
+	case ACPI_HMAT_READ_LATENCY:
+	case ACPI_HMAT_WRITE_LATENCY:
+		if (!*best || *best > value)
+			*best = value;
+		break;
+	case ACPI_HMAT_ACCESS_BANDWIDTH:
+	case ACPI_HMAT_READ_BANDWIDTH:
+	case ACPI_HMAT_WRITE_BANDWIDTH:
+		if (!*best || *best < value)
+			*best = value;
+		break;
+	}
+}
+
 static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 				      const unsigned long end)
 {
+	struct memory_target *t;
 	struct acpi_hmat_locality *loc = (void *)header;
-	unsigned int init, targ, total_size, ipds, tpds;
+	unsigned int init, targ, pass, p_node, total_size, ipds, tpds;
 	u32 *inits, *targs, value;
 	u16 *entries;
 	u8 type;
@@ -87,12 +143,28 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 	targs = &inits[ipds];
 	entries = (u16 *)(&targs[tpds]);
 	for (targ = 0; targ < tpds; targ++) {
-		for (init = 0; init < ipds; init++) {
-			value = entries[init * tpds + targ];
-			value = (value * loc->entry_base_unit) / 10;
-			pr_info("  Initiator-Target[%d-%d]:%d%s\n",
-				inits[init], targs[targ], value,
-				hmat_data_type_suffix(type));
+		u32 best = 0;
+
+		t = find_mem_target(targs[targ]);
+		for (pass = 0; pass < 2; pass++) {
+			for (init = 0; init < ipds; init++) {
+				value = entries[init * tpds + targ];
+				value = (value * loc->entry_base_unit) / 10;
+
+				if (!pass) {
+					hmat_update_access(type, value, &best);
+					pr_info("  Initiator-Target[%d-%d]:%d%s\n",
+						inits[init], targs[targ], value,
+						hmat_data_type_suffix(type));
+					continue;
+				}
+
+				if (!t)
+					continue;
+				p_node = pxm_to_node(inits[init]);
+				if (p_node != NUMA_NO_NODE && value == best)
+					set_bit(p_node, t->p_nodes);
+			}
 		}
 	}
 	return 0;
@@ -122,6 +194,7 @@ static int __init hmat_parse_address_range(union acpi_subtable_headers *header,
 					   const unsigned long end)
 {
 	struct acpi_hmat_address_range *spa = (void *)header;
+	struct memory_target *t = NULL;
 
 	if (spa->header.length != sizeof(*spa)) {
 		pr_err("HMAT: Unexpected address range header length: %d\n",
@@ -131,6 +204,23 @@ static int __init hmat_parse_address_range(union acpi_subtable_headers *header,
 	pr_info("HMAT: Memory (%#llx length %#llx) Flags:%04x Processor Domain:%d Memory Domain:%d\n",
 		spa->physical_address_base, spa->physical_address_length,
 		spa->flags, spa->processor_PD, spa->memory_PD);
+
+	if (spa->flags & ACPI_HMAT_MEMORY_PD_VALID) {
+		t = find_mem_target(spa->memory_PD);
+		if (!t) {
+			pr_warn("HMAT: Memory Domain missing from SRAT\n");
+			return -EINVAL;
+		}
+	}
+	if (t && spa->flags & ACPI_HMAT_PROCESSOR_PD_VALID) {
+		int p_node = pxm_to_node(spa->processor_PD);
+
+		if (p_node == NUMA_NO_NODE) {
+			pr_warn("HMAT: Invalid Processor Domain\n");
+			return -EINVAL;
+		}
+		set_bit(p_node, t->p_nodes);
+	}
 	return 0;
 }
 
@@ -154,6 +244,33 @@ static int __init hmat_parse_subtable(union acpi_subtable_headers *header,
 	}
 }
 
+static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
+					  const unsigned long end)
+{
+	struct acpi_srat_mem_affinity *ma = (void *)header;
+
+	if (!ma)
+		return -EINVAL;
+	if (!(ma->flags & ACPI_SRAT_MEM_ENABLED))
+		return 0;
+	alloc_memory_target(ma->proximity_domain);
+	return 0;
+}
+
+static __init void hmat_register_targets(void)
+{
+	struct memory_target *t, *next;
+	unsigned m, p;
+
+	list_for_each_entry_safe(t, next, &targets, node) {
+		list_del(&t->node);
+		m = pxm_to_node(t->memory_pxm);
+		for_each_set_bit(p, t->p_nodes, MAX_NUMNODES)
+			register_memory_node_under_compute_node(m, p, 0);
+		kfree(t);
+	}
+}
+
 static __init int hmat_init(void)
 {
 	struct acpi_table_header *tbl;
@@ -163,6 +280,17 @@ static __init int hmat_init(void)
 	if (srat_disabled())
 		return 0;
 
+	status = acpi_get_table(ACPI_SIG_SRAT, 0, &tbl);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	if (acpi_table_parse_entries(ACPI_SIG_SRAT,
+				sizeof(struct acpi_table_srat),
+				ACPI_SRAT_TYPE_MEMORY_AFFINITY,
+				srat_parse_mem_affinity, 0) < 0)
+		goto out_put;
+	acpi_put_table(tbl);
+
 	status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
 	if (ACPI_FAILURE(status))
 		return 0;
@@ -173,6 +301,7 @@ static __init int hmat_init(void)
 					     hmat_parse_subtable, 0) < 0)
 			goto out_put;
 	}
+	hmat_register_targets();
 out_put:
 	acpi_put_table(tbl);
 	return 0;
-- 
2.14.4

