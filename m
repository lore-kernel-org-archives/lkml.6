Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeCNS02 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:26:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752491AbeCNS0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:26:24 -0400
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
Subject: [PATCH v3 04/14] KVM: s390: device attribute to set AP interpretive execution
Date: Wed, 14 Mar 2018 14:25:44 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031418-0012-0000-0000-000015E550F6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003025; UDB=6.00510424; IPR=6.00782355;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 18:26:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031418-0013-0000-0000-000051DE9DB7
Message-Id: <1521051954-25715-5-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140201
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VFIO AP device model exploits interpretive execution of AP
instructions (APIE) to provide guests passthrough access to AP
devices. This patch introduces a new device attribute in the
KVM_S390_VM_CRYPTO device attribute group to set APIE from
the VFIO AP device defined on the guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/include/uapi/asm/kvm.h |    1 +
 arch/s390/kvm/kvm-s390.c         |   19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 98957c2..bbac5a1 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -699,6 +699,7 @@ struct kvm_s390_crypto {
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
+	__u8 apie;
 };
 
 #define APCB0_MASK_SIZE 1
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index a580dec..fdcbeb9 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -161,6 +161,7 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
 #define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
 #define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
+#define KVM_S390_VM_CRYPTO_INTERPRET_AP		4
 
 /* kvm attributes for migration mode */
 #define KVM_S390_VM_MIGRATION_STOP	0
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a60c45b..bc46b67 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -815,6 +815,19 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
 		VM_EVENT(kvm, 3, "%s", "DISABLE: DEA keywrapping support");
 		break;
+	case KVM_S390_VM_CRYPTO_INTERPRET_AP:
+		if (attr->addr) {
+			if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP))
+				return -EOPNOTSUPP;
+			kvm->arch.crypto.apie = 1;
+			VM_EVENT(kvm, 3, "%s",
+				 "ENABLE: AP interpretive execution");
+		} else {
+			kvm->arch.crypto.apie = 0;
+			VM_EVENT(kvm, 3, "%s",
+				 "DISABLE: AP interpretive execution");
+		}
+		break;
 	default:
 		mutex_unlock(&kvm->lock);
 		return -ENXIO;
@@ -1453,6 +1466,7 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 		case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
 		case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
 		case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
+		case KVM_S390_VM_CRYPTO_INTERPRET_AP:
 			ret = 0;
 			break;
 		default:
@@ -2409,6 +2423,11 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 
+	if (vcpu->kvm->arch.crypto.apie)
+		vcpu->arch.sie_block->eca |= ECA_APIE;
+	else
+		vcpu->arch.sie_block->eca &= ~ECA_APIE;
+
 	if (!test_kvm_facility(vcpu->kvm, 76))
 		return;
 
-- 
1.7.1
