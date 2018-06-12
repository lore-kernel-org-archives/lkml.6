Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A8765C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FA6208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FA6208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933892AbeFLINO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:13:14 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:4303 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933463AbeFLIMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:12:14 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="40978539"
Received: from bogon (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Jun 2018 16:12:11 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 351FF4B41ECF;
        Tue, 12 Jun 2018 16:12:08 +0800 (CST)
Received: from localhost (10.167.225.56) by G08CNEXCHPEKD01.g08.fujitsu.local
 (10.167.33.89) with Microsoft SMTP Server id 14.3.399.0; Tue, 12 Jun 2018
 16:12:12 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <lcapitulino@redhat.com>,
        <caoj.fnst@cn.fujitsu.com>, <douly.fnst@cn.fujitsu.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [RFC PATCH 3/4] x86/boot/KASLR: Walk srat tables to filter immovable memory
Date:   Tue, 12 Jun 2018 16:10:50 +0800
Message-ID: <20180612081051.21811-4-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180612081051.21811-1-fanc.fnst@cn.fujitsu.com>
References: <20180612081051.21811-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 351FF4B41ECF.ABAD0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'CONFIG_MEMORY_HOTREMOVE' specified, walk the acpi srat memory
tables, store the immovable memory regions, so that kaslr can get
the information abouth where can be selected or not.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/kaslr.c | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b87a7582853d..4edff0501540 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -31,6 +31,7 @@
 
 #include "misc.h"
 #include "error.h"
+#include "acpitb.h"
 #include "../string.h"
 
 #include <generated/compile.h>
@@ -104,6 +105,17 @@ static bool memmap_too_large;
 /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
 unsigned long long mem_limit = ULLONG_MAX;
 
+/* Store the max numbers of acpi tables */
+#define ACPI_MAX_TABLES		128
+
+#ifdef CONFIG_MEMORY_HOTREMOVE
+/* Store the movable memory */
+struct mem_vector immovable_mem[MAX_NUMNODES*2];
+
+/* Store the num of movable mem regions */
+static int num_immovable_mem;
+#endif
+
 
 enum mem_avoid_index {
 	MEM_AVOID_ZO_RANGE = 0,
@@ -266,6 +278,44 @@ static int handle_mem_memmap(void)
 	return 0;
 }
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+/*
+ * According to ACPI table, filter the immvoable memory regions
+ * and store them in immovable_mem[].
+ */
+static void handle_movable_mem(void)
+{
+	struct acpi_table_header *table_header;
+	struct acpi_subtable_header *asth;
+	struct acpi_srat_mem_affinity *ma;
+	unsigned long table_size;
+	unsigned long table_end;
+	int i = 0;
+
+	table_header = get_acpi_srat_table();
+
+	table_size = sizeof(struct acpi_table_srat);
+	table_end = (unsigned long)table_header + table_header->length;
+	asth = (struct acpi_subtable_header *)
+		((unsigned long)table_header + table_size);
+
+	while (((unsigned long)asth) +
+			sizeof(struct acpi_subtable_header) < table_end) {
+		if (asth->type == 1) {
+			ma = (struct acpi_srat_mem_affinity *)asth;
+			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
+				immovable_mem[i].start = ma->base_address;
+				immovable_mem[i].size = ma->length;
+				i++;
+			}
+		}
+		asth = (struct acpi_subtable_header *)
+			((unsigned long)asth + asth->length);
+	}
+	num_immovable_mem = i;
+}
+#endif
+
 /*
  * In theory, KASLR can put the kernel anywhere in the range of [16M, 64T).
  * The mem_avoid array is used to store the ranges that need to be avoided
@@ -389,6 +439,11 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* Mark the memmap regions we need to avoid */
 	handle_mem_memmap();
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+	/* Mark the hotplug SB regions we need choose */
+	handle_movable_mem();
+#endif
+
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 	/* Make sure video RAM can be used. */
 	add_identity_map(0, PMD_SIZE);
-- 
2.17.0



