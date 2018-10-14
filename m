Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C556EC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971AB20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971AB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeJNXT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:19:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36802 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728015AbeJNXT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:19:58 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM9-0004cW-Fs; Sun, 14 Oct 2018 16:31:01 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000Ge-HH; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michael Ellerman" <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.922183139@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 095/366] powerpc/mm/hugetlb: initialize the pagetable
 cache correctly for hugetlb
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

commit 6fa504835d6969144b2bd3699684dd447c789ba2 upstream.

With 64k page size, we have hugetlb pte entries at the pmd and pud level for
book3s64. We don't need to create a separate page table cache for that. With 4k
we need to make sure hugepd page table cache for 16M is placed at PUD level
and 16G at the PGD level.

Simplify all these by not using HUGEPD_PD_SHIFT which is confusing for book3s64.

Without this patch, with 64k page size we create pagetable caches with shift
value 10 and 7 which are not used at all.

Fixes: 419df06eea5b ("powerpc: Reduce the PTE_INDEX_SIZE")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.16: Don't use an #ifdef because this implementation of
 hugetlbpage_init() is only used if CONFIG_PPC_BOOK3S_64 is enabled.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -175,9 +175,6 @@ static int __hugepte_alloc(struct mm_str
 #ifdef CONFIG_PPC_FSL_BOOK3E
 #define HUGEPD_PGD_SHIFT PGDIR_SHIFT
 #define HUGEPD_PUD_SHIFT PUD_SHIFT
-#else
-#define HUGEPD_PGD_SHIFT PUD_SHIFT
-#define HUGEPD_PUD_SHIFT PMD_SHIFT
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -871,15 +868,17 @@ static int __init hugetlbpage_init(void)
 
 		shift = mmu_psize_to_shift(psize);
 
-		if (add_huge_page_size(1ULL << shift) < 0)
+		if (shift > PGDIR_SHIFT)
 			continue;
-
-		if (shift < PMD_SHIFT)
-			pdshift = PMD_SHIFT;
-		else if (shift < PUD_SHIFT)
+		else if (shift > PUD_SHIFT)
+			pdshift = PGDIR_SHIFT;
+		else if (shift > PMD_SHIFT)
 			pdshift = PUD_SHIFT;
 		else
-			pdshift = PGDIR_SHIFT;
+			pdshift = PMD_SHIFT;
+
+		if (add_huge_page_size(1ULL << shift) < 0)
+			continue;
 		/*
 		 * if we have pdshift and shift value same, we don't
 		 * use pgt cache for hugepd.

