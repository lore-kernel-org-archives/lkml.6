Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932149AbeCIODE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:03:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932116AbeCIODB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:03:01 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] x86/hyper-v: allocate and use Virtual Processor Assist Pages
Date: Fri,  9 Mar 2018 15:02:46 +0100
Message-Id: <20180309140249.2840-5-vkuznets@redhat.com>
In-Reply-To: <20180309140249.2840-1-vkuznets@redhat.com>
References: <20180309140249.2840-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtual Processor Assist Pages usage allows us to do optimized EOI
processing for APIC, enable Enlightened VMCS support in KVM and more.
struct hv_vp_assist_page is defined according to the Hyper-V TLFS v5.0b.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since v1:
  move HV_X64_ENLIGHTENED_VMCS_RECOMMENDED definition to this patch
---
 arch/x86/hyperv/hv_init.c          | 33 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h | 13 +++++++++++++
 arch/x86/include/asm/mshyperv.h    | 10 ++++++++++
 3 files changed, 56 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 4b82bc206929..2e0c0351c5f8 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -88,6 +88,9 @@ EXPORT_SYMBOL_GPL(hyperv_cs);
 u32 *hv_vp_index;
 EXPORT_SYMBOL_GPL(hv_vp_index);
 
+struct hv_vp_assist_page **hv_vp_assist_page;
+EXPORT_SYMBOL_GPL(hv_vp_assist_page);
+
 u32 hv_max_vp_index;
 
 static int hv_cpu_init(unsigned int cpu)
@@ -101,6 +104,23 @@ static int hv_cpu_init(unsigned int cpu)
 	if (msr_vp_index > hv_max_vp_index)
 		hv_max_vp_index = msr_vp_index;
 
+	if (!hv_vp_assist_page)
+		return 0;
+
+	if (!hv_vp_assist_page[smp_processor_id()])
+		hv_vp_assist_page[smp_processor_id()] =
+			__vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
+
+	if (hv_vp_assist_page[smp_processor_id()]) {
+		u64 val;
+
+		val = vmalloc_to_pfn(hv_vp_assist_page[smp_processor_id()]);
+		val = (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
+			HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
+
+		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
+	}
+
 	return 0;
 }
 
@@ -198,6 +218,12 @@ static int hv_cpu_die(unsigned int cpu)
 	struct hv_reenlightenment_control re_ctrl;
 	unsigned int new_cpu;
 
+	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
+		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
+		vfree(hv_vp_assist_page[cpu]);
+		hv_vp_assist_page[cpu] = NULL;
+	}
+
 	if (hv_reenlightenment_cb == NULL)
 		return 0;
 
@@ -241,6 +267,13 @@ void hyperv_init(void)
 	if (!hv_vp_index)
 		return;
 
+	hv_vp_assist_page = kcalloc(num_possible_cpus(),
+				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
+	if (!hv_vp_assist_page) {
+		ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
+		return;
+	}
+
 	if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
 			      hv_cpu_init, hv_cpu_die) < 0)
 		goto free_vp_index;
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 5c0d8fab87a3..3d0fba18ab4c 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -156,6 +156,9 @@
 /* Recommend using the newer ExProcessorMasks interface */
 #define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED	(1 << 11)
 
+/* Recommend using enlightened VMCS */
+#define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED    (1 << 14)
+
 /*
  * Crash notification flag.
  */
@@ -469,6 +472,16 @@ struct hv_timer_message_payload {
 	__u64 delivery_time;	/* When the message was delivered */
 };
 
+/* Define virtual processor assist page structure. */
+struct hv_vp_assist_page {
+	__u32 apic_assist;
+	__u32 reserved;
+	__u64 vtl_control[2];
+	__u64 nested_enlightenments_control[2];
+	__u32 enlighten_vmentry;
+	__u64 current_nested_vmcs;
+};
+
 #define HV_STIMER_ENABLE		(1ULL << 0)
 #define HV_STIMER_PERIODIC		(1ULL << 1)
 #define HV_STIMER_LAZY			(1ULL << 2)
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 38cfbe9a5794..dcb40567b35e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -218,6 +218,12 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
  */
 extern u32 *hv_vp_index;
 extern u32 hv_max_vp_index;
+extern struct hv_vp_assist_page **hv_vp_assist_page;
+
+static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
+{
+	return hv_vp_assist_page[cpu];
+}
 
 /**
  * hv_cpu_number_to_vp_number() - Map CPU to VP.
@@ -254,6 +260,10 @@ static inline void hyperv_setup_mmu_ops(void) {}
 static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
 static inline void clear_hv_tscchange_cb(void) {}
 static inline void hyperv_stop_tsc_emulation(void) {};
+static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
+{
+	return NULL;
+}
 #endif /* CONFIG_HYPERV */
 
 #ifdef CONFIG_HYPERV_TSCPAGE
-- 
2.14.3
