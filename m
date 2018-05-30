Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbeE3EDC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:03:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750735AbeE3EDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:03:00 -0400
From: Zeng Tao <prime.zeng@hisilicon.com>
To: <hminas@synopsys.com>
CC: Zeng Tao <prime.zeng@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: dwc2: gadget: fix missing process for isoc descriptor dma mode
Date: Wed, 30 May 2018 20:01:15 +0800
Message-ID: <1527681676-44003-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it's the first request to queue, and we are using descriptor dma mode
for isoc transfer, we only need to add the request to the queue, and it
will be processed in the future nak interrupt handler.

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 drivers/usb/dwc2/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index f0d9ccf..48e3a48c 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -1365,6 +1365,9 @@ static int dwc2_hsotg_ep_queue(struct usb_ep *ep, struct usb_request *req,
 			return 0;
 		}
 
+		if (using_desc_dma(hs))
+			return 0;
+
 		/* Update current frame number value. */
 		hs->frame_number = dwc2_hsotg_read_frameno(hs);
 		while (dwc2_gadget_target_frame_elapsed(hs_ep)) {
-- 
2.7.4
