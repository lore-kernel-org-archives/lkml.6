Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227bD4rn/vppv/rEFxIb8nJ3aAC5MapDL5y3x7U9YVAwtr3BvxB0oYLHtkWvbRLGdhFjBx0u
ARC-Seal: i=1; a=rsa-sha256; t=1518183839; cv=none;
        d=google.com; s=arc-20160816;
        b=etSPhxCjGPrZ/Db71i60n+TaxYcGmx/RDjjIcX7qOymklDr48Xw5Bqoe+oeFYnPOIx
         9f+RuOhSQv/J5zwO5riRqTWLOLEQ5MxMaum1JPeW0sgQR3CPDxR87N90tpP9FV+We52d
         l38FtxEyWjMUlr+KjaBbSN4IkK5jJAZElXO1Y3qWL2BGVzz6oR1zBuuPxss4kOREyZAd
         19DY0YevJR1dsa9beq5LLAYx+buLtaAsH+Su1c0hWl7s/FvbivFuzgevcoA0ZgCbklQU
         xwHFRupLTcQec3vAZcAj2hmmw+p3IlHOW+Uo5T6yLUgDYsOz0zYJrNkhAlThZTjdu22S
         ke9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u6Zj8wxBZbp0QXclzbgRAUlb1KBlpAsB3+2AqZS87Ek=;
        b=wQtDpnKepPHOsjaFXaz9jAxr/c8A7xVEGvtTtVEf3i/PgWoHkuMbMd+R6MrCthvT2n
         bnpWwHneeF3aHC2IZpg9znQVigxD2/mR0KGRf+7qg3ophx+h7q/4LsGlKAiXchBP0QkP
         Ke1qIg4Xqmzp+y7lTbuuE/MLYs0TvO/CDnrIHQVns8+oba0hn9vpfYfB3KXpB4hIGDFz
         ev1+QJ6HuciTRfMLPE49gcQafHeio4pUhobZdVBG1l6vOyAdv6b/H7tzsEshr9fcb9AC
         bzbkADU9R/HWunmxf4Yjlpc7MFTvofJhdH9WqWX24knDIZ52vBQdw/ndzw8OHGbBdbs+
         LulQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Mark Kanda <mark.kanda@oracle.com>,
	Ameya More <ameya.more@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 79/92] KVM: nVMX: Eliminate vmcs02 pool
Date: Fri,  9 Feb 2018 14:39:48 +0100
Message-Id: <20180209133936.891018935@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591931138070351113?=
X-GMAIL-MSGID: =?utf-8?q?1591931138070351113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>


(cherry picked from commit de3a0021a60635de96aa92713c1a31a96747d72c)

The potential performance advantages of a vmcs02 pool have never been
realized. To simplify the code, eliminate the pool. Instead, a single
vmcs02 is allocated per VCPU when the VCPU enters VMX operation.

Cc: stable@vger.kernel.org       # prereq for Spectre mitigation
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Ameya More <ameya.more@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |  146 ++++++++---------------------------------------------
 1 file changed, 23 insertions(+), 123 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -174,7 +174,6 @@ module_param(ple_window_max, int, S_IRUG
 extern const ulong vmx_return;
 
 #define NR_AUTOLOAD_MSRS 8
-#define VMCS02_POOL_SIZE 1
 
 struct vmcs {
 	u32 revision_id;
@@ -208,7 +207,7 @@ struct shared_msr_entry {
  * stored in guest memory specified by VMPTRLD, but is opaque to the guest,
  * which must access it using VMREAD/VMWRITE/VMCLEAR instructions.
  * More than one of these structures may exist, if L1 runs multiple L2 guests.
- * nested_vmx_run() will use the data here to build a vmcs02: a VMCS for the
+ * nested_vmx_run() will use the data here to build the vmcs02: a VMCS for the
  * underlying hardware which will be used to run L2.
  * This structure is packed to ensure that its layout is identical across
  * machines (necessary for live migration).
@@ -387,13 +386,6 @@ struct __packed vmcs12 {
  */
 #define VMCS12_SIZE 0x1000
 
-/* Used to remember the last vmcs02 used for some recently used vmcs12s */
-struct vmcs02_list {
-	struct list_head list;
-	gpa_t vmptr;
-	struct loaded_vmcs vmcs02;
-};
-
 /*
  * The nested_vmx structure is part of vcpu_vmx, and holds information we need
  * for correct emulation of VMX (i.e., nested VMX) on this vcpu.
@@ -420,15 +412,15 @@ struct nested_vmx {
 	 */
 	bool sync_shadow_vmcs;
 
-	/* vmcs02_list cache of VMCSs recently used to run L2 guests */
-	struct list_head vmcs02_pool;
-	int vmcs02_num;
 	bool change_vmcs01_virtual_x2apic_mode;
 	/* L2 must run next, and mustn't decide to exit to L1. */
 	bool nested_run_pending;
+
+	struct loaded_vmcs vmcs02;
+
 	/*
-	 * Guest pages referred to in vmcs02 with host-physical pointers, so
-	 * we must keep them pinned while L2 runs.
+	 * Guest pages referred to in the vmcs02 with host-physical
+	 * pointers, so we must keep them pinned while L2 runs.
 	 */
 	struct page *apic_access_page;
 	struct page *virtual_apic_page;
@@ -6678,94 +6670,6 @@ static int handle_monitor(struct kvm_vcp
 }
 
 /*
- * To run an L2 guest, we need a vmcs02 based on the L1-specified vmcs12.
- * We could reuse a single VMCS for all the L2 guests, but we also want the
- * option to allocate a separate vmcs02 for each separate loaded vmcs12 - this
- * allows keeping them loaded on the processor, and in the future will allow
- * optimizations where prepare_vmcs02 doesn't need to set all the fields on
- * every entry if they never change.
- * So we keep, in vmx->nested.vmcs02_pool, a cache of size VMCS02_POOL_SIZE
- * (>=0) with a vmcs02 for each recently loaded vmcs12s, most recent first.
- *
- * The following functions allocate and free a vmcs02 in this pool.
- */
-
-/* Get a VMCS from the pool to use as vmcs02 for the current vmcs12. */
-static struct loaded_vmcs *nested_get_current_vmcs02(struct vcpu_vmx *vmx)
-{
-	struct vmcs02_list *item;
-	list_for_each_entry(item, &vmx->nested.vmcs02_pool, list)
-		if (item->vmptr == vmx->nested.current_vmptr) {
-			list_move(&item->list, &vmx->nested.vmcs02_pool);
-			return &item->vmcs02;
-		}
-
-	if (vmx->nested.vmcs02_num >= max(VMCS02_POOL_SIZE, 1)) {
-		/* Recycle the least recently used VMCS. */
-		item = list_last_entry(&vmx->nested.vmcs02_pool,
-				       struct vmcs02_list, list);
-		item->vmptr = vmx->nested.current_vmptr;
-		list_move(&item->list, &vmx->nested.vmcs02_pool);
-		return &item->vmcs02;
-	}
-
-	/* Create a new VMCS */
-	item = kmalloc(sizeof(struct vmcs02_list), GFP_KERNEL);
-	if (!item)
-		return NULL;
-	item->vmcs02.vmcs = alloc_vmcs();
-	item->vmcs02.shadow_vmcs = NULL;
-	if (!item->vmcs02.vmcs) {
-		kfree(item);
-		return NULL;
-	}
-	loaded_vmcs_init(&item->vmcs02);
-	item->vmptr = vmx->nested.current_vmptr;
-	list_add(&(item->list), &(vmx->nested.vmcs02_pool));
-	vmx->nested.vmcs02_num++;
-	return &item->vmcs02;
-}
-
-/* Free and remove from pool a vmcs02 saved for a vmcs12 (if there is one) */
-static void nested_free_vmcs02(struct vcpu_vmx *vmx, gpa_t vmptr)
-{
-	struct vmcs02_list *item;
-	list_for_each_entry(item, &vmx->nested.vmcs02_pool, list)
-		if (item->vmptr == vmptr) {
-			free_loaded_vmcs(&item->vmcs02);
-			list_del(&item->list);
-			kfree(item);
-			vmx->nested.vmcs02_num--;
-			return;
-		}
-}
-
-/*
- * Free all VMCSs saved for this vcpu, except the one pointed by
- * vmx->loaded_vmcs. We must be running L1, so vmx->loaded_vmcs
- * must be &vmx->vmcs01.
- */
-static void nested_free_all_saved_vmcss(struct vcpu_vmx *vmx)
-{
-	struct vmcs02_list *item, *n;
-
-	WARN_ON(vmx->loaded_vmcs != &vmx->vmcs01);
-	list_for_each_entry_safe(item, n, &vmx->nested.vmcs02_pool, list) {
-		/*
-		 * Something will leak if the above WARN triggers.  Better than
-		 * a use-after-free.
-		 */
-		if (vmx->loaded_vmcs == &item->vmcs02)
-			continue;
-
-		free_loaded_vmcs(&item->vmcs02);
-		list_del(&item->list);
-		kfree(item);
-		vmx->nested.vmcs02_num--;
-	}
-}
-
-/*
  * The following 3 functions, nested_vmx_succeed()/failValid()/failInvalid(),
  * set the success or error code of an emulated VMX instruction, as specified
  * by Vol 2B, VMX Instruction Reference, "Conventions".
@@ -7078,6 +6982,12 @@ static int handle_vmon(struct kvm_vcpu *
 		return 1;
 	}
 
+	vmx->nested.vmcs02.vmcs = alloc_vmcs();
+	vmx->nested.vmcs02.shadow_vmcs = NULL;
+	if (!vmx->nested.vmcs02.vmcs)
+		goto out_vmcs02;
+	loaded_vmcs_init(&vmx->nested.vmcs02);
+
 	if (cpu_has_vmx_msr_bitmap()) {
 		vmx->nested.msr_bitmap =
 				(unsigned long *)__get_free_page(GFP_KERNEL);
@@ -7100,9 +7010,6 @@ static int handle_vmon(struct kvm_vcpu *
 		vmx->vmcs01.shadow_vmcs = shadow_vmcs;
 	}
 
-	INIT_LIST_HEAD(&(vmx->nested.vmcs02_pool));
-	vmx->nested.vmcs02_num = 0;
-
 	hrtimer_init(&vmx->nested.preemption_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL_PINNED);
 	vmx->nested.preemption_timer.function = vmx_preemption_timer_fn;
@@ -7120,6 +7027,9 @@ out_cached_vmcs12:
 	free_page((unsigned long)vmx->nested.msr_bitmap);
 
 out_msr_bitmap:
+	free_loaded_vmcs(&vmx->nested.vmcs02);
+
+out_vmcs02:
 	return -ENOMEM;
 }
 
@@ -7205,7 +7115,7 @@ static void free_nested(struct vcpu_vmx
 		vmx->vmcs01.shadow_vmcs = NULL;
 	}
 	kfree(vmx->nested.cached_vmcs12);
-	/* Unpin physical memory we referred to in current vmcs02 */
+	/* Unpin physical memory we referred to in the vmcs02 */
 	if (vmx->nested.apic_access_page) {
 		nested_release_page(vmx->nested.apic_access_page);
 		vmx->nested.apic_access_page = NULL;
@@ -7221,7 +7131,7 @@ static void free_nested(struct vcpu_vmx
 		vmx->nested.pi_desc = NULL;
 	}
 
-	nested_free_all_saved_vmcss(vmx);
+	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
 
 /* Emulate the VMXOFF instruction */
@@ -7255,8 +7165,6 @@ static int handle_vmclear(struct kvm_vcp
 			vmptr + offsetof(struct vmcs12, launch_state),
 			&zero, sizeof(zero));
 
-	nested_free_vmcs02(vmx, vmptr);
-
 	skip_emulated_instruction(vcpu);
 	nested_vmx_succeed(vcpu);
 	return 1;
@@ -8045,10 +7953,11 @@ static bool nested_vmx_exit_handled(stru
 
 	/*
 	 * The host physical addresses of some pages of guest memory
-	 * are loaded into VMCS02 (e.g. L1's Virtual APIC Page). The CPU
-	 * may write to these pages via their host physical address while
-	 * L2 is running, bypassing any address-translation-based dirty
-	 * tracking (e.g. EPT write protection).
+	 * are loaded into the vmcs02 (e.g. vmcs12's Virtual APIC
+	 * Page). The CPU may write to these pages via their host
+	 * physical address while L2 is running, bypassing any
+	 * address-translation-based dirty tracking (e.g. EPT write
+	 * protection).
 	 *
 	 * Mark them dirty on every exit from L2 to prevent them from
 	 * getting out of sync with dirty tracking.
@@ -10212,7 +10121,6 @@ static int nested_vmx_run(struct kvm_vcp
 	struct vmcs12 *vmcs12;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int cpu;
-	struct loaded_vmcs *vmcs02;
 	bool ia32e;
 	u32 msr_entry_idx;
 
@@ -10352,17 +10260,13 @@ static int nested_vmx_run(struct kvm_vcp
 	 * the nested entry.
 	 */
 
-	vmcs02 = nested_get_current_vmcs02(vmx);
-	if (!vmcs02)
-		return -ENOMEM;
-
 	enter_guest_mode(vcpu);
 
 	if (!(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
 		vmx->nested.vmcs01_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
 
 	cpu = get_cpu();
-	vmx->loaded_vmcs = vmcs02;
+	vmx->loaded_vmcs = &vmx->nested.vmcs02;
 	vmx_vcpu_put(vcpu);
 	vmx_vcpu_load(vcpu, cpu);
 	vcpu->cpu = cpu;
@@ -10877,10 +10781,6 @@ static void nested_vmx_vmexit(struct kvm
 	vm_exit_controls_reset_shadow(vmx);
 	vmx_segment_cache_clear(vmx);
 
-	/* if no vmcs02 cache requested, remove the one we used */
-	if (VMCS02_POOL_SIZE == 0)
-		nested_free_vmcs02(vmx, vmx->nested.current_vmptr);
-
 	load_vmcs12_host_state(vcpu, vmcs12);
 
 	/* Update any VMCS fields that might have changed while L2 ran */
