Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEC0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDCD2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vip4g3s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfBTUR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:17:57 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33106 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfBTURw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:52 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8e45087617;
        Wed, 20 Feb 2019 20:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=y2ywQsg8ZwocwXwGKOAVPtXD+yYTYrFhFyWzqli6irA=;
 b=vip4g3s1j01PcCB7aJEcvW5bIh5NTRelBrf8d5VELn1ejI5Hf4lxTVMQ5C7dlGwvIgRY
 2ULqlnlcLUfcvqgKW1UKnwd9GDrUnLL+8nDtnPAIANF3f8RmMOHKMYRNM3Ptc9yiIvb7
 ESA3TZ9X7DVPwXQil9Inx1WRBjFT5ZEFluxhlTIQcLsL8xpPa0ux7pbwg5c4tv7og+tN
 N+IN05uHAjz6nQ6TjwgA3m6aE5K5RNQfeObGMyN3JN/YW/FpUPan2b9EBpX1hrCv6EZu
 gMNkwuk3TJrBheZk7qM1ovZSBRlUelyzjFwSxhX7IO/Sy5lnB9cL/aQEgWsmVaOu0/j8 lw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qp81ec39n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:39 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHcjF022141
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:38 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKHc8q018497;
        Wed, 20 Feb 2019 20:17:38 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:38 -0800
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
Subject: [PATCH RFC 14/39] KVM: x86/xen: handle PV IPI vcpu yield
Date:   Wed, 20 Feb 2019 20:15:44 +0000
Message-Id: <20190220201609.28290-15-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=907 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cooperative Linux guests after an IPI-many may yield vcpu if
any of the IPI'd vcpus were preempted (i.e. runstate is 'runnable'.)
Support SCHEDOP_yield for handling yield.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/kvm/xen.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index ec40cb1de6b6..753a6d2c11cd 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -17,6 +17,7 @@
 #include <xen/interface/xen.h>
 #include <xen/interface/vcpu.h>
 #include <xen/interface/event_channel.h>
+#include <xen/interface/sched.h>
 
 #include "trace.h"
 
@@ -668,6 +669,31 @@ static int kvm_xen_hcall_set_timer_op(struct kvm_vcpu *vcpu, uint64_t timeout)
 	return 0;
 }
 
+static int kvm_xen_hcall_sched_op(struct kvm_vcpu *vcpu, int cmd, u64 param)
+{
+	int ret = -ENOSYS;
+	gpa_t gpa;
+	int idx;
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	gpa = kvm_mmu_gva_to_gpa_system(vcpu, param, NULL);
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	if (!gpa)
+		return -EFAULT;
+
+	switch (cmd) {
+	case SCHEDOP_yield:
+		kvm_vcpu_on_spin(vcpu, true);
+		ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 {
 	bool longmode;
@@ -714,6 +740,11 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 		if (!r)
 			goto hcall_success;
 		break;
+	case __HYPERVISOR_sched_op:
+		r = kvm_xen_hcall_sched_op(vcpu, params[0], params[1]);
+		if (!r)
+			goto hcall_success;
+		break;
 	/* fallthrough */
 	default:
 		break;
-- 
2.11.0

