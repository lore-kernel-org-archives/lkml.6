Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeDSVOE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 17:14:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753319AbeDSVOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 17:14:02 -0400
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, akrowiak@linux.vnet.ibm.com,
        pbonzini@redhat.com, rkrcmar@redhat.com
Subject: [PATCH] KVM: s390: reset crypto attributes for all vcpus
Date: Thu, 19 Apr 2018 17:13:52 -0400
X-Mailer: git-send-email 1.7.1
X-TM-AS-GCONF: 00
x-cbid: 18041921-8235-0000-0000-00000D56EA55
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008885; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01020342; UDB=6.00520615; IPR=6.00799579;
 MB=3.00020672; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-19 21:13:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041921-8236-0000-0000-0000408EEA6A
Message-Id: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804190186
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces a new function to reset the crypto attributes for all
vcpus whether they are running or not. Each vcpu in KVM will
be removed from SIE prior to resetting the crypto attributes in its
SIE state description. After all vcpus have had their crypto attributes
reset the vcpus will be restored to SIE.

This function is incorporated into the kvm_s390_vm_set_crypto(kvm)
function to fix a reported issue whereby the crypto key wrapping
attributes could potentially get out of synch for running vcpus.

Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/kvm/kvm-s390.c |   18 ++++++++++++++----
 arch/s390/kvm/kvm-s390.h |   13 +++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index fa355a6..4fa3037 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -789,6 +789,19 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 	return ret;
 }
 
+void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
+ {
+	int i;
+	struct kvm_vcpu *vcpu;
+
+	kvm_s390_vcpu_block_all(kvm);
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+	        kvm_s390_vcpu_crypto_setup(vcpu);
+
+	kvm_s390_vcpu_unblock_all(kvm);
+}
+
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
 
 static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
@@ -832,10 +845,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
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
index 1b5621f..981e3ba 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -410,4 +410,17 @@ static inline int kvm_s390_use_sca_entries(void)
 }
 void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 				     struct mcck_volatile_info *mcck_info);
+
+/**
+ * kvm_s390_vcpu_crypto_reset_all
+ *
+ * Reset the crypto attributes for each vcpu. This can be done while the vcpus
+ * are running as each vcpu will be removed from SIE before resetting the crypt
+ * attributes and restored to SIE afterward.
+ *
+ * Note: The kvm->lock must be held while calling this function
+ *
+ * @kvm: the KVM guest
+ */
+void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm);
 #endif
-- 
1.7.1
