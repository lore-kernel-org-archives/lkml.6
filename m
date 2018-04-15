Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbeDOVWt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:22:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753040AbeDOVWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:22:40 -0400
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
Subject: [PATCH v4 02/15] KVM: s390: reset crypto attributes for all vcpus
Date: Sun, 15 Apr 2018 17:22:12 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041521-0008-0000-0000-000002F74F1E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008862; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018429; UDB=6.00519481; IPR=6.00797666;
 MB=3.00020592; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-15 21:22:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041521-0009-0000-0000-000038E9719A
Message-Id: <1523827345-11600-3-git-send-email-akrowiak@linux.vnet.ibm.com>
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

Introduces a new function to reset the crypto attributes for all
vcpus whether they are running or not. Each vcpu in KVM will
be removed from SIE prior to resetting the crypto attributes in its
SIE state description. After all vcpus have had their crypto attributes
reset the vcpus will be restored to SIE.

This function will be used in a later patch to set the ECA.28
bit in the SIE state description to enable interpretive execution of
AP instructions. It will also be incorporated into the
kvm_s390_vm_set_crypto(kvm) function to fix an issue whereby the crypto
key wrapping attributes could potentially get out of synch for running
vcpus.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/kvm/kvm-s390.c |   19 +++++++++++++------
 arch/s390/kvm/kvm-s390.h |   14 ++++++++++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 64c9862..d0c3518 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -791,11 +791,21 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
 
-static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
+void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
 {
-	struct kvm_vcpu *vcpu;
 	int i;
+	struct kvm_vcpu *vcpu;
+
+	kvm_s390_vcpu_block_all(kvm);
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_s390_vcpu_crypto_setup(vcpu);
 
+	kvm_s390_vcpu_unblock_all(kvm);
+}
+
+static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
+{
 	if (!test_kvm_facility(kvm, 76))
 		return -EINVAL;
 
@@ -832,10 +842,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 		return -ENXIO;
 	}
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		kvm_s390_vcpu_crypto_setup(vcpu);
-		exit_sie(vcpu);
-	}
+	kvm_s390_vcpu_crypto_reset_all(kvm);
 	mutex_unlock(&kvm->lock);
 	return 0;
 }
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 1b5621f..76324b7 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -410,4 +410,18 @@ static inline int kvm_s390_use_sca_entries(void)
 }
 void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 				     struct mcck_volatile_info *mcck_info);
+
+/**
+ * kvm_s390_vcpu_crypto_reset_all
+ *
+ * Reset the crypto attributes for each vcpu. This can be done while the vcpus
+ * are running as each vcpu will be removed from SIE before resetting the crypto
+ * attributes and restored to SIE afterward.
+ *
+ * Note: The kvm->lock mutex must be locked prior to calling this function and
+ *	 unlocked after it returns.
+ *
+ * @kvm: the KVM guest
+ */
+void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm);
 #endif
-- 
1.7.1
