Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753597AbeFDHVV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753291AbeFDHCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:02:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 49/52] powerpc/mm/slice: Remove intermediate bitmap copy
Date: Mon,  4 Jun 2018 08:58:44 +0200
Message-Id: <20180604065608.565231214@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 326691ad4f179e6edc7eb1271e618dd673e4736d upstream.

bitmap_or() and bitmap_andnot() can work properly with dst identical
to src1 or src2. There is no need of an intermediate result bitmap
that is copied back to dst in a second step.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/slice.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -379,21 +379,17 @@ static unsigned long slice_find_area(str
 
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
