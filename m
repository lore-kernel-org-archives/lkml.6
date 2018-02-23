Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeBWWnO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 17:43:14 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36183 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbeBWWnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 17:43:08 -0500
X-Google-Smtp-Source: AG47ELvM2h6/KKsYaky7ND/0gkUyE/QhjlW0SG2VPn7PeeK8q6+oP8DUAWEhOgnQHL8NHLed9OrsMw==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: liran.alon@oracle.com
Subject: [PATCH] KVM: x86: move LAPIC initialization after VMCS creation
Date: Fri, 23 Feb 2018 23:43:02 +0100
Message-Id: <1519425782-44820-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial reset of the local APIC is performed before the VMCS has been
created, but it tries to do a vmwrite:

 vmwrite error: reg 810 value 4a00 (err 18944)
 CPU: 54 PID: 38652 Comm: qemu-kvm Tainted: G        W I      4.16.0-0.rc2.git0.1.fc28.x86_64 #1
 Hardware name: Intel Corporation S2600CW/S2600CW, BIOS SE5C610.86B.01.01.0003.090520141303 09/05/2014
 Call Trace:
  vmx_set_rvi [kvm_intel]
  vmx_hwapic_irr_update [kvm_intel]
  kvm_lapic_reset [kvm]
  kvm_create_lapic [kvm]
  kvm_arch_vcpu_init [kvm]
  kvm_vcpu_init [kvm]
  vmx_create_vcpu [kvm_intel]
  kvm_vm_ioctl [kvm]

Move it later, after the VMCS has been created.

Fixes: 851c1a18c5412fd321e387cfe60739387cdbf37d
Cc: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/lapic.c | 1 -
 arch/x86/kvm/x86.c   | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 924ac8ce9d50..cc5fe7a50dde 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2165,7 +2165,6 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
 	 */
 	vcpu->arch.apic_base = MSR_IA32_APICBASE_ENABLE;
 	static_key_slow_inc(&apic_sw_disabled.key); /* sw disabled at reset */
-	kvm_lapic_reset(vcpu, false);
 	kvm_iodevice_init(&apic->dev, &apic_mmio_ops);
 
 	return 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c8a0b545ac20..ca90d9515137 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7975,6 +7975,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	kvm_vcpu_mtrr_init(vcpu);
 	vcpu_load(vcpu);
 	kvm_vcpu_reset(vcpu, false);
+	kvm_lapic_reset(vcpu, false);
 	kvm_mmu_setup(vcpu);
 	vcpu_put(vcpu);
 	return 0;
-- 
1.8.3.1
