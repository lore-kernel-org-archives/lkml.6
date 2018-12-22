Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067CCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF97821927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbeLVCYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 21:24:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:11627 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbeLVCYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 21:24:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 18:24:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,383,1539673200"; 
   d="scan'208";a="305869617"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2018 18:24:46 -0800
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] x86/efi: Don't unmap EFI boot services code/data regions for EFI_OLD_MEMMAP and EFI_MIXED_MODE
Date:   Fri, 21 Dec 2018 18:22:34 -0800
Message-Id: <20181222022234.7573-1-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d5052a7130a6 ("x86/efi: Unmap EFI boot services code/data regions
from efi_pgd") forgets to take two EFI modes into consideration namely
EFI_OLD_MEMMAP and EFI_MIXED_MODE.

EFI_OLD_MEMMAP is a legacy way of mapping EFI regions into swapper_pg_dir
using ioremap() and init_memory_mapping(). This feature can be enabled by
passing "efi=old_map" as kernel command line argument. But,
efi_unmap_pages() unmaps EFI boot services code/data regions *only* from
efi_pgd and hence cannot be used for unmapping EFI boot services code/data
regions from swapper_pg_dir.

Introduce a temporary fix to not unmap EFI boot services code/data regions
when EFI_OLD_MEMMAP is enabled while working on a real fix.

EFI_MIXED_MODE is another feature where a 64-bit kernel runs on a
64-bit platform crippled by a 32-bit firmware. To support EFI_MIXED_MODE,
all RAM (i.e. namely EFI regions like EFI_CONVENTIONAL_MEMORY,
EFI_LOADER_<CODE/DATA>, EFI_BOOT_SERVICES_<CODE/DATA> and
EFI_RUNTIME_CODE/DATA regions) is mapped into efi_pgd all the time to
facilitate EFI runtime calls access it's arguments in 1:1 mode. Hence,
don't unmap EFI boot services code/data regions when booted in mixed mode.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 09e811b9da26..9c34230aaeae 100644
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
+	if (!efi_is_native() && IS_ENABLED(CONFIG_EFI_MIXED))
+		return;
+
 	if (kernel_unmap_pages_in_pgd(pgd, pa, md->num_pages))
 		pr_err("Failed to unmap 1:1 mapping for 0x%llx\n", pa);
 
-- 
2.19.1

