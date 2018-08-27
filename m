Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9483C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77ABC208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77ABC208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeH0WpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:45:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:56507 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbeH0WpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:45:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 11:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,296,1531810800"; 
   d="scan'208";a="69524602"
Received: from nitikasi-mobl.ger.corp.intel.com (HELO localhost) ([10.249.36.186])
  by orsmga006.jf.intel.com with ESMTP; 27 Aug 2018 11:56:55 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Serge Ayoun <serge.ayoun@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v13 07/13] x86/sgx: Add data structures for tracking the EPC pages
Date:   Mon, 27 Aug 2018 21:53:28 +0300
Message-Id: <20180827185507.17087-8-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add data structures to track Enclave Page Cache (EPC) pages.  EPC is
divided into multiple banks (1-N) of which addresses and sizes can be
enumerated with CPUID by the OS.

On NUMA systems a node can have at most bank. A bank can be at most part of
two nodes. SGX supports both nodes with a single memory controller and also
sub-cluster nodes with severals memory controllers on a single die.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Co-developed-by: Serge Ayoun <serge.ayoun@intel.com>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Serge Ayoun <serge.ayoun@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/sgx.h      |  60 ++++++++++++++++++
 arch/x86/kernel/cpu/intel_sgx.c | 106 +++++++++++++++++++++++++++++++-
 2 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 2130e639ab49..17b7b3aa66bf 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -4,9 +4,69 @@
 #ifndef _ASM_X86_SGX_H
 #define _ASM_X86_SGX_H
 
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/rwsem.h>
 #include <linux/types.h>
+#include <asm/sgx_arch.h>
+#include <asm/asm.h>
+
+#define SGX_MAX_EPC_BANKS 8
+
+struct sgx_epc_page {
+	unsigned long desc;
+	struct list_head list;
+};
+
+struct sgx_epc_bank {
+	unsigned long pa;
+	void *va;
+	unsigned long size;
+	struct sgx_epc_page *pages_data;
+	struct sgx_epc_page **pages;
+	unsigned long free_cnt;
+	spinlock_t lock;
+};
 
 extern bool sgx_enabled;
 extern bool sgx_lc_enabled;
+extern struct sgx_epc_bank sgx_epc_banks[SGX_MAX_EPC_BANKS];
+
+/*
+ * enum sgx_epc_page_desc - defines bits and masks for an EPC page's desc
+ * @SGX_EPC_BANK_MASK:	      SGX allows a system to multiple EPC banks (at
+ *			      different physical locations).  The index of a
+ *			      page's bank in its desc so that we can do a quick
+ *			      lookup of its virtual address (EPC is mapped via
+ *			      ioremap_cache() because it's non-standard memory).
+ *			      Current and near-future hardware defines at most
+ *			      eight banks, hence three bits to hold the bank.
+ *			      sgx_page_cache_init() asserts that the max bank
+ *			      index doesn't exceed SGX_EPC_BANK_MASK.
+ * @SGX_EPC_PAGE_RECLAIMABLE: When set, indicates a page is reclaimable.  Used
+ *			      when freeing a page to know that we also need to
+ *			      remove the page from the active page list.
+ *
+ * Defines the layout of the desc field in the &struct sgx_epc_page, which
+ * contains EPC bank number, physical address of the page and the page status
+ * flag.
+ */
+enum sgx_epc_page_desc {
+	SGX_EPC_BANK_MASK			= GENMASK_ULL(3, 0),
+	SGX_EPC_PAGE_RECLAIMABLE		= BIT(4),
+	/* bits 12-63 are reserved for the physical page address of the page */
+};
+
+static inline struct sgx_epc_bank *sgx_epc_bank(struct sgx_epc_page *page)
+{
+	return &sgx_epc_banks[page->desc & SGX_EPC_BANK_MASK];
+}
+
+static inline void *sgx_epc_addr(struct sgx_epc_page *page)
+{
+	struct sgx_epc_bank *bank = sgx_epc_bank(page);
+
+	return (void *)(bank->va + (page->desc & PAGE_MASK) - bank->pa);
+}
 
 #endif /* _ASM_X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/intel_sgx.c b/arch/x86/kernel/cpu/intel_sgx.c
index 17b46bec9c54..53ac172e8006 100644
--- a/arch/x86/kernel/cpu/intel_sgx.c
+++ b/arch/x86/kernel/cpu/intel_sgx.c
@@ -1,23 +1,121 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 // Copyright(c) 2016-17 Intel Corporation.
 
-#include <asm/sgx.h>
-#include <asm/sgx_pr.h>
 #include <linux/freezer.h>
 #include <linux/highmem.h>
 #include <linux/kthread.h>
+#include <linux/pagemap.h>
 #include <linux/ratelimit.h>
 #include <linux/sched/signal.h>
+#include <linux/shmem_fs.h>
 #include <linux/slab.h>
+#include <asm/sgx.h>
+#include <asm/sgx_pr.h>
 
 bool sgx_enabled __ro_after_init;
 EXPORT_SYMBOL_GPL(sgx_enabled);
 bool sgx_lc_enabled __ro_after_init;
 EXPORT_SYMBOL_GPL(sgx_lc_enabled);
+struct sgx_epc_bank sgx_epc_banks[SGX_MAX_EPC_BANKS];
+EXPORT_SYMBOL_GPL(sgx_epc_banks);
+
+static int sgx_nr_epc_banks;
+
+static __init int sgx_init_epc_bank(u64 addr, u64 size, unsigned long index,
+				    struct sgx_epc_bank *bank)
+{
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct sgx_epc_page *pages_data;
+	unsigned long i;
+	void *va;
+
+	va = ioremap_cache(addr, size);
+	if (!va)
+		return -ENOMEM;
+
+	pages_data = kcalloc(nr_pages, sizeof(struct sgx_epc_page), GFP_KERNEL);
+	if (!pages_data)
+		goto out_iomap;
+
+	bank->pages = kcalloc(nr_pages, sizeof(struct sgx_epc_page *),
+			      GFP_KERNEL);
+	if (!bank->pages)
+		goto out_pdata;
+
+	for (i = 0; i < nr_pages; i++) {
+		bank->pages[i] = &pages_data[i];
+		bank->pages[i]->desc = (addr + (i << PAGE_SHIFT)) | index;
+	}
+
+	bank->pa = addr;
+	bank->size = size;
+	bank->va = va;
+	bank->free_cnt = nr_pages;
+	bank->pages_data = pages_data;
+	spin_lock_init(&bank->lock);
+	return 0;
+out_pdata:
+	kfree(pages_data);
+out_iomap:
+	iounmap(va);
+	return -ENOMEM;
+}
+
+static __init void sgx_page_cache_teardown(void)
+{
+	struct sgx_epc_bank *bank;
+	int i;
+
+	for (i = 0; i < sgx_nr_epc_banks; i++) {
+		bank = &sgx_epc_banks[i];
+		iounmap((void *)bank->va);
+		kfree(bank->pages);
+		kfree(bank->pages_data);
+	}
+}
+
+static inline u64 sgx_combine_bank_regs(u64 low, u64 high)
+{
+	return (low & 0xFFFFF000) + ((high & 0xFFFFF) << 32);
+}
+
+static __init int sgx_page_cache_init(void)
+{
+	u32 eax, ebx, ecx, edx;
+	u64 pa, size;
+	int ret;
+	int i;
+
+	for (i = 0; i < SGX_MAX_EPC_BANKS; i++) {
+		cpuid_count(SGX_CPUID, 2 + i, &eax, &ebx, &ecx, &edx);
+		if (!(eax & 0xF))
+			break;
+
+		pa = sgx_combine_bank_regs(eax, ebx);
+		size = sgx_combine_bank_regs(ecx, edx);
+		pr_info("EPC bank 0x%llx-0x%llx\n", pa, pa + size - 1);
+
+		ret = sgx_init_epc_bank(pa, size, i, &sgx_epc_banks[i]);
+		if (ret) {
+			sgx_page_cache_teardown();
+			return ret;
+		}
+
+		sgx_nr_epc_banks++;
+	}
+
+	if (!sgx_nr_epc_banks) {
+		pr_err("There are zero EPC banks.\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
 
 static __init int sgx_init(void)
 {
 	unsigned long fc;
+	int ret;
 
 	if (!boot_cpu_has(X86_FEATURE_SGX))
 		return false;
@@ -39,6 +137,10 @@ static __init int sgx_init(void)
 	if (!(fc & FEATURE_CONTROL_SGX_LE_WR))
 		pr_info("IA32_SGXLEPUBKEYHASHn MSRs are not writable\n");
 
+	ret = sgx_page_cache_init();
+	if (ret)
+		return ret;
+
 	sgx_enabled = true;
 	sgx_lc_enabled = !!(fc & FEATURE_CONTROL_SGX_LE_WR);
 	return 0;
-- 
2.17.1

