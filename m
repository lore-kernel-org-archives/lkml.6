Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F43C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E927E208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E927E208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeH0Ugo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:36:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727471AbeH0Ugn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:36:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DF1A402212B;
        Mon, 27 Aug 2018 16:49:21 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 155EF2166B41;
        Mon, 27 Aug 2018 16:49:17 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: [PATCH v5 5/5] KVM: x86: hyperv: implement PV IPI send hypercalls
Date:   Mon, 27 Aug 2018 18:48:58 +0200
Message-Id: <20180827164858.12496-6-vkuznets@redhat.com>
In-Reply-To: <20180827164858.12496-1-vkuznets@redhat.com>
References: <20180827164858.12496-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 16:49:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 16:49:21 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using hypercall for sending IPIs is faster because this allows to specify
any number of vCPUs (even > 64 with sparse CPU set), the whole procedure
will take only one VMEXIT.

Current Hyper-V TLFS (v5.0b) claims that HvCallSendSyntheticClusterIpi
hypercall can't be 'fast' (passing parameters through registers) but
apparently this is not true, Windows always uses it as 'fast' so we need
to support that.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 Documentation/virtual/kvm/api.txt |   7 +++
 arch/x86/kvm/hyperv.c             | 105 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/trace.h              |  42 +++++++++++++++
 arch/x86/kvm/x86.c                |   1 +
 include/uapi/linux/kvm.h          |   1 +
 5 files changed, 156 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index c664064f76fb..d6fb93f22c0b 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4762,3 +4762,10 @@ CPU when the exception is taken. If this virtual SError is taken to EL1 using
 AArch64, this value will be reported in the ISS field of ESR_ELx.
 
 See KVM_CAP_VCPU_EVENTS for more details.
+8.20 KVM_CAP_HYPERV_SEND_IPI
+
+Architectures: x86
+
+This capability indicates that KVM supports paravirtualized Hyper-V IPI send
+hypercalls:
+HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index d1a911132b59..dadec987a39b 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1360,6 +1360,97 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 		((u64)rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
 }
 
+static u64 kvm_hv_send_ipi(struct kvm_vcpu *current_vcpu, u64 ingpa, u64 outgpa,
+			   bool ex, bool fast)
+{
+	struct kvm *kvm = current_vcpu->kvm;
+	struct hv_send_ipi_ex send_ipi_ex;
+	struct hv_send_ipi send_ipi;
+	struct kvm_vcpu *vcpu;
+	unsigned long valid_bank_mask;
+	u64 sparse_banks[64];
+	int sparse_banks_len, bank, i;
+	struct kvm_lapic_irq irq = {.delivery_mode = APIC_DM_FIXED};
+	bool all_cpus;
+
+	if (!ex) {
+		if (!fast) {
+			if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi,
+						    sizeof(send_ipi))))
+				return HV_STATUS_INVALID_HYPERCALL_INPUT;
+			sparse_banks[0] = send_ipi.cpu_mask;
+			irq.vector = send_ipi.vector;
+		} else {
+			/* 'reserved' part of hv_send_ipi should be 0 */
+			if (unlikely(ingpa >> 32 != 0))
+				return HV_STATUS_INVALID_HYPERCALL_INPUT;
+			sparse_banks[0] = outgpa;
+			irq.vector = (u32)ingpa;
+		}
+		all_cpus = false;
+		valid_bank_mask = BIT_ULL(0);
+
+		trace_kvm_hv_send_ipi(irq.vector, sparse_banks[0]);
+	} else {
+		if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi_ex,
+					    sizeof(send_ipi_ex))))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
+		trace_kvm_hv_send_ipi_ex(send_ipi_ex.vector,
+					 send_ipi_ex.vp_set.format,
+					 send_ipi_ex.vp_set.valid_bank_mask);
+
+		irq.vector = send_ipi_ex.vector;
+		valid_bank_mask = send_ipi_ex.vp_set.valid_bank_mask;
+		sparse_banks_len = bitmap_weight(&valid_bank_mask, 64) *
+			sizeof(sparse_banks[0]);
+
+		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
+
+		if (!sparse_banks_len)
+			goto ret_success;
+
+		if (!all_cpus &&
+		    kvm_read_guest(kvm,
+				   ingpa + offsetof(struct hv_send_ipi_ex,
+						    vp_set.bank_contents),
+				   sparse_banks,
+				   sparse_banks_len))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+	}
+
+	if ((irq.vector < HV_IPI_LOW_VECTOR) ||
+	    (irq.vector > HV_IPI_HIGH_VECTOR))
+		return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
+	if (all_cpus) {
+		kvm_for_each_vcpu(i, vcpu, kvm) {
+			/* We fail only when APIC is disabled */
+			if (!kvm_apic_set_irq(vcpu, &irq, NULL))
+				return HV_STATUS_INVALID_HYPERCALL_INPUT;
+		}
+		goto ret_success;
+	}
+
+	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask, 64) {
+		for_each_set_bit(i, (unsigned long *)&sparse_banks[bank], 64) {
+			u32 vp_index = bank * 64 + i;
+			struct kvm_vcpu *vcpu =
+				get_vcpu_by_vpidx(kvm, vp_index);
+
+			/* Unknown vCPU specified */
+			if (!vcpu)
+				continue;
+
+			/* We fail only when APIC is disabled */
+			kvm_apic_set_irq(vcpu, &irq, NULL);
+		}
+	}
+
+ret_success:
+	return HV_STATUS_SUCCESS;
+}
+
 bool kvm_hv_hypercall_enabled(struct kvm *kvm)
 {
 	return READ_ONCE(kvm->arch.hyperv.hv_hypercall) & HV_X64_MSR_HYPERCALL_ENABLE;
@@ -1529,6 +1620,20 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		}
 		ret = kvm_hv_flush_tlb(vcpu, ingpa, rep_cnt, true);
 		break;
+	case HVCALL_SEND_IPI:
+		if (unlikely(rep)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
+		ret = kvm_hv_send_ipi(vcpu, ingpa, outgpa, false, fast);
+		break;
+	case HVCALL_SEND_IPI_EX:
+		if (unlikely(fast || rep)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
+		ret = kvm_hv_send_ipi(vcpu, ingpa, outgpa, true, false);
+		break;
 	default:
 		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
 		break;
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 0f997683404f..0659465a745c 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1418,6 +1418,48 @@ TRACE_EVENT(kvm_hv_flush_tlb_ex,
 		  __entry->valid_bank_mask, __entry->format,
 		  __entry->address_space, __entry->flags)
 );
+
+/*
+ * Tracepoints for kvm_hv_send_ipi.
+ */
+TRACE_EVENT(kvm_hv_send_ipi,
+	TP_PROTO(u32 vector, u64 processor_mask),
+	TP_ARGS(vector, processor_mask),
+
+	TP_STRUCT__entry(
+		__field(u32, vector)
+		__field(u64, processor_mask)
+	),
+
+	TP_fast_assign(
+		__entry->vector = vector;
+		__entry->processor_mask = processor_mask;
+	),
+
+	TP_printk("vector %x processor_mask 0x%llx",
+		  __entry->vector, __entry->processor_mask)
+);
+
+TRACE_EVENT(kvm_hv_send_ipi_ex,
+	TP_PROTO(u32 vector, u64 format, u64 valid_bank_mask),
+	TP_ARGS(vector, format, valid_bank_mask),
+
+	TP_STRUCT__entry(
+		__field(u32, vector)
+		__field(u64, format)
+		__field(u64, valid_bank_mask)
+	),
+
+	TP_fast_assign(
+		__entry->vector = vector;
+		__entry->format = format;
+		__entry->valid_bank_mask = valid_bank_mask;
+	),
+
+	TP_printk("vector %x format %llx valid_bank_mask 0x%llx",
+		  __entry->vector, __entry->format,
+		  __entry->valid_bank_mask)
+);
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 14ee9a814888..504e1fa4ae69 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2910,6 +2910,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_VP_INDEX:
 	case KVM_CAP_HYPERV_EVENTFD:
 	case KVM_CAP_HYPERV_TLBFLUSH:
+	case KVM_CAP_HYPERV_SEND_IPI:
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
 	case KVM_CAP_X86_ROBUST_SINGLESTEP:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 07548de5c988..8ab11c8d95fd 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -952,6 +952,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_HPAGE_1M 156
 #define KVM_CAP_NESTED_STATE 157
 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
+#define KVM_CAP_HYPERV_SEND_IPI 159
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.14.4

