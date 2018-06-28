Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0956C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2E32748F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2E32748F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966386AbeF1NxY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:53:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966310AbeF1NxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:53:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA5AA76F9F;
        Thu, 28 Jun 2018 13:53:20 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0046E20180F5;
        Thu, 28 Jun 2018 13:53:18 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] KVM: x86: hyperv: introduce vp_index_to_vcpu_idx mapping
Date:   Thu, 28 Jun 2018 15:53:10 +0200
Message-Id: <20180628135313.17468-3-vkuznets@redhat.com>
In-Reply-To: <20180628135313.17468-1-vkuznets@redhat.com>
References: <20180628135313.17468-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 28 Jun 2018 13:53:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 28 Jun 2018 13:53:21 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it is easy to get VP index from vCPU index the reverse task is hard.
Basically, to solve it we have to walk all vCPUs checking if their VP index
matches. For hypercalls like HvFlushVirtualAddress{List,Space}* and the
upcoming HvSendSyntheticClusterIpi* where a single CPU may be specified in
the whole set this is obviously sub-optimal.

As VP index can be set to anything <= U32_MAX by userspace using plain
[0..MAX_VP_INDEX] array is not a viable option. Use condensed sorted
array with logarithmic search complexity instead. Use RCU to make read
access as fast as possible and maintain atomicity of updates.

Give vp_idx == U32_MAX a special 'remove only' meaning to keep
vp_idx_to_vcpu_idx()/vp_idx_update() interfaces simple.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  12 +++
 arch/x86/kvm/hyperv.c           | 190 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 187 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c13cd28d9d1b..2dfcdcaaa696 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -747,6 +747,16 @@ struct kvm_apic_map {
 	struct kvm_lapic *phys_map[];
 };
 
+/* Mapping from VP number to vCPU idx */
+struct vp_idx_map {
+	struct rcu_head rcu;
+	int len;
+	struct {
+		u32 vp_idx;
+		u32 vcpu_idx;
+	} vp_idx_elem[];
+};
+
 /* Hyper-V emulation context */
 struct kvm_hv {
 	struct mutex hv_lock;
@@ -765,6 +775,8 @@ struct kvm_hv {
 	u64 hv_reenlightenment_control;
 	u64 hv_tsc_emulation_control;
 	u64 hv_tsc_emulation_status;
+
+	struct vp_idx_map *vp_idx_map;
 };
 
 enum kvm_irqchip_mode {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 63a17bbbf0e5..d676335a5448 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -127,19 +127,161 @@ static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
 	return 0;
 }
 
+static void vp_idx_map_free(struct rcu_head *rcu)
+{
+	struct vp_idx_map *map = container_of(rcu, struct vp_idx_map, rcu);
+
+	kfree(map);
+}
+
+static u32 vp_idx_to_vcpu_idx(struct kvm *kvm, u32 vp_idx)
+{
+	struct kvm_hv *hv = &kvm->arch.hyperv;
+	u32 vcpu_idx = U32_MAX, tmp_vp_idx;
+	int l_index = 0, r_index, tmp_index;
+	struct vp_idx_map *map;
+
+	/*
+	 * Make an educated guess: vp_idx is initialized to == vcpu_idx, it
+	 * stays this way unless changed by userspace.
+	 */
+	if (vp_idx < KVM_MAX_VCPUS) {
+		struct kvm_vcpu *vcpu = kvm_get_vcpu(kvm, vp_idx);
+
+		if (vcpu && vcpu_to_hv_vcpu(vcpu)->vp_index == vp_idx)
+			return vp_idx;
+	}
+
+	rcu_read_lock();
+	map = rcu_dereference(hv->vp_idx_map);
+	if (!map)
+		goto unlock;
+
+	r_index = map->len - 1;
+
+	while (r_index >= l_index) {
+		tmp_index = (r_index + l_index)/2;
+		tmp_vp_idx = map->vp_idx_elem[tmp_index].vp_idx;
+
+		if (tmp_vp_idx == vp_idx) {
+			vcpu_idx = map->vp_idx_elem[tmp_index].vcpu_idx;
+			break;
+		} else if (tmp_vp_idx < vp_idx) {
+			l_index = tmp_index + 1;
+		} else /* (tmp_vp_idx > vp_idx) */ {
+			r_index = tmp_index - 1;
+		}
+	};
+
+unlock:
+	rcu_read_unlock();
+
+	return vcpu_idx;
+}
+
+/*
+ * Atomically updates vp_idx map removing old and adding new vp_idx->vcpu_idx
+ * mapping. vp_idx == U32_MAX means only the old mapping should be removed.
+ */
+static int vp_idx_update(struct kvm_hv *hv, u32 vp_idx, u32 vcpu_idx)
+{
+	struct vp_idx_map *new, *old;
+	int i, add = 1, remove = 1, nindex, oindex;
+	u32 vp_idx_old = U32_MAX;
+	bool added = false;
+	int ret;
+
+	mutex_lock(&hv->hv_lock);
+	old = rcu_dereference_protected(hv->vp_idx_map, &hv->hv_lock);
+	if (!old) {
+		ret = -EFAULT;
+		goto unlock_exit;
+	}
+
+	if (vp_idx == U32_MAX)
+		add = 0;
+
+	for (i = 0; i < old->len; i++) {
+		/* Check if we have stale mapping for vcpu_idx */
+		if (old->vp_idx_elem[i].vcpu_idx == vcpu_idx)
+			vp_idx_old = old->vp_idx_elem[i].vp_idx;
+
+		/* Check if we have another mapping for vp_idx */
+		if (old->vp_idx_elem[i].vp_idx == vp_idx) {
+			ret = -EEXIST;
+			goto unlock_exit;
+		}
+	}
+
+	if (vp_idx_old == U32_MAX)
+		remove = 0;
+
+	new = kmalloc(sizeof(*new) + sizeof(new->vp_idx_elem[0]) *
+		      (old->len + add - remove), GFP_KERNEL);
+	if (!new) {
+		ret = -ENOMEM;
+		goto unlock_exit;
+	}
+	new->len = old->len + add - remove;
+
+	for (nindex = 0, oindex = 0; nindex < new->len; nindex++, oindex++) {
+		/* Appending new element to the very end */
+		if (oindex == old->len) {
+			new->vp_idx_elem[nindex].vp_idx = vp_idx;
+			new->vp_idx_elem[nindex].vcpu_idx = vcpu_idx;
+			break;
+		}
+
+		/* Removing old mapping */
+		if (old->vp_idx_elem[oindex].vp_idx == vp_idx_old) {
+			nindex--;
+			continue;
+		}
+
+		/* Inserting new element */
+		if (old->vp_idx_elem[oindex].vp_idx > vp_idx && !added) {
+			added = true;
+			new->vp_idx_elem[nindex].vp_idx = vp_idx;
+			new->vp_idx_elem[nindex].vcpu_idx = vcpu_idx;
+
+			/*
+			 * We will add the old->vp_idx_elem[oindex] element on
+			 * the next iteration.
+			 */
+			oindex--;
+			continue;
+		}
+
+		/* Nothing special, just copy */
+		new->vp_idx_elem[nindex].vp_idx =
+			old->vp_idx_elem[oindex].vp_idx;
+		new->vp_idx_elem[nindex].vcpu_idx =
+			old->vp_idx_elem[oindex].vcpu_idx;
+
+	}
+	rcu_assign_pointer(hv->vp_idx_map, new);
+	ret = 0;
+
+unlock_exit:
+	mutex_unlock(&hv->hv_lock);
+
+	if (!ret)
+		call_rcu(&old->rcu, vp_idx_map_free);
+
+	return ret;
+}
+
 static struct kvm_vcpu *get_vcpu_by_vpidx(struct kvm *kvm, u32 vpidx)
 {
 	struct kvm_vcpu *vcpu = NULL;
-	int i;
+	u32 vcpu_idx;
+
+	vcpu_idx = vp_idx_to_vcpu_idx(kvm, vpidx);
 
-	if (vpidx < KVM_MAX_VCPUS)
-		vcpu = kvm_get_vcpu(kvm, vpidx);
-	if (vcpu && vcpu_to_hv_vcpu(vcpu)->vp_index == vpidx)
-		return vcpu;
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		if (vcpu_to_hv_vcpu(vcpu)->vp_index == vpidx)
-			return vcpu;
-	return NULL;
+	if (vcpu_idx < KVM_MAX_VCPUS)
+		vcpu = kvm_get_vcpu(kvm, vcpu_idx);
+
+	return vcpu;
 }
 
 static struct kvm_vcpu_hv_synic *synic_get(struct kvm *kvm, u32 vpidx)
@@ -686,6 +828,8 @@ void kvm_hv_vcpu_uninit(struct kvm_vcpu *vcpu)
 
 	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++)
 		stimer_cleanup(&hv_vcpu->stimer[i]);
+
+	vp_idx_update(&vcpu->kvm->arch.hyperv, U32_MAX, kvm_vcpu_get_idx(vcpu));
 }
 
 static void stimer_prepare_msg(struct kvm_vcpu_hv_stimer *stimer)
@@ -727,8 +871,12 @@ void kvm_hv_vcpu_init(struct kvm_vcpu *vcpu)
 void kvm_hv_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
+	struct kvm_hv *hv = &vcpu->kvm->arch.hyperv;
+	int idx;
 
-	hv_vcpu->vp_index = kvm_vcpu_get_idx(vcpu);
+	idx = kvm_vcpu_get_idx(vcpu);
+	if (!vp_idx_update(hv, idx, idx))
+		hv_vcpu->vp_index = idx;
 }
 
 int kvm_hv_activate_synic(struct kvm_vcpu *vcpu, bool dont_zero_synic_pages)
@@ -1038,7 +1186,12 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 
 	switch (msr) {
 	case HV_X64_MSR_VP_INDEX:
-		if (!host)
+		if (!host || (u32)data == U32_MAX)
+			return 1;
+		if (hv->vp_index == (u32)data)
+			break;
+		if (vp_idx_update(&vcpu->kvm->arch.hyperv, (u32)data,
+				  kvm_vcpu_get_idx(vcpu)))
 			return 1;
 		hv->vp_index = (u32)data;
 		break;
@@ -1540,18 +1693,25 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 
 void kvm_hv_init_vm(struct kvm *kvm)
 {
-	mutex_init(&kvm->arch.hyperv.hv_lock);
-	idr_init(&kvm->arch.hyperv.conn_to_evt);
+	struct kvm_hv *hv = &kvm->arch.hyperv;
+
+	mutex_init(&hv->hv_lock);
+	idr_init(&hv->conn_to_evt);
+
+	hv->vp_idx_map = kzalloc(sizeof(*hv->vp_idx_map), GFP_KERNEL);
 }
 
 void kvm_hv_destroy_vm(struct kvm *kvm)
 {
+	struct kvm_hv *hv = &kvm->arch.hyperv;
 	struct eventfd_ctx *eventfd;
 	int i;
 
-	idr_for_each_entry(&kvm->arch.hyperv.conn_to_evt, eventfd, i)
+	idr_for_each_entry(&hv->conn_to_evt, eventfd, i)
 		eventfd_ctx_put(eventfd);
-	idr_destroy(&kvm->arch.hyperv.conn_to_evt);
+	idr_destroy(&hv->conn_to_evt);
+
+	kfree(hv->vp_idx_map);
 }
 
 static int kvm_hv_eventfd_assign(struct kvm *kvm, u32 conn_id, int fd)
-- 
2.14.4

