Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbeBCWws (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 17:52:48 -0500
Received: from terminus.zytor.com ([65.50.211.136]:54837 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbeBCWwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 17:52:41 -0500
Date: Sat, 3 Feb 2018 14:50:27 -0800
From: tip-bot for KarimAllah Ahmed <tipbot@zytor.com>
Message-ID: <tip-b7b27aa011a1df42728d1768fc181d9ce69e6911@git.kernel.org>
Cc: hpa@zytor.com, pbonzini@redhat.com, konrad.wilk@oracle.com,
        jmattson@google.com, dwmw@amazon.co.uk, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, rkrcmar@redhat.com,
        karahmed@amazon.de
Reply-To: karahmed@amazon.de, rkrcmar@redhat.com, mingo@kernel.org,
        jmattson@google.com, pbonzini@redhat.com, konrad.wilk@oracle.com,
        tglx@linutronix.de, dwmw@amazon.co.uk, linux-kernel@vger.kernel.org,
        hpa@zytor.com
In-Reply-To: <1517522386-18410-2-git-send-email-karahmed@amazon.de>
References: <1517522386-18410-2-git-send-email-karahmed@amazon.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] KVM/x86: Update the reverse_cpuid list to include
 CPUID_7_EDX
Git-Commit-ID: b7b27aa011a1df42728d1768fc181d9ce69e6911
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

Commit-ID:  b7b27aa011a1df42728d1768fc181d9ce69e6911
Gitweb:     https://git.kernel.org/tip/b7b27aa011a1df42728d1768fc181d9ce69e6911
Author:     KarimAllah Ahmed <karahmed@amazon.de>
AuthorDate: Thu, 1 Feb 2018 22:59:42 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 3 Feb 2018 23:06:51 +0100

KVM/x86: Update the reverse_cpuid list to include CPUID_7_EDX

[dwmw2: Stop using KF() for bits in it, too]
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Cc: kvm@vger.kernel.org
Cc: Radim Krčmář <rkrcmar@redhat.com>
Link: https://lkml.kernel.org/r/1517522386-18410-2-git-send-email-karahmed@amazon.de

---
 arch/x86/kvm/cpuid.c | 8 +++-----
 arch/x86/kvm/cpuid.h | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0099e10..c0eb337 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -67,9 +67,7 @@ u64 kvm_supported_xcr0(void)
 
 #define F(x) bit(X86_FEATURE_##x)
 
-/* These are scattered features in cpufeatures.h. */
-#define KVM_CPUID_BIT_AVX512_4VNNIW     2
-#define KVM_CPUID_BIT_AVX512_4FMAPS     3
+/* For scattered features from cpufeatures.h; we currently expose none */
 #define KF(x) bit(KVM_CPUID_BIT_##x)
 
 int kvm_update_cpuid(struct kvm_vcpu *vcpu)
@@ -392,7 +390,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		KF(AVX512_4VNNIW) | KF(AVX512_4FMAPS);
+		F(AVX512_4VNNIW) | F(AVX512_4FMAPS);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
@@ -477,7 +475,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			if (!tdp_enabled || !boot_cpu_has(X86_FEATURE_OSPKE))
 				entry->ecx &= ~F(PKU);
 			entry->edx &= kvm_cpuid_7_0_edx_x86_features;
-			entry->edx &= get_scattered_cpuid_leaf(7, 0, CPUID_EDX);
+			cpuid_mask(&entry->edx, CPUID_7_EDX);
 		} else {
 			entry->ebx = 0;
 			entry->ecx = 0;
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index c2cea66..9a327d5 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -54,6 +54,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_8000_000A_EDX] = {0x8000000a, 0, CPUID_EDX},
 	[CPUID_7_ECX]         = {         7, 0, CPUID_ECX},
 	[CPUID_8000_0007_EBX] = {0x80000007, 0, CPUID_EBX},
+	[CPUID_7_EDX]         = {         7, 0, CPUID_EDX},
 };
 
 static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned x86_feature)
