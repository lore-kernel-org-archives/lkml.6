Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85DCC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA1B2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA1B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeJPA3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:29:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbeJPA3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:29:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9FGeBv4037975
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:43:02 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n4vy1w5ym-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:43:01 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 15 Oct 2018 17:42:59 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Oct 2018 17:42:56 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9FGgtCN393482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Oct 2018 16:42:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37A6542047;
        Mon, 15 Oct 2018 19:42:29 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCD9A42042;
        Mon, 15 Oct 2018 19:42:28 +0100 (BST)
Received: from mschwideX1.emea.ibm.com (unknown [9.145.33.55])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Oct 2018 19:42:28 +0100 (BST)
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Li Wang <liwang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 3/3] s390/mm: fix mis-accounting of pgtable_bytes
Date:   Mon, 15 Oct 2018 18:42:39 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
References: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18101516-0028-0000-0000-00000307ADB9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101516-0029-0000-0000-000023C2B51E
Message-Id: <1539621759-5967-4-git-send-email-schwidefsky@de.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150147
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
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/mmu_context.h |  5 -----
 arch/s390/include/asm/pgalloc.h     |  6 +++---
 arch/s390/include/asm/pgtable.h     | 18 ++++++++++++++++++
 arch/s390/include/asm/tlb.h         |  6 +++---
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index 0717ee76885d..f1ab9420ccfb 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -45,8 +45,6 @@ static inline int init_new_context(struct task_struct *tsk,
 		mm->context.asce_limit = STACK_TOP_MAX;
 		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
 				   _ASCE_USER_BITS | _ASCE_TYPE_REGION3;
-		/* pgd_alloc() did not account this pud */
-		mm_inc_nr_puds(mm);
 		break;
 	case -PAGE_SIZE:
 		/* forked 5-level task, set new asce with new_mm->pgd */
@@ -62,9 +60,6 @@ static inline int init_new_context(struct task_struct *tsk,
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
index f0f9bcf94c03..5ee733720a57 100644
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
index 0e7cb0dc9c33..de05466ce50c 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -485,6 +485,24 @@ static inline int is_module_addr(void *addr)
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
index 457b7ba0fbb6..b31c779cf581 100644
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
-- 
2.16.4

