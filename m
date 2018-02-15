Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226f6cUPBgCILv02jjUMRG1JlysM12Uo1HVHWj5HdBNv6OLrIFJNjy4Wrj8tjMjgQBqdLQqq
ARC-Seal: i=1; a=rsa-sha256; t=1518709291; cv=none;
        d=google.com; s=arc-20160816;
        b=xKjzQg8VK8O/21OxE1q5rfs0RBT+VGDikXRUNDeB8EhkkJMki/ITUDtiXUxwAgJqSG
         KDjk1p51qQ51DWHN8B7JpZO2q6ZrthRFyVEoha89GgVGx8Wla14/mb9bU0hR0GmPPlSB
         qqHnpLVIsZtPZ6yc/BCZmPreRuCbuIOT8B9nE9yIwErsAukM1Iobl9UkNeKijNlJlVjP
         o32Zktrn6Md1rdb6bEAUeIOs0UUvVqWKvT3jOxPtiF6ubvRpfxmlyzhpREHihJiEKMrj
         hPdDlRElJgdVoB0ZjTEM/MTU/DFq0xRQg7MUPNyzA+IwVDtleUYeKianuqa+XR+DIy/Y
         bxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NNWGVpSD7BW7+CmsokL9uxojwFefVIEYgTwqqQSQ+NY=;
        b=jrPHKFyruGOrNU7/hg76rjBgxWQYZK1mdPJ+6MeLkKCwtzSihsi48PG4aZNHkbuA3q
         FKm6G+cUahH9k4odTju55y2Wu+G07leW335mpyQs7WjJ26E8tIELV/KACiY11gn2Bf/s
         /AIwM6Jx1YuC7ciSSVwO5zjtSsw+jhWXld9q0e7IqGA1iPn7pD5ZjxFAIORfBTl1ffCA
         PvCzGFZsceeGO0kA6Gl6K/9LVgk7MBM3rPyXpr7kU8EO2c7FkQD1jgcXLfIlRmygQmz7
         aprUPadE+mc4kQJhlnTwhg5Tj9Cw0MbmUDXekkPY3wSz8JqG3CjVqt4nieoyU1gV5Qzj
         +aow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 065/202] [Variant 2/Spectre-v2] arm64: KVM: Use per-CPU vector when BP hardening is enabled
Date: Thu, 15 Feb 2018 16:16:05 +0100
Message-Id: <20180215151716.856841630@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481562742963731?=
X-GMAIL-MSGID: =?utf-8?q?1592482114275321484?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 6840bdd73d07 upstream.

Now that we have per-CPU vectors, let's plug then in the KVM/arm64 code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Conflicts:
	arch/arm/include/asm/kvm_mmu.h
	arch/arm64/include/asm/kvm_mmu.h
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/kvm_mmu.h   |   10 ++++++++++
 arch/arm64/include/asm/kvm_mmu.h |   38 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/switch.c      |    2 +-
 virt/kvm/arm/arm.c               |    8 +++++++-
 4 files changed, 56 insertions(+), 2 deletions(-)

--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -221,6 +221,16 @@ static inline unsigned int kvm_get_vmid_
 	return 8;
 }
 
+static inline void *kvm_get_hyp_vector(void)
+{
+	return kvm_ksym_ref(__kvm_hyp_vector);
+}
+
+static inline int kvm_map_vectors(void)
+{
+	return 0;
+}
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* __ARM_KVM_MMU_H__ */
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -309,5 +309,43 @@ static inline unsigned int kvm_get_vmid_
 	return (cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR1_VMIDBITS_SHIFT) == 2) ? 16 : 8;
 }
 
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+#include <asm/mmu.h>
+
+static inline void *kvm_get_hyp_vector(void)
+{
+	struct bp_hardening_data *data = arm64_get_bp_hardening_data();
+	void *vect = kvm_ksym_ref(__kvm_hyp_vector);
+
+	if (data->fn) {
+		vect = __bp_harden_hyp_vecs_start +
+		       data->hyp_vectors_slot * SZ_2K;
+
+		if (!has_vhe())
+			vect = lm_alias(vect);
+	}
+
+	return vect;
+}
+
+static inline int kvm_map_vectors(void)
+{
+	return create_hyp_mappings(kvm_ksym_ref(__bp_harden_hyp_vecs_start),
+				   kvm_ksym_ref(__bp_harden_hyp_vecs_end),
+				   PAGE_HYP_EXEC);
+}
+
+#else
+static inline void *kvm_get_hyp_vector(void)
+{
+	return kvm_ksym_ref(__kvm_hyp_vector);
+}
+
+static inline int kvm_map_vectors(void)
+{
+	return 0;
+}
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -52,7 +52,7 @@ static void __hyp_text __activate_traps_
 	val &= ~(CPACR_EL1_FPEN | CPACR_EL1_ZEN);
 	write_sysreg(val, cpacr_el1);
 
-	write_sysreg(__kvm_hyp_vector, vbar_el1);
+	write_sysreg(kvm_get_hyp_vector(), vbar_el1);
 }
 
 static void __hyp_text __activate_traps_nvhe(void)
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1158,7 +1158,7 @@ static void cpu_init_hyp_mode(void *dumm
 	pgd_ptr = kvm_mmu_get_httbr();
 	stack_page = __this_cpu_read(kvm_arm_hyp_stack_page);
 	hyp_stack_ptr = stack_page + PAGE_SIZE;
-	vector_ptr = (unsigned long)kvm_ksym_ref(__kvm_hyp_vector);
+	vector_ptr = (unsigned long)kvm_get_hyp_vector();
 
 	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
 	__cpu_init_stage2();
@@ -1403,6 +1403,12 @@ static int init_hyp_mode(void)
 		goto out_err;
 	}
 
+	err = kvm_map_vectors();
+	if (err) {
+		kvm_err("Cannot map vectors\n");
+		goto out_err;
+	}
+
 	/*
 	 * Map the Hyp stack pages
 	 */
