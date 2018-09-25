Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BACC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC55214DC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC55214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeIZF2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:28:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727443AbeIZF2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:28:18 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PNEUEt049903
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:18:23 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mqvvqkkd4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:18:23 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Tue, 25 Sep 2018 17:18:22 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 17:18:19 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PNIGj726476566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 16:18:16 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4020A13605D;
        Tue, 25 Sep 2018 17:18:16 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCC8B136059;
        Tue, 25 Sep 2018 17:18:11 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.192.224])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Sep 2018 17:18:11 -0600 (MDT)
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
        Pierre Morel <pmorel@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v11 20/26] KVM: s390: vsie: allow CRYCB FORMAT-0
Date:   Tue, 25 Sep 2018 19:16:35 -0400
X-Mailer: git-send-email 2.19.0.221.g150f307
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092523-0036-0000-0000-00000A3EBF1F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009771; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093642; UDB=6.00565266; IPR=6.00873680;
 MB=3.00023503; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-25 23:18:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092523-0037-0000-0000-000049117F52
Message-Id: <20180925231641.4954-21-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=897 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809250227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Morel <pmorel@linux.ibm.com>

When the host and the guest both use a FORMAT-0 CRYCB,
we copy the guest's FORMAT-0 APCB to a shadow CRYCB
for use by vSIE.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 0a26814c6efe..67a5536637bb 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -136,7 +136,15 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
-/* Copy to APCB FORMAT0 from APCB FORMAT0 */
+/**
+ * setup_apcb00 - Copy to APCB FORMAT0 from APCB FORMAT0
+ * @vcpu: pointer to the virtual CPU
+ * @apcb_s: pointer to start of apcb in the shadow crycb
+ * @apcb_o: pointer to start of original apcb in the guest2
+ * @apcb_h: pointer to start of apcb in the guest1
+ *
+ * Returns 0 and -EFAULT on error reading guest apcb
+ */
 static int setup_apcb00(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
 			unsigned long apcb_o, unsigned long *apcb_h)
 {
@@ -209,6 +217,14 @@ static int setup_apcb(struct kvm_vcpu *vcpu, struct kvm_s390_crypto_cb *crycb_s,
 		return setup_apcb00(vcpu, (unsigned long *) &crycb_s->apcb0,
 				    (unsigned long) &crycb->apcb0,
 				    (unsigned long *) &crycb_h->apcb0);
+	case CRYCB_FORMAT0:
+		if ((crycb_o & PAGE_MASK) != ((crycb_o + 32) & PAGE_MASK))
+			return -EACCES;
+		if (fmt_h != CRYCB_FORMAT0)
+			return -EINVAL;
+		return setup_apcb00(vcpu, (unsigned long *) &crycb_s->apcb0,
+				    (unsigned long) &crycb->apcb0,
+				    (unsigned long *) &crycb_h->apcb0);
 	}
 	return -EINVAL;
 }
@@ -248,8 +264,6 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	int ret = 0;
 
 	scb_s->crycbd = 0;
-	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
-		return 0;
 
 	apie_h = vcpu->arch.sie_block->eca & ECA_APIE;
 	if (!apie_h && !key_msk)
-- 
2.19.0.221.g150f307

