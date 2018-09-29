Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724C0C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C3E2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C3E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeI3ESa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51772 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728538AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000Gw-Gr; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006vh-6l; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Chris Metcalf" <cmetcalf@ezchip.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.162543511@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 085/131] tile: drop pte_file()-related helpers
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

commit eb12f4872a3845a8803f689646dea5b92a30aff7 upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Chris Metcalf <cmetcalf@ezchip.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/tile/include/asm/pgtable.h | 11 -----------
 arch/tile/mm/homecache.c        |  4 ----
 2 files changed, 15 deletions(-)

--- a/arch/tile/include/asm/pgtable.h
+++ b/arch/tile/include/asm/pgtable.h
@@ -285,17 +285,6 @@ extern void start_mm_caching(struct mm_s
 extern void check_mm_caching(struct mm_struct *prev, struct mm_struct *next);
 
 /*
- * Support non-linear file mappings (see sys_remap_file_pages).
- * This is defined by CLIENT1 set but CLIENT0 and _PAGE_PRESENT clear, and the
- * file offset in the 32 high bits.
- */
-#define _PAGE_FILE        HV_PTE_CLIENT1
-#define PTE_FILE_MAX_BITS 32
-#define pte_file(pte)     (hv_pte_get_client1(pte) && !hv_pte_get_client0(pte))
-#define pte_to_pgoff(pte) ((pte).val >> 32)
-#define pgoff_to_pte(off) ((pte_t) { (((long long)(off)) << 32) | _PAGE_FILE })
-
-/*
  * Encode and de-code a swap entry (see <linux/swapops.h>).
  * We put the swap file type+offset in the 32 high bits;
  * I believe we can just leave the low bits clear.
--- a/arch/tile/mm/homecache.c
+++ b/arch/tile/mm/homecache.c
@@ -265,10 +265,6 @@ static int pte_to_home(pte_t pte)
 /* Update the home of a PTE if necessary (can also be used for a pgprot_t). */
 pte_t pte_set_home(pte_t pte, int home)
 {
-	/* Check for non-linear file mapping "PTEs" and pass them through. */
-	if (pte_file(pte))
-		return pte;
-
 #if CHIP_HAS_MMIO()
 	/* Check for MMIO mappings and pass them through. */
 	if (hv_pte_get_mode(pte) == HV_PTE_MODE_MMIO)

