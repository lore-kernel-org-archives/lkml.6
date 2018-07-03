Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE60C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E7421CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E7421CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932535AbeGCBwj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:52:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:5207 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753463AbeGCBvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:51:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 18:51:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,301,1526367600"; 
   d="scan'208";a="212956411"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.52])
  by orsmga004.jf.intel.com with ESMTP; 02 Jul 2018 18:51:15 -0700
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
Subject: [PATCH 4/6] x86/efi: Free existing memory map before installing new memory map
Date:   Mon,  2 Jul 2018 18:50:52 -0700
Message-Id: <1530582654-25662-5-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530582654-25662-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1530582654-25662-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

efi_memmap_install(), unmaps the existing memory map and installs a new
memory map but doesn't free the memory allocated to the existing
memory map. Fortunately, the details about the existing memory map (like
the physical address, number of entries and type of memory) are
stored in efi.memmap. Hence, use them to free the memory.

In __efi_enter_virtual_mode(), we don't use efi_memmap_install() to
install a new memory map, instead we use efi_memmap_init_late(). Hence,
free existing memory map there too before installing a new memory map.

Generally, memory for new memory map is allocated using
efi_memmap_alloc() but in __efi_enter_virtual_mode() it's done using
realloc_pages() [please see efi_map_regions()]. So, it's OK to free this
memory using efi_memmap_free() in efi_free_boot_services().

Also, note that the first time efi_free_memmap() is called either from
efi_fake_memmap() or efi_arch_mem_reserve() [depending on the boot
sequence], we are actually freeing memblock_reserved memory which isn't
allocated by efi_memmap_alloc(). So, there are two outliers where we use
efi_free_memmap() to free memory allocated through other sources
rather than efi_memmap_alloc().

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
 arch/x86/platform/efi/efi.c     | 3 +++
 arch/x86/platform/efi/quirks.c  | 6 ++++++
 drivers/firmware/efi/fake_mem.c | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index cda54abf25a6..7756426e93b5 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -952,6 +952,9 @@ static void __init __efi_enter_virtual_mode(void)
 	 * firmware via SetVirtualAddressMap().
 	 */
 	efi_memmap_unmap();
+	/* Free existing memory map before installing new memory map */
+	efi_memmap_free(efi.memmap.phys_map, efi.memmap.nr_map,
+			efi.memmap.alloc_type);
 
 	if (efi_memmap_init_late(pa, efi.memmap.desc_size * count)) {
 		pr_err("Failed to remap late EFI memory map\n");
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 11fa6ac9f0c2..11800f3cbb93 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -292,6 +292,9 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	efi_memmap_insert(&efi.memmap, new, &mr);
 	early_memunmap(new, new_size);
 
+	/* Free existing memory map before installing new memory map */
+	efi_memmap_free(efi.memmap.phys_map, efi.memmap.nr_map,
+			efi.memmap.alloc_type);
 	efi_memmap_install(new_phys, num_entries, alloc_type);
 }
 
@@ -452,6 +455,9 @@ void __init efi_free_boot_services(void)
 
 	memunmap(new);
 
+	/* Free existing memory map before installing new memory map */
+	efi_memmap_free(efi.memmap.phys_map, efi.memmap.nr_map,
+			efi.memmap.alloc_type);
 	if (efi_memmap_install(new_phys, num_entries, alloc_type)) {
 		pr_err("Could not install new EFI memmap\n");
 		return;
diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index 82dcfa1c340b..a47754efb796 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -90,6 +90,9 @@ void __init efi_fake_memmap(void)
 	/* swap into new EFI memmap */
 	early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
 
+	/* Free existing memory map before installing new memory map */
+	efi_memmap_free(efi.memmap.phys_map, efi.memmap.nr_map,
+			efi.memmap.alloc_type);
 	efi_memmap_install(new_memmap_phy, new_nr_map, alloc_type);
 
 	/* print new EFI memmap */
-- 
2.7.4

