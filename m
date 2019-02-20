Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88614C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471F32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hgZxKqZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfBTUVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:21:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35362 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfBTURv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8fJJ087627;
        Wed, 20 Feb 2019 20:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=WA5tVmPGiyTbR+w8aie+g3q7493Oumr1VfMgf/HFYL4=;
 b=hgZxKqZ3ohnMpGS0b2ik2rt1//i4DoVo9WbHgxahyBRo4Ios5OHO5eGO9a6CtcxmHDWA
 1qaxnTOWFw1+YRrLvQFlkO81CjI5W+Wfl8waR6UCogQbqPeZdw35pGC8hzEhfbNuCsVx
 yPcTcx+Afa6GJxW3wqmU+tTkNXdY3nybW+FUyLxXyL5ISQHuidBb0c9v+4GurGONV7as
 yjOg4AfvNq3CE1Dp25HNSoEoXC1n7227sA3pyiIOGdmv0t1jS6vreQ60W+0V54O/coql
 PfpAVIUgNCasblXo3g+Vswuvp1EFP7RVBCfyKtfxeFxsOhAIYI8hhmQvi3pjxv0Z3iHd kQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qpb5rktqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:36 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHZJv026107
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:36 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHZXl009502;
        Wed, 20 Feb 2019 20:17:35 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:35 -0800
From:   Joao Martins <joao.m.martins@oracle.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH RFC 13/39] KVM: x86/xen: handle PV timers oneshot mode
Date:   Wed, 20 Feb 2019 20:15:43 +0000
Message-Id: <20190220201609.28290-14-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the guest has offloaded the timer virq, handle the following
hypercalls for programming the timer:

    VCPUOP_set_singleshot_timer
    VCPUOP_stop_singleshot_timer
    set_timer_op(timestamp_ns)

The event channel corresponding to the timer virq is then used to inject
events once timer deadlines are met. For now we back the PV timer with
hrtimer.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |   2 +
 arch/x86/kvm/irq.c              |  11 ++-
 arch/x86/kvm/x86.c              |   4 +
 arch/x86/kvm/xen.c              | 185 +++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/xen.h              |   6 ++
 5 files changed, 202 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 92b76127eb43..7fcc81dbb688 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -552,6 +552,8 @@ struct kvm_vcpu_xen {
 	struct kvm_xen_callback cb;
 #define KVM_XEN_NR_VIRQS 24
 	unsigned int virq_to_port[KVM_XEN_NR_VIRQS];
+	struct hrtimer timer;
+	atomic_t timer_pending;
 };
 
 struct kvm_vcpu_arch {
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index cdb1dbfcc9b1..936c31ae019a 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -34,10 +34,14 @@
  */
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 {
+	int r = 0;
+
 	if (lapic_in_kernel(vcpu))
-		return apic_has_pending_timer(vcpu);
+		r = apic_has_pending_timer(vcpu);
+	if (kvm_xen_timer_enabled(vcpu))
+		r += kvm_xen_has_pending_timer(vcpu);
 
-	return 0;
+	return r;
 }
 EXPORT_SYMBOL(kvm_cpu_has_pending_timer);
 
@@ -172,6 +176,8 @@ void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu)
 {
 	if (lapic_in_kernel(vcpu))
 		kvm_inject_apic_timer_irqs(vcpu);
+	if (kvm_xen_timer_enabled(vcpu))
+		kvm_xen_inject_timer_irqs(vcpu);
 }
 EXPORT_SYMBOL_GPL(kvm_inject_pending_timer_irqs);
 
@@ -179,4 +185,5 @@ void __kvm_migrate_timers(struct kvm_vcpu *vcpu)
 {
 	__kvm_migrate_apic_timer(vcpu);
 	__kvm_migrate_pit_timer(vcpu);
+	__kvm_migrate_xen_timer(vcpu);
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 76bd23113ccd..e29cefd2dc6a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9115,6 +9115,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	vcpu->arch.preempted_in_kernel = false;
 
 	kvm_hv_vcpu_init(vcpu);
+	kvm_xen_vcpu_init(vcpu);
 
 	return 0;
 
@@ -9566,6 +9567,9 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_hv_has_stimer_pending(vcpu))
 		return true;
 
+	if (kvm_xen_has_pending_timer(vcpu))
+		return true;
+
 	return false;
 }
 
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 42c1fe01600d..ec40cb1de6b6 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -32,6 +32,7 @@ struct evtchnfd {
 	};
 };
 
+static int kvm_xen_evtchn_send(struct kvm_vcpu *vcpu, int port);
 static void *xen_vcpu_info(struct kvm_vcpu *v);
 
 int kvm_xen_has_interrupt(struct kvm_vcpu *vcpu)
@@ -101,6 +102,91 @@ static void kvm_xen_evtchnfd_upcall(struct kvm_vcpu *vcpu, struct evtchnfd *e)
 	kvm_xen_do_upcall(vcpu->kvm, e->vcpu, vx->cb.via, vx->cb.vector, 0);
 }
 
+int kvm_xen_has_pending_timer(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+
+	if (kvm_xen_hypercall_enabled(vcpu->kvm) && kvm_xen_timer_enabled(vcpu))
+		return atomic_read(&vcpu_xen->timer_pending);
+
+	return 0;
+}
+
+void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+
+	if (atomic_read(&vcpu_xen->timer_pending) > 0) {
+		kvm_xen_evtchn_send(vcpu, vcpu_xen->virq_to_port[VIRQ_TIMER]);
+
+		atomic_set(&vcpu_xen->timer_pending, 0);
+	}
+}
+
+static enum hrtimer_restart xen_timer_callback(struct hrtimer *timer)
+{
+	struct kvm_vcpu_xen *vcpu_xen =
+		container_of(timer, struct kvm_vcpu_xen, timer);
+	struct kvm_vcpu *vcpu = xen_vcpu_to_vcpu(vcpu_xen);
+	struct swait_queue_head *wq = &vcpu->wq;
+
+	if (atomic_read(&vcpu_xen->timer_pending))
+		return HRTIMER_NORESTART;
+
+	atomic_inc(&vcpu_xen->timer_pending);
+	kvm_set_pending_timer(vcpu);
+
+	if (swait_active(wq))
+		swake_up_one(wq);
+
+	return HRTIMER_NORESTART;
+}
+
+void __kvm_migrate_xen_timer(struct kvm_vcpu *vcpu)
+{
+	struct hrtimer *timer;
+
+	if (!kvm_xen_timer_enabled(vcpu))
+		return;
+
+	timer = &vcpu->arch.xen.timer;
+	if (hrtimer_cancel(timer))
+		hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED);
+}
+
+static void kvm_xen_start_timer(struct kvm_vcpu *vcpu, u64 delta_ns)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+	struct hrtimer *timer = &vcpu_xen->timer;
+	ktime_t ktime_now;
+
+	atomic_set(&vcpu_xen->timer_pending, 0);
+	ktime_now = ktime_get();
+	hrtimer_start(timer, ktime_add_ns(ktime_now, delta_ns),
+		      HRTIMER_MODE_ABS_PINNED);
+}
+
+static void kvm_xen_stop_timer(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+
+	hrtimer_cancel(&vcpu_xen->timer);
+}
+
+void kvm_xen_init_timer(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+
+	hrtimer_init(&vcpu_xen->timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_ABS_PINNED);
+	vcpu_xen->timer.function = xen_timer_callback;
+}
+
+bool kvm_xen_timer_enabled(struct kvm_vcpu *vcpu)
+{
+	return !!vcpu->arch.xen.virq_to_port[VIRQ_TIMER];
+}
+
 void kvm_xen_set_virq(struct kvm *kvm, struct evtchnfd *evt)
 {
 	int virq = evt->virq.type;
@@ -111,6 +197,9 @@ void kvm_xen_set_virq(struct kvm *kvm, struct evtchnfd *evt)
 	if (!vcpu)
 		return;
 
+	if (virq == VIRQ_TIMER)
+		kvm_xen_init_timer(vcpu);
+
 	vcpu_xen = vcpu_to_xen_vcpu(vcpu);
 	vcpu_xen->virq_to_port[virq] = evt->port;
 }
@@ -514,6 +603,71 @@ static int kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, int cmd, u64 param)
 	return kvm_xen_evtchn_send(vcpu, send.port);
 }
 
+static int kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, int cmd, int vcpu_id,
+				 u64 param)
+{
+	struct vcpu_set_singleshot_timer oneshot;
+	int ret = -EINVAL;
+	long delta;
+	gpa_t gpa;
+	int idx;
+
+	/* Only process timer ops with commands 6 to 9 */
+	if (cmd < VCPUOP_set_periodic_timer ||
+	    cmd > VCPUOP_stop_singleshot_timer)
+		return ret;
+
+	if (!kvm_xen_timer_enabled(vcpu))
+		return ret;
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	gpa = kvm_mmu_gva_to_gpa_system(vcpu, param, NULL);
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	if (!gpa)
+		return ret;
+
+	switch (cmd) {
+	case VCPUOP_set_singleshot_timer:
+		if (kvm_vcpu_read_guest(vcpu, gpa, &oneshot,
+					sizeof(oneshot)))
+			return -EFAULT;
+
+		delta = oneshot.timeout_abs_ns - get_kvmclock_ns(vcpu->kvm);
+		kvm_xen_start_timer(vcpu, delta);
+		ret = 0;
+		break;
+	case VCPUOP_stop_singleshot_timer:
+		kvm_xen_stop_timer(vcpu);
+		ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int kvm_xen_hcall_set_timer_op(struct kvm_vcpu *vcpu, uint64_t timeout)
+{
+	ktime_t ktime_now = ktime_get();
+	long delta = timeout - get_kvmclock_ns(vcpu->kvm);
+
+	if (!kvm_xen_timer_enabled(vcpu))
+		return -EINVAL;
+
+	if (timeout == 0) {
+		kvm_xen_stop_timer(vcpu);
+	} else if (unlikely(timeout < ktime_now) ||
+		   ((uint32_t) (delta >> 50) != 0)) {
+		kvm_xen_start_timer(vcpu, 50000000);
+	} else {
+		kvm_xen_start_timer(vcpu, delta);
+	}
+
+	return 0;
+}
+
 int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 {
 	bool longmode;
@@ -546,10 +700,20 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	case __HYPERVISOR_event_channel_op:
 		r = kvm_xen_hcall_evtchn_send(vcpu, params[0],
 					      params[1]);
-		if (!r) {
-			kvm_xen_hypercall_set_result(vcpu, r);
-			return kvm_skip_emulated_instruction(vcpu);
-		}
+		if (!r)
+			goto hcall_success;
+		break;
+	case __HYPERVISOR_vcpu_op:
+		r = kvm_xen_hcall_vcpu_op(vcpu, params[0], params[1],
+					  params[2]);
+		if (!r)
+			goto hcall_success;
+		break;
+	case __HYPERVISOR_set_timer_op:
+		r = kvm_xen_hcall_set_timer_op(vcpu, params[0]);
+		if (!r)
+			goto hcall_success;
+		break;
 	/* fallthrough */
 	default:
 		break;
@@ -567,6 +731,14 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 		kvm_xen_hypercall_complete_userspace;
 
 	return 0;
+
+hcall_success:
+	kvm_xen_hypercall_set_result(vcpu, r);
+	return kvm_skip_emulated_instruction(vcpu);
+}
+
+void kvm_xen_vcpu_init(struct kvm_vcpu *vcpu)
+{
 }
 
 void kvm_xen_vcpu_uninit(struct kvm_vcpu *vcpu)
@@ -579,6 +751,11 @@ void kvm_xen_vcpu_uninit(struct kvm_vcpu *vcpu)
 		put_page(virt_to_page(vcpu_xen->pv_time));
 	if (vcpu_xen->steal_time)
 		put_page(virt_to_page(vcpu_xen->steal_time));
+
+	if (!kvm_xen_timer_enabled(vcpu))
+		return;
+
+	kvm_xen_stop_timer(vcpu);
 }
 
 void kvm_xen_init_vm(struct kvm *kvm)
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 8f26625564c8..f82b8b5b3345 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -37,6 +37,12 @@ int kvm_xen_setup_evtchn(struct kvm *kvm,
 void kvm_xen_init_vm(struct kvm *kvm);
 void kvm_xen_destroy_vm(struct kvm *kvm);
 int kvm_vm_ioctl_xen_eventfd(struct kvm *kvm, struct kvm_xen_eventfd *args);
+void kvm_xen_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_xen_vcpu_uninit(struct kvm_vcpu *vcpu);
 
+void __kvm_migrate_xen_timer(struct kvm_vcpu *vcpu);
+int kvm_xen_has_pending_timer(struct kvm_vcpu *vcpu);
+void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu);
+bool kvm_xen_timer_enabled(struct kvm_vcpu *vcpu);
+
 #endif
-- 
2.11.0

