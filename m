Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36B0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D402146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="micbrxhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfBTUSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:18:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36236 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfBTUSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8VOd087139;
        Wed, 20 Feb 2019 20:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=34dhGVmA7cwyWHVj6W3v3cz50sdqag95jPIz8PaaXqQ=;
 b=micbrxhSej3rnBFycSvbC8DEka9LUAG+T72t3VwzIWiXeFar1GSjuG5uOaWhhhEWTvRm
 gN+0NTsyt8o8LqxjD+ErrrksjHsYO1nUZQPWku+CwYv7/rIH99z+lpLYNaSNaYWP98nK
 sOB+Gw9RrYfqc/bv8g2OlE9mfrM9kgGQpq5A3IF6jHNiG2SZ8U8sPvqqS1fvbpoZjY5w
 9YIYZGE6mzmZnVDEVkPBfvky81NPWRt/nIOFW1sXb8Jqdw2SSEEfyMYwoSna3Bdym7OY
 FsVQ7QuMKk/Ksd37jfKIHDXUb+ACe+OCjfTq+3W4Jc9VlnwgY37smcRY/6C2KJE6YbFK qA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qpb5rktum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:23 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIMvj019690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:23 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIM81009979;
        Wed, 20 Feb 2019 20:18:22 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:22 -0800
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
Subject: [PATCH RFC 28/39] KVM: x86/xen: interdomain evtchn support
Date:   Wed, 20 Feb 2019 20:15:58 +0000
Message-Id: <20190220201609.28290-29-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankur Arora <ankur.a.arora@oracle.com>

Implement sending events between backend and the guest. To send an
event we mark the event channel pending by setting some bits in the
shared_info and vcpu_info pages and deliver the upcall on the
destination vcpu.

To send an event to dom0, we mark the event channel pending and
send an IPI to the destination vcpu, which would invoke the event
channel upcall handler, which inturn calls the ISR registered by
the backend drivers.

When sending to the guest we fetch the vcpu from the guest, mark the
event channel pending and deliver the interrupt to the guest.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/kvm/xen.c       | 271 ++++++++++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/kvm.h |  10 +-
 2 files changed, 263 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index fecc548b2f12..420e3ebb66bc 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -27,6 +27,10 @@
 #include <xen/features.h>
 #include <asm/xen/hypercall.h>
 
+#include <xen/xen.h>
+#include <xen/events.h>
+#include <xen/xen-ops.h>
+
 #include "trace.h"
 
 /* Grant v1 references per 4K page */
@@ -46,12 +50,18 @@ struct evtchnfd {
 		struct {
 			u8 type;
 		} virq;
+		struct {
+			domid_t dom;
+			struct kvm *vm;
+			u32 port;
+		} remote;
 	};
 };
 
 static int kvm_xen_evtchn_send(struct kvm_vcpu *vcpu, int port);
-static void *xen_vcpu_info(struct kvm_vcpu *v);
+static void *vcpu_to_xen_vcpu_info(struct kvm_vcpu *v);
 static void kvm_xen_gnttab_free(struct kvm_xen *xen);
+static int kvm_xen_evtchn_send_shim(struct kvm_xen *shim, struct evtchnfd *evt);
 static int shim_hypercall(u64 code, u64 a0, u64 a1, u64 a2, u64 a3, u64 a4);
 
 #define XEN_DOMID_MIN	1
@@ -114,7 +124,7 @@ int kvm_xen_free_domid(struct kvm *kvm)
 int kvm_xen_has_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
-	struct vcpu_info *vcpu_info = xen_vcpu_info(vcpu);
+	struct vcpu_info *vcpu_info = vcpu_to_xen_vcpu_info(vcpu);
 
 	if (!!atomic_read(&vcpu_xen->cb.queued) || (vcpu_info &&
 	    test_bit(0, (unsigned long *) &vcpu_info->evtchn_upcall_pending)))
@@ -386,7 +396,7 @@ static int kvm_xen_shared_info_init(struct kvm *kvm, gfn_t gfn)
 	return 0;
 }
 
-static void *xen_vcpu_info(struct kvm_vcpu *v)
+static void *vcpu_to_xen_vcpu_info(struct kvm_vcpu *v)
 {
 	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(v);
 	struct kvm_xen *kvm = &v->kvm->arch.xen;
@@ -478,7 +488,7 @@ void kvm_xen_setup_pvclock_page(struct kvm_vcpu *v)
 {
 	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(v);
 	struct pvclock_vcpu_time_info *guest_hv_clock;
-	void *hva = xen_vcpu_info(v);
+	void *hva = vcpu_to_xen_vcpu_info(v);
 	unsigned int offset;
 
 	offset = offsetof(struct vcpu_info, time);
@@ -638,8 +648,6 @@ static int kvm_xen_evtchn_2l_set_pending(struct shared_info *shared_info,
 	return 1;
 }
 
-#undef BITS_PER_EVTCHN_WORD
-
 static int kvm_xen_evtchn_set_pending(struct kvm_vcpu *svcpu,
 				      struct evtchnfd *evfd)
 {
@@ -670,8 +678,44 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
 		wake_up(&vcpu_xen->sched_waitq);
 }
 
+static void kvm_xen_evtchn_2l_reset_port(struct shared_info *shared_info,
+					 int port)
+{
+	clear_bit(port, (unsigned long *) shared_info->evtchn_pending);
+	clear_bit(port, (unsigned long *) shared_info->evtchn_mask);
+}
+
+static inline struct evtchnfd *port_to_evtchn(struct kvm *kvm, int port)
+{
+	struct kvm_xen *xen = kvm ? &kvm->arch.xen : xen_shim;
+
+	return idr_find(&xen->port_to_evt, port);
+}
+
+static struct kvm_vcpu *get_remote_vcpu(struct evtchnfd *source)
+{
+	struct kvm *rkvm = source->remote.vm;
+	int rport = source->remote.port;
+	struct evtchnfd *dest = NULL;
+	struct kvm_vcpu *vcpu = NULL;
+
+	WARN_ON(source->type <= XEN_EVTCHN_TYPE_IPI);
+
+	if (!rkvm)
+		return NULL;
+
+	/* conn_to_evt is protected by vcpu->kvm->srcu */
+	dest = port_to_evtchn(rkvm, rport);
+	if (!dest)
+		return NULL;
+
+	vcpu = kvm_get_vcpu(rkvm, dest->vcpu);
+	return vcpu;
+}
+
 static int kvm_xen_evtchn_send(struct kvm_vcpu *vcpu, int port)
 {
+	struct kvm_vcpu *target = vcpu;
 	struct eventfd_ctx *eventfd;
 	struct evtchnfd *evtchnfd;
 
@@ -680,10 +724,19 @@ static int kvm_xen_evtchn_send(struct kvm_vcpu *vcpu, int port)
 	if (!evtchnfd)
 		return -ENOENT;
 
+	if (evtchnfd->type == XEN_EVTCHN_TYPE_INTERDOM ||
+	    evtchnfd->type == XEN_EVTCHN_TYPE_UNBOUND) {
+		target = get_remote_vcpu(evtchnfd);
+		port = evtchnfd->remote.port;
+
+		if (!target && !evtchnfd->remote.dom)
+			return kvm_xen_evtchn_send_shim(xen_shim, evtchnfd);
+	}
+
 	eventfd = evtchnfd->ctx;
-	if (!kvm_xen_evtchn_set_pending(vcpu, evtchnfd)) {
+	if (!kvm_xen_evtchn_set_pending(target, evtchnfd)) {
 		if (!eventfd)
-			kvm_xen_evtchnfd_upcall(vcpu, evtchnfd);
+			kvm_xen_evtchnfd_upcall(target, evtchnfd);
 		else
 			eventfd_signal(eventfd, 1);
 	}
@@ -894,6 +947,67 @@ static int kvm_xen_hcall_sched_op(struct kvm_vcpu *vcpu, int cmd, u64 param)
 	return ret;
 }
 
+static void kvm_xen_call_function_deliver(void *_)
+{
+	xen_hvm_evtchn_do_upcall();
+}
+
+static inline int kvm_xen_evtchn_call_function(struct evtchnfd *event)
+{
+	int ret;
+
+	if (!irqs_disabled())
+		return smp_call_function_single(event->vcpu,
+						kvm_xen_call_function_deliver,
+						NULL, 0);
+
+	local_irq_enable();
+	ret = smp_call_function_single(event->vcpu,
+				       kvm_xen_call_function_deliver, NULL, 0);
+	local_irq_disable();
+
+	return ret;
+}
+
+static int kvm_xen_evtchn_send_shim(struct kvm_xen *dom0, struct evtchnfd *e)
+{
+	struct shared_info *s = HYPERVISOR_shared_info;
+	struct evtchnfd *remote;
+	int pending;
+
+	remote = idr_find(&dom0->port_to_evt, e->remote.port);
+	if (!remote)
+		return -ENOENT;
+
+	pending = kvm_xen_evtchn_2l_set_pending(s,
+						per_cpu(xen_vcpu, remote->vcpu),
+						remote->port);
+	return kvm_xen_evtchn_call_function(remote);
+}
+
+static int __kvm_xen_evtchn_send_guest(struct kvm_vcpu *vcpu, int port)
+{
+	struct evtchnfd *evtchnfd;
+	struct eventfd_ctx *eventfd;
+
+	/* conn_to_evt is protected by vcpu->kvm->srcu */
+	evtchnfd = idr_find(&vcpu->kvm->arch.xen.port_to_evt, port);
+	if (!evtchnfd)
+		return -ENOENT;
+
+	eventfd = evtchnfd->ctx;
+	if (!kvm_xen_evtchn_set_pending(vcpu, evtchnfd))
+		kvm_xen_evtchnfd_upcall(vcpu, evtchnfd);
+
+	kvm_xen_check_poller(kvm_get_vcpu(vcpu->kvm, evtchnfd->vcpu), port);
+	return 0;
+}
+
+static int kvm_xen_evtchn_send_guest(struct evtchnfd *evt, int port)
+{
+	return __kvm_xen_evtchn_send_guest(get_remote_vcpu(evt), port);
+}
+
 int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 {
 	bool longmode;
@@ -1045,13 +1159,15 @@ static int kvm_xen_eventfd_update(struct kvm *kvm, struct idr *port_to_evt,
 	return 0;
 }
 
-static int kvm_xen_eventfd_assign(struct kvm *kvm, struct idr *port_to_evt,
-				  struct mutex *port_lock,
-				  struct kvm_xen_eventfd *args)
+int kvm_xen_eventfd_assign(struct kvm *kvm, struct idr *port_to_evt,
+			   struct mutex *port_lock,
+			   struct kvm_xen_eventfd *args)
 {
+	struct evtchnfd *evtchnfd, *unbound = NULL;
 	struct eventfd_ctx *eventfd = NULL;
-	struct evtchnfd *evtchnfd;
+	struct kvm *remote_vm = NULL;
 	u32 port = args->port;
+	u32 endport = 0;
 	int ret;
 
 	if (args->fd != -1) {
@@ -1064,25 +1180,56 @@ static int kvm_xen_eventfd_assign(struct kvm *kvm, struct idr *port_to_evt,
 	    args->virq.type >= KVM_XEN_NR_VIRQS)
 		return -EINVAL;
 
+	if (args->remote.domid == DOMID_SELF)
+		remote_vm = kvm;
+	else if (args->remote.domid == xen_shim->domid)
+		remote_vm = NULL;
+	else if ((args->type == XEN_EVTCHN_TYPE_INTERDOM ||
+		  args->type == XEN_EVTCHN_TYPE_UNBOUND)) {
+		remote_vm = kvm_xen_find_vm(args->remote.domid);
+		if (!remote_vm)
+			return -ENOENT;
+	}
+
+	if (args->type == XEN_EVTCHN_TYPE_INTERDOM) {
+		unbound = port_to_evtchn(remote_vm, args->remote.port);
+		if (!unbound)
+			return -ENOENT;
+	}
+
 	evtchnfd =  kzalloc(sizeof(struct evtchnfd), GFP_KERNEL);
 	if (!evtchnfd)
 		return -ENOMEM;
 
 	evtchnfd->ctx = eventfd;
-	evtchnfd->port = port;
 	evtchnfd->vcpu = args->vcpu;
 	evtchnfd->type = args->type;
+
 	if (evtchnfd->type == XEN_EVTCHN_TYPE_VIRQ)
 		evtchnfd->virq.type = args->virq.type;
+	else if ((evtchnfd->type == XEN_EVTCHN_TYPE_UNBOUND) ||
+		 (evtchnfd->type == XEN_EVTCHN_TYPE_INTERDOM)) {
+		evtchnfd->remote.dom = args->remote.domid;
+		evtchnfd->remote.vm = remote_vm;
+		evtchnfd->remote.port = args->remote.port;
+	}
+
+	if (port == 0)
+		port = 1; /* evtchns in range (0..INT_MAX] */
+	else
+		endport = port + 1;
 
 	mutex_lock(port_lock);
-	ret = idr_alloc(port_to_evt, evtchnfd, port, port + 1,
+	ret = idr_alloc(port_to_evt, evtchnfd, port, endport,
 			GFP_KERNEL);
 	mutex_unlock(port_lock);
 
 	if (ret >= 0) {
-		if (evtchnfd->type == XEN_EVTCHN_TYPE_VIRQ)
+		evtchnfd->port = args->port = ret;
+		if (kvm && evtchnfd->type == XEN_EVTCHN_TYPE_VIRQ)
 			kvm_xen_set_virq(kvm, evtchnfd);
+		else if (evtchnfd->type == XEN_EVTCHN_TYPE_INTERDOM)
+			unbound->remote.port = ret;
 		return 0;
 	}
 
@@ -1107,8 +1254,14 @@ static int kvm_xen_eventfd_deassign(struct kvm *kvm, struct idr *port_to_evt,
 	if (!evtchnfd)
 		return -ENOENT;
 
-	if (kvm)
+	if (!kvm) {
+		struct shared_info *shinfo = HYPERVISOR_shared_info;
+
+		kvm_xen_evtchn_2l_reset_port(shinfo, port);
+	} else {
 		synchronize_srcu(&kvm->srcu);
+	}
+
 	if (evtchnfd->ctx)
 		eventfd_ctx_put(evtchnfd->ctx);
 	kfree(evtchnfd);
@@ -1930,6 +2083,89 @@ static int shim_hcall_gnttab(int op, void *p, int count)
 	return ret;
 }
 
+static int shim_hcall_evtchn_send(struct kvm_xen *dom0, struct evtchn_send *snd)
+{
+	struct evtchnfd *event;
+
+	event = idr_find(&dom0->port_to_evt, snd->port);
+	if (!event)
+		return -ENOENT;
+
+	if (event->remote.vm == NULL)
+		return kvm_xen_evtchn_send_shim(xen_shim, event);
+	else if (event->type == XEN_EVTCHN_TYPE_INTERDOM ||
+		 event->type == XEN_EVTCHN_TYPE_UNBOUND)
+		return kvm_xen_evtchn_send_guest(event, event->remote.port);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int shim_hcall_evtchn(int op, void *p)
+{
+	int ret;
+	struct kvm_xen_eventfd evt;
+
+	if (p == NULL)
+		return -EINVAL;
+
+	memset(&evt, 0, sizeof(evt));
+
+	switch (op) {
+	case EVTCHNOP_bind_interdomain: {
+		struct evtchn_bind_interdomain *un;
+
+		un = (struct evtchn_bind_interdomain *) p;
+
+		evt.fd = -1;
+		evt.port = 0;
+		if (un->remote_port == 0) {
+			evt.type = XEN_EVTCHN_TYPE_UNBOUND;
+			evt.remote.domid = un->remote_dom;
+		} else {
+			evt.type = XEN_EVTCHN_TYPE_INTERDOM;
+			evt.remote.domid = un->remote_dom;
+			evt.remote.port = un->remote_port;
+		}
+
+		ret = kvm_xen_eventfd_assign(NULL, &xen_shim->port_to_evt,
+					     &xen_shim->xen_lock, &evt);
+		un->local_port = evt.port;
+		break;
+	}
+	case EVTCHNOP_alloc_unbound: {
+		struct evtchn_alloc_unbound *un;
+
+		un = (struct evtchn_alloc_unbound *) p;
+
+		if (un->dom != DOMID_SELF || un->remote_dom != DOMID_SELF)
+			return -EINVAL;
+		evt.fd = -1;
+		evt.port = 0;
+		evt.type = XEN_EVTCHN_TYPE_UNBOUND;
+		evt.remote.domid = DOMID_SELF;
+
+		ret = kvm_xen_eventfd_assign(NULL, &xen_shim->port_to_evt,
+					     &xen_shim->xen_lock, &evt);
+		un->port = evt.port;
+		break;
+	}
+	case EVTCHNOP_send: {
+		struct evtchn_send *send;
+
+		send = (struct evtchn_send *) p;
+		ret = shim_hcall_evtchn_send(xen_shim, send);
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 static int shim_hcall_version(int op, struct xen_feature_info *fi)
 {
 	if (op != XENVER_get_features || !fi || fi->submap_idx != 0)
@@ -1947,6 +2183,9 @@ static int shim_hypercall(u64 code, u64 a0, u64 a1, u64 a2, u64 a3, u64 a4)
 	int ret = -ENOSYS;
 
 	switch (code) {
+	case __HYPERVISOR_event_channel_op:
+		ret = shim_hcall_evtchn((int) a0, (void *)a1);
+		break;
 	case __HYPERVISOR_grant_table_op:
 		ret = shim_hcall_gnttab((int) a0, (void *) a1, (int) a2);
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index ff7f7d019472..74d877792dfa 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1483,8 +1483,10 @@ struct kvm_xen_hvm_attr {
 		} vcpu_attr;
 		struct kvm_xen_eventfd {
 
-#define XEN_EVTCHN_TYPE_VIRQ 0
-#define XEN_EVTCHN_TYPE_IPI  1
+#define XEN_EVTCHN_TYPE_VIRQ      0
+#define XEN_EVTCHN_TYPE_IPI       1
+#define XEN_EVTCHN_TYPE_INTERDOM  2
+#define XEN_EVTCHN_TYPE_UNBOUND   3
 			__u32 type;
 			__u32 port;
 			__u32 vcpu;
@@ -1497,6 +1499,10 @@ struct kvm_xen_hvm_attr {
 				struct {
 					__u8 type;
 				} virq;
+				struct {
+					__u16 domid;
+					__u32 port;
+				} remote;
 				__u32 padding[2];
 			};
 		} evtchn;
-- 
2.11.0

