Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BA2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE94247A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE94247A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934654AbeGCSXN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:23:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:31211 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934440AbeGCSXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:23:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 11:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,304,1526367600"; 
   d="scan'208";a="242708190"
Received: from cdikicix-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.69])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jul 2018 11:23:05 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v12 07/13] x86/sgx: data structures for tracking available EPC pages
Date:   Tue,  3 Jul 2018 21:19:52 +0300
Message-Id: <20180703182118.15024-8-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGX has a set of data structures to maintain information about the enclaves
and their security properties. BIOS reserves a fixed size region of
physical memory for these structures by setting Processor Reserved Memory
Range Registers (PRMRR). This memory area is called Enclave Page Cache
(EPC).

This commit adds a database of EPC banks for kernel to easily access the
available EPC pages. On UMA architectures there is a singe bank of EPC
pages. On NUMA architectures there is an EPC bank for each node.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Co-developed-by: Serge Ayoun <serge.ayoun@intel.com>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/sgx.h      |  30 +++++++
 arch/x86/kernel/cpu/intel_sgx.c | 146 +++++++++++++++++++++++++++++++-
 2 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 2130e639ab49..77b2294fcfb0 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -4,9 +4,39 @@
 #ifndef _ASM_X86_SGX_H
 #define _ASM_X86_SGX_H
 
+#include <asm/sgx_arch.h>
+#include <asm/asm.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/rwsem.h>
 #include <linux/types.h>
 
+#define SGX_MAX_EPC_BANKS 8
+
+#define SGX_EPC_BANK(epc_page) \
+	(&sgx_epc_banks[(unsigned long)(epc_page->desc) & ~PAGE_MASK])
+#define SGX_EPC_PFN(epc_page) PFN_DOWN((unsigned long)(epc_page->desc))
+#define SGX_EPC_ADDR(epc_page) ((unsigned long)(epc_page->desc) & PAGE_MASK)
+
+struct sgx_epc_page {
+	unsigned long desc;
+	struct list_head list;
+};
+
+struct sgx_epc_bank {
+	unsigned long pa;
+	unsigned long va;
+	unsigned long size;
+	struct sgx_epc_page *pages_data;
+	struct sgx_epc_page **pages;
+	atomic_t free_cnt;
+	struct rw_semaphore lock;
+};
+
 extern bool sgx_enabled;
 extern bool sgx_lc_enabled;
 
+void *sgx_get_page(struct sgx_epc_page *ptr);
+void sgx_put_page(void *epc_page_ptr);
+
 #endif /* _ASM_X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/intel_sgx.c b/arch/x86/kernel/cpu/intel_sgx.c
index 77d94115c4cf..60cbc7cfb868 100644
--- a/arch/x86/kernel/cpu/intel_sgx.c
+++ b/arch/x86/kernel/cpu/intel_sgx.c
@@ -6,8 +6,10 @@
 #include <linux/freezer.h>
 #include <linux/highmem.h>
 #include <linux/kthread.h>
+#include <linux/pagemap.h>
 #include <linux/ratelimit.h>
 #include <linux/sched/signal.h>
+#include <linux/shmem_fs.h>
 #include <linux/slab.h>
 
 bool sgx_enabled __ro_after_init;
@@ -15,6 +17,139 @@ EXPORT_SYMBOL(sgx_enabled);
 bool sgx_lc_enabled __ro_after_init;
 EXPORT_SYMBOL(sgx_lc_enabled);
 
+static atomic_t sgx_nr_free_pages = ATOMIC_INIT(0);
+static struct sgx_epc_bank sgx_epc_banks[SGX_MAX_EPC_BANKS];
+static int sgx_nr_epc_banks;
+
+/**
+ * sgx_get_page - pin an EPC page
+ * @page:	an EPC page
+ *
+ * Return: a pointer to the pinned EPC page
+ */
+void *sgx_get_page(struct sgx_epc_page *page)
+{
+	struct sgx_epc_bank *bank = SGX_EPC_BANK(page);
+
+	if (IS_ENABLED(CONFIG_X86_64))
+		return (void *)(bank->va + SGX_EPC_ADDR(page) - bank->pa);
+
+	return kmap_atomic_pfn(SGX_EPC_PFN(page));
+}
+EXPORT_SYMBOL(sgx_get_page);
+
+/**
+ * sgx_put_page - unpin an EPC page
+ * @ptr:	a pointer to the pinned EPC page
+ */
+void sgx_put_page(void *ptr)
+{
+	if (IS_ENABLED(CONFIG_X86_64))
+		return;
+
+	kunmap_atomic(ptr);
+}
+EXPORT_SYMBOL(sgx_put_page);
+
+static __init int sgx_init_epc_bank(unsigned long addr, unsigned long size,
+				    unsigned long index,
+				    struct sgx_epc_bank *bank)
+{
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	unsigned long i;
+	void *va;
+
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		va = ioremap_cache(addr, size);
+		if (!va)
+			return -ENOMEM;
+	}
+
+	bank->pages_data = kzalloc(nr_pages * sizeof(struct sgx_epc_page),
+				   GFP_KERNEL);
+	if (!bank->pages_data) {
+		if (IS_ENABLED(CONFIG_X86_64))
+			iounmap(va);
+
+		return -ENOMEM;
+	}
+
+	bank->pages = kzalloc(nr_pages * sizeof(struct sgx_epc_page *),
+			      GFP_KERNEL);
+	if (!bank->pages) {
+		if (IS_ENABLED(CONFIG_X86_64))
+			iounmap(va);
+		kfree(bank->pages_data);
+		bank->pages_data = NULL;
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < nr_pages; i++) {
+		bank->pages[i] = &bank->pages_data[i];
+		bank->pages[i]->desc = (addr + (i << PAGE_SHIFT)) | index;
+	}
+
+	bank->pa = addr;
+	bank->size = size;
+	if (IS_ENABLED(CONFIG_X86_64))
+		bank->va = (unsigned long)va;
+
+	atomic_set(&bank->free_cnt, nr_pages);
+	init_rwsem(&bank->lock);
+	atomic_add(nr_pages, &sgx_nr_free_pages);
+	return 0;
+}
+
+static __init void sgx_page_cache_teardown(void)
+{
+	struct sgx_epc_bank *bank;
+	int i;
+
+	for (i = 0; i < sgx_nr_epc_banks; i++) {
+		bank = &sgx_epc_banks[i];
+
+		if (IS_ENABLED(CONFIG_X86_64))
+			iounmap((void *)bank->va);
+
+		kfree(bank->pages);
+		kfree(bank->pages_data);
+	}
+}
+
+static __init int sgx_page_cache_init(void)
+{
+	unsigned long size;
+	unsigned int eax;
+	unsigned int ebx;
+	unsigned int ecx;
+	unsigned int edx;
+	unsigned long pa;
+	int i;
+	int ret;
+
+	for (i = 0; i < SGX_MAX_EPC_BANKS; i++) {
+		cpuid_count(SGX_CPUID, i + SGX_CPUID_EPC_BANKS, &eax, &ebx,
+			    &ecx, &edx);
+		if (!(eax & 0xf))
+			break;
+
+		pa = ((u64)(ebx & 0xfffff) << 32) + (u64)(eax & 0xfffff000);
+		size = ((u64)(edx & 0xfffff) << 32) + (u64)(ecx & 0xfffff000);
+
+		pr_info("EPC bank 0x%lx-0x%lx\n", pa, pa + size);
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
+	return 0;
+}
+
 static __init bool sgx_is_enabled(bool *lc_enabled)
 {
 	unsigned long fc;
@@ -47,7 +182,16 @@ static __init bool sgx_is_enabled(bool *lc_enabled)
 
 static __init int sgx_init(void)
 {
-	sgx_enabled = sgx_is_enabled(&sgx_lc_enabled);
+	int ret;
+
+	if (!sgx_is_enabled(&sgx_lc_enabled))
+		return 0;
+
+	ret = sgx_page_cache_init();
+	if (ret)
+		return ret;
+
+	sgx_enabled = true;
 	return 0;
 }
 
-- 
2.17.1

