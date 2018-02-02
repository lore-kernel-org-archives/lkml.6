Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2249nfj89BiX4N2kAVxQNKc6sjyoCmjRi/zcdWS8x41WCsYIuOjPVxqoL1Z62TTR8SQQNxav
ARC-Seal: i=1; a=rsa-sha256; t=1517591322; cv=none;
        d=google.com; s=arc-20160816;
        b=rMGZxGXqBBelnbtvp5I+x7ohgRNcfhqh/+BW0pkWCrYP/e9Gl3c6bhOdJtXy9CYCvs
         sd4gI91z2mCtD5nF1IqAPCxExwTYJ3tCqk74jkgAFR6ULDDCFV4WelFVcC8v/b4f7KfG
         Slt9fIwpXk6RVDM4RP8JrNpZ69boocdBwvhnaxDGJ9XR3NkjfMpsIbX/oFvQyzT1RXXq
         PeuImSCXBFhcX4XvWUK7G7D23a4dOCM+nb6SXcNU+OxaW/AAQS4cLCpg8HCPCkReF74k
         KszGhopr4NdxSUsktUL54Or9pqUKxxT9lvHqTR6cZF94JkoILHvI7zFCNuGs0DFQBprP
         wk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LYElnqIhbnkFLENAlyySc5uPpaaLJOGnAMNClaCm+uE=;
        b=Dlb3whDapvdI0hcRnK36ihJ9S3O+AdNN42/a8HpIN4jKadx0wbMu0fNDCgxxM1EJ4f
         TJg7dIfKR2tUoxiea109DzBY9Y519X3uT0SVeJGHbBu8Jmibk/DHm9QHEphaIn9sQR+J
         Zq8PKiDGufm0dcovuEEfCOsZZjFGe/sx0KdX4+u6new09PcWcqDXogFzRlPe2QbV7xtb
         7GlDm4FaVoyHWM/SdFDtDeg7o4rTkuw98zWcEaRDekYvAYPhgSiNEGkheql0lu40GxZb
         7R4dFkaPFDg9WTaYb/jVkxerI0lUqU+UyOLrM+DYi3gnTqst8C3n48U3wC8uSfF1RiQj
         NT6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Krish Sadhukhan <krish.sadhukhan@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 040/156] KVM: nVMX: Fix mmu context after VMLAUNCH/VMRESUME failure
Date: Fri,  2 Feb 2018 17:57:01 +0100
Message-Id: <20180202140842.100581637@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309838996422969?=
X-GMAIL-MSGID: =?utf-8?q?1591309838996422969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <wanpeng.li@hotmail.com>


[ Upstream commit 5af4157388adad82c339e3742fb6b67840721347 ]

Commit 4f350c6dbcb (kvm: nVMX: Handle deferred early VMLAUNCH/VMRESUME failure
properly) can result in L1(run kvm-unit-tests/run_tests.sh vmx_controls in L1)
null pointer deference and also L0 calltrace when EPT=0 on both L0 and L1.

In L1:

BUG: unable to handle kernel paging request at ffffffffc015bf8f
 IP: vmx_vcpu_run+0x202/0x510 [kvm_intel]
 PGD 146e13067 P4D 146e13067 PUD 146e15067 PMD 3d2686067 PTE 3d4af9161
 Oops: 0003 [#1] PREEMPT SMP
 CPU: 2 PID: 1798 Comm: qemu-system-x86 Not tainted 4.14.0-rc4+ #6
 RIP: 0010:vmx_vcpu_run+0x202/0x510 [kvm_intel]
 Call Trace:
 WARNING: kernel stack frame pointer at ffffb86f4988bc18 in qemu-system-x86:1798 has bad value 0000000000000002

In L0:

-----------[ cut here ]------------
 WARNING: CPU: 6 PID: 4460 at /home/kernel/linux/arch/x86/kvm//vmx.c:9845 vmx_inject_page_fault_nested+0x130/0x140 [kvm_intel]
 CPU: 6 PID: 4460 Comm: qemu-system-x86 Tainted: G           OE   4.14.0-rc7+ #25
 RIP: 0010:vmx_inject_page_fault_nested+0x130/0x140 [kvm_intel]
 Call Trace:
  paging64_page_fault+0x500/0xde0 [kvm]
  ? paging32_gva_to_gpa_nested+0x120/0x120 [kvm]
  ? nonpaging_page_fault+0x3b0/0x3b0 [kvm]
  ? __asan_storeN+0x12/0x20
  ? paging64_gva_to_gpa+0xb0/0x120 [kvm]
  ? paging64_walk_addr_generic+0x11a0/0x11a0 [kvm]
  ? lock_acquire+0x2c0/0x2c0
  ? vmx_read_guest_seg_ar+0x97/0x100 [kvm_intel]
  ? vmx_get_segment+0x2a6/0x310 [kvm_intel]
  ? sched_clock+0x1f/0x30
  ? check_chain_key+0x137/0x1e0
  ? __lock_acquire+0x83c/0x2420
  ? kvm_multiple_exception+0xf2/0x220 [kvm]
  ? debug_check_no_locks_freed+0x240/0x240
  ? debug_smp_processor_id+0x17/0x20
  ? __lock_is_held+0x9e/0x100
  kvm_mmu_page_fault+0x90/0x180 [kvm]
  kvm_handle_page_fault+0x15c/0x310 [kvm]
  ? __lock_is_held+0x9e/0x100
  handle_exception+0x3c7/0x4d0 [kvm_intel]
  vmx_handle_exit+0x103/0x1010 [kvm_intel]
  ? kvm_arch_vcpu_ioctl_run+0x1628/0x2e20 [kvm]

The commit avoids to load host state of vmcs12 as vmcs01's guest state
since vmcs12 is not modified (except for the VM-instruction error field)
if the checking of vmcs control area fails. However, the mmu context is
switched to nested mmu in prepare_vmcs02() and it will not be reloaded
since load_vmcs12_host_state() is skipped when nested VMLAUNCH/VMRESUME
fails. This patch fixes it by reloading mmu context when nested
VMLAUNCH/VMRESUME fails.

Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11339,6 +11339,24 @@ static void prepare_vmcs12(struct kvm_vc
 	kvm_clear_interrupt_queue(vcpu);
 }
 
+static void load_vmcs12_mmu_host_state(struct kvm_vcpu *vcpu,
+			struct vmcs12 *vmcs12)
+{
+	u32 entry_failure_code;
+
+	nested_ept_uninit_mmu_context(vcpu);
+
+	/*
+	 * Only PDPTE load can fail as the value of cr3 was checked on entry and
+	 * couldn't have changed.
+	 */
+	if (nested_vmx_load_cr3(vcpu, vmcs12->host_cr3, false, &entry_failure_code))
+		nested_vmx_abort(vcpu, VMX_ABORT_LOAD_HOST_PDPTE_FAIL);
+
+	if (!enable_ept)
+		vcpu->arch.walk_mmu->inject_page_fault = kvm_inject_page_fault;
+}
+
 /*
  * A part of what we need to when the nested L2 guest exits and we want to
  * run its L1 parent, is to reset L1's guest state to the host state specified
@@ -11352,7 +11370,6 @@ static void load_vmcs12_host_state(struc
 				   struct vmcs12 *vmcs12)
 {
 	struct kvm_segment seg;
-	u32 entry_failure_code;
 
 	if (vmcs12->vm_exit_controls & VM_EXIT_LOAD_IA32_EFER)
 		vcpu->arch.efer = vmcs12->host_ia32_efer;
@@ -11379,17 +11396,7 @@ static void load_vmcs12_host_state(struc
 	vcpu->arch.cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
 	vmx_set_cr4(vcpu, vmcs12->host_cr4);
 
-	nested_ept_uninit_mmu_context(vcpu);
-
-	/*
-	 * Only PDPTE load can fail as the value of cr3 was checked on entry and
-	 * couldn't have changed.
-	 */
-	if (nested_vmx_load_cr3(vcpu, vmcs12->host_cr3, false, &entry_failure_code))
-		nested_vmx_abort(vcpu, VMX_ABORT_LOAD_HOST_PDPTE_FAIL);
-
-	if (!enable_ept)
-		vcpu->arch.walk_mmu->inject_page_fault = kvm_inject_page_fault;
+	load_vmcs12_mmu_host_state(vcpu, vmcs12);
 
 	if (enable_vpid) {
 		/*
@@ -11615,6 +11622,9 @@ static void nested_vmx_vmexit(struct kvm
 	 * accordingly.
 	 */
 	nested_vmx_failValid(vcpu, VMXERR_ENTRY_INVALID_CONTROL_FIELD);
+
+	load_vmcs12_mmu_host_state(vcpu, vmcs12);
+
 	/*
 	 * The emulated instruction was already skipped in
 	 * nested_vmx_run, but the updated RIP was never
