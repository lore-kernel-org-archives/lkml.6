Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C912C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134A521019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfAWLKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:10:12 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7521 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727264AbfAWLKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:10:10 -0500
X-IronPort-AV: E=Sophos;i="5.56,510,1539619200"; 
   d="scan'208";a="52651120"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jan 2019 19:10:08 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id DAC534C47E9F;
        Wed, 23 Jan 2019 19:10:08 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 23 Jan 2019 19:10:15 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>, <kasong@redhat.com>
Subject: [PATCH v16 4/7] x86/boot: Introduce bios_get_rsdp_addr() to search RSDP in memory
Date:   Wed, 23 Jan 2019 19:08:47 +0800
Message-ID: <20190123110850.12433-5-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
References: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: DAC534C47E9F.AD1B0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory information in SRAT table is necessary to fix the conflict
between KASLR and memory-hotremove. So RSDP and SRAT should be parsed.

When booting form KEXEC/EFI/BIOS, the methods to compute RSDP
are different. When booting from BIOS, there is no variable who can
point to RSDP directly, so scan memory for the RSDP and verify RSDP
by signature and checksum.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c | 83 +++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 75b3ce4356f4..0c389a22bb86 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -111,4 +111,87 @@ static acpi_physical_address efi_get_rsdp_addr(void)
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
+	u8 *address, *end;
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
+		if (compute_checksum((u8 *)rsdp, ACPI_RSDP_CHECKSUM_LENGTH))
+			continue;
+
+		/* Check extended checksum if table version >= 2 */
+		if ((rsdp->revision >= 2) &&
+		    (compute_checksum((u8 *)rsdp, ACPI_RSDP_XCHECKSUM_LENGTH)))
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
+	unsigned long address;
+	u8 *table_ptr, *rsdp;
+
+	/* Get the location of the Extended BIOS Data Area (EBDA) */
+	table_ptr = (u8 *)ACPI_EBDA_PTR_LOCATION;
+	address = *(u16 *)table_ptr;
+	address <<= 4;
+	table_ptr = (u8 *)address;
+
+	/*
+	 * Search EBDA paragraphs (EBDA is required to be a minimum of
+	 * 1K length)
+	 */
+	if (address > 0x400) {
+		rsdp = scan_mem_for_rsdp(table_ptr, ACPI_EBDA_WINDOW_SIZE);
+		if (rsdp) {
+			address = (unsigned long)rsdp;
+			return address;
+		}
+	}
+
+	/* Search upper memory: 16-byte boundaries in E0000h-FFFFFh */
+	table_ptr = (u8 *)ACPI_HI_RSDP_WINDOW_BASE;
+	rsdp = scan_mem_for_rsdp(table_ptr, ACPI_HI_RSDP_WINDOW_SIZE);
+	if (rsdp) {
+		address = (unsigned long)rsdp;
+		return address;
+	}
+
+	return 0;
+}
 #endif /* CONFIG_ACPI */
-- 
2.20.1



