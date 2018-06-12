Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9A3E9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508E4208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508E4208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934055AbeFLINP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:13:15 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:48040 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933579AbeFLIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:12:11 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="40978532"
Received: from bogon (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Jun 2018 16:12:06 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 1EEF64B34D54;
        Tue, 12 Jun 2018 16:12:03 +0800 (CST)
Received: from localhost (10.167.225.56) by G08CNEXCHPEKD01.g08.fujitsu.local
 (10.167.33.89) with Microsoft SMTP Server id 14.3.399.0; Tue, 12 Jun 2018
 16:12:07 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <lcapitulino@redhat.com>,
        <caoj.fnst@cn.fujitsu.com>, <douly.fnst@cn.fujitsu.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [RFC PATCH 1/4] x86/boot: Add acpitb.h to help parse acpi tables
Date:   Tue, 12 Jun 2018 16:10:48 +0800
Message-ID: <20180612081051.21811-2-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180612081051.21811-1-fanc.fnst@cn.fujitsu.com>
References: <20180612081051.21811-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 1EEF64B34D54.AA802
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to parse ACPI tables, some structers and functions of
ACPI code are needed. But ACPI code is an independent part and
has its closed logic. So dig the necessary structures and functions
from ACPI head files.
Can be used to help parse efi/bios tables, ACPI root tables, rsdp
tables, srat tables in 'compressed' directory.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpitb.h | 175 ++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 arch/x86/boot/compressed/acpitb.h

diff --git a/arch/x86/boot/compressed/acpitb.h b/arch/x86/boot/compressed/acpitb.h
new file mode 100644
index 000000000000..5ac00eb14141
--- /dev/null
+++ b/arch/x86/boot/compressed/acpitb.h
@@ -0,0 +1,175 @@
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include "misc.h"
+
+#define ACPI_NAME_SIZE                  4
+#define ACPI_OEM_ID_SIZE                6
+#define ACPI_OEM_TABLE_ID_SIZE          8
+#define ACPI_SRAT_MEM_HOT_PLUGGABLE (1<<1)        /* 01: Memory region is hot pluggable */
+
+#define ACPI_RSDP_SCAN_STEP             16
+#define ACPI_RSDP_CHECKSUM_LENGTH       20
+#define ACPI_RSDP_XCHECKSUM_LENGTH      36
+
+#define ACPI_CAST_PTR(t, p)	((t *) (void *) (p))
+#define ACPI_SIG_RSDP	"RSD PTR "      /* Root System Description Pointer */
+#define ACPI_VALIDATE_RSDP_SIG(a)	(!strncmp(ACPI_CAST_PTR(char, (a)), ACPI_SIG_RSDP, 8))
+
+#define ACPI_EBDA_PTR_LOCATION          0x0000040E      /* Physical Address */
+#define ACPI_HI_RSDP_WINDOW_BASE        0x000E0000      /* Physical Address */
+#define ACPI_HI_RSDP_WINDOW_SIZE        0x00020000
+#define ACPI_EBDA_WINDOW_SIZE		1024
+#define ACPI_MAX_TABLES			128
+#define ACPI_PTR_DIFF(a, b)	((acpi_size)(ACPI_CAST_PTR(u8, (a)) - ACPI_CAST_PTR(u8, (b))))
+#define ACPI_XSDT_ENTRY_SIZE	(sizeof(u64))
+#define ACPI_RSDT_ENTRY_SIZE	(sizeof(u32))
+
+#define ACPI_ADD_PTR(t, a, b)	(ACPI_CAST_PTR(t, (ACPI_CAST_PTR(u8, (a)) + (acpi_size)(b))))
+
+#ifdef ACPI_32BIT_PHYSICAL_ADDRESS
+
+/*
+ * OSPMs can define this to shrink the size of the structures for 32-bit
+ * none PAE environment. ASL compiler may always define this to generate
+ * 32-bit OSPM compliant tables.
+ */
+typedef u32 acpi_physical_address;
+
+#else                           /* ACPI_32BIT_PHYSICAL_ADDRESS */
+
+/*
+ * It is reported that, after some calculations, the physical addresses can
+ * wrap over the 32-bit boundary on 32-bit PAE environment.
+ * https://bugzilla.kernel.org/show_bug.cgi?id=87971
+ */
+typedef u64 acpi_physical_address;
+
+#endif                          /* ACPI_32BIT_PHYSICAL_ADDRESS */
+
+typedef u64 acpi_size;
+
+struct acpi_table_rsdp {
+	char signature[8];	/* ACPI signature, contains "RSD PTR " */
+	u8 checksum;		/* ACPI 1.0 checksum */
+	char oem_id[ACPI_OEM_ID_SIZE];	/* OEM identification */
+	u8 revision;		/* Must be (0) for ACPI 1.0 or (2) for ACPI 2.0+ */
+	u32 rsdt_physical_address;	/* 32-bit physical address of the RSDT */
+	u32 length;		/* Table length in bytes, including header (ACPI 2.0+) */
+	u64 xsdt_physical_address;	/* 64-bit physical address of the XSDT (ACPI 2.0+) */
+	u8 extended_checksum;	/* Checksum of entire table (ACPI 2.0+) */
+	u8 reserved[3];		/* Reserved, must be zero */
+};
+
+struct acpi_table_header *get_acpi_srat_table(void);
+/*******************************************************************************
+ *
+ * Master ACPI Table Header. This common header is used by all ACPI tables
+ * except the RSDP and FACS.
+ *
+ ******************************************************************************/
+
+struct acpi_table_header {
+	char signature[ACPI_NAME_SIZE];	/* ASCII table signature */
+	u32 length;		/* Length of table in bytes, including this header */
+	u8 revision;		/* ACPI Specification minor version number */
+	u8 checksum;		/* To make sum of entire table == 0 */
+	char oem_id[ACPI_OEM_ID_SIZE];	/* ASCII OEM identification */
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];	/* ASCII OEM table identification */
+	u32 oem_revision;	/* OEM revision number */
+	char asl_compiler_id[ACPI_NAME_SIZE];	/* ASCII ASL compiler vendor ID */
+	u32 asl_compiler_revision;	/* ASL compiler version */
+};
+
+/*******************************************************************************
+ *
+ * SRAT - System Resource Affinity Table
+ *        Version 3
+ *
+ ******************************************************************************/
+
+struct acpi_table_srat {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 table_revision;	/* Must be value '1' */
+	u64 reserved;		/* Reserved, must be zero */
+};
+
+/* Generic subtable header (used in MADT, SRAT, etc.) */
+
+struct acpi_subtable_header {
+	u8 type;
+	u8 length;
+};
+
+struct acpi_srat_mem_affinity {
+	struct acpi_subtable_header header;
+	u32 proximity_domain;
+	u16 reserved;		/* Reserved, must be zero */
+	u64 base_address;
+	u64 length;
+	u32 reserved1;
+	u32 flags;
+	u64 reserved2;		/* Reserved, must be zero */
+};
+
+/*
+ * Internal table-related structures
+ */
+union acpi_name_union {
+	u32 integer;
+	char ascii[4];
+};
+
+typedef u8 acpi_owner_id;
+
+/* Internal ACPI Table Descriptor. One per ACPI table. */
+
+struct acpi_table_desc {
+	acpi_physical_address address;
+	struct acpi_table_header *pointer;
+	u32 length;             /* Length fixed at 32 bits (fixed in table header) */
+	union acpi_name_union signature;
+	acpi_owner_id owner_id;
+	u8 flags;
+	u16 validation_count;
+};
+
+#ifdef ACPI_BIG_ENDIAN
+#define ACPI_MOVE_64_TO_64(d, s) \
+{((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[7]; \
+((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[6]; \
+((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[5]; \
+((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[4]; \
+((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3]; \
+((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2]; \
+((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1]; \
+((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }
+#else
+#ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
+#define ACPI_MOVE_64_TO_64(d, s) \
+{*(u64 *)(void *)(d) = *(u64 *)(void *)(s); }
+#else
+#define ACPI_MOVE_64_TO_64(d, s) \
+{((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0]; \
+((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1]; \
+((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2]; \
+((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3]; \
+((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[4]; \
+((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[5]; \
+((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[6]; \
+((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[7]; }
+#endif
+#endif
+#ifdef ACPI_BIG_ENDIAN
+#define ACPI_MOVE_16_TO_32(d, s) \
+{(*(u32 *)(void *)(d)) = 0; \
+((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1]; \
+((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0]; }
+#else
+#ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
+#define ACPI_MOVE_16_TO_32(d, s) \
+{*(u32 *)(void *)(d) = *(u16 *)(void *)(s); }
+#else
+#define ACPI_MOVE_16_TO_32(d, s) \
+{(*(u32 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s); }
+#endif
+#endif
-- 
2.17.0



