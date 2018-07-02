Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061BBC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE3925DE3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE3925DE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeGBNhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:37:16 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:39334 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752345AbeGBNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:35:35 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id 5pbZ1y00z3XaVaC06pbZKW; Mon, 02 Jul 2018 15:35:34 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fZyzN-0001Z3-Py; Mon, 02 Jul 2018 15:35:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fZyzN-0001QT-On; Mon, 02 Jul 2018 15:35:33 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        "David S . Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/5] net: mac8390: Use standard memcpy_{from,to}io()
Date:   Mon,  2 Jul 2018 15:35:29 +0200
Message-Id: <20180702133532.5412-3-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702133532.5412-1-geert@linux-m68k.org>
References: <20180702133532.5412-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mac8390 driver defines its own variants of memcpy_fromio() and
memcpy_toio(), using similar implementations, but different function
signatures.

Remove the custom definitions of memcpy_fromio() and memcpy_toio(), and
adjust all callers to the standard signatures.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
This is a dependency for "m68k: Move mem*io define guards to
<asm/kmap.h>".

Untested on real hardware, assembler output compared.
---
 drivers/net/ethernet/8390/mac8390.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/8390/mac8390.c b/drivers/net/ethernet/8390/mac8390.c
index b6d735bf80117e27..342ae08ec3c29832 100644
--- a/drivers/net/ethernet/8390/mac8390.c
+++ b/drivers/net/ethernet/8390/mac8390.c
@@ -153,9 +153,6 @@ static void dayna_block_input(struct net_device *dev, int count,
 static void dayna_block_output(struct net_device *dev, int count,
 			       const unsigned char *buf, int start_page);
 
-#define memcpy_fromio(a, b, c)	memcpy((a), (void *)(b), (c))
-#define memcpy_toio(a, b, c)	memcpy((void *)(a), (b), (c))
-
 #define memcmp_withio(a, b, c)	memcmp((a), (void *)(b), (c))
 
 /* Slow Sane (16-bit chunk memory read/write) Cabletron uses this */
@@ -239,7 +236,7 @@ static enum mac8390_access mac8390_testio(unsigned long membase)
 	unsigned long outdata = 0xA5A0B5B0;
 	unsigned long indata =  0x00000000;
 	/* Try writing 32 bits */
-	memcpy_toio(membase, &outdata, 4);
+	memcpy_toio((void __iomem *)membase, &outdata, 4);
 	/* Now compare them */
 	if (memcmp_withio(&outdata, membase, 4) == 0)
 		return ACCESS_32;
@@ -711,7 +708,7 @@ static void sane_get_8390_hdr(struct net_device *dev,
 			      struct e8390_pkt_hdr *hdr, int ring_page)
 {
 	unsigned long hdr_start = (ring_page - WD_START_PG)<<8;
-	memcpy_fromio(hdr, dev->mem_start + hdr_start, 4);
+	memcpy_fromio(hdr, (void __iomem *)dev->mem_start + hdr_start, 4);
 	/* Fix endianness */
 	hdr->count = swab16(hdr->count);
 }
@@ -725,13 +722,16 @@ static void sane_block_input(struct net_device *dev, int count,
 	if (xfer_start + count > ei_status.rmem_end) {
 		/* We must wrap the input move. */
 		int semi_count = ei_status.rmem_end - xfer_start;
-		memcpy_fromio(skb->data, dev->mem_start + xfer_base,
+		memcpy_fromio(skb->data,
+			      (void __iomem *)dev->mem_start + xfer_base,
 			      semi_count);
 		count -= semi_count;
-		memcpy_fromio(skb->data + semi_count, ei_status.rmem_start,
-			      count);
+		memcpy_fromio(skb->data + semi_count,
+			      (void __iomem *)ei_status.rmem_start, count);
 	} else {
-		memcpy_fromio(skb->data, dev->mem_start + xfer_base, count);
+		memcpy_fromio(skb->data,
+			      (void __iomem *)dev->mem_start + xfer_base,
+			      count);
 	}
 }
 
@@ -740,7 +740,7 @@ static void sane_block_output(struct net_device *dev, int count,
 {
 	long shmem = (start_page - WD_START_PG)<<8;
 
-	memcpy_toio(dev->mem_start + shmem, buf, count);
+	memcpy_toio((void __iomem *)dev->mem_start + shmem, buf, count);
 }
 
 /* dayna block input/output */
-- 
2.17.1

