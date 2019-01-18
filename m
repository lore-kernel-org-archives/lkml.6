Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE03C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A202086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfARLOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:14:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfARLOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:14:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DF479D1FC;
        Fri, 18 Jan 2019 11:14:14 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9102101960A;
        Fri, 18 Jan 2019 11:14:07 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dyoung@redhat.com, bhe@redhat.com,
        kexec@lists.infradead.org, akpm@linux-foundation.org,
        robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org,
        fanc.fnst@cn.fujitsu.com, linux-acpi@vger.kernel.org,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 3/3] x86, kexec_file_load: make it work with efi=noruntime or efi=old_map
Date:   Fri, 18 Jan 2019 19:13:10 +0800
Message-Id: <20190118111310.29589-4-kasong@redhat.com>
In-Reply-To: <20190118111310.29589-1-kasong@redhat.com>
References: <20190118111310.29589-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 18 Jan 2019 11:14:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When efi=noruntime or efi=oldmap is used, EFI services won't be available
in the second kernel, therefore the second kernel will not be able to get
the ACPI RSDP address from firmware by calling EFI services and won't
boot. Previously we are expecting the user to set the acpi_rsdp=<addr>
on kernel command line for second kernel as there was no way to pass RSDP
address to second kernel.

After commit e6e094e053af ('x86/acpi, x86/boot: Take RSDP address from
boot params if available'), now it's possible to set an acpi_rsdp_addr
parameter in the boot_params passed to second kernel, this commit makes
use of it, detect and set the RSDP address when it's required for second
kernel to boot.

Tested with an EFI enabled KVM VM with efi=noruntime.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 097f52fb02e3..63101b2194fb 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <linux/efi.h>
 #include <linux/verification.h>
+#include <linux/acpi.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -255,8 +256,17 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	/* Setup EFI state */
 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
 			efi_setup_data_offset);
+
+#ifdef CONFIG_ACPI
+	/* Setup ACPI RSDP pointer in case EFI is not available in second kernel */
+	if (!acpi_disabled && (!efi_enabled(EFI_RUNTIME_SERVICES) || efi_enabled(EFI_OLD_MEMMAP))) {
+		params->acpi_rsdp_addr = acpi_os_get_root_pointer_late();
+		if (!params->acpi_rsdp_addr)
+			pr_warn("RSDP is not available for second kernel\n");
+	}
 #endif
 
+#endif
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,
 				EDDMAXNR * sizeof(struct edd_info));
-- 
2.20.1

