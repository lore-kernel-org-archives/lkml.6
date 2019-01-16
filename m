Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D16EC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C169206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfAPR7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:59:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:8973 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbfAPR7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:59:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 09:59:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="117227772"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2019 09:59:37 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 03/13] acpi/hmat: Parse and report heterogeneous memory
Date:   Wed, 16 Jan 2019 10:57:54 -0700
Message-Id: <20190116175804.30196-4-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190116175804.30196-1-keith.busch@intel.com>
References: <20190116175804.30196-1-keith.busch@intel.com>
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
 drivers/acpi/Kconfig       |   1 +
 drivers/acpi/Makefile      |   1 +
 drivers/acpi/hmat/Kconfig  |   8 ++
 drivers/acpi/hmat/Makefile |   1 +
 drivers/acpi/hmat/hmat.c   | 180 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 191 insertions(+)
 create mode 100644 drivers/acpi/hmat/Kconfig
 create mode 100644 drivers/acpi/hmat/Makefile
 create mode 100644 drivers/acpi/hmat/hmat.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 90ff0a47c12e..b377f970adfd 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -465,6 +465,7 @@ config ACPI_REDUCED_HARDWARE_ONLY
 	  If you are unsure what to do, do not enable this option.
 
 source "drivers/acpi/nfit/Kconfig"
+source "drivers/acpi/hmat/Kconfig"
 
 source "drivers/acpi/apei/Kconfig"
 source "drivers/acpi/dptf/Kconfig"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 7c6afc111d76..bff8fbe5a6ab 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI)		+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_NFIT)		+= nfit/
+obj-$(CONFIG_ACPI_HMAT)		+= hmat/
 obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
 obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
new file mode 100644
index 000000000000..a4034d37a311
--- /dev/null
+++ b/drivers/acpi/hmat/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+config ACPI_HMAT
+	bool "ACPI Heterogeneous Memory Attribute Table Support"
+	depends on ACPI_NUMA
+	help
+	 Parses representation of the ACPI Heterogeneous Memory Attributes
+	 Table (HMAT) and set the memory node relationships and access
+	 attributes.
diff --git a/drivers/acpi/hmat/Makefile b/drivers/acpi/hmat/Makefile
new file mode 100644
index 000000000000..e909051d3d00
--- /dev/null
+++ b/drivers/acpi/hmat/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ACPI_HMAT) := hmat.o
diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
new file mode 100644
index 000000000000..833a783868d5
--- /dev/null
+++ b/drivers/acpi/hmat/hmat.c
@@ -0,0 +1,180 @@
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
+static __init int hmat_init(void)
+{
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
+	for (i = ACPI_HMAT_TYPE_ADDRESS_RANGE; i < ACPI_HMAT_TYPE_RESERVED; i++) {
+		if (acpi_table_parse_entries(ACPI_SIG_HMAT,
+					     sizeof(struct acpi_table_hmat), i,
+					     hmat_parse_subtable, 0) < 0)
+			goto out_put;
+	}
+out_put:
+	acpi_put_table(tbl);
+	return 0;
+}
+subsys_initcall(hmat_init);
-- 
2.14.4

