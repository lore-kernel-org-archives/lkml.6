Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELupjktdWVeLLgyN7ISjNzL9erne7gEi8+2BEAaNe83lNX73W5C5afyuEeTlhp1NnwgsoDIn
ARC-Seal: i=1; a=rsa-sha256; t=1521484311; cv=none;
        d=google.com; s=arc-20160816;
        b=Q+7Pbkzb5TAj4Q/TRfhHxRK/jLK1jUEvjFb9LMQY8udyhIaIO2OEcTTRp1zoRY4vXc
         vEQ1xkRk3py3n30nD3jVhk0vA8p/gFKGBSlUYzjYsKTmEkAUuDKX/c7X/ZlMcNOk7zy0
         tL9eidZf7B3+dsM47PDsc+Ld9PWFBG6B6Nb0EvaRETY60d6w0rcQITUD1tr0/61gt5PD
         k3tn8hBGs2OVrx2/O5rq8Z2Hx0LdLbj57P/2ElOU18DQzfZ+AyDjbnZ0/FS4C9gjZkZ9
         lBKHo1lqJSmFny2kr8B8Niqie+L15pDTSkJZXQZkeeC/aOCHUB9IH19BX/TNqZWbvxDe
         6m+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TIxzYtaDPeZCBgYBGOPkXvBz8AJixqkJFe9vyndkYhQ=;
        b=YM3nYk5FafCl7jTRn0F7wG4EsbX1hKpIfFbHgPTx7h1M2Aiczp2YfeAI53TvtMOmwU
         iedG+ROMEgkc2XKZqjvSImKiMFY7eUOCcB1XXohlsAu92ohLtKovmbvNpQmSjFRQO7ON
         J2xZ6yDJvGSwbsknl0vgeZ21IpQSmEJR82qZNUssLvFbRGZ5r/qdbge9rd9REnZWWF0R
         f2Hyek2uzspNKqUG8Ig0kfPkTqWw9FUVcxecXM7wR81LgTyUZr2ksm7+YcmaOkccbFck
         9nKmLKZruvCtipGbyDbi7o2RCX2zW5xn9CKmZtq3kXOw/njAVJZnNU83h6EeCNneJQnB
         pUFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoffer Dall <cdall@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.15 24/52] KVM: arm/arm64: vgic: Dont populate multiple LRs with the same vintid
Date: Mon, 19 Mar 2018 19:08:22 +0100
Message-Id: <20180319180736.447818535@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391865611815073?=
X-GMAIL-MSGID: =?utf-8?q?1595391933409350844?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 16ca6a607d84bef0129698d8d808f501afd08d43 upstream.

The vgic code is trying to be clever when injecting GICv2 SGIs,
and will happily populate LRs with the same interrupt number if
they come from multiple vcpus (after all, they are distinct
interrupt sources).

Unfortunately, this is against the letter of the architecture,
and the GICv2 architecture spec says "Each valid interrupt stored
in the List registers must have a unique VirtualID for that
virtual CPU interface.". GICv3 has similar (although slightly
ambiguous) restrictions.

This results in guests locking up when using GICv2-on-GICv3, for
example. The obvious fix is to stop trying so hard, and inject
a single vcpu per SGI per guest entry. After all, pending SGIs
with multiple source vcpus are pretty rare, and are mostly seen
in scenario where the physical CPUs are severely overcomitted.

But as we now only inject a single instance of a multi-source SGI per
vcpu entry, we may delay those interrupts for longer than strictly
necessary, and run the risk of injecting lower priority interrupts
in the meantime.

In order to address this, we adopt a three stage strategy:
- If we encounter a multi-source SGI in the AP list while computing
  its depth, we force the list to be sorted
- When populating the LRs, we prevent the injection of any interrupt
  of lower priority than that of the first multi-source SGI we've
  injected.
- Finally, the injection of a multi-source SGI triggers the request
  of a maintenance interrupt when there will be no pending interrupt
  in the LRs (HCR_NPIE).

At the point where the last pending interrupt in the LRs switches
from Pending to Active, the maintenance interrupt will be delivered,
allowing us to add the remaining SGIs using the same process.

Cc: stable@vger.kernel.org
Fixes: 0919e84c0fc1 ("KVM: arm/arm64: vgic-new: Add IRQ sync/flush framework")
Acked-by: Christoffer Dall <cdall@kernel.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/irqchip/arm-gic-v3.h |    1 
 include/linux/irqchip/arm-gic.h    |    1 
 virt/kvm/arm/vgic/vgic-v2.c        |    9 ++++-
 virt/kvm/arm/vgic/vgic-v3.c        |    9 ++++-
 virt/kvm/arm/vgic/vgic.c           |   61 ++++++++++++++++++++++++++++---------
 virt/kvm/arm/vgic/vgic.h           |    2 +
 6 files changed, 67 insertions(+), 16 deletions(-)

--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -503,6 +503,7 @@
 
 #define ICH_HCR_EN			(1 << 0)
 #define ICH_HCR_UIE			(1 << 1)
+#define ICH_HCR_NPIE			(1 << 3)
 #define ICH_HCR_TC			(1 << 10)
 #define ICH_HCR_TALL0			(1 << 11)
 #define ICH_HCR_TALL1			(1 << 12)
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -84,6 +84,7 @@
 
 #define GICH_HCR_EN			(1 << 0)
 #define GICH_HCR_UIE			(1 << 1)
+#define GICH_HCR_NPIE			(1 << 3)
 
 #define GICH_LR_VIRTUALID		(0x3ff << 0)
 #define GICH_LR_PHYSID_CPUID_SHIFT	(10)
--- a/virt/kvm/arm/vgic/vgic-v2.c
+++ b/virt/kvm/arm/vgic/vgic-v2.c
@@ -37,6 +37,13 @@ void vgic_v2_init_lrs(void)
 		vgic_v2_write_lr(i, 0);
 }
 
+void vgic_v2_set_npie(struct kvm_vcpu *vcpu)
+{
+	struct vgic_v2_cpu_if *cpuif = &vcpu->arch.vgic_cpu.vgic_v2;
+
+	cpuif->vgic_hcr |= GICH_HCR_NPIE;
+}
+
 void vgic_v2_set_underflow(struct kvm_vcpu *vcpu)
 {
 	struct vgic_v2_cpu_if *cpuif = &vcpu->arch.vgic_cpu.vgic_v2;
@@ -64,7 +71,7 @@ void vgic_v2_fold_lr_state(struct kvm_vc
 	int lr;
 	unsigned long flags;
 
-	cpuif->vgic_hcr &= ~GICH_HCR_UIE;
+	cpuif->vgic_hcr &= ~(GICH_HCR_UIE | GICH_HCR_NPIE);
 
 	for (lr = 0; lr < vgic_cpu->used_lrs; lr++) {
 		u32 val = cpuif->vgic_lr[lr];
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -26,6 +26,13 @@ static bool group1_trap;
 static bool common_trap;
 static bool gicv4_enable;
 
+void vgic_v3_set_npie(struct kvm_vcpu *vcpu)
+{
+	struct vgic_v3_cpu_if *cpuif = &vcpu->arch.vgic_cpu.vgic_v3;
+
+	cpuif->vgic_hcr |= ICH_HCR_NPIE;
+}
+
 void vgic_v3_set_underflow(struct kvm_vcpu *vcpu)
 {
 	struct vgic_v3_cpu_if *cpuif = &vcpu->arch.vgic_cpu.vgic_v3;
@@ -47,7 +54,7 @@ void vgic_v3_fold_lr_state(struct kvm_vc
 	int lr;
 	unsigned long flags;
 
-	cpuif->vgic_hcr &= ~ICH_HCR_UIE;
+	cpuif->vgic_hcr &= ~(ICH_HCR_UIE | ICH_HCR_NPIE);
 
 	for (lr = 0; lr < vgic_cpu->used_lrs; lr++) {
 		u64 val = cpuif->vgic_lr[lr];
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -675,22 +675,37 @@ static inline void vgic_set_underflow(st
 		vgic_v3_set_underflow(vcpu);
 }
 
+static inline void vgic_set_npie(struct kvm_vcpu *vcpu)
+{
+	if (kvm_vgic_global_state.type == VGIC_V2)
+		vgic_v2_set_npie(vcpu);
+	else
+		vgic_v3_set_npie(vcpu);
+}
+
 /* Requires the ap_list_lock to be held. */
-static int compute_ap_list_depth(struct kvm_vcpu *vcpu)
+static int compute_ap_list_depth(struct kvm_vcpu *vcpu,
+				 bool *multi_sgi)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_irq *irq;
 	int count = 0;
 
+	*multi_sgi = false;
+
 	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
 
 	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
 		spin_lock(&irq->irq_lock);
 		/* GICv2 SGIs can count for more than one... */
-		if (vgic_irq_is_sgi(irq->intid) && irq->source)
-			count += hweight8(irq->source);
-		else
+		if (vgic_irq_is_sgi(irq->intid) && irq->source) {
+			int w = hweight8(irq->source);
+
+			count += w;
+			*multi_sgi |= (w > 1);
+		} else {
 			count++;
+		}
 		spin_unlock(&irq->irq_lock);
 	}
 	return count;
@@ -701,28 +716,43 @@ static void vgic_flush_lr_state(struct k
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_irq *irq;
-	int count = 0;
+	int count;
+	bool npie = false;
+	bool multi_sgi;
+	u8 prio = 0xff;
 
 	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
 
-	if (compute_ap_list_depth(vcpu) > kvm_vgic_global_state.nr_lr)
+	count = compute_ap_list_depth(vcpu, &multi_sgi);
+	if (count > kvm_vgic_global_state.nr_lr || multi_sgi)
 		vgic_sort_ap_list(vcpu);
 
+	count = 0;
+
 	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
 		spin_lock(&irq->irq_lock);
 
-		if (unlikely(vgic_target_oracle(irq) != vcpu))
-			goto next;
-
 		/*
-		 * If we get an SGI with multiple sources, try to get
-		 * them in all at once.
+		 * If we have multi-SGIs in the pipeline, we need to
+		 * guarantee that they are all seen before any IRQ of
+		 * lower priority. In that case, we need to filter out
+		 * these interrupts by exiting early. This is easy as
+		 * the AP list has been sorted already.
 		 */
-		do {
+		if (multi_sgi && irq->priority > prio) {
+			spin_unlock(&irq->irq_lock);
+			break;
+		}
+
+		if (likely(vgic_target_oracle(irq) == vcpu)) {
 			vgic_populate_lr(vcpu, irq, count++);
-		} while (irq->source && count < kvm_vgic_global_state.nr_lr);
 
-next:
+			if (irq->source) {
+				npie = true;
+				prio = irq->priority;
+			}
+		}
+
 		spin_unlock(&irq->irq_lock);
 
 		if (count == kvm_vgic_global_state.nr_lr) {
@@ -733,6 +763,9 @@ next:
 		}
 	}
 
+	if (npie)
+		vgic_set_npie(vcpu);
+
 	vcpu->arch.vgic_cpu.used_lrs = count;
 
 	/* Nuke remaining LRs */
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -151,6 +151,7 @@ void vgic_v2_fold_lr_state(struct kvm_vc
 void vgic_v2_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr);
 void vgic_v2_clear_lr(struct kvm_vcpu *vcpu, int lr);
 void vgic_v2_set_underflow(struct kvm_vcpu *vcpu);
+void vgic_v2_set_npie(struct kvm_vcpu *vcpu);
 int vgic_v2_has_attr_regs(struct kvm_device *dev, struct kvm_device_attr *attr);
 int vgic_v2_dist_uaccess(struct kvm_vcpu *vcpu, bool is_write,
 			 int offset, u32 *val);
@@ -180,6 +181,7 @@ void vgic_v3_fold_lr_state(struct kvm_vc
 void vgic_v3_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr);
 void vgic_v3_clear_lr(struct kvm_vcpu *vcpu, int lr);
 void vgic_v3_set_underflow(struct kvm_vcpu *vcpu);
+void vgic_v3_set_npie(struct kvm_vcpu *vcpu);
 void vgic_v3_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
 void vgic_v3_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
 void vgic_v3_enable(struct kvm_vcpu *vcpu);
