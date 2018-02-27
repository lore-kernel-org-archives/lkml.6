Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbeB0OdZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:33:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753497AbeB0ObY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:31:24 -0500
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v2 08/15] KVM: s390: interface to enable AP execution mode
Date: Tue, 27 Feb 2018 09:28:06 -0500
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022714-0008-0000-0000-000009621B82
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995862; UDB=6.00506230; IPR=6.00775186;
 MB=3.00019761; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-27 14:28:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022714-0009-0000-0000-000046310791
Message-Id: <1519741693-17440-9-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270183
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces a new interface to enable AP interpretive
execution (IE) mode for the KVM guest. When running
with IE mode enabled, AP instructions executed on the
KVM guest will be interpreted by the firmware and
passed directly through to an AP device installed on
the system. The CPU model feature for AP must
be enabled for the KVM guest in order to enable
interpretive execution mode.

This interface will be used in a subsequent patch
by the VFIO AP device driver.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm-ap.h   |    2 ++
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/kvm/kvm-ap.c           |   27 +++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h         |    1 +
 4 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
index 46e7c5b..6bd6bfb 100644
--- a/arch/s390/include/asm/kvm-ap.h
+++ b/arch/s390/include/asm/kvm-ap.h
@@ -51,4 +51,6 @@ struct kvm_ap_matrix {
 
 void kvm_ap_deconfigure_matrix(struct kvm *kvm);
 
+int kvm_ap_enable_ie_mode(struct kvm *kvm);
+
 #endif /* _ASM_KVM_AP */
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index a4c77d3..1eebdd6 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -186,6 +186,7 @@ struct kvm_s390_sie_block {
 #define ECA_AIV		0x00200000
 #define ECA_VX		0x00020000
 #define ECA_PROTEXCI	0x00002000
+#define ECA_APIE	0x00000008
 #define ECA_SII		0x00000001
 	__u32	eca;			/* 0x004c */
 #define ICPT_INST	0x04
diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
index bb29045..862e54b 100644
--- a/arch/s390/kvm/kvm-ap.c
+++ b/arch/s390/kvm/kvm-ap.c
@@ -307,3 +307,30 @@ void kvm_ap_deconfigure_matrix(struct kvm *kvm)
 	kvm_ap_clear_crycb_masks(kvm);
 }
 EXPORT_SYMBOL(kvm_ap_deconfigure_matrix);
+
+/**
+ * kvm_ap_enable_ie_mode
+ *
+ * Enable interpretrive execution of AP instructions for the guest. When
+ * enabled, AP instructions executed on the guest will be interpreted and
+ * passed through to an AP installed on the host system.
+ *
+ * Returns 0 if interpretrive execution is enabled. Returns -EOPNOTSUPP
+ * if AP facilities are not installed for the guest.
+ *
+ * @kvm: the guest's kvm structure
+ */
+int kvm_ap_enable_ie_mode(struct kvm *kvm)
+{
+	int i;
+	struct kvm_vcpu *vcpu;
+
+	if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP))
+		return -EOPNOTSUPP;
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		vcpu->arch.sie_block->eca |= ECA_APIE;
+
+	return 0;
+}
+EXPORT_SYMBOL(kvm_ap_enable_ie_mode);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 1b5621f..3142541 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -18,6 +18,7 @@
 #include <asm/facility.h>
 #include <asm/processor.h>
 #include <asm/sclp.h>
+#include <asm/ap.h>
 
 /* Transactional Memory Execution related macros */
 #define IS_TE_ENABLED(vcpu)	((vcpu->arch.sie_block->ecb & ECB_TE))
-- 
1.7.1
