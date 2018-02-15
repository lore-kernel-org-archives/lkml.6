Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2242lf/J5WVzOHeOVkYWJQJCJImFK16Kw0OPnOJOOX1i+rec3N0sKe/dxVb/IZTJlutfT4g8
ARC-Seal: i=1; a=rsa-sha256; t=1518708765; cv=none;
        d=google.com; s=arc-20160816;
        b=IA7OubQeTa06a5lPodnm9HnNJwDi3zdm9eQXlgN8MFeHoAU1Sr+mOgOGJGl0FoJBTS
         30TcfK92heHWRzaZMqEUxm1QzBPcTyC7RIPeCvTYbuNXt3SkRjIemitlCgGhWF3FS9o6
         mRsP/g30VZU43ZMDcabXWGqcrt52GbVrehu5Y80oby8/0ugzshf+ltq094HDnT+fd2eq
         zIhc20unDsr4t7ZbX7+mt7hOxFMVUq+DZvByS4u0x5UIqC44t3Cqcr8AwvDcQL4kLdKH
         JPAvI2kdnX4ZfFebanp750Tq5d/yswmmYqFrkbggbftjQq/oVvRgGPgZDnLitn4zevFZ
         NnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Qk68ZDTrBLkcDJWMv0t6hkI/x/X2LkQKlawd73CuUyQ=;
        b=pY/lAGvnuRgPJYkF5vjpI/v9J/sEvBMmjP2I+cAhNPgDO8xtkVWf/TVl7PswONtuP6
         X8MdHQL4sSqxY7Z+n3aLPpliHQjEgF2EvHxyZSfgwWSBLOmsVcpWHNJme1BifHhG4mxF
         9z6kO3D0keufVXPGtFu7WngwZ0o8+ZssRYOeJ57c5xhD3vtxjZ1G1JYusLFSNl934NaB
         ltriTk0USLplRqlbtuxIafzCcjCSS0+mui8OE0Yp7omKtAzQf0OlV5y0wFWlLHFeWTyV
         xG3wAIAGNhsZKVZHdQem4jEOIOq5Nj+CT0hrr5PRk9NgUMZWAvJP0cfgrUECGh/YFPhT
         HOTQ==
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 072/195] [Variant 2/Spectre-v2] arm64: KVM: Use per-CPU vector when BP hardening is enabled
Date: Thu, 15 Feb 2018 16:16:03 +0100
Message-Id: <20180215151709.301843339@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481562742963731?=
X-GMAIL-MSGID: =?utf-8?q?1592481562742963731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 6840bdd73d07 upstream.

Now that we have per-CPU vectors, let's plug then in the KVM/arm64 code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
@@ -51,7 +51,7 @@ static void __hyp_text __activate_traps_
 	val &= ~CPACR_EL1_FPEN;
 	write_sysreg(val, cpacr_el1);
 
-	write_sysreg(__kvm_hyp_vector, vbar_el1);
+	write_sysreg(kvm_get_hyp_vector(), vbar_el1);
 }
 
 static void __hyp_text __activate_traps_nvhe(void)
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1139,7 +1139,7 @@ static void cpu_init_hyp_mode(void *dumm
 	pgd_ptr = kvm_mmu_get_httbr();
 	stack_page = __this_cpu_read(kvm_arm_hyp_stack_page);
 	hyp_stack_ptr = stack_page + PAGE_SIZE;
-	vector_ptr = (unsigned long)kvm_ksym_ref(__kvm_hyp_vector);
+	vector_ptr = (unsigned long)kvm_get_hyp_vector();
 
 	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
 	__cpu_init_stage2();
@@ -1384,6 +1384,12 @@ static int init_hyp_mode(void)
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
