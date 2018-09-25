Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FC5C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6260F20896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6260F20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeIZF2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:28:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727567AbeIZF2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:28:36 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PNEVit066582
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:18:41 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mqtj4h8a6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:18:41 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Tue, 25 Sep 2018 17:18:39 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 17:18:36 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PNIXLD63635656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 16:18:33 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DDBB136051;
        Tue, 25 Sep 2018 17:18:33 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88DEB13605D;
        Tue, 25 Sep 2018 17:18:30 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.192.224])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Sep 2018 17:18:30 -0600 (MDT)
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
Subject: [PATCH v11 24/26] KVM: s390: device attrs to enable/disable AP interpretation
Date:   Tue, 25 Sep 2018 19:16:39 -0400
X-Mailer: git-send-email 2.19.0.221.g150f307
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092523-0012-0000-0000-000016BBBFB4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009771; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093643; UDB=6.00565266; IPR=6.00873680;
 MB=3.00023503; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-25 23:18:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092523-0013-0000-0000-000054889A06
Message-Id: <20180925231641.4954-25-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809250227
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
 arch/s390/include/uapi/asm/kvm.h |  2 ++
 arch/s390/kvm/kvm-s390.c         | 31 ++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 9a50f02b9894..16511d97e8dc 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -160,6 +160,8 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
 #define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
 #define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
+#define KVM_S390_VM_CRYPTO_ENABLE_APIE		4
+#define KVM_S390_VM_CRYPTO_DISABLE_APIE		5
 
 /* kvm attributes for migration mode */
 #define KVM_S390_VM_MIGRATION_STOP	0
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c94ef2d0dbe4..81fd82f7626d 100644
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
@@ -876,17 +877,35 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
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
+		if (!ap_instructions_available()) {
+			mutex_unlock(&kvm->lock);
+			return -EOPNOTSUPP;
+		}
+		kvm->arch.crypto.apie = 0;
+		break;
 	default:
 		mutex_unlock(&kvm->lock);
 		return -ENXIO;
@@ -1495,6 +1514,10 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 		case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
 			ret = 0;
 			break;
+		case KVM_S390_VM_CRYPTO_ENABLE_APIE:
+		case KVM_S390_VM_CRYPTO_DISABLE_APIE:
+			ret = ap_instructions_available() ? 0 : -ENXIO;
+			break;
 		default:
 			ret = -ENXIO;
 			break;
@@ -2062,6 +2085,7 @@ static u64 kvm_s390_get_initial_cpuid(void)
 static void kvm_s390_crypto_init(struct kvm *kvm)
 {
 	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
+	kvm->arch.crypto.apie = 0;
 	kvm_s390_set_crycb_format(kvm);
 
 	if (!test_kvm_facility(kvm, 76))
@@ -2601,6 +2625,7 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
+	vcpu->arch.sie_block->eca &= ~ECA_APIE;
 
 	if (vcpu->kvm->arch.crypto.apie)
 		vcpu->arch.sie_block->eca |= ECA_APIE;
-- 
2.19.0.221.g150f307

