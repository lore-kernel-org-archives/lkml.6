Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6F1C07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568542133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568542133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeIMAvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:51:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728024AbeIMAvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:51:14 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CJY4gf100786
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:45:10 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf84hatnp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:45:10 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Wed, 12 Sep 2018 13:45:09 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 13:45:04 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CJj1Te21954718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 12:45:01 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 958DD6A05D;
        Wed, 12 Sep 2018 13:45:01 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFD2E6A047;
        Wed, 12 Sep 2018 13:44:58 -0600 (MDT)
Received: from localhost.localdomain (unknown [9.80.213.181])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Sep 2018 13:44:58 -0600 (MDT)
From:   Tony Krowiak <akrowiak@linux.vnet.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v10 24/26] KVM: s390: device attrs to enable/disable AP interpretation
Date:   Wed, 12 Sep 2018 15:43:14 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091219-0004-0000-0000-00001488C6C9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009709; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01087371; UDB=6.00561489; IPR=6.00867384;
 MB=3.00023256; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-12 19:45:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091219-0005-0000-0000-000088C9F0B1
Message-Id: <1536781396-13601-25-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Krowiak <akrowiak@linux.ibm.com>

Introduces two new VM crypto device attributes (KVM_S390_VM_CRYPTO)
to enable or disable AP instruction interpretation from userspace
via the KVM_SET_DEVICE_ATTR ioctl:

* The KVM_S390_VM_CRYPTO_ENABLE_APIE attribute enables hardware
  interpretation of AP instructions executed on the guest.

* The KVM_S390_VM_CRYPTO_DISABLE_APIE attribute disables hardware
  interpretation of AP instructions executed on the guest. In this
  case the instructions will be intercepted and pass through to
  the guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/include/uapi/asm/kvm.h |    2 ++
 arch/s390/kvm/kvm-s390.c         |   27 +++++++++++++++++++++++----
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index b32bd1b..36d3531 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -719,6 +719,7 @@ struct kvm_s390_crypto {
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
+	__u8 apie;
 };
 
 #define APCB0_MASK_SIZE 1
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 8c23afc..a8dbd90 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -161,6 +161,8 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
 #define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
 #define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
+#define KVM_S390_VM_CRYPTO_ENABLE_APIE		4
+#define KVM_S390_VM_CRYPTO_DISABLE_APIE		5
 
 /* kvm attributes for migration mode */
 #define KVM_S390_VM_MIGRATION_STOP	0
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2cdd980..286c2e0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -856,12 +856,11 @@ void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
 
 static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 {
-	if (!test_kvm_facility(kvm, 76))
-		return -EINVAL;
-
 	mutex_lock(&kvm->lock);
 	switch (attr->attr) {
 	case KVM_S390_VM_CRYPTO_ENABLE_AES_KW:
+		if (!test_kvm_facility(kvm, 76))
+			return -EINVAL;
 		get_random_bytes(
 			kvm->arch.crypto.crycb->aes_wrapping_key_mask,
 			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
@@ -869,6 +868,8 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 		VM_EVENT(kvm, 3, "%s", "ENABLE: AES keywrapping support");
 		break;
 	case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
+		if (!test_kvm_facility(kvm, 76))
+			return -EINVAL;
 		get_random_bytes(
 			kvm->arch.crypto.crycb->dea_wrapping_key_mask,
 			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
@@ -876,17 +877,31 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 		VM_EVENT(kvm, 3, "%s", "ENABLE: DEA keywrapping support");
 		break;
 	case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
+		if (!test_kvm_facility(kvm, 76))
+			return -EINVAL;
 		kvm->arch.crypto.aes_kw = 0;
 		memset(kvm->arch.crypto.crycb->aes_wrapping_key_mask, 0,
 			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
 		VM_EVENT(kvm, 3, "%s", "DISABLE: AES keywrapping support");
 		break;
 	case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
+		if (!test_kvm_facility(kvm, 76))
+			return -EINVAL;
 		kvm->arch.crypto.dea_kw = 0;
 		memset(kvm->arch.crypto.crycb->dea_wrapping_key_mask, 0,
 			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
 		VM_EVENT(kvm, 3, "%s", "DISABLE: DEA keywrapping support");
 		break;
+	case KVM_S390_VM_CRYPTO_ENABLE_APIE:
+		if (!ap_instructions_available()) {
+			mutex_unlock(&kvm->lock);
+			return -EOPNOTSUPP;
+		}
+		kvm->arch.crypto.apie = 1;
+		break;
+	case KVM_S390_VM_CRYPTO_DISABLE_APIE:
+		kvm->arch.crypto.apie = 0;
+		break;
 	default:
 		mutex_unlock(&kvm->lock);
 		return -ENXIO;
@@ -1493,6 +1508,8 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 		case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
 		case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
 		case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
+		case KVM_S390_VM_CRYPTO_ENABLE_APIE:
+		case KVM_S390_VM_CRYPTO_DISABLE_APIE:
 			ret = 0;
 			break;
 		default:
@@ -2062,6 +2079,7 @@ static u64 kvm_s390_get_initial_cpuid(void)
 static void kvm_s390_crypto_init(struct kvm *kvm)
 {
 	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
+	kvm->arch.crypto.apie = 0;
 	kvm_s390_set_crycb_format(kvm);
 
 	if (!test_kvm_facility(kvm, 76))
@@ -2602,8 +2620,9 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
+	vcpu->arch.sie_block->eca &= ~ECA_APIE;
 
-	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
+	if (vcpu->kvm->arch.crypto.apie)
 		vcpu->arch.sie_block->eca |= ECA_APIE;
 
 	/* Set up protected key support */
-- 
1.7.1

