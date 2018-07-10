Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5100DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFD12083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFD12083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbeGJScO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:32:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47446 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732845AbeGJScN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:32:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BCD8DD0B;
        Tue, 10 Jul 2018 18:32:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 4.14 14/53] drm/udl: fix display corruption of the last line
Date:   Tue, 10 Jul 2018 20:24:50 +0200
Message-Id: <20180710182459.720795883@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/udl/udl_fb.c       |    5 ++++-
 drivers/gpu/drm/udl/udl_transfer.c |   11 +++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -137,7 +137,10 @@ int udl_handle_damage(struct udl_framebu
 
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
@@ -153,11 +153,11 @@ static void udl_compress_hline16(
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
 		pixel_val16 = get_pixel_val16(pixel, bpp);
 
 		while (pixel < cmd_pixel_end) {
@@ -193,6 +193,9 @@ static void udl_compress_hline16(
 		if (pixel > raw_pixel_start) {
 			/* finalize last RAW span */
 			*raw_pixels_count_byte = ((pixel-raw_pixel_start) / bpp) & 0xFF;
+		} else {
+			/* undo unused byte */
+			cmd--;
 		}
 
 		*cmd_pixels_count_byte = ((pixel - cmd_pixel_start) / bpp) & 0xFF;


