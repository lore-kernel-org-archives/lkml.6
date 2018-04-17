Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/95WvXC0/jiza93etRSjIrJ7CrQQxqm4cUrAsbwSbLo6vd5SS+FbGn9zzMdCwD3KzgPwKD
ARC-Seal: i=1; a=rsa-sha256; t=1523981338; cv=none;
        d=google.com; s=arc-20160816;
        b=Dyjry763dI/Rphuxxb79gQefD9WpwcZ8m8Mrne1n6wf+b13UOItq354FwI0q1MaZmy
         7MROpw/2O6L84FVBA06gmrNsY70ltEODCHYaUHkdfrdNrswDVKw+FetIim9Dnkh+juRl
         bq6IZ7dHTKR+DXe5H7FbGVaflCTDXuFuIpIGOvfDk3gWqFEGyRKYmh0UGdroHzkmvAW1
         3JFDPvfEBBzTvh0Wxe0dYphB70AkwgxFkUJuDLeazFcTw+biK186KnJRkUu2AdYx2k8Z
         yFL50NFBH3NZv9xCvv1xZLG3+5c9SSZmkKaBsRtR2DPGOcND2Zbr11R3L5AsjvWMXVRd
         s88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BooBWPwnE7TV6B5YN7ajZ3GMpEhhv1uPxisHS+BpG5Y=;
        b=Q6R74hLv9kaqgl1+VgUfsKcXuEQVl7jyyzaeuANYD9myEsnMk9bsmDimUPzmLWIUYl
         p1OHqrEYk9uaRdeKHOTxH5WrHjsxTzPdnwPjODqLcTkvacvakbnjjP0MZbzVsQ416PQc
         BA3WS9qPeLhZJc4Ue+b86oshyrlSstlfZJ4dsqjfTqCZ/RgllmAydvNhj59j8H5gLtAl
         q05tHUj8yGgHEYy+qXuhMAsJ9/oeVPyQBO34XAK26UFOrO1pvPOXwxL/VXGvBSVP7vE4
         Jv4DogeRBUL6CFOcQTlluGKZQAmpsELsgtO61vpb2vq7fISSBJmxjCxTd3FBVxAInVrc
         C3gA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 28/66] arm64: KVM: Use per-CPU vector when BP hardening is enabled
Date: Tue, 17 Apr 2018 17:59:01 +0200
Message-Id: <20180417155647.089298589@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010255942627892?=
X-GMAIL-MSGID: =?utf-8?q?1598010255942627892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Marc Zyngier <marc.zyngier@arm.com>

commit 6840bdd73d07216ab4bc46f5a8768c37ea519038 upstream.

Now that we have per-CPU vectors, let's plug then in the KVM/arm64 code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[v4.9: account for files moved to virt/ upstream, use cpus_have_cap()]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/kvm_mmu.h   |   10 ++++++++++
 arch/arm/kvm/arm.c               |    9 ++++++++-
 arch/arm64/include/asm/kvm_mmu.h |   38 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/switch.c      |    2 +-
 4 files changed, 57 insertions(+), 2 deletions(-)

--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -223,6 +223,16 @@ static inline unsigned int kvm_get_vmid_
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
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1088,7 +1088,7 @@ static void cpu_init_hyp_mode(void *dumm
 	pgd_ptr = kvm_mmu_get_httbr();
 	stack_page = __this_cpu_read(kvm_arm_hyp_stack_page);
 	hyp_stack_ptr = stack_page + PAGE_SIZE;
-	vector_ptr = (unsigned long)kvm_ksym_ref(__kvm_hyp_vector);
+	vector_ptr = (unsigned long)kvm_get_hyp_vector();
 
 	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
 	__cpu_init_stage2();
@@ -1345,6 +1345,13 @@ static int init_hyp_mode(void)
 		goto out_err;
 	}
 
+
+	err = kvm_map_vectors();
+	if (err) {
+		kvm_err("Cannot map vectors\n");
+		goto out_err;
+	}
+
 	/*
 	 * Map the Hyp stack pages
 	 */
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -313,5 +313,43 @@ static inline unsigned int kvm_get_vmid_
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
+		if (!cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
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
@@ -50,7 +50,7 @@ static void __hyp_text __activate_traps_
 	val &= ~CPACR_EL1_FPEN;
 	write_sysreg(val, cpacr_el1);
 
-	write_sysreg(__kvm_hyp_vector, vbar_el1);
+	write_sysreg(kvm_get_hyp_vector(), vbar_el1);
 }
 
 static void __hyp_text __activate_traps_nvhe(void)
