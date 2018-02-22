Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932926AbeBVO1Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:27:24 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:29676 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932714AbeBVO1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:27:22 -0500
Message-Id: <455276187b369bf019e91715b7488e86cd932d49.1519305410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 1/6] powerpc/mm/slice: Remove intermediate bitmap copy
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
        aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 22 Feb 2018 15:27:20 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_or() and bitmap_andnot() can work properly with dst identical
to src1 or src2. There is no need of an intermediate result bitmap
that is copied back to dst in a second step.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 v2: New in v2
 v3: patch moved up front of the serie to avoid ephemeral slice_bitmap_copy() function in following patch
 v4: No change
 v5: No change

 arch/powerpc/mm/slice.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 23ec2c5e3b78..98b53d48968f 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -388,21 +388,17 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 
 static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
 {
-	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
-
 	dst->low_slices |= src->low_slices;
-	bitmap_or(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
-	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
+	bitmap_or(dst->high_slices, dst->high_slices, src->high_slices,
+		  SLICE_NUM_HIGH);
 }
 
 static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *src)
 {
-	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
-
 	dst->low_slices &= ~src->low_slices;
 
-	bitmap_andnot(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
-	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
+	bitmap_andnot(dst->high_slices, dst->high_slices, src->high_slices,
+		      SLICE_NUM_HIGH);
 }
 
 #ifdef CONFIG_PPC_64K_PAGES
-- 
2.13.3
