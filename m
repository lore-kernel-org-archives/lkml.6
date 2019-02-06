Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F87C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB435217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfBFOhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:37:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39451 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBFOhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:37:54 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x16EbJgK1325273
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Feb 2019 06:37:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x16EbGVH1325270;
        Wed, 6 Feb 2019 06:37:16 -0800
Date:   Wed, 6 Feb 2019 06:37:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kairui Song <tipbot@zytor.com>
Message-ID: <tip-ccec81e4251f5a5421e02874e394338a897056ca@git.kernel.org>
Cc:     yannik@sembritzki.me, tglx@linutronix.de, dyoung@redhat.com,
        x86@kernel.org, bp@suse.de, prudo@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org,
        dhowells@redhat.com, fanc.fnst@cn.fujitsu.com, bhe@redhat.com,
        akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        mingo@redhat.com, kasong@redhat.com
Reply-To: takahiro.akashi@linaro.org, dhowells@redhat.com,
          linux-kernel@vger.kernel.org, fanc.fnst@cn.fujitsu.com,
          hpa@zytor.com, mingo@kernel.org, kasong@redhat.com,
          mingo@redhat.com, bhe@redhat.com, akpm@linux-foundation.org,
          tglx@linutronix.de, yannik@sembritzki.me, bp@suse.de,
          prudo@linux.vnet.ibm.com, x86@kernel.org, dyoung@redhat.com
In-Reply-To: <20190204173852.4863-1-kasong@redhat.com>
References: <20190204173852.4863-1-kasong@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/kexec: Fill in acpi_rsdp_addr from the first
 kernel
Git-Commit-ID: ccec81e4251f5a5421e02874e394338a897056ca
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ccec81e4251f5a5421e02874e394338a897056ca
Gitweb:     https://git.kernel.org/tip/ccec81e4251f5a5421e02874e394338a897056ca
Author:     Kairui Song <kasong@redhat.com>
AuthorDate: Tue, 5 Feb 2019 01:38:52 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 6 Feb 2019 15:29:03 +0100

x86/kexec: Fill in acpi_rsdp_addr from the first kernel

When efi=noruntime or efi=oldmap is used on the kernel command line, EFI
services won't be available in the second kernel, therefore the second
kernel will not be able to get the ACPI RSDP address from firmware by
calling EFI services and so it won't boot.

Commit

  e6e094e053af ("x86/acpi, x86/boot: Take RSDP address from boot params if available")

added an acpi_rsdp_addr field to boot_params which stores the RSDP
address for other kernel users.

Recently, after

  3a63f70bf4c3 ("x86/boot: Early parse RSDP and save it in boot_params")

the acpi_rsdp_addr will always be filled with a valid RSDP address.

So fill in that value into the second kernel's boot_params thus ensuring
that the second kernel receives the RSDP value from the first kernel.

 [ bp: massage commit message. ]

Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Yannik Sembritzki <yannik@sembritzki.me>
Link: https://lkml.kernel.org/r/20190204173852.4863-1-kasong@redhat.com
---
 arch/x86/kernel/kexec-bzimage64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 0d5efa34f359..2a0ff871025a 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -215,6 +215,9 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	params->screen_info.ext_mem_k = 0;
 	params->alt_mem_k = 0;
 
+	/* Always fill in RSDP: it is either 0 or a valid value */
+	params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
+
 	/* Default APM info */
 	memset(&params->apm_bios_info, 0, sizeof(params->apm_bios_info));
 
@@ -253,7 +256,6 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
 			efi_setup_data_offset);
 #endif
-
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,
 				EDDMAXNR * sizeof(struct edd_info));
