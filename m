Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeDQFrD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 01:47:03 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35304 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbeDQFq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 01:46:56 -0400
X-Google-Smtp-Source: AIpwx48U6yIlbXdpXW05KZvu9nhddDL4Yspv8pnTDz2gfg3ilM1N0RTti2vZNk5FeZ9iScnbK952mw==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH 1/3] KVM: VMX: Introduce per-VM I/O permission bitmaps
Date: Mon, 16 Apr 2018 22:46:00 -0700
Message-Id: <1523943962-25415-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

This patch introduces per-VM I/O permission bitmaps, it will be used by 
later patches.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Tim Shearer <tshearer@advaoptical.com>
Cc: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/vmx.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 5b49ad4..ebf1140 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -189,12 +189,19 @@ module_param(ple_window_max, uint, 0444);
 
 extern const ulong vmx_return;
 
+enum {
+	VMX_IO_BITMAP_A,
+	VMX_IO_BITMAP_B,
+	VMX_IO_BITMAP_NR
+};
+
 struct kvm_vmx {
 	struct kvm kvm;
 
 	unsigned int tss_addr;
 	bool ept_identity_pagetable_done;
 	gpa_t ept_identity_map_addr;
+	unsigned long *vmx_io_bitmap[VMX_IO_BITMAP_NR];
 };
 
 #define NR_AUTOLOAD_MSRS 8
@@ -3963,7 +3970,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
 #endif
 	      CPU_BASED_CR3_LOAD_EXITING |
 	      CPU_BASED_CR3_STORE_EXITING |
-	      CPU_BASED_UNCOND_IO_EXITING |
+	      CPU_BASED_USE_IO_BITMAPS |
 	      CPU_BASED_MOV_DR_EXITING |
 	      CPU_BASED_USE_TSC_OFFSETING |
 	      CPU_BASED_MWAIT_EXITING |
@@ -5940,6 +5947,12 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 #endif
 	int i;
 
+	/* I/O */
+	vmcs_write64(IO_BITMAP_A,
+		__pa(to_kvm_vmx(vmx->vcpu.kvm)->vmx_io_bitmap[VMX_IO_BITMAP_A]));
+	vmcs_write64(IO_BITMAP_B,
+		__pa(to_kvm_vmx(vmx->vcpu.kvm)->vmx_io_bitmap[VMX_IO_BITMAP_B]));
+
 	if (enable_shadow_vmcs) {
 		vmcs_write64(VMREAD_BITMAP, __pa(vmx_vmread_bitmap));
 		vmcs_write64(VMWRITE_BITMAP, __pa(vmx_vmwrite_bitmap));
@@ -10093,9 +10106,24 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 
 static int vmx_vm_init(struct kvm *kvm)
 {
+	int i;
+	struct kvm_vmx *kvm_vmx = to_kvm_vmx(kvm);
+
 	if (!ple_gap)
 		kvm->arch.pause_in_guest = true;
+
+	for (i = 0; i < VMX_IO_BITMAP_NR; i++) {
+		kvm_vmx->vmx_io_bitmap[i] = (unsigned long *)__get_free_page(GFP_KERNEL);
+		if (!kvm_vmx->vmx_io_bitmap[i])
+			goto out;
+		memset(kvm_vmx->vmx_io_bitmap[i], 0xff, PAGE_SIZE);
+	}
 	return 0;
+
+out:
+	for (i = 0; i < VMX_IO_BITMAP_NR; i++)
+		free_page((unsigned long)kvm_vmx->vmx_io_bitmap[i]);
+	return -ENOMEM;
 }
 
 static void __init vmx_check_processor_compat(void *rtn)
@@ -11128,8 +11156,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	}
 
 	/*
-	 * A vmexit (to either L1 hypervisor or L0 userspace) is always needed
-	 * for I/O port accesses.
+	 * Merging of IO bitmap not currently supported.
+	 * Rather, exit every time.
 	 */
 	exec_control &= ~CPU_BASED_USE_IO_BITMAPS;
 	exec_control |= CPU_BASED_UNCOND_IO_EXITING;
-- 
2.7.4
