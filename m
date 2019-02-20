Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BE2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3724121848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hphEvXpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfBTURl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:17:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35116 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfBTURh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8X04087279;
        Wed, 20 Feb 2019 20:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=f2LOq6B0XuNZKZBzoY6FcLJqthrRVeHYrz/V57Db200=;
 b=hphEvXpQvvu/TvmmgwOlbxm3ToiZS1n4SWX6Lch6HFUhfFq0x4eKmRRslA4RuNwUgvrm
 rfKOhoKAvZMvrBILMVyW8SX0/qxz+1YyhhoDOHZIQSkVS3w+biI6Vha2XjG8jEF2BRV5
 4mU32lOg0tL4p7oxDIpAvY1lQxG4Rv7EO6DBPNxmciDu+rVFbTnTtqasey6b4NRxRpc6
 3B4gQbUCQ8XXqLqb7ej+f0bYa5q1Bb6LjwyclKW/f5Yp61XIGzkMOuOupaXLQJ3skux8
 WP7ZzdK181aD91pwRBD5aKEDG8cmbcVWCF+PeWF+YgvDkRqVaG8m6UF/pBhbKgEX6cM1 5A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qpb5rktph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:23 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHMNa025505
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:22 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHMFB009375;
        Wed, 20 Feb 2019 20:17:22 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:22 -0800
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
Subject: [PATCH RFC 09/39] KVM: x86: declare Xen HVM guest capability
Date:   Wed, 20 Feb 2019 20:15:39 +0000
Message-Id: <20190220201609.28290-10-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=715 adultscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also take the chance to document this rather old capability of
KVM_CAP_XEN_HVM which only means it supports the Xen hypercall MSR.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 Documentation/virtual/kvm/api.txt | 14 ++++++++++++++
 arch/x86/kvm/x86.c                |  1 +
 include/uapi/linux/kvm.h          |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 356156f5c52d..c3a1402b76bf 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -5016,6 +5016,7 @@ CPU when the exception is taken. If this virtual SError is taken to EL1 using
 AArch64, this value will be reported in the ISS field of ESR_ELx.
 
 See KVM_CAP_VCPU_EVENTS for more details.
+
 8.20 KVM_CAP_HYPERV_SEND_IPI
 
 Architectures: x86
@@ -5023,3 +5024,16 @@ Architectures: x86
 This capability indicates that KVM supports paravirtualized Hyper-V IPI send
 hypercalls:
 HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
+
+8.21 KVM_CAP_XEN_HVM
+
+Architectures: x86
+
+This capability indicates that KVM supports the Xen hypercall page MSR.
+
+8.22 KVM_CAP_XEN_HVM_GUEST
+
+Architectures: x86
+
+This capability indicates that KVM supports Xen HVM guests.
+This includes KVM_IRQ_ROUTING_XEN_EVTCHN as well.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 888598fdf543..11b9ff2bd901 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3009,6 +3009,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_PIT_STATE2:
 	case KVM_CAP_SET_IDENTITY_MAP_ADDR:
 	case KVM_CAP_XEN_HVM:
+	case KVM_CAP_XEN_HVM_GUEST:
 	case KVM_CAP_VCPU_EVENTS:
 	case KVM_CAP_HYPERV:
 	case KVM_CAP_HYPERV_VAPIC:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b91e57d9e6d3..682ea00abd58 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1003,6 +1003,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
 #define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
 #define KVM_CAP_HYPERV_CPUID 167
+#define KVM_CAP_XEN_HVM_GUEST 168
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1455,6 +1456,7 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_HYPERV_CPUID */
 #define KVM_GET_SUPPORTED_HV_CPUID _IOWR(KVMIO, 0xc1, struct kvm_cpuid2)
 
+/* Available with KVM_CAP_XEN_HVM_GUEST */
 #define KVM_XEN_HVM_GET_ATTR        _IOWR(KVMIO,  0xc2, struct kvm_xen_hvm_attr)
 #define KVM_XEN_HVM_SET_ATTR        _IOW(KVMIO,  0xc3, struct kvm_xen_hvm_attr)
 
@@ -1472,6 +1474,7 @@ struct kvm_xen_hvm_attr {
 	} u;
 };
 
+/* Available with KVM_CAP_XEN_HVM_GUEST */
 #define KVM_XEN_ATTR_TYPE_SHARED_INFO       0x0
 #define KVM_XEN_ATTR_TYPE_VCPU_INFO         0x1
 #define KVM_XEN_ATTR_TYPE_VCPU_TIME_INFO    0x2
-- 
2.11.0

