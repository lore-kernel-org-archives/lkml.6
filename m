Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B547DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 21:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857462195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 21:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390100AbeLVVFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 16:05:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51843 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbeLVVFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 16:05:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBML41RJ283665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 22 Dec 2018 13:04:01 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBML3w4C283662;
        Sat, 22 Dec 2018 13:03:58 -0800
Date:   Sat, 22 Dec 2018 13:03:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sai Praneeth Prakhya <tipbot@zytor.com>
Message-ID: <tip-1debf0958fa27b7c469dbf22754929ec59a7c0e7@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, ard.biesheuvel@linaro.org,
        luto@kernel.org, sai.praneeth.prakhya@intel.com, mingo@kernel.org,
        peterz@infradead.org, bp@alien8.de, bhsharma@redhat.com,
        dave.hansen@intel.com, torvalds@linux-foundation.org,
        riel@surriel.com
Reply-To: bhsharma@redhat.com, bp@alien8.de, riel@surriel.com,
          torvalds@linux-foundation.org, dave.hansen@intel.com,
          tglx@linutronix.de, ard.biesheuvel@linaro.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
          peterz@infradead.org, mingo@kernel.org,
          sai.praneeth.prakhya@intel.com, luto@kernel.org
In-Reply-To: <20181222022234.7573-1-sai.praneeth.prakhya@intel.com>
References: <20181222022234.7573-1-sai.praneeth.prakhya@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] x86/efi: Don't unmap EFI boot services code/data
 regions for EFI_OLD_MEMMAP and EFI_MIXED_MODE
Git-Commit-ID: 1debf0958fa27b7c469dbf22754929ec59a7c0e7
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

Commit-ID:  1debf0958fa27b7c469dbf22754929ec59a7c0e7
Gitweb:     https://git.kernel.org/tip/1debf0958fa27b7c469dbf22754929ec59a7c0e7
Author:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
AuthorDate: Fri, 21 Dec 2018 18:22:34 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 22 Dec 2018 20:58:30 +0100

x86/efi: Don't unmap EFI boot services code/data regions for EFI_OLD_MEMMAP and EFI_MIXED_MODE

The following commit:

  d5052a7130a6 ("x86/efi: Unmap EFI boot services code/data regions from efi_pgd")

forgets to take two EFI modes into consideration, namely EFI_OLD_MEMMAP and
EFI_MIXED_MODE:

- EFI_OLD_MEMMAP is a legacy way of mapping EFI regions into swapper_pg_dir
  using ioremap() and init_memory_mapping(). This feature can be enabled by
  passing "efi=old_map" as kernel command line argument. But,
  efi_unmap_pages() unmaps EFI boot services code/data regions *only* from
  efi_pgd and hence cannot be used for unmapping EFI boot services code/data
  regions from swapper_pg_dir.

Introduce a temporary fix to not unmap EFI boot services code/data regions
when EFI_OLD_MEMMAP is enabled while working on a real fix.

- EFI_MIXED_MODE is another feature where a 64-bit kernel runs on a
  64-bit platform crippled by a 32-bit firmware. To support EFI_MIXED_MODE,
  all RAM (i.e. namely EFI regions like EFI_CONVENTIONAL_MEMORY,
  EFI_LOADER_<CODE/DATA>, EFI_BOOT_SERVICES_<CODE/DATA> and
  EFI_RUNTIME_CODE/DATA regions) is mapped into efi_pgd all the time to
  facilitate EFI runtime calls access it's arguments in 1:1 mode.

Hence, don't unmap EFI boot services code/data regions when booted in mixed mode.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181222022234.7573-1-sai.praneeth.prakhya@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/efi/quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 09e811b9da26..17456a1d3f04 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -380,6 +380,22 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
 	u64 pa = md->phys_addr;
 	u64 va = md->virt_addr;
 
+	/*
+	 * To Do: Remove this check after adding functionality to unmap EFI boot
+	 * services code/data regions from direct mapping area because
+	 * "efi=old_map" maps EFI regions in swapper_pg_dir.
+	 */
+	if (efi_enabled(EFI_OLD_MEMMAP))
+		return;
+
+	/*
+	 * EFI mixed mode has all RAM mapped to access arguments while making
+	 * EFI runtime calls, hence don't unmap EFI boot services code/data
+	 * regions.
+	 */
+	if (!efi_is_native())
+		return;
+
 	if (kernel_unmap_pages_in_pgd(pgd, pa, md->num_pages))
 		pr_err("Failed to unmap 1:1 mapping for 0x%llx\n", pa);
 
