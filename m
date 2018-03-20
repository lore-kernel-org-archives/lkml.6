Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbeCTOCf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:02:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753403AbeCTOCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:02:25 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v6 4/7] x86/hyper-v: allocate and use Virtual Processor Assist Pages
Date: Tue, 20 Mar 2018 15:02:08 +0100
Message-Id: <20180320140211.7600-5-vkuznets@redhat.com>
In-Reply-To: <20180320140211.7600-1-vkuznets@redhat.com>
References: <20180320140211.7600-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtual Processor Assist Pages usage allows us to do optimized EOI
processing for APIC, enable Enlightened VMCS support in KVM and more.
struct hv_vp_assist_page is defined according to the Hyper-V TLFS v5.0b.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/hyperv/hv_init.c          | 43 +++++++++++++++++++++++++++++++++++---
 arch/x86/include/asm/hyperv-tlfs.h | 13 ++++++++++++
 arch/x86/include/asm/mshyperv.h    | 13 ++++++++++++
 3 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 4b82bc206929..cfecc2272f2d 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -88,11 +88,15 @@ EXPORT_SYMBOL_GPL(hyperv_cs);
 u32 *hv_vp_index;
 EXPORT_SYMBOL_GPL(hv_vp_index);
 
+struct hv_vp_assist_page **hv_vp_assist_page;
+EXPORT_SYMBOL_GPL(hv_vp_assist_page);
+
 u32 hv_max_vp_index;
 
 static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
+	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
 
 	hv_get_vp_index(msr_vp_index);
 
@@ -101,6 +105,22 @@ static int hv_cpu_init(unsigned int cpu)
 	if (msr_vp_index > hv_max_vp_index)
 		hv_max_vp_index = msr_vp_index;
 
+	if (!hv_vp_assist_page)
+		return 0;
+
+	if (!*hvp)
+		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
+
+	if (*hvp) {
+		u64 val;
+
+		val = vmalloc_to_pfn(*hvp);
+		val = (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
+			HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
+
+		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
+	}
+
 	return 0;
 }
 
@@ -198,6 +218,9 @@ static int hv_cpu_die(unsigned int cpu)
 	struct hv_reenlightenment_control re_ctrl;
 	unsigned int new_cpu;
 
+	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
+		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
+
 	if (hv_reenlightenment_cb == NULL)
 		return 0;
 
@@ -224,6 +247,7 @@ void hyperv_init(void)
 {
 	u64 guest_id, required_msrs;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
+	int cpuhp;
 
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return;
@@ -241,9 +265,17 @@ void hyperv_init(void)
 	if (!hv_vp_index)
 		return;
 
-	if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
-			      hv_cpu_init, hv_cpu_die) < 0)
+	hv_vp_assist_page = kcalloc(num_possible_cpus(),
+				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
+	if (!hv_vp_assist_page) {
+		ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
 		goto free_vp_index;
+	}
+
+	cpuhp = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
+				  hv_cpu_init, hv_cpu_die);
+	if (cpuhp < 0)
+		goto free_vp_assist_page;
 
 	/*
 	 * Setup the hypercall page and enable hypercalls.
@@ -256,7 +288,7 @@ void hyperv_init(void)
 	hv_hypercall_pg  = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL_RX);
 	if (hv_hypercall_pg == NULL) {
 		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
-		goto free_vp_index;
+		goto remove_cpuhp_state;
 	}
 
 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
@@ -304,6 +336,11 @@ void hyperv_init(void)
 
 	return;
 
+remove_cpuhp_state:
+	cpuhp_remove_state(cpuhp);
+free_vp_assist_page:
+	kfree(hv_vp_assist_page);
+	hv_vp_assist_page = NULL;
 free_vp_index:
 	kfree(hv_vp_index);
 	hv_vp_index = NULL;
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index acdec9a957db..41eac22db5e3 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -163,6 +163,9 @@
 /* Recommend using the newer ExProcessorMasks interface */
 #define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED	(1 << 11)
 
+/* Recommend using enlightened VMCS */
+#define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED    (1 << 14)
+
 /*
  * Crash notification flag.
  */
@@ -476,6 +479,16 @@ struct hv_timer_message_payload {
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
index 38cfbe9a5794..3f162353f180 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -218,6 +218,15 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
  */
 extern u32 *hv_vp_index;
 extern u32 hv_max_vp_index;
+extern struct hv_vp_assist_page **hv_vp_assist_page;
+
+static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
+{
+	if (!hv_vp_assist_page)
+		return NULL;
+
+	return hv_vp_assist_page[cpu];
+}
 
 /**
  * hv_cpu_number_to_vp_number() - Map CPU to VP.
@@ -254,6 +263,10 @@ static inline void hyperv_setup_mmu_ops(void) {}
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
