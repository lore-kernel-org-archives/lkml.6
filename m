Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754062AbeDKRXd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 13:23:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753364AbeDKRVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 13:21:32 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] x86/hyper-v: move struct hv_flush_pcpu{,ex} definitions to common header
Date: Wed, 11 Apr 2018 19:21:21 +0200
Message-Id: <20180411172126.16355-2-vkuznets@redhat.com>
In-Reply-To: <20180411172126.16355-1-vkuznets@redhat.com>
References: <20180411172126.16355-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V TLB flush hypercalls definitions will be required for KVM so move
them hyperv-tlfs.h. Structures also need to be renamed as '_pcpu' suffix is
invalid for a general-purpose definition.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/mmu.c              | 40 ++++++++++----------------------------
 arch/x86/include/asm/hyperv-tlfs.h | 20 +++++++++++++++++++
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 56c9ebac946f..002fc565f8f2 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -13,32 +13,12 @@
 #define CREATE_TRACE_POINTS
 #include <asm/trace/hyperv.h>
 
-/* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
-struct hv_flush_pcpu {
-	u64 address_space;
-	u64 flags;
-	u64 processor_mask;
-	u64 gva_list[];
-};
-
-/* HvFlushVirtualAddressSpaceEx, HvFlushVirtualAddressListEx hypercalls */
-struct hv_flush_pcpu_ex {
-	u64 address_space;
-	u64 flags;
-	struct {
-		u64 format;
-		u64 valid_bank_mask;
-		u64 bank_contents[];
-	} hv_vp_set;
-	u64 gva_list[];
-};
-
 /* Each gva in gva_list encodes up to 4096 pages to flush */
 #define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
 
-static struct hv_flush_pcpu __percpu **pcpu_flush;
+static struct hv_tlb_flush __percpu **pcpu_flush;
 
-static struct hv_flush_pcpu_ex __percpu **pcpu_flush_ex;
+static struct hv_tlb_flush_ex __percpu **pcpu_flush_ex;
 
 /*
  * Fills in gva_list starting from offset. Returns the number of items added.
@@ -71,7 +51,7 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 }
 
 /* Return the number of banks in the resulting vp_set */
-static inline int cpumask_to_vp_set(struct hv_flush_pcpu_ex *flush,
+static inline int cpumask_to_vp_set(struct hv_tlb_flush_ex *flush,
 				    const struct cpumask *cpus)
 {
 	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
@@ -81,7 +61,7 @@ static inline int cpumask_to_vp_set(struct hv_flush_pcpu_ex *flush,
 		return 0;
 
 	/*
-	 * Clear all banks up to the maximum possible bank as hv_flush_pcpu_ex
+	 * Clear all banks up to the maximum possible bank as hv_tlb_flush_ex
 	 * structs are not cleared between calls, we risk flushing unneeded
 	 * vCPUs otherwise.
 	 */
@@ -109,8 +89,8 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 				    const struct flush_tlb_info *info)
 {
 	int cpu, vcpu, gva_n, max_gvas;
-	struct hv_flush_pcpu **flush_pcpu;
-	struct hv_flush_pcpu *flush;
+	struct hv_tlb_flush **flush_pcpu;
+	struct hv_tlb_flush *flush;
 	u64 status = U64_MAX;
 	unsigned long flags;
 
@@ -196,8 +176,8 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 				       const struct flush_tlb_info *info)
 {
 	int nr_bank = 0, max_gvas, gva_n;
-	struct hv_flush_pcpu_ex **flush_pcpu;
-	struct hv_flush_pcpu_ex *flush;
+	struct hv_tlb_flush_ex **flush_pcpu;
+	struct hv_tlb_flush_ex *flush;
 	u64 status = U64_MAX;
 	unsigned long flags;
 
@@ -303,7 +283,7 @@ void hyper_alloc_mmu(void)
 		return;
 
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
-		pcpu_flush = alloc_percpu(struct hv_flush_pcpu *);
+		pcpu_flush = alloc_percpu(struct hv_tlb_flush *);
 	else
-		pcpu_flush_ex = alloc_percpu(struct hv_flush_pcpu_ex *);
+		pcpu_flush_ex = alloc_percpu(struct hv_tlb_flush_ex *);
 }
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 1c602ad4bda8..ccb1dffe0d84 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -703,4 +703,24 @@ struct hv_enlightened_vmcs {
 #define HV_STIMER_AUTOENABLE		(1ULL << 3)
 #define HV_STIMER_SINT(config)		(__u8)(((config) >> 16) & 0x0F)
 
+/* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
+struct hv_tlb_flush {
+	u64 address_space;
+	u64 flags;
+	u64 processor_mask;
+	u64 gva_list[];
+};
+
+/* HvFlushVirtualAddressSpaceEx, HvFlushVirtualAddressListEx hypercalls */
+struct hv_tlb_flush_ex {
+	u64 address_space;
+	u64 flags;
+	struct {
+		u64 format;
+		u64 valid_bank_mask;
+		u64 bank_contents[];
+	} hv_vp_set;
+	u64 gva_list[];
+};
+
 #endif
-- 
2.14.3
