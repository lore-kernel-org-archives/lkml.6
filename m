Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1876C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B7620BED
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B7620BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbeHNAcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:32:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730987AbeHNAck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:32:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7DLdGFJ077446
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:48:34 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kugy6tm2b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:48:34 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Mon, 13 Aug 2018 17:48:33 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Aug 2018 17:48:30 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7DLmSjw13041770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Aug 2018 21:48:28 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDA0912405C;
        Mon, 13 Aug 2018 18:49:26 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B77D7124055;
        Mon, 13 Aug 2018 18:49:25 -0400 (EDT)
Received: from localhost.localdomain (unknown [9.85.141.105])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Aug 2018 18:49:25 -0400 (EDT)
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
Subject: [PATCH v9 02/22] s390/zcrypt: Review inline assembler constraints.
Date:   Mon, 13 Aug 2018 17:47:59 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18081321-0064-0000-0000-0000033A58F1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009538; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073087; UDB=6.00552882; IPR=6.00853043;
 MB=3.00022698; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-13 21:48:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081321-0065-0000-0000-00003A4A2153
Message-Id: <1534196899-16987-3-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=960 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808130218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Freudenberger <freude@de.ibm.com>

Reviewed and adapted the register use and asm constraints
of the C inline assembler functions in accordance to the
the AP instructions specifications.

Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/ap_asm.h |   40 +++++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/crypto/ap_asm.h b/drivers/s390/crypto/ap_asm.h
index b22d30a..e22ee12 100644
--- a/drivers/s390/crypto/ap_asm.h
+++ b/drivers/s390/crypto/ap_asm.h
@@ -20,14 +20,16 @@ static inline int ap_instructions_available(void)
 {
 	register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
 	register unsigned long reg1 asm ("1") = -ENODEV;
-	register unsigned long reg2 asm ("2") = 0UL;
+	register unsigned long reg2 asm ("2");
 
 	asm volatile(
 		"   .long 0xb2af0000\n"		/* PQAP(TAPQ) */
-		"0: la    %1,0\n"
+		"0: la    %0,0\n"
 		"1:\n"
 		EX_TABLE(0b, 1b)
-		: "+d" (reg0), "+d" (reg1), "+d" (reg2) : : "cc");
+		: "+d" (reg1), "=d" (reg2)
+		: "d" (reg0)
+		: "cc");
 	return reg1;
 }
 
@@ -42,10 +44,12 @@ static inline struct ap_queue_status ap_tapq(ap_qid_t qid, unsigned long *info)
 {
 	register unsigned long reg0 asm ("0") = qid;
 	register struct ap_queue_status reg1 asm ("1");
-	register unsigned long reg2 asm ("2") = 0UL;
+	register unsigned long reg2 asm ("2");
 
 	asm volatile(".long 0xb2af0000"		/* PQAP(TAPQ) */
-		     : "+d" (reg0), "=d" (reg1), "+d" (reg2) : : "cc");
+		     : "=d" (reg1), "=d" (reg2)
+		     : "d" (reg0)
+		     : "cc");
 	if (info)
 		*info = reg2;
 	return reg1;
@@ -59,13 +63,14 @@ static inline struct ap_queue_status ap_tapq(ap_qid_t qid, unsigned long *info)
  */
 static inline struct ap_queue_status ap_rapq(ap_qid_t qid)
 {
-	register unsigned long reg0 asm ("0") = qid | 0x01000000UL;
+	register unsigned long reg0 asm ("0") = qid | (1UL << 24);
 	register struct ap_queue_status reg1 asm ("1");
-	register unsigned long reg2 asm ("2") = 0UL;
 
 	asm volatile(
 		".long 0xb2af0000"		/* PQAP(RAPQ) */
-		: "+d" (reg0), "=d" (reg1), "+d" (reg2) : : "cc");
+		: "=d" (reg1)
+		: "d" (reg0)
+		: "cc");
 	return reg1;
 }
 
@@ -107,8 +112,8 @@ static inline struct ap_queue_status ap_aqic(ap_qid_t qid,
 
 	asm volatile(
 		".long 0xb2af0000"		/* PQAP(AQIC) */
-		: "+d" (reg0), "+d" (reg1_in), "=d" (reg1_out), "+d" (reg2)
-		:
+		: "=d" (reg1_out)
+		: "d" (reg0), "d" (reg1_in), "d" (reg2)
 		: "cc");
 	return reg1_out;
 }
@@ -120,17 +125,17 @@ static inline struct ap_queue_status ap_aqic(ap_qid_t qid,
  */
 static inline int ap_qci(void *config)
 {
-	register unsigned long reg0 asm ("0") = 0x04000000UL;
+	register unsigned long reg0 asm ("0") = 4UL << 24;
 	register unsigned long reg1 asm ("1") = -EINVAL;
 	register void *reg2 asm ("2") = (void *) config;
 
 	asm volatile(
 		".long 0xb2af0000\n"		/* PQAP(QCI) */
-		"0: la    %1,0\n"
+		"0: la    %0,0\n"
 		"1:\n"
 		EX_TABLE(0b, 1b)
-		: "+d" (reg0), "+d" (reg1), "+d" (reg2)
-		:
+		: "+d" (reg1)
+		: "d" (reg0), "d" (reg2)
 		: "cc", "memory");
 
 	return reg1;
@@ -169,12 +174,13 @@ static inline struct ap_queue_status ap_qact(ap_qid_t qid, int ifbit,
 		| ((ifbit & 0x01) << 22);
 	register unsigned long reg1_in asm ("1") = apinfo->val;
 	register struct ap_queue_status reg1_out asm ("1");
-	register unsigned long reg2 asm ("2") = 0;
+	register unsigned long reg2 asm ("2");
 
 	asm volatile(
 		".long 0xb2af0000"		/* PQAP(QACT) */
-		: "+d" (reg0), "+d" (reg1_in), "=d" (reg1_out), "+d" (reg2)
-		: : "cc");
+		: "+d" (reg1_in), "=d" (reg1_out), "=d" (reg2)
+		: "d" (reg0)
+		: "cc");
 	apinfo->val = reg2;
 	return reg1_out;
 }
-- 
1.7.1

