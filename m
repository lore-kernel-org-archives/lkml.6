Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F136C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA912064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA912064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJPA3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:29:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbeJPA3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:29:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9FGeauR025028
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:43:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n4w32ctpk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:43:00 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 15 Oct 2018 17:42:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Oct 2018 17:42:55 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9FGgsLJ60817446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Oct 2018 16:42:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB2834203F;
        Mon, 15 Oct 2018 19:42:27 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D0B842045;
        Mon, 15 Oct 2018 19:42:27 +0100 (BST)
Received: from mschwideX1.emea.ibm.com (unknown [9.145.33.55])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Oct 2018 19:42:27 +0100 (BST)
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Li Wang <liwang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 2/3] mm: add mm_pxd_folded checks to pgtable_bytes accounting functions
Date:   Mon, 15 Oct 2018 18:42:38 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
References: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18101516-0028-0000-0000-00000307ADB8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101516-0029-0000-0000-000023C2B51C
Message-Id: <1539621759-5967-3-git-send-email-schwidefsky@de.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=675 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common mm code calls mm_dec_nr_pmds() and mm_dec_nr_puds()
in free_pgtables() if the address range spans a full pud or pmd.
If mm_dec_nr_puds/mm_dec_nr_pmds are non-empty due to configuration
settings they blindly subtract the size of the pmd or pud table from
pgtable_bytes even if the pud or pmd page table layer is folded.

Add explicit mm_[pmd|pud]_folded checks to the four pgtable_bytes
accounting functions mm_inc_nr_puds, mm_inc_nr_pmds, mm_dec_nr_puds
and mm_dec_nr_pmds. As the check for folded page tables can be
overwritten by the architecture, this allows to keep a correct
pgtable_bytes value for platforms that use a dynamic number of
page table levels.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 include/linux/mm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d1029972541c..67f55c71e59a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1764,11 +1764,15 @@ int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address);
 
 static inline void mm_inc_nr_puds(struct mm_struct *mm)
 {
+	if (mm_pud_folded(mm))
+		return;
 	atomic_long_add(PTRS_PER_PUD * sizeof(pud_t), &mm->pgtables_bytes);
 }
 
 static inline void mm_dec_nr_puds(struct mm_struct *mm)
 {
+	if (mm_pud_folded(mm))
+		return;
 	atomic_long_sub(PTRS_PER_PUD * sizeof(pud_t), &mm->pgtables_bytes);
 }
 #endif
@@ -1788,11 +1792,15 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address);
 
 static inline void mm_inc_nr_pmds(struct mm_struct *mm)
 {
+	if (mm_pmd_folded(mm))
+		return;
 	atomic_long_add(PTRS_PER_PMD * sizeof(pmd_t), &mm->pgtables_bytes);
 }
 
 static inline void mm_dec_nr_pmds(struct mm_struct *mm)
 {
+	if (mm_pmd_folded(mm))
+		return;
 	atomic_long_sub(PTRS_PER_PMD * sizeof(pmd_t), &mm->pgtables_bytes);
 }
 #endif
-- 
2.16.4

