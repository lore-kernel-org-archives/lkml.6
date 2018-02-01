Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-69569-1517507577-2-17904558372282236773
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517507576; b=EipdceXsrg9PdgXsoP3D6pAx1O0rHJdUyxjIKSbbBab5ekB
    GcT7VcCtCQTy3kiw9sgT/KZ9LRE78a7eblkFf4a4p8KoVFRjBtUv3jUzfYib+jGk
    K9mBwfSEYFuOAgGqVY9uKUaqQ+dbCVxvVij/50Y1E9bYJLNtGo8GlYwWhlsKH8Gl
    x1DqFuUpxtxex9ea3K3MgTpX5Nj0L8wSn6TxEvMTYKiMetBRCAns1MPijROK1ejB
    mKR5PtfB0jCVkro7YcZzCEhNsOqvJEYQFUCAnWUi5hf8NV9pfl7uAEYR+hdyYPuE
    MZ20mnx8eaTJZWoI7GOAhg8E96KAuGgscwXrJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1517507576; bh=orTdt3p1JxSrG8339uyZtoHYrE
    SVsdIt2h3VKNNuXRo=; b=MOZ32wtmmiZkX0KQVW0nmnYNHqH39ElKKZRQOb7efN
    DRWDEnptlE0p4XOPcusJtTb3zBeIc55OC0zW4pZH4fU8kOhmgyy16DSW4ni+Z4rV
    vJGCHS7ZKSrJtVvxjyM+OQ0T498A83hpHMaPRj2NHcRanyJBNyJiCzaUKxa331sM
    XD+VMzJwhLT58B/JjJTf6q1L/GREskv6Koen787neFBZg6c3HmT/kQZ49khCiwvp
    Fa1k4UgF48+HUW8YWyfrxEWnK42igMGriZkNnRAQS9GUDWjxSafAPSulWOVXHNlc
    JX41znpqAOPI1bGSUJofLv4nUBP3CDMTrP0fxtMlMehg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeBARwx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 12:52:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751913AbeBARww (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Feb 2018 12:52:52 -0500
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, stable@vger.kernel.org
Subject: [PATCH] KVM: x86: fix backward migration with async_PF
Date: Thu,  1 Feb 2018 18:50:22 +0100
Message-Id: <20180201175022.25011-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Guests on new hypersiors might set KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT
bit when enabling async_PF, but this bit is reserved on old hypervisors,
which results in a failure upon migration.

Guests at least expect that KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT might not
be present when booting, so we allow userspace to handle migration
compatibility by adding a KVM CPUID flag that determines the presence of
KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT.

Fixes: 52a5c155cf79 ("KVM: async_pf: Let guest support delivery of async_pf from guest mode")
Cc: <stable@vger.kernel.org>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
---
 arch/x86/include/uapi/asm/kvm_para.h |  1 +
 arch/x86/kernel/kvm.c                |  8 ++++----
 arch/x86/kvm/cpuid.c                 |  3 ++-
 arch/x86/kvm/cpuid.h                 | 11 +++++++++++
 arch/x86/kvm/x86.c                   |  6 ++++--
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 7a2ade4aa235..6cfa9c8cb7d6 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -26,6 +26,7 @@
 #define KVM_FEATURE_PV_EOI		6
 #define KVM_FEATURE_PV_UNHALT		7
 #define KVM_FEATURE_PV_TLB_FLUSH	9
+#define KVM_FEATURE_ASYNC_PF_VMEXIT	10
 
 /* The last 8 bits are used to indicate how to interpret the flags field
  * in pvclock structure. If no bits are set, all flags are ignored.
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 4e37d1a851a6..971babe964d2 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -341,10 +341,10 @@ static void kvm_guest_cpu_init(void)
 #endif
 		pa |= KVM_ASYNC_PF_ENABLED;
 
-		/* Async page fault support for L1 hypervisor is optional */
-		if (wrmsr_safe(MSR_KVM_ASYNC_PF_EN,
-			(pa | KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT) & 0xffffffff, pa >> 32) < 0)
-			wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
+		if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_VMEXIT))
+			pa |= KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
+
+		wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
 		__this_cpu_write(apf_reason.enabled, 1);
 		printk(KERN_INFO"KVM setup async PF for cpu %d\n",
 		       smp_processor_id());
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 20e491b94f44..7fc04a176c57 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -604,7 +604,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			     (1 << KVM_FEATURE_PV_EOI) |
 			     (1 << KVM_FEATURE_CLOCKSOURCE_STABLE_BIT) |
 			     (1 << KVM_FEATURE_PV_UNHALT) |
-			     (1 << KVM_FEATURE_PV_TLB_FLUSH);
+			     (1 << KVM_FEATURE_PV_TLB_FLUSH) |
+			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT);
 
 		if (sched_info_on())
 			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index c2cea6651279..f20731dfe28e 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -105,6 +105,17 @@ static __always_inline bool guest_cpuid_has(struct kvm_vcpu *vcpu, unsigned x86_
 	return *reg & bit(x86_feature);
 }
 
+static inline bool guest_kvm_cpuid_has(struct kvm_vcpu *vcpu, unsigned kvm_feature)
+{
+	struct kvm_cpuid_entry2 *entry;
+
+	entry = kvm_find_cpuid_entry(vcpu, KVM_CPUID_FEATURES, 0);
+	if (!entry)
+		return false;
+
+	return entry->eax & bit(kvm_feature);
+}
+
 static __always_inline void guest_cpuid_clear(struct kvm_vcpu *vcpu, unsigned x86_feature)
 {
 	int *reg;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4c3103f449a3..c16740a06f0c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2139,8 +2139,10 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
 {
 	gpa_t gpa = data & ~0x3f;
 
-	/* Bits 3:5 are reserved, Should be zero */
-	if (data & 0x38)
+	/* Bits 3:5 are reserved, Should be zero. */
+	if (data & 0x38 ||
+	    (data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT &&
+	     !guest_kvm_cpuid_has(vcpu, KVM_FEATURE_ASYNC_PF_VMEXIT)))
 		return 1;
 
 	vcpu->arch.apf.msr_val = data;
-- 
2.15.1
