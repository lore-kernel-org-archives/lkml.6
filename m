Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gKCeHsm5Glt6SAAAmS7hNA
	; Fri, 08 Jun 2018 17:21:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C4959607DC; Fri,  8 Jun 2018 17:21:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 49681601D2;
	Fri,  8 Jun 2018 17:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49681601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeFHRVR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:21:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:9409 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752959AbeFHRVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:21:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 10:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="231035412"
Received: from nzou1-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.254.60])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2018 10:21:08 -0700
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc: dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), intel-sgx-kernel-dev@lists.01.org (open list:INTEL SGX)
Subject: [PATCH v11 09/13] x86, sgx: basic routines for enclave page cache
Date: Fri,  8 Jun 2018 19:09:44 +0200
Message-Id: <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGX has a set of data structures to maintain information about the enclaves
and their security properties. BIOS reserves a fixed size region of
physical memory for these structures by setting Processor Reserved Memory
Range Registers (PRMRR). This memory area is called Enclave Page Cache
(EPC).

This commit implements the basic routines to allocate and free pages from
different EPC banks. There is also a swapper thread ksgxswapd for EPC pages
that gets woken up by sgx_alloc_page() when we run below the low watermark.
The swapper thread continues swapping pages up until it reaches the high
watermark.

Each subsystem that uses SGX must provide a set of callbacks for EPC
pages that are used to reclaim, block and write an EPC page. Kernel
takes the responsibility of maintaining LRU cache for them.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/include/asm/sgx.h      |  67 +++++
 arch/x86/include/asm/sgx_arch.h | 224 ++++++++++++++++
 arch/x86/kernel/cpu/intel_sgx.c | 443 +++++++++++++++++++++++++++++++-
 3 files changed, 732 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/sgx_arch.h

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index a2f727f85b91..ae738e16ba6c 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -14,6 +14,7 @@
 #include <asm/asm.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
+#include <linux/rwsem.h>
 #include <linux/types.h>
 
 #define SGX_CPUID 0x12
@@ -193,7 +194,73 @@ static inline int __emodt(struct sgx_secinfo *secinfo, void *epc)
 	return __encls_ret_2(EMODT, secinfo, epc);
 }
 
+#define SGX_MAX_EPC_BANKS 8
+
+#define SGX_EPC_BANK(epc_page) \
+	(&sgx_epc_banks[(unsigned long)(epc_page->desc) & ~PAGE_MASK])
+#define SGX_EPC_PFN(epc_page) PFN_DOWN((unsigned long)(epc_page->desc))
+#define SGX_EPC_ADDR(epc_page) ((unsigned long)(epc_page->desc) & PAGE_MASK)
+
+struct sgx_epc_page;
+
+struct sgx_epc_page_ops {
+	bool (*get)(struct sgx_epc_page *epc_page);
+	void (*put)(struct sgx_epc_page *epc_page);
+	bool (*reclaim)(struct sgx_epc_page *epc_page);
+	void (*block)(struct sgx_epc_page *epc_page);
+	void (*write)(struct sgx_epc_page *epc_page);
+};
+
+struct sgx_epc_page_impl {
+	const struct sgx_epc_page_ops *ops;
+};
+
+struct sgx_epc_page {
+	unsigned long desc;
+	struct sgx_epc_page_impl *impl;
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
+extern bool sgx_lc_enabled;
+extern atomic_t sgx_nr_free_pages;
+extern struct sgx_epc_bank sgx_epc_banks[];
+extern int sgx_nr_epc_banks;
+extern struct list_head sgx_active_page_list;
+extern struct spinlock sgx_active_page_list_lock;
+
+enum sgx_alloc_flags {
+	SGX_ALLOC_ATOMIC	= BIT(0),
+};
+
+struct sgx_epc_page *sgx_try_alloc_page(struct sgx_epc_page_impl *impl);
+struct sgx_epc_page *sgx_alloc_page(struct sgx_epc_page_impl *impl,
+				    unsigned int flags);
+int sgx_free_page(struct sgx_epc_page *page);
+void *sgx_get_page(struct sgx_epc_page *ptr);
+void sgx_put_page(void *epc_page_ptr);
+struct page *sgx_get_backing(struct file *file, pgoff_t index);
+void sgx_put_backing(struct page *backing_page, bool write);
+int sgx_einit(struct sgx_sigstruct *sigstruct, struct sgx_einittoken *token,
+	      struct sgx_epc_page *secs_page, u64 le_pubkey_hash[4]);
+
+struct sgx_launch_request {
+	u8 mrenclave[32];
+	u8 mrsigner[32];
+	uint64_t attributes;
+	uint64_t xfrm;
+	struct sgx_einittoken token;
+};
 
 #define SGX_FN(name, params...)		\
 {					\
diff --git a/arch/x86/include/asm/sgx_arch.h b/arch/x86/include/asm/sgx_arch.h
new file mode 100644
index 000000000000..eb64bd92f84e
--- /dev/null
+++ b/arch/x86/include/asm/sgx_arch.h
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+// Suresh Siddha <suresh.b.siddha@intel.com>
+
+#ifndef _ASM_X86_SGX_ARCH_H
+#define _ASM_X86_SGX_ARCH_H
+
+#include <linux/types.h>
+
+#define SGX_SSA_GPRS_SIZE		182
+#define SGX_SSA_MISC_EXINFO_SIZE	16
+
+enum sgx_misc {
+	SGX_MISC_EXINFO		= 0x01,
+};
+
+#define SGX_MISC_RESERVED_MASK 0xFFFFFFFFFFFFFFFEL
+
+enum sgx_attribute {
+	SGX_ATTR_DEBUG		= 0x02,
+	SGX_ATTR_MODE64BIT	= 0x04,
+	SGX_ATTR_PROVISIONKEY	= 0x10,
+	SGX_ATTR_EINITTOKENKEY	= 0x20,
+};
+
+#define SGX_ATTR_RESERVED_MASK 0xFFFFFFFFFFFFFFC9L
+
+#define SGX_SECS_RESERVED1_SIZE 24
+#define SGX_SECS_RESERVED2_SIZE 32
+#define SGX_SECS_RESERVED3_SIZE 96
+#define SGX_SECS_RESERVED4_SIZE 3836
+
+struct sgx_secs {
+	uint64_t size;
+	uint64_t base;
+	uint32_t ssaframesize;
+	uint32_t miscselect;
+	uint8_t reserved1[SGX_SECS_RESERVED1_SIZE];
+	uint64_t attributes;
+	uint64_t xfrm;
+	uint32_t mrenclave[8];
+	uint8_t reserved2[SGX_SECS_RESERVED2_SIZE];
+	uint32_t mrsigner[8];
+	uint8_t	reserved3[SGX_SECS_RESERVED3_SIZE];
+	uint16_t isvvprodid;
+	uint16_t isvsvn;
+	uint8_t reserved4[SGX_SECS_RESERVED4_SIZE];
+};
+
+enum sgx_tcs_flags {
+	SGX_TCS_DBGOPTIN	= 0x01, /* cleared on EADD */
+};
+
+#define SGX_TCS_RESERVED_MASK 0xFFFFFFFFFFFFFFFEL
+
+struct sgx_tcs {
+	uint64_t state;
+	uint64_t flags;
+	uint64_t ossa;
+	uint32_t cssa;
+	uint32_t nssa;
+	uint64_t oentry;
+	uint64_t aep;
+	uint64_t ofsbase;
+	uint64_t ogsbase;
+	uint32_t fslimit;
+	uint32_t gslimit;
+	uint64_t reserved[503];
+};
+
+struct sgx_pageinfo {
+	uint64_t linaddr;
+	uint64_t srcpge;
+	union {
+		uint64_t secinfo;
+		uint64_t pcmd;
+	};
+	uint64_t secs;
+} __attribute__((aligned(32)));
+
+
+#define SGX_SECINFO_PERMISSION_MASK	0x0000000000000007L
+#define SGX_SECINFO_PAGE_TYPE_MASK	0x000000000000FF00L
+#define SGX_SECINFO_RESERVED_MASK	0xFFFFFFFFFFFF00F8L
+
+enum sgx_page_type {
+	SGX_PAGE_TYPE_SECS	= 0x00,
+	SGX_PAGE_TYPE_TCS	= 0x01,
+	SGX_PAGE_TYPE_REG	= 0x02,
+	SGX_PAGE_TYPE_VA	= 0x03,
+	SGX_PAGE_TYPE_TRIM	= 0x04,
+};
+
+enum sgx_secinfo_flags {
+	SGX_SECINFO_R		= 0x01,
+	SGX_SECINFO_W		= 0x02,
+	SGX_SECINFO_X		= 0x04,
+	SGX_SECINFO_SECS	= (SGX_PAGE_TYPE_SECS << 8),
+	SGX_SECINFO_TCS		= (SGX_PAGE_TYPE_TCS << 8),
+	SGX_SECINFO_REG		= (SGX_PAGE_TYPE_REG << 8),
+	SGX_SECINFO_TRIM	= (SGX_PAGE_TYPE_TRIM << 8),
+};
+
+struct sgx_secinfo {
+	uint64_t flags;
+	uint64_t reserved[7];
+} __attribute__((aligned(64)));
+
+struct sgx_pcmd {
+	struct sgx_secinfo secinfo;
+	uint64_t enclave_id;
+	uint8_t reserved[40];
+	uint8_t mac[16];
+};
+
+#define SGX_MODULUS_SIZE 384
+
+struct sgx_sigstruct_header {
+	uint64_t header1[2];
+	uint32_t vendor;
+	uint32_t date;
+	uint64_t header2[2];
+	uint32_t swdefined;
+	uint8_t reserved1[84];
+};
+
+struct sgx_sigstruct_body {
+	uint32_t miscselect;
+	uint32_t miscmask;
+	uint8_t reserved2[20];
+	uint64_t attributes;
+	uint64_t xfrm;
+	uint8_t attributemask[16];
+	uint8_t mrenclave[32];
+	uint8_t reserved3[32];
+	uint16_t isvprodid;
+	uint16_t isvsvn;
+} __attribute__((__packed__));
+
+struct sgx_sigstruct {
+	struct sgx_sigstruct_header header;
+	uint8_t modulus[SGX_MODULUS_SIZE];
+	uint32_t exponent;
+	uint8_t signature[SGX_MODULUS_SIZE];
+	struct sgx_sigstruct_body body;
+	uint8_t reserved4[12];
+	uint8_t q1[SGX_MODULUS_SIZE];
+	uint8_t q2[SGX_MODULUS_SIZE];
+};
+
+struct sgx_sigstruct_payload {
+	struct sgx_sigstruct_header header;
+	struct sgx_sigstruct_body body;
+};
+
+struct sgx_einittoken_payload {
+	uint32_t valid;
+	uint32_t reserved1[11];
+	uint64_t attributes;
+	uint64_t xfrm;
+	uint8_t mrenclave[32];
+	uint8_t reserved2[32];
+	uint8_t mrsigner[32];
+	uint8_t reserved3[32];
+};
+
+struct sgx_einittoken {
+	struct sgx_einittoken_payload payload;
+	uint8_t cpusvnle[16];
+	uint16_t isvprodidle;
+	uint16_t isvsvnle;
+	uint8_t reserved2[24];
+	uint32_t maskedmiscselectle;
+	uint64_t maskedattributesle;
+	uint64_t maskedxfrmle;
+	uint8_t keyid[32];
+	uint8_t mac[16];
+};
+
+struct sgx_report {
+	uint8_t cpusvn[16];
+	uint32_t miscselect;
+	uint8_t reserved1[28];
+	uint64_t attributes;
+	uint64_t xfrm;
+	uint8_t mrenclave[32];
+	uint8_t reserved2[32];
+	uint8_t mrsigner[32];
+	uint8_t reserved3[96];
+	uint16_t isvprodid;
+	uint16_t isvsvn;
+	uint8_t reserved4[60];
+	uint8_t reportdata[64];
+	uint8_t keyid[32];
+	uint8_t mac[16];
+};
+
+struct sgx_targetinfo {
+	uint8_t mrenclave[32];
+	uint64_t attributes;
+	uint64_t xfrm;
+	uint8_t reserved1[4];
+	uint32_t miscselect;
+	uint8_t reserved2[456];
+};
+
+struct sgx_keyrequest {
+	uint16_t keyname;
+	uint16_t keypolicy;
+	uint16_t isvsvn;
+	uint16_t reserved1;
+	uint8_t cpusvn[16];
+	uint64_t attributemask;
+	uint64_t xfrmmask;
+	uint8_t keyid[32];
+	uint32_t miscmask;
+	uint8_t reserved2[436];
+};
+
+#endif /* _ASM_X86_SGX_ARCH_H */
diff --git a/arch/x86/kernel/cpu/intel_sgx.c b/arch/x86/kernel/cpu/intel_sgx.c
index db6b315334f4..ae2b5c5b455f 100644
--- a/arch/x86/kernel/cpu/intel_sgx.c
+++ b/arch/x86/kernel/cpu/intel_sgx.c
@@ -14,14 +14,439 @@
 #include <linux/freezer.h>
 #include <linux/highmem.h>
 #include <linux/kthread.h>
+#include <linux/pagemap.h>
 #include <linux/ratelimit.h>
 #include <linux/sched/signal.h>
+#include <linux/shmem_fs.h>
 #include <linux/slab.h>
 
+#define SGX_NR_TO_SCAN	16
+#define SGX_NR_LOW_PAGES 32
+#define SGX_NR_HIGH_PAGES 64
+
 bool sgx_enabled __ro_after_init = false;
 EXPORT_SYMBOL(sgx_enabled);
+bool sgx_lc_enabled __ro_after_init;
+EXPORT_SYMBOL(sgx_lc_enabled);
+atomic_t sgx_nr_free_pages = ATOMIC_INIT(0);
+EXPORT_SYMBOL(sgx_nr_free_pages);
+struct sgx_epc_bank sgx_epc_banks[SGX_MAX_EPC_BANKS];
+EXPORT_SYMBOL(sgx_epc_banks);
+int sgx_nr_epc_banks;
+EXPORT_SYMBOL(sgx_nr_epc_banks);
+LIST_HEAD(sgx_active_page_list);
+EXPORT_SYMBOL(sgx_active_page_list);
+DEFINE_SPINLOCK(sgx_active_page_list_lock);
+EXPORT_SYMBOL(sgx_active_page_list_lock);
+
+static struct task_struct *ksgxswapd_tsk;
+static DECLARE_WAIT_QUEUE_HEAD(ksgxswapd_waitq);
+
+/*
+ * Writing the LE hash MSRs is extraordinarily expensive, e.g.
+ * 3-4x slower than normal MSRs, so we use a per-cpu cache to
+ * track the last known value of the MSRs to avoid unnecessarily
+ * writing the MSRs with the current value.  Because most Linux
+ * kernels will use an LE that is signed with a non-Intel key,
+ * i.e. the first EINIT will need to write the MSRs regardless
+ * of the cache, the cache is intentionally left uninitialized
+ * during boot as initializing the cache would be pure overhead
+ * for the majority of systems.  Furthermore, the MSRs are per-cpu
+ * and the boot-time values aren't guaranteed to be identical
+ * across cpus, so we'd have to run code all all cpus to properly
+ * init the cache.  All in all, the complexity and overhead of
+ * initializing the cache is not justified.
+ */
+static DEFINE_PER_CPU(u64 [4], sgx_le_pubkey_hash_cache);
+
+static void sgx_swap_cluster(void)
+{
+	struct sgx_epc_page *cluster[SGX_NR_TO_SCAN + 1];
+	struct sgx_epc_page *epc_page;
+	int i;
+	int j;
+
+	memset(cluster, 0, sizeof(cluster));
+
+	for (i = 0, j = 0; i < SGX_NR_TO_SCAN; i++) {
+		spin_lock(&sgx_active_page_list_lock);
+		if (list_empty(&sgx_active_page_list)) {
+			spin_unlock(&sgx_active_page_list_lock);
+			break;
+		}
+		epc_page = list_first_entry(&sgx_active_page_list,
+					    struct sgx_epc_page, list);
+		if (!epc_page->impl->ops->get(epc_page)) {
+			list_move_tail(&epc_page->list, &sgx_active_page_list);
+			spin_unlock(&sgx_active_page_list_lock);
+			continue;
+		}
+		list_del(&epc_page->list);
+		spin_unlock(&sgx_active_page_list_lock);
 
-static __init bool sgx_is_enabled(void)
+		if (epc_page->impl->ops->reclaim(epc_page)) {
+			cluster[j++] = epc_page;
+		} else {
+			spin_lock(&sgx_active_page_list_lock);
+			list_add_tail(&epc_page->list, &sgx_active_page_list);
+			spin_unlock(&sgx_active_page_list_lock);
+			epc_page->impl->ops->put(epc_page);
+		}
+	}
+
+	for (i = 0; cluster[i]; i++) {
+		epc_page = cluster[i];
+		epc_page->impl->ops->block(epc_page);
+	}
+
+	for (i = 0; cluster[i]; i++) {
+		epc_page = cluster[i];
+		epc_page->impl->ops->write(epc_page);
+		epc_page->impl->ops->put(epc_page);
+		sgx_free_page(epc_page);
+	}
+}
+
+static int ksgxswapd(void *p)
+{
+	set_freezable();
+
+	while (!kthread_should_stop()) {
+		if (try_to_freeze())
+			continue;
+
+		wait_event_freezable(ksgxswapd_waitq, kthread_should_stop() ||
+				     atomic_read(&sgx_nr_free_pages) <
+				     SGX_NR_HIGH_PAGES);
+
+		if (atomic_read(&sgx_nr_free_pages) < SGX_NR_HIGH_PAGES)
+			sgx_swap_cluster();
+	}
+
+	pr_info("%s: done\n", __func__);
+	return 0;
+}
+
+/**
+ * sgx_try_alloc_page - try to allocate an EPC page
+ * @impl:	implementation for the struct sgx_epc_page
+ *
+ * Try to grab a page from the free EPC page list. If there is a free page
+ * available, it is returned to the caller.
+ *
+ * Return:
+ *   a &struct sgx_epc_page instace,
+ *   NULL otherwise
+ */
+struct sgx_epc_page *sgx_try_alloc_page(struct sgx_epc_page_impl *impl)
+{
+	struct sgx_epc_bank *bank;
+	struct sgx_epc_page *page = NULL;
+	int i;
+
+	for (i = 0; i < sgx_nr_epc_banks; i++) {
+		bank = &sgx_epc_banks[i];
+
+		down_write(&bank->lock);
+
+		if (atomic_read(&bank->free_cnt))
+			page = bank->pages[atomic_dec_return(&bank->free_cnt)];
+
+		up_write(&bank->lock);
+
+		if (page)
+			break;
+	}
+
+	if (page) {
+		atomic_dec(&sgx_nr_free_pages);
+		page->impl = impl;
+	}
+
+	return page;
+}
+EXPORT_SYMBOL(sgx_try_alloc_page);
+
+/**
+ * sgx_alloc_page - allocate an EPC page
+ * @flags:	allocation flags
+ * @impl:	implementation for the struct sgx_epc_page
+ *
+ * Try to grab a page from the free EPC page list. If there is a free page
+ * available, it is returned to the caller. If called with SGX_ALLOC_ATOMIC,
+ * the function will return immediately if the list is empty. Otherwise, it
+ * will swap pages up until there is a free page available. Upon returning the
+ * low watermark is checked and ksgxswapd is waken up if we are below it.
+ *
+ * Return:
+ *   a &struct sgx_epc_page instace,
+ *   -ENOMEM if all pages are unreclaimable,
+ *   -EBUSY when called with SGX_ALLOC_ATOMIC and out of free pages
+ */
+struct sgx_epc_page *sgx_alloc_page(struct sgx_epc_page_impl *impl,
+				    unsigned int flags)
+{
+	struct sgx_epc_page *entry;
+
+	for ( ; ; ) {
+		entry = sgx_try_alloc_page(impl);
+		if (entry)
+			break;
+
+		if (list_empty(&sgx_active_page_list))
+			return ERR_PTR(-ENOMEM);
+
+		if (flags & SGX_ALLOC_ATOMIC) {
+			entry = ERR_PTR(-EBUSY);
+			break;
+		}
+
+		if (signal_pending(current)) {
+			entry = ERR_PTR(-ERESTARTSYS);
+			break;
+		}
+
+		sgx_swap_cluster();
+		schedule();
+	}
+
+	if (atomic_read(&sgx_nr_free_pages) < SGX_NR_LOW_PAGES)
+		wake_up(&ksgxswapd_waitq);
+
+	return entry;
+}
+EXPORT_SYMBOL(sgx_alloc_page);
+
+/**
+ * sgx_free_page - free an EPC page
+ *
+ * @page:	any EPC page
+ *
+ * Remove an EPC page and insert it back to the list of free pages.
+ *
+ * Return: SGX error code
+ */
+int sgx_free_page(struct sgx_epc_page *page)
+{
+	struct sgx_epc_bank *bank = SGX_EPC_BANK(page);
+	int ret;
+
+	ret = sgx_eremove(page);
+	if (ret) {
+		pr_debug("EREMOVE returned %d\n", ret);
+		return ret;
+	}
+
+	down_read(&bank->lock);
+	bank->pages[atomic_inc_return(&bank->free_cnt) - 1] = page;
+	atomic_inc(&sgx_nr_free_pages);
+	up_read(&bank->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(sgx_free_page);
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
+struct page *sgx_get_backing(struct file *file, pgoff_t index)
+{
+	struct inode *inode = file->f_path.dentry->d_inode;
+	struct address_space *mapping = inode->i_mapping;
+	gfp_t gfpmask = mapping_gfp_mask(mapping);
+
+	return shmem_read_mapping_page_gfp(mapping, index, gfpmask);
+}
+EXPORT_SYMBOL(sgx_get_backing);
+
+void sgx_put_backing(struct page *backing_page, bool write)
+{
+	if (write)
+		set_page_dirty(backing_page);
+
+	put_page(backing_page);
+}
+EXPORT_SYMBOL(sgx_put_backing);
+
+/**
+ * sgx_einit - EINIT an enclave with the appropriate LE pubkey hash
+ * @sigstruct:		a pointer to the enclave's sigstruct
+ * @token:		a pointer to the enclave's EINIT token
+ * @secs_page:		a pointer to the enclave's SECS EPC page
+ * @le_pubkey_hash:	the desired LE pubkey hash for EINIT
+ */
+int sgx_einit(struct sgx_sigstruct *sigstruct, struct sgx_einittoken *token,
+	      struct sgx_epc_page *secs_page, u64 le_pubkey_hash[4])
+{
+	u64 __percpu *cache;
+	void *secs;
+	int i, ret;
+
+	secs = sgx_get_page(secs_page);
+
+	if (!sgx_lc_enabled) {
+		ret = __einit(sigstruct, token, secs);
+		goto out;
+	}
+
+	cache = per_cpu(sgx_le_pubkey_hash_cache, smp_processor_id());
+
+	preempt_disable();
+	for (i = 0; i < 4; i++) {
+		if (le_pubkey_hash[i] == cache[i])
+			continue;
+
+		wrmsrl(MSR_IA32_SGXLEPUBKEYHASH0 + i, le_pubkey_hash[i]);
+		cache[i] = le_pubkey_hash[i];
+	}
+	ret = __einit(sigstruct, token, secs);
+	preempt_enable();
+
+out:
+	sgx_put_page(secs);
+	return ret;
+}
+EXPORT_SYMBOL(sgx_einit);
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
+
+	if (ksgxswapd_tsk) {
+		kthread_stop(ksgxswapd_tsk);
+		ksgxswapd_tsk = NULL;
+	}
+}
+
+static __init int sgx_page_cache_init(void)
+{
+	struct task_struct *tsk;
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
+	tsk = kthread_run(ksgxswapd, NULL, "ksgxswapd");
+	if (IS_ERR(tsk)) {
+		sgx_page_cache_teardown();
+		return PTR_ERR(tsk);
+	}
+	ksgxswapd_tsk = tsk;
+	return 0;
+}
+
+static __init bool sgx_is_enabled(bool *lc_enabled)
 {
 	unsigned long fc;
 
@@ -41,12 +466,26 @@ static __init bool sgx_is_enabled(void)
 	if (!(fc & FEATURE_CONTROL_SGX_ENABLE))
 		return false;
 
+	*lc_enabled = !!(fc & FEATURE_CONTROL_SGX_LE_WR);
+
 	return true;
 }
 
 static __init int sgx_init(void)
 {
-	sgx_enabled = sgx_is_enabled();
+	bool lc_enabled;
+	int ret;
+
+	if (!sgx_is_enabled(&lc_enabled))
+		return 0;
+
+	ret = sgx_page_cache_init();
+	if (ret)
+		return ret;
+
+	sgx_enabled = true;
+	sgx_lc_enabled = lc_enabled;
+
 	return 0;
 }
 
-- 
2.17.0
