Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109DBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80932147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eyDCvbxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfBTUSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:18:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33644 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfBTUSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:21 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8Y1B087453;
        Wed, 20 Feb 2019 20:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Ocu54pk3NtEKCI8wPFFHUf3OhFUmnOlU+mn28ZBsLxs=;
 b=eyDCvbxcxlnQUnAhXMWTq12RS2kENa36wky7g0bR1uaDpPp0n12Qhvrbw8nqE73ssvaN
 gS9dCp2T+M5HyF/lEevsnAGGLa0bzokAJSf4pXTnSUmLwewez/yjWISzLmKl3NTElg36
 Sp3G9VGWANNuTWww/+KtnC4ouasEH6SM3DGDdkLgbItPQ6lm7jrcbY+eapIHTUUiexgx
 iygX6DtGHYMnBmmwJlzYnCkEsRGnhU8f/2kcGSj22Cvvcm6ilvRqWoCppiue7M3Dp6eU
 pQ4m6z1r87WWBFyDsewGFF+4Wxov7EEp1WG6b9jv83U3PHWmCdlwLMVBi7uK8pmViWhz gA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qp81ec3cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:07 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKI0fu027446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:01 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKI0x3009753;
        Wed, 20 Feb 2019 20:18:00 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:00 -0800
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
Subject: [PATCH RFC 21/39] KVM: x86/xen: domid allocation
Date:   Wed, 20 Feb 2019 20:15:51 +0000
Message-Id: <20190220201609.28290-22-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=636 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace requests a free @domid to be assigned to itself, or
explicitly selects one by setting @any to 0. The @domid is then
used for various interdomain/unbound event purposes.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/x86.c              |  2 ++
 arch/x86/kvm/xen.c              | 70 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/xen.h              |  2 ++
 include/uapi/linux/kvm.h        |  4 +++
 5 files changed, 80 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c629fedb2e21..384247fc433d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -27,6 +27,7 @@
 #include <linux/clocksource.h>
 #include <linux/irqbypass.h>
 #include <linux/hyperv.h>
+#include <xen/interface/xen.h>
 
 #include <asm/apic.h>
 #include <asm/pvclock-abi.h>
@@ -862,6 +863,7 @@ struct kvm_hv {
 /* Xen emulation context */
 struct kvm_xen {
 	u64 xen_hypercall;
+	domid_t domid;
 
 	gfn_t shinfo_addr;
 	struct shared_info *shinfo;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b1d9045d7989..cb95f7f8bed9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6986,6 +6986,7 @@ int kvm_arch_init(void *opaque)
 	if (hypervisor_is_type(X86_HYPER_MS_HYPERV))
 		set_hv_tscchange_cb(kvm_hyperv_tsc_notifier);
 #endif
+	kvm_xen_init();
 
 	return 0;
 
@@ -6999,6 +7000,7 @@ int kvm_arch_init(void *opaque)
 
 void kvm_arch_exit(void)
 {
+	kvm_xen_exit();
 #ifdef CONFIG_X86_64
 	if (hypervisor_is_type(X86_HYPER_MS_HYPERV))
 		clear_hv_tscchange_cb();
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 07066402737d..e570c9b26563 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -36,6 +36,48 @@ struct evtchnfd {
 static int kvm_xen_evtchn_send(struct kvm_vcpu *vcpu, int port);
 static void *xen_vcpu_info(struct kvm_vcpu *v);
 
+#define XEN_DOMID_MIN	1
+#define XEN_DOMID_MAX	(DOMID_FIRST_RESERVED - 1)
+
+static rwlock_t domid_lock;
+static struct idr domid_to_kvm;
+
+static int kvm_xen_domid_init(struct kvm *kvm, bool any, domid_t domid)
+{
+	u16 min = XEN_DOMID_MIN, max = XEN_DOMID_MAX;
+	struct kvm_xen *xen = &kvm->arch.xen;
+	int ret;
+
+	if (!any) {
+		min = domid;
+		max = domid + 1;
+	}
+
+	write_lock_bh(&domid_lock);
+	ret = idr_alloc(&domid_to_kvm, kvm, min, max, GFP_ATOMIC);
+	write_unlock_bh(&domid_lock);
+
+	if (ret < 0)
+		return ret;
+
+	xen->domid = ret;
+	return 0;
+}
+
+int kvm_xen_free_domid(struct kvm *kvm)
+{
+	struct kvm_xen *xen = &kvm->arch.xen;
+	struct kvm *vm;
+
+	write_lock_bh(&domid_lock);
+	vm = idr_remove(&domid_to_kvm, xen->domid);
+	write_unlock_bh(&domid_lock);
+
+	synchronize_srcu(&kvm->srcu);
+
+	return vm == kvm;
+}
+
 int kvm_xen_has_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
@@ -460,6 +502,17 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		r = kvm_vm_ioctl_xen_eventfd(kvm, &xevfd);
 		break;
 	}
+	case KVM_XEN_ATTR_TYPE_DOMID: {
+		domid_t domid = (u16) data->u.dom.domid;
+		bool any = (data->u.dom.domid < 0);
+
+		/* Domain ID 0 or >= 0x7ff0 are reserved */
+		if (!any && (!domid || (domid >= XEN_DOMID_MAX)))
+			return -EINVAL;
+
+		r = kvm_xen_domid_init(kvm, any, domid);
+		break;
+	}
 	default:
 		break;
 	}
@@ -489,6 +542,11 @@ int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		r = 0;
 		break;
 	}
+	case KVM_XEN_ATTR_TYPE_DOMID: {
+		data->u.dom.domid = kvm->arch.xen.domid;
+		r = 0;
+		break;
+	}
 	default:
 		break;
 	}
@@ -909,6 +967,18 @@ void kvm_xen_destroy_vm(struct kvm *kvm)
 
 	if (xen->shinfo)
 		put_page(virt_to_page(xen->shinfo));
+
+	kvm_xen_free_domid(kvm);
+}
+
+void kvm_xen_init(void)
+{
+	idr_init(&domid_to_kvm);
+	rwlock_init(&domid_lock);
+}
+
+void kvm_xen_exit(void)
+{
 }
 
 static int kvm_xen_eventfd_update(struct kvm *kvm, struct idr *port_to_evt,
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index f82b8b5b3345..76ef2150c650 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -39,6 +39,8 @@ void kvm_xen_destroy_vm(struct kvm *kvm);
 int kvm_vm_ioctl_xen_eventfd(struct kvm *kvm, struct kvm_xen_eventfd *args);
 void kvm_xen_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_xen_vcpu_uninit(struct kvm_vcpu *vcpu);
+void kvm_xen_init(void);
+void kvm_xen_exit(void);
 
 void __kvm_migrate_xen_timer(struct kvm_vcpu *vcpu);
 int kvm_xen_has_pending_timer(struct kvm_vcpu *vcpu);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 1b3ecce5f92e..3212cad732dd 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1500,6 +1500,9 @@ struct kvm_xen_hvm_attr {
 				__u32 padding[2];
 			};
 		} evtchn;
+		struct {
+			__s32 domid;
+		} dom;
 	} u;
 };
 
@@ -1510,6 +1513,7 @@ struct kvm_xen_hvm_attr {
 #define KVM_XEN_ATTR_TYPE_VCPU_RUNSTATE     0x3
 /* Available with KVM_CAP_XEN_HVM_EVTCHN */
 #define KVM_XEN_ATTR_TYPE_EVTCHN            0x4
+#define KVM_XEN_ATTR_TYPE_DOMID             0x5
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
-- 
2.11.0

