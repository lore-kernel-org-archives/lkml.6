Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E2E2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yRO5BrCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfBTURx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:17:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52224 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfBTURu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8ks7081898;
        Wed, 20 Feb 2019 20:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1Xwv+1Uk4qDQHMQm9A5i5vmdwTT1Em2+yLk6wYsYmxo=;
 b=yRO5BrCdizWjPJE8uqXqNHPi5A+lCvso+i8HZOJa4MUb0jp/7Oiqs3U79Wm7xoqdU13i
 g/mOmq/OvPdiZFuMClu4oXXeZxzqD+ZF1x9GseRejA8diJ8mbL4eqfcmUik9i7GMSzeW
 SnmjyHoIMzMMPLVAitRuxEMzaydBs5OPWODjW09kk1ON5p9EjEBoNPlrEN7tcs4AUe+0
 byFjF0RAoYXpBXUTj1ShvE6C2W72T3x9OvPZN0JxGDa00+ygOVuipezokbRbTaotNg6U
 T7EPCobtnfhZXxTJlv+R2/Oq/pFtUQYZR2e4SN1e41Axc8QZBCmG84K2EZxLXyvRF84s eg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:35 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHTl9025788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:30 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHTct011860;
        Wed, 20 Feb 2019 20:17:29 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:28 -0800
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
Subject: [PATCH RFC 11/39] KVM: x86/xen: evtchn signaling via eventfd
Date:   Wed, 20 Feb 2019 20:15:41 +0000
Message-Id: <20190220201609.28290-12-joao.m.martins@oracle.com>
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

userspace registers a @port to an @eventfd, that is bound to a
 @vcpu. This information is then used when the guest does an
EVTCHNOP_send with a port registered with the kernel.

EVTCHNOP_send short-circuiting happens by marking the event as pending
in the shared info and vcpu info pages and doing the upcall. For IPIs
and interdomain event channels, we do the upcall on the assigned vcpu.

After binding events the guest or host may wish to bind those
events to a particular vcpu. This is usually done for unbound
and and interdomain events. Update requests are handled via the
KVM_XEN_EVENTFD_UPDATE flag.

Unregistered ports are handled by the emulator.

Co-developed-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |   3 +
 arch/x86/kvm/x86.c              |   1 +
 arch/x86/kvm/xen.c              | 238 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/xen.h              |   2 +
 include/uapi/linux/kvm.h        |  20 ++++
 5 files changed, 264 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3305173bf10b..f31fcaf8fa7c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -859,6 +859,9 @@ struct kvm_xen {
 
 	gfn_t shinfo_addr;
 	struct shared_info *shinfo;
+
+	struct idr port_to_evt;
+	struct mutex xen_lock;
 };
 
 enum kvm_xen_callback_via {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 11b9ff2bd901..76bd23113ccd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9181,6 +9181,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	INIT_DELAYED_WORK(&kvm->arch.kvmclock_update_work, kvmclock_update_fn);
 	INIT_DELAYED_WORK(&kvm->arch.kvmclock_sync_work, kvmclock_sync_fn);
 
+	kvm_xen_init_vm(kvm);
 	kvm_hv_init_vm(kvm);
 	kvm_page_track_init(kvm);
 	kvm_mmu_init_vm(kvm);
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 99a3722146d8..1fbdfa7c4356 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -10,14 +10,28 @@
 #include "ioapic.h"
 
 #include <linux/kvm_host.h>
+#include <linux/eventfd.h>
 #include <linux/sched/stat.h>
 
 #include <trace/events/kvm.h>
 #include <xen/interface/xen.h>
 #include <xen/interface/vcpu.h>
+#include <xen/interface/event_channel.h>
 
 #include "trace.h"
 
+struct evtchnfd {
+	struct eventfd_ctx *ctx;
+	u32 vcpu;
+	u32 port;
+	u32 type;
+	union {
+		struct {
+			u8 type;
+		} virq;
+	};
+};
+
 static void *xen_vcpu_info(struct kvm_vcpu *v);
 
 int kvm_xen_has_interrupt(struct kvm_vcpu *vcpu)
@@ -80,6 +94,13 @@ static int kvm_xen_do_upcall(struct kvm *kvm, u32 dest_vcpu,
 	return 0;
 }
 
+static void kvm_xen_evtchnfd_upcall(struct kvm_vcpu *vcpu, struct evtchnfd *e)
+{
+	struct kvm_vcpu_xen *vx = vcpu_to_xen_vcpu(vcpu);
+
+	kvm_xen_do_upcall(vcpu->kvm, e->vcpu, vx->cb.via, vx->cb.vector, 0);
+}
+
 int kvm_xen_set_evtchn(struct kvm_kernel_irq_routing_entry *e,
 		   struct kvm *kvm, int irq_source_id, int level,
 		   bool line_status)
@@ -329,6 +350,12 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		r = 0;
 		break;
 	}
+	case KVM_XEN_ATTR_TYPE_EVTCHN: {
+		struct kvm_xen_eventfd xevfd = data->u.evtchn;
+
+		r = kvm_vm_ioctl_xen_eventfd(kvm, &xevfd);
+		break;
+	}
 	default:
 		break;
 	}
@@ -388,10 +415,96 @@ static int kvm_xen_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
+static int kvm_xen_evtchn_2l_vcpu_set_pending(struct vcpu_info *v)
+{
+	return test_and_set_bit(0, (unsigned long *) &v->evtchn_upcall_pending);
+}
+
+#define BITS_PER_EVTCHN_WORD (sizeof(xen_ulong_t)*8)
+
+static int kvm_xen_evtchn_2l_set_pending(struct shared_info *shared_info,
+					 struct vcpu_info *vcpu_info,
+					 int p)
+{
+	if (test_and_set_bit(p, (unsigned long *) shared_info->evtchn_pending))
+		return 1;
+
+	if (!test_bit(p, (unsigned long *) shared_info->evtchn_mask) &&
+	    !test_and_set_bit(p / BITS_PER_EVTCHN_WORD,
+			      (unsigned long *) &vcpu_info->evtchn_pending_sel))
+		return kvm_xen_evtchn_2l_vcpu_set_pending(vcpu_info);
+
+	return 1;
+}
+
+#undef BITS_PER_EVTCHN_WORD
+
+static int kvm_xen_evtchn_set_pending(struct kvm_vcpu *svcpu,
+				      struct evtchnfd *evfd)
+{
+	struct kvm_vcpu_xen *vcpu_xen;
+	struct vcpu_info *vcpu_info;
+	struct shared_info *shared_info;
+	struct kvm_vcpu *vcpu;
+
+	vcpu = kvm_get_vcpu(svcpu->kvm, evfd->vcpu);
+	if (!vcpu)
+		return -ENOENT;
+
+	vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+	shared_info = (struct shared_info *) vcpu->kvm->arch.xen.shinfo;
+	vcpu_info = (struct vcpu_info *) vcpu_xen->vcpu_info;
+
+	return kvm_xen_evtchn_2l_set_pending(shared_info, vcpu_info,
+					     evfd->port);
+}
+
+static int kvm_xen_evtchn_send(struct kvm_vcpu *vcpu, int port)
+{
+	struct eventfd_ctx *eventfd;
+	struct evtchnfd *evtchnfd;
+
+	/* conn_to_evt is protected by vcpu->kvm->srcu */
+	evtchnfd = idr_find(&vcpu->kvm->arch.xen.port_to_evt, port);
+	if (!evtchnfd)
+		return -ENOENT;
+
+	eventfd = evtchnfd->ctx;
+	if (!kvm_xen_evtchn_set_pending(vcpu, evtchnfd)) {
+		if (!eventfd)
+			kvm_xen_evtchnfd_upcall(vcpu, evtchnfd);
+		else
+			eventfd_signal(eventfd, 1);
+	}
+
+	return 0;
+}
+
+static int kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, int cmd, u64 param)
+{
+	struct evtchn_send send;
+	gpa_t gpa;
+	int idx;
+
+	/* Port management is done in userspace */
+	if (cmd != EVTCHNOP_send)
+		return -EINVAL;
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	gpa = kvm_mmu_gva_to_gpa_system(vcpu, param, NULL);
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	if (!gpa || kvm_vcpu_read_guest(vcpu, gpa, &send, sizeof(send)))
+		return -EFAULT;
+
+	return kvm_xen_evtchn_send(vcpu, send.port);
+}
+
 int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 {
 	bool longmode;
 	u64 input, params[5];
+	int r;
 
 	input = (u64)kvm_register_read(vcpu, VCPU_REGS_RAX);
 
@@ -415,6 +528,19 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	trace_kvm_xen_hypercall(input, params[0], params[1], params[2],
 				params[3], params[4]);
 
+	switch (input) {
+	case __HYPERVISOR_event_channel_op:
+		r = kvm_xen_hcall_evtchn_send(vcpu, params[0],
+					      params[1]);
+		if (!r) {
+			kvm_xen_hypercall_set_result(vcpu, r);
+			return kvm_skip_emulated_instruction(vcpu);
+		}
+	/* fallthrough */
+	default:
+		break;
+	}
+
 	vcpu->run->exit_reason = KVM_EXIT_XEN;
 	vcpu->run->xen.type = KVM_EXIT_XEN_HCALL;
 	vcpu->run->xen.u.hcall.input = input;
@@ -441,6 +567,12 @@ void kvm_xen_vcpu_uninit(struct kvm_vcpu *vcpu)
 		put_page(virt_to_page(vcpu_xen->steal_time));
 }
 
+void kvm_xen_init_vm(struct kvm *kvm)
+{
+	mutex_init(&kvm->arch.xen.xen_lock);
+	idr_init(&kvm->arch.xen.port_to_evt);
+}
+
 void kvm_xen_destroy_vm(struct kvm *kvm)
 {
 	struct kvm_xen *xen = &kvm->arch.xen;
@@ -448,3 +580,109 @@ void kvm_xen_destroy_vm(struct kvm *kvm)
 	if (xen->shinfo)
 		put_page(virt_to_page(xen->shinfo));
 }
+
+static int kvm_xen_eventfd_update(struct kvm *kvm, struct idr *port_to_evt,
+				  struct mutex *port_lock,
+				  struct kvm_xen_eventfd *args)
+{
+	struct eventfd_ctx *eventfd = NULL;
+	struct evtchnfd *evtchnfd;
+
+	mutex_lock(port_lock);
+	evtchnfd = idr_find(port_to_evt, args->port);
+	mutex_unlock(port_lock);
+
+	if (!evtchnfd)
+		return -ENOENT;
+
+	if (args->fd != -1) {
+		eventfd = eventfd_ctx_fdget(args->fd);
+		if (IS_ERR(eventfd))
+			return PTR_ERR(eventfd);
+	}
+
+	evtchnfd->vcpu = args->vcpu;
+	return 0;
+}
+
+static int kvm_xen_eventfd_assign(struct kvm *kvm, struct idr *port_to_evt,
+				  struct mutex *port_lock,
+				  struct kvm_xen_eventfd *args)
+{
+	struct eventfd_ctx *eventfd = NULL;
+	struct evtchnfd *evtchnfd;
+	u32 port = args->port;
+	int ret;
+
+	if (args->fd != -1) {
+		eventfd = eventfd_ctx_fdget(args->fd);
+		if (IS_ERR(eventfd))
+			return PTR_ERR(eventfd);
+	}
+
+	evtchnfd =  kzalloc(sizeof(struct evtchnfd), GFP_KERNEL);
+	if (!evtchnfd)
+		return -ENOMEM;
+
+	evtchnfd->ctx = eventfd;
+	evtchnfd->port = port;
+	evtchnfd->vcpu = args->vcpu;
+	evtchnfd->type = args->type;
+	if (evtchnfd->type == XEN_EVTCHN_TYPE_VIRQ)
+		evtchnfd->virq.type = args->virq.type;
+
+	mutex_lock(port_lock);
+	ret = idr_alloc(port_to_evt, evtchnfd, port, port + 1,
+			GFP_KERNEL);
+	mutex_unlock(port_lock);
+
+	if (ret >= 0)
+		return 0;
+
+	if (ret == -ENOSPC)
+		ret = -EEXIST;
+
+	if (eventfd)
+		eventfd_ctx_put(eventfd);
+	kfree(evtchnfd);
+	return ret;
+}
+
+static int kvm_xen_eventfd_deassign(struct kvm *kvm, struct idr *port_to_evt,
+				  struct mutex *port_lock, u32 port)
+{
+	struct evtchnfd *evtchnfd;
+
+	mutex_lock(port_lock);
+	evtchnfd = idr_remove(port_to_evt, port);
+	mutex_unlock(port_lock);
+
+	if (!evtchnfd)
+		return -ENOENT;
+
+	if (kvm)
+		synchronize_srcu(&kvm->srcu);
+	if (evtchnfd->ctx)
+		eventfd_ctx_put(evtchnfd->ctx);
+	kfree(evtchnfd);
+	return 0;
+}
+
+int kvm_vm_ioctl_xen_eventfd(struct kvm *kvm, struct kvm_xen_eventfd *args)
+{
+	struct kvm_xen *xen = &kvm->arch.xen;
+	int allowed_flags = (KVM_XEN_EVENTFD_DEASSIGN | KVM_XEN_EVENTFD_UPDATE);
+
+	if ((args->flags & (~allowed_flags)) ||
+	    (args->port <= 0))
+		return -EINVAL;
+
+	if (args->flags == KVM_XEN_EVENTFD_DEASSIGN)
+		return kvm_xen_eventfd_deassign(kvm, &xen->port_to_evt,
+						&xen->xen_lock, args->port);
+	if (args->flags == KVM_XEN_EVENTFD_UPDATE)
+		return kvm_xen_eventfd_update(kvm, &xen->port_to_evt,
+					      &xen->xen_lock, args);
+	return kvm_xen_eventfd_assign(kvm, &xen->port_to_evt,
+				      &xen->xen_lock, args);
+}
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 6a42e134924a..8f26625564c8 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -34,7 +34,9 @@ int kvm_xen_set_evtchn(struct kvm_kernel_irq_routing_entry *e,
 int kvm_xen_setup_evtchn(struct kvm *kvm,
 			 struct kvm_kernel_irq_routing_entry *e);
 
+void kvm_xen_init_vm(struct kvm *kvm);
 void kvm_xen_destroy_vm(struct kvm *kvm);
+int kvm_vm_ioctl_xen_eventfd(struct kvm *kvm, struct kvm_xen_eventfd *args);
 void kvm_xen_vcpu_uninit(struct kvm_vcpu *vcpu);
 
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 49001f681cd1..4eae47a0ef63 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1479,6 +1479,25 @@ struct kvm_xen_hvm_attr {
 			__u32 vcpu;
 			__u64 gpa;
 		} vcpu_attr;
+		struct kvm_xen_eventfd {
+
+#define XEN_EVTCHN_TYPE_VIRQ 0
+#define XEN_EVTCHN_TYPE_IPI  1
+			__u32 type;
+			__u32 port;
+			__u32 vcpu;
+			__s32 fd;
+
+#define KVM_XEN_EVENTFD_DEASSIGN	(1 << 0)
+#define KVM_XEN_EVENTFD_UPDATE		(1 << 1)
+			__u32 flags;
+			union {
+				struct {
+					__u8 type;
+				} virq;
+				__u32 padding[2];
+			};
+		} evtchn;
 	} u;
 };
 
@@ -1487,6 +1506,7 @@ struct kvm_xen_hvm_attr {
 #define KVM_XEN_ATTR_TYPE_VCPU_INFO         0x1
 #define KVM_XEN_ATTR_TYPE_VCPU_TIME_INFO    0x2
 #define KVM_XEN_ATTR_TYPE_VCPU_RUNSTATE     0x3
+#define KVM_XEN_ATTR_TYPE_EVTCHN            0x4
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
-- 
2.11.0

