Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30C3C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719D3208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719D3208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbeG0PNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:13:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730458AbeG0PNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:13:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RDmlb2037898
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:51:44 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kg2ejnq53-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:51:43 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.vnet.ibm.com>;
        Fri, 27 Jul 2018 14:51:42 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 14:51:39 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6RDpdZx41156848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 13:51:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2199552052;
        Fri, 27 Jul 2018 16:51:52 +0100 (BST)
Received: from nimbus.lab.toulouse-stg.fr.ibm.com (unknown [9.145.62.135])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8FC8052050;
        Fri, 27 Jul 2018 16:51:51 +0100 (BST)
From:   Laurent Dufour <ldufour@linux.vnet.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     aneesh.kumar@linux.ibm.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com
Subject: [PATCH 3/3] powerpc/pseries/mm: call H_BLOCK_REMOVE
Date:   Fri, 27 Jul 2018 15:51:33 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072713-0012-0000-0000-0000028FB06F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072713-0013-0000-0000-000020C1A4CA
Message-Id: <1532699493-10883-4-git-send-email-ldufour@linux.vnet.ibm.com>
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

This hypervisor call allows to remove up to 8 ptes with only call to tlbie.

The virtual pages must be all within the same naturally aligned 8 page
virtual address block and have the same page and segment size encodings.

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h     |   1 +
 arch/powerpc/platforms/pseries/lpar.c | 223 +++++++++++++++++++++++++++++++---
 2 files changed, 205 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 662c8347d699..e403d574651d 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -278,6 +278,7 @@
 #define H_COP			0x304
 #define H_GET_MPP_X		0x314
 #define H_SET_MODE		0x31C
+#define H_BLOCK_REMOVE		0x328
 #define H_CLEAR_HPT		0x358
 #define H_REQUEST_VMC		0x360
 #define H_RESIZE_HPT_PREPARE	0x36C
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 96b8cd8a802d..41ed03245eb4 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -418,6 +418,73 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	BUG_ON(lpar_rc != H_SUCCESS);
 }
 
+
+/*
+ * As defined in the PAPR's section 14.5.4.1.8
+ * The control mask doesn't include the returned reference and change bit from
+ * the processed PTE.
+ */
+#define HBLKR_AVPN		0x0100000000000000UL
+#define HBLKR_CTRL_MASK		0xf800000000000000UL
+#define HBLKR_CTRL_SUCCESS	0x8000000000000000UL
+#define HBLKR_CTRL_ERRNOTFOUND	0x8800000000000000UL
+#define HBLKR_CTRL_ERRBUSY	0xa000000000000000UL
+
+/**
+ * H_BLOCK_REMOVE caller.
+ * @idx should point to the latest @param entry set with a PTEX.
+ * If PTE cannot be processed because another CPUs has already locked that
+ * group, those entries are put back in @param starting at index 1.
+ * If entries has to be retried and @retry_busy is set to true, these entries
+ * are retried until success. If @retry_busy is set to false, the returned
+ * is the number of entries yet to process.
+ */
+static unsigned long call_block_remove(unsigned long idx, unsigned long *param,
+				       bool retry_busy)
+{
+	unsigned long i, rc, new_idx;
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+
+again:
+	new_idx = 0;
+	BUG_ON((idx < 2) || (idx > PLPAR_HCALL9_BUFSIZE));
+	if (idx < PLPAR_HCALL9_BUFSIZE)
+		param[idx] = HBR_END;
+
+	rc = plpar_hcall9(H_BLOCK_REMOVE, retbuf,
+			  param[0], /* AVA */
+			  param[1],  param[2],  param[3],  param[4], /* TS0-7 */
+			  param[5],  param[6],  param[7],  param[8]);
+	if (rc == H_SUCCESS)
+		return 0;
+
+	BUG_ON(rc != H_PARTIAL);
+
+	/* Check that the unprocessed entries were 'not found' or 'busy' */
+	for (i = 0; i < idx-1; i++) {
+		unsigned long ctrl = retbuf[i] & HBLKR_CTRL_MASK;
+
+		if (ctrl == HBLKR_CTRL_ERRBUSY) {
+			param[++new_idx] = param[i+1];
+			continue;
+		}
+
+		BUG_ON(ctrl != HBLKR_CTRL_SUCCESS
+		       && ctrl != HBLKR_CTRL_ERRNOTFOUND);
+	}
+
+	/*
+	 * If there were entries found busy, retry these entries if requested,
+	 * of if all the entries have to be retried.
+	 */
+	if (new_idx && (retry_busy || new_idx == (PLPAR_HCALL9_BUFSIZE-1))) {
+		idx = new_idx + 1;
+		goto again;
+	}
+
+	return new_idx;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * Limit iterations holding pSeries_lpar_tlbie_lock to 3. We also need
@@ -425,17 +492,59 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
  */
 #define PPC64_HUGE_HPTE_BATCH 12
 
-static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
-					     unsigned long *vpn, int count,
-					     int psize, int ssize)
+static void hugepage_block_invalidate(unsigned long *slot, unsigned long *vpn,
+				      int count, int psize, int ssize)
 {
 	unsigned long param[PLPAR_HCALL9_BUFSIZE];
-	int i = 0, pix = 0, rc;
-	unsigned long flags = 0;
-	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
+	unsigned long shift, current_vpgb, vpgb;
+	int i, pix = 0;
 
-	if (lock_tlbie)
-		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
+	shift = mmu_psize_defs[psize].shift;
+
+	for (i = 0; i < count; i++) {
+		/*
+		 * Shifting 3 bits more on the right to get a
+		 * 8 pages aligned virtual addresse.
+		 */
+		vpgb = (vpn[i] >> (shift - VPN_SHIFT + 3));
+		if (!pix || vpgb != current_vpgb) {
+			/*
+			 * Need to start a new 8 pages block, flush
+			 * the current one if needed.
+			 */
+			if (pix)
+				(void)call_block_remove(pix, param, true);
+			current_vpgb = vpgb;
+			param[0] = hpte_encode_avpn(vpn[i], psize, ssize);
+			pix = 1;
+		}
+
+		param[pix++] = HBR_REQUEST | HBLKR_AVPN | slot[i];
+		if (pix == PLPAR_HCALL9_BUFSIZE) {
+			pix = call_block_remove(pix, param, false);
+			/*
+			 * pix = 0 means that all the entries were
+			 * removed, we can start a new block.
+			 * Otherwise, this means that there are entries
+			 * to retry, and pix points to latest one, so
+			 * we should increment it and try to continue
+			 * the same block.
+			 */
+			if (!pix)
+				current_vpgb = 0;
+			else
+				pix++;
+		}
+	}
+	if (pix)
+		(void)call_block_remove(pix, param, true);
+}
+
+static void hugepage_bulk_invalidate(unsigned long *slot, unsigned long *vpn,
+				     int count, int psize, int ssize)
+{
+	unsigned long param[PLPAR_HCALL9_BUFSIZE];
+	int i = 0, pix = 0, rc;
 
 	for (i = 0; i < count; i++) {
 
@@ -443,17 +552,6 @@ static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 			pSeries_lpar_hpte_invalidate(slot[i], vpn[i], psize, 0,
 						     ssize, 0);
 		} else {
-			param[pix] = HBR_REQUEST | HBR_AVPN | slot[i];
-			param[pix+1] = hpte_encode_avpn(vpn[i], psize, ssize);
-			pix += 2;
-			if (pix == 8) {
-				rc = plpar_hcall9(H_BULK_REMOVE, param,
-						  param[0], param[1], param[2],
-						  param[3], param[4], param[5],
-						  param[6], param[7]);
-				BUG_ON(rc != H_SUCCESS);
-				pix = 0;
-			}
 		}
 	}
 	if (pix) {
@@ -463,6 +561,23 @@ static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 				  param[6], param[7]);
 		BUG_ON(rc != H_SUCCESS);
 	}
+}
+
+static inline void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
+						      unsigned long *vpn,
+						      int count, int psize,
+						      int ssize)
+{
+	unsigned long flags = 0;
+	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
+
+	if (lock_tlbie)
+		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
+
+	if (firmware_has_feature(FW_FEATURE_BLOCK_REMOVE))
+		hugepage_block_invalidate(slot, vpn, count, psize, ssize);
+	else
+		hugepage_bulk_invalidate(slot, vpn, count, psize, ssize);
 
 	if (lock_tlbie)
 		spin_unlock_irqrestore(&pSeries_lpar_tlbie_lock, flags);
@@ -565,6 +680,70 @@ static inline unsigned long compute_slot(real_pte_t pte,
 	return slot;
 }
 
+/**
+ * The hcall H_BLOCK_REMOVE implies that the virtual pages to processed are
+ * "all within the same naturally aligned 8 page virtual address block".
+ */
+static void do_block_remove(unsigned long number, struct ppc64_tlb_batch *batch,
+			    unsigned long *param)
+{
+	unsigned long vpn;
+	unsigned long i, pix = 0;
+	unsigned long index, shift, slot, current_vpgb, vpgb;
+	real_pte_t pte;
+	int psize, ssize;
+
+	psize = batch->psize;
+	ssize = batch->ssize;
+
+	for (i = 0; i < number; i++) {
+		vpn = batch->vpn[i];
+		pte = batch->pte[i];
+		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
+			/*
+			 * Shifting 3 bits more on the right to get a
+			 * 8 pages aligned virtual addresse.
+			 */
+			vpgb = (vpn >> (shift - VPN_SHIFT + 3));
+			if (!pix || vpgb != current_vpgb) {
+				/*
+				 * Need to start a new 8 pages block, flush
+				 * the current one if needed.
+				 */
+				if (pix)
+					(void)call_block_remove(pix, param,
+								true);
+				current_vpgb = vpgb;
+				param[0] = hpte_encode_avpn(vpn, psize,
+							    ssize);
+				pix = 1;
+			}
+
+			slot = compute_slot(pte, vpn, index, shift, ssize);
+			param[pix++] = HBR_REQUEST | HBLKR_AVPN | slot;
+
+			if (pix == PLPAR_HCALL9_BUFSIZE) {
+				pix = call_block_remove(pix, param, false);
+				/*
+				 * pix = 0 means that all the entries were
+				 * removed, we can start a new block.
+				 * Otherwise, this means that there are entries
+				 * to retry, and pix points to latest one, so
+				 * we should increment it and try to continue
+				 * the same block.
+				 */
+				if (!pix)
+					current_vpgb = 0;
+				else
+					pix++;
+			}
+		} pte_iterate_hashed_end();
+	}
+
+	if (pix > 1)
+		(void)call_block_remove(pix, param, true);
+}
+
 /*
  * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
  * lock.
@@ -584,6 +763,11 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	if (lock_tlbie)
 		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
 
+	if (firmware_has_feature(FW_FEATURE_BLOCK_REMOVE)) {
+		do_block_remove(number, batch, param);
+		goto out;
+	}
+
 	psize = batch->psize;
 	ssize = batch->ssize;
 	pix = 0;
@@ -622,6 +806,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 		BUG_ON(rc != H_SUCCESS);
 	}
 
+out:
 	if (lock_tlbie)
 		spin_unlock_irqrestore(&pSeries_lpar_tlbie_lock, flags);
 }
-- 
2.7.4

