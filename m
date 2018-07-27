Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D1FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE45208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE45208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbeG0PNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:13:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732706AbeG0PNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:13:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RDmkEZ118828
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:51:44 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kg2fq5mgg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:51:43 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.vnet.ibm.com>;
        Fri, 27 Jul 2018 14:51:42 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 14:51:38 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6RDpb2140370404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 13:51:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80D8A5204F;
        Fri, 27 Jul 2018 16:51:50 +0100 (BST)
Received: from nimbus.lab.toulouse-stg.fr.ibm.com (unknown [9.145.62.135])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id ED91252051;
        Fri, 27 Jul 2018 16:51:49 +0100 (BST)
From:   Laurent Dufour <ldufour@linux.vnet.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     aneesh.kumar@linux.ibm.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com
Subject: [PATCH 2/3] powerpc/pseries/mm: factorize PTE slot computation
Date:   Fri, 27 Jul 2018 15:51:32 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072713-4275-0000-0000-0000029F6715
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072713-4276-0000-0000-000037A76B3B
Message-Id: <1532699493-10883-3-git-send-email-ldufour@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This part of code will be called also when dealing with H_BLOCK_REMOVE.

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 52eeff1297f4..96b8cd8a802d 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -547,6 +547,24 @@ static int pSeries_lpar_hpte_removebolted(unsigned long ea,
 	return 0;
 }
 
+
+static inline unsigned long compute_slot(real_pte_t pte,
+					 unsigned long vpn,
+					 unsigned long index,
+					 unsigned long shift,
+					 int ssize)
+{
+	unsigned long slot, hash, hidx;
+
+	hash = hpt_hash(vpn, shift, ssize);
+	hidx = __rpte_to_hidx(pte, index);
+	if (hidx & _PTEIDX_SECONDARY)
+		hash = ~hash;
+	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+	slot += hidx & _PTEIDX_GROUP_IX;
+	return slot;
+}
+
 /*
  * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
  * lock.
@@ -559,7 +577,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long param[PLPAR_HCALL9_BUFSIZE];
-	unsigned long hash, index, shift, hidx, slot;
+	unsigned long index, shift, slot;
 	real_pte_t pte;
 	int psize, ssize;
 
@@ -573,12 +591,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 		vpn = batch->vpn[i];
 		pte = batch->pte[i];
 		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
-			hash = hpt_hash(vpn, shift, ssize);
-			hidx = __rpte_to_hidx(pte, index);
-			if (hidx & _PTEIDX_SECONDARY)
-				hash = ~hash;
-			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-			slot += hidx & _PTEIDX_GROUP_IX;
+			slot = compute_slot(pte, vpn, index, shift, ssize);
 			if (!firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
 				/*
 				 * lpar doesn't use the passed actual page size
-- 
2.7.4

