Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C41C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CEE218A1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfBDRjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:39:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64113 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfBDRjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:39:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 659E181F0E;
        Mon,  4 Feb 2019 17:39:13 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49E805BBCB;
        Mon,  4 Feb 2019 17:39:06 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH] x86, kexec_file_load: fill in acpi_rsdp_addr boot param unconditionally
Date:   Tue,  5 Feb 2019 01:38:52 +0800
Message-Id: <20190204173852.4863-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 04 Feb 2019 17:39:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When efi=noruntime or efi=oldmap is used, EFI services won't be available
in the second kernel, therefore the second kernel will not be able to get
the ACPI RSDP address from firmware by calling EFI services so it won't
boot. Previously we are expecting the user to set the acpi_rsdp=<addr>
on kernel command line for second kernel as there was no other way to
pass RSDP address to second kernel.

After commit e6e094e053af ("x86/acpi, x86/boot: Take RSDP address from
boot params if available"), now it's possible to set an acpi_rsdp_addr
parameter in the boot_params passed to second kernel, and kernel will
prefer using this value for the RSDP address when it's set.

And with commit 3a63f70bf4c3 ("x86/boot: Early parse RSDP and save it in
boot_params"), now the acpi_rsdp_addr will always be filled with valid
RSDP address. So we just fill in that value for second kernel's
boot_params unconditionally, this ensure second kernel always use the
same RSDP value as the first kernel.

Tested with an EFI enabled KVM VM with efi=noruntime.

Signed-off-by: Kairui Song <kasong@redhat.com>
---

This is update of part of patch series: "[PATCH v3 0/3] make kexec work
with efi=noruntime or efi=old_map."

But "[PATCH v3 1/3] x86, kexec_file_load: Don't setup EFI info if EFI
runtime is not enabled" is already in [tip:x86/urgent], and with Chao's
commit 3a63f70bf4c3 in [tip:x86/boot], we can just fill in acpi_rsdp_addr
boot param unconditionally to fix the problem, so only I update and resend
this patch.

 arch/x86/kernel/kexec-bzimage64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 53917a3ebf94..3611946dc7ea 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -218,6 +218,9 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	params->screen_info.ext_mem_k = 0;
 	params->alt_mem_k = 0;
 
+	/* Always fill in RSDP, it's either 0 or a valid value */
+	params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
+
 	/* Default APM info */
 	memset(&params->apm_bios_info, 0, sizeof(params->apm_bios_info));
 
@@ -256,7 +259,6 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
 			efi_setup_data_offset);
 #endif
-
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,
 				EDDMAXNR * sizeof(struct edd_info));
-- 
2.20.1

