Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF17C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7591E21848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T6t+61v9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfBTUSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:18:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33222 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfBTUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:59 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8VDJ087434;
        Wed, 20 Feb 2019 20:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=iMKfAofvTA0lJaBbYGohbYbz6+eKYt5uJa2e5hpVk2Q=;
 b=T6t+61v9WlponIdHDeeGEW/SrwSmAPkFXqwbI1ktwHI/k/jCuwnN7Nfmg7njzwLedDRt
 geW003NOn/utXdzsUgbVOeodnYHFi8qzBXwnQ9OpolOkAH2A3IaQ84Yw4H7hKmekVnQB
 tkWabO4WpJ8SRNxwVYK/SejHAVjRg0ka98MM7YNwZSPOCTbdVAetf4MeE/vjDsZ9Rn36
 TxZ3ox4z3InKAzwzlaVzvnRjOS9emxupfRsNwyl0hDdeMEitJqhGW0eOA/Xuw8KRQMvU
 i8sE9Oww+fPQuzXZIEELOypKtD1nOP36WhfwY4MOO7aUpktmPASrq/RC8KRzu7J//Zv6 0A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qp81ec3a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:45 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHikT022432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:45 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHia2009656;
        Wed, 20 Feb 2019 20:17:44 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:44 -0800
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
Subject: [PATCH RFC 16/39] KVM: x86: declare Xen HVM evtchn offload capability
Date:   Wed, 20 Feb 2019 20:15:46 +0000
Message-Id: <20190220201609.28290-17-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=726 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new capability for event channel support in hypervisor.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 Documentation/virtual/kvm/api.txt | 9 +++++++++
 arch/x86/kvm/x86.c                | 1 +
 include/uapi/linux/kvm.h          | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index c3a1402b76bf..36d9386415fa 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -5037,3 +5037,12 @@ Architectures: x86
 
 This capability indicates that KVM supports Xen HVM guests.
 This includes KVM_IRQ_ROUTING_XEN_EVTCHN as well.
+
+8.23 KVM_CAP_XEN_HVM_EVTCHN
+
+Architectures: x86
+
+This capability indicates KVM's support for the event channel offload.
+Implies support for KVM_IRQ_ROUTING_XEN_EVTCHN irq routing, and
+for attribute KVM_XEN_ATTR_TYPE_EVTCHN in KVM_XEN_HVM_GET_ATTR or
+KVM_XEN_HVM_SET_ATTR.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e29cefd2dc6a..b1d9045d7989 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3010,6 +3010,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SET_IDENTITY_MAP_ADDR:
 	case KVM_CAP_XEN_HVM:
 	case KVM_CAP_XEN_HVM_GUEST:
+	case KVM_CAP_XEN_HVM_EVTCHN:
 	case KVM_CAP_VCPU_EVENTS:
 	case KVM_CAP_HYPERV:
 	case KVM_CAP_HYPERV_VAPIC:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4eae47a0ef63..1b3ecce5f92e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1004,6 +1004,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
 #define KVM_CAP_HYPERV_CPUID 167
 #define KVM_CAP_XEN_HVM_GUEST 168
+#define KVM_CAP_XEN_HVM_EVTCHN 169
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1046,6 +1047,7 @@ struct kvm_irq_routing_xen_evtchn {
 #define KVM_IRQ_ROUTING_MSI 2
 #define KVM_IRQ_ROUTING_S390_ADAPTER 3
 #define KVM_IRQ_ROUTING_HV_SINT 4
+/* Available with KVM_CAP_XEN_HVM_EVTCHN */
 #define KVM_IRQ_ROUTING_XEN_EVTCHN 5
 
 struct kvm_irq_routing_entry {
@@ -1506,6 +1508,7 @@ struct kvm_xen_hvm_attr {
 #define KVM_XEN_ATTR_TYPE_VCPU_INFO         0x1
 #define KVM_XEN_ATTR_TYPE_VCPU_TIME_INFO    0x2
 #define KVM_XEN_ATTR_TYPE_VCPU_RUNSTATE     0x3
+/* Available with KVM_CAP_XEN_HVM_EVTCHN */
 #define KVM_XEN_ATTR_TYPE_EVTCHN            0x4
 
 /* Secure Encrypted Virtualization command */
-- 
2.11.0

