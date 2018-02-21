Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934634AbeBURXh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:23:37 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934244AbeBURXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:23:35 -0500
From: Khalid Aziz <khalid.aziz@oracle.com>
To: akpm@linux-foundation.org, davem@davemloft.net,
        dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, mhocko@suse.com, jack@suse.cz,
        kirill.shutemov@linux.intel.com, ross.zwisler@linux.intel.com,
        willy@infradead.org, hughd@google.com, n-horiguchi@ah.jp.nec.com,
        mgorman@suse.de, jglisse@redhat.com, dave.jiang@intel.com,
        dan.j.williams@intel.com, anthony.yznaga@oracle.com,
        nadav.amit@gmail.com, zi.yan@cs.rutgers.edu, aarcange@redhat.com,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        henry.willard@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>
Subject: [PATCH v12 08/11] mm: Clear arch specific VM flags on protection change
Date: Wed, 21 Feb 2018 10:15:50 -0700
Message-Id: <f0bfc4b7ce6c8563bf0d5ef74af20b5d1edea66f.1519227112.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8811 signatures=668676
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=846
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802210211
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
index ad06d42adb1a..ae806dbc63ee 100644
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
index 088ea9c08678..c1d6af7455da 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -475,7 +475,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		 * cleared from the VMA.
 		 */
 		mask_off_old_flags = VM_READ | VM_WRITE | VM_EXEC |
-					ARCH_VM_PKEY_FLAGS;
+					VM_FLAGS_CLEAR;
 
 		new_vma_pkey = arch_override_mprotect_pkey(vma, prot, pkey);
 		newflags = calc_vm_prot_bits(prot, new_vma_pkey);
-- 
2.11.0
