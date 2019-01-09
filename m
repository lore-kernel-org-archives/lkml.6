Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2212C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00D220685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfAIRMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:12:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:36066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbfAIRMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:12:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70E9AAF58;
        Wed,  9 Jan 2019 17:12:23 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: jazz: fix 64bit build
Date:   Wed,  9 Jan 2019 18:12:16 +0100
Message-Id: <20190109171216.19992-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

64bit JAZZ builds failed with

linux-next/arch/mips/jazz/jazzdma.c: In function ‘vdma_init’:
/linux-next/arch/mips/jazz/jazzdma.c:77:30: error: implicit declaration of function ‘KSEG1ADDR’; did you mean ‘CKSEG1ADDR’? [-Werror=implicit-function-declaration]
  pgtbl = (VDMA_PGTBL_ENTRY *)KSEG1ADDR(pgtbl);
                              ^~~~~~~~~
                              CKSEG1ADDR
/linux-next/arch/mips/jazz/jazzdma.c:77:10: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  pgtbl = (VDMA_PGTBL_ENTRY *)KSEG1ADDR(pgtbl);
          ^
In file included from /linux-next/arch/mips/include/asm/barrier.h:11:0,
                 from /linux-next/include/linux/compiler.h:248,
                 from /linux-next/include/linux/kernel.h:10,
                 from /linux-next/arch/mips/jazz/jazzdma.c:11:
/linux-next/arch/mips/include/asm/addrspace.h:41:29: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
 #define _ACAST32_  (_ATYPE_)(_ATYPE32_) /* widen if necessary */
                             ^
/linux-next/arch/mips/include/asm/addrspace.h:53:25: note: in expansion of macro ‘_ACAST32_’
 #define CPHYSADDR(a)  ((_ACAST32_(a)) & 0x1fffffff)
                         ^~~~~~~~~
/linux-next/arch/mips/jazz/jazzdma.c:84:44: note: in expansion of macro ‘CPHYSADDR’
  r4030_write_reg32(JAZZ_R4030_TRSTBL_BASE, CPHYSADDR(pgtbl));

Using correct casts and CKSEG1ADDR when dealing with the pgtbl setup
fixes this.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/jazz/jazzdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index 6256d35dbf4d..bedb5047aff3 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -74,14 +74,15 @@ static int __init vdma_init(void)
 						    get_order(VDMA_PGTBL_SIZE));
 	BUG_ON(!pgtbl);
 	dma_cache_wback_inv((unsigned long)pgtbl, VDMA_PGTBL_SIZE);
-	pgtbl = (VDMA_PGTBL_ENTRY *)KSEG1ADDR(pgtbl);
+	pgtbl = (VDMA_PGTBL_ENTRY *)CKSEG1ADDR((unsigned long)pgtbl);
 
 	/*
 	 * Clear the R4030 translation table
 	 */
 	vdma_pgtbl_init();
 
-	r4030_write_reg32(JAZZ_R4030_TRSTBL_BASE, CPHYSADDR(pgtbl));
+	r4030_write_reg32(JAZZ_R4030_TRSTBL_BASE,
+			  CPHYSADDR((unsigned long)pgtbl));
 	r4030_write_reg32(JAZZ_R4030_TRSTBL_LIM, VDMA_PGTBL_SIZE);
 	r4030_write_reg32(JAZZ_R4030_TRSTBL_INV, 0);
 
-- 
2.13.7

