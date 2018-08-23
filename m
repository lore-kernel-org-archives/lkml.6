Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8D7213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8D7213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeHWLZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:25:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41610 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeHWLZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:25:58 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7E0399D2;
        Thu, 23 Aug 2018 07:57:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gevorg Sahakyan <sahakyan@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        William Wu <william.wu@rock-chips.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 09/79] usb: dwc2: fix isoc split in transfer with no data
Date:   Thu, 23 Aug 2018 09:52:45 +0200
Message-Id: <20180823074919.282188634@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Wu <william.wu@rock-chips.com>

[ Upstream commit 70c3c8cb83856758025c2a211dd022bc0478922a ]

If isoc split in transfer with no data (the length of DATA0
packet is zero), we can't simply return immediately. Because
the DATA0 can be the first transaction or the second transaction
for the isoc split in transaction. If the DATA0 packet with no
data is in the first transaction, we can return immediately.
But if the DATA0 packet with no data is in the second transaction
of isoc split in transaction sequence, we need to increase the
qtd->isoc_frame_index and giveback urb to device driver if needed,
otherwise, the MDATA packet will be lost.

A typical test case is that connect the dwc2 controller with an
usb hs Hub (GL852G-12), and plug an usb fs audio device (Plantronics
headset) into the downstream port of Hub. Then use the usb mic
to record, we can find noise when playback.

In the case, the isoc split in transaction sequence like this:

- SSPLIT IN transaction
- CSPLIT IN transaction
  - MDATA packet (176 bytes)
- CSPLIT IN transaction
  - DATA0 packet (0 byte)

This patch use both the length of DATA0 and qtd->isoc_split_offset
to check if the DATA0 is in the second transaction.

Tested-by: Gevorg Sahakyan <sahakyan@synopsys.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Minas Harutyunyan hminas@synopsys.com>
Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/hcd_intr.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -931,9 +931,8 @@ static int dwc2_xfercomp_isoc_split_in(s
 	frame_desc = &qtd->urb->iso_descs[qtd->isoc_frame_index];
 	len = dwc2_get_actual_xfer_length(hsotg, chan, chnum, qtd,
 					  DWC2_HC_XFER_COMPLETE, NULL);
-	if (!len) {
+	if (!len && !qtd->isoc_split_offset) {
 		qtd->complete_split = 0;
-		qtd->isoc_split_offset = 0;
 		return 0;
 	}
 


