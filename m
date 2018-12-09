Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5EBC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A29F20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A29F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeLIWIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:08:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37288 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbeLIWID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:08:03 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73N-0002ir-VC; Sun, 09 Dec 2018 21:55:58 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003Gq-5r; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        "Mikulas Patocka" <mpatocka@redhat.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.100654295@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 059/328] udlfb: fix display corruption of the last line
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

From: Mikulas Patocka <mpatocka@redhat.com>

commit 4e705e17ce3409a1f492cfd5dadcf6a4f6075842 upstream.

The displaylink hardware has such a peculiarity that it doesn't render a
command until next command is received. This produces occasional
corruption, such as when setting 22x11 font on the console, only the first
line of the cursor will be blinking if the cursor is located at some
specific columns.

When we end up with a repeating pixel, the driver has a bug that it leaves
one uninitialized byte after the command (and this byte is enough to flush
the command and render it - thus it fixes the screen corruption), however
whe we end up with a non-repeating pixel, there is no byte appended and
this results in temporary screen corruption.

This patch fixes the screen corruption by always appending a byte 0xAF at
the end of URB. It also removes the uninitialized byte.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[bwh: Backported to 3.16:
 - Pointers to struct dlfb_data are named "dev" rather than "dlfb"
 - s/BPP/bpp/
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/udlfb.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include <linux/delay.h>
+#include <asm/unaligned.h>
 #include <video/udlfb.h>
 #include "edid.h"
 
@@ -453,17 +454,17 @@ static void dlfb_compress_hline(
 		raw_pixels_count_byte = cmd++; /*  we'll know this later */
 		raw_pixel_start = pixel;
 
-		cmd_pixel_end = pixel + min(MAX_CMD_PIXELS + 1,
-			min((int)(pixel_end - pixel),
-			    (int)(cmd_buffer_end - cmd) / bpp));
+		cmd_pixel_end = pixel + min3(MAX_CMD_PIXELS + 1UL,
+					(unsigned long)(pixel_end - pixel),
+					(unsigned long)(cmd_buffer_end - 1 - cmd) / bpp);
 
-		prefetch_range((void *) pixel, (cmd_pixel_end - pixel) * bpp);
+		prefetch_range((void *) pixel, (u8 *)cmd_pixel_end - (u8 *)pixel);
 
 		while (pixel < cmd_pixel_end) {
 			const uint16_t * const repeating_pixel = pixel;
 
-			*cmd++ = *pixel >> 8;
-			*cmd++ = *pixel;
+			put_unaligned_be16(*pixel, cmd);
+			cmd += 2;
 			pixel++;
 
 			if (unlikely((pixel < cmd_pixel_end) &&
@@ -489,13 +490,16 @@ static void dlfb_compress_hline(
 		if (pixel > raw_pixel_start) {
 			/* finalize last RAW span */
 			*raw_pixels_count_byte = (pixel-raw_pixel_start) & 0xFF;
+		} else {
+			/* undo unused byte */
+			cmd--;
 		}
 
 		*cmd_pixels_count_byte = (pixel - cmd_pixel_start) & 0xFF;
-		dev_addr += (pixel - cmd_pixel_start) * bpp;
+		dev_addr += (u8 *)pixel - (u8 *)cmd_pixel_start;
 	}
 
-	if (cmd_buffer_end <= MIN_RLX_CMD_BYTES + cmd) {
+	if (cmd_buffer_end - MIN_RLX_CMD_BYTES <= cmd) {
 		/* Fill leftover bytes with no-ops */
 		if (cmd_buffer_end > cmd)
 			memset(cmd, 0xAF, cmd_buffer_end - cmd);
@@ -615,8 +619,11 @@ static int dlfb_handle_damage(struct dlf
 	}
 
 	if (cmd > (char *) urb->transfer_buffer) {
+		int len;
+		if (cmd < (char *) urb->transfer_buffer + urb->transfer_buffer_length)
+			*cmd++ = 0xAF;
 		/* Send partial buffer remaining before exiting */
-		int len = cmd - (char *) urb->transfer_buffer;
+		len = cmd - (char *) urb->transfer_buffer;
 		ret = dlfb_submit_urb(dev, urb, len);
 		bytes_sent += len;
 	} else
@@ -740,8 +747,11 @@ static void dlfb_dpy_deferred_io(struct
 	}
 
 	if (cmd > (char *) urb->transfer_buffer) {
+		int len;
+		if (cmd < (char *) urb->transfer_buffer + urb->transfer_buffer_length)
+			*cmd++ = 0xAF;
 		/* Send partial buffer remaining before exiting */
-		int len = cmd - (char *) urb->transfer_buffer;
+		len = cmd - (char *) urb->transfer_buffer;
 		dlfb_submit_urb(dev, urb, len);
 		bytes_sent += len;
 	} else

