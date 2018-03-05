Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeCEQ2W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:28:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:31637 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752623AbeCEQ0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:26:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="180031741"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC, PATCH 12/22] mm: Do no merge vma with different encryption KeyIDs
Date: Mon,  5 Mar 2018 19:26:00 +0300
Message-Id: <20180305162610.37510-13-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMAs with different KeyID do not mix together. Only VMAs with the same
KeyID are compatible.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/mm.h | 7 +++++++
 mm/mmap.c          | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc7b32d0189b..7a4285f09c99 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1486,6 +1486,13 @@ static inline bool vma_is_encrypted(struct vm_area_struct *vma)
 }
 #endif
 
+#ifndef vma_keyid
+static inline int vma_keyid(struct vm_area_struct *vma)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/mm/mmap.c b/mm/mmap.c
index 9efdc021ad22..fa218d1c6bfa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1208,7 +1208,8 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
 		mpol_equal(vma_policy(a), vma_policy(b)) &&
 		a->vm_file == b->vm_file &&
 		!((a->vm_flags ^ b->vm_flags) & ~(VM_READ|VM_WRITE|VM_EXEC|VM_SOFTDIRTY)) &&
-		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
+		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT) &&
+		vma_keyid(a) == vma_keyid(b);
 }
 
 /*
-- 
2.16.1
