Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TCKbI73TGlvnIgAAmS7hNA
	; Fri, 08 Jun 2018 19:06:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 718F8607DC; Fri,  8 Jun 2018 19:06:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="XGIZh1PT"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 307E460275;
	Fri,  8 Jun 2018 19:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 307E460275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeFHTGc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:06:32 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:41792 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752662AbeFHTGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:06:31 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jun 2018 15:06:31 EDT
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.22/8.16.0.22) with SMTP id w58IvPOs020197;
        Fri, 8 Jun 2018 19:58:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id; s=jan2016.eng;
 bh=itzodWythzEyEoJMwkew01V3D7MPmGPBRCvvntVprY4=;
 b=XGIZh1PTqd7Io/Gq+Xl+9BbztE8ai64KXIVMsU59NtO5IRDhBGT24rpci6yaECaPtzxn
 fDuWLW0yd56DpiKQQqfRFYHazyoO2wcP+CP+9pBOzPERkoCfTO80NOLvUqJtCfwDVPRl
 IE8ljMBu37nRIvzJTzizByveKnFs3V+zxukliBX4JtFWckElmUOBXu2+sQQD7KAKZi43
 GMtMNzwaxrN8Itzu685G0oYWPI6YcTvV4bUfusoWuUXaVKTirGOQFalbPZDQDORjSi3f
 6AXybAOnJxw1cTH22EGlSERlC4fWOYurdqyZTQiuM0J5P3TXM+b0BqIX2EV0kbBu1tWF Mw==
Received: from prod-mail-ppoint3 (a96-6-114-86.deploy.static.akamaitechnologies.com [96.6.114.86] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 2jf85mmp5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jun 2018 19:58:14 +0100
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.0.21/8.16.0.21) with SMTP id w58IuAV0031234;
        Fri, 8 Jun 2018 14:58:13 -0400
Received: from prod-mail-relay14.akamai.com ([172.27.17.39])
        by prod-mail-ppoint3.akamai.com with ESMTP id 2jbpjwvbuw-1;
        Fri, 08 Jun 2018 14:58:13 -0400
Received: from bos-lpjec.kendall.corp.akamai.com (bos-lpjec.kendall.corp.akamai.com [172.28.13.175])
        by prod-mail-relay14.akamai.com (Postfix) with ESMTP id C542982D01;
        Fri,  8 Jun 2018 18:58:12 +0000 (GMT)
From: Jason Baron <jbaron@akamai.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc: Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] mm/madvise: allow MADV_DONTNEED to free memory that is MLOCK_ONFAULT
Date: Fri,  8 Jun 2018 14:56:52 -0400
Message-Id: <1528484212-7199-1-git-send-email-jbaron@akamai.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806080207
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806080207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to free memory that is marked MLOCK_ONFAULT, the memory region
needs to be first unlocked, before calling MADV_DONTNEED. And if the region
is to be reused as MLOCK_ONFAULT, we require another call to mlock2() with
the MLOCK_ONFAULT flag.

Let's simplify freeing memory that is set MLOCK_ONFAULT, by allowing
MADV_DONTNEED to work directly for memory that is set MLOCK_ONFAULT. The
locked memory limits, tracked by mm->locked_vm do not need to be adjusted
in this case, since they were charged to the entire region when
MLOCK_ONFAULT was initially set.

Further, I don't think allowing MADV_FREE for MLOCK_ONFAULT regions makes
sense, since the point of MLOCK_ONFAULT is for userspace to know when pages
are locked in memory and thus to know when page faults will occur.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/internal.h | 18 ++++++++++++++++++
 mm/madvise.c  |  4 ++--
 mm/oom_kill.c |  2 +-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9e3654d..16c0041 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/tracepoint-defs.h>
+#include <uapi/asm-generic/mman-common.h>
 
 /*
  * The set of flags that only affect watermark checking and reclaim
@@ -45,9 +46,26 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 
 static inline bool can_madv_dontneed_vma(struct vm_area_struct *vma)
 {
+	return !(((vma->vm_flags & (VM_LOCKED|VM_LOCKONFAULT)) == VM_LOCKED) ||
+		 (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP)));
+}
+
+static inline bool can_madv_free_vma(struct vm_area_struct *vma)
+{
 	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
 }
 
+static inline bool can_madv_dontneed_or_free_vma(struct vm_area_struct *vma,
+						 int behavior)
+{
+	if (behavior == MADV_DONTNEED)
+		return can_madv_dontneed_vma(vma);
+	else if (behavior == MADV_FREE)
+		return can_madv_free_vma(vma);
+	else
+		return 0;
+}
+
 void unmap_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end,
diff --git a/mm/madvise.c b/mm/madvise.c
index 4d3c922..61ff306 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -517,7 +517,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  int behavior)
 {
 	*prev = vma;
-	if (!can_madv_dontneed_vma(vma))
+	if (!can_madv_dontneed_or_free_vma(vma, behavior))
 		return -EINVAL;
 
 	if (!userfaultfd_remove(vma, start, end)) {
@@ -539,7 +539,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 			 */
 			return -ENOMEM;
 		}
-		if (!can_madv_dontneed_vma(vma))
+		if (!can_madv_dontneed_or_free_vma(vma, behavior))
 			return -EINVAL;
 		if (end > vma->vm_end) {
 			/*
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8ba6cb8..9817d15 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -492,7 +492,7 @@ void __oom_reap_task_mm(struct mm_struct *mm)
 	set_bit(MMF_UNSTABLE, &mm->flags);
 
 	for (vma = mm->mmap ; vma; vma = vma->vm_next) {
-		if (!can_madv_dontneed_vma(vma))
+		if (!can_madv_free_vma(vma))
 			continue;
 
 		/*
-- 
2.7.4
