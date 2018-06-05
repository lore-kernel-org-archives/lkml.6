Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeFEUkr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:40:47 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:59778
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751902AbeFEUjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:39:01 -0400
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc: Michael Kelley <mikelley@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 6/8] Drivers: hv: vmbus: Make TLFS #define names architecture neutral
Date: Tue,  5 Jun 2018 13:37:54 -0700
Message-Id: <20180605203756.29809-6-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605203756.29809-1-kys@linuxonhyperv.com>
References: <20180605203536.29751-1-kys@linuxonhyperv.com>
 <20180605203756.29809-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfNIFPdILffucLRUaZlDIJ92qU+gIV3IXco07fwUKxZ3G8WRWdUt17qcEPT5zEMwTCfWAIsAeSOFS+8JFOzaJZR+Ut3mvTESg97cl+q8nrPw6DYrJu0xt
 7R9m1crfvklbqspNcvPfCOLfeqT2qaBySifuEY7hu6rBoNQ+w2fi8LS2YDj1+dIDYsKWHT8tva+dmXROm1wRndhRE/J5xBbAWWj5G7GfLDY4Iom6b77qIdSj
 VsTKe68rZnc7LDd8UJQwcUgPYFD1CK5cAQObjGz4Ov0BrgIZRBpMbk0GkjON9fw4/hmRL4c10oH48jJvllng4mFwVMZVSgEvQYNXWcqJnB2DDmywVnlG6ldx
 yI+rnr+nEcRM4X3OKYEo5n1by9ZT+W0pdPbaVz6fAO01YXoGJQ/S42bd/2S/qgL4Nxmr1ZCgnO11zlQX19XH3qcLsvQMUJwP4kSF8hcaAU2kTZbX7xgw0z2c
 N/GfjrPwyxX8A61OwZJPdhJQsAVtdam/yhwinwDCuVNLwggie/ddkxmik5c2mb4N5P052QDXlk1cBSHCSXOOsdyLxB6040o+vpan2Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

The Hyper-V feature and hint flags in hyperv-tlfs.h are all defined
with the string "X64" in the name.  Some of these flags are indeed
x86/x64 specific, but others are not.  For the ones that are used
in architecture independent Hyper-V driver code, or will be used in
the upcoming support for Hyper-V for ARM64, this patch removes the
"X64" from the name.

This patch changes the flags that are currently known to be
used on multiple architectures. Hyper-V for ARM64 is still a
work-in-progress and the Top Level Functional Spec (TLFS) has not
been separated into x86/x64 and ARM64 areas.  So additional flags
may need to be updated later.

This patch only changes symbol names.  There are no functional
changes.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/hyperv/hv_init.c          |  4 ++--
 arch/x86/include/asm/hyperv-tlfs.h | 12 ++++++------
 arch/x86/kernel/cpu/mshyperv.c     |  4 ++--
 drivers/hv/hv.c                    | 10 +++++-----
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index cfecc2272f2d..3db87293dce0 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -302,7 +302,7 @@ void hyperv_init(void)
 	 * Register Hyper-V specific clocksource.
 	 */
 #ifdef CONFIG_HYPERV_TSCPAGE
-	if (ms_hyperv.features & HV_X64_MSR_REFERENCE_TSC_AVAILABLE) {
+	if (ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE) {
 		union hv_x64_msr_hypercall_contents tsc_msr;
 
 		tsc_pg = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
@@ -331,7 +331,7 @@ void hyperv_init(void)
 	 */
 
 	hyperv_cs = &hyperv_cs_msr;
-	if (ms_hyperv.features & HV_X64_MSR_TIME_REF_COUNT_AVAILABLE)
+	if (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE)
 		clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
 
 	return;
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 416cb0e0c496..44657e07fd59 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -35,9 +35,9 @@
 /* VP Runtime (HV_X64_MSR_VP_RUNTIME) available */
 #define HV_X64_MSR_VP_RUNTIME_AVAILABLE		(1 << 0)
 /* Partition Reference Counter (HV_X64_MSR_TIME_REF_COUNT) available*/
-#define HV_X64_MSR_TIME_REF_COUNT_AVAILABLE	(1 << 1)
+#define HV_MSR_TIME_REF_COUNT_AVAILABLE		(1 << 1)
 /* Partition reference TSC MSR is available */
-#define HV_X64_MSR_REFERENCE_TSC_AVAILABLE              (1 << 9)
+#define HV_MSR_REFERENCE_TSC_AVAILABLE		(1 << 9)
 
 /* A partition's reference time stamp counter (TSC) page */
 #define HV_X64_MSR_REFERENCE_TSC		0x40000021
@@ -60,7 +60,7 @@
  * Synthetic Timer MSRs (HV_X64_MSR_STIMER0_CONFIG through
  * HV_X64_MSR_STIMER3_COUNT) available
  */
-#define HV_X64_MSR_SYNTIMER_AVAILABLE		(1 << 3)
+#define HV_MSR_SYNTIMER_AVAILABLE		(1 << 3)
 /*
  * APIC access MSRs (HV_X64_MSR_EOI, HV_X64_MSR_ICR and HV_X64_MSR_TPR)
  * are available
@@ -86,7 +86,7 @@
 #define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE (1 << 10)
 
 /* stimer Direct Mode is available */
-#define HV_X64_STIMER_DIRECT_MODE_AVAILABLE	(1 << 19)
+#define HV_STIMER_DIRECT_MODE_AVAILABLE		(1 << 19)
 
 /*
  * Feature identification: EBX indicates which flags were specified at
@@ -160,9 +160,9 @@
 #define HV_X64_RELAXED_TIMING_RECOMMENDED	(1 << 5)
 
 /*
- * Virtual APIC support
+ * Recommend not using Auto End-Of-Interrupt feature
  */
-#define HV_X64_DEPRECATING_AEOI_RECOMMENDED	(1 << 9)
+#define HV_DEPRECATING_AEOI_RECOMMENDED		(1 << 9)
 
 /* Recommend using the newer ExProcessorMasks interface */
 #define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED	(1 << 11)
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 8a49b7ef7b76..ad12733f6058 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -50,7 +50,7 @@ __visible void __irq_entry hyperv_vector_handler(struct pt_regs *regs)
 	if (vmbus_handler)
 		vmbus_handler();
 
-	if (ms_hyperv.hints & HV_X64_DEPRECATING_AEOI_RECOMMENDED)
+	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
 		ack_APIC_irq();
 
 	exiting_irq();
@@ -300,7 +300,7 @@ static void __init ms_hyperv_init_platform(void)
 				hyperv_reenlightenment_vector);
 
 	/* Setup the IDT for stimer0 */
-	if (ms_hyperv.misc_features & HV_X64_STIMER_DIRECT_MODE_AVAILABLE)
+	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
 		alloc_intr_gate(HYPERV_STIMER0_VECTOR,
 				hv_stimer0_callback_vector);
 #endif
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 96c403a07906..c72e8d7bd7fc 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -64,7 +64,7 @@ int hv_init(void)
 		return -ENOMEM;
 
 	direct_mode_enabled = ms_hyperv.misc_features &
-			HV_X64_STIMER_DIRECT_MODE_AVAILABLE;
+			HV_STIMER_DIRECT_MODE_AVAILABLE;
 	return 0;
 }
 
@@ -302,7 +302,7 @@ int hv_synic_init(unsigned int cpu)
 
 	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
 	shared_sint.masked = false;
-	if (ms_hyperv.hints & HV_X64_DEPRECATING_AEOI_RECOMMENDED)
+	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
 		shared_sint.auto_eoi = false;
 	else
 		shared_sint.auto_eoi = true;
@@ -320,7 +320,7 @@ int hv_synic_init(unsigned int cpu)
 	/*
 	 * Register the per-cpu clockevent source.
 	 */
-	if (ms_hyperv.features & HV_X64_MSR_SYNTIMER_AVAILABLE)
+	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE)
 		clockevents_config_and_register(hv_cpu->clk_evt,
 						HV_TIMER_FREQUENCY,
 						HV_MIN_DELTA_TICKS,
@@ -335,7 +335,7 @@ void hv_synic_clockevents_cleanup(void)
 {
 	int cpu;
 
-	if (!(ms_hyperv.features & HV_X64_MSR_SYNTIMER_AVAILABLE))
+	if (!(ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE))
 		return;
 
 	if (direct_mode_enabled)
@@ -394,7 +394,7 @@ int hv_synic_cleanup(unsigned int cpu)
 		return -EBUSY;
 
 	/* Turn off clockevent device */
-	if (ms_hyperv.features & HV_X64_MSR_SYNTIMER_AVAILABLE) {
+	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
 		struct hv_per_cpu_context *hv_cpu
 			= this_cpu_ptr(hv_context.cpu_context);
 
-- 
2.17.1
