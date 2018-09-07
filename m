Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268DDC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0EB20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0EB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbeIHCDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:03:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45230 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbeIHCDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:03:24 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E9137DC4;
        Fri,  7 Sep 2018 21:20:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.18 122/145] udlfb: fix display corruption of the last line
Date:   Fri,  7 Sep 2018 23:09:48 +0200
Message-Id: <20180907210913.132197565@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/udlfb.c |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include <linux/delay.h>
+#include <asm/unaligned.h>
 #include <video/udlfb.h>
 #include "edid.h"
 
@@ -450,17 +451,17 @@ static void dlfb_compress_hline(
 		raw_pixels_count_byte = cmd++; /*  we'll know this later */
 		raw_pixel_start = pixel;
 
-		cmd_pixel_end = pixel + min(MAX_CMD_PIXELS + 1,
-			min((int)(pixel_end - pixel),
-			    (int)(cmd_buffer_end - cmd) / BPP));
+		cmd_pixel_end = pixel + min3(MAX_CMD_PIXELS + 1UL,
+					(unsigned long)(pixel_end - pixel),
+					(unsigned long)(cmd_buffer_end - 1 - cmd) / BPP);
 
-		prefetch_range((void *) pixel, (cmd_pixel_end - pixel) * BPP);
+		prefetch_range((void *) pixel, (u8 *)cmd_pixel_end - (u8 *)pixel);
 
 		while (pixel < cmd_pixel_end) {
 			const uint16_t * const repeating_pixel = pixel;
 
-			*cmd++ = *pixel >> 8;
-			*cmd++ = *pixel;
+			put_unaligned_be16(*pixel, cmd);
+			cmd += 2;
 			pixel++;
 
 			if (unlikely((pixel < cmd_pixel_end) &&
@@ -486,13 +487,16 @@ static void dlfb_compress_hline(
 		if (pixel > raw_pixel_start) {
 			/* finalize last RAW span */
 			*raw_pixels_count_byte = (pixel-raw_pixel_start) & 0xFF;
+		} else {
+			/* undo unused byte */
+			cmd--;
 		}
 
 		*cmd_pixels_count_byte = (pixel - cmd_pixel_start) & 0xFF;
-		dev_addr += (pixel - cmd_pixel_start) * BPP;
+		dev_addr += (u8 *)pixel - (u8 *)cmd_pixel_start;
 	}
 
-	if (cmd_buffer_end <= MIN_RLX_CMD_BYTES + cmd) {
+	if (cmd_buffer_end - MIN_RLX_CMD_BYTES <= cmd) {
 		/* Fill leftover bytes with no-ops */
 		if (cmd_buffer_end > cmd)
 			memset(cmd, 0xAF, cmd_buffer_end - cmd);
@@ -610,8 +614,11 @@ static int dlfb_handle_damage(struct dlf
 	}
 
 	if (cmd > (char *) urb->transfer_buffer) {
+		int len;
+		if (cmd < (char *) urb->transfer_buffer + urb->transfer_buffer_length)
+			*cmd++ = 0xAF;
 		/* Send partial buffer remaining before exiting */
-		int len = cmd - (char *) urb->transfer_buffer;
+		len = cmd - (char *) urb->transfer_buffer;
 		ret = dlfb_submit_urb(dlfb, urb, len);
 		bytes_sent += len;
 	} else
@@ -735,8 +742,11 @@ static void dlfb_dpy_deferred_io(struct
 	}
 
 	if (cmd > (char *) urb->transfer_buffer) {
+		int len;
+		if (cmd < (char *) urb->transfer_buffer + urb->transfer_buffer_length)
+			*cmd++ = 0xAF;
 		/* Send partial buffer remaining before exiting */
-		int len = cmd - (char *) urb->transfer_buffer;
+		len = cmd - (char *) urb->transfer_buffer;
 		dlfb_submit_urb(dlfb, urb, len);
 		bytes_sent += len;
 	} else


