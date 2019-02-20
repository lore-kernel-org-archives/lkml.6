Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADA8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CECD218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IeY3iumG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfBTURi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:17:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51976 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfBTURe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8Xht081717;
        Wed, 20 Feb 2019 20:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=mdHWAv+RFA17VCCI7IU4ksER0LZyfmkASS+wZz/Vd28=;
 b=IeY3iumGqJMHu1u0Dgpp70e6hjbnzUO87NWuFoujPczT/YPGp7LyH1sZXWLjBuiiHhCJ
 o1JuyVRPdk0j/c8ez9dL/881mDuZiX+E6PUG3o6zze7s1A/plGo2cIol3U2Cq4bno9sN
 CjjMylzEoFYgVoQw3ELwpo/BOPvhHZgc4+jUi9YdayvVMm8dCuZljkn4Vicx5AME2hdd
 QdVafRCPaSauXTYXRq+C88DEjFxi16j156kCgOp5l21uLMWkeg9Vwj3UjzySinRiVVN3
 yqdCde4bxHIZ1YvGwNAXgMaeAkmYz46YDv+/efmk9jn08pHIW5LWLT21qDCz/pyCub3w Hw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:20 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHJr3025389
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:20 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHJPi011792;
        Wed, 20 Feb 2019 20:17:19 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:19 -0800
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
Subject: [PATCH RFC 08/39] KVM: x86/xen: register steal clock
Date:   Wed, 20 Feb 2019 20:15:38 +0000
Message-Id: <20190220201609.28290-9-joao.m.martins@oracle.com>
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

Allow emulator to register vcpu runstates which allow Xen guests
to use that for steal clock. The 'preempted' state of KVM steal clock
equates to 'runnable' state, 'running' has similar meanings for both and
'offline' is used when system admin needs to bring vcpu offline or
hotplug.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/x86.c              | 10 ++++++++
 arch/x86/kvm/xen.c              | 51 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/xen.h              |  2 ++
 include/uapi/linux/kvm.h        |  1 +
 5 files changed, 66 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f39d50dd8f40..9d388ba0a05c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -541,6 +541,8 @@ struct kvm_vcpu_xen {
 	struct vcpu_info *vcpu_info;
 	gpa_t pv_time_addr;
 	struct pvclock_vcpu_time_info *pv_time;
+	gpa_t steal_time_addr;
+	struct vcpu_runstate_info *steal_time;
 };
 
 struct kvm_vcpu_arch {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3ce97860e6ee..888598fdf543 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2389,6 +2389,11 @@ static void kvm_vcpu_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
 
 static void record_steal_time(struct kvm_vcpu *vcpu)
 {
+	if (vcpu->arch.xen.steal_time_addr) {
+		kvm_xen_setup_runstate_page(vcpu);
+		return;
+	}
+
 	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
 		return;
 
@@ -3251,6 +3256,11 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 {
+	if (vcpu->arch.xen.steal_time_addr) {
+		kvm_xen_runstate_set_preempted(vcpu);
+		return;
+	}
+
 	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
 		return;
 
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 77d1153386bc..4fdc4c71245a 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -9,9 +9,11 @@
 #include "xen.h"
 
 #include <linux/kvm_host.h>
+#include <linux/sched/stat.h>
 
 #include <trace/events/kvm.h>
 #include <xen/interface/xen.h>
+#include <xen/interface/vcpu.h>
 
 #include "trace.h"
 
@@ -30,6 +32,11 @@ static void set_vcpu_attr(struct kvm_vcpu *v, u16 type, gpa_t gpa, void *addr)
 		vcpu_xen->pv_time = addr;
 		kvm_xen_setup_pvclock_page(v);
 		break;
+	case KVM_XEN_ATTR_TYPE_VCPU_RUNSTATE:
+		vcpu_xen->steal_time_addr = gpa;
+		vcpu_xen->steal_time = addr;
+		kvm_xen_setup_runstate_page(v);
+		break;
 	default:
 		break;
 	}
@@ -44,6 +51,8 @@ static gpa_t get_vcpu_attr(struct kvm_vcpu *v, u16 type)
 		return vcpu_xen->vcpu_info_addr;
 	case KVM_XEN_ATTR_TYPE_VCPU_TIME_INFO:
 		return vcpu_xen->pv_time_addr;
+	case KVM_XEN_ATTR_TYPE_VCPU_RUNSTATE:
+		return vcpu_xen->steal_time_addr;
 	default:
 		return 0;
 	}
@@ -124,6 +133,41 @@ static void kvm_xen_update_vcpu_time(struct kvm_vcpu *v,
 	guest_hv_clock->version = vcpu->hv_clock.version;
 }
 
+void kvm_xen_runstate_set_preempted(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+	int state = RUNSTATE_runnable;
+
+	vcpu->arch.st.steal.preempted = KVM_VCPU_PREEMPTED;
+
+	vcpu_xen->steal_time->state = state;
+}
+
+void kvm_xen_setup_runstate_page(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+	struct vcpu_runstate_info runstate;
+
+	runstate = *vcpu_xen->steal_time;
+
+	runstate.state_entry_time += 1;
+	runstate.state_entry_time |= XEN_RUNSTATE_UPDATE;
+	vcpu_xen->steal_time->state_entry_time = runstate.state_entry_time;
+	smp_wmb();
+
+	vcpu->arch.st.steal.steal += current->sched_info.run_delay -
+		vcpu->arch.st.last_steal;
+	vcpu->arch.st.last_steal = current->sched_info.run_delay;
+
+	runstate.state = RUNSTATE_running;
+	runstate.time[RUNSTATE_runnable] = vcpu->arch.st.steal.steal;
+	*vcpu_xen->steal_time = runstate;
+
+	runstate.state_entry_time &= ~XEN_RUNSTATE_UPDATE;
+	vcpu_xen->steal_time->state_entry_time = runstate.state_entry_time;
+	smp_wmb();
+}
+
 void kvm_xen_setup_pvclock_page(struct kvm_vcpu *v)
 {
 	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(v);
@@ -155,6 +199,10 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		r = kvm_xen_shared_info_init(kvm, gfn);
 		break;
 	}
+	case KVM_XEN_ATTR_TYPE_VCPU_RUNSTATE:
+		if (unlikely(!sched_info_on()))
+			return -ENOTSUPP;
+	/* fallthrough */
 	case KVM_XEN_ATTR_TYPE_VCPU_TIME_INFO:
 	case KVM_XEN_ATTR_TYPE_VCPU_INFO: {
 		gpa_t gpa = data->u.vcpu_attr.gpa;
@@ -191,6 +239,7 @@ int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		data->u.shared_info.gfn = kvm->arch.xen.shinfo_addr;
 		break;
 	}
+	case KVM_XEN_ATTR_TYPE_VCPU_RUNSTATE:
 	case KVM_XEN_ATTR_TYPE_VCPU_TIME_INFO:
 	case KVM_XEN_ATTR_TYPE_VCPU_INFO: {
 		struct kvm_vcpu *v;
@@ -282,6 +331,8 @@ void kvm_xen_vcpu_uninit(struct kvm_vcpu *vcpu)
 		put_page(virt_to_page(vcpu_xen->vcpu_info));
 	if (vcpu_xen->pv_time)
 		put_page(virt_to_page(vcpu_xen->pv_time));
+	if (vcpu_xen->steal_time)
+		put_page(virt_to_page(vcpu_xen->steal_time));
 }
 
 void kvm_xen_destroy_vm(struct kvm *kvm)
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 10ebd0b7a25e..2feef68ee80f 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -17,6 +17,8 @@ static inline struct kvm_vcpu *xen_vcpu_to_vcpu(struct kvm_vcpu_xen *xen_vcpu)
 }
 
 void kvm_xen_setup_pvclock_page(struct kvm_vcpu *vcpu);
+void kvm_xen_setup_runstate_page(struct kvm_vcpu *vcpu);
+void kvm_xen_runstate_set_preempted(struct kvm_vcpu *vcpu);
 int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data);
 int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data);
 bool kvm_xen_hypercall_enabled(struct kvm *kvm);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8296c3a2434f..b91e57d9e6d3 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1475,6 +1475,7 @@ struct kvm_xen_hvm_attr {
 #define KVM_XEN_ATTR_TYPE_SHARED_INFO       0x0
 #define KVM_XEN_ATTR_TYPE_VCPU_INFO         0x1
 #define KVM_XEN_ATTR_TYPE_VCPU_TIME_INFO    0x2
+#define KVM_XEN_ATTR_TYPE_VCPU_RUNSTATE     0x3
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
-- 
2.11.0

