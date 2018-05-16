Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbeEPPWR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:22:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752148AbeEPPVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:21:49 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] KVM: x86: hyperv: simplistic HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE}_EX implementation
Date: Wed, 16 May 2018 17:21:30 +0200
Message-Id: <20180516152131.30689-8-vkuznets@redhat.com>
In-Reply-To: <20180516152131.30689-1-vkuznets@redhat.com>
References: <20180516152131.30689-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement HvFlushVirtualAddress{List,Space}Ex hypercalls in the same way
we've implemented non-EX counterparts.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 110 ++++++++++++++++++++++++++++++++++++++++++++------
 arch/x86/kvm/trace.h  |  27 +++++++++++++
 2 files changed, 125 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 0d916606519d..b298391f0f93 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1242,31 +1242,102 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
 		return kvm_hv_get_msr(vcpu, msr, pdata);
 }
 
+static __always_inline int get_sparse_bank_no(u64 valid_bank_mask, int bank_no)
+{
+	int i = 0, j;
+
+	if (!(valid_bank_mask & BIT_ULL(bank_no)))
+		return -1;
+
+	for (j = 0; j < bank_no; j++)
+		if (valid_bank_mask & BIT_ULL(j))
+			i++;
+
+	return i;
+}
+
 static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
-			    u16 rep_cnt)
+			    u16 rep_cnt, bool ex)
 {
 	struct kvm *kvm = current_vcpu->kvm;
 	struct kvm_vcpu_hv *hv_current = &current_vcpu->arch.hyperv;
+	struct hv_tlb_flush_ex flush_ex;
 	struct hv_tlb_flush flush;
 	struct kvm_vcpu *vcpu;
 	unsigned long vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)] = {0};
-	int i;
+	unsigned long valid_bank_mask;
+	u64 sparse_banks[64];
+	int sparse_banks_len, i;
+	bool all_cpus;
 
-	if (unlikely(kvm_read_guest(kvm, ingpa, &flush, sizeof(flush))))
-		return HV_STATUS_INVALID_HYPERCALL_INPUT;
+	if (!ex) {
+		if (unlikely(kvm_read_guest(kvm, ingpa, &flush, sizeof(flush))))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 
-	trace_kvm_hv_flush_tlb(flush.processor_mask, flush.address_space,
-			       flush.flags);
+		trace_kvm_hv_flush_tlb(flush.processor_mask,
+				       flush.address_space, flush.flags);
+
+		sparse_banks[0] = flush.processor_mask;
+		all_cpus = flush.flags & HV_FLUSH_ALL_PROCESSORS;
+	} else {
+		if (unlikely(kvm_read_guest(kvm, ingpa, &flush_ex,
+					    sizeof(flush_ex))))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
+		trace_kvm_hv_flush_tlb_ex(flush_ex.hv_vp_set.valid_bank_mask,
+					  flush_ex.hv_vp_set.format,
+					  flush_ex.address_space,
+					  flush_ex.flags);
+
+		valid_bank_mask = flush_ex.hv_vp_set.valid_bank_mask;
+		all_cpus = flush_ex.hv_vp_set.format !=
+			HV_GENERIC_SET_SPARSE_4K;
+
+		sparse_banks_len = bitmap_weight(&valid_bank_mask, 64) *
+			sizeof(sparse_banks[0]);
+
+		if (!sparse_banks_len && !all_cpus)
+			goto ret_success;
+
+		if (!all_cpus &&
+		    kvm_read_guest(kvm,
+				   ingpa + offsetof(struct hv_tlb_flush_ex,
+						    hv_vp_set.bank_contents),
+				   sparse_banks,
+				   sparse_banks_len))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+	}
 
 	cpumask_clear(&hv_current->tlb_lush);
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
+		int bank = hv->vp_index / 64, sbank = 0;
+
+		if (!all_cpus) {
+			/* Banks >64 can't be represented */
+			if (bank >= 64)
+				continue;
+
+			/* Non-ex hypercalls can only address first 64 vCPUs */
+			if (!ex && bank)
+				continue;
+
+			if (ex) {
+				/*
+				 * Check is the bank of this vCPU is in sparse
+				 * set and get the sparse bank number.
+				 */
+				sbank = get_sparse_bank_no(valid_bank_mask,
+							   bank);
+
+				if (sbank < 0)
+					continue;
+			}
 
-		if (!(flush.flags & HV_FLUSH_ALL_PROCESSORS) &&
-		    (hv->vp_index >= 64 ||
-		    !(flush.processor_mask & BIT_ULL(hv->vp_index))))
-			continue;
+			if (!(sparse_banks[sbank] & BIT_ULL(hv->vp_index % 64)))
+				continue;
+		}
 
 		/*
 		 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we
@@ -1280,6 +1351,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 				    KVM_REQ_TLB_FLUSH | KVM_REQUEST_NO_WAKEUP,
 				    vcpu_bitmap, &hv_current->tlb_lush);
 
+ret_success:
 	/* We always do full TLB flush, set rep_done = rep_cnt. */
 	return (u64)HV_STATUS_SUCCESS |
 		((u64)rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
@@ -1427,14 +1499,28 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
-		ret = kvm_hv_flush_tlb(vcpu, ingpa, rep_cnt);
+		ret = kvm_hv_flush_tlb(vcpu, ingpa, rep_cnt, false);
 		break;
 	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE:
 		if (unlikely(fast || rep)) {
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
-		ret = kvm_hv_flush_tlb(vcpu, ingpa, rep_cnt);
+		ret = kvm_hv_flush_tlb(vcpu, ingpa, rep_cnt, false);
+		break;
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX:
+		if (unlikely(fast || !rep_cnt || rep_idx)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
+		ret = kvm_hv_flush_tlb(vcpu, ingpa, rep_cnt, true);
+		break;
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX:
+		if (unlikely(fast || rep)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
+		ret = kvm_hv_flush_tlb(vcpu, ingpa, rep_cnt, true);
 		break;
 	default:
 		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 47a4fd758743..0f997683404f 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1391,6 +1391,33 @@ TRACE_EVENT(kvm_hv_flush_tlb,
 		  __entry->processor_mask, __entry->address_space,
 		  __entry->flags)
 );
+
+/*
+ * Tracepoint for kvm_hv_flush_tlb_ex.
+ */
+TRACE_EVENT(kvm_hv_flush_tlb_ex,
+	TP_PROTO(u64 valid_bank_mask, u64 format, u64 address_space, u64 flags),
+	TP_ARGS(valid_bank_mask, format, address_space, flags),
+
+	TP_STRUCT__entry(
+		__field(u64, valid_bank_mask)
+		__field(u64, format)
+		__field(u64, address_space)
+		__field(u64, flags)
+	),
+
+	TP_fast_assign(
+		__entry->valid_bank_mask = valid_bank_mask;
+		__entry->format = format;
+		__entry->address_space = address_space;
+		__entry->flags = flags;
+	),
+
+	TP_printk("valid_bank_mask 0x%llx format 0x%llx "
+		  "address_space 0x%llx flags 0x%llx",
+		  __entry->valid_bank_mask, __entry->format,
+		  __entry->address_space, __entry->flags)
+);
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.14.3
