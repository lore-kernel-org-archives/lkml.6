Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E206C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D456D2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D456D2152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbeHWNzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:55:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730453AbeHWNzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:55:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NAJxd8036298
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 06:26:06 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m1r06qsj8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 06:26:06 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 23 Aug 2018 11:26:04 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 11:26:02 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NAQ0O021102662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 10:26:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4336A4057;
        Thu, 23 Aug 2018 13:25:59 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DAD4A4040;
        Thu, 23 Aug 2018 13:25:59 +0100 (BST)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.92])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 13:25:59 +0100 (BST)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     david@redhat.com
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: [PATCH v3 2/3] KVM: s390: vsie: Do the CRYCB validation first
Date:   Thu, 23 Aug 2018 12:25:55 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082310-4275-0000-0000-000002AE19BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082310-4276-0000-0000-000037B7224B
Message-Id: <1535019956-23539-3-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=878 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When entering the SIE the CRYCB validation better
be done independently of the instruction's
availability.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 12b9707..38ea5da 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -161,17 +161,18 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	/* format-1 is supported with message-security-assist extension 3 */
 	if (!test_kvm_facility(vcpu->kvm, 76))
 		return 0;
-	/* we may only allow it if enabled for guest 2 */
-	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
-		     (ECB3_AES | ECB3_DEA);
-	if (!ecb3_flags)
-		return 0;
 
 	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
 		return set_validity_icpt(scb_s, 0x003CU);
 	else if (!crycb_addr)
 		return set_validity_icpt(scb_s, 0x0039U);
 
+	/* we may only allow it if enabled for guest 2 */
+	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
+		     (ECB3_AES | ECB3_DEA);
+	if (!ecb3_flags)
+		return 0;
+
 	/* copy only the wrapping keys */
 	if (read_guest_real(vcpu, crycb_addr + 72,
 			    vsie_page->crycb.dea_wrapping_key_mask, 56))
-- 
2.7.4

