Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FEBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01CE2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="odgzp3Za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfBTUS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:18:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36010 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbfBTUSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8mh1087654;
        Wed, 20 Feb 2019 20:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=NU46i4dx5S4gBMOqXT0/SvgK/gbayTEmAnpW0YFRcz0=;
 b=odgzp3Zas0N1pt2dNs73fQjVXeCP72PlzImpjrbGORjlInMYrFmD1azVPFguLdkr1kV2
 hYtvLaQHIIjscJs+/uMJ05HVrIu8t9Y/GbuYk0CfqIs5+dEen0kAvXUHpSmnyhde/ZD2
 pki7EOXSjZQNcPAnU++7dEzcPs4HcpfYP6XHlPkHATiqMUT4WOfpQW/fqIpGI88OX3BY
 PwzB8c1r9PwI/iYmGDiCK+wzy7mOCFJR8CzEWue8ZCmrWeXRAwdi9c/BBP7LQjoJKaBc
 dgMhUY6c7BxV9fDSzSnrVML8ZV/3x5fiyR9gC3ksahm6gTRlv40kLB8b2C6gvrqsqf/S /w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qpb5rkttc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKI4TG006421
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:04 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKI3OM012216;
        Wed, 20 Feb 2019 20:18:04 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:03 -0800
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
Subject: [PATCH RFC 22/39] KVM: x86/xen: grant table init
Date:   Wed, 20 Feb 2019 20:15:52 +0000
Message-Id: <20190220201609.28290-23-joao.m.martins@oracle.com>
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

Add support for guest grant table initialization. This is mostly
scaffolding at this point: we allocate grant table state and map
it globally.

Later patches add support for seeding the grant table with reserved
entries, and setup maptrack which would be used for grant map and unmap
operations.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/include/asm/kvm_host.h | 19 +++++++++
 arch/x86/kvm/xen.c              | 88 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/xen.h              |  1 +
 include/uapi/linux/kvm.h        | 13 ++++++
 4 files changed, 121 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 384247fc433d..e0cbc0899580 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -860,6 +860,23 @@ struct kvm_hv {
 	atomic_t num_mismatched_vp_indexes;
 };
 
+/* Xen grant table */
+struct kvm_grant_table {
+	u32 nr_frames;
+	u32 max_nr_frames;
+	union {
+		void **frames;
+		struct grant_entry_v1 **frames_v1;
+	};
+	gfn_t *frames_addr;
+	gpa_t initial_addr;
+	struct grant_entry_v1 *initial;
+
+	/* maptrack limits */
+	u32 max_mt_frames;
+	u32 nr_mt_frames;
+};
+
 /* Xen emulation context */
 struct kvm_xen {
 	u64 xen_hypercall;
@@ -871,6 +888,8 @@ struct kvm_xen {
 	struct idr port_to_evt;
 	unsigned long poll_mask[BITS_TO_LONGS(KVM_MAX_VCPUS)];
 	struct mutex xen_lock;
+
+	struct kvm_grant_table gnttab;
 };
 
 enum kvm_xen_callback_via {
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index e570c9b26563..b9e6e8f72d87 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -17,6 +17,7 @@
 #include <xen/interface/xen.h>
 #include <xen/interface/vcpu.h>
 #include <xen/interface/event_channel.h>
+#include <xen/interface/grant_table.h>
 #include <xen/interface/sched.h>
 
 #include "trace.h"
@@ -35,6 +36,7 @@ struct evtchnfd {
 
 static int kvm_xen_evtchn_send(struct kvm_vcpu *vcpu, int port);
 static void *xen_vcpu_info(struct kvm_vcpu *v);
+static void kvm_xen_gnttab_free(struct kvm_xen *xen);
 
 #define XEN_DOMID_MIN	1
 #define XEN_DOMID_MAX	(DOMID_FIRST_RESERVED - 1)
@@ -513,6 +515,12 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		r = kvm_xen_domid_init(kvm, any, domid);
 		break;
 	}
+	case KVM_XEN_ATTR_TYPE_GNTTAB: {
+		struct kvm_xen_gnttab xevfd = data->u.gnttab;
+
+		r = kvm_vm_ioctl_xen_gnttab(kvm, &xevfd);
+		break;
+	}
 	default:
 		break;
 	}
@@ -969,6 +977,7 @@ void kvm_xen_destroy_vm(struct kvm *kvm)
 		put_page(virt_to_page(xen->shinfo));
 
 	kvm_xen_free_domid(kvm);
+	kvm_xen_gnttab_free(&kvm->arch.xen);
 }
 
 void kvm_xen_init(void)
@@ -1093,3 +1102,82 @@ int kvm_vm_ioctl_xen_eventfd(struct kvm *kvm, struct kvm_xen_eventfd *args)
 	return kvm_xen_eventfd_assign(kvm, &xen->port_to_evt,
 				      &xen->xen_lock, args);
 }
+
+int kvm_xen_gnttab_init(struct kvm *kvm, struct kvm_xen *xen,
+			struct kvm_xen_gnttab *op, int dom0)
+{
+	u32 max_mt_frames = op->init.max_maptrack_frames;
+	unsigned long initial = op->init.initial_frame;
+	struct kvm_grant_table *gnttab = &xen->gnttab;
+	u32 max_frames = op->init.max_frames;
+	struct page *page = NULL;
+	void *addr;
+
+	if (!dom0) {
+		if (!op->init.initial_frame ||
+		    offset_in_page(op->init.initial_frame))
+			return -EINVAL;
+
+		if (get_user_pages_fast(initial, 1, 1, &page) != 1)
+			return -EFAULT;
+
+		gnttab->initial_addr = initial;
+		gnttab->initial = page_to_virt(page);
+		put_page(page);
+	}
+
+	addr = kcalloc(max_frames, sizeof(gfn_t), GFP_KERNEL);
+	if (!addr)
+		goto out;
+	xen->gnttab.frames_addr = addr;
+
+	addr = kcalloc(max_frames, sizeof(addr), GFP_KERNEL);
+	if (!addr)
+		goto out;
+
+	gnttab->frames = addr;
+	gnttab->frames[0] = xen->gnttab.initial;
+	gnttab->max_nr_frames = max_frames;
+	gnttab->max_mt_frames = max_mt_frames;
+	gnttab->nr_mt_frames = 1;
+	gnttab->nr_frames = 0;
+
+	pr_debug("kvm_xen: dom%u: grant table limits (gnttab:%d maptrack:%d)\n",
+		 xen->domid, gnttab->max_nr_frames, gnttab->max_mt_frames);
+	return 0;
+
+out:
+	kfree(xen->gnttab.frames);
+	kfree(xen->gnttab.frames_addr);
+	if (page)
+		put_page(page);
+	memset(&xen->gnttab, 0, sizeof(xen->gnttab));
+	return -ENOMEM;
+}
+
+void kvm_xen_gnttab_free(struct kvm_xen *xen)
+{
+	struct kvm_grant_table *gnttab = &xen->gnttab;
+
+	kfree(gnttab->frames);
+	kfree(gnttab->frames_addr);
+}
+
+int kvm_vm_ioctl_xen_gnttab(struct kvm *kvm, struct kvm_xen_gnttab *op)
+{
+	int r = -EINVAL;
+
+	if (!op)
+		return r;
+
+	switch (op->flags) {
+	case KVM_XEN_GNTTAB_F_INIT:
+		r = kvm_xen_gnttab_init(kvm, &kvm->arch.xen, op, 0);
+		break;
+	default:
+		r = -ENOSYS;
+		break;
+	}
+
+	return r;
+}
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 76ef2150c650..08ad4e1259df 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -37,6 +37,7 @@ int kvm_xen_setup_evtchn(struct kvm *kvm,
 void kvm_xen_init_vm(struct kvm *kvm);
 void kvm_xen_destroy_vm(struct kvm *kvm);
 int kvm_vm_ioctl_xen_eventfd(struct kvm *kvm, struct kvm_xen_eventfd *args);
+int kvm_vm_ioctl_xen_gnttab(struct kvm *kvm, struct kvm_xen_gnttab *op);
 void kvm_xen_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_xen_vcpu_uninit(struct kvm_vcpu *vcpu);
 void kvm_xen_init(void);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 3212cad732dd..e4fb9bc34d61 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1503,6 +1503,18 @@ struct kvm_xen_hvm_attr {
 		struct {
 			__s32 domid;
 		} dom;
+		struct kvm_xen_gnttab {
+#define KVM_XEN_GNTTAB_F_INIT		0
+			__u32 flags;
+			union {
+				struct {
+					__u32 max_frames;
+					__u32 max_maptrack_frames;
+					__u64 initial_frame;
+				} init;
+				__u32 padding[4];
+			};
+		} gnttab;
 	} u;
 };
 
@@ -1514,6 +1526,7 @@ struct kvm_xen_hvm_attr {
 /* Available with KVM_CAP_XEN_HVM_EVTCHN */
 #define KVM_XEN_ATTR_TYPE_EVTCHN            0x4
 #define KVM_XEN_ATTR_TYPE_DOMID             0x5
+#define KVM_XEN_ATTR_TYPE_GNTTAB            0x6
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
-- 
2.11.0

