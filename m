Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7364EC6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EFD20865
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EFD20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJMIpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 04:45:10 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47148 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeJMIpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 04:45:10 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 795A329FC4; Fri, 12 Oct 2018 21:10:06 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <17b745712a31927fda2d5d93571884122d7c4727.1539391675.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k: Unroll raw_outsb() loop
Date:   Sat, 13 Oct 2018 11:47:55 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unroll the raw_outsb() loop using the optimized assembler code from
raw_outsw(). That code is copied and pasted, with movew changed to moveb.

This improves the performance of sequential write transfers using mac_esp
in PIO mode by 5% or 10%. (The DMA controller on the 840av/660av models is
still unsupported so PIO transfers are used.)

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
In a separate patch series, mac_esp adopts writesb() in place of inline
assembler, making that code smaller and more reusable.
---
 arch/m68k/include/asm/raw_io.h | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/raw_io.h b/arch/m68k/include/asm/raw_io.h
index 85761255dde5..8a6dc6e5a279 100644
--- a/arch/m68k/include/asm/raw_io.h
+++ b/arch/m68k/include/asm/raw_io.h
@@ -107,12 +107,43 @@ static inline void raw_insb(volatile u8 __iomem *port, u8 *buf, unsigned int len
 }
 
 static inline void raw_outsb(volatile u8 __iomem *port, const u8 *buf,
-			     unsigned int len)
+			     unsigned int nr)
 {
-	unsigned int i;
+	unsigned int tmp;
 
-        for (i = 0; i < len; i++)
-		out_8(port, *buf++);
+	if (nr & 15) {
+		tmp = (nr & 15) - 1;
+		asm volatile (
+			"1: moveb %0@+,%2@; dbra %1,1b"
+			: "=a" (buf), "=d" (tmp)
+			: "a" (port), "0" (buf),
+			  "1" (tmp));
+	}
+	if (nr >> 4) {
+		tmp = (nr >> 4) - 1;
+		asm volatile (
+			"1: "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"moveb %0@+,%2@; "
+			"dbra %1,1b"
+			: "=a" (buf), "=d" (tmp)
+			: "a" (port), "0" (buf),
+			  "1" (tmp));
+	}
 }
 
 static inline void raw_insw(volatile u16 __iomem *port, u16 *buf, unsigned int nr)
-- 
2.16.4

