Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716F0C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384392147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384392147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeLNJa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:30:56 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23660 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728843AbeLNJav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:30:51 -0500
X-IronPort-AV: E=Sophos;i="5.56,352,1539619200"; 
   d="scan'208";a="49767740"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2018 17:30:49 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 628A94B75BDE;
        Fri, 14 Dec 2018 17:30:50 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Dec 2018 17:30:49 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v14 3/5] x86/boot: Introduce bios_get_rsdp_addr() to search RSDP in memory
Date:   Fri, 14 Dec 2018 17:30:11 +0800
Message-ID: <20181214093013.13370-4-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 628A94B75BDE.A9A61
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix the conflict between KASLR and memory-hotremove, memory
Memory information in SRAT is necessary to fix the conflict
between KASLR and memory-hotremove. So RSDP and SRAT should be parsed.

When booting form KEXEC/EFI/BIOS, the methods to compute RSDP
are different. When booting from BIOS, there is no variable who can
point to RSDP directly, so scan memory for the RSDP and verify RSDP
by signature and checksum.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c | 86 +++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 4151881d8713..795a78559a58 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -107,3 +107,89 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 #endif
 	return rsdp_addr;
 }
+
+static u8 compute_checksum(u8 *buffer, u32 length)
+{
+	u8 *end = buffer + length;
+	u8 sum = 0;
+
+	while (buffer < end)
+		sum += *(buffer++);
+
+	return sum;
+}
+
+/* Search a block of memory for the RSDP signature. */
+static u8 *scan_mem_for_rsdp(u8 *start, u32 length)
+{
+	struct acpi_table_rsdp *rsdp;
+	u8 *address;
+	u8 *end;
+
+	end = start + length;
+
+	/* Search from given start address for the requested length */
+	for (address = start; address < end; address += ACPI_RSDP_SCAN_STEP) {
+		/*
+		 * Both RSDP signature and checksum must be correct.
+		 * Note: Sometimes there exists more than one RSDP in memory;
+		 * the valid RSDP has a valid checksum, all others have an
+		 * invalid checksum.
+		 */
+		rsdp = (struct acpi_table_rsdp *)address;
+
+		/* BAD Signature */
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
+		/* Signature and checksum valid, we have found a real RSDP */
+		return address;
+	}
+	return NULL;
+}
+
+/* Search RSDP address, based on acpi_find_root_pointer(). */
+static acpi_physical_address bios_get_rsdp_addr(void)
+{
+	u8 *table_ptr;
+	u32 address;
+	u8 *rsdp;
+
+	/* Get the location of the Extended BIOS Data Area (EBDA) */
+	table_ptr = (u8 *)ACPI_EBDA_PTR_LOCATION;
+	*(u32 *)(void *)&address = *(u16 *)(void *)table_ptr;
+	address <<= 4;
+	table_ptr = (u8 *)(long)address;
+
+	/*
+	 * Search EBDA paragraphs (EBDA is required to be a minimum of
+	 * 1K length)
+	 */
+	if (address > 0x400) {
+		rsdp = scan_mem_for_rsdp(table_ptr, ACPI_EBDA_WINDOW_SIZE);
+		if (rsdp) {
+			address += (u32)ACPI_PTR_DIFF(rsdp, table_ptr);
+			return (acpi_physical_address)address;
+		}
+	}
+
+	table_ptr = (u8 *)ACPI_HI_RSDP_WINDOW_BASE;
+	rsdp = scan_mem_for_rsdp(table_ptr, ACPI_HI_RSDP_WINDOW_SIZE);
+
+	/* Search upper memory: 16-byte boundaries in E0000h-FFFFFh */
+	if (rsdp) {
+		address = (u32)(ACPI_HI_RSDP_WINDOW_BASE +
+				ACPI_PTR_DIFF(rsdp, table_ptr));
+		return (acpi_physical_address)address;
+	}
+	return 0;
+}
-- 
2.19.2



