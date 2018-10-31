Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9069BECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5010E20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5010E20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbeJaV6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:58:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728649AbeJaV6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:58:09 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9VCx5Cq034616
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 09:00:12 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nfcuur3dq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 09:00:12 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 31 Oct 2018 13:00:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Oct 2018 13:00:08 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9VD07Bu1376624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 13:00:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A447A11C066;
        Wed, 31 Oct 2018 13:00:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FBF811C05C;
        Wed, 31 Oct 2018 13:00:07 +0000 (GMT)
Received: from mschwideX1.boeblingen.de.ibm.com (unknown [9.152.212.164])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 31 Oct 2018 13:00:07 +0000 (GMT)
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Li Wang <liwang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4/4] s390/mm: fix mis-accounting of pgtable_bytes
Date:   Wed, 31 Oct 2018 14:00:01 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540990801-4261-1-git-send-email-schwidefsky@de.ibm.com>
References: <1540990801-4261-1-git-send-email-schwidefsky@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18103113-0016-0000-0000-0000021CFB59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103113-0017-0000-0000-0000327525F0
Message-Id: <1540990801-4261-5-git-send-email-schwidefsky@de.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case a fork or a clone system fails in copy_process and the error
handling does the mmput() at the bad_fork_cleanup_mm label, the
following warning messages will appear on the console:

  BUG: non-zero pgtables_bytes on freeing mm: 16384

The reason for that is the tricks we play with mm_inc_nr_puds() and
mm_inc_nr_pmds() in init_new_context().

A normal 64-bit process has 3 levels of page table, the p4d level and
the pud level are folded. On process termination the free_pud_range()
function in mm/memory.c will subtract 16KB from pgtable_bytes with a
mm_dec_nr_puds() call, but there actually is not really a pud table.

One issue with this is the fact that pgtable_bytes is usually off
by a few kilobytes, but the more severe problem is that for a failed
fork or clone the free_pgtables() function is not called. In this case
there is no mm_dec_nr_puds() or mm_dec_nr_pmds() that go together with
the mm_inc_nr_puds() and mm_inc_nr_pmds in init_new_context().
The pgtable_bytes will be off by 16384 or 32768 bytes and we get the
BUG message. The message itself is purely cosmetic, but annoying.

To fix this override the mm_pmd_folded, mm_pud_folded and mm_p4d_folded
function to check for the true size of the address space.

Reported-by: Li Wang <liwang@redhat.com>
Tested-by: Li Wang <liwang@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/mmu_context.h |  5 -----
 arch/s390/include/asm/pgalloc.h     |  6 +++---
 arch/s390/include/asm/pgtable.h     | 18 ++++++++++++++++++
 arch/s390/include/asm/tlb.h         |  6 +++---
 arch/s390/mm/pgalloc.c              |  1 +
 5 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index dbd689d..ccbb53e 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -46,8 +46,6 @@ static inline int init_new_context(struct task_struct *tsk,
 		mm->context.asce_limit = STACK_TOP_MAX;
 		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
 				   _ASCE_USER_BITS | _ASCE_TYPE_REGION3;
-		/* pgd_alloc() did not account this pud */
-		mm_inc_nr_puds(mm);
 		break;
 	case -PAGE_SIZE:
 		/* forked 5-level task, set new asce with new_mm->pgd */
@@ -63,9 +61,6 @@ static inline int init_new_context(struct task_struct *tsk,
 		/* forked 2-level compat task, set new asce with new mm->pgd */
 		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
 				   _ASCE_USER_BITS | _ASCE_TYPE_SEGMENT;
-		/* pgd_alloc() did not account this pmd */
-		mm_inc_nr_pmds(mm);
-		mm_inc_nr_puds(mm);
 	}
 	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
 	return 0;
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index f0f9bcf..5ee7337 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -36,11 +36,11 @@ static inline void crst_table_init(unsigned long *crst, unsigned long entry)
 
 static inline unsigned long pgd_entry_type(struct mm_struct *mm)
 {
-	if (mm->context.asce_limit <= _REGION3_SIZE)
+	if (mm_pmd_folded(mm))
 		return _SEGMENT_ENTRY_EMPTY;
-	if (mm->context.asce_limit <= _REGION2_SIZE)
+	if (mm_pud_folded(mm))
 		return _REGION3_ENTRY_EMPTY;
-	if (mm->context.asce_limit <= _REGION1_SIZE)
+	if (mm_p4d_folded(mm))
 		return _REGION2_ENTRY_EMPTY;
 	return _REGION1_ENTRY_EMPTY;
 }
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 411d435..0637324 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -493,6 +493,24 @@ static inline int is_module_addr(void *addr)
 				   _REGION_ENTRY_PROTECT | \
 				   _REGION_ENTRY_NOEXEC)
 
+static inline bool mm_p4d_folded(struct mm_struct *mm)
+{
+	return mm->context.asce_limit <= _REGION1_SIZE;
+}
+#define mm_p4d_folded(mm) mm_p4d_folded(mm)
+
+static inline bool mm_pud_folded(struct mm_struct *mm)
+{
+	return mm->context.asce_limit <= _REGION2_SIZE;
+}
+#define mm_pud_folded(mm) mm_pud_folded(mm)
+
+static inline bool mm_pmd_folded(struct mm_struct *mm)
+{
+	return mm->context.asce_limit <= _REGION3_SIZE;
+}
+#define mm_pmd_folded(mm) mm_pmd_folded(mm)
+
 static inline int mm_has_pgste(struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 457b7ba..b31c779 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -136,7 +136,7 @@ static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 				unsigned long address)
 {
-	if (tlb->mm->context.asce_limit <= _REGION3_SIZE)
+	if (mm_pmd_folded(tlb->mm))
 		return;
 	pgtable_pmd_page_dtor(virt_to_page(pmd));
 	tlb_remove_table(tlb, pmd);
@@ -152,7 +152,7 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				unsigned long address)
 {
-	if (tlb->mm->context.asce_limit <= _REGION1_SIZE)
+	if (mm_p4d_folded(tlb->mm))
 		return;
 	tlb_remove_table(tlb, p4d);
 }
@@ -167,7 +167,7 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 				unsigned long address)
 {
-	if (tlb->mm->context.asce_limit <= _REGION2_SIZE)
+	if (mm_pud_folded(tlb->mm))
 		return;
 	tlb_remove_table(tlb, pud);
 }
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 76d89ee..814f265 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -101,6 +101,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 			mm->context.asce_limit = _REGION1_SIZE;
 			mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
 				_ASCE_USER_BITS | _ASCE_TYPE_REGION2;
+			mm_inc_nr_puds(mm);
 		} else {
 			crst_table_init(table, _REGION1_ENTRY_EMPTY);
 			pgd_populate(mm, (pgd_t *) table, (p4d_t *) pgd);
-- 
2.7.4

