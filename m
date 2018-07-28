Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F4EC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C537020842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C537020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeG1Kdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 06:33:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:53999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbeG1Kdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 06:33:39 -0400
Received: from homer.simpson.net ([185.221.150.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mb8MV-1fQRXI0VS7-00Keyb; Sat, 28
 Jul 2018 11:07:35 +0200
Message-ID: <1532768853.9882.73.camel@gmx.de>
Subject: [rt-patch 3/3] arm, KVM: convert vgic_irq.irq_lock to raw_spinlock_t
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Sat, 28 Jul 2018 11:07:33 +0200
In-Reply-To: <1532764179.9882.14.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532764179.9882.14.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PTx9OZL5lFCUv27K8ajPtFeVDKtOFcVQYoDTUaHj57YDZJa8MOF
 k0z/k+d09bq6cO08UtgGPWe7NNUQ3wdx/JYtpdVvDX76H0W/esRF3oufVs2rsHMUFEsUtiq
 sRX/HAhKtTur1dTdYjJZYjiM89uzX+9/kQwqAfaCOmxoKFSan+O5qH8hPhuRebL9Yr7qiOL
 DgWGzoFTZcCGeJWRsdjZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/PxCo9nz/4s=:bd06gHDYSlJ86zq4BWFTI9
 K3ik0SE5FqhI26sPEJ55JJShmzQ6Mdtb3/j+8rJ4s4aCHZPYeE9pZC6o7EwliYdLON4VeYcR2
 tS5m4gxXrWWkPF9xYvFUTHdHwjDljWcT3VHb9M4zYNrHjYPF2u2OvziCnTzLd/sPy/kK2I2ZN
 7lGQUp+a7Apzn+O0u/QWb1z/ijE90bZAacgRCNrtI5cWTUyjp2kTA6u0l58gBZ26OV38sUWOn
 yTgR7OwmHckeWChhBOQnjmk4wkjoKY/83hlmXop5neIxmaRHoauAxcdO5+TE9Fv87N2YxdagC
 mErzR+eZzBC+EtJhYY/AzFmh3idl379XtAd7RL8M4caiUUFgW53PwFR5fgGcT1KFP+ExDplWv
 8ZLJBFtHkJUvJq2ZFgSHna3Ri2rIjfCRhDLJajYqol3Wa9BHpDqyloziDS9hrRhKC+MAxpHz4
 Sbyrz3l5AhiJVVK8LCqtLhm+I9j3ZL0Ws/ddT7Fy0BR4NTZYrHe9Lh/qoIpexY+BYf55sjtiS
 H2iMSkfp3XXsEZOfnTUgfa6StANzoHGmQt6wx+UMZ8I01Rx4ES6CjPXO4Co9r0t3RmTeQ2rVf
 H9sDu+090Aom/IMCEiSHUh+C+s22Wb6gvou3Ytb+CyPEkKzXHhDSC56mRLU75XMjPEC+pbJDW
 pnnaPXJy/wXQMBsv3J80Qauuenw97ZbEfoug9K6fOoI6QUfZt3NawHyzDHHLLnGxnmTBM9r1m
 HWJ6TRDIaQfyCCnR43D/QkqqDvHRucH/7At+nU4cy1mwcoc/bHObzsW1BUIKmli70PiSS0UCb
 qR44iU3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


b103cc3f10c0 ("KVM: arm/arm64: Avoid timer save/restore in vcpu entry/exit")
requires vgic_irq.irq_lock be converted to raw_spinlock_t.

Problem: kvm_preempt_ops.sched_in = kvm_sched_in;
   kvm_sched_in()
      kvm_arch_vcpu_load()
         kvm_timer_vcpu_load() <- b103cc3f10c0 addition
            kvm_timer_vcpu_load_gic()
               kvm_vgic_map_is_active()
                  spin_lock_irqsave(&irq->irq_lock, flags);

Quoting virt/kvm/arm/vgic/vgic.c, locking order is...

  kvm->lock (mutex)
    its->cmd_lock (mutex)
      its->its_lock (mutex)
        vgic_cpu->ap_list_lock         must be taken with IRQs disabled
          kvm->lpi_list_lock           must be taken with IRQs disabled
            vgic_irq->irq_lock         must be taken with IRQs disabled

...meaning vgic_dist.lpi_list_lock and vgic_cpu.ap_list_lock must be
converted as well.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 include/kvm/arm_vgic.h           |    6 -
 virt/kvm/arm/vgic/vgic-debug.c   |    4 -
 virt/kvm/arm/vgic/vgic-init.c    |    8 +-
 virt/kvm/arm/vgic/vgic-its.c     |   22 +++----
 virt/kvm/arm/vgic/vgic-mmio-v2.c |   14 ++--
 virt/kvm/arm/vgic/vgic-mmio-v3.c |   10 +--
 virt/kvm/arm/vgic/vgic-mmio.c    |   34 +++++------
 virt/kvm/arm/vgic/vgic-v2.c      |    4 -
 virt/kvm/arm/vgic/vgic-v3.c      |    8 +-
 virt/kvm/arm/vgic/vgic.c         |  120 +++++++++++++++++++--------------------
 10 files changed, 115 insertions(+), 115 deletions(-)

--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -96,7 +96,7 @@ enum vgic_irq_config {
 };
 
 struct vgic_irq {
-	spinlock_t irq_lock;		/* Protects the content of the struct */
+	raw_spinlock_t irq_lock;	/* Protects the content of the struct */
 	struct list_head lpi_list;	/* Used to link all LPIs together */
 	struct list_head ap_list;
 
@@ -243,7 +243,7 @@ struct vgic_dist {
 	u64			propbaser;
 
 	/* Protects the lpi_list and the count value below. */
-	spinlock_t		lpi_list_lock;
+	raw_spinlock_t		lpi_list_lock;
 	struct list_head	lpi_list_head;
 	int			lpi_list_count;
 
@@ -296,7 +296,7 @@ struct vgic_cpu {
 	unsigned int used_lrs;
 	struct vgic_irq private_irqs[VGIC_NR_PRIVATE_IRQS];
 
-	spinlock_t ap_list_lock;	/* Protects the ap_list */
+	raw_spinlock_t ap_list_lock;	/* Protects the ap_list */
 
 	/*
 	 * List of IRQs that this VCPU should consider because they are either
--- a/virt/kvm/arm/vgic/vgic-debug.c
+++ b/virt/kvm/arm/vgic/vgic-debug.c
@@ -228,9 +228,9 @@ static int vgic_debug_show(struct seq_fi
 		irq = &kvm->arch.vgic.spis[iter->intid - VGIC_NR_PRIVATE_IRQS];
 	}
 
-	spin_lock_irqsave(&irq->irq_lock, flags);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	print_irq_state(s, irq, vcpu);
-	spin_unlock_irqrestore(&irq->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 	return 0;
 }
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -64,7 +64,7 @@ void kvm_vgic_early_init(struct kvm *kvm
 	struct vgic_dist *dist = &kvm->arch.vgic;
 
 	INIT_LIST_HEAD(&dist->lpi_list_head);
-	spin_lock_init(&dist->lpi_list_lock);
+	raw_spin_lock_init(&dist->lpi_list_lock);
 }
 
 /**
@@ -80,7 +80,7 @@ void kvm_vgic_vcpu_early_init(struct kvm
 	int i;
 
 	INIT_LIST_HEAD(&vgic_cpu->ap_list_head);
-	spin_lock_init(&vgic_cpu->ap_list_lock);
+	raw_spin_lock_init(&vgic_cpu->ap_list_lock);
 
 	/*
 	 * Enable and configure all SGIs to be edge-triggered and
@@ -90,7 +90,7 @@ void kvm_vgic_vcpu_early_init(struct kvm
 		struct vgic_irq *irq = &vgic_cpu->private_irqs[i];
 
 		INIT_LIST_HEAD(&irq->ap_list);
-		spin_lock_init(&irq->irq_lock);
+		raw_spin_lock_init(&irq->irq_lock);
 		irq->intid = i;
 		irq->vcpu = NULL;
 		irq->target_vcpu = vcpu;
@@ -214,7 +214,7 @@ static int kvm_vgic_dist_init(struct kvm
 
 		irq->intid = i + VGIC_NR_PRIVATE_IRQS;
 		INIT_LIST_HEAD(&irq->ap_list);
-		spin_lock_init(&irq->irq_lock);
+		raw_spin_lock_init(&irq->irq_lock);
 		irq->vcpu = NULL;
 		irq->target_vcpu = vcpu0;
 		kref_init(&irq->refcount);
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -65,14 +65,14 @@ static struct vgic_irq *vgic_add_lpi(str
 
 	INIT_LIST_HEAD(&irq->lpi_list);
 	INIT_LIST_HEAD(&irq->ap_list);
-	spin_lock_init(&irq->irq_lock);
+	raw_spin_lock_init(&irq->irq_lock);
 
 	irq->config = VGIC_CONFIG_EDGE;
 	kref_init(&irq->refcount);
 	irq->intid = intid;
 	irq->target_vcpu = vcpu;
 
-	spin_lock_irqsave(&dist->lpi_list_lock, flags);
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
 
 	/*
 	 * There could be a race with another vgic_add_lpi(), so we need to
@@ -100,7 +100,7 @@ static struct vgic_irq *vgic_add_lpi(str
 	dist->lpi_list_count++;
 
 out_unlock:
-	spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	/*
 	 * We "cache" the configuration table entries in our struct vgic_irq's.
@@ -287,7 +287,7 @@ static int update_lpi_config(struct kvm
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&irq->irq_lock, flags);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
 	if (!filter_vcpu || filter_vcpu == irq->target_vcpu) {
 		irq->priority = LPI_PROP_PRIORITY(prop);
@@ -299,7 +299,7 @@ static int update_lpi_config(struct kvm
 		}
 	}
 
-	spin_unlock_irqrestore(&irq->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 	if (irq->hw)
 		return its_prop_update_vlpi(irq->host_irq, prop, needs_inv);
@@ -332,7 +332,7 @@ static int vgic_copy_lpi_list(struct kvm
 	if (!intids)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&dist->lpi_list_lock, flags);
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
 	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
 		if (i == irq_count)
 			break;
@@ -341,7 +341,7 @@ static int vgic_copy_lpi_list(struct kvm
 			continue;
 		intids[i++] = irq->intid;
 	}
-	spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	*intid_ptr = intids;
 	return i;
@@ -352,9 +352,9 @@ static int update_affinity(struct vgic_i
 	int ret = 0;
 	unsigned long flags;
 
-	spin_lock_irqsave(&irq->irq_lock, flags);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	irq->target_vcpu = vcpu;
-	spin_unlock_irqrestore(&irq->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 	if (irq->hw) {
 		struct its_vlpi_map map;
@@ -455,7 +455,7 @@ static int its_sync_lpi_pending_table(st
 		}
 
 		irq = vgic_get_irq(vcpu->kvm, NULL, intids[i]);
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		irq->pending_latch = pendmask & (1U << bit_nr);
 		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
 		vgic_put_irq(vcpu->kvm, irq);
@@ -612,7 +612,7 @@ static int vgic_its_trigger_msi(struct k
 		return irq_set_irqchip_state(irq->host_irq,
 					     IRQCHIP_STATE_PENDING, true);
 
-	spin_lock_irqsave(&irq->irq_lock, flags);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	irq->pending_latch = true;
 	vgic_queue_irq_unlock(kvm, irq, flags);
 
--- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
@@ -100,7 +100,7 @@ static void vgic_mmio_write_sgir(struct
 
 		irq = vgic_get_irq(source_vcpu->kvm, vcpu, intid);
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		irq->pending_latch = true;
 		irq->source |= 1U << source_vcpu->vcpu_id;
 
@@ -144,13 +144,13 @@ static void vgic_mmio_write_target(struc
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, NULL, intid + i);
 		int target;
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
 		irq->targets = (val >> (i * 8)) & cpu_mask;
 		target = irq->targets ? __ffs(irq->targets) : 0;
 		irq->target_vcpu = kvm_get_vcpu(vcpu->kvm, target);
 
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		vgic_put_irq(vcpu->kvm, irq);
 	}
 }
@@ -183,13 +183,13 @@ static void vgic_mmio_write_sgipendc(str
 	for (i = 0; i < len; i++) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
 		irq->source &= ~((val >> (i * 8)) & 0xff);
 		if (!irq->source)
 			irq->pending_latch = false;
 
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		vgic_put_irq(vcpu->kvm, irq);
 	}
 }
@@ -205,7 +205,7 @@ static void vgic_mmio_write_sgipends(str
 	for (i = 0; i < len; i++) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
 		irq->source |= (val >> (i * 8)) & 0xff;
 
@@ -213,7 +213,7 @@ static void vgic_mmio_write_sgipends(str
 			irq->pending_latch = true;
 			vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
 		} else {
-			spin_unlock_irqrestore(&irq->irq_lock, flags);
+			raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		}
 		vgic_put_irq(vcpu->kvm, irq);
 	}
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -145,13 +145,13 @@ static void vgic_mmio_write_irouter(stru
 	if (!irq)
 		return;
 
-	spin_lock_irqsave(&irq->irq_lock, flags);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
 	/* We only care about and preserve Aff0, Aff1 and Aff2. */
 	irq->mpidr = val & GENMASK(23, 0);
 	irq->target_vcpu = kvm_mpidr_to_vcpu(vcpu->kvm, irq->mpidr);
 
-	spin_unlock_irqrestore(&irq->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 	vgic_put_irq(vcpu->kvm, irq);
 }
 
@@ -252,7 +252,7 @@ static void vgic_v3_uaccess_write_pendin
 	for (i = 0; i < len * 8; i++) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		if (test_bit(i, &val)) {
 			/*
 			 * pending_latch is set irrespective of irq type
@@ -263,7 +263,7 @@ static void vgic_v3_uaccess_write_pendin
 			vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
 		} else {
 			irq->pending_latch = false;
-			spin_unlock_irqrestore(&irq->irq_lock, flags);
+			raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		}
 
 		vgic_put_irq(vcpu->kvm, irq);
@@ -845,7 +845,7 @@ void vgic_v3_dispatch_sgi(struct kvm_vcp
 
 		irq = vgic_get_irq(vcpu->kvm, c_vcpu, sgi);
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		irq->pending_latch = true;
 
 		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -75,7 +75,7 @@ void vgic_mmio_write_senable(struct kvm_
 	for_each_set_bit(i, &val, len * 8) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		irq->enabled = true;
 		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
 
@@ -94,11 +94,11 @@ void vgic_mmio_write_cenable(struct kvm_
 	for_each_set_bit(i, &val, len * 8) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
 		irq->enabled = false;
 
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		vgic_put_irq(vcpu->kvm, irq);
 	}
 }
@@ -115,10 +115,10 @@ unsigned long vgic_mmio_read_pending(str
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
 		unsigned long flags;
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		if (irq_is_pending(irq))
 			value |= (1U << i);
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 		vgic_put_irq(vcpu->kvm, irq);
 	}
@@ -170,7 +170,7 @@ void vgic_mmio_write_spending(struct kvm
 	for_each_set_bit(i, &val, len * 8) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		if (irq->hw)
 			vgic_hw_irq_spending(vcpu, irq, is_uaccess);
 		else
@@ -217,14 +217,14 @@ void vgic_mmio_write_cpending(struct kvm
 	for_each_set_bit(i, &val, len * 8) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
 		if (irq->hw)
 			vgic_hw_irq_cpending(vcpu, irq, is_uaccess);
 		else
 			irq->pending_latch = false;
 
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		vgic_put_irq(vcpu->kvm, irq);
 	}
 }
@@ -266,7 +266,7 @@ static void vgic_mmio_change_active(stru
 	unsigned long flags;
 	struct kvm_vcpu *requester_vcpu = vgic_get_mmio_requester_vcpu();
 
-	spin_lock_irqsave(&irq->irq_lock, flags);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
 	/*
 	 * If this virtual IRQ was written into a list register, we
@@ -287,7 +287,7 @@ static void vgic_mmio_change_active(stru
 	while (irq->vcpu && /* IRQ may have state in an LR somewhere */
 	       irq->vcpu != requester_vcpu && /* Current thread is not the VCPU thread */
 	       irq->vcpu->cpu != -1) /* VCPU thread is running */
-		cond_resched_lock(&irq->irq_lock);
+		raw_cond_resched_lock(&irq->irq_lock);
 
 	if (irq->hw)
 		vgic_hw_irq_change_active(vcpu, irq, active, !requester_vcpu);
@@ -297,7 +297,7 @@ static void vgic_mmio_change_active(stru
 	if (irq->active)
 		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
 	else
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 }
 
 /*
@@ -436,10 +436,10 @@ void vgic_mmio_write_priority(struct kvm
 	for (i = 0; i < len; i++) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		/* Narrow the priority range to what we actually support */
 		irq->priority = (val >> (i * 8)) & GENMASK(7, 8 - VGIC_PRI_BITS);
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 		vgic_put_irq(vcpu->kvm, irq);
 	}
@@ -485,14 +485,14 @@ void vgic_mmio_write_config(struct kvm_v
 			continue;
 
 		irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
 		if (test_bit(i * 2 + 1, &val))
 			irq->config = VGIC_CONFIG_EDGE;
 		else
 			irq->config = VGIC_CONFIG_LEVEL;
 
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		vgic_put_irq(vcpu->kvm, irq);
 	}
 }
@@ -541,12 +541,12 @@ void vgic_write_irq_line_level_info(stru
 		 * restore irq config before line level.
 		 */
 		new_level = !!(val & (1U << i));
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		irq->line_level = new_level;
 		if (new_level)
 			vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
 		else
-			spin_unlock_irqrestore(&irq->irq_lock, flags);
+			raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 		vgic_put_irq(vcpu->kvm, irq);
 	}
--- a/virt/kvm/arm/vgic/vgic-v2.c
+++ b/virt/kvm/arm/vgic/vgic-v2.c
@@ -85,7 +85,7 @@ void vgic_v2_fold_lr_state(struct kvm_vc
 
 		irq = vgic_get_irq(vcpu->kvm, vcpu, intid);
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
 		/* Always preserve the active bit */
 		irq->active = !!(val & GICH_LR_ACTIVE_BIT);
@@ -132,7 +132,7 @@ void vgic_v2_fold_lr_state(struct kvm_vc
 				vgic_irq_set_phys_active(irq, false);
 		}
 
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		vgic_put_irq(vcpu->kvm, irq);
 	}
 
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -75,7 +75,7 @@ void vgic_v3_fold_lr_state(struct kvm_vc
 		if (!irq)	/* An LPI could have been unmapped. */
 			continue;
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
 		/* Always preserve the active bit */
 		irq->active = !!(val & ICH_LR_ACTIVE_BIT);
@@ -123,7 +123,7 @@ void vgic_v3_fold_lr_state(struct kvm_vc
 				vgic_irq_set_phys_active(irq, false);
 		}
 
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		vgic_put_irq(vcpu->kvm, irq);
 	}
 
@@ -335,9 +335,9 @@ int vgic_v3_lpi_sync_pending_status(stru
 
 	status = val & (1 << bit_nr);
 
-	spin_lock_irqsave(&irq->irq_lock, flags);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	if (irq->target_vcpu != vcpu) {
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		goto retry;
 	}
 	irq->pending_latch = status;
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -75,7 +75,7 @@ static struct vgic_irq *vgic_get_lpi(str
 	struct vgic_irq *irq = NULL;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dist->lpi_list_lock, flags);
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
 
 	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
 		if (irq->intid != intid)
@@ -91,7 +91,7 @@ static struct vgic_irq *vgic_get_lpi(str
 	irq = NULL;
 
 out_unlock:
-	spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	return irq;
 }
@@ -137,15 +137,15 @@ void vgic_put_irq(struct kvm *kvm, struc
 	if (irq->intid < VGIC_MIN_LPI)
 		return;
 
-	spin_lock_irqsave(&dist->lpi_list_lock, flags);
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
 	if (!kref_put(&irq->refcount, vgic_irq_release)) {
-		spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+		raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 		return;
 	};
 
 	list_del(&irq->lpi_list);
 	dist->lpi_list_count--;
-	spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	kfree(irq);
 }
@@ -195,7 +195,7 @@ void vgic_irq_set_phys_active(struct vgi
  */
 static struct kvm_vcpu *vgic_target_oracle(struct vgic_irq *irq)
 {
-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
+	DEBUG_SPINLOCK_BUG_ON(!raw_spin_is_locked(&irq->irq_lock));
 
 	/* If the interrupt is active, it must stay on the current vcpu */
 	if (irq->active)
@@ -243,8 +243,8 @@ static int vgic_irq_cmp(void *priv, stru
 	bool penda, pendb;
 	int ret;
 
-	spin_lock(&irqa->irq_lock);
-	spin_lock_nested(&irqb->irq_lock, SINGLE_DEPTH_NESTING);
+	raw_spin_lock(&irqa->irq_lock);
+	raw_spin_lock_nested(&irqb->irq_lock, SINGLE_DEPTH_NESTING);
 
 	if (irqa->active || irqb->active) {
 		ret = (int)irqb->active - (int)irqa->active;
@@ -262,8 +262,8 @@ static int vgic_irq_cmp(void *priv, stru
 	/* Both pending and enabled, sort by priority */
 	ret = irqa->priority - irqb->priority;
 out:
-	spin_unlock(&irqb->irq_lock);
-	spin_unlock(&irqa->irq_lock);
+	raw_spin_unlock(&irqb->irq_lock);
+	raw_spin_unlock(&irqa->irq_lock);
 	return ret;
 }
 
@@ -272,7 +272,7 @@ static void vgic_sort_ap_list(struct kvm
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 
-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
+	DEBUG_SPINLOCK_BUG_ON(!raw_spin_is_locked(&vgic_cpu->ap_list_lock));
 
 	list_sort(NULL, &vgic_cpu->ap_list_head, vgic_irq_cmp);
 }
@@ -310,7 +310,7 @@ bool vgic_queue_irq_unlock(struct kvm *k
 {
 	struct kvm_vcpu *vcpu;
 
-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
+	DEBUG_SPINLOCK_BUG_ON(!raw_spin_is_locked(&irq->irq_lock));
 
 retry:
 	vcpu = vgic_target_oracle(irq);
@@ -324,7 +324,7 @@ bool vgic_queue_irq_unlock(struct kvm *k
 		 * not need to be inserted into an ap_list and there is also
 		 * no more work for us to do.
 		 */
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 		/*
 		 * We have to kick the VCPU here, because we could be
@@ -346,12 +346,12 @@ bool vgic_queue_irq_unlock(struct kvm *k
 	 * We must unlock the irq lock to take the ap_list_lock where
 	 * we are going to insert this new pending interrupt.
 	 */
-	spin_unlock_irqrestore(&irq->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 	/* someone can do stuff here, which we re-check below */
 
-	spin_lock_irqsave(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
-	spin_lock(&irq->irq_lock);
+	raw_spin_lock_irqsave(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
+	raw_spin_lock(&irq->irq_lock);
 
 	/*
 	 * Did something change behind our backs?
@@ -366,10 +366,10 @@ bool vgic_queue_irq_unlock(struct kvm *k
 	 */
 
 	if (unlikely(irq->vcpu || vcpu != vgic_target_oracle(irq))) {
-		spin_unlock(&irq->irq_lock);
-		spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
+		raw_spin_unlock(&irq->irq_lock);
+		raw_spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		goto retry;
 	}
 
@@ -381,8 +381,8 @@ bool vgic_queue_irq_unlock(struct kvm *k
 	list_add_tail(&irq->ap_list, &vcpu->arch.vgic_cpu.ap_list_head);
 	irq->vcpu = vcpu;
 
-	spin_unlock(&irq->irq_lock);
-	spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
+	raw_spin_unlock(&irq->irq_lock);
+	raw_spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
 
 	kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
 	kvm_vcpu_kick(vcpu);
@@ -429,11 +429,11 @@ int kvm_vgic_inject_irq(struct kvm *kvm,
 	if (!irq)
 		return -EINVAL;
 
-	spin_lock_irqsave(&irq->irq_lock, flags);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
 	if (!vgic_validate_injection(irq, level, owner)) {
 		/* Nothing to see here, move along... */
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		vgic_put_irq(kvm, irq);
 		return 0;
 	}
@@ -493,9 +493,9 @@ int kvm_vgic_map_phys_irq(struct kvm_vcp
 
 	BUG_ON(!irq);
 
-	spin_lock_irqsave(&irq->irq_lock, flags);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	ret = kvm_vgic_map_irq(vcpu, irq, host_irq, get_input_level);
-	spin_unlock_irqrestore(&irq->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 	vgic_put_irq(vcpu->kvm, irq);
 
 	return ret;
@@ -518,11 +518,11 @@ void kvm_vgic_reset_mapped_irq(struct kv
 	if (!irq->hw)
 		goto out;
 
-	spin_lock_irqsave(&irq->irq_lock, flags);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	irq->active = false;
 	irq->pending_latch = false;
 	irq->line_level = false;
-	spin_unlock_irqrestore(&irq->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 out:
 	vgic_put_irq(vcpu->kvm, irq);
 }
@@ -538,9 +538,9 @@ int kvm_vgic_unmap_phys_irq(struct kvm_v
 	irq = vgic_get_irq(vcpu->kvm, vcpu, vintid);
 	BUG_ON(!irq);
 
-	spin_lock_irqsave(&irq->irq_lock, flags);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	kvm_vgic_unmap_irq(irq);
-	spin_unlock_irqrestore(&irq->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 	vgic_put_irq(vcpu->kvm, irq);
 
 	return 0;
@@ -570,12 +570,12 @@ int kvm_vgic_set_owner(struct kvm_vcpu *
 		return -EINVAL;
 
 	irq = vgic_get_irq(vcpu->kvm, vcpu, intid);
-	spin_lock_irqsave(&irq->irq_lock, flags);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	if (irq->owner && irq->owner != owner)
 		ret = -EEXIST;
 	else
 		irq->owner = owner;
-	spin_unlock_irqrestore(&irq->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 	return ret;
 }
@@ -595,13 +595,13 @@ static void vgic_prune_ap_list(struct kv
 	unsigned long flags;
 
 retry:
-	spin_lock_irqsave(&vgic_cpu->ap_list_lock, flags);
+	raw_spin_lock_irqsave(&vgic_cpu->ap_list_lock, flags);
 
 	list_for_each_entry_safe(irq, tmp, &vgic_cpu->ap_list_head, ap_list) {
 		struct kvm_vcpu *target_vcpu, *vcpuA, *vcpuB;
 		bool target_vcpu_needs_kick = false;
 
-		spin_lock(&irq->irq_lock);
+		raw_spin_lock(&irq->irq_lock);
 
 		BUG_ON(vcpu != irq->vcpu);
 
@@ -614,7 +614,7 @@ static void vgic_prune_ap_list(struct kv
 			 */
 			list_del(&irq->ap_list);
 			irq->vcpu = NULL;
-			spin_unlock(&irq->irq_lock);
+			raw_spin_unlock(&irq->irq_lock);
 
 			/*
 			 * This vgic_put_irq call matches the
@@ -629,14 +629,14 @@ static void vgic_prune_ap_list(struct kv
 
 		if (target_vcpu == vcpu) {
 			/* We're on the right CPU */
-			spin_unlock(&irq->irq_lock);
+			raw_spin_unlock(&irq->irq_lock);
 			continue;
 		}
 
 		/* This interrupt looks like it has to be migrated. */
 
-		spin_unlock(&irq->irq_lock);
-		spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
+		raw_spin_unlock(&irq->irq_lock);
+		raw_spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
 
 		/*
 		 * Ensure locking order by always locking the smallest
@@ -650,10 +650,10 @@ static void vgic_prune_ap_list(struct kv
 			vcpuB = vcpu;
 		}
 
-		spin_lock_irqsave(&vcpuA->arch.vgic_cpu.ap_list_lock, flags);
-		spin_lock_nested(&vcpuB->arch.vgic_cpu.ap_list_lock,
+		raw_spin_lock_irqsave(&vcpuA->arch.vgic_cpu.ap_list_lock, flags);
+		raw_spin_lock_nested(&vcpuB->arch.vgic_cpu.ap_list_lock,
 				 SINGLE_DEPTH_NESTING);
-		spin_lock(&irq->irq_lock);
+		raw_spin_lock(&irq->irq_lock);
 
 		/*
 		 * If the affinity has been preserved, move the
@@ -673,9 +673,9 @@ static void vgic_prune_ap_list(struct kv
 			target_vcpu_needs_kick = true;
 		}
 
-		spin_unlock(&irq->irq_lock);
-		spin_unlock(&vcpuB->arch.vgic_cpu.ap_list_lock);
-		spin_unlock_irqrestore(&vcpuA->arch.vgic_cpu.ap_list_lock, flags);
+		raw_spin_unlock(&irq->irq_lock);
+		raw_spin_unlock(&vcpuB->arch.vgic_cpu.ap_list_lock);
+		raw_spin_unlock_irqrestore(&vcpuA->arch.vgic_cpu.ap_list_lock, flags);
 
 		if (target_vcpu_needs_kick) {
 			kvm_make_request(KVM_REQ_IRQ_PENDING, target_vcpu);
@@ -685,7 +685,7 @@ static void vgic_prune_ap_list(struct kv
 		goto retry;
 	}
 
-	spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
+	raw_spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
 }
 
 static inline void vgic_fold_lr_state(struct kvm_vcpu *vcpu)
@@ -700,7 +700,7 @@ static inline void vgic_fold_lr_state(st
 static inline void vgic_populate_lr(struct kvm_vcpu *vcpu,
 				    struct vgic_irq *irq, int lr)
 {
-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
+	DEBUG_SPINLOCK_BUG_ON(!raw_spin_is_locked(&irq->irq_lock));
 
 	if (kvm_vgic_global_state.type == VGIC_V2)
 		vgic_v2_populate_lr(vcpu, irq, lr);
@@ -742,10 +742,10 @@ static int compute_ap_list_depth(struct
 
 	*multi_sgi = false;
 
-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
+	DEBUG_SPINLOCK_BUG_ON(!raw_spin_is_locked(&vgic_cpu->ap_list_lock));
 
 	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
-		spin_lock(&irq->irq_lock);
+		raw_spin_lock(&irq->irq_lock);
 		/* GICv2 SGIs can count for more than one... */
 		if (vgic_irq_is_sgi(irq->intid) && irq->source) {
 			int w = hweight8(irq->source);
@@ -755,7 +755,7 @@ static int compute_ap_list_depth(struct
 		} else {
 			count++;
 		}
-		spin_unlock(&irq->irq_lock);
+		raw_spin_unlock(&irq->irq_lock);
 	}
 	return count;
 }
@@ -770,7 +770,7 @@ static void vgic_flush_lr_state(struct k
 	bool multi_sgi;
 	u8 prio = 0xff;
 
-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
+	DEBUG_SPINLOCK_BUG_ON(!raw_spin_is_locked(&vgic_cpu->ap_list_lock));
 
 	count = compute_ap_list_depth(vcpu, &multi_sgi);
 	if (count > kvm_vgic_global_state.nr_lr || multi_sgi)
@@ -779,7 +779,7 @@ static void vgic_flush_lr_state(struct k
 	count = 0;
 
 	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
-		spin_lock(&irq->irq_lock);
+		raw_spin_lock(&irq->irq_lock);
 
 		/*
 		 * If we have multi-SGIs in the pipeline, we need to
@@ -789,7 +789,7 @@ static void vgic_flush_lr_state(struct k
 		 * the AP list has been sorted already.
 		 */
 		if (multi_sgi && irq->priority > prio) {
-			spin_unlock(&irq->irq_lock);
+			raw_spin_unlock(&irq->irq_lock);
 			break;
 		}
 
@@ -802,7 +802,7 @@ static void vgic_flush_lr_state(struct k
 			}
 		}
 
-		spin_unlock(&irq->irq_lock);
+		raw_spin_unlock(&irq->irq_lock);
 
 		if (count == kvm_vgic_global_state.nr_lr) {
 			if (!list_is_last(&irq->ap_list,
@@ -857,9 +857,9 @@ void kvm_vgic_flush_hwstate(struct kvm_v
 
 	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());
 
-	spin_lock(&vcpu->arch.vgic_cpu.ap_list_lock);
+	raw_spin_lock(&vcpu->arch.vgic_cpu.ap_list_lock);
 	vgic_flush_lr_state(vcpu);
-	spin_unlock(&vcpu->arch.vgic_cpu.ap_list_lock);
+	raw_spin_unlock(&vcpu->arch.vgic_cpu.ap_list_lock);
 }
 
 void kvm_vgic_load(struct kvm_vcpu *vcpu)
@@ -897,18 +897,18 @@ int kvm_vgic_vcpu_pending_irq(struct kvm
 	if (vcpu->arch.vgic_cpu.vgic_v3.its_vpe.pending_last)
 		return true;
 
-	spin_lock_irqsave(&vgic_cpu->ap_list_lock, flags);
+	raw_spin_lock_irqsave(&vgic_cpu->ap_list_lock, flags);
 
 	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
-		spin_lock(&irq->irq_lock);
+		raw_spin_lock(&irq->irq_lock);
 		pending = irq_is_pending(irq) && irq->enabled;
-		spin_unlock(&irq->irq_lock);
+		raw_spin_unlock(&irq->irq_lock);
 
 		if (pending)
 			break;
 	}
 
-	spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
+	raw_spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
 
 	return pending;
 }
@@ -940,9 +940,9 @@ bool kvm_vgic_map_is_active(struct kvm_v
 		return false;
 
 	irq = vgic_get_irq(vcpu->kvm, vcpu, vintid);
-	spin_lock_irqsave(&irq->irq_lock, flags);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	map_is_active = irq->hw && irq->active;
-	spin_unlock_irqrestore(&irq->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 	vgic_put_irq(vcpu->kvm, irq);
 
 	return map_is_active;
