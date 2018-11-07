Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAD9C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9228F20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9228F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbeKHDKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:10:31 -0500
Received: from ale.deltatee.com ([207.54.116.67]:48330 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbeKHDKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:10:30 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gKRnB-0003U5-I0; Wed, 07 Nov 2018 10:39:02 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gKRnA-0006HQ-Fv; Wed, 07 Nov 2018 10:39:00 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Date:   Wed,  7 Nov 2018 10:38:58 -0700
Message-Id: <20181107173859.24096-2-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181107173859.24096-1-logang@deltatee.com>
References: <20181107173859.24096-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-sh@vger.kernel.org, akpm@linux-foundation.org, sbates@raithlin.com, palmer@sifive.com, aou@eecs.berkeley.edu, hch@lst.de, arnd@arndb.de, logang@deltatee.com, catalin.marinas@arm.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 1/2] mm: Introduce common STRUCT_PAGE_MAX_SHIFT define
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This define is used by arm64 to calculate the size of the vmemmap
region. It is defined as the log2 of the upper bound on the size
of a struct page.

We move it into mm_types.h so it can be defined properly instead of
set and checked with a build bug. This also allows us to use the same
define for riscv.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/memory.h | 9 ---------
 arch/arm64/mm/init.c            | 8 --------
 include/asm-generic/fixmap.h    | 1 +
 include/linux/mm_types.h        | 5 +++++
 4 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..f0a5c9531e8b 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -34,15 +34,6 @@
  */
 #define PCI_IO_SIZE		SZ_16M
 
-/*
- * Log2 of the upper bound of the size of a struct page. Used for sizing
- * the vmemmap region only, does not affect actual memory footprint.
- * We don't use sizeof(struct page) directly since taking its size here
- * requires its definition to be available at this point in the inclusion
- * chain, and it may not be a power of 2 in the first place.
- */
-#define STRUCT_PAGE_MAX_SHIFT	6
-
 /*
  * VMEMMAP_SIZE - allows the whole linear region to be covered by
  *                a struct page array
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9d9582cac6c4..1a3e411a1d08 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -612,14 +612,6 @@ void __init mem_init(void)
 	BUILD_BUG_ON(TASK_SIZE_32			> TASK_SIZE_64);
 #endif
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-	/*
-	 * Make sure we chose the upper bound of sizeof(struct page)
-	 * correctly when sizing the VMEMMAP array.
-	 */
-	BUILD_BUG_ON(sizeof(struct page) > (1 << STRUCT_PAGE_MAX_SHIFT));
-#endif
-
 	if (PAGE_SIZE >= 16384 && get_num_physpages() <= 128) {
 		extern int sysctl_overcommit_memory;
 		/*
diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 827e4d3bbc7a..8cc7b09c1bc7 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -16,6 +16,7 @@
 #define __ASM_GENERIC_FIXMAP_H
 
 #include <linux/bug.h>
+#include <linux/mm_types.h>
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
 #define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ed8f6292a53..2c471a2c43fa 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -206,6 +206,11 @@ struct page {
 #endif
 } _struct_page_alignment;
 
+/*
+ * Used for sizing the vmemmap region on some architectures
+ */
+#define STRUCT_PAGE_MAX_SHIFT	(order_base_2(sizeof(struct page)))
+
 #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
 #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
 
-- 
2.19.0

