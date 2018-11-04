Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4FFC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE042082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE042082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeKEFaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 00:30:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:8971 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbeKEFaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 00:30:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 12:12:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,465,1534834800"; 
   d="scan'208";a="97569963"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga003.jf.intel.com with ESMTP; 04 Nov 2018 12:12:05 -0800
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH V3 2/3] x86/efi: Unmap EFI boot services code/data regions from efi_pgd
Date:   Sun,  4 Nov 2018 12:10:18 -0800
Message-Id: <20181104201019.26142-3-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104201019.26142-1-sai.praneeth.prakhya@intel.com>
References: <20181104201019.26142-1-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

efi_free_boot_services(), as the name suggests, frees EFI boot services
code/data regions but forgets to unmap these regions from efi_pgd. This
means that any code that's running in efi_pgd address space (e.g:
any EFI runtime service) would still be able to access these regions but
the contents of these regions would have long been over written by
someone else. So, it's important to unmap these regions. Hence,
introduce efi_unmap_pages() to unmap these regions from efi_pgd.

After unmapping EFI boot services code/data regions, any illegal access
by buggy firmware to these regions would result in page fault which will
be handled by EFI specific fault handler.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/quirks.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 669babcaf245..fb1c44b11235 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -370,6 +370,24 @@ void __init efi_reserve_boot_services(void)
 	}
 }
 
+/*
+ * Apart from having VA mappings for EFI boot services code/data regions,
+ * (duplicate) 1:1 mappings were also created as a quirk for buggy firmware. So,
+ * unmap both 1:1 and VA mappings.
+ */
+static void __init efi_unmap_pages(efi_memory_desc_t *md)
+{
+	pgd_t *pgd = efi_mm.pgd;
+	u64 pa = md->phys_addr;
+	u64 va = md->virt_addr;
+
+	if (kernel_unmap_pages_in_pgd(pgd, pa, md->num_pages))
+		pr_err("Failed to unmap 1:1 mapping for 0x%llx\n", pa);
+
+	if (kernel_unmap_pages_in_pgd(pgd, va, md->num_pages))
+		pr_err("Failed to unmap VA mapping for 0x%llx\n", va);
+}
+
 void __init efi_free_boot_services(void)
 {
 	phys_addr_t new_phys, new_size;
@@ -395,6 +413,13 @@ void __init efi_free_boot_services(void)
 		}
 
 		/*
+		 * Before calling set_virtual_address_map(), EFI boot services
+		 * code/data regions were mapped as a quirk for buggy firmware.
+		 * Unmap them from efi_pgd before freeing them up.
+		 */
+		efi_unmap_pages(md);
+
+		/*
 		 * Nasty quirk: if all sub-1MB memory is used for boot
 		 * services, we can get here without having allocated the
 		 * real mode trampoline.  It's too late to hand boot services
-- 
2.7.4

