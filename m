Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DABC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA27218A6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5TInvlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfBBJlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:41:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38737 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfBBJln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:41:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so7470982ede.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 01:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UG8rnIGuuYCyn1MgwH5GL70RHIkJGZksj7iIE3TwONc=;
        b=d5TInvlr3vrCCCTqz+QDeLqjtprI+ae3HlnrRs/HIONGa8vKX5qRi0zJKVT0ef/Bu1
         d1SptAbgHOc6fqPtTWbgc+Y47+sTeEU4zDOpVFwsTToZaQZUAIkxLSuQG05bd4eavPYI
         S9An9oaksIlSlmSdyn923Ov+JNGWVq9DhcxHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UG8rnIGuuYCyn1MgwH5GL70RHIkJGZksj7iIE3TwONc=;
        b=YxovqAVBaicaO157edxXfDC/MP53Imlw50kqgy/resosHHWiPoQeNr4Alo42Idnqpi
         QplztZCRL9wzo/o9v/WyOUyN4BdW/vg/npgTCynqQWaMky5sCMWME8nTxv4BIEDxMLiE
         m1rxgeflPUgvz6gox+sPaKlJg3nbyhDBLqvjkv6GZOKsnbE/xIGXO60BMDkdRCvbl3QP
         27r6P4UlMIqH0zwGv46eylHK4JJ/c9Err3b9lGRdVvD8h0sx7cwpv+HDgTkAgluBxPJQ
         SCtlFfC/kuIDjCatXwVCzfkM9yWg06Cjmg316xONicE00Ur+C33X7SQW+YzzhpsGDOvG
         pbQQ==
X-Gm-Message-State: AJcUukfG8gbd5exI6+9SGCkJVltISD+tJsba7UcNp64hNnyafT6TyU5s
        crDfCdxcFTfd/0c60IwmAV3M6w==
X-Google-Smtp-Source: ALg8bN5OLZSlc8qh9wKKUaDSSYzA4F2iTUJCg/8d4+gFUoan69XgCTeMpAEOg+HS3z07j3tg5Nq7gQ==
X-Received: by 2002:a17:906:5e43:: with SMTP id b3mr38434394eju.200.1549100502004;
        Sat, 02 Feb 2019 01:41:42 -0800 (PST)
Received: from mba13.c.hoisthospitality.com ([109.236.135.164])
        by smtp.gmail.com with ESMTPSA id l41sm2608824eda.83.2019.02.02.01.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 01:41:40 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH 10/10] acpi: bgrt: parse BGRT to obtain BMP address before it gets clobbered
Date:   Sat,  2 Feb 2019 10:41:19 +0100
Message-Id: <20190202094119.13230-11-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
References: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bitmap left in the framebuffer by the firmware is described by an
ACPI table called "BGRT", which describes the size, pixel format and
the address of a BMP image in memory. While the BGRT ACPI table is
guaranteed to reside in a "ACPI reclaim" memory region, which is
never touched by Linux. The BMP image, however, typically resides
in EFI Boot Services Memory, which may have been overwritten by the
time the BGRT discovery routine runs.

So instead, drop the handling from the ACPI init code, and call the
BGRT parsing code immediately after going over the EFI configuration
table array, at which time no memory has been touched yet except for
the .data/.bss regions covered by the static kernel image.

Unfortunately, this involves a non-trivial amount of ACPI entry
point and root table parsing, but we cannot rely on the normal
ACPI infrastructure yet this early in the boot.

Also note that we cannot take the 'acpi_disabled' global variable
into account, since it may not have assumed the correct value yet
(on arm64, the default value is '1' which is overridden to '0' if
no DT description has been made available by the firmware)

Cc: Peter Jones <pjones@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/acpi.c        |  2 -
 arch/x86/kernel/acpi/boot.c     |  2 -
 drivers/acpi/bgrt.c             |  6 ---
 drivers/firmware/efi/efi-bgrt.c | 84 ++++++++++++++++++++++++++++++---
 drivers/firmware/efi/efi.c      | 13 +++++
 include/linux/efi-bgrt.h        |  4 +-
 6 files changed, 92 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 44e3c351e1ea..7429a811f76d 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -230,8 +230,6 @@ void __init acpi_boot_table_init(void)
 			early_init_dt_scan_chosen_stdout();
 	} else {
 		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
-		if (IS_ENABLED(CONFIG_ACPI_BGRT))
-			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
 	}
 }
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 2624de16cd7a..2d3535b62752 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1633,8 +1633,6 @@ int __init acpi_boot_init(void)
 	acpi_process_madt();
 
 	acpi_table_parse(ACPI_SIG_HPET, acpi_parse_hpet);
-	if (IS_ENABLED(CONFIG_ACPI_BGRT))
-		acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
 
 	if (!acpi_noirq)
 		x86_init.pci.init = pci_acpi_init;
diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
index 75af78361ce5..048413e06898 100644
--- a/drivers/acpi/bgrt.c
+++ b/drivers/acpi/bgrt.c
@@ -81,12 +81,6 @@ static const struct attribute_group bgrt_attribute_group = {
 	.bin_attrs = bgrt_bin_attributes,
 };
 
-int __init acpi_parse_bgrt(struct acpi_table_header *table)
-{
-	efi_bgrt_init(table);
-	return 0;
-}
-
 static int __init bgrt_init(void)
 {
 	int ret;
diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index a2384184a7de..9c50d453b143 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -24,24 +24,94 @@ struct bmp_header {
 	u32 size;
 } __packed;
 
-void __init efi_bgrt_init(struct acpi_table_header *table)
+void __init efi_bgrt_init(unsigned long rsdp_phys)
 {
 	void *image;
 	struct bmp_header bmp_header;
 	struct acpi_table_bgrt *bgrt = &bgrt_tab;
+	struct acpi_table_bgrt *table = NULL;
+	struct acpi_table_rsdp *rsdp;
+	struct acpi_table_header *hdr;
+	u64 xsdt_phys = 0;
+	u32 rsdt_phys = 0;
+	size_t len;
 
-	if (acpi_disabled)
+	if (!efi_enabled(EFI_MEMMAP))
 		return;
 
-	if (!efi_enabled(EFI_MEMMAP))
+	/* map the root pointer table to find the xsdt/rsdt values */
+	rsdp = early_memremap_ro(rsdp_phys, sizeof(*rsdp));
+	if (rsdp) {
+		if (ACPI_VALIDATE_RSDP_SIG(rsdp->signature)) {
+			xsdt_phys = rsdp->xsdt_physical_address;
+			rsdt_phys = rsdp->rsdt_physical_address;
+		}
+		early_memunmap(rsdp, sizeof(*rsdp));
+	}
+
+	if (WARN_ON(!xsdt_phys && !rsdt_phys))
 		return;
 
-	if (table->length < sizeof(bgrt_tab)) {
-		pr_notice("Ignoring BGRT: invalid length %u (expected %zu)\n",
-		       table->length, sizeof(bgrt_tab));
+	/* obtain the length of whichever table we will be using */
+	hdr = early_memremap_ro(xsdt_phys ?: rsdt_phys, sizeof(*hdr));
+	if (WARN_ON(!hdr))
+		return;
+	len = hdr->length;
+	early_memunmap(hdr, sizeof(*hdr));
+
+	/* remap with the correct length */
+	hdr = early_memremap_ro(xsdt_phys ?: rsdt_phys, len);
+	if (WARN_ON(!hdr))
+		return;
+
+	if (xsdt_phys) {
+		struct acpi_table_xsdt *xsdt = (void *)hdr;
+		int i;
+
+		for (i = 0; i < (len - sizeof(*hdr)) / sizeof(u64); i++) {
+			table = early_memremap_ro(xsdt->table_offset_entry[i],
+						  sizeof(*table));
+			if (WARN_ON(!table))
+				break;
+
+			if (ACPI_COMPARE_NAME(table->header.signature,
+					      ACPI_SIG_BGRT))
+				break;
+			early_memunmap(table, sizeof(*table));
+			table = NULL;
+		}
+	} else if (rsdt_phys) {
+		struct acpi_table_rsdt *rsdt = (void *)hdr;
+		int i;
+
+		for (i = 0; i < (len - sizeof(*hdr)) / sizeof(u32); i++) {
+			table = early_memremap_ro(rsdt->table_offset_entry[i],
+						  sizeof(*table));
+			if (WARN_ON(!table))
+				break;
+
+			if (ACPI_COMPARE_NAME(table->header.signature,
+					      ACPI_SIG_BGRT))
+				break;
+			early_memunmap(table, sizeof(*table));
+			table = NULL;
+		}
+	}
+	early_memunmap(hdr, len);
+
+	if (!table)
 		return;
+
+	len = table->header.length;
+	memcpy(bgrt, table, min(len, sizeof(bgrt_tab)));
+	early_memunmap(table, sizeof(*table));
+
+	if (len < sizeof(bgrt_tab)) {
+		pr_notice("Ignoring BGRT: invalid length %zu (expected %zu)\n",
+		       len, sizeof(bgrt_tab));
+		goto out;
 	}
-	*bgrt = *(struct acpi_table_bgrt *)table;
+
 	if (bgrt->version != 1) {
 		pr_notice("Ignoring BGRT: invalid version %u (expected 1)\n",
 		       bgrt->version);
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4c46ff6f2242..e5ef5c0eacc1 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/efi.h>
+#include <linux/efi-bgrt.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/io.h>
@@ -592,6 +593,18 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 
 		early_memunmap(tbl, sizeof(*tbl));
 	}
+
+	/*
+	 * We need to parse the BGRT table (which is an ACPI table not a UEFI
+	 * configuration table) by hand and figure out where the bitmap it
+	 * describes lives in memory so we can reserve it early on. Otherwise,
+	 * it may be clobbered by the time we get to it during the ordinary ACPI
+	 * table init sequence.
+	 */
+	if (IS_ENABLED(CONFIG_ACPI_BGRT) &&
+	    efi.acpi20 != EFI_INVALID_TABLE_ADDR)
+		efi_bgrt_init(efi.acpi20);
+
 	return 0;
 }
 
diff --git a/include/linux/efi-bgrt.h b/include/linux/efi-bgrt.h
index e6cd51005633..528ea62d99ec 100644
--- a/include/linux/efi-bgrt.h
+++ b/include/linux/efi-bgrt.h
@@ -6,7 +6,7 @@
 
 #ifdef CONFIG_ACPI_BGRT
 
-void efi_bgrt_init(struct acpi_table_header *table);
+void efi_bgrt_init(unsigned long rsdp_phys);
 int __init acpi_parse_bgrt(struct acpi_table_header *table);
 
 /* The BGRT data itself; only valid if bgrt_image != NULL. */
@@ -15,7 +15,7 @@ extern struct acpi_table_bgrt bgrt_tab;
 
 #else /* !CONFIG_ACPI_BGRT */
 
-static inline void efi_bgrt_init(struct acpi_table_header *table) {}
+static inline void efi_bgrt_init(unsigned long rsdp_phys) {}
 static inline int __init acpi_parse_bgrt(struct acpi_table_header *table)
 {
 	return 0;
-- 
2.17.1

