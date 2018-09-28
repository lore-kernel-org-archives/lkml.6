Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5D4C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E532172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E532172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbeI1PzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:55:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49139 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbeI1PzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:55:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4C25D20703; Fri, 28 Sep 2018 11:32:07 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 24404206D0;
        Fri, 28 Sep 2018 11:32:07 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] MIPS: stop using _PTRS_PER_PGD
Date:   Fri, 28 Sep 2018 11:32:02 +0200
Message-Id: <20180928093202.15426-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 3.3 has been retired for a while, use PTRS_PER_PGD and remove the
asm-offsets.h inclusion.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/mm/init.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 400676ce03f4..15cae0f11880 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -32,7 +32,6 @@
 #include <linux/kcore.h>
 #include <linux/initrd.h>
 
-#include <asm/asm-offsets.h>
 #include <asm/bootinfo.h>
 #include <asm/cachectl.h>
 #include <asm/cpu.h>
@@ -521,17 +520,13 @@ unsigned long pgd_current[NR_CPUS];
 #endif
 
 /*
- * gcc 3.3 and older have trouble determining that PTRS_PER_PGD and PGD_ORDER
- * are constants.  So we use the variants from asm-offset.h until that gcc
- * will officially be retired.
- *
  * Align swapper_pg_dir in to 64K, allows its address to be loaded
  * with a single LUI instruction in the TLB handlers.  If we used
  * __aligned(64K), its size would get rounded up to the alignment
  * size, and waste space.  So we place it in its own section and align
  * it in the linker script.
  */
-pgd_t swapper_pg_dir[_PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
+pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
 #ifndef __PAGETABLE_PUD_FOLDED
 pud_t invalid_pud_table[PTRS_PER_PUD] __page_aligned_bss;
 #endif
-- 
2.19.0

