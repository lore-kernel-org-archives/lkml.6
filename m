Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeBASFI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:05:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47230 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbeBASCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:02:42 -0500
From: Khalid Aziz <khalid.aziz@oracle.com>
To: akpm@linux-foundation.org, davem@davemloft.net,
        dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, mhocko@suse.com, jack@suse.cz,
        kirill.shutemov@linux.intel.com, ross.zwisler@linux.intel.com,
        willy@infradead.org, hughd@google.com, n-horiguchi@ah.jp.nec.com,
        mgorman@suse.de, jglisse@redhat.com, dave.jiang@intel.com,
        dan.j.williams@intel.com, anthony.yznaga@oracle.com,
        nadav.amit@gmail.com, zi.yan@cs.rutgers.edu, aarcange@redhat.com,
        khandual@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>
Subject: [PATCH v11 08/10] mm: Clear arch specific VM flags on protection change
Date: Thu,  1 Feb 2018 11:01:16 -0700
Message-Id: <c917985f8eacf4647a135df1b223739ef62a5501.1517497017.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1517497017.git.khalid.aziz@oracle.com>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1517497017.git.khalid.aziz@oracle.com>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=854
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010231
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When protection bits are changed on a VMA, some of the architecture
specific flags should be cleared as well. An examples of this are the
PKEY flags on x86. This patch expands the current code that clears
PKEY flags for x86, to support similar functionality for other
architectures as well.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
v7:
	- new patch

 include/linux/mm.h | 6 ++++++
 mm/mprotect.c      | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ea818ff739cd..1931c93fb063 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -287,6 +287,12 @@ extern unsigned int kobjsize(const void *objp);
 /* This mask is used to clear all the VMA flags used by mlock */
 #define VM_LOCKED_CLEAR_MASK	(~(VM_LOCKED | VM_LOCKONFAULT))
 
+/* Arch-specific flags to clear when updating VM flags on protection change */
+#ifndef VM_ARCH_CLEAR
+# define VM_ARCH_CLEAR	VM_NONE
+#endif
+#define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 80243e0166a7..8b24b9fa2f4f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -470,7 +470,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		 * cleared from the VMA.
 		 */
 		mask_off_old_flags = VM_READ | VM_WRITE | VM_EXEC |
-					ARCH_VM_PKEY_FLAGS;
+					VM_FLAGS_CLEAR;
 
 		new_vma_pkey = arch_override_mprotect_pkey(vma, prot, pkey);
 		newflags = calc_vm_prot_bits(prot, new_vma_pkey);
-- 
2.11.0
