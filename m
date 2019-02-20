Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE36C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3D32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TAF37CCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfBTURt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:17:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33014 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfBTURr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:47 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8Vnk087437;
        Wed, 20 Feb 2019 20:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=tmD778ESsfRwNMq9An4G52B5oKCiX42JyVamao6ufmw=;
 b=TAF37CCyat1YdR1UjRk+dJuoA5zlEnM4afilHLYTgTx8Kc04kxyCiXmxs9Naoerb2cQy
 uw6u4CmGw4WcJ9VnEG2+v3ir2kF3JSpqKDxxfGPlOo5DB4m9hFDI3n7H+QCvyu3sI4L+
 Paz8FjEKZWHzSapv9LDktDuOOUd7KuGvPZwOSehojytBmUYMUodZLdMUz52zt/t23awU
 nb7FUhixGDSbotApDUPFTNQM/7/vo8LhO+WGserT0vfDgwoHTOLa3WhZOMSRuDu/1ZP2
 ohtcPI4ycz6NO6vRQVEPto9xzVF8ecNkSDNJ47EiRrExoAPxBmQY0gGEKJYvDRn1hynz wQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qp81ec39c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:33 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHWjQ025954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:32 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKHW0X018398;
        Wed, 20 Feb 2019 20:17:32 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:31 -0800
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
Subject: [PATCH RFC 12/39] KVM: x86/xen: store virq when assigning evtchn
Date:   Wed, 20 Feb 2019 20:15:42 +0000
Message-Id: <20190220201609.28290-13-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=941 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable virq offload to the hypervisor. The primary user for this is
the timer virq.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/xen.c              | 23 ++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f31fcaf8fa7c..92b76127eb43 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -550,6 +550,8 @@ struct kvm_vcpu_xen {
 	gpa_t steal_time_addr;
 	struct vcpu_runstate_info *steal_time;
 	struct kvm_xen_callback cb;
+#define KVM_XEN_NR_VIRQS 24
+	unsigned int virq_to_port[KVM_XEN_NR_VIRQS];
 };
 
 struct kvm_vcpu_arch {
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 1fbdfa7c4356..42c1fe01600d 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -101,6 +101,20 @@ static void kvm_xen_evtchnfd_upcall(struct kvm_vcpu *vcpu, struct evtchnfd *e)
 	kvm_xen_do_upcall(vcpu->kvm, e->vcpu, vx->cb.via, vx->cb.vector, 0);
 }
 
+void kvm_xen_set_virq(struct kvm *kvm, struct evtchnfd *evt)
+{
+	int virq = evt->virq.type;
+	struct kvm_vcpu_xen *vcpu_xen;
+	struct kvm_vcpu *vcpu;
+
+	vcpu = kvm_get_vcpu(kvm, evt->vcpu);
+	if (!vcpu)
+		return;
+
+	vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+	vcpu_xen->virq_to_port[virq] = evt->port;
+}
+
 int kvm_xen_set_evtchn(struct kvm_kernel_irq_routing_entry *e,
 		   struct kvm *kvm, int irq_source_id, int level,
 		   bool line_status)
@@ -620,6 +634,10 @@ static int kvm_xen_eventfd_assign(struct kvm *kvm, struct idr *port_to_evt,
 			return PTR_ERR(eventfd);
 	}
 
+	if (args->type == XEN_EVTCHN_TYPE_VIRQ &&
+	    args->virq.type >= KVM_XEN_NR_VIRQS)
+		return -EINVAL;
+
 	evtchnfd =  kzalloc(sizeof(struct evtchnfd), GFP_KERNEL);
 	if (!evtchnfd)
 		return -ENOMEM;
@@ -636,8 +654,11 @@ static int kvm_xen_eventfd_assign(struct kvm *kvm, struct idr *port_to_evt,
 			GFP_KERNEL);
 	mutex_unlock(port_lock);
 
-	if (ret >= 0)
+	if (ret >= 0) {
+		if (evtchnfd->type == XEN_EVTCHN_TYPE_VIRQ)
+			kvm_xen_set_virq(kvm, evtchnfd);
 		return 0;
+	}
 
 	if (ret == -ENOSPC)
 		ret = -EEXIST;
-- 
2.11.0

