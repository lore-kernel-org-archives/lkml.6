Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DC6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA182080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA182080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbeKLGES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:04:18 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52904 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726816AbeKLGER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:04:17 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvss-0000l8-6K; Sun, 11 Nov 2018 19:59:02 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001gC-Hn; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Mikulas Patocka" <mpatocka@redhat.com>,
        "Dave Airlie" <airlied@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.954890705@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 230/366] drm/udl: fix display corruption of the last line
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 99ec9e77511dea55d81729fc80b6c63a61bfa8e0 upstream.

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
Signed-off-by: Dave Airlie <airlied@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/udl/udl_fb.c       |  5 ++++-
 drivers/gpu/drm/udl/udl_transfer.c | 11 +++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -234,7 +234,10 @@ int udl_handle_damage(struct udl_framebu
 
 	if (cmd > (char *) urb->transfer_buffer) {
 		/* Send partial buffer remaining before exiting */
-		int len = cmd - (char *) urb->transfer_buffer;
+		int len;
+		if (cmd < (char *) urb->transfer_buffer + urb->transfer_buffer_length)
+			*cmd++ = 0xAF;
+		len = cmd - (char *) urb->transfer_buffer;
 		ret = udl_submit_urb(dev, urb, len);
 		bytes_sent += len;
 	} else
--- a/drivers/gpu/drm/udl/udl_transfer.c
+++ b/drivers/gpu/drm/udl/udl_transfer.c
@@ -149,11 +149,11 @@ static void udl_compress_hline16(
 		raw_pixels_count_byte = cmd++; /*  we'll know this later */
 		raw_pixel_start = pixel;
 
-		cmd_pixel_end = pixel + (min(MAX_CMD_PIXELS + 1,
-			min((int)(pixel_end - pixel) / bpp,
-			    (int)(cmd_buffer_end - cmd) / 2))) * bpp;
+		cmd_pixel_end = pixel + min3(MAX_CMD_PIXELS + 1UL,
+					(unsigned long)(pixel_end - pixel) / bpp,
+					(unsigned long)(cmd_buffer_end - 1 - cmd) / 2) * bpp;
 
-		prefetch_range((void *) pixel, (cmd_pixel_end - pixel) * bpp);
+		prefetch_range((void *) pixel, cmd_pixel_end - pixel);
 
 		while (pixel < cmd_pixel_end) {
 			const u8 *const start = pixel;
@@ -193,6 +193,9 @@ static void udl_compress_hline16(
 		if (pixel > raw_pixel_start) {
 			/* finalize last RAW span */
 			*raw_pixels_count_byte = ((pixel-raw_pixel_start) / bpp) & 0xFF;
+		} else {
+			/* undo unused byte */
+			cmd--;
 		}
 
 		*cmd_pixels_count_byte = ((pixel - cmd_pixel_start) / bpp) & 0xFF;

