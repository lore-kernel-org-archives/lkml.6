Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7C9C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6B4214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789707;
	bh=4EHvlSa95M81UGwYlSAG5spP6vIvoEYtmN0d4pp2yvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=siCBZuhvXhunbgtG+Jm6fFu+nSM+1FU6OJ6YQUJJxg7Zzww1SqMYzl+lBpL/NkKmX
	 XmqlmXMoirX566YOz85HI3bgXqr4ekgMsCOFUe4DczK6MFSwu9ptGk+7v+lz452g4Q
	 dCNmJq9QGsQK30S8gu3ILA837wEglIgEDP9X+1dc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6B4214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbeLNMPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732456AbeLNMPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:15:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5669A21527;
        Fri, 14 Dec 2018 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789699;
        bh=4EHvlSa95M81UGwYlSAG5spP6vIvoEYtmN0d4pp2yvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sygw1uXHgxyPm114WLdOM8Jauj3mBeUMYHqYwquxM/FIEDigF4bQ42Dbr64VkUEb0
         sWcBvjtc7JTlNfLxnmLnRhNUvmeCM+FWBhixcX8d15yjshQucbv7y2JxvgQe1HqxB/
         /vVCG250gpSfPtBTs3egcw3+w6nNx/7d/ra8r1Ts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Mark Kanda <mark.kanda@oracle.com>,
        Ameya More <ameya.more@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 43/88] KVM: nVMX: Eliminate vmcs02 pool
Date:   Fri, 14 Dec 2018 13:00:17 +0100
Message-Id: <20181214115705.734729843@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

commit de3a0021a60635de96aa92713c1a31a96747d72c upstream.

The potential performance advantages of a vmcs02 pool have never been
realized. To simplify the code, eliminate the pool. Instead, a single
vmcs02 is allocated per VCPU when the VCPU enters VMX operation.

Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Ameya More <ameya.more@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 4.4:
 - No loaded_vmcs::shadow_vmcs field to initialise
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |  144 ++++++++---------------------------------------------
 1 file changed, 22 insertions(+), 122 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -172,7 +172,6 @@ module_param(ple_window_max, int, S_IRUG
 extern const ulong vmx_return;
 
 #define NR_AUTOLOAD_MSRS 8
-#define VMCS02_POOL_SIZE 1
 
 struct vmcs {
 	u32 revision_id;
@@ -205,7 +204,7 @@ struct shared_msr_entry {
  * stored in guest memory specified by VMPTRLD, but is opaque to the guest,
  * which must access it using VMREAD/VMWRITE/VMCLEAR instructions.
  * More than one of these structures may exist, if L1 runs multiple L2 guests.
- * nested_vmx_run() will use the data here to build a vmcs02: a VMCS for the
+ * nested_vmx_run() will use the data here to build the vmcs02: a VMCS for the
  * underlying hardware which will be used to run L2.
  * This structure is packed to ensure that its layout is identical across
  * machines (necessary for live migration).
@@ -384,13 +383,6 @@ struct __packed vmcs12 {
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
@@ -412,16 +404,16 @@ struct nested_vmx {
 	 */
 	bool sync_shadow_vmcs;
 
-	/* vmcs02_list cache of VMCSs recently used to run L2 guests */
-	struct list_head vmcs02_pool;
-	int vmcs02_num;
 	u64 vmcs01_tsc_offset;
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
@@ -6435,93 +6427,6 @@ static int handle_monitor(struct kvm_vcp
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
-		item = list_entry(vmx->nested.vmcs02_pool.prev,
-			struct vmcs02_list, list);
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
@@ -6833,6 +6738,11 @@ static int handle_vmon(struct kvm_vcpu *
 		return 1;
 	}
 
+	vmx->nested.vmcs02.vmcs = alloc_vmcs();
+	if (!vmx->nested.vmcs02.vmcs)
+		goto out_vmcs02;
+	loaded_vmcs_init(&vmx->nested.vmcs02);
+
 	if (cpu_has_vmx_msr_bitmap()) {
 		vmx->nested.msr_bitmap =
 				(unsigned long *)__get_free_page(GFP_KERNEL);
@@ -6851,9 +6761,6 @@ static int handle_vmon(struct kvm_vcpu *
 		vmx->nested.current_shadow_vmcs = shadow_vmcs;
 	}
 
-	INIT_LIST_HEAD(&(vmx->nested.vmcs02_pool));
-	vmx->nested.vmcs02_num = 0;
-
 	hrtimer_init(&vmx->nested.preemption_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL);
 	vmx->nested.preemption_timer.function = vmx_preemption_timer_fn;
@@ -6870,6 +6777,9 @@ out_shadow_vmcs:
 	free_page((unsigned long)vmx->nested.msr_bitmap);
 
 out_msr_bitmap:
+	free_loaded_vmcs(&vmx->nested.vmcs02);
+
+out_vmcs02:
 	return -ENOMEM;
 }
 
@@ -6946,7 +6856,7 @@ static void free_nested(struct vcpu_vmx
 	}
 	if (enable_shadow_vmcs)
 		free_vmcs(vmx->nested.current_shadow_vmcs);
-	/* Unpin physical memory we referred to in current vmcs02 */
+	/* Unpin physical memory we referred to in the vmcs02 */
 	if (vmx->nested.apic_access_page) {
 		nested_release_page(vmx->nested.apic_access_page);
 		vmx->nested.apic_access_page = NULL;
@@ -6962,7 +6872,7 @@ static void free_nested(struct vcpu_vmx
 		vmx->nested.pi_desc = NULL;
 	}
 
-	nested_free_all_saved_vmcss(vmx);
+	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
 
 /* Emulate the VMXOFF instruction */
@@ -6996,8 +6906,6 @@ static int handle_vmclear(struct kvm_vcp
 			vmptr + offsetof(struct vmcs12, launch_state),
 			&zero, sizeof(zero));
 
-	nested_free_vmcs02(vmx, vmptr);
-
 	skip_emulated_instruction(vcpu);
 	nested_vmx_succeed(vcpu);
 	return 1;
@@ -7784,10 +7692,11 @@ static bool nested_vmx_exit_handled(stru
 
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
@@ -9889,7 +9798,6 @@ static int nested_vmx_run(struct kvm_vcp
 	struct vmcs12 *vmcs12;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int cpu;
-	struct loaded_vmcs *vmcs02;
 	bool ia32e;
 	u32 msr_entry_idx;
 
@@ -10029,10 +9937,6 @@ static int nested_vmx_run(struct kvm_vcp
 	 * the nested entry.
 	 */
 
-	vmcs02 = nested_get_current_vmcs02(vmx);
-	if (!vmcs02)
-		return -ENOMEM;
-
 	enter_guest_mode(vcpu);
 
 	vmx->nested.vmcs01_tsc_offset = vmcs_read64(TSC_OFFSET);
@@ -10041,7 +9945,7 @@ static int nested_vmx_run(struct kvm_vcp
 		vmx->nested.vmcs01_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
 
 	cpu = get_cpu();
-	vmx->loaded_vmcs = vmcs02;
+	vmx->loaded_vmcs = &vmx->nested.vmcs02;
 	vmx_vcpu_put(vcpu);
 	vmx_vcpu_load(vcpu, cpu);
 	vcpu->cpu = cpu;
@@ -10553,10 +10457,6 @@ static void nested_vmx_vmexit(struct kvm
 	vm_exit_controls_init(vmx, vmcs_read32(VM_EXIT_CONTROLS));
 	vmx_segment_cache_clear(vmx);
 
-	/* if no vmcs02 cache requested, remove the one we used */
-	if (VMCS02_POOL_SIZE == 0)
-		nested_free_vmcs02(vmx, vmx->nested.current_vmptr);
-
 	load_vmcs12_host_state(vcpu, vmcs12);
 
 	/* Update TSC_OFFSET if TSC was changed while L2 ran */


