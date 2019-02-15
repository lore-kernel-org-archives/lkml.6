Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53912C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B67321925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392279AbfBOJLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:11:07 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44673 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726986AbfBOJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:11:07 -0500
X-IronPort-AV: E=Sophos;i="5.58,372,1544457600"; 
   d="scan'208";a="54417125"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Feb 2019 17:11:03 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 43E374C4C382;
        Fri, 15 Feb 2019 17:11:04 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 15 Feb 2019 17:11:07 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <bp@alien8.de>
Subject: [PATCH] x86/boot: Move detecting acpi=off in cmdline to get_rsdp_addr()
Date:   Fri, 15 Feb 2019 17:10:47 +0800
Message-ID: <20190215091047.23047-1-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 43E374C4C382.A6072
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "acpi=off" specified in cmdline, the whole functions of acpi.c
should not work, there is no need to ealy parse RSDP, so detect
"acpi=off" in the very first place.

Also replace magic number with macro.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 0ef4ad55b29b..5510a2105b7b 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -213,8 +213,13 @@ static acpi_physical_address bios_get_rsdp_addr(void)
 /* Return RSDP address on success, otherwise 0. */
 acpi_physical_address get_rsdp_addr(void)
 {
+	char arg[MAX_ACPI_ARG_LENGTH];
 	acpi_physical_address pa;
 
+	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
+	    !strncmp(arg, "off", 3))
+		return 0;
+
 	pa = get_acpi_rsdp();
 
 	if (!pa)
@@ -235,9 +240,9 @@ static unsigned long get_acpi_srat_table(void)
 {
 	unsigned long root_table, acpi_table;
 	struct acpi_table_header *header;
+	char arg[MAX_ACPI_ARG_LENGTH];
 	struct acpi_table_rsdp *rsdp;
 	u32 num_entries, size, len;
-	char arg[10];
 	u8 *entry;
 
 	rsdp = (struct acpi_table_rsdp *)(long)boot_params->acpi_rsdp_addr;
@@ -299,13 +304,8 @@ int count_immovable_mem_regions(void)
 	unsigned long table_addr, table_end, table;
 	struct acpi_subtable_header *sub_table;
 	struct acpi_table_header *table_header;
-	char arg[MAX_ACPI_ARG_LENGTH];
 	int num = 0;
 
-	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
-	    !strncmp(arg, "off", 3))
-		return 0;
-
 	table_addr = get_acpi_srat_table();
 	if (!table_addr)
 		return 0;
-- 
2.20.1



