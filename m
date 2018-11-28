Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDB7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D6820989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D6820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeK2BhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:37:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727726AbeK2BhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:37:10 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASEYKCo066426
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:35:17 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p1up5bptx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:35:17 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 28 Nov 2018 14:35:16 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Nov 2018 14:35:13 -0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wASEZCEA23462128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 14:35:12 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD7376E056;
        Wed, 28 Nov 2018 14:35:12 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D0EE6E054;
        Wed, 28 Nov 2018 14:35:09 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.87.253])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 28 Nov 2018 14:35:09 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V2 4/5] mm/hugetlb: Add prot_modify_start/commit sequence for hugetlb update
Date:   Wed, 28 Nov 2018 20:04:37 +0530
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128143438.29458-1-aneesh.kumar@linux.ibm.com>
References: <20181128143438.29458-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112814-0016-0000-0000-0000095C37AF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010137; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01124008; UDB=6.00583546; IPR=6.00904137;
 MB=3.00024366; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-28 14:35:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112814-0017-0000-0000-000041381595
Message-Id: <20181128143438.29458-5-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=983 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/hugetlb.h | 18 ++++++++++++++++++
 mm/hugetlb.c            |  8 +++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 087fd5f48c91..e2a3b0c854eb 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -543,6 +543,24 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 	set_huge_pte_at(mm, addr, ptep, pte);
 }
 #endif
+
+#ifndef huge_ptep_modify_prot_start
+static inline pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
+						unsigned long addr, pte_t *ptep)
+{
+	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+}
+#endif
+
+#ifndef huge_ptep_modify_prot_commit
+static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
+						unsigned long addr, pte_t *ptep,
+						pte_t old_pte, pte_t pte)
+{
+	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+}
+#endif
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 #define alloc_huge_page(v, a, r) NULL
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7f2a28ab46d5..e5f5cda14f28 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4388,10 +4388,12 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			continue;
 		}
 		if (!huge_pte_none(pte)) {
-			pte = huge_ptep_get_and_clear(mm, address, ptep);
-			pte = pte_mkhuge(huge_pte_modify(pte, newprot));
+			pte_t old_pte;
+
+			old_pte = huge_ptep_modify_prot_start(vma, address, ptep);
+			pte = pte_mkhuge(huge_pte_modify(old_pte, newprot));
 			pte = arch_make_huge_pte(pte, vma, NULL, 0);
-			set_huge_pte_at(mm, address, ptep, pte);
+			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
 		}
 		spin_unlock(ptl);
-- 
2.19.1

