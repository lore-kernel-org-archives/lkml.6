Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeDOVZx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:25:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753094AbeDOVWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:22:46 -0400
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        akrowiak@linux.vnet.ibm.com
Subject: [PATCH v4 05/15] KVM: s390: enable/disable AP interpretive execution
Date: Sun, 15 Apr 2018 17:22:15 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041521-0048-0000-0000-0000025C4D5F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008862; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018429; UDB=6.00519481; IPR=6.00797666;
 MB=3.00020592; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-15 21:22:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041521-0049-0000-0000-000044C9804C
Message-Id: <1523827345-11600-6-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804150214
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VFIO AP device model exploits interpretive execution of AP
instructions (APIE) to provide guests passthrough access to AP
devices. This patch introduces a new interface to enable and
disable APIE.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm-ap.h   |   16 ++++++++++++++++
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/kvm/kvm-ap.c           |   20 ++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c         |    9 +++++++++
 4 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
index 736e93e..a6c092e 100644
--- a/arch/s390/include/asm/kvm-ap.h
+++ b/arch/s390/include/asm/kvm-ap.h
@@ -35,4 +35,20 @@
  */
 void kvm_ap_build_crycbd(struct kvm *kvm);
 
+/**
+ * kvm_ap_interpret_instructions
+ *
+ * Indicate whether AP instructions shall be interpreted. If they are not
+ * interpreted, all AP instructions will be intercepted and routed back to
+ * userspace.
+ *
+ * @kvm: the virtual machine attributes
+ * @enable: indicates whether AP instructions are to be interpreted (true) or
+ *	    or not (false).
+ *
+ * Returns 0 if completed successfully; otherwise, returns -EOPNOTSUPP
+ * indicating that AP instructions are not installed on the guest.
+ */
+int kvm_ap_interpret_instructions(struct kvm *kvm, bool enable);
+
 #endif /* _ASM_KVM_AP */
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 3162783..5470685 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -715,6 +715,7 @@ struct kvm_s390_crypto {
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
+	__u8 apie;
 };
 
 #define APCB0_MASK_SIZE 1
diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
index 991bae4..55d11b5 100644
--- a/arch/s390/kvm/kvm-ap.c
+++ b/arch/s390/kvm/kvm-ap.c
@@ -58,3 +58,23 @@ void kvm_ap_build_crycbd(struct kvm *kvm)
 	}
 }
 EXPORT_SYMBOL(kvm_ap_build_crycbd);
+
+int kvm_ap_interpret_instructions(struct kvm *kvm, bool enable)
+{
+	int ret = 0;
+
+	mutex_lock(&kvm->lock);
+
+	if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP)) {
+		ret = -EOPNOTSUPP;
+		goto done;
+	}
+
+	kvm->arch.crypto.apie = enable;
+	kvm_s390_vcpu_crypto_reset_all(kvm);
+
+done:
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+EXPORT_SYMBOL(kvm_ap_interpret_instructions);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 55cd897..1dc8566 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1901,6 +1901,9 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
 	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
 	kvm_ap_build_crycbd(kvm);
 
+	/* Default setting indicating SIE shall interpret AP instructions */
+	kvm->arch.crypto.apie = 1;
+
 	if (!test_kvm_facility(kvm, 76))
 		return;
 
@@ -2434,6 +2437,12 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 
+	vcpu->arch.sie_block->eca &= ~ECA_APIE;
+	if (vcpu->kvm->arch.crypto.apie &&
+	    test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
+		vcpu->arch.sie_block->eca |= ECA_APIE;
+
+
 	if (!test_kvm_facility(vcpu->kvm, 76))
 		return;
 
-- 
1.7.1
