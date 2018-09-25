Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14E5C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6035B2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6035B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeIZF2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:28:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727334AbeIZF2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:28:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PNEX2F022547
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:18:14 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mqtmp9f3v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:18:14 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Tue, 25 Sep 2018 17:18:13 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 17:18:09 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PNI6n356099018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 16:18:06 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25EB5136055;
        Tue, 25 Sep 2018 17:18:06 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 023AC136051;
        Tue, 25 Sep 2018 17:18:03 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.192.224])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Sep 2018 17:18:02 -0600 (MDT)
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
Subject: [PATCH v11 18/26] KVM: s390: vsie: Allow CRYCB FORMAT-2
Date:   Tue, 25 Sep 2018 19:16:33 -0400
X-Mailer: git-send-email 2.19.0.221.g150f307
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092523-8235-0000-0000-00000E06BFD2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009771; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093643; UDB=6.00565266; IPR=6.00873680;
 MB=3.00023503; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-25 23:18:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092523-8236-0000-0000-000042C5971F
Message-Id: <20180925231641.4954-19-akrowiak@linux.vnet.ibm.com>
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

From: Pierre Morel <pmorel@linux.ibm.com>

When the guest and the host both use CRYCB FORMAT-2,
we copy the guest's FORMAT-1 APCB to a FORMAT-1
shadow APCB.

This patch also cleans up the shadow_crycb() function.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 114 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 104 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index e0e6fbfa88f4..3a932781e0b0 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -136,14 +136,81 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
-/*
+/**
+ * setup_apcb11 - Copy the FORMAT1 APCB from the guest to the shadow CRYCB
+ * @vcpu: pointer to the virtual CPU
+ * @apcb_s: pointer to start of apcb in the shadow crycb
+ * @apcb_o: pointer to start of original guest apcb
+ * @apcb_h: pointer to start of apcb in the host
+ *
+ * Returns 0 and -EFAULT on error reading guest apcb
+ */
+static int setup_apcb11(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
+			unsigned long apcb_o,
+			unsigned long *apcb_h)
+{
+	if (read_guest_real(vcpu, apcb_o, apcb_s,
+			    sizeof(struct kvm_s390_apcb1)))
+		return -EFAULT;
+
+	bitmap_and(apcb_s, apcb_s, apcb_h, sizeof(struct kvm_s390_apcb1));
+
+	return 0;
+}
+
+/**
+ * setup_apcb - Create a shadow copy of the apcb.
+ * @vcpu: pointer to the virtual CPU
+ * @crycb_s: pointer to shadow crycb
+ * @crycb_o: pointer to original guest crycb
+ * @crycb_h: pointer to the host crycb
+ * @fmt_o: format of the original guest crycb.
+ * @fmt_h: format of the host crycb.
+ *
+ * Checks the compatibility between the guest and host crycb and calls the
+ * appropriate copy function.
+ *
+ * Return 0 or an error number if the guest and host crycb are incompatible.
+ */
+static int setup_apcb(struct kvm_vcpu *vcpu, struct kvm_s390_crypto_cb *crycb_s,
+	       const u32 crycb_o,
+	       struct kvm_s390_crypto_cb *crycb_h,
+	       int fmt_o, int fmt_h)
+{
+	struct kvm_s390_crypto_cb *crycb;
+
+	crycb = (struct kvm_s390_crypto_cb *) (unsigned long)crycb_o;
+
+	switch (fmt_o) {
+	case CRYCB_FORMAT2:
+		if ((crycb_o & PAGE_MASK) != ((crycb_o + 256) & PAGE_MASK))
+			return -EACCES;
+		if (fmt_h != CRYCB_FORMAT2)
+			return -EINVAL;
+		return setup_apcb11(vcpu, (unsigned long *)&crycb_s->apcb1,
+				    (unsigned long) &crycb->apcb1,
+				    (unsigned long *)&crycb_h->apcb1);
+	}
+	return -EINVAL;
+}
+
+/**
+ * shadow_crycb - Create a shadow copy of the crycb block
+ * @vcpu: a pointer to the virtual CPU
+ * @vsie_page: a pointer to internal date used for the vSIE
+ *
  * Create a shadow copy of the crycb block and setup key wrapping, if
  * requested for guest 3 and enabled for guest 2.
  *
- * We accept format-1 or format-2, but we treat it as a format-1 (no AP in g2),
- * and we convert it into format-2 in the shadow CRYCB.
+ * We accept format-1 or format-2, but we convert format-1 into format-2
+ * in the shadow CRYCB.
+ * Using format-2 enables the firmware to choose the right format when
+ * scheduling the SIE.
  * There is nothing to do for format-0.
  *
+ * This function centralize the issuing of set_validity_icpt() for all
+ * the subfunctions working on the crycb.
+ *
  * Returns: - 0 if shadowed or nothing to do
  *          - > 0 if control has to be given to guest 2
  */
@@ -155,24 +222,42 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
 	unsigned long *b1, *b2;
 	u8 ecb3_flags;
+	int apie_h;
+	int key_msk = test_kvm_facility(vcpu->kvm, 76);
+	int fmt_o = crycbd_o & CRYCB_FORMAT_MASK;
+	int fmt_h = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
+	int ret = 0;
 
 	scb_s->crycbd = 0;
 	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
 		return 0;
-	/* format-1 is supported with message-security-assist extension 3 */
-	if (!test_kvm_facility(vcpu->kvm, 76))
+
+	apie_h = vcpu->arch.sie_block->eca & ECA_APIE;
+	if (!apie_h && !key_msk)
 		return 0;
 
-	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
-		return set_validity_icpt(scb_s, 0x003CU);
-	else if (!crycb_addr)
+	if (!crycb_addr)
 		return set_validity_icpt(scb_s, 0x0039U);
 
+	if (fmt_o == CRYCB_FORMAT1)
+		if ((crycb_addr & PAGE_MASK) !=
+		    ((crycb_addr + 128) & PAGE_MASK))
+			return set_validity_icpt(scb_s, 0x003CU);
+
+	if (apie_h && (scb_o->eca & ECA_APIE)) {
+		ret = setup_apcb(vcpu, &vsie_page->crycb, crycb_addr,
+				 vcpu->kvm->arch.crypto.crycb,
+				 fmt_o, fmt_h);
+		if (ret)
+			goto end;
+		scb_s->eca |= scb_o->eca & ECA_APIE;
+	}
+
 	/* we may only allow it if enabled for guest 2 */
 	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
 		     (ECB3_AES | ECB3_DEA);
 	if (!ecb3_flags)
-		return 0;
+		goto end;
 
 	/* copy only the wrapping keys */
 	if (read_guest_real(vcpu, crycb_addr + 72,
@@ -180,7 +265,6 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		return set_validity_icpt(scb_s, 0x0035U);
 
 	scb_s->ecb3 |= ecb3_flags;
-	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT2;
 
 	/* xor both blocks in one run */
 	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
@@ -188,6 +272,16 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			    vcpu->kvm->arch.crypto.crycb->dea_wrapping_key_mask;
 	/* as 56%8 == 0, bitmap_xor won't overwrite any data */
 	bitmap_xor(b1, b1, b2, BITS_PER_BYTE * 56);
+end:
+	switch (ret) {
+	case -EINVAL:
+		return set_validity_icpt(scb_s, 0x0020U);
+	case -EFAULT:
+		return set_validity_icpt(scb_s, 0x0035U);
+	case -EACCES:
+		return set_validity_icpt(scb_s, 0x003CU);
+	}
+	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT2;
 	return 0;
 }
 
-- 
2.19.0.221.g150f307

