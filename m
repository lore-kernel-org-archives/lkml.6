Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 67288C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BE2208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BE2208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934240AbeFLOj1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:39:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:64427 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933408AbeFLOjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:39:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 07:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,215,1526367600"; 
   d="scan'208";a="231956830"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 12 Jun 2018 07:39:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 8E21EF5; Tue, 12 Jun 2018 17:39:20 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 02/17] mm/khugepaged: Do not collapse pages in encrypted VMAs
Date:   Tue, 12 Jun 2018 17:39:00 +0300
Message-Id: <20180612143915.68065-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages for encrypted VMAs have to be allocated in a special way:
we would need to propagate down not only desired NUMA node but also
whether the page is encrypted.

It complicates not-so-trivial routine of huge page allocation in
khugepaged even more. It also puts more pressure on page allocator:
we cannot re-use pages allocated for encrypted VMA to collapse
page in unencrypted one or vice versa.

I think for now it worth skipping encrypted VMAs. We can return
to this topic later.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/mm.h | 7 +++++++
 mm/khugepaged.c    | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1c3c15f37ed6..435b053c457c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1492,6 +1492,13 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
 	return !vma->vm_ops;
 }
 
+#ifndef vma_is_encrypted
+static inline bool vma_is_encrypted(struct vm_area_struct *vma)
+{
+	return false;
+}
+#endif
+
 #ifndef vma_keyid
 static inline int vma_keyid(struct vm_area_struct *vma)
 {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d7b2a4bf8671..a03b40bef033 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -835,6 +835,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma)
 		return false;
 	if (is_vma_temporary_stack(vma))
 		return false;
+	if (vma_is_encrypted(vma))
+		return false;
 	return !(vma->vm_flags & VM_NO_KHUGEPAGED);
 }
 
-- 
2.17.1

