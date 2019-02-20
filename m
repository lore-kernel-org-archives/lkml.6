Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EF421848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uOVgl3zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfBTUSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:18:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33758 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfBTUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:28 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8Vnp087437;
        Wed, 20 Feb 2019 20:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=7ig7Sg5h1FYfSi3sU0r70ZC4ydxm/2hRabR9MYY/Poo=;
 b=uOVgl3zk+npTxYojOEiTH2Ghkie7xpuN+jto+FoUtZUfjYXI1v8YxENbYwhKJU2JDUj9
 GZmztXGXisR8lJ336quvpcXY2WCmfuAeX16oxAwkUyJQ0Zi3IjFuVyazCYGciBd+mk32
 3Y8koDm9j/dduPjxw3xlZ9NzPFl2IALiLO73FGuQODkIz05Hfo1sagEu41eEKOQquVxY
 QfkGk0THheJNMo5v0a2jSkRFqBNayh4xMcuV9j+flmEDg6vrJ5CC8FzmKeSCj6OVabVr
 BISlPoJSLCupgyFwfyvX9L10mpbiOZQ7N8XWNeN1GB/QwkUN4sml1d3yQhJ62XyiofM1 pA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qp81ec3d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:12 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKI7hm006514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:07 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKI7Ln009812;
        Wed, 20 Feb 2019 20:18:07 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:06 -0800
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
Subject: [PATCH RFC 23/39] KVM: x86/xen: grant table grow support
Date:   Wed, 20 Feb 2019 20:15:53 +0000
Message-Id: <20190220201609.28290-24-joao.m.martins@oracle.com>
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

Guests grant tables with core Xen PV devices (xenbus, console) need to
be seeded with a bunch of reserved entries at boot. However, at init,
the grant table is, from a guest perspective, empty and has no frames
backing it. That only happens once the guest does:

 XENMEM_add_to_physmap(idx=N,gfn=M,space=XENMAPSPACE_grant_table)

Which will share the added page with the hypervisor.

The way we handle this then is to seed (from userspace) the initial
frame where we store special entries which reference guest PV ring
pages. These pages are in-turn mapped/unmapped in backend domains
hosting xenstored and xenconsoled.

When the guest initializes its grant tables (with the hypercall listed
above) we copy the entries from the private frame into a "mapped" gfn.
To do this, the userspace VMM handles XENMEM_add_to_physmap hypercall and
the hypervisor grows its grant table. Note that a grant table can only
grow - no shrinking is possible.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/include/asm/kvm_host.h | 16 ++++++++
 arch/x86/kvm/xen.c              | 90 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h        |  5 +++
 3 files changed, 111 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e0cbc0899580..70bb7339ddd4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -860,6 +860,21 @@ struct kvm_hv {
 	atomic_t num_mismatched_vp_indexes;
 };
 
+struct kvm_grant_map {
+	u64 gpa;
+	union {
+		struct {
+
+#define _KVM_GNTMAP_ACTIVE      (15)
+#define KVM_GNTMAP_ACTIVE       (1 << _KVM_GNTMAP_ACTIVE)
+			u16 flags;
+			u16 ref;
+			u32 domid;
+		};
+		u64 fields;
+	};
+};
+
 /* Xen grant table */
 struct kvm_grant_table {
 	u32 nr_frames;
@@ -871,6 +886,7 @@ struct kvm_grant_table {
 	gfn_t *frames_addr;
 	gpa_t initial_addr;
 	struct grant_entry_v1 *initial;
+	struct kvm_grant_map **handle;
 
 	/* maptrack limits */
 	u32 max_mt_frames;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index b9e6e8f72d87..7266d27db210 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -22,6 +22,12 @@
 
 #include "trace.h"
 
+/* Grant v1 references per 4K page */
+#define GPP_V1 (PAGE_SIZE / sizeof(struct grant_entry_v1))
+
+/* Grant mappings per 4K page */
+#define MPP    (PAGE_SIZE / sizeof(struct kvm_grant_map))
+
 struct evtchnfd {
 	struct eventfd_ctx *ctx;
 	u32 vcpu;
@@ -1158,11 +1164,92 @@ int kvm_xen_gnttab_init(struct kvm *kvm, struct kvm_xen *xen,
 void kvm_xen_gnttab_free(struct kvm_xen *xen)
 {
 	struct kvm_grant_table *gnttab = &xen->gnttab;
+	int i;
+
+	for (i = 0; i < gnttab->nr_frames; i++)
+		put_page(virt_to_page(gnttab->frames[i]));
 
 	kfree(gnttab->frames);
 	kfree(gnttab->frames_addr);
 }
 
+int kvm_xen_gnttab_copy_initial_frame(struct kvm *kvm)
+{
+	struct kvm_grant_table *gnttab = &kvm->arch.xen.gnttab;
+	int idx = 0;
+
+	/* Only meant to copy the first gpa being populated */
+	if (!gnttab->initial_addr || !gnttab->frames[idx])
+		return -EINVAL;
+
+	memcpy(gnttab->frames[idx], gnttab->initial, PAGE_SIZE);
+	return 0;
+}
+
+int kvm_xen_maptrack_grow(struct kvm_xen *xen, u32 target)
+{
+	u32 max_entries = target * GPP_V1;
+	u32 nr_entries = xen->gnttab.nr_mt_frames * MPP;
+	int i, j, err = 0;
+	void *addr;
+
+	for (i = nr_entries, j = xen->gnttab.nr_mt_frames;
+	     i < max_entries; i += MPP, j++) {
+		addr = (void *) get_zeroed_page(GFP_KERNEL);
+		if (!addr) {
+			err = -ENOMEM;
+			break;
+		}
+
+		xen->gnttab.handle[j] = addr;
+	}
+
+	xen->gnttab.nr_mt_frames = j;
+	xen->gnttab.nr_frames = target;
+	return err;
+}
+
+int kvm_xen_gnttab_grow(struct kvm *kvm, struct kvm_xen_gnttab *op)
+{
+	struct kvm_xen *xen = &kvm->arch.xen;
+	struct kvm_grant_table *gnttab = &xen->gnttab;
+	gfn_t *map = gnttab->frames_addr;
+	u64 gfn = op->grow.gfn;
+	u32 idx = op->grow.idx;
+	struct page *page;
+
+	if (idx < gnttab->nr_frames || idx >= gnttab->max_nr_frames)
+		return -EINVAL;
+
+	if (!idx && !gnttab->nr_frames &&
+	    !gnttab->initial) {
+		return -EINVAL;
+	}
+
+	page = gfn_to_page(kvm, gfn);
+	if (is_error_page(page))
+		return -EINVAL;
+
+	map[idx] = gfn;
+
+	gnttab->frames[idx] = page_to_virt(page);
+	if (!idx && !gnttab->nr_frames &&
+	    kvm_xen_gnttab_copy_initial_frame(kvm)) {
+		pr_err("kvm_xen: dom%u: failed to copy initial frame\n",
+			xen->domid);
+		return -EFAULT;
+	}
+
+	if (kvm_xen_maptrack_grow(xen, gnttab->nr_frames + 1)) {
+		pr_warn("kvm_xen: dom%u: cannot grow maptrack\n", xen->domid);
+		return -EFAULT;
+	}
+
+	pr_debug("kvm_xen: dom%u: grant table grow frames:%d/%d\n", xen->domid,
+		 gnttab->nr_frames, gnttab->max_nr_frames);
+	return 0;
+}
+
 int kvm_vm_ioctl_xen_gnttab(struct kvm *kvm, struct kvm_xen_gnttab *op)
 {
 	int r = -EINVAL;
@@ -1174,6 +1261,9 @@ int kvm_vm_ioctl_xen_gnttab(struct kvm *kvm, struct kvm_xen_gnttab *op)
 	case KVM_XEN_GNTTAB_F_INIT:
 		r = kvm_xen_gnttab_init(kvm, &kvm->arch.xen, op, 0);
 		break;
+	case KVM_XEN_GNTTAB_F_GROW:
+		r = kvm_xen_gnttab_grow(kvm, op);
+		break;
 	default:
 		r = -ENOSYS;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index e4fb9bc34d61..ff7f7d019472 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1505,6 +1505,7 @@ struct kvm_xen_hvm_attr {
 		} dom;
 		struct kvm_xen_gnttab {
 #define KVM_XEN_GNTTAB_F_INIT		0
+#define KVM_XEN_GNTTAB_F_GROW		(1 << 0)
 			__u32 flags;
 			union {
 				struct {
@@ -1512,6 +1513,10 @@ struct kvm_xen_hvm_attr {
 					__u32 max_maptrack_frames;
 					__u64 initial_frame;
 				} init;
+				struct {
+					__u32 idx;
+					__u64 gfn;
+				} grow;
 				__u32 padding[4];
 			};
 		} gnttab;
-- 
2.11.0

