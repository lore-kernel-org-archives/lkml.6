Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeESL3D (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:29:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54617 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbeESL27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:28:59 -0400
Date: Sat, 19 May 2018 04:28:52 -0700
From: "tip-bot for K. Y. Srinivasan" <tipbot@zytor.com>
Message-ID: <tip-366f03b0cf90ef55f063d4a54cf62b0ac9b6da9d@git.kernel.org>
Cc: kys@microsoft.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, mikelley@microsoft.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, mikelley@microsoft.com,
        kys@microsoft.com, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180516215334.6547-3-kys@linuxonhyperv.com>
References: <20180516215334.6547-3-kys@linuxonhyperv.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] X86/Hyper-V: Enhanced IPI enlightenment
Git-Commit-ID: 366f03b0cf90ef55f063d4a54cf62b0ac9b6da9d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  366f03b0cf90ef55f063d4a54cf62b0ac9b6da9d
Gitweb:     https://git.kernel.org/tip/366f03b0cf90ef55f063d4a54cf62b0ac9b6da9d
Author:     K. Y. Srinivasan <kys@microsoft.com>
AuthorDate: Wed, 16 May 2018 14:53:32 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 19 May 2018 13:23:17 +0200

X86/Hyper-V: Enhanced IPI enlightenment

Support enhanced IPI enlightenments (to target more than 64 CPUs).

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: olaf@aepfle.de
Cc: sthemmin@microsoft.com
Cc: gregkh@linuxfoundation.org
Cc: jasowang@redhat.com
Cc: Michael.H.Kelley@microsoft.com
Cc: hpa@zytor.com
Cc: apw@canonical.com
Cc: devel@linuxdriverproject.org
Cc: vkuznets@redhat.com
Link: https://lkml.kernel.org/r/20180516215334.6547-3-kys@linuxonhyperv.com

---
 arch/x86/hyperv/hv_apic.c          | 42 +++++++++++++++++++++++++++++++++++++-
 arch/x86/hyperv/mmu.c              |  2 +-
 arch/x86/include/asm/hyperv-tlfs.h | 15 +++++++++++++-
 arch/x86/include/asm/mshyperv.h    | 33 ++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 3e0de61f1a7c..192b6ad6a361 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -93,6 +93,40 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
 /*
  * IPI implementation on Hyper-V.
  */
+static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
+{
+	struct ipi_arg_ex **arg;
+	struct ipi_arg_ex *ipi_arg;
+	unsigned long flags;
+	int nr_bank = 0;
+	int ret = 1;
+
+	local_irq_save(flags);
+	arg = (struct ipi_arg_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	ipi_arg = *arg;
+	if (unlikely(!ipi_arg))
+		goto ipi_mask_ex_done;
+
+	ipi_arg->vector = vector;
+	ipi_arg->reserved = 0;
+	ipi_arg->vp_set.valid_bank_mask = 0;
+
+	if (!cpumask_equal(mask, cpu_present_mask)) {
+		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
+		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
+	}
+	if (!nr_bank)
+		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
+
+	ret = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
+			      ipi_arg, NULL);
+
+ipi_mask_ex_done:
+	local_irq_restore(flags);
+	return ((ret == 0) ? true : false);
+}
+
 static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	int cur_cpu, vcpu;
@@ -110,6 +144,9 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
 		return false;
 
+	if ((ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
+		return __send_ipi_mask_ex(mask, vector);
+
 	local_irq_save(flags);
 	arg = (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
 
@@ -193,7 +230,10 @@ static void hv_send_ipi_self(int vector)
 void __init hv_apic_init(void)
 {
 	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
-		pr_info("Hyper-V: Using IPI hypercalls\n");
+		if ((ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
+			pr_info("Hyper-V: Using ext hypercalls for IPI\n");
+		else
+			pr_info("Hyper-V: Using IPI hypercalls\n");
 		/*
 		 * Set the IPI entry points.
 		 */
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 56c9ebac946f..adee39a7a3f2 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -239,7 +239,7 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	flush->hv_vp_set.valid_bank_mask = 0;
 
 	if (!cpumask_equal(cpus, cpu_present_mask)) {
-		flush->hv_vp_set.format = HV_GENERIC_SET_SPARCE_4K;
+		flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 		nr_bank = cpumask_to_vp_set(flush, cpus);
 	}
 
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 332e786d4deb..3bfa92c2793c 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -344,6 +344,7 @@ struct hv_tsc_emulation_status {
 #define HVCALL_SEND_IPI				0x000b
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX  0x0013
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX   0x0014
+#define HVCALL_SEND_IPI_EX			0x0015
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
 
@@ -369,7 +370,7 @@ struct hv_tsc_emulation_status {
 #define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
 
 enum HV_GENERIC_SET_FORMAT {
-	HV_GENERIC_SET_SPARCE_4K,
+	HV_GENERIC_SET_SPARSE_4K,
 	HV_GENERIC_SET_ALL,
 };
 
@@ -721,4 +722,16 @@ struct ipi_arg_non_ex {
 	u64 cpu_mask;
 };
 
+struct hv_vpset {
+	u64 format;
+	u64 valid_bank_mask;
+	u64 bank_contents[];
+};
+
+struct ipi_arg_ex {
+	u32 vector;
+	u32 reserved;
+	struct hv_vpset vp_set;
+};
+
 #endif
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 1eff91599c2b..0ee82519957b 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -259,6 +259,39 @@ static inline int hv_cpu_number_to_vp_number(int cpu_number)
 	return hv_vp_index[cpu_number];
 }
 
+static inline int cpumask_to_vpset(struct hv_vpset *vpset,
+				    const struct cpumask *cpus)
+{
+	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
+
+	/* valid_bank_mask can represent up to 64 banks */
+	if (hv_max_vp_index / 64 >= 64)
+		return 0;
+
+	/*
+	 * Clear all banks up to the maximum possible bank as hv_flush_pcpu_ex
+	 * structs are not cleared between calls, we risk flushing unneeded
+	 * vCPUs otherwise.
+	 */
+	for (vcpu_bank = 0; vcpu_bank <= hv_max_vp_index / 64; vcpu_bank++)
+		vpset->bank_contents[vcpu_bank] = 0;
+
+	/*
+	 * Some banks may end up being empty but this is acceptable.
+	 */
+	for_each_cpu(cpu, cpus) {
+		vcpu = hv_cpu_number_to_vp_number(cpu);
+		vcpu_bank = vcpu / 64;
+		vcpu_offset = vcpu % 64;
+		__set_bit(vcpu_offset, (unsigned long *)
+			  &vpset->bank_contents[vcpu_bank]);
+		if (vcpu_bank >= nr_bank)
+			nr_bank = vcpu_bank + 1;
+	}
+	vpset->valid_bank_mask = GENMASK_ULL(nr_bank - 1, 0);
+	return nr_bank;
+}
+
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
 void hyper_alloc_mmu(void);
