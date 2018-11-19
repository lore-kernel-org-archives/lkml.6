Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5567C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDEB206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDEB206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407307AbeKTDcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:32:36 -0500
Received: from foss.arm.com ([217.140.101.70]:33372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406505AbeKTDcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:32:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40FC5165C;
        Mon, 19 Nov 2018 09:08:18 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 749C43F5B7;
        Mon, 19 Nov 2018 09:08:16 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc:     marc.zyngier@arm.com, Christoffer.Dall@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de,
        Julien Thierry <julien.thierry@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH 4/4] KVM: arm/arm64: vgic: Make vgic_cpu->ap_list_lock a raw_spinlock
Date:   Mon, 19 Nov 2018 17:07:59 +0000
Message-Id: <1542647279-46609-5-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542647279-46609-1-git-send-email-julien.thierry@arm.com>
References: <1542647279-46609-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vgic_cpu->ap_list_lock must always be taken with interrupts disabled as
it is used in interrupt context.

For configurations such as PREEMPT_RT_FULL, this means that it should
be a raw_spinlock since RT spinlocks are interruptible.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h        |  2 +-
 virt/kvm/arm/vgic/vgic-init.c |  2 +-
 virt/kvm/arm/vgic/vgic.c      | 43 ++++++++++++++++++++++---------------------
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 32954e1..c36c86f 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -307,7 +307,7 @@ struct vgic_cpu {
 	unsigned int used_lrs;
 	struct vgic_irq private_irqs[VGIC_NR_PRIVATE_IRQS];

-	spinlock_t ap_list_lock;	/* Protects the ap_list */
+	raw_spinlock_t ap_list_lock;	/* Protects the ap_list */

 	/*
 	 * List of IRQs that this VCPU should consider because they are either
diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 330c1ad..dfbfcb1 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -206,7 +206,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	vgic_cpu->sgi_iodev.base_addr = VGIC_ADDR_UNDEF;

 	INIT_LIST_HEAD(&vgic_cpu->ap_list_head);
-	spin_lock_init(&vgic_cpu->ap_list_lock);
+	raw_spin_lock_init(&vgic_cpu->ap_list_lock);

 	/*
 	 * Enable and configure all SGIs to be edge-triggered and
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 01bd18c..736ae59 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -54,11 +54,11 @@ struct vgic_global kvm_vgic_global_state __ro_after_init = {
  * When taking more than one ap_list_lock at the same time, always take the
  * lowest numbered VCPU's ap_list_lock first, so:
  *   vcpuX->vcpu_id < vcpuY->vcpu_id:
- *     spin_lock(vcpuX->arch.vgic_cpu.ap_list_lock);
- *     spin_lock(vcpuY->arch.vgic_cpu.ap_list_lock);
+ *     raw_spin_lock(vcpuX->arch.vgic_cpu.ap_list_lock);
+ *     raw_spin_lock(vcpuY->arch.vgic_cpu.ap_list_lock);
  *
  * Since the VGIC must support injecting virtual interrupts from ISRs, we have
- * to use the spin_lock_irqsave/spin_unlock_irqrestore versions of outer
+ * to use the raw_spin_lock_irqsave/raw_spin_unlock_irqrestore versions of outer
  * spinlocks for any lock that may be taken while injecting an interrupt.
  */

@@ -273,7 +273,7 @@ static void vgic_sort_ap_list(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;

-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
+	DEBUG_SPINLOCK_BUG_ON(!raw_spin_is_locked(&vgic_cpu->ap_list_lock));

 	list_sort(NULL, &vgic_cpu->ap_list_head, vgic_irq_cmp);
 }
@@ -351,7 +351,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,

 	/* someone can do stuff here, which we re-check below */

-	spin_lock_irqsave(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
+	raw_spin_lock_irqsave(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
 	raw_spin_lock(&irq->irq_lock);

 	/*
@@ -368,7 +368,8 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,

 	if (unlikely(irq->vcpu || vcpu != vgic_target_oracle(irq))) {
 		raw_spin_unlock(&irq->irq_lock);
-		spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
+		raw_spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock,
+					   flags);

 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		goto retry;
@@ -383,7 +384,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
 	irq->vcpu = vcpu;

 	raw_spin_unlock(&irq->irq_lock);
-	spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
+	raw_spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);

 	kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
 	kvm_vcpu_kick(vcpu);
@@ -597,7 +598,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());

 retry:
-	spin_lock(&vgic_cpu->ap_list_lock);
+	raw_spin_lock(&vgic_cpu->ap_list_lock);

 	list_for_each_entry_safe(irq, tmp, &vgic_cpu->ap_list_head, ap_list) {
 		struct kvm_vcpu *target_vcpu, *vcpuA, *vcpuB;
@@ -638,7 +639,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 		/* This interrupt looks like it has to be migrated. */

 		raw_spin_unlock(&irq->irq_lock);
-		spin_unlock(&vgic_cpu->ap_list_lock);
+		raw_spin_unlock(&vgic_cpu->ap_list_lock);

 		/*
 		 * Ensure locking order by always locking the smallest
@@ -652,9 +653,9 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 			vcpuB = vcpu;
 		}

-		spin_lock(&vcpuA->arch.vgic_cpu.ap_list_lock);
-		spin_lock_nested(&vcpuB->arch.vgic_cpu.ap_list_lock,
-				 SINGLE_DEPTH_NESTING);
+		raw_spin_lock(&vcpuA->arch.vgic_cpu.ap_list_lock);
+		raw_spin_lock_nested(&vcpuB->arch.vgic_cpu.ap_list_lock,
+				      SINGLE_DEPTH_NESTING);
 		raw_spin_lock(&irq->irq_lock);

 		/*
@@ -676,8 +677,8 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 		}

 		raw_spin_unlock(&irq->irq_lock);
-		spin_unlock(&vcpuB->arch.vgic_cpu.ap_list_lock);
-		spin_unlock(&vcpuA->arch.vgic_cpu.ap_list_lock);
+		raw_spin_unlock(&vcpuB->arch.vgic_cpu.ap_list_lock);
+		raw_spin_unlock(&vcpuA->arch.vgic_cpu.ap_list_lock);

 		if (target_vcpu_needs_kick) {
 			kvm_make_request(KVM_REQ_IRQ_PENDING, target_vcpu);
@@ -687,7 +688,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 		goto retry;
 	}

-	spin_unlock(&vgic_cpu->ap_list_lock);
+	raw_spin_unlock(&vgic_cpu->ap_list_lock);
 }

 static inline void vgic_fold_lr_state(struct kvm_vcpu *vcpu)
@@ -736,7 +737,7 @@ static int compute_ap_list_depth(struct kvm_vcpu *vcpu,

 	*multi_sgi = false;

-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
+	DEBUG_SPINLOCK_BUG_ON(!raw_spin_is_locked(&vgic_cpu->ap_list_lock));

 	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
 		int w;
@@ -761,7 +762,7 @@ static void vgic_flush_lr_state(struct kvm_vcpu *vcpu)
 	bool multi_sgi;
 	u8 prio = 0xff;

-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
+	DEBUG_SPINLOCK_BUG_ON(!raw_spin_is_locked(&vgic_cpu->ap_list_lock));

 	count = compute_ap_list_depth(vcpu, &multi_sgi);
 	if (count > kvm_vgic_global_state.nr_lr || multi_sgi)
@@ -872,9 +873,9 @@ void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)

 	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());

-	spin_lock(&vcpu->arch.vgic_cpu.ap_list_lock);
+	raw_spin_lock(&vcpu->arch.vgic_cpu.ap_list_lock);
 	vgic_flush_lr_state(vcpu);
-	spin_unlock(&vcpu->arch.vgic_cpu.ap_list_lock);
+	raw_spin_unlock(&vcpu->arch.vgic_cpu.ap_list_lock);

 	if (can_access_vgic_from_kernel())
 		vgic_restore_state(vcpu);
@@ -915,7 +916,7 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.vgic_cpu.vgic_v3.its_vpe.pending_last)
 		return true;

-	spin_lock_irqsave(&vgic_cpu->ap_list_lock, flags);
+	raw_spin_lock_irqsave(&vgic_cpu->ap_list_lock, flags);

 	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
 		raw_spin_lock(&irq->irq_lock);
@@ -926,7 +927,7 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 			break;
 	}

-	spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
+	raw_spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);

 	return pending;
 }
--
1.9.1
