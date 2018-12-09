Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4F9C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADEC20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADEC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeLIWEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:04:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36824 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726685AbeLIWEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:04:43 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73O-0002pp-KF; Sun, 09 Dec 2018 21:55:58 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003Gg-35; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ladislav Michl" <ladis@linux-mips.org>,
        "Bernie Thompson" <bernie@plugable.com>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.352734232@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 057/328] video: udlfb: Fix unaligned access
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ladislav Michl <ladis@linux-mips.org>

commit 115e77597efcc94cb1f6cbb7df5cf7ce8feb8632 upstream.

Driver generates lots of alignment trap exceptions on ARM.
Fix that by replacing typecasting of odd addresses with
byte shifting and remove uneccessary typecasting.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Cc: Bernie Thompson <bernie@plugable.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/udlfb.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -443,9 +443,9 @@ static void dlfb_compress_hline(
 
 		*cmd++ = 0xAF;
 		*cmd++ = 0x6B;
-		*cmd++ = (uint8_t) ((dev_addr >> 16) & 0xFF);
-		*cmd++ = (uint8_t) ((dev_addr >> 8) & 0xFF);
-		*cmd++ = (uint8_t) ((dev_addr) & 0xFF);
+		*cmd++ = dev_addr >> 16;
+		*cmd++ = dev_addr >> 8;
+		*cmd++ = dev_addr;
 
 		cmd_pixels_count_byte = cmd++; /*  we'll know this later */
 		cmd_pixel_start = pixel;
@@ -462,8 +462,8 @@ static void dlfb_compress_hline(
 		while (pixel < cmd_pixel_end) {
 			const uint16_t * const repeating_pixel = pixel;
 
-			*(uint16_t *)cmd = cpu_to_be16p(pixel);
-			cmd += 2;
+			*cmd++ = *pixel >> 8;
+			*cmd++ = *pixel;
 			pixel++;
 
 			if (unlikely((pixel < cmd_pixel_end) &&
@@ -1532,15 +1532,16 @@ static int dlfb_parse_vendor_descriptor(
 			u8 length;
 			u16 key;
 
-			key = le16_to_cpu(*((u16 *) desc));
-			desc += sizeof(u16);
-			length = *desc;
-			desc++;
+			key = *desc++;
+			key |= (u16)*desc++ << 8;
+			length = *desc++;
 
 			switch (key) {
 			case 0x0200: { /* max_area */
-				u32 max_area;
-				max_area = le32_to_cpu(*((u32 *)desc));
+				u32 max_area = *desc++;
+				max_area |= (u32)*desc++ << 8;
+				max_area |= (u32)*desc++ << 16;
+				max_area |= (u32)*desc++ << 24;
 				pr_warn("DL chip limited to %d pixel modes\n",
 					max_area);
 				dev->sku_pixel_limit = max_area;

