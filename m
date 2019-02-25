Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDB9C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7352083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131629;
	bh=s74Qn4pTwS2mbvHBtEq8DwCDORBSeXHKeAULa1m/UPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TWcpPfwyobDV5azGxXfQvZy8dSjrQBhOZlO8+83H/YSRyb7Yiv+IuYDDOe5r6rYu5
	 N6o6VFqnwu2wplaN7cbf9wLYKMD8pXF+9w9i7jm/0Edvpr1Gw+W0PRBJrzYVZe5qFe
	 H/FbuVSmOZz9C77oswIatCSH8x+pjs3U8m9OiuLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfBYVxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:53:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730845AbfBYVWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C62EE21871;
        Mon, 25 Feb 2019 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129740;
        bh=s74Qn4pTwS2mbvHBtEq8DwCDORBSeXHKeAULa1m/UPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RbMkUeVaXw2n0v3aR7rDEXiJEJnHxssrkqfe2Byzojbpnus1XND9R18opMcj82q/X
         g4KP+dihebELzDo6xjbxOG54snUBG6kGqmzzRG6rLC4yd8DFpXREb3wFwiY7pEg7UN
         TJtSvhhqf71mjk/+n3Rl0ijomm0LKdd13FzEDgN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 051/152] MIPS: jazz: fix 64bit build
Date:   Mon, 25 Feb 2019 22:10:43 +0100
Message-Id: <20190225195047.145915689@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d31bc2f012088..fb2b6d0b77c36 100644
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



