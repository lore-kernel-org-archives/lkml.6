Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730E2C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449E8222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025490;
	bh=1z71pzkxzyVS2GESeNK7FKCMwy6xGxN/TGedt9Obyjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EZybZ1tLcvsDPDGoh5jlhLK1JrdsTMKB0srcWbI5dCaqPTdwud95F540JxPhH2Z0q
	 3wsJjIlEI/AMrHAm/YiS31Al4fgZI2JfwFnuEr9H13VAzp1lAN4TJaOP9hgXP8SntO
	 e7/I3nnb+m+sZYXaiMH1oqR2B6ysPUN/E54DacZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbfBMCiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732893AbfBMCiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF77206B6;
        Wed, 13 Feb 2019 02:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025484;
        bh=1z71pzkxzyVS2GESeNK7FKCMwy6xGxN/TGedt9Obyjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvEKM4GBTPUAD/2PUFqTnNwYTauFkuLzq4DfIt68UZgewGaZfjP8Vmd+HmKXxMCt2
         Af9J5iWG4fP1T0qNbaBrga/KldVxvBCvjl7O7yLSoPO5EKPh5U8XUhuVJ7CnMDnEIB
         WK5TKJ6s/sy/XyiPqpp4yrEytJJRDvsvdkOcH6q4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 36/83] MIPS: jazz: fix 64bit build
Date:   Tue, 12 Feb 2019 21:36:14 -0500
Message-Id: <20190213023701.20286-36-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit 41af167fbc0032f9d7562854f58114eaa9270336 ]

64bit JAZZ builds failed with

  linux-next/arch/mips/jazz/jazzdma.c: In function `vdma_init`:
  /linux-next/arch/mips/jazz/jazzdma.c:77:30: error: implicit declaration
    of function `KSEG1ADDR`; did you mean `CKSEG1ADDR`?
    [-Werror=implicit-function-declaration]
    pgtbl = (VDMA_PGTBL_ENTRY *)KSEG1ADDR(pgtbl);
                                ^~~~~~~~~
                                CKSEG1ADDR
  /linux-next/arch/mips/jazz/jazzdma.c:77:10: error: cast to pointer from
    integer of different size [-Werror=int-to-pointer-cast]
    pgtbl = (VDMA_PGTBL_ENTRY *)KSEG1ADDR(pgtbl);
            ^
  In file included from /linux-next/arch/mips/include/asm/barrier.h:11:0,
                   from /linux-next/include/linux/compiler.h:248,
                   from /linux-next/include/linux/kernel.h:10,
                   from /linux-next/arch/mips/jazz/jazzdma.c:11:
  /linux-next/arch/mips/include/asm/addrspace.h:41:29: error: cast from
    pointer to integer of different size [-Werror=pointer-to-int-cast]
   #define _ACAST32_  (_ATYPE_)(_ATYPE32_) /* widen if necessary */
                               ^
  /linux-next/arch/mips/include/asm/addrspace.h:53:25: note: in
    expansion of macro `_ACAST32_`
   #define CPHYSADDR(a)  ((_ACAST32_(a)) & 0x1fffffff)
                           ^~~~~~~~~
  /linux-next/arch/mips/jazz/jazzdma.c:84:44: note: in expansion of
    macro `CPHYSADDR`
    r4030_write_reg32(JAZZ_R4030_TRSTBL_BASE, CPHYSADDR(pgtbl));

Using correct casts and CKSEG1ADDR when dealing with the pgtbl setup
fixes this.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/jazz/jazzdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index d31bc2f01208..fb2b6d0b77c3 100644
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
2.19.1

