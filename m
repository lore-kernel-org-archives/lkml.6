Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeESL3a (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:29:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41687 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752174AbeESL31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:29:27 -0400
Date: Sat, 19 May 2018 04:29:20 -0700
From: "tip-bot for K. Y. Srinivasan" <tipbot@zytor.com>
Message-ID: <tip-800b8f03fdc8d66885ff03de531285526a4ca0d4@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mikelley@microsoft.com, mingo@kernel.org,
        kys@microsoft.com, hpa@zytor.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        kys@microsoft.com
In-Reply-To: <20180516215334.6547-4-kys@linuxonhyperv.com>
References: <20180516215334.6547-4-kys@linuxonhyperv.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] X86/Hyper-V: Consolidate code for converting
 cpumask to vpset
Git-Commit-ID: 800b8f03fdc8d66885ff03de531285526a4ca0d4
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

Commit-ID:  800b8f03fdc8d66885ff03de531285526a4ca0d4
Gitweb:     https://git.kernel.org/tip/800b8f03fdc8d66885ff03de531285526a4ca0d4
Author:     K. Y. Srinivasan <kys@microsoft.com>
AuthorDate: Wed, 16 May 2018 14:53:33 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 19 May 2018 13:23:18 +0200

X86/Hyper-V: Consolidate code for converting cpumask to vpset

Consolidate code for converting cpumask to vpset.

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
Link: https://lkml.kernel.org/r/20180516215334.6547-4-kys@linuxonhyperv.com

---
 arch/x86/hyperv/mmu.c | 43 ++-----------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index adee39a7a3f2..c9cd28f0bae4 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -25,11 +25,7 @@ struct hv_flush_pcpu {
 struct hv_flush_pcpu_ex {
 	u64 address_space;
 	u64 flags;
-	struct {
-		u64 format;
-		u64 valid_bank_mask;
-		u64 bank_contents[];
-	} hv_vp_set;
+	struct hv_vpset hv_vp_set;
 	u64 gva_list[];
 };
 
@@ -70,41 +66,6 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 	return gva_n - offset;
 }
 
-/* Return the number of banks in the resulting vp_set */
-static inline int cpumask_to_vp_set(struct hv_flush_pcpu_ex *flush,
-				    const struct cpumask *cpus)
-{
-	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
-
-	/* valid_bank_mask can represent up to 64 banks */
-	if (hv_max_vp_index / 64 >= 64)
-		return 0;
-
-	/*
-	 * Clear all banks up to the maximum possible bank as hv_flush_pcpu_ex
-	 * structs are not cleared between calls, we risk flushing unneeded
-	 * vCPUs otherwise.
-	 */
-	for (vcpu_bank = 0; vcpu_bank <= hv_max_vp_index / 64; vcpu_bank++)
-		flush->hv_vp_set.bank_contents[vcpu_bank] = 0;
-
-	/*
-	 * Some banks may end up being empty but this is acceptable.
-	 */
-	for_each_cpu(cpu, cpus) {
-		vcpu = hv_cpu_number_to_vp_number(cpu);
-		vcpu_bank = vcpu / 64;
-		vcpu_offset = vcpu % 64;
-		__set_bit(vcpu_offset, (unsigned long *)
-			  &flush->hv_vp_set.bank_contents[vcpu_bank]);
-		if (vcpu_bank >= nr_bank)
-			nr_bank = vcpu_bank + 1;
-	}
-	flush->hv_vp_set.valid_bank_mask = GENMASK_ULL(nr_bank - 1, 0);
-
-	return nr_bank;
-}
-
 static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 				    const struct flush_tlb_info *info)
 {
@@ -240,7 +201,7 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 
 	if (!cpumask_equal(cpus, cpu_present_mask)) {
 		flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
-		nr_bank = cpumask_to_vp_set(flush, cpus);
+		nr_bank = cpumask_to_vpset(&(flush->hv_vp_set), cpus);
 	}
 
 	if (!nr_bank) {
