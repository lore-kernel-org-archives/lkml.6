Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2DBC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2109621CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2109621CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932355AbeGCBv4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:51:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:5209 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753639AbeGCBvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:51:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 18:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,301,1526367600"; 
   d="scan'208";a="212956413"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.52])
  by orsmga004.jf.intel.com with ESMTP; 02 Jul 2018 18:51:17 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Dave Young <dyoung@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Laszlo Ersek <lersek@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Nicolai Stange <nicstange@gmail.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 5/6] x86/efi: Free allocated memory if remap fails
Date:   Mon,  2 Jul 2018 18:50:53 -0700
Message-Id: <1530582654-25662-6-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530582654-25662-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1530582654-25662-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

efi_memmap_alloc(), as the name suggests, allocates memory for a new efi
memory map. It's referenced from couple of places, namely,
efi_arch_mem_reserve() and efi_free_boot_services(). These callers,
after allocating memory, remap it for further use. As usual, a routine
check is performed to confirm successful remap. If the remap fails,
ideally, the allocated memory should be freed but presently we just
return without freeing it up. Hence, fix this bug by freeing the memory
with efi_memmap_free().

Also, efi_fake_memmap() references efi_memmap_alloc() but it frees
memory correctly using memblock_free(), but replace it with
efi_memmap_free() to maintain consistency, as in, allocate memory with
efi_memmap_alloc() and free memory with efi_memmap_free().

It's a fact that memremap() and early_memremap() might never fail and
this code might never get a chance to run but to maintain good kernel
programming semantics, we might need this patch.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Nicolai Stange <nicstange@gmail.com>
Cc: Naresh Bhat <naresh.bhat@linaro.org>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/quirks.c  | 10 ++++++++--
 drivers/firmware/efi/fake_mem.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 11800f3cbb93..8fce327387e5 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -286,6 +286,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	new = early_memremap(new_phys, new_size);
 	if (!new) {
 		pr_err("Failed to map new boot services memmap\n");
+		efi_memmap_free(new_phys, num_entries, alloc_type);
 		return;
 	}
 
@@ -434,7 +435,7 @@ void __init efi_free_boot_services(void)
 	new = memremap(new_phys, new_size, MEMREMAP_WB);
 	if (!new) {
 		pr_err("Failed to map new EFI memmap\n");
-		return;
+		goto free_mem;
 	}
 
 	/*
@@ -460,8 +461,13 @@ void __init efi_free_boot_services(void)
 			efi.memmap.alloc_type);
 	if (efi_memmap_install(new_phys, num_entries, alloc_type)) {
 		pr_err("Could not install new EFI memmap\n");
-		return;
+		goto free_mem;
 	}
+
+	return;
+
+free_mem:
+	efi_memmap_free(new_phys, num_entries, alloc_type);
 }
 
 /*
diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index a47754efb796..09b0fabf07fd 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -80,7 +80,7 @@ void __init efi_fake_memmap(void)
 	new_memmap = early_memremap(new_memmap_phy,
 				    efi.memmap.desc_size * new_nr_map);
 	if (!new_memmap) {
-		memblock_free(new_memmap_phy, efi.memmap.desc_size * new_nr_map);
+		efi_memmap_free(new_memmap_phy, new_nr_map, alloc_type);
 		return;
 	}
 
-- 
2.7.4

