Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED10C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763042146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5MChGTBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfBTUTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:19:17 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34592 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfBTUTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:19:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8lad087668;
        Wed, 20 Feb 2019 20:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=FLMolSeoCWdbxtw77CaFuuJsBsJh/M3jVztlkbWRZPc=;
 b=5MChGTBTyedjta2OKtVVtqGVHWi2hrR0XbsE6nCrI+qGtbyLVQNeLpU+asie5DxyKi1K
 U+spM7BcYJe/YtXAadQbuczyROFG0IGr5n8J96FPM2jF0VlfBwE3gMtKl7/y2eiFiCFU
 sMZWTPeQj4pGIRDC2D0wDyC8KQBWeCMHyZDg16bnrrUlmketGwEgI3fWu8erYAzekv+N
 MIbdxz9/GCI5GOsR8nPVQBU6XRdMbpUT4PXcz5OjKxH3Tyef2QmXmsHxjS8Kv2AfzHbq
 hI4sENM+0q2KzrkbQji6Aav7f3fNnM5mBHFOlPlPf9JBTHNQXGc4m970Rr9saEFPZqmt iA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qp81ec3gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIvTU031200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:57 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKIvZh019192;
        Wed, 20 Feb 2019 20:18:57 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:56 -0800
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
Subject: [PATCH RFC 39/39] KVM: x86: declare Xen HVM Dom0 capability
Date:   Wed, 20 Feb 2019 20:16:09 +0000
Message-Id: <20190220201609.28290-40-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=699 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new capability for domid, interdomain/unbound event channel types
and grant table support in hypervisor. This would be used to drive Xen
kernel backends.

Co-developed-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 Documentation/virtual/kvm/api.txt | 10 ++++++++++
 arch/x86/kvm/x86.c                |  4 ++++
 include/uapi/linux/kvm.h          |  3 +++
 3 files changed, 17 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 36d9386415fa..311dcded5e28 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -5046,3 +5046,13 @@ This capability indicates KVM's support for the event channel offload.
 Implies support for KVM_IRQ_ROUTING_XEN_EVTCHN irq routing, and
 for attribute KVM_XEN_ATTR_TYPE_EVTCHN in KVM_XEN_HVM_GET_ATTR or
 KVM_XEN_HVM_SET_ATTR.
+
+8.24 KVM_CAP_XEN_HVM_DOM0
+
+Architectures: x86
+
+This capability indicates support for assigning domid and handling kernel
+backends in the hypervisor. Also implies that attributes
+KVM_XEN_ATTR_TYPE_DOMID, KVM_XEN_ATTR_TYPE_GNTTAB are supported.  For the
+existing KVM_XEN_ATTR_TYPE_EVTCHN attribute, it indicates support for
+interdomain and unbound event channels.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cb95f7f8bed9..e8c3494b10cb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -71,6 +71,7 @@
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
 #include <asm/intel_pt.h>
+#include <xen/xen.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -3049,6 +3050,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ADJUST_CLOCK:
 		r = KVM_CLOCK_TSC_STABLE;
 		break;
+	case KVM_CAP_XEN_HVM_DOM0:
+		r = xen_shim_domain();
+		break;
 	case KVM_CAP_X86_DISABLE_EXITS:
 		r |=  KVM_X86_DISABLE_EXITS_HLT | KVM_X86_DISABLE_EXITS_PAUSE;
 		if(kvm_can_mwait_in_guest())
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 74d877792dfa..d817a7bbf507 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1005,6 +1005,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_CPUID 167
 #define KVM_CAP_XEN_HVM_GUEST 168
 #define KVM_CAP_XEN_HVM_EVTCHN 169
+#define KVM_CAP_XEN_HVM_DOM0 170
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1485,6 +1486,7 @@ struct kvm_xen_hvm_attr {
 
 #define XEN_EVTCHN_TYPE_VIRQ      0
 #define XEN_EVTCHN_TYPE_IPI       1
+/* Available with KVM_CAP_XEN_HVM_DOM0 */
 #define XEN_EVTCHN_TYPE_INTERDOM  2
 #define XEN_EVTCHN_TYPE_UNBOUND   3
 			__u32 type;
@@ -1536,6 +1538,7 @@ struct kvm_xen_hvm_attr {
 #define KVM_XEN_ATTR_TYPE_VCPU_RUNSTATE     0x3
 /* Available with KVM_CAP_XEN_HVM_EVTCHN */
 #define KVM_XEN_ATTR_TYPE_EVTCHN            0x4
+/* Available with KVM_CAP_XEN_HVM_DOM0 */
 #define KVM_XEN_ATTR_TYPE_DOMID             0x5
 #define KVM_XEN_ATTR_TYPE_GNTTAB            0x6
 
-- 
2.11.0

