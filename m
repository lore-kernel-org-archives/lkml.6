Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A5CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DA52147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kDZrOVFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfBTURp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:17:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52136 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfBTURn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8VUv081696;
        Wed, 20 Feb 2019 20:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=UdadlV07KAuI7D1n34KKSaXxz4+/ZDZCYXQmV9TN8mg=;
 b=kDZrOVFbKcLAgZLCPpS1jLcr26HTjAv0CwoOkdH37dRgjC3cIDQ2IwPyCEPg50Ae6p7p
 6PEunlEwz1FeWjy9KG/+tWxL3z8xaDPx8G8N3E3YsmN5TjZpyz0X+jckacLJibo4WYW0
 uiroB1EeAPFlqt8jGCWjB+t2ZbzHbhvhSDZQ2tGyygBmrapsKwPbMiquA03VnsJNUwNm
 10Xm1HJnjxLn2MqXpxUA9VF58Oy2EqvP9IcMVQfh80GS6eLFCibwV5odgOzciULhmDJA
 3tuJyoe0cwjUpTlwxkTuIjxx4MTuNwjx8LH2RS0N1dkgwK2reRc5ei5MtwG732WdxD8u UQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:28 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHRBo021624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:27 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKHPZK015421;
        Wed, 20 Feb 2019 20:17:27 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:25 -0800
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
Subject: [PATCH RFC 10/39] KVM: x86/xen: support upcall vector
Date:   Wed, 20 Feb 2019 20:15:40 +0000
Message-Id: <20190220201609.28290-11-joao.m.martins@oracle.com>
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

From: Ankur Arora <ankur.a.arora@oracle.com>

Add support for HVM_PARAM_CALLBACK_VIA_TYPE_VECTOR and
HVM_PARAM_CALLBACK_VIA_TYPE_EVTCHN upcall. Some Xen upcall variants do
not have an EOI for received upcalls. We handle that by directly
injecting the interrupt in the VMCS instead of going through the
LAPIC.

Note that the route @vcpu field represents the vcpu index and not a vcpu
id. The vcpu_id is architecture specific e.g. on x86 it's set to the
apic id by userspace.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |  14 ++++++
 arch/x86/kvm/irq.c              |  14 ++++--
 arch/x86/kvm/irq_comm.c         |  11 +++++
 arch/x86/kvm/xen.c              | 106 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/xen.h              |   9 ++++
 include/linux/kvm_host.h        |  24 +++++++++
 include/uapi/linux/kvm.h        |   8 +++
 7 files changed, 183 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9d388ba0a05c..3305173bf10b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -534,6 +534,12 @@ struct kvm_vcpu_hv {
 	cpumask_t tlb_flush;
 };
 
+struct kvm_xen_callback {
+	u32 via;
+	u32 vector;
+	atomic_t queued;
+};
+
 /* Xen per vcpu emulation context */
 struct kvm_vcpu_xen {
 	struct kvm_xen_exit exit;
@@ -543,6 +549,7 @@ struct kvm_vcpu_xen {
 	struct pvclock_vcpu_time_info *pv_time;
 	gpa_t steal_time_addr;
 	struct vcpu_runstate_info *steal_time;
+	struct kvm_xen_callback cb;
 };
 
 struct kvm_vcpu_arch {
@@ -854,6 +861,13 @@ struct kvm_xen {
 	struct shared_info *shinfo;
 };
 
+enum kvm_xen_callback_via {
+	KVM_XEN_CALLBACK_VIA_GSI,
+	KVM_XEN_CALLBACK_VIA_PCI_INTX,
+	KVM_XEN_CALLBACK_VIA_VECTOR,
+	KVM_XEN_CALLBACK_VIA_EVTCHN,
+};
+
 enum kvm_irqchip_mode {
 	KVM_IRQCHIP_NONE,
 	KVM_IRQCHIP_KERNEL,       /* created with KVM_CREATE_IRQCHIP */
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index faa264822cee..cdb1dbfcc9b1 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -26,6 +26,7 @@
 #include "irq.h"
 #include "i8254.h"
 #include "x86.h"
+#include "xen.h"
 
 /*
  * check if there are pending timer events
@@ -61,7 +62,9 @@ static int kvm_cpu_has_extint(struct kvm_vcpu *v)
 			return pending_userspace_extint(v);
 		else
 			return v->kvm->arch.vpic->output;
-	} else
+	} else if (kvm_xen_has_interrupt(v) != -1)
+		return 1;
+	else
 		return 0;
 }
 
@@ -119,7 +122,7 @@ int kvm_cpu_has_interrupt(struct kvm_vcpu *v)
 	if (kvm_cpu_has_extint(v))
 		return 1;
 
-	return kvm_apic_has_interrupt(v) != -1;	/* LAPIC */
+	return kvm_apic_has_interrupt(v) != -1; /* LAPIC */
 }
 EXPORT_SYMBOL_GPL(kvm_cpu_has_interrupt);
 
@@ -135,8 +138,13 @@ static int kvm_cpu_get_extint(struct kvm_vcpu *v)
 
 			v->arch.pending_external_vector = -1;
 			return vector;
-		} else
+		} else {
+			int vector = kvm_xen_get_interrupt(v);
+
+			if (vector)
+				return vector;		 /* Xen */
 			return kvm_pic_read_irq(v->kvm); /* PIC */
+		}
 	} else
 		return -1;
 }
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 3cc3b2d130a0..3b5da18c9ce2 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -36,6 +36,7 @@
 #include "lapic.h"
 
 #include "hyperv.h"
+#include "xen.h"
 #include "x86.h"
 
 static int kvm_set_pic_irq(struct kvm_kernel_irq_routing_entry *e,
@@ -176,6 +177,9 @@ int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
 	int r;
 
 	switch (e->type) {
+	case KVM_IRQ_ROUTING_XEN_EVTCHN:
+		return kvm_xen_set_evtchn(e, kvm, irq_source_id, level,
+				       line_status);
 	case KVM_IRQ_ROUTING_HV_SINT:
 		return kvm_hv_set_sint(e, kvm, irq_source_id, level,
 				       line_status);
@@ -325,6 +329,13 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		e->hv_sint.vcpu = ue->u.hv_sint.vcpu;
 		e->hv_sint.sint = ue->u.hv_sint.sint;
 		break;
+	case KVM_IRQ_ROUTING_XEN_EVTCHN:
+		e->set = kvm_xen_set_evtchn;
+		e->evtchn.vcpu = ue->u.evtchn.vcpu;
+		e->evtchn.vector = ue->u.evtchn.vector;
+		e->evtchn.via = ue->u.evtchn.via;
+
+		return kvm_xen_setup_evtchn(kvm, e);
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 4fdc4c71245a..99a3722146d8 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -7,6 +7,7 @@
 
 #include "x86.h"
 #include "xen.h"
+#include "ioapic.h"
 
 #include <linux/kvm_host.h>
 #include <linux/sched/stat.h>
@@ -17,6 +18,111 @@
 
 #include "trace.h"
 
+static void *xen_vcpu_info(struct kvm_vcpu *v);
+
+int kvm_xen_has_interrupt(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+	struct vcpu_info *vcpu_info = xen_vcpu_info(vcpu);
+
+	if (!!atomic_read(&vcpu_xen->cb.queued) || (vcpu_info &&
+	    test_bit(0, (unsigned long *) &vcpu_info->evtchn_upcall_pending)))
+		return 1;
+
+	return -1;
+}
+
+int kvm_xen_get_interrupt(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+	u32 vector = vcpu_xen->cb.vector;
+
+	if (kvm_xen_has_interrupt(vcpu) == -1)
+		return 0;
+
+	atomic_set(&vcpu_xen->cb.queued, 0);
+	return vector;
+}
+
+static int kvm_xen_do_upcall(struct kvm *kvm, u32 dest_vcpu,
+			     u32 via, u32 vector, int level)
+{
+	struct kvm_vcpu_xen *vcpu_xen;
+	struct kvm_lapic_irq irq;
+	struct kvm_vcpu *vcpu;
+
+	if (vector > 0xff || vector < 0x10 || dest_vcpu >= KVM_MAX_VCPUS)
+		return -EINVAL;
+
+	vcpu = kvm_get_vcpu(kvm, dest_vcpu);
+	if (!vcpu)
+		return -EINVAL;
+
+	memset(&irq, 0, sizeof(irq));
+	if (via == KVM_XEN_CALLBACK_VIA_VECTOR) {
+		vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+		atomic_set(&vcpu_xen->cb.queued, 1);
+		kvm_make_request(KVM_REQ_EVENT, vcpu);
+		kvm_vcpu_kick(vcpu);
+	} else if (via == KVM_XEN_CALLBACK_VIA_EVTCHN) {
+		irq.shorthand = APIC_DEST_SELF;
+		irq.dest_mode = APIC_DEST_PHYSICAL;
+		irq.delivery_mode = APIC_DM_FIXED;
+		irq.vector = vector;
+		irq.level = level;
+
+		/* Deliver upcall to a vector on the destination vcpu */
+		kvm_irq_delivery_to_apic(kvm, vcpu->arch.apic, &irq, NULL);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int kvm_xen_set_evtchn(struct kvm_kernel_irq_routing_entry *e,
+		   struct kvm *kvm, int irq_source_id, int level,
+		   bool line_status)
+{
+	/*
+	 * The routing information for the kirq specifies the vector
+	 * on the destination vcpu.
+	 */
+	return kvm_xen_do_upcall(kvm, e->evtchn.vcpu, e->evtchn.via,
+				 e->evtchn.vector, level);
+}
+
+int kvm_xen_setup_evtchn(struct kvm *kvm,
+			 struct kvm_kernel_irq_routing_entry *e)
+{
+	struct kvm_vcpu_xen *vcpu_xen;
+	struct kvm_vcpu *vcpu = NULL;
+
+	if (e->evtchn.vector > 0xff || e->evtchn.vector < 0x10)
+		return -EINVAL;
+
+	/* Expect vcpu to be sane */
+	if (e->evtchn.vcpu >= KVM_MAX_VCPUS)
+		return -EINVAL;
+
+	vcpu = kvm_get_vcpu(kvm, e->evtchn.vcpu);
+	if (!vcpu)
+		return -EINVAL;
+
+	vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+	if (e->evtchn.via == KVM_XEN_CALLBACK_VIA_VECTOR) {
+		vcpu_xen->cb.via = KVM_XEN_CALLBACK_VIA_VECTOR;
+		vcpu_xen->cb.vector = e->evtchn.vector;
+	} else if (e->evtchn.via == KVM_XEN_CALLBACK_VIA_EVTCHN) {
+		vcpu_xen->cb.via = KVM_XEN_CALLBACK_VIA_EVTCHN;
+		vcpu_xen->cb.vector = e->evtchn.vector;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void set_vcpu_attr(struct kvm_vcpu *v, u16 type, gpa_t gpa, void *addr)
 {
 	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(v);
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 2feef68ee80f..6a42e134924a 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -25,6 +25,15 @@ bool kvm_xen_hypercall_enabled(struct kvm *kvm);
 bool kvm_xen_hypercall_set(struct kvm *kvm);
 int kvm_xen_hypercall(struct kvm_vcpu *vcpu);
 
+int kvm_xen_has_interrupt(struct kvm_vcpu *vcpu);
+int kvm_xen_get_interrupt(struct kvm_vcpu *vcpu);
+
+int kvm_xen_set_evtchn(struct kvm_kernel_irq_routing_entry *e,
+		       struct kvm *kvm, int irq_source_id, int level,
+		       bool line_status);
+int kvm_xen_setup_evtchn(struct kvm *kvm,
+			 struct kvm_kernel_irq_routing_entry *e);
+
 void kvm_xen_destroy_vm(struct kvm *kvm);
 void kvm_xen_vcpu_uninit(struct kvm_vcpu *vcpu);
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9d55c63db09b..af5e7455ff6a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -350,6 +350,29 @@ struct kvm_hv_sint {
 	u32 sint;
 };
 
+/*
+ * struct kvm_xen_evtchn: currently specifies the upcall vector setup to
+ * deliver the interrupt to the guest.
+ *
+ * via = XEN_PARAM_CALLBACK_VIA_TYPE_GSI|_PCI
+ *    vcpu: always deliver to vcpu-0
+ *    vector: is used as upcall-vector
+ *    EOI: none
+ * via = XEN_PARAM_CALLBACK_VIA_TYPE_VECTOR
+ *    vcpu: deliver to specified vcpu
+ *    vector: used as upcall-vector
+ *    EOI: none
+ * via = XEN_PARAM_CALLBACK_VIA_TYPE_EVTCHN
+ *    vcpu: deliver to specified vcpu (vector should be bound to the vcpu)
+ *    vector: used as upcall-vector
+ *    EOI: expected
+ */
+struct kvm_xen_evtchn {
+	u32 via;
+	u32 vcpu;
+	u32 vector;
+};
+
 struct kvm_kernel_irq_routing_entry {
 	u32 gsi;
 	u32 type;
@@ -370,6 +393,7 @@ struct kvm_kernel_irq_routing_entry {
 		} msi;
 		struct kvm_s390_adapter_int adapter;
 		struct kvm_hv_sint hv_sint;
+		struct kvm_xen_evtchn evtchn;
 	};
 	struct hlist_node link;
 };
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 682ea00abd58..49001f681cd1 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1035,11 +1035,18 @@ struct kvm_irq_routing_hv_sint {
 	__u32 sint;
 };
 
+struct kvm_irq_routing_xen_evtchn {
+	__u32 via;
+	__u32 vcpu;
+	__u32 vector;
+};
+
 /* gsi routing entry types */
 #define KVM_IRQ_ROUTING_IRQCHIP 1
 #define KVM_IRQ_ROUTING_MSI 2
 #define KVM_IRQ_ROUTING_S390_ADAPTER 3
 #define KVM_IRQ_ROUTING_HV_SINT 4
+#define KVM_IRQ_ROUTING_XEN_EVTCHN 5
 
 struct kvm_irq_routing_entry {
 	__u32 gsi;
@@ -1051,6 +1058,7 @@ struct kvm_irq_routing_entry {
 		struct kvm_irq_routing_msi msi;
 		struct kvm_irq_routing_s390_adapter adapter;
 		struct kvm_irq_routing_hv_sint hv_sint;
+		struct kvm_irq_routing_xen_evtchn evtchn;
 		__u32 pad[8];
 	} u;
 };
-- 
2.11.0

