Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBA7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A972086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A972086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeIZF1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:27:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726593AbeIZF1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:27:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PNEVIC108619
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:17:09 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mqwqd9jy7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:17:09 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Tue, 25 Sep 2018 17:17:09 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 17:17:04 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PNH1DM42008654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 16:17:01 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A89B136055;
        Tue, 25 Sep 2018 17:17:01 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65BC1136051;
        Tue, 25 Sep 2018 17:16:58 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.192.224])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Sep 2018 17:16:58 -0600 (MDT)
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
Subject: [PATCH v11 03/26] KVM: s390: refactor crypto initialization
Date:   Tue, 25 Sep 2018 19:16:18 -0400
X-Mailer: git-send-email 2.19.0.221.g150f307
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092523-8235-0000-0000-00000E06BFB8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009771; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093642; UDB=6.00565266; IPR=6.00873679;
 MB=3.00023503; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-25 23:17:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092523-8236-0000-0000-000042C5968E
Message-Id: <20180925231641.4954-4-akrowiak@linux.vnet.ibm.com>
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

This patch refactors the code that initializes and sets up the
crypto configuration for a guest. The following changes are
implemented via this patch:

1. Introduces a flag indicating AP instructions executed on
   the guest shall be interpreted by the firmware. This flag
   is used to set a bit in the guest's state description
   indicating AP instructions are to be interpreted.

2. Replace code implementing AP interfaces with code supplied
   by the AP bus to query the AP configuration.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  3 ++
 arch/s390/kvm/kvm-s390.c         | 70 +++++++++++++++-----------------
 2 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 75d39628f21d..79fa0a3a777f 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -187,6 +187,7 @@ struct kvm_s390_sie_block {
 #define ECA_AIV		0x00200000
 #define ECA_VX		0x00020000
 #define ECA_PROTEXCI	0x00002000
+#define ECA_APIE	0x00000008
 #define ECA_SII		0x00000001
 	__u32	eca;			/* 0x004c */
 #define ICPT_INST	0x04
@@ -256,6 +257,7 @@ struct kvm_s390_sie_block {
 	__u8	reservede4[4];		/* 0x00e4 */
 	__u64	tecmc;			/* 0x00e8 */
 	__u8	reservedf0[12];		/* 0x00f0 */
+#define CRYCB_FORMAT_MASK 0x00000003
 #define CRYCB_FORMAT1 0x00000001
 #define CRYCB_FORMAT2 0x00000003
 	__u32	crycbd;			/* 0x00fc */
@@ -716,6 +718,7 @@ struct kvm_s390_crypto {
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
+	__u8 apie;
 };
 
 #define APCB0_MASK_SIZE 1
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 876fbb2b0c04..d62f6d840f8c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -40,6 +40,7 @@
 #include <asm/sclp.h>
 #include <asm/cpacf.h>
 #include <asm/timex.h>
+#include <asm/ap.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 
@@ -1995,49 +1996,37 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	return r;
 }
 
-static int kvm_s390_query_ap_config(u8 *config)
-{
-	u32 fcn_code = 0x04000000UL;
-	u32 cc = 0;
-
-	memset(config, 0, 128);
-	asm volatile(
-		"lgr 0,%1\n"
-		"lgr 2,%2\n"
-		".long 0xb2af0000\n"		/* PQAP(QCI) */
-		"0: ipm %0\n"
-		"srl %0,28\n"
-		"1:\n"
-		EX_TABLE(0b, 1b)
-		: "+r" (cc)
-		: "r" (fcn_code), "r" (config)
-		: "cc", "0", "2", "memory"
-	);
-
-	return cc;
-}
-
 static int kvm_s390_apxa_installed(void)
 {
-	u8 config[128];
-	int cc;
+	struct ap_config_info info;
 
-	if (test_facility(12)) {
-		cc = kvm_s390_query_ap_config(config);
-
-		if (cc)
-			pr_err("PQAP(QCI) failed with cc=%d", cc);
-		else
-			return config[0] & 0x40;
+	if (ap_instructions_available()) {
+		if (ap_qci(&info) == 0)
+			return info.apxa;
 	}
 
 	return 0;
 }
 
+/*
+ * The format of the crypto control block (CRYCB) is specified in the 3 low
+ * order bits of the CRYCB designation (CRYCBD) field as follows:
+ * Format 0: Neither the message security assist extension 3 (MSAX3) nor the
+ *	     AP extended addressing (APXA) facility are installed.
+ * Format 1: The APXA facility is not installed but the MSAX3 facility is.
+ * Format 2: Both the APXA and MSAX3 facilities are installed
+ */
 static void kvm_s390_set_crycb_format(struct kvm *kvm)
 {
 	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
 
+	/* Clear the CRYCB format bits - i.e., set format 0 by default */
+	kvm->arch.crypto.crycbd &= ~(CRYCB_FORMAT_MASK);
+
+	/* Check whether MSAX3 is installed */
+	if (!test_kvm_facility(kvm, 76))
+		return;
+
 	if (kvm_s390_apxa_installed())
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT2;
 	else
@@ -2055,12 +2044,12 @@ static u64 kvm_s390_get_initial_cpuid(void)
 
 static void kvm_s390_crypto_init(struct kvm *kvm)
 {
-	if (!test_kvm_facility(kvm, 76))
-		return;
-
 	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
 	kvm_s390_set_crycb_format(kvm);
 
+	if (!test_kvm_facility(kvm, 76))
+		return;
+
 	/* Enable AES/DEA protected key functions by default */
 	kvm->arch.crypto.aes_kw = 1;
 	kvm->arch.crypto.dea_kw = 1;
@@ -2586,17 +2575,24 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 {
-	if (!test_kvm_facility(vcpu->kvm, 76))
+	/*
+	 * If the AP instructions are not being interpreted and the MSAX3
+	 * facility is not configured for the guest, there is nothing to set up.
+	 */
+	if (!vcpu->kvm->arch.crypto.apie && !test_kvm_facility(vcpu->kvm, 76))
 		return;
 
+	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
 
+	if (vcpu->kvm->arch.crypto.apie)
+		vcpu->arch.sie_block->eca |= ECA_APIE;
+
+	/* Set up protected key support */
 	if (vcpu->kvm->arch.crypto.aes_kw)
 		vcpu->arch.sie_block->ecb3 |= ECB3_AES;
 	if (vcpu->kvm->arch.crypto.dea_kw)
 		vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
-
-	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 }
 
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
-- 
2.19.0.221.g150f307

