Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754885AbeDPLJB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:09:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754834AbeDPLIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:08:18 -0400
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
Subject: [PATCH v3 4/6] KVM: x86: hyperv: simplistic HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} implementation
Date: Mon, 16 Apr 2018 13:08:04 +0200
Message-Id: <20180416110806.4896-5-vkuznets@redhat.com>
In-Reply-To: <20180416110806.4896-1-vkuznets@redhat.com>
References: <20180416110806.4896-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement HvFlushVirtualAddress{List,Space} hypercalls in a simplistic way:
do full TLB flush with KVM_REQ_TLB_FLUSH and kick vCPUs which are currently
IN_GUEST_MODE.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/hyperv.c           | 74 ++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/trace.h            | 24 +++++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c25775fad4ed..9ce1fb2b6af3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -476,6 +476,7 @@ struct kvm_vcpu_hv {
 	struct kvm_hyperv_exit exit;
 	struct kvm_vcpu_hv_stimer stimer[HV_SYNIC_STIMER_COUNT];
 	DECLARE_BITMAP(stimer_pending_bitmap, HV_SYNIC_STIMER_COUNT);
+	cpumask_t tlb_lush;
 };
 
 struct kvm_vcpu_arch {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 67788d358200..fa26af1e8b7c 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1242,6 +1242,65 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
 		return kvm_hv_get_msr(vcpu, msr, pdata);
 }
 
+static void ack_flush(void *_completed)
+{
+}
+
+static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
+			    u16 rep_cnt)
+{
+	struct kvm *kvm = current_vcpu->kvm;
+	struct kvm_vcpu_hv *hv_current = &current_vcpu->arch.hyperv;
+	struct hv_tlb_flush flush;
+	struct kvm_vcpu *vcpu;
+	int i, cpu, me;
+
+	if (unlikely(kvm_read_guest(kvm, ingpa, &flush, sizeof(flush))))
+		return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
+	trace_kvm_hv_flush_tlb(flush.processor_mask, flush.address_space,
+			       flush.flags);
+
+	cpumask_clear(&hv_current->tlb_lush);
+
+	me = get_cpu();
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
+
+		if (!(flush.flags & HV_FLUSH_ALL_PROCESSORS) &&
+		    !(flush.processor_mask & BIT_ULL(hv->vp_index)))
+			continue;
+
+		/*
+		 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we
+		 * can't analyze it here, flush TLB regardless of the specified
+		 * address space.
+		 */
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
@@ -1377,12 +1436,25 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		vcpu->arch.complete_userspace_io =
 				kvm_hv_hypercall_complete_userspace;
 		return 0;
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST:
+		if (unlikely(fast || !rep_cnt || rep_idx)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
+		ret = kvm_hv_flush_tlb(vcpu, ingpa, rep_cnt);
+		break;
+	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE:
+		if (unlikely(fast || rep)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
+		ret = kvm_hv_flush_tlb(vcpu, ingpa, rep_cnt);
+		break;
 	default:
 		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
 		break;
 	}
 
-set_result:
 	kvm_hv_hypercall_set_result(vcpu, ret);
 	return 1;
 }
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 9807c314c478..47a4fd758743 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1367,6 +1367,30 @@ TRACE_EVENT(kvm_hv_timer_state,
 			__entry->vcpu_id,
 			__entry->hv_timer_in_use)
 );
+
+/*
+ * Tracepoint for kvm_hv_flush_tlb.
+ */
+TRACE_EVENT(kvm_hv_flush_tlb,
+	TP_PROTO(u64 processor_mask, u64 address_space, u64 flags),
+	TP_ARGS(processor_mask, address_space, flags),
+
+	TP_STRUCT__entry(
+		__field(u64, processor_mask)
+		__field(u64, address_space)
+		__field(u64, flags)
+	),
+
+	TP_fast_assign(
+		__entry->processor_mask = processor_mask;
+		__entry->address_space = address_space;
+		__entry->flags = flags;
+	),
+
+	TP_printk("processor_mask 0x%llx address_space 0x%llx flags 0x%llx",
+		  __entry->processor_mask, __entry->address_space,
+		  __entry->flags)
+);
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.14.3
