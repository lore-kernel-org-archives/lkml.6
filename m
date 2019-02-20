Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D503CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7122146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZqLyANRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfBTUVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:21:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60974 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfBTURb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:31 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK95Wd088088;
        Wed, 20 Feb 2019 20:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=l7fb/dXFfaQBZgqf9ui2KpVrBMWCvGVoCEVnuwIloQc=;
 b=ZqLyANRgYj0arQDEs4AfnZcFy6M1QcRyNS3X58r54VNyflHV/wcHNPQu4a14VRpw0vei
 i2d8cWodYI+6PsHzc2m4HzXOGVk3Z50+9ihnLhFinYntlMAAWBPVbHo5hfWx+QAH4DCo
 ea9cNRb9Jc6zoPCpGEB4bPn03s+dTc7qHS0OARPvTS75LEjOsFbuDzRA1U5J2bjHDFRv
 0VI411AbSZx9ddrU3frJHkgL/QdeHZJys+LJQaCN3RtVfw9Hp8H96/HxSJ4PKjDsqfNU
 wRsPPh/VFhub7g960D+ouSOn1JMpOdTRUS8K26c0FHEHcdq4XeS3t746U3o94Pa5J4Pg 8g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qp81ec382-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:17 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHGra015952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:16 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHGMi009307;
        Wed, 20 Feb 2019 20:17:16 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:15 -0800
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
Subject: [PATCH RFC 07/39] KVM: x86/xen: register vcpu time info region
Date:   Wed, 20 Feb 2019 20:15:37 +0000
Message-Id: <20190220201609.28290-8-joao.m.martins@oracle.com>
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

Allow the Xen emulated guest the ability to register secondary
vcpu time information. On Xen guests this is used in order to be
mapped to userspace and hence allow vdso gettimeofday to work.

In doing so, move kvm_xen_set_pvclock_page() logic to
kvm_xen_update_vcpu_time() and have the former a top-level
function which updates primary vcpu time info (in struct vcpu_info)
and secondary one.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/xen.c              | 45 ++++++++++++++++++++++++++++++-----------
 include/uapi/linux/kvm.h        |  1 +
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 96f65ba4b3c0..f39d50dd8f40 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -539,6 +539,8 @@ struct kvm_vcpu_xen {
 	struct kvm_xen_exit exit;
 	gpa_t vcpu_info_addr;
 	struct vcpu_info *vcpu_info;
+	gpa_t pv_time_addr;
+	struct pvclock_vcpu_time_info *pv_time;
 };
 
 struct kvm_vcpu_arch {
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 36d6dd0ea4b8..77d1153386bc 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -25,6 +25,11 @@ static void set_vcpu_attr(struct kvm_vcpu *v, u16 type, gpa_t gpa, void *addr)
 		vcpu_xen->vcpu_info = addr;
 		kvm_xen_setup_pvclock_page(v);
 		break;
+	case KVM_XEN_ATTR_TYPE_VCPU_TIME_INFO:
+		vcpu_xen->pv_time_addr = gpa;
+		vcpu_xen->pv_time = addr;
+		kvm_xen_setup_pvclock_page(v);
+		break;
 	default:
 		break;
 	}
@@ -37,6 +42,8 @@ static gpa_t get_vcpu_attr(struct kvm_vcpu *v, u16 type)
 	switch (type) {
 	case KVM_XEN_ATTR_TYPE_VCPU_INFO:
 		return vcpu_xen->vcpu_info_addr;
+	case KVM_XEN_ATTR_TYPE_VCPU_TIME_INFO:
+		return vcpu_xen->pv_time_addr;
 	default:
 		return 0;
 	}
@@ -83,20 +90,10 @@ static void *xen_vcpu_info(struct kvm_vcpu *v)
 	return hva + offset;
 }
 
-void kvm_xen_setup_pvclock_page(struct kvm_vcpu *v)
+static void kvm_xen_update_vcpu_time(struct kvm_vcpu *v,
+				 struct pvclock_vcpu_time_info *guest_hv_clock)
 {
 	struct kvm_vcpu_arch *vcpu = &v->arch;
-	struct pvclock_vcpu_time_info *guest_hv_clock;
-	void *hva = xen_vcpu_info(v);
-	unsigned int offset;
-
-	if (!hva)
-		return;
-
-	offset = offsetof(struct vcpu_info, time);
-
-	guest_hv_clock = (struct pvclock_vcpu_time_info *)
-		(hva + offset);
 
 	BUILD_BUG_ON(offsetof(struct pvclock_vcpu_time_info, version) != 0);
 
@@ -127,6 +124,26 @@ void kvm_xen_setup_pvclock_page(struct kvm_vcpu *v)
 	guest_hv_clock->version = vcpu->hv_clock.version;
 }
 
+void kvm_xen_setup_pvclock_page(struct kvm_vcpu *v)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(v);
+	struct pvclock_vcpu_time_info *guest_hv_clock;
+	void *hva = xen_vcpu_info(v);
+	unsigned int offset;
+
+	offset = offsetof(struct vcpu_info, time);
+	guest_hv_clock = (struct pvclock_vcpu_time_info *) (hva + offset);
+
+	if (likely(hva))
+		kvm_xen_update_vcpu_time(v, guest_hv_clock);
+
+	/* Update secondary pvclock region if registered */
+	if (vcpu_xen->pv_time_addr) {
+		guest_hv_clock = vcpu_xen->pv_time;
+		kvm_xen_update_vcpu_time(v, guest_hv_clock);
+	}
+}
+
 int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 {
 	int r = -ENOENT;
@@ -138,6 +155,7 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		r = kvm_xen_shared_info_init(kvm, gfn);
 		break;
 	}
+	case KVM_XEN_ATTR_TYPE_VCPU_TIME_INFO:
 	case KVM_XEN_ATTR_TYPE_VCPU_INFO: {
 		gpa_t gpa = data->u.vcpu_attr.gpa;
 		struct kvm_vcpu *v;
@@ -173,6 +191,7 @@ int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		data->u.shared_info.gfn = kvm->arch.xen.shinfo_addr;
 		break;
 	}
+	case KVM_XEN_ATTR_TYPE_VCPU_TIME_INFO:
 	case KVM_XEN_ATTR_TYPE_VCPU_INFO: {
 		struct kvm_vcpu *v;
 
@@ -261,6 +280,8 @@ void kvm_xen_vcpu_uninit(struct kvm_vcpu *vcpu)
 
 	if (vcpu_xen->vcpu_info)
 		put_page(virt_to_page(vcpu_xen->vcpu_info));
+	if (vcpu_xen->pv_time)
+		put_page(virt_to_page(vcpu_xen->pv_time));
 }
 
 void kvm_xen_destroy_vm(struct kvm *kvm)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 782f497a0fdd..8296c3a2434f 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1474,6 +1474,7 @@ struct kvm_xen_hvm_attr {
 
 #define KVM_XEN_ATTR_TYPE_SHARED_INFO       0x0
 #define KVM_XEN_ATTR_TYPE_VCPU_INFO         0x1
+#define KVM_XEN_ATTR_TYPE_VCPU_TIME_INFO    0x2
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
-- 
2.11.0

