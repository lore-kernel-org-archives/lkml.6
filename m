Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A01C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6805620873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570405;
	bh=uQ8txkPdmpf44FSCKvVbB9qm3KsjgAbw3R37I6Ec7so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DIWKnxMbzFziyEj++nuQOIwV3JHPcPsIuKikzoxsiOqhmVhD8YcBDn+P3rPCGLkEO
	 /5ZIIrkT+g6p0t/EGvKYX9bXRY92QnFxc7y6MMGTnDxoq8kCpzLD5F25r3hjQaNYBO
	 4/UAnBeLqP52Qv5sYC7e4cWxw9JgwkL0ooCpb+mI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfAOQkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732516AbfAOQkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:40:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86E7020883;
        Tue, 15 Jan 2019 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570399;
        bh=uQ8txkPdmpf44FSCKvVbB9qm3KsjgAbw3R37I6Ec7so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9Gk1Y57rR7Ab5KWab+i25OMgqkOuAN7mlUwYsB1Wx6gh/AjpOw/hpY9WNKnmM4Nm
         0GaPnz+eR0EcSmfv3XMFSD30RHcP7DUz4TwLshX9jF+Jfnp6ydH14GdUyO27fkne5y
         p12eoY3SXhEuXvRRyMSiFhwaTD6zxa394m2E+Dsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rik van Riel <riel@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.14 01/27] x86,kvm: move qemu/guest FPU switching out to vcpu_run
Date:   Tue, 15 Jan 2019 17:35:50 +0100
Message-Id: <20190115154901.275881593@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154901.189747728@linuxfoundation.org>
References: <20190115154901.189747728@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rik van Riel <riel@redhat.com>

commit f775b13eedee2f7f3c6fdd4e90fb79090ce5d339 upstream.

Currently, every time a VCPU is scheduled out, the host kernel will
first save the guest FPU/xstate context, then load the qemu userspace
FPU context, only to then immediately save the qemu userspace FPU
context back to memory. When scheduling in a VCPU, the same extraneous
FPU loads and saves are done.

This could be avoided by moving from a model where the guest FPU is
loaded and stored with preemption disabled, to a model where the
qemu userspace FPU is swapped out for the guest FPU context for
the duration of the KVM_RUN ioctl.

This is done under the VCPU mutex, which is also taken when other
tasks inspect the VCPU FPU context, so the code should already be
safe for this change. That should come as no surprise, given that
s390 already has this optimization.

This can fix a bug where KVM calls get_user_pages while owning the
FPU, and the file system ends up requesting the FPU again:

    [258270.527947]  __warn+0xcb/0xf0
    [258270.527948]  warn_slowpath_null+0x1d/0x20
    [258270.527951]  kernel_fpu_disable+0x3f/0x50
    [258270.527953]  __kernel_fpu_begin+0x49/0x100
    [258270.527955]  kernel_fpu_begin+0xe/0x10
    [258270.527958]  crc32c_pcl_intel_update+0x84/0xb0
    [258270.527961]  crypto_shash_update+0x3f/0x110
    [258270.527968]  crc32c+0x63/0x8a [libcrc32c]
    [258270.527975]  dm_bm_checksum+0x1b/0x20 [dm_persistent_data]
    [258270.527978]  node_prepare_for_write+0x44/0x70 [dm_persistent_data]
    [258270.527985]  dm_block_manager_write_callback+0x41/0x50 [dm_persistent_data]
    [258270.527988]  submit_io+0x170/0x1b0 [dm_bufio]
    [258270.527992]  __write_dirty_buffer+0x89/0x90 [dm_bufio]
    [258270.527994]  __make_buffer_clean+0x4f/0x80 [dm_bufio]
    [258270.527996]  __try_evict_buffer+0x42/0x60 [dm_bufio]
    [258270.527998]  dm_bufio_shrink_scan+0xc0/0x130 [dm_bufio]
    [258270.528002]  shrink_slab.part.40+0x1f5/0x420
    [258270.528004]  shrink_node+0x22c/0x320
    [258270.528006]  do_try_to_free_pages+0xf5/0x330
    [258270.528008]  try_to_free_pages+0xe9/0x190
    [258270.528009]  __alloc_pages_slowpath+0x40f/0xba0
    [258270.528011]  __alloc_pages_nodemask+0x209/0x260
    [258270.528014]  alloc_pages_vma+0x1f1/0x250
    [258270.528017]  do_huge_pmd_anonymous_page+0x123/0x660
    [258270.528021]  handle_mm_fault+0xfd3/0x1330
    [258270.528025]  __get_user_pages+0x113/0x640
    [258270.528027]  get_user_pages+0x4f/0x60
    [258270.528063]  __gfn_to_pfn_memslot+0x120/0x3f0 [kvm]
    [258270.528108]  try_async_pf+0x66/0x230 [kvm]
    [258270.528135]  tdp_page_fault+0x130/0x280 [kvm]
    [258270.528149]  kvm_mmu_page_fault+0x60/0x120 [kvm]
    [258270.528158]  handle_ept_violation+0x91/0x170 [kvm_intel]
    [258270.528162]  vmx_handle_exit+0x1ca/0x1400 [kvm_intel]

No performance changes were detected in quick ping-pong tests on
my 4 socket system, which is expected since an FPU+xstate load is
on the order of 0.1us, while ping-ponging between CPUs is on the
order of 20us, and somewhat noisy.

Cc: stable@vger.kernel.org
Signed-off-by: Rik van Riel <riel@redhat.com>
Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[Fixed a bug where reset_vcpu called put_fpu without preceding load_fpu,
 which happened inside from KVM_CREATE_VCPU ioctl. - Radim]
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/kvm_host.h |   13 +++++++++++++
 arch/x86/kvm/x86.c              |   34 +++++++++++++---------------------
 include/linux/kvm_host.h        |    2 +-
 3 files changed, 27 insertions(+), 22 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -539,7 +539,20 @@ struct kvm_vcpu_arch {
 	struct kvm_mmu_memory_cache mmu_page_cache;
 	struct kvm_mmu_memory_cache mmu_page_header_cache;
 
+	/*
+	 * QEMU userspace and the guest each have their own FPU state.
+	 * In vcpu_run, we switch between the user and guest FPU contexts.
+	 * While running a VCPU, the VCPU thread will have the guest FPU
+	 * context.
+	 *
+	 * Note that while the PKRU state lives inside the fpu registers,
+	 * it is switched out separately at VMENTER and VMEXIT time. The
+	 * "guest_fpu" state here contains the guest FPU context, with the
+	 * host PRKU bits.
+	 */
+	struct fpu user_fpu;
 	struct fpu guest_fpu;
+
 	u64 xcr0;
 	u64 guest_supported_xcr0;
 	u32 guest_xstate_size;
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3020,7 +3020,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 	pagefault_enable();
 	kvm_x86_ops->vcpu_put(vcpu);
-	kvm_put_guest_fpu(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
 	/*
 	 * If userspace has set any breakpoints or watchpoints, dr6 is restored
@@ -5377,13 +5376,10 @@ static void emulator_halt(struct x86_emu
 
 static void emulator_get_fpu(struct x86_emulate_ctxt *ctxt)
 {
-	preempt_disable();
-	kvm_load_guest_fpu(emul_to_vcpu(ctxt));
 }
 
 static void emulator_put_fpu(struct x86_emulate_ctxt *ctxt)
 {
-	preempt_enable();
 }
 
 static int emulator_intercept(struct x86_emulate_ctxt *ctxt,
@@ -7083,7 +7079,6 @@ static int vcpu_enter_guest(struct kvm_v
 	preempt_disable();
 
 	kvm_x86_ops->prepare_guest_switch(vcpu);
-	kvm_load_guest_fpu(vcpu);
 
 	/*
 	 * Disable IRQs before setting IN_GUEST_MODE.  Posted interrupt
@@ -7428,12 +7423,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 		}
 	}
 
+	kvm_load_guest_fpu(vcpu);
+
 	if (unlikely(vcpu->arch.complete_userspace_io)) {
 		int (*cui)(struct kvm_vcpu *) = vcpu->arch.complete_userspace_io;
 		vcpu->arch.complete_userspace_io = NULL;
 		r = cui(vcpu);
 		if (r <= 0)
-			goto out;
+			goto out_fpu;
 	} else
 		WARN_ON(vcpu->arch.pio.count || vcpu->mmio_needed);
 
@@ -7442,6 +7439,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 	else
 		r = vcpu_run(vcpu);
 
+out_fpu:
+	kvm_put_guest_fpu(vcpu);
 out:
 	kvm_put_guest_fpu(vcpu);
 	post_kvm_run_save(vcpu);
@@ -7865,32 +7864,25 @@ static void fx_init(struct kvm_vcpu *vcp
 	vcpu->arch.cr0 |= X86_CR0_ET;
 }
 
+/* Swap (qemu) user FPU context for the guest FPU context. */
 void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->guest_fpu_loaded)
-		return;
-
-	/*
-	 * Restore all possible states in the guest,
-	 * and assume host would use all available bits.
-	 * Guest xcr0 would be loaded later.
-	 */
-	vcpu->guest_fpu_loaded = 1;
-	__kernel_fpu_begin();
+	preempt_disable();
+	copy_fpregs_to_fpstate(&vcpu->arch.user_fpu);
 	/* PKRU is separately restored in kvm_x86_ops->run.  */
 	__copy_kernel_to_fpregs(&vcpu->arch.guest_fpu.state,
 				~XFEATURE_MASK_PKRU);
+	preempt_enable();
 	trace_kvm_fpu(1);
 }
 
+/* When vcpu_run ends, restore user space FPU context. */
 void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
 {
-	if (!vcpu->guest_fpu_loaded)
-		return;
-
-	vcpu->guest_fpu_loaded = 0;
+	preempt_disable();
 	copy_fpregs_to_fpstate(&vcpu->arch.guest_fpu);
-	__kernel_fpu_end();
+	copy_kernel_to_fpregs(&vcpu->arch.user_fpu.state);
+	preempt_enable();
 	++vcpu->stat.fpu_reload;
 	trace_kvm_fpu(0);
 }
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -232,7 +232,7 @@ struct kvm_vcpu {
 	struct mutex mutex;
 	struct kvm_run *run;
 
-	int guest_fpu_loaded, guest_xcr0_loaded;
+	int guest_xcr0_loaded;
 	struct swait_queue_head wq;
 	struct pid __rcu *pid;
 	int sigset_active;


