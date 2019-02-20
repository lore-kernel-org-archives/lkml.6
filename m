Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18ADC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42122146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZK0gbkf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfBTUR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:17:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51792 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfBTUR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8UCE081678;
        Wed, 20 Feb 2019 20:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=al+fO0YM+/IdPORa/NVtvyagkKve8vydINcMaFyRhuU=;
 b=ZK0gbkf7s34driGkAUZ6IKo9bt2YJud67HsrMiWjq72VI6Hou+zfqXodVdylQU07SOJp
 +vStemVsDTYrOEiTLa34xH2jtwDl0qh0Ax/0Xt7Qjd3yO2y5csDizXq7Ct1n7Gu5s1X6
 PhIq2+3s+B/cb2DmDBkh6hO1EahfgK0rBCmiOvk5J0ur26JKSY9lMCBcDOCnwQahrKBW
 cSyDVLxziDoo5P5txKHXdGFc3mprc1ZheFrmtDGThHkKpIUJXGXjjXu0RA3+H4aQeHfF
 ozzyfNex0mtxsl9EvZygl3LM/PIcf7mYl7Ld05fze8n3qYzeHasO2w/mWiNNExZGDjPb Rg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:13 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKH7nP020701
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:07 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKH6U7018096;
        Wed, 20 Feb 2019 20:17:06 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:05 -0800
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
Subject: [PATCH RFC 04/39] KVM: x86/xen: setup pvclock updates
Date:   Wed, 20 Feb 2019 20:15:34 +0000
Message-Id: <20190220201609.28290-5-joao.m.martins@oracle.com>
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

This means when we set shared_info page GPA, and request a master
clock update. This will trigger all vcpus to update their respective
shared pvclock data with guests. We follow a similar approach
as Hyper-V and KVM and adjust it accordingly.

Note however that Xen differs a little on how pvclock pages are set up.
Specifically KVM assumes 4K page alignment and pvclock data starts in
the beginning of the page. Whereas Xen you can place that information
anywhere in the page.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/kvm/x86.c |  2 ++
 arch/x86/kvm/xen.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/xen.h |  1 +
 3 files changed, 50 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1eda96304180..6eb2afaa2af2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2211,6 +2211,8 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
 
 	if (vcpu->pv_time_enabled)
 		kvm_setup_pvclock_page(v);
+	if (ka->xen.shinfo)
+		kvm_xen_setup_pvclock_page(v);
 	if (v == kvm_get_vcpu(v->kvm, 0))
 		kvm_hv_setup_tsc_page(v->kvm, &vcpu->hv_clock);
 	return 0;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 4df223bd3cd7..b4bd1949656e 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -29,9 +29,56 @@ static int kvm_xen_shared_info_init(struct kvm *kvm, gfn_t gfn)
 	shared_info = page_to_virt(page);
 	memset(shared_info, 0, sizeof(struct shared_info));
 	kvm->arch.xen.shinfo = shared_info;
+
+	kvm_make_all_cpus_request(kvm, KVM_REQ_MASTERCLOCK_UPDATE);
 	return 0;
 }
 
+void kvm_xen_setup_pvclock_page(struct kvm_vcpu *v)
+{
+	struct kvm_vcpu_arch *vcpu = &v->arch;
+	struct pvclock_vcpu_time_info *guest_hv_clock;
+	unsigned int offset;
+
+	if (v->vcpu_id >= MAX_VIRT_CPUS)
+		return;
+
+	offset = offsetof(struct vcpu_info, time);
+	offset += offsetof(struct shared_info, vcpu_info);
+	offset += v->vcpu_id * sizeof(struct vcpu_info);
+
+	guest_hv_clock = (struct pvclock_vcpu_time_info *)
+		(((void *)v->kvm->arch.xen.shinfo) + offset);
+
+	BUILD_BUG_ON(offsetof(struct pvclock_vcpu_time_info, version) != 0);
+
+	if (guest_hv_clock->version & 1)
+		++guest_hv_clock->version;  /* first time write, random junk */
+
+	vcpu->hv_clock.version = guest_hv_clock->version + 1;
+	guest_hv_clock->version = vcpu->hv_clock.version;
+
+	smp_wmb();
+
+	/* retain PVCLOCK_GUEST_STOPPED if set in guest copy */
+	vcpu->hv_clock.flags |= (guest_hv_clock->flags & PVCLOCK_GUEST_STOPPED);
+
+	if (vcpu->pvclock_set_guest_stopped_request) {
+		vcpu->hv_clock.flags |= PVCLOCK_GUEST_STOPPED;
+		vcpu->pvclock_set_guest_stopped_request = false;
+	}
+
+	trace_kvm_pvclock_update(v->vcpu_id, &vcpu->hv_clock);
+
+	*guest_hv_clock = vcpu->hv_clock;
+
+	smp_wmb();
+
+	vcpu->hv_clock.version++;
+
+	guest_hv_clock->version = vcpu->hv_clock.version;
+}
+
 int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 {
 	int r = -ENOENT;
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index bb38edf383fe..827c9390da34 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -3,6 +3,7 @@
 #ifndef __ARCH_X86_KVM_XEN_H__
 #define __ARCH_X86_KVM_XEN_H__
 
+void kvm_xen_setup_pvclock_page(struct kvm_vcpu *vcpu);
 int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data);
 int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data);
 bool kvm_xen_hypercall_enabled(struct kvm *kvm);
-- 
2.11.0

