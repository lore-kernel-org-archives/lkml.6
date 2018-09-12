Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6C7C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E33E2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E33E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeIMAuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:50:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbeIMAun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:50:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CJYPwh104835
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:44:40 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf7btmnf0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:44:40 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Wed, 12 Sep 2018 13:44:39 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 13:44:35 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CJiWMG51642390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 12:44:32 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCC0D6A04D;
        Wed, 12 Sep 2018 13:44:32 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E59436A04F;
        Wed, 12 Sep 2018 13:44:29 -0600 (MDT)
Received: from localhost.localdomain (unknown [9.80.213.181])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Sep 2018 13:44:29 -0600 (MDT)
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
Subject: [PATCH v10 17/26] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
Date:   Wed, 12 Sep 2018 15:43:07 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091219-0036-0000-0000-00000A360111
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009709; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01087371; UDB=6.00561488; IPR=6.00867384;
 MB=3.00023256; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-12 19:44:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091219-0037-0000-0000-000048EAD6F3
Message-Id: <1536781396-13601-18-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=818 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Morel <pmorel@linux.ibm.com>

The comment preceding the shadow_crycb function is
misleading, we effectively accept FORMAT2 CRYCB in the
guest.

When using FORMAT2 in the host we do not need to or with
FORMAT1.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/vsie.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 38ea5da..e0e6fbf 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -140,7 +140,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
  * Create a shadow copy of the crycb block and setup key wrapping, if
  * requested for guest 3 and enabled for guest 2.
  *
- * We only accept format-1 (no AP in g2), but convert it into format-2
+ * We accept format-1 or format-2, but we treat it as a format-1 (no AP in g2),
+ * and we convert it into format-2 in the shadow CRYCB.
  * There is nothing to do for format-0.
  *
  * Returns: - 0 if shadowed or nothing to do
@@ -179,8 +180,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		return set_validity_icpt(scb_s, 0x0035U);
 
 	scb_s->ecb3 |= ecb3_flags;
-	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
-			CRYCB_FORMAT2;
+	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT2;
 
 	/* xor both blocks in one run */
 	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
-- 
1.7.1

