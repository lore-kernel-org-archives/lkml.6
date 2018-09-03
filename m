Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057CFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD7220869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD7220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeICVOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:14:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbeICVOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:14:19 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7C0FDCF5;
        Mon,  3 Sep 2018 16:53:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 13/80] usb: gadget: r8a66597: Fix a possible sleep-in-atomic-context bugs in r8a66597_queue()
Date:   Mon,  3 Sep 2018 18:48:51 +0200
Message-Id: <20180903164934.687145192@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164934.171677301@linuxfoundation.org>
References: <20180903164934.171677301@linuxfoundation.org>
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

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit f36b507c14c4b6e634463a610294e9cb0065c8ea ]

The driver may sleep in an interrupt handler.
The function call path (from bottom to top) in Linux-4.16.7 is:

[FUNC] r8a66597_queue(GFP_KERNEL)
drivers/usb/gadget/udc/r8a66597-udc.c, 1193:
		r8a66597_queue in get_status
drivers/usb/gadget/udc/r8a66597-udc.c, 1301:
		get_status in setup_packet
drivers/usb/gadget/udc/r8a66597-udc.c, 1381:
		setup_packet in irq_control_stage
drivers/usb/gadget/udc/r8a66597-udc.c, 1508:
		irq_control_stage in r8a66597_irq (interrupt handler)

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool (DSAC-2) and checked by
my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/r8a66597-udc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1193,7 +1193,7 @@ __acquires(r8a66597->lock)
 	r8a66597->ep0_req->length = 2;
 	/* AV: what happens if we get called again before that gets through? */
 	spin_unlock(&r8a66597->lock);
-	r8a66597_queue(r8a66597->gadget.ep0, r8a66597->ep0_req, GFP_KERNEL);
+	r8a66597_queue(r8a66597->gadget.ep0, r8a66597->ep0_req, GFP_ATOMIC);
 	spin_lock(&r8a66597->lock);
 }
 


