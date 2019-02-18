Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527B6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B172217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfBRUV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:21:56 -0500
Received: from gateway30.websitewelcome.com ([192.185.150.24]:42293 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728434AbfBRUV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:21:56 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id E911F3B2D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 14:21:54 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id vpQIgrV2g4FKpvpQIgB16v; Mon, 18 Feb 2019 14:21:54 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=47442 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gvpQI-001GOQ-5O; Mon, 18 Feb 2019 14:21:54 -0600
Date:   Mon, 18 Feb 2019 14:21:53 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] usb: wusbcore: wa-xfer: use struct_size() helper
Message-ID: <20190218202153.GA21376@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gvpQI-001GOQ-5O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:47442
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, change the following form:

sizeof(*packet_desc) + (sizeof(packet_desc->PacketLength[0]) * seg->isoc_frame_count)

to :

struct_size(packet_status, PacketStatus, seg->isoc_frame_count);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/wusbcore/wa-xfer.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/wusbcore/wa-xfer.c b/drivers/usb/wusbcore/wa-xfer.c
index 01f2f21830c0..abf88cea37bb 100644
--- a/drivers/usb/wusbcore/wa-xfer.c
+++ b/drivers/usb/wusbcore/wa-xfer.c
@@ -662,9 +662,9 @@ static void __wa_setup_isoc_packet_descr(
 
 	/* populate isoc packet descriptor. */
 	packet_desc->bPacketType = WA_XFER_ISO_PACKET_INFO;
-	packet_desc->wLength = cpu_to_le16(sizeof(*packet_desc) +
-		(sizeof(packet_desc->PacketLength[0]) *
-			seg->isoc_frame_count));
+	packet_desc->wLength = cpu_to_le16(struct_size(packet_desc,
+					   PacketLength,
+					   seg->isoc_frame_count));
 	for (frame_index = 0; frame_index < seg->isoc_frame_count;
 		++frame_index) {
 		int offset_index = frame_index + seg->isoc_frame_offset;
@@ -2438,7 +2438,7 @@ static int wa_process_iso_packet_status(struct wahc *wa, struct urb *urb)
 	struct wa_rpipe *rpipe;
 	unsigned done = 0, dti_busy = 0, data_frame_count = 0, seg_index;
 	unsigned first_frame_index = 0, rpipe_ready = 0;
-	int expected_size;
+	size_t expected_size;
 
 	/* We have a xfer result buffer; check it */
 	dev_dbg(dev, "DTI: isoc packet status %d bytes at %p\n",
@@ -2460,11 +2460,10 @@ static int wa_process_iso_packet_status(struct wahc *wa, struct urb *urb)
 		goto error_bad_seg;
 	seg = xfer->seg[wa->dti_isoc_xfer_seg];
 	rpipe = xfer->ep->hcpriv;
-	expected_size = sizeof(*packet_status) +
-			(sizeof(packet_status->PacketStatus[0]) *
-			seg->isoc_frame_count);
+	expected_size = struct_size(packet_status, PacketStatus,
+				    seg->isoc_frame_count);
 	if (urb->actual_length != expected_size) {
-		dev_err(dev, "DTI Error: isoc packet status--bad urb length (%d bytes vs %d needed)\n",
+		dev_err(dev, "DTI Error: isoc packet status--bad urb length (%d bytes vs %zu needed)\n",
 			urb->actual_length, expected_size);
 		goto error_bad_seg;
 	}
-- 
2.20.1

