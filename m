Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeBXAwe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 19:52:34 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52427 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752681AbeBXAwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 19:52:31 -0500
X-Google-Smtp-Source: AG47ELvTW8/KuurPOgAEppRVwdeDgY5ccHymi+EW7S5X1QP3WGvo1zVMklxblV+x67TyV3PqfwYZEg==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH] KVM: VMX: expose the host's ARCH_CAPABILITIES MSR to userspace
Date: Sat, 24 Feb 2018 01:52:26 +0100
Message-Id: <1519433546-33879-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new MSR feature framework to expose the ARCH_CAPABILITIES MSR to
userspace.  This way, userspace can access the capabilities even if it
does not have the permissions to read MSRs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx.c | 12 +++++++++++-
 arch/x86/kvm/x86.c |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 130fca0ea1bf..99689061e11e 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3228,7 +3228,17 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
 
 static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 {
-	return 1;
+	switch (msr->index) {
+	case MSR_IA32_ARCH_CAPABILITIES:
+		if (!boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
+			return 1;
+		rdmsrl(msr->index, msr->data);
+		break;
+	default:
+		return 1;
+	}
+
+	return 0;
 }
 
 /*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 54b4ed55945b..e9a8cc9e3b2b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1054,6 +1054,7 @@ bool kvm_rdpmc(struct kvm_vcpu *vcpu)
  * can be used by a hypervisor to validate requested CPU features.
  */
 static u32 msr_based_features[] = {
+	MSR_IA32_ARCH_CAPABILITIES,
 	MSR_F10H_DECFG,
 };
 
-- 
1.8.3.1
