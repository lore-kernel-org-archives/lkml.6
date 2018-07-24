Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741ADECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366EF20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366EF20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeGXNSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:18:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:17867 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388288AbeGXNRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:17:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 05:11:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,397,1526367600"; 
   d="scan'208";a="59028635"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 24 Jul 2018 05:11:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D0C0C5A; Tue, 24 Jul 2018 15:11:47 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 1/3] mm: Introduce vma_init()
Date:   Tue, 24 Jul 2018 15:11:37 +0300
Message-Id: <20180724121139.62570-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724121139.62570-1-kirill.shutemov@linux.intel.com>
References: <20180724121139.62570-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all VMAs allocated with vm_area_alloc(). Some of them allocated on
stack or in data segment.

The new helper can be use to initialize VMA properly regardless where
it was allocated.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/mm.h | 6 ++++++
 kernel/fork.c      | 6 ++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d3a3842316b8..31540f166987 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -452,6 +452,12 @@ struct vm_operations_struct {
 					  unsigned long addr);
 };
 
+static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
+{
+	vma->vm_mm = mm;
+	INIT_LIST_HEAD(&vma->anon_vma_chain);
+}
+
 struct mmu_gather;
 struct inode;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index a191c05e757d..1b27babc4c78 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -312,10 +312,8 @@ struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
 
-	if (vma) {
-		vma->vm_mm = mm;
-		INIT_LIST_HEAD(&vma->anon_vma_chain);
-	}
+	if (vma)
+		vma_init(vma, mm);
 	return vma;
 }
 
-- 
2.18.0

