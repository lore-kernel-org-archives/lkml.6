Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE58BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956A520869
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956A520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbeKNBVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:21:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387812AbeKNBVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:21:07 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D364C037F90;
        Tue, 13 Nov 2018 15:22:32 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.34.244.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A8BC1001938;
        Tue, 13 Nov 2018 15:22:27 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH 3/3] x86/kvm/hyper-v: direct mode for synthetic timers
Date:   Tue, 13 Nov 2018 16:22:16 +0100
Message-Id: <20181113152218.22049-4-vkuznets@redhat.com>
In-Reply-To: <20181113152218.22049-1-vkuznets@redhat.com>
References: <20181113152218.22049-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 13 Nov 2018 15:22:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out Hyper-V on KVM (as of 2016) will only use synthetic timers
if direct mode is available. With direct mode we notify the guest by
asserting APIC irq instead of sending a SynIC message.

The implementation uses existing vec_bitmap for letting lapic code
know that we're interested in the particular IRQ's EOI request. We assume
that the same APIC irq won't be used by the guest for both direct mode
stimer and as sint source (especially with AutoEOI semantics). It is
unclear how things should be handled if that's not true.

Direct mode is also somewhat less expensive; in my testing
stimer_send_msg() takes not less than 1500 cpu cycles and
stimer_notify_direct() can usually be done in 300-400. WS2016 without
Hyper-V, however, always sticks to non-direct version.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c    | 71 +++++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/trace.h     | 10 +++---
 arch/x86/kvm/x86.c       |  1 +
 include/uapi/linux/kvm.h |  1 +
 4 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index eaec15c738df..c451793bf758 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -53,8 +53,21 @@ static inline int synic_get_sint_vector(u64 sint_value)
 static bool synic_has_vector_connected(struct kvm_vcpu_hv_synic *synic,
 				      int vector)
 {
+	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
+	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
+	struct kvm_vcpu_hv_stimer *stimer;
 	int i;
 
+	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
+		stimer = &hv_vcpu->stimer[i];
+		if (stimer->config.enable && stimer->config.direct_mode &&
+		    stimer->config.apic_vector == vector)
+			return true;
+	}
+
+	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(synic->sint); i++) {
 		if (synic_get_sint_vector(synic_read_sint(synic, i)) == vector)
 			return true;
@@ -80,14 +93,14 @@ static bool synic_has_vector_auto_eoi(struct kvm_vcpu_hv_synic *synic,
 static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
 				int vector)
 {
-	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
-		return;
-
 	if (synic_has_vector_connected(synic, vector))
 		__set_bit(vector, synic->vec_bitmap);
 	else
 		__clear_bit(vector, synic->vec_bitmap);
 
+	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
+		return;
+
 	if (synic_has_vector_auto_eoi(synic, vector))
 		__set_bit(vector, synic->auto_eoi_bitmap);
 	else
@@ -202,6 +215,7 @@ static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
 	for (idx = 0; idx < ARRAY_SIZE(hv_vcpu->stimer); idx++) {
 		stimer = &hv_vcpu->stimer[idx];
 		if (stimer->msg_pending && stimer->config.enable &&
+		    !stimer->config.direct_mode &&
 		    stimer->config.sintx == sint) {
 			set_bit(stimer->index,
 				hv_vcpu->stimer_pending_bitmap);
@@ -371,14 +385,29 @@ int kvm_hv_synic_set_irq(struct kvm *kvm, u32 vpidx, u32 sint)
 
 void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector)
 {
+	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
 	struct kvm_vcpu_hv_synic *synic = vcpu_to_synic(vcpu);
-	int i;
+	struct kvm_vcpu_hv_stimer *stimer;
+	int i, stimers_pending = 0;
 
 	trace_kvm_hv_synic_send_eoi(vcpu->vcpu_id, vector);
 
 	for (i = 0; i < ARRAY_SIZE(synic->sint); i++)
 		if (synic_get_sint_vector(synic_read_sint(synic, i)) == vector)
 			kvm_hv_notify_acked_sint(vcpu, i);
+
+	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
+		stimer = &hv_vcpu->stimer[i];
+		if (stimer->msg_pending && stimer->config.enable &&
+		    stimer->config.direct_mode &&
+		    stimer->config.apic_vector == vector) {
+			set_bit(stimer->index,
+				hv_vcpu->stimer_pending_bitmap);
+			stimers_pending++;
+		}
+	}
+	if (stimers_pending)
+		kvm_make_request(KVM_REQ_HV_STIMER, vcpu);
 }
 
 static int kvm_hv_set_sint_gsi(struct kvm *kvm, u32 vpidx, u32 sint, int gsi)
@@ -545,15 +574,25 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
 static int stimer_set_config(struct kvm_vcpu_hv_stimer *stimer, u64 config,
 			     bool host)
 {
-	union hv_stimer_config new_config = {.as_uint64 = config};
+	struct kvm_vcpu *vcpu = stimer_to_vcpu(stimer);
+	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
+	union hv_stimer_config new_config = {.as_uint64 = config},
+		old_config = {.as_uint64 = stimer->config.as_uint64};
 
 	trace_kvm_hv_stimer_set_config(stimer_to_vcpu(stimer)->vcpu_id,
 				       stimer->index, config, host);
 
 	stimer_cleanup(stimer);
-	if (stimer->config.enable && new_config.sintx == 0)
+	if (old_config.enable &&
+	    !new_config.direct_mode && new_config.sintx == 0)
 		new_config.enable = 0;
 	stimer->config.as_uint64 = new_config.as_uint64;
+
+	if (old_config.direct_mode)
+		synic_update_vector(&hv_vcpu->synic, old_config.apic_vector);
+	if (new_config.direct_mode)
+		synic_update_vector(&hv_vcpu->synic, new_config.apic_vector);
+
 	stimer_mark_pending(stimer, false);
 	return 0;
 }
@@ -640,14 +679,28 @@ static int stimer_send_msg(struct kvm_vcpu_hv_stimer *stimer)
 				 stimer->config.sintx, msg);
 }
 
+static int stimer_notify_direct(struct kvm_vcpu_hv_stimer *stimer)
+{
+	struct kvm_vcpu *vcpu = stimer_to_vcpu(stimer);
+	struct kvm_lapic_irq irq = {
+		.delivery_mode = APIC_DM_FIXED,
+		.vector = stimer->config.apic_vector
+	};
+
+	return !kvm_apic_set_irq(vcpu, &irq, NULL);
+}
+
 static void stimer_expiration(struct kvm_vcpu_hv_stimer *stimer)
 {
-	int r;
+	int r, direct = stimer->config.direct_mode;
 
 	stimer->msg_pending = true;
-	r = stimer_send_msg(stimer);
+	if (!direct)
+		r = stimer_send_msg(stimer);
+	else
+		r = stimer_notify_direct(stimer);
 	trace_kvm_hv_stimer_expiration(stimer_to_vcpu(stimer)->vcpu_id,
-				       stimer->index, r);
+				       stimer->index, direct, r);
 	if (!r) {
 		stimer->msg_pending = false;
 		if (!(stimer->config.periodic))
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 0659465a745c..705f40ae2532 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1254,24 +1254,26 @@ TRACE_EVENT(kvm_hv_stimer_callback,
  * Tracepoint for stimer_expiration.
  */
 TRACE_EVENT(kvm_hv_stimer_expiration,
-	TP_PROTO(int vcpu_id, int timer_index, int msg_send_result),
-	TP_ARGS(vcpu_id, timer_index, msg_send_result),
+	TP_PROTO(int vcpu_id, int timer_index, int direct, int msg_send_result),
+	TP_ARGS(vcpu_id, timer_index, direct, msg_send_result),
 
 	TP_STRUCT__entry(
 		__field(int, vcpu_id)
 		__field(int, timer_index)
+		__field(int, direct)
 		__field(int, msg_send_result)
 	),
 
 	TP_fast_assign(
 		__entry->vcpu_id = vcpu_id;
 		__entry->timer_index = timer_index;
+		__entry->direct = direct;
 		__entry->msg_send_result = msg_send_result;
 	),
 
-	TP_printk("vcpu_id %d timer %d msg send result %d",
+	TP_printk("vcpu_id %d timer %d direct %d send result %d",
 		  __entry->vcpu_id, __entry->timer_index,
-		  __entry->msg_send_result)
+		  __entry->direct, __entry->msg_send_result)
 );
 
 /*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5cd5647120f2..b21b5ceb8d26 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2997,6 +2997,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_TLBFLUSH:
 	case KVM_CAP_HYPERV_SEND_IPI:
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
+	case KVM_CAP_HYPERV_STIMER_DIRECT:
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
 	case KVM_CAP_X86_ROBUST_SINGLESTEP:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2b7a652c9fa4..b8da14cee8e5 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -975,6 +975,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
+#define KVM_CAP_HYPERV_STIMER_DIRECT 166
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.17.2

