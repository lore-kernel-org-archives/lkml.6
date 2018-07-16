Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DCEECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08CC208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08CC208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbeGPJYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:24:05 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:19138 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731193AbeGPJYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:24:05 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42280509"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Jul 2018 16:57:34 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 7952C4B5CBF0;
        Mon, 16 Jul 2018 16:57:31 +0800 (CST)
Received: from localhost (10.167.225.56) by G08CNEXCHPEKD02.g08.fujitsu.local
 (10.167.33.89) with Microsoft SMTP Server id 14.3.399.0; Mon, 16 Jul 2018
 16:57:33 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <lcapitulino@redhat.com>,
        <caoj.fnst@cn.fujitsu.com>, <douly.fnst@cn.fujitsu.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [RFC PATCH v2 3/4] x86/boot/KASLR: Walk srat tables to filter immovable memory
Date:   Mon, 16 Jul 2018 16:55:37 +0800
Message-ID: <20180716085538.31939-4-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716085538.31939-1-fanc.fnst@cn.fujitsu.com>
References: <20180716085538.31939-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 7952C4B5CBF0.AA93D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'CONFIG_MEMORY_HOTREMOVE' specified, walk the acpi srat memory
tables, store the immovable memory regions, so that kaslr can get
the information abouth where can be selected or not.
If 'CONFIG_MEMORY_HOTREMOVE' not specified, go on the old code.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/kaslr.c | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 531c9876f573..0ec5aab915db 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -31,6 +31,7 @@
 
 #include "misc.h"
 #include "error.h"
+#include "acpitb.h"
 #include "../string.h"
 
 #include <generated/compile.h>
@@ -104,6 +105,14 @@ static bool memmap_too_large;
 /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
 unsigned long long mem_limit = ULLONG_MAX;
 
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
@@ -298,6 +307,47 @@ static int handle_mem_options(void)
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
+	struct acpi_subtable_header *table;
+	struct acpi_srat_mem_affinity *ma;
+	unsigned long table_size;
+	unsigned long table_end;
+	int i = 0;
+
+	table_header = get_acpi_srat_table();
+
+	if (!table_header)
+		return;
+
+	table_end = (unsigned long)table_header + table_header->length;
+
+	table = (struct acpi_subtable_header *)
+		((unsigned long)table_header + sizeof(struct acpi_table_srat));
+
+	table_size = sizeof(struct acpi_subtable_header);
+	while (((unsigned long)table) + table->length < table_end) {
+		if (table->type == 1) {
+			ma = (struct acpi_srat_mem_affinity *)table;
+			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
+				immovable_mem[i].start = ma->base_address;
+				immovable_mem[i].size = ma->length;
+				i++;
+			}
+		}
+		table = (struct acpi_subtable_header *)
+			((unsigned long)table + table->length);
+	}
+	num_immovable_mem = i;
+}
+#endif
+
 /*
  * In theory, KASLR can put the kernel anywhere in the range of [16M, 64T).
  * The mem_avoid array is used to store the ranges that need to be avoided
@@ -421,6 +471,11 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* Mark the memmap regions we need to avoid */
 	handle_mem_options();
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+	/* Mark the hotplug SB regions we need choose */
+	handle_movable_mem();
+#endif
+
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 	/* Make sure video RAM can be used. */
 	add_identity_map(0, PMD_SIZE);
-- 
2.17.1



