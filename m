Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE65C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981FD20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981FD20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeK2BhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:37:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727726AbeK2BhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:37:14 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASEYIkl094124
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:35:22 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p1ugqvc64-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:35:22 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 28 Nov 2018 14:35:21 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Nov 2018 14:35:18 -0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wASEZHNg20512924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 14:35:17 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BC656E058;
        Wed, 28 Nov 2018 14:35:17 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 552996E053;
        Wed, 28 Nov 2018 14:35:14 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.87.253])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 28 Nov 2018 14:35:13 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V2 5/5] arch/powerpc/mm/hugetlb: NestMMU workaround for hugetlb mprotect RW upgrade
Date:   Wed, 28 Nov 2018 20:04:38 +0530
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128143438.29458-1-aneesh.kumar@linux.ibm.com>
References: <20181128143438.29458-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112814-8235-0000-0000-00000E2FC527
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010137; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01124008; UDB=6.00583546; IPR=6.00904138;
 MB=3.00024366; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-28 14:35:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112814-8236-0000-0000-000043843E47
Message-Id: <20181128143438.29458-6-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=584 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NestMMU requires us to mark the pte invalid and flush the tlb when we do a
RW upgrade of pte. We fixed a variant of this in the fault path in commit
Fixes: bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h | 12 ++++++++
 arch/powerpc/mm/hugetlbpage-radix.c          | 17 ++++++++++++
 arch/powerpc/mm/hugetlbpage.c                | 29 ++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index 5b0177733994..66c1e4f88d65 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -13,6 +13,10 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 				unsigned long len, unsigned long pgoff,
 				unsigned long flags);
 
+extern void radix__huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
+						unsigned long addr, pte_t *ptep,
+						pte_t old_pte, pte_t pte);
+
 static inline int hstate_get_psize(struct hstate *hstate)
 {
 	unsigned long shift;
@@ -42,4 +46,12 @@ static inline bool gigantic_page_supported(void)
 /* hugepd entry valid bit */
 #define HUGEPD_VAL_BITS		(0x8000000000000000UL)
 
+#define huge_ptep_modify_prot_start huge_ptep_modify_prot_start
+extern pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep);
+
+#define huge_ptep_modify_prot_commit huge_ptep_modify_prot_commit
+extern void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep,
+					 pte_t old_pte, pte_t new_pte);
 #endif
diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index 2486bee0f93e..1f77d71e7708 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -90,3 +90,20 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
 	return vm_unmapped_area(&info);
 }
+
+void radix__huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep,
+					 pte_t old_pte, pte_t pte)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	/*
+	 * To avoid NMMU hang while relaxing access we need to flush the tlb before
+	 * we set the new value.
+	 */
+	if (is_pte_rw_upgrade(pte_val(old_pte), pte_val(pte)) &&
+	    (atomic_read(&mm->context.copros) > 0))
+		flush_hugetlb_page(vma, addr);
+
+	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+}
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 8cf035e68378..39d33a3d0dc6 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -912,3 +912,32 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 
 	return 1;
 }
+
+#ifdef CONFIG_PPC_BOOK3S_64
+pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
+				  unsigned long addr, pte_t *ptep)
+{
+	unsigned long pte_val;
+	/*
+	 * Clear the _PAGE_PRESENT so that no hardware parallel update is
+	 * possible. Also keep the pte_present true so that we don't take
+	 * wrong fault.
+	 */
+	pte_val = pte_update(vma->vm_mm, addr, ptep,
+			     _PAGE_PRESENT, _PAGE_INVALID, 1);
+
+	return __pte(pte_val);
+}
+EXPORT_SYMBOL(huge_ptep_modify_prot_start);
+
+void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
+				  pte_t *ptep, pte_t old_pte, pte_t pte)
+{
+
+	if (radix_enabled())
+		return radix__huge_ptep_modify_prot_commit(vma, addr, ptep,
+							   old_pte, pte);
+	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+}
+EXPORT_SYMBOL(huge_ptep_modify_prot_commit);
+#endif
-- 
2.19.1

