Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932371AbeCEQav (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:30:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:9033 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752368AbeCEQ01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:26:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="39349290"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC, PATCH 14/22] mm, khugepaged: Do not collapse pages in encrypted VMAs
Date: Mon,  5 Mar 2018 19:26:02 +0300
Message-Id: <20180305162610.37510-15-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages for encrypted VMAs have to be allocated in a special way:
we would need to propagate down not only desired NUMA node but also
whether the page is encrypted.

It complicates not-so-trivial routine of huge page allocation in
khugepaged even more. I also puts more pressure on page allocator:
we cannot re-use pages allocated for encrypted VMA to collapse
page in unencrypted one or vice versa.

I think for now it worth skipping encrypted VMAs. We can return
to this topic later.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b7e2268dfc9a..601151678414 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -830,6 +830,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma)
 		return false;
 	if (is_vma_temporary_stack(vma))
 		return false;
+	if (vma_is_encrypted(vma))
+		return false;
 	return !(vma->vm_flags & VM_NO_KHUGEPAGED);
 }
 
-- 
2.16.1
