Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC19C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 06:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A5321773
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 06:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="GWHyK0x4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfBCGy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 01:54:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34862 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfBCGy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 01:54:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so5321988pfi.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 22:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICuNB17w6PrPN6phGSOGL9Fh2axlKpYzYZ29Jq7bzZ0=;
        b=GWHyK0x49kjObKonHwtpIl5Vl+vV1kLSpiEZA92ogSSBI+NNJsq5SQed+mqfo4nhz0
         hB2Ry6q5MHe0j9/tQPltGBAopLp3VBLMxs+veFjKHc79fXxBgy2q3ySN8klCV75zFfzi
         K2T+nMSGAWs5EmR+ZjrbHgMAFBSBdKD7vAoLeLxSAyhYQWIYAXOzraOj6luU+km39NNv
         UbugfkPObxLSiqUghh5SFie+G1Btplaspxn4Vww7QlGbI2eEIC19NG+CIdyFCN86lgYZ
         x+2qjn9xv0VykNOsYQfYL8Ip4s8QDEHTNBsnHoSXxvI3BRO0xxw8SpMOCsT0jztw2uWt
         hZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICuNB17w6PrPN6phGSOGL9Fh2axlKpYzYZ29Jq7bzZ0=;
        b=mmIKXsPKMbPOUuK3DROBaQdGeQZbafNw7BvcBL83Tkwj7Wo5zAgVMQ8VUHvTUtt38w
         EcawvpQIk72kG/ys4OVysVeS2hzkSq5x2ZtToTj6b4hIm5khKf2H5wxm3RuIIYoXDn2P
         VECztRrGXF2QpzuSmhfzdJtNnFwDTPv9tL2cnDIwQdFRvkzsumXPEoRkCLdoepM+JbOp
         n6XNXv5Qf4TEsknXVjPUm/FqUw/3rH9L8PbrhE6u6bY8lTDaVzMZabiGuAC/cCbHLFPu
         2xGwIeQQSXFuMtyj8r4woTlbIgI8v5gKH8lK3v8MD140jJVGYFucwQGoKkCtRaYmLy7Q
         R+Sg==
X-Gm-Message-State: AHQUAubbOxx8To4a3a1wfRLmcfS/TqQ6JoZfXJCgKKS9kHv7iYsn8iTn
        QFYz8NMDSQLGJrMJTPoc4i7KLQ==
X-Google-Smtp-Source: AHgI3Ib2ZLygKEHd7KMJZinYXtBH9sKmiVSjNEvzqS/kf0ZnksfYfwOiVUZ/LEIqxOtAUS4ukzYhsg==
X-Received: by 2002:a65:40ca:: with SMTP id u10mr7500164pgp.321.1549176867992;
        Sat, 02 Feb 2019 22:54:27 -0800 (PST)
Received: from sspatil-glaptop2.roam.corp.google.com (c-73-170-36-70.hsd1.ca.comcast.net. [73.170.36.70])
        by smtp.gmail.com with ESMTPSA id t3sm7363638pgp.5.2019.02.02.22.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 22:54:27 -0800 (PST)
From:   Sandeep Patil <sspatil@android.com>
To:     vbabka@suse.cz, adobriyan@gmail.com, akpm@linux-foundation.org,
        avagin@openvz.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@android.com, dancol@google.com
Subject: [PATCH v2] mm: proc: smaps_rollup: Fix pss_locked calculation
Date:   Sat,  2 Feb 2019 22:54:25 -0800
Message-Id: <20190203065425.14650-1-sspatil@android.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'pss_locked' field of smaps_rollup was being calculated incorrectly.
It accumulated the current pss everytime a locked VMA was found.  Fix
that by adding to 'pss_locked' the same time as that of 'pss' if the vma
being walked is locked.

Fixes: 493b0e9d945f ("mm: add /proc/pid/smaps_rollup")
Cc: stable@vger.kernel.org # 4.14.y 4.19.y
Signed-off-by: Sandeep Patil <sspatil@android.com>
---

v1->v2
------
- Move pss_locked accounting into smaps_account() inline with pss

 fs/proc/task_mmu.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f0ec9edab2f3..85b0ef890b28 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -423,7 +423,7 @@ struct mem_size_stats {
 };
 
 static void smaps_account(struct mem_size_stats *mss, struct page *page,
-		bool compound, bool young, bool dirty)
+		bool compound, bool young, bool dirty, bool locked)
 {
 	int i, nr = compound ? 1 << compound_order(page) : 1;
 	unsigned long size = nr * PAGE_SIZE;
@@ -450,24 +450,31 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		else
 			mss->private_clean += size;
 		mss->pss += (u64)size << PSS_SHIFT;
+		if (locked)
+			mss->pss_locked += (u64)size << PSS_SHIFT;
 		return;
 	}
 
 	for (i = 0; i < nr; i++, page++) {
 		int mapcount = page_mapcount(page);
+		unsigned long pss = (PAGE_SIZE << PSS_SHIFT);
 
 		if (mapcount >= 2) {
 			if (dirty || PageDirty(page))
 				mss->shared_dirty += PAGE_SIZE;
 			else
 				mss->shared_clean += PAGE_SIZE;
-			mss->pss += (PAGE_SIZE << PSS_SHIFT) / mapcount;
+			mss->pss += pss / mapcount;
+			if (locked)
+				mss->pss_locked += pss / mapcount;
 		} else {
 			if (dirty || PageDirty(page))
 				mss->private_dirty += PAGE_SIZE;
 			else
 				mss->private_clean += PAGE_SIZE;
-			mss->pss += PAGE_SIZE << PSS_SHIFT;
+			mss->pss += pss;
+			if (locked)
+				mss->pss_locked += pss;
 		}
 	}
 }
@@ -490,6 +497,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
+	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
 
 	if (pte_present(*pte)) {
@@ -532,7 +540,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	if (!page)
 		return;
 
-	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte));
+	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte), locked);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -541,6 +549,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
+	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page;
 
 	/* FOLL_DUMP will return -EFAULT on huge zero page */
@@ -555,7 +564,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		/* pass */;
 	else
 		VM_BUG_ON_PAGE(1, page);
-	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd));
+	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd), locked);
 }
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
@@ -737,11 +746,8 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 		}
 	}
 #endif
-
 	/* mmap_sem is held in m_start */
 	walk_page_vma(vma, &smaps_walk);
-	if (vma->vm_flags & VM_LOCKED)
-		mss->pss_locked += mss->pss;
 }
 
 #define SEQ_PUT_DEC(str, val) \
-- 
2.20.1.611.gfbb209baf1-goog

