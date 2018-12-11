Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E86C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773A120851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773A120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbeLKBGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:06:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:24609 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729389AbeLKBFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:05:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 17:05:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,340,1539673200"; 
   d="scan'208";a="117705172"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2018 17:05:44 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 02/12] acpi/hmat: Parse and report heterogeneous memory
Date:   Mon, 10 Dec 2018 18:03:00 -0700
Message-Id: <20181211010310.8551-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181211010310.8551-1-keith.busch@intel.com>
References: <20181211010310.8551-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems may provide different memory types and export this information
in the ACPI Heterogeneous Memory Attribute Table (HMAT). Parse these
tables provided by the platform and report the memory access and caching
attributes.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/acpi/Kconfig  |   8 +++
 drivers/acpi/Makefile |   1 +
 drivers/acpi/hmat.c   | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c |   9 +++
 include/linux/acpi.h  |   1 +
 5 files changed, 211 insertions(+)
 create mode 100644 drivers/acpi/hmat.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7cea769c37df..9a05af3a18cf 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -327,6 +327,14 @@ config ACPI_NUMA
 	depends on (X86 || IA64 || ARM64)
 	default y if IA64_GENERIC || IA64_SGI_SN2 || ARM64
 
+config ACPI_HMAT
+	bool "ACPI Heterogeneous Memory Attribute Table Support"
+	depends on ACPI_NUMA
+	help
+	 Parses representation of the ACPI Heterogeneous Memory Attributes
+	 Table (HMAT) and set the memory node relationships and access
+	 attributes.
+
 config ACPI_CUSTOM_DSDT_FILE
 	string "Custom DSDT Table file to include"
 	default ""
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index edc039313cd6..b5e13499f88b 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -55,6 +55,7 @@ acpi-$(CONFIG_X86)		+= x86/apple.o
 acpi-$(CONFIG_X86)		+= x86/utils.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
+acpi-$(CONFIG_ACPI_HMAT)	+= hmat.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 acpi-y				+= acpi_lpat.o
 acpi-$(CONFIG_ACPI_LPIT)	+= acpi_lpit.o
diff --git a/drivers/acpi/hmat.c b/drivers/acpi/hmat.c
new file mode 100644
index 000000000000..ef3881f0f370
--- /dev/null
+++ b/drivers/acpi/hmat.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Heterogeneous Memory Attributes Table (HMAT) representation
+ *
+ * Copyright (c) 2018, Intel Corporation.
+ */
+
+#include <acpi/acpi_numa.h>
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/node.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+static __init const char *hmat_data_type(u8 type)
+{
+	switch (type) {
+	case ACPI_HMAT_ACCESS_LATENCY:
+		return "Access Latency";
+	case ACPI_HMAT_READ_LATENCY:
+		return "Read Latency";
+	case ACPI_HMAT_WRITE_LATENCY:
+		return "Write Latency";
+	case ACPI_HMAT_ACCESS_BANDWIDTH:
+		return "Access Bandwidth";
+	case ACPI_HMAT_READ_BANDWIDTH:
+		return "Read Bandwidth";
+	case ACPI_HMAT_WRITE_BANDWIDTH:
+		return "Write Bandwidth";
+	default:
+		return "Reserved";
+	};
+}
+
+static __init const char *hmat_data_type_suffix(u8 type)
+{
+	switch (type) {
+	case ACPI_HMAT_ACCESS_LATENCY:
+	case ACPI_HMAT_READ_LATENCY:
+	case ACPI_HMAT_WRITE_LATENCY:
+		return " nsec";
+	case ACPI_HMAT_ACCESS_BANDWIDTH:
+	case ACPI_HMAT_READ_BANDWIDTH:
+	case ACPI_HMAT_WRITE_BANDWIDTH:
+		return " MB/s";
+	default:
+		return "";
+	};
+}
+
+static __init int hmat_parse_locality(union acpi_subtable_headers *header,
+				      const unsigned long end)
+{
+	struct acpi_hmat_locality *loc = (void *)header;
+	unsigned int init, targ, total_size, ipds, tpds;
+	u32 *inits, *targs, value;
+	u16 *entries;
+	u8 type;
+
+	if (loc->header.length < sizeof(*loc)) {
+		pr_err("HMAT: Unexpected locality header length: %d\n",
+			loc->header.length);
+		return -EINVAL;
+	}
+
+	type = loc->data_type;
+	ipds = loc->number_of_initiator_Pds;
+	tpds = loc->number_of_target_Pds;
+	total_size = sizeof(*loc) + sizeof(*entries) * ipds * tpds +
+		     sizeof(*inits) * ipds + sizeof(*targs) * tpds;
+	if (loc->header.length < total_size) {
+		pr_err("HMAT: Unexpected locality header length:%d, minimum required:%d\n",
+			loc->header.length, total_size);
+		return -EINVAL;
+	}
+
+	pr_info("HMAT: Locality: Flags:%02x Type:%s Initiator Domains:%d Target Domains:%d Base:%lld\n",
+		loc->flags, hmat_data_type(type), ipds, tpds,
+		loc->entry_base_unit);
+
+	inits = (u32 *)(loc + 1);
+	targs = &inits[ipds];
+	entries = (u16 *)(&targs[tpds]);
+	for (targ = 0; targ < tpds; targ++) {
+		for (init = 0; init < ipds; init++) {
+			value = entries[init * tpds + targ];
+			value = (value * loc->entry_base_unit) / 10;
+			pr_info("  Initiator-Target[%d-%d]:%d%s\n",
+				inits[init], targs[targ], value,
+				hmat_data_type_suffix(type));
+		}
+	}
+	return 0;
+}
+
+static __init int hmat_parse_cache(union acpi_subtable_headers *header,
+				   const unsigned long end)
+{
+	struct acpi_hmat_cache *cache = (void *)header;
+	u32 attrs;
+
+	if (cache->header.length < sizeof(*cache)) {
+		pr_err("HMAT: Unexpected cache header length: %d\n",
+			cache->header.length);
+		return -EINVAL;
+	}
+
+	attrs = cache->cache_attributes;
+	pr_info("HMAT: Cache: Domain:%d Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
+		cache->memory_PD, cache->cache_size, attrs,
+		cache->number_of_SMBIOShandles);
+
+	return 0;
+}
+
+static int __init hmat_parse_address_range(union acpi_subtable_headers *header,
+					   const unsigned long end)
+{
+	struct acpi_hmat_address_range *spa = (void *)header;
+
+	if (spa->header.length != sizeof(*spa)) {
+		pr_err("HMAT: Unexpected address range header length: %d\n",
+			spa->header.length);
+		return -EINVAL;
+	}
+	pr_info("HMAT: Memory (%#llx length %#llx) Flags:%04x Processor Domain:%d Memory Domain:%d\n",
+		spa->physical_address_base, spa->physical_address_length,
+		spa->flags, spa->processor_PD, spa->memory_PD);
+	return 0;
+}
+
+static int __init hmat_parse_subtable(union acpi_subtable_headers *header,
+				      const unsigned long end)
+{
+	struct acpi_hmat_structure *hdr = (void *)header;
+
+	if (!hdr)
+		return -EINVAL;
+
+	switch (hdr->type) {
+	case ACPI_HMAT_TYPE_ADDRESS_RANGE:
+		return hmat_parse_address_range(header, end);
+	case ACPI_HMAT_TYPE_LOCALITY:
+		return hmat_parse_locality(header, end);
+	case ACPI_HMAT_TYPE_CACHE:
+		return hmat_parse_cache(header, end);
+	default:
+		return -EINVAL;
+	}
+}
+
+static __init int parse_noop(struct acpi_table_header *table)
+{
+	return 0;
+}
+
+static __init int hmat_init(void)
+{
+	struct acpi_subtable_proc subtable_proc;
+	struct acpi_table_header *tbl;
+	enum acpi_hmat_type i;
+	acpi_status status;
+
+	if (srat_disabled())
+		return 0;
+
+	status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	if (acpi_table_parse(ACPI_SIG_HMAT, parse_noop))
+		goto out_put;
+
+	memset(&subtable_proc, 0, sizeof(subtable_proc));
+	subtable_proc.handler = hmat_parse_subtable;
+	for (i = ACPI_HMAT_TYPE_ADDRESS_RANGE; i < ACPI_HMAT_TYPE_RESERVED; i++) {
+		subtable_proc.id = i;
+		if (acpi_table_parse_entries_array(ACPI_SIG_HMAT,
+					sizeof(struct acpi_table_hmat),
+					&subtable_proc, 1, 0) < 0)
+			goto out_put;
+	}
+ out_put:
+	acpi_put_table(tbl);
+	return 0;
+}
+subsys_initcall(hmat_init);
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index e9643b4267c7..bc1addf715dc 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -51,6 +51,7 @@ static int acpi_apic_instance __initdata;
 
 enum acpi_subtable_type {
 	ACPI_SUBTABLE_COMMON,
+	ACPI_SUBTABLE_HMAT,
 };
 
 struct acpi_subtable_entry {
@@ -232,6 +233,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
 	switch (entry->type) {
 	case ACPI_SUBTABLE_COMMON:
 		return entry->hdr->common.type;
+	case ACPI_SUBTABLE_HMAT:
+		return entry->hdr->hmat.type;
 	}
 	return 0;
 }
@@ -242,6 +245,8 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
 	switch (entry->type) {
 	case ACPI_SUBTABLE_COMMON:
 		return entry->hdr->common.length;
+	case ACPI_SUBTABLE_HMAT:
+		return entry->hdr->hmat.length;
 	}
 	return 0;
 }
@@ -252,6 +257,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 	switch (entry->type) {
 	case ACPI_SUBTABLE_COMMON:
 		return sizeof(entry->hdr->common);
+	case ACPI_SUBTABLE_HMAT:
+		return sizeof(entry->hdr->hmat);
 	}
 	return 0;
 }
@@ -259,6 +266,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 static enum acpi_subtable_type __init
 acpi_get_subtable_type(char *id)
 {
+	if (strncmp(id, ACPI_SIG_HMAT, 4) == 0)
+		return ACPI_SUBTABLE_HMAT;
 	return ACPI_SUBTABLE_COMMON;
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 18805a967c70..4373f5ba0f95 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -143,6 +143,7 @@ enum acpi_address_range_id {
 /* Table Handlers */
 union acpi_subtable_headers {
 	struct acpi_subtable_header common;
+	struct acpi_hmat_structure hmat;
 };
 
 typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
-- 
2.14.4

