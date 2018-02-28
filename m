Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeB1HIA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:08:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750835AbeB1HH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:07:59 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC REBASED 5/5] powerpc/mm/slice: use the dynamic high slice size to limit bitmap operations
In-Reply-To: <5badd882663833576c10b8aafe235fe1e443f119.1518382747.git.christophe.leroy@c-s.fr>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr> <5badd882663833576c10b8aafe235fe1e443f119.1518382747.git.christophe.leroy@c-s.fr>
Date: Wed, 28 Feb 2018 12:37:50 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18022807-0008-0000-0000-000004D5590D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022807-0009-0000-0000-00001E687C11
Message-Id: <87y3jda8xl.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280084
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I also noticed that the slice mask printing use wrong variables now. I
guess this should take care of it

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index fef3f36b0b73..6b3575c39668 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -535,8 +535,6 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * already
 	 */
 	maskp = slice_mask_for_size(mm, psize);
-	slice_print_mask(" good_mask", &good_mask);
-
 	/*
 	 * Here "good" means slices that are already the right page size,
 	 * "compat" means slices that have a compatible page size (i.e.
@@ -569,6 +567,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	{
 		slice_copy_mask(&good_mask, maskp, high_slices);
 	}
+	slice_print_mask(" good_mask", &good_mask);
+	slice_print_mask(" compat_mask", compat_maskp);
 
 	/* First check hint if it's valid or if we have MAP_FIXED */
 	if (addr || fixed) {
@@ -646,7 +646,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 
 	slice_range_to_mask(addr, len, &potential_mask, high_slices);
 	slice_dbg(" found potential area at 0x%lx\n", addr);
-	slice_print_mask(" mask", maskp);
+	slice_print_mask(" mask", &potential_mask);
 
  convert:
 	slice_andnot_mask(&potential_mask, &potential_mask, &good_mask, high_slices);
@@ -836,13 +836,6 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 		return !slice_check_range_fits(mm, &available, addr, len);
 	}
 #endif
-
-#if 0 /* too verbose */
-	slice_dbg("is_hugepage_only_range(mm=%p, addr=%lx, len=%lx)\n",
-		 mm, addr, len);
-	slice_print_mask(" mask", &mask);
-	slice_print_mask(" available", &available);
-#endif
 	return !slice_check_range_fits(mm, maskp, addr, len);
 }
 #endif
