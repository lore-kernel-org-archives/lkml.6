Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DFAC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C2F259E3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C2F259E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbeGBNfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:35:47 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:41452 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbeGBNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:35:35 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 5pbZ1y00i3XaVaC01pbZRm; Mon, 02 Jul 2018 15:35:34 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fZyzN-0001Z0-P8; Mon, 02 Jul 2018 15:35:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fZyzN-0001QR-Ny; Mon, 02 Jul 2018 15:35:33 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        "David S . Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/5] m68k/io: Add missing ioremap define guards, fix typo
Date:   Mon,  2 Jul 2018 15:35:28 +0200
Message-Id: <20180702133532.5412-2-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702133532.5412-1-geert@linux-m68k.org>
References: <20180702133532.5412-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Add missing define guard for ioremap_wt(),
  - Fix typo s/ioremap_fillcache/ioremap_fullcache/,
  - Add define guard for iounmap() for consistency with other
    architectures.

Fixes: 9746882f547d2f00 ("m68k: group io mapping definitions and functions")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/kmap.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index 84b8333db8ad1987..bf1026def698f21f 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -16,6 +16,7 @@
  */
 extern void __iomem *__ioremap(unsigned long physaddr, unsigned long size,
 			       int cacheflag);
+#define iounmap iounmap
 extern void iounmap(void __iomem *addr);
 extern void __iounmap(void *addr, unsigned long size);
 
@@ -33,13 +34,14 @@ static inline void __iomem *ioremap_nocache(unsigned long physaddr,
 }
 
 #define ioremap_uc ioremap_nocache
+#define ioremap_wt ioremap_wt
 static inline void __iomem *ioremap_wt(unsigned long physaddr,
 				       unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
 }
 
-#define ioremap_fillcache ioremap_fullcache
+#define ioremap_fullcache ioremap_fullcache
 static inline void __iomem *ioremap_fullcache(unsigned long physaddr,
 					      unsigned long size)
 {
-- 
2.17.1

