Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FEDC46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6E621718
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6E621718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeHHRFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:05:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728554AbeHHRFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:05:08 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78EiPPt009024
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 10:45:09 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kqyjsrg02-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:45:09 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 10:45:08 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 10:45:05 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78Ej3bg1900908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 14:45:03 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94B4A2806A;
        Wed,  8 Aug 2018 10:43:51 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83CC42805E;
        Wed,  8 Aug 2018 10:43:50 -0400 (EDT)
Received: from localhost.localdomain (unknown [9.85.187.56])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Aug 2018 10:43:50 -0400 (EDT)
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
        Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v8 20/22] KVM: s390: Handling of Cypto control block in VSIE
Date:   Wed,  8 Aug 2018 10:44:30 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080814-0052-0000-0000-0000031B7B1D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009507; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070983; UDB=6.00551366; IPR=6.00850513;
 MB=3.00022589; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-08 14:45:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080814-0053-0000-0000-00005DA86A63
Message-Id: <1533739472-7172-21-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Morel <pmorel@linux.ibm.com>

Shadowing the crypto control block now supports APCB shadowing.

AP instruction interpretation for guest 3 through ECA.28 is shadowed when
guest 2 ECA.28 is set.

CRYCB is shadowed for APCB and wrapping keys.

CRYCB format 0 is now supported for both guests 2 and 3.

Shadow CRYCB always uses the guest 2 CRYCB format and it
follows that:

* Guest 3 CRYCB format 0 is supported with guest 2 CRYCB format 0,1 or 2
* Guest 3 CRYCB format 1 is supported with guest 2 CRYCB format 1 or 2
* Guest 3 CRYCB format 2 is supported with guest 2 CRYCB format 2

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c |  224 ++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 200 insertions(+), 24 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index aa30b48..fc7986b 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -136,17 +136,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
-/*
- * Create a shadow copy of the crycb block and setup key wrapping, if
- * requested for guest 3 and enabled for guest 2.
- *
- * We only accept format-1 (no AP in g2), but convert it into format-2
- * There is nothing to do for format-0.
- *
- * Returns: - 0 if shadowed or nothing to do
- *          - > 0 if control has to be given to guest 2
- */
-static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+/* Copy keys into shadow crycb, is only called if MSA3 is available.  */
+static int copy_key_masks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
@@ -155,30 +146,17 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	unsigned long *b1, *b2;
 	u8 ecb3_flags;
 
-	scb_s->crycbd = 0;
-	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
-		return 0;
-	/* format-1 is supported with message-security-assist extension 3 */
-	if (!test_kvm_facility(vcpu->kvm, 76))
-		return 0;
 	/* we may only allow it if enabled for guest 2 */
 	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
 		     (ECB3_AES | ECB3_DEA);
 	if (!ecb3_flags)
 		return 0;
 
-	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
-		return set_validity_icpt(scb_s, 0x003CU);
-	else if (!crycb_addr)
-		return set_validity_icpt(scb_s, 0x0039U);
-
 	/* copy only the wrapping keys */
 	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
 		return set_validity_icpt(scb_s, 0x0035U);
 
 	scb_s->ecb3 |= ecb3_flags;
-	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
-			CRYCB_FORMAT2;
 
 	/* xor both blocks in one run */
 	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
@@ -189,6 +167,204 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
+/* Copy masks into apcb when g2 and g3 use format 1 */
+static int copy_apcb1(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
+	const u32 crycb_o = crycbd_o & 0x7ffffff8U;
+	struct kvm_s390_crypto_cb *crycb_h = &vcpu->kvm->arch.sie_page2->crycb;
+	struct kvm_s390_crypto_cb *crycb_s = &vsie_page->crycb;
+	unsigned long *apcb_s = (unsigned long *) &crycb_s->apcb1;
+	unsigned long *apcb_h = (unsigned long *) &crycb_h->apcb1;
+	int i;
+	u32 src;
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb1);
+	if (read_guest_real(vcpu, src, apcb_s, sizeof(struct kvm_s390_apcb1)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	for (i = 0; i < sizeof(struct kvm_s390_apcb1); i += sizeof(*apcb_s))
+		*apcb_s &= *apcb_h;
+
+	return 0;
+}
+
+/*
+ * Copy masks into apcb when g2 use format 1 and g3 use format 0
+ * In this case the shadow APCB uses format 1
+ */
+static int copy_apcb01(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
+	const u32 crycb_o = crycbd_o & 0x7ffffff8U;
+	struct kvm_s390_apcb1 *apcb_h = &vcpu->kvm->arch.sie_page2->crycb.apcb1;
+	struct kvm_s390_apcb1 *apcb_s = &vsie_page->crycb.apcb1;
+	u32 src;
+
+	memset(apcb_s, 0, sizeof(*apcb_s));
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.apm[0]);
+	if (read_guest_real(vcpu, src, &apcb_s->apm[0], sizeof(__u64)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.aqm[0]);
+	if (read_guest_real(vcpu, src, &apcb_s->aqm[0], sizeof(__u64)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.adm[0]);
+	if (read_guest_real(vcpu, src, &apcb_s->adm[0], sizeof(__u64)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	apcb_s->apm[0] &= apcb_h->apm[0];
+	apcb_s->aqm[0] &= apcb_h->aqm[0];
+	apcb_s->adm[0] &= apcb_h->adm[0];
+
+	return 0;
+}
+
+/* Copy masks into apcb when g2 and g3 use format 0 */
+static int copy_apcb0(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
+	const u32 crycb_o = crycbd_o & 0x7ffffff8U;
+	struct kvm_s390_apcb0 *apcb_h = &vcpu->kvm->arch.sie_page2->crycb.apcb0;
+	struct kvm_s390_apcb0 *apcb_s = &vsie_page->crycb.apcb0;
+	u32 src;
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.apm[0]);
+	if (read_guest_real(vcpu, src, &apcb_s->apm[0], sizeof(__u64)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.aqm[0]);
+	if (read_guest_real(vcpu, src, &apcb_s->aqm[0], sizeof(__u64)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.adm[0]);
+	if (read_guest_real(vcpu, src, &apcb_s->adm[0], sizeof(__u64)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	apcb_s->apm[0] &= apcb_h->apm[0];
+	apcb_s->aqm[0] &= apcb_h->aqm[0];
+	apcb_s->adm[0] &= apcb_h->adm[0];
+
+	return 0;
+}
+
+/* Shadowing APCB depends on G2 and G3 CRYCB format */
+static int copy_apcb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+		     int g2_fmt, int g3_fmt)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	int ret = 0;
+
+	switch (g2_fmt) {
+	case CRYCB_FORMAT0:
+		switch (g3_fmt) {
+		case  CRYCB_FORMAT0:
+			ret = copy_apcb0(vcpu, vsie_page);
+			break;
+		default:
+			return set_validity_icpt(scb_s, 0x0020U);
+		}
+		break;
+	case CRYCB_FORMAT1:
+		switch (g3_fmt) {
+		case CRYCB_FORMAT1:
+		case CRYCB_FORMAT0:	/* Fall through to copy APCB */
+			ret = copy_apcb0(vcpu, vsie_page);
+			break;
+		default:
+			return set_validity_icpt(scb_s, 0x0020U);
+		}
+		break;
+	case CRYCB_FORMAT2:
+		switch (g3_fmt) {
+		case CRYCB_FORMAT0:
+		case CRYCB_FORMAT1:
+			ret = copy_apcb01(vcpu, vsie_page);
+			break;
+		case CRYCB_FORMAT2:
+			ret = copy_apcb1(vcpu, vsie_page);
+			break;
+		}
+		break;
+	default:
+	/*
+	 * Guest 2 format is valid or we can not get to here.
+	 */
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * Create a shadow copy of the crycb block.
+ * - Setup key wrapping, if requested for guest 3 and enabled for guest 2.
+ * - Shadow APCB if requested by guest 3 and enabled for guest 2 through
+ *   ECA_APIE.
+ *
+ * We only accept format-1 (no AP in g2), but convert it into format-2
+ * There is nothing to do for format-0.
+ *
+ * Returns: - 0 if shadowed or nothing to do
+ *          - > 0 if control has to be given to guest 2
+ *          - < 0 if something went wrong on copy
+ */
+#define ECA_APIE 0x00000008
+static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
+	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
+	int g2_fmt = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
+	int g3_fmt = crycbd_o & CRYCB_FORMAT_MASK;
+	int g2_apie, g2_msa3, g3_apie, g3_msa3;
+	int size, ret;
+
+	/* crycb should not cross a page boundary */
+	size = (g3_fmt == CRYCB_FORMAT2) ? 0x100 : 0x80;
+	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + size) & PAGE_MASK))
+		return set_validity_icpt(scb_s, 0x003CU);
+
+	g2_apie = vcpu->arch.sie_block->eca & ECA_APIE;
+	g3_apie = scb_o->eca & g2_apie;
+
+	g2_msa3 = test_kvm_facility(vcpu->kvm, 76);
+	g3_msa3 = (g3_fmt != CRYCB_FORMAT0) & g2_msa3;
+
+	scb_s->crycbd = 0;
+	/* If no AP instructions and no keys we just set crycbd to 0 */
+	if (!(g3_apie || g3_msa3))
+		return 0;
+
+	if (!crycb_addr)
+		return set_validity_icpt(scb_s, 0x0039U);
+
+	if (g3_apie) {
+		ret = copy_apcb(vcpu, vsie_page, g2_fmt, g3_fmt);
+		if (ret)
+			goto out;
+		scb_s->eca |= g3_apie;
+	}
+
+	if (g3_msa3)
+		ret = copy_key_masks(vcpu, vsie_page);
+
+	if (!ret)
+		scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | g2_fmt;
+
+out:
+	return ret;
+}
+
 /* shadow (round up/down) the ibc to avoid validity icpt */
 static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
-- 
1.7.1

