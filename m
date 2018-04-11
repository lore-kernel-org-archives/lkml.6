Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeDKRVn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 13:21:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751798AbeDKRVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 13:21:40 -0400
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
Subject: [PATCH v2 5/6] KVM: x86: hyperv: simplistic HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE}_EX implementation
Date: Wed, 11 Apr 2018 19:21:25 +0200
Message-Id: <20180411172126.16355-6-vkuznets@redhat.com>
In-Reply-To: <20180411172126.16355-1-vkuznets@redhat.com>
References: <20180411172126.16355-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement HvFlushVirtualAddress{List,Space}Ex hypercalls in a simplistic
way: do full TLB flush with KVM_REQ_TLB_FLUSH and kick vCPUs which are
currently IN_GUEST_MODE.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/trace.h  |  27 ++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index fa26af1e8b7c..7028cd58d5f4 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1301,6 +1301,108 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 		((u64)rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
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
+static __always_inline int load_bank_guest(struct kvm *kvm, u64 ingpa,
+				  int sparse_bank, u64 *bank_contents)
+{
+	int offset;
+
+	offset = offsetof(struct hv_tlb_flush_ex, hv_vp_set.bank_contents) +
+		sizeof(u64) * sparse_bank;
+
+	if (unlikely(kvm_read_guest(kvm, ingpa + offset,
+				    bank_contents, sizeof(u64))))
+		return 1;
+
+	return 0;
+}
+
+static int kvm_hv_flush_tlb_ex(struct kvm_vcpu *current_vcpu, u64 ingpa,
+			       u16 rep_cnt)
+{
+	struct kvm *kvm = current_vcpu->kvm;
+	struct kvm_vcpu_hv *hv_current = &current_vcpu->arch.hyperv;
+	struct hv_tlb_flush_ex flush;
+	struct kvm_vcpu *vcpu;
+	u64 bank_contents, valid_bank_mask;
+	int i, cpu, me, current_sparse_bank = -1;
+	u64 ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+
+	if (unlikely(kvm_read_guest(kvm, ingpa, &flush, sizeof(flush))))
+		return ret;
+
+	valid_bank_mask = flush.hv_vp_set.valid_bank_mask;
+
+	trace_kvm_hv_flush_tlb_ex(valid_bank_mask, flush.hv_vp_set.format,
+				  flush.address_space, flush.flags);
+
+	cpumask_clear(&hv_current->tlb_lush);
+
+	me = get_cpu();
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
+		int bank = hv->vp_index / 64, sparse_bank;
+
+		if (flush.hv_vp_set.format == HV_GENERIC_SET_SPARCE_4K) {
+			/* Check is the bank of this vCPU is in sparse set */
+			sparse_bank = get_sparse_bank_no(valid_bank_mask, bank);
+			if (sparse_bank < 0)
+				continue;
+
+			/*
+			 * Assume hv->vp_index is in ascending order and we can
+			 * optimize by not reloading bank contents for every
+			 * vCPU.
+			 */
+			if (sparse_bank != current_sparse_bank) {
+				if (load_bank_guest(kvm, ingpa, sparse_bank,
+						    &bank_contents))
+					return ret;
+				current_sparse_bank = sparse_bank;
+			}
+
+			if (!(bank_contents & BIT_ULL(hv->vp_index % 64)))
+				continue;
+		}
+
+		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
+
+		/*
+		 * It is possible that vCPU will migrate and we will kick wrong
+		 * CPU but vCPU's TLB will anyway be flushed upon migration as
+		 * we already made KVM_REQ_TLB_FLUSH request.
+		 */
+		cpu = vcpu->cpu;
+		if (cpu != -1 && cpu != me && cpu_online(cpu) &&
+		    kvm_arch_vcpu_should_kick(vcpu))
+			cpumask_set_cpu(cpu, &hv_current->tlb_lush);
+	}
+
+	if (!cpumask_empty(&hv_current->tlb_lush))
+		smp_call_function_many(&hv_current->tlb_lush, ack_flush,
+				       NULL, true);
+
+	put_cpu();
+
+	/* We always do full TLB flush, set rep_done = rep_cnt. */
+	return (u64)HV_STATUS_SUCCESS |
+		((u64)rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
+}
+
 bool kvm_hv_hypercall_enabled(struct kvm *kvm)
 {
 	return READ_ONCE(kvm->arch.hyperv.hv_hypercall) & HV_X64_MSR_HYPERCALL_ENABLE;
@@ -1450,6 +1552,20 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		}
 		ret = kvm_hv_flush_tlb(vcpu, ingpa, rep_cnt);
 		break;
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX:
+		if (unlikely(fast || !rep_cnt || rep_idx)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
+		ret = kvm_hv_flush_tlb_ex(vcpu, ingpa, rep_cnt);
+		break;
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX:
+		if (unlikely(fast || rep)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
+		ret = kvm_hv_flush_tlb_ex(vcpu, ingpa, rep_cnt);
+		break;
 	default:
 		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
 		break;
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
