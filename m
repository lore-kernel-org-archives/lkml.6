Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273B3C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73E421718
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73E421718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeHHRFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:05:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728029AbeHHRFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:05:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78EikNo099787
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 10:45:03 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kqyb81286-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:45:02 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 10:45:01 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 10:44:58 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78EiuRi66584780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 14:44:56 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E8A728059;
        Wed,  8 Aug 2018 10:43:44 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61EA92805C;
        Wed,  8 Aug 2018 10:43:43 -0400 (EDT)
Received: from localhost.localdomain (unknown [9.85.187.56])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Aug 2018 10:43:43 -0400 (EDT)
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
Subject: [PATCH v8 14/22] KVM: s390: interfaces to clear CRYCB masks
Date:   Wed,  8 Aug 2018 10:44:24 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080814-0060-0000-0000-0000029A75C7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009507; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070983; UDB=6.00551366; IPR=6.00850514;
 MB=3.00022589; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-08 14:45:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080814-0061-0000-0000-000046196FF5
Message-Id: <1533739472-7172-15-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=936 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Krowiak <akrowiak@linux.ibm.com>

Introduces two new KVM interface to clear the APM, AQM and ADM masks in
the guest's CRYCB.  The VCPUs are taken out of SIE to ensure the VCPUs do
not get out of sync.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |    3 +++
 arch/s390/kvm/kvm-s390.c         |   15 +++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 0c13f61..d7e19e1 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -258,6 +258,7 @@ struct kvm_s390_sie_block {
 	__u64	tecmc;			/* 0x00e8 */
 	__u8	reservedf0[12];		/* 0x00f0 */
 #define CRYCB_FORMAT_MASK 0x00000003
+#define CRYCB_FORMAT0 0x00000000
 #define CRYCB_FORMAT1 0x00000001
 #define CRYCB_FORMAT2 0x00000003
 	__u32	crycbd;			/* 0x00fc */
@@ -862,6 +863,8 @@ void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
 void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
 				 struct kvm_async_pf *work);
 
+void kvm_arch_crypto_clear_masks(struct kvm *kvm);
+
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
 extern char sie_exit;
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f96a443..0d03249 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1919,6 +1919,21 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
 }
 
+void kvm_arch_crypto_clear_masks(struct kvm *kvm)
+{
+	mutex_lock(&kvm->lock);
+	kvm_s390_vcpu_block_all(kvm);
+
+	memset(&kvm->arch.crypto.crycb->apcb0, 0,
+	       sizeof(kvm->arch.crypto.crycb->apcb0));
+	memset(&kvm->arch.crypto.crycb->apcb1, 0,
+	       sizeof(kvm->arch.crypto.crycb->apcb1));
+
+	kvm_s390_vcpu_unblock_all(kvm);
+	mutex_unlock(&kvm->lock);
+}
+EXPORT_SYMBOL(kvm_arch_crypto_clear_masks);
+
 static u64 kvm_s390_get_initial_cpuid(void)
 {
 	struct cpuid cpuid;
-- 
1.7.1

