Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512E6ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3402083C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3402083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeJVR4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:56:22 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:58640 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728385AbeJVR4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:56:21 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46549108"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Oct 2018 17:38:31 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id BF2654B71108;
        Mon, 22 Oct 2018 17:38:28 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 22 Oct 2018 17:38:32 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <bhe@redhat.com>,
        <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v10 4/7] x86/boot: Add bios_get_rsdp_addr() to search RSDP in memory
Date:   Mon, 22 Oct 2018 17:37:17 +0800
Message-ID: <20181022093720.21426-5-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181022093720.21426-1-fanc.fnst@cn.fujitsu.com>
References: <20181022093720.21426-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: BF2654B71108.A89F0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Imitate ACPI code to search RSDP pointer from memory.
Walk memory and check the signature until get the RSDP signature.
Based on acpi_tb_scan_memory_for_rsdp() and acpi_find_root_pointer().
If didn't get RSDP from EFI table, will run this function.

Used for later patch to dig out SRAT table and get the memory
information. So that we can figure out the immovable memory regions
to avoid KASLR extracts kernel on movable memory, so slove the
conflict between KASLR and movable_node feature.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpitb.c | 106 ++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
index 56b54b0e0889..50fa65cf824d 100644
--- a/arch/x86/boot/compressed/acpitb.c
+++ b/arch/x86/boot/compressed/acpitb.c
@@ -94,3 +94,109 @@ static void efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
 	}
 #endif
 }
+
+static u8 compute_checksum(u8 *buffer, u32 length)
+{
+	u8 sum = 0;
+	u8 *end = buffer + length;
+
+	while (buffer < end)
+		sum = (u8)(sum + *(buffer++));
+
+	return sum;
+}
+
+/*
+ * Used to search a block of memory for the RSDP signature.
+ * Return Pointer to the RSDP if found, otherwise NULL.
+ * Based on acpi_tb_scan_memory_for_rsdp().
+ */
+static u8 *scan_mem_for_rsdp(u8 *start, u32 length)
+{
+	struct acpi_table_rsdp *rsdp;
+	u8 *end;
+	u8 *rover;
+
+	end = start + length;
+
+	/* Search from given start address for the requested length */
+	for (rover = start; rover < end; rover += ACPI_RSDP_SCAN_STEP) {
+		/*
+		 * The RSDP signature and checksum must both be correct
+		 * Note: Sometimes there exists more than one RSDP in memory;
+		 * the valid RSDP has a valid checksum, all others have an
+		 * invalid checksum.
+		 */
+		rsdp = (struct acpi_table_rsdp *)rover;
+
+		/* Nope, BAD Signature */
+		if (!ACPI_VALIDATE_RSDP_SIG(rsdp->signature))
+			continue;
+
+		/* Check the standard checksum */
+		if (compute_checksum((u8 *) rsdp, ACPI_RSDP_CHECKSUM_LENGTH))
+			continue;
+
+		/* Check extended checksum if table version >= 2 */
+		if ((rsdp->revision >= 2) &&
+		    (compute_checksum((u8 *) rsdp, ACPI_RSDP_XCHECKSUM_LENGTH)))
+			continue;
+
+		/* Sig and checksum valid, we have found a real RSDP */
+		return rover;
+	}
+	return NULL;
+}
+
+/*
+ * Used to search RSDP physical address.
+ * Based on acpi_find_root_pointer(). Since only use physical address
+ * in this period, so there is no need to do the memory map jobs.
+ */
+static void bios_get_rsdp_addr(acpi_physical_address *rsdp_addr)
+{
+	struct acpi_table_rsdp *rsdp;
+	u8 *table_ptr;
+	u8 *mem_rover;
+	u32 address;
+
+	/*
+	 * Get the location of the Extended BIOS Data Area (EBDA)
+	 * Since we use physical address directely, so
+	 * acpi_os_map_memory() and acpi_os_unmap_memory() are
+	 * not needed here.
+	 */
+	table_ptr = (u8 *)ACPI_EBDA_PTR_LOCATION;
+	*(u32 *)(void *)&address = *(u16 *)(void *)table_ptr;
+	address <<= 4;
+	table_ptr = (u8 *)address;
+
+	/*
+	 * Search EBDA paragraphs (EBDA is required to be a minimum of
+	 * 1K length)
+	 */
+	if (address > 0x400) {
+		mem_rover = scan_mem_for_rsdp(table_ptr, ACPI_EBDA_WINDOW_SIZE);
+
+		if (mem_rover) {
+			address += (u32)ACPI_PTR_DIFF(mem_rover, table_ptr);
+			*rsdp_addr = (acpi_physical_address)address;
+			return;
+		}
+	}
+
+	table_ptr = (u8 *)ACPI_HI_RSDP_WINDOW_BASE;
+	mem_rover = scan_mem_for_rsdp(table_ptr, ACPI_HI_RSDP_WINDOW_SIZE);
+
+	/*
+	 * Search upper memory: 16-byte boundaries in E0000h-FFFFFh
+	 * Since we use physical address directely, so
+	 * acpi_os_map_memory() and acpi_os_unmap_memory() are
+	 * not needed here.
+	 */
+	if (mem_rover) {
+		address = (u32)(ACPI_HI_RSDP_WINDOW_BASE +
+				ACPI_PTR_DIFF(mem_rover, table_ptr));
+		*rsdp_addr = (acpi_physical_address)address;
+	}
+}
-- 
2.17.2



