Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7EEC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE155218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548366406;
	bh=mP/dn4P8yO0HgQaHComuchD0LlkJiiCTN1lZ7gtvdKY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PADGedjf5Xy8miRCDvrkkfuDtRbPDTBpOtHIKBm6FajZ8IjeF4X/nkS3GPLUkBEVL
	 n+S09RypXf4xPXywOn8akLzk0kdtL3ZwAy/S6XMHyhcLzAxroxDfcpVf+q6Qu2+A8j
	 dFWdQMCNn7aMp522TpZNF9Vej6MfEn89TB0tQIaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfAXVqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:46:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfAXVqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:46:44 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDD60218B0;
        Thu, 24 Jan 2019 21:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548366404;
        bh=mP/dn4P8yO0HgQaHComuchD0LlkJiiCTN1lZ7gtvdKY=;
        h=From:To:Cc:Subject:Date:From;
        b=vx6dHtqeYzyq6DyEMc4knwVQAleB4Nkm4MV2NnSUjNtum8tSoCd9PNO4JjtS4VPwt
         rtzTJl2jAxidh1wg00UhFh2/p1AAcpFz3xWiQSu2EyE1cf8/J2437VDrp3S0vATkWe
         5B6+1X+7qN7wQUaWoEobMMz1rX2pmrQYmuYvc2Sc=
From:   Shuah Khan <shuah@kernel.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usbip: Fix vhci_urb_enqueue() URB null transfer buffer error path
Date:   Thu, 24 Jan 2019 14:46:42 -0700
Message-Id: <20190124214642.14552-1-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix vhci_urb_enqueue() to print debug msg and return error instead of
failing with BUG_ON.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 drivers/usb/usbip/vhci_hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 1e592ec94ba4..f46ee1fefe02 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -702,8 +702,10 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	}
 	vdev = &vhci_hcd->vdev[portnum-1];
 
-	/* patch to usb_sg_init() is in 2.5.60 */
-	BUG_ON(!urb->transfer_buffer && urb->transfer_buffer_length);
+	if (!urb->transfer_buffer && urb->transfer_buffer_length) {
+		dev_dbg(dev, "Null URB transfer buffer\n");
+		return -EINVAL;
+	}
 
 	spin_lock_irqsave(&vhci->lock, flags);
 
-- 
2.17.1

