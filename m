Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbeEQOy2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:54:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751481AbeEQOy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:54:26 -0400
Date: Thu, 17 May 2018 17:54:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] kvm: rename HINTS_DEDICATED to KVM_HINTS_REALTIME
Message-ID: <1526568841-35372-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HINTS_DEDICATED seems to be somewhat confusing:

Guest doesn't really care whether it's the only task running on a host
CPU as long as it's not preempted.

And there are more reasons for Guest to be preempted than host CPU
sharing, for example, with memory overcommit it can get preempted on a
memory access, post copy migration can cause preemption, etc.

Let's call it KVM_HINTS_REALTIME which seems to better
match what guests expect.

Also, the flag most be set on all vCPUs - current guests assume this.
Note so in the documentation.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/virtual/kvm/cpuid.txt  | 6 +++---
 arch/x86/include/uapi/asm/kvm_para.h | 2 +-
 arch/x86/kernel/kvm.c                | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
index d4f33eb8..ab022dc 100644
--- a/Documentation/virtual/kvm/cpuid.txt
+++ b/Documentation/virtual/kvm/cpuid.txt
@@ -72,8 +72,8 @@ KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
 
 flag                               || value || meaning
 ==================================================================================
-KVM_HINTS_DEDICATED                ||     0 || guest checks this feature bit to
-                                   ||       || determine if there is vCPU pinning
-                                   ||       || and there is no vCPU over-commitment,
+KVM_HINTS_REALTIME                 ||     0 || guest checks this feature bit to
+                                   ||       || determine that vCPUs are never
+                                   ||       || preempted for an unlimited time,
                                    ||       || allowing optimizations
 ----------------------------------------------------------------------------------
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 4c851eb..0ede697 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -29,7 +29,7 @@
 #define KVM_FEATURE_PV_TLB_FLUSH	9
 #define KVM_FEATURE_ASYNC_PF_VMEXIT	10
 
-#define KVM_HINTS_DEDICATED      0
+#define KVM_HINTS_REALTIME      0
 
 /* The last 8 bits are used to indicate how to interpret the flags field
  * in pvclock structure. If no bits are set, all flags are ignored.
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7867417..5b2300b 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -457,7 +457,7 @@ static void __init sev_map_percpu_data(void)
 static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
 {
 	native_smp_prepare_cpus(max_cpus);
-	if (kvm_para_has_hint(KVM_HINTS_DEDICATED))
+	if (kvm_para_has_hint(KVM_HINTS_REALTIME))
 		static_branch_disable(&virt_spin_lock_key);
 }
 
@@ -553,7 +553,7 @@ static void __init kvm_guest_init(void)
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
-	    !kvm_para_has_hint(KVM_HINTS_DEDICATED) &&
+	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
 	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
 		pv_mmu_ops.flush_tlb_others = kvm_flush_tlb_others;
 
@@ -649,7 +649,7 @@ static __init int kvm_setup_pv_tlb_flush(void)
 	int cpu;
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
-	    !kvm_para_has_hint(KVM_HINTS_DEDICATED) &&
+	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
 	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		for_each_possible_cpu(cpu) {
 			zalloc_cpumask_var_node(per_cpu_ptr(&__pv_tlb_mask, cpu),
@@ -745,7 +745,7 @@ void __init kvm_spinlock_init(void)
 	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
 		return;
 
-	if (kvm_para_has_hint(KVM_HINTS_DEDICATED))
+	if (kvm_para_has_hint(KVM_HINTS_REALTIME))
 		return;
 
 	__pv_init_lock_hash();
-- 
MST
