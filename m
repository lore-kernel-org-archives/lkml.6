Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103D4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC00E2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YSHauSFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390667AbfAKUMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:12:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55458 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389268AbfAKUMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:12:37 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0BK3YQ7038845;
        Fri, 11 Jan 2019 20:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=n1i+b3unkjpNYxqcEhfDSmY/9FySvsyj3Uo3w/fMxNE=;
 b=YSHauSFf1/rr7TAiE5uAWY4ThO9J3AN3nFh5+xR+uUG35wUhXc2r5mWzSNluzu9CYXNu
 nP4ILwnO5vnbzUFHZF+jkzN7MnOQCJ7fNQz8+O6yht6eWBpb9m+/IieJpIydiNxc3tJU
 jcDFwWqDFm1p1QJat/S2EbMu//+FJh8ChFJTnbhxHdS7vmhAfp8lUuYBapcXwOrYG9H9
 mGUFSyea19jcHRtmH4tmEfh0L5HQk4BMK7kWufEoyCUR1wuWFDSu8jxg+YSkhfcFHDHj
 q8xrAp0jzTEmFL5/VXqWm0+2MUxfkVIljvrsxZA52io9jz8LqIb6JO6CV6mlIVL+HAjc oQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2ptj3ef3dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 20:10:17 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0BKAGmd022776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 20:10:16 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0BKADA6013556;
        Fri, 11 Jan 2019 20:10:13 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jan 2019 12:10:13 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Boaz Harrosh <boazh@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH] mm: align anon mmap for THP
Date:   Fri, 11 Jan 2019 12:10:03 -0800
Message-Id: <20190111201003.19755-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.2
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9133 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901110159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At LPC last year, Boaz Harrosh asked why he had to 'jump through hoops'
to get an address returned by mmap() suitably aligned for THP.  It seems
that if mmap is asking for a mapping length greater than huge page
size, it should align the returned address to huge page size.

THP alignment has already been added for DAX, shm and tmpfs.  However,
simple anon mappings does not take THP alignment into account.

I could not determine if this was ever considered or discussed in the past.

There is a maze of arch specific and independent get_unmapped_area
routines.  The patch below just modifies the common vm_unmapped_area
routine.  It may be too simplistic, but I wanted to throw out some
code while asking if something like this has ever been considered.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/huge_mm.h |  6 ++++++
 include/linux/mm.h      |  3 +++
 mm/mmap.c               | 11 +++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 4663ee96cf59..dbff7ea7d2e7 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -117,6 +117,10 @@ static inline bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 	return false;
 }
 
+#define thp_enabled_globally()						\
+	(transparent_hugepage_flags &					\
+	 ((1<<TRANSPARENT_HUGEPAGE_FLAG) |				\
+	  (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
@@ -262,6 +266,8 @@ static inline bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 	return false;
 }
 
+#define thp_enabled_globally() false
+
 static inline void prep_transhuge_page(struct page *page) {}
 
 #define transparent_hugepage_flags 0UL
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5411de93a363..131b0be0bbeb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2358,6 +2358,7 @@ struct vm_unmapped_area_info {
 	unsigned long align_offset;
 };
 
+extern void thp_vma_unmapped_align(struct vm_unmapped_area_info *info);
 extern unsigned long unmapped_area(struct vm_unmapped_area_info *info);
 extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
 
@@ -2373,6 +2374,8 @@ extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
 static inline unsigned long
 vm_unmapped_area(struct vm_unmapped_area_info *info)
 {
+	thp_vma_unmapped_align(info);
+
 	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
 		return unmapped_area_topdown(info);
 	else
diff --git a/mm/mmap.c b/mm/mmap.c
index 6c04292e16a7..f9c111394052 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1864,6 +1864,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return error;
 }
 
+void thp_vma_unmapped_align(struct vm_unmapped_area_info *info)
+{
+	if (!thp_enabled_globally())
+		return;
+
+	if (info->align_mask || info->length < HPAGE_PMD_SIZE)
+		return;
+
+	info->align_mask = PAGE_MASK & (HPAGE_PMD_SIZE - 1);
+}
+
 unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
 	/*
-- 
2.17.2

