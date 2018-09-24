Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5476ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8936A208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8936A208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbeIXSTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:19:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbeIXSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:19:37 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 213C9107E;
        Mon, 24 Sep 2018 12:17:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junki Kato <junki.kato.xk@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 093/173] usb: gadget: udc: renesas_usb3: fix maxpacket size of ep0
Date:   Mon, 24 Sep 2018 13:52:07 +0200
Message-Id: <20180924113122.888274643@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit dfe1a51d2a36647f74cbad478801efa7cf394376 upstream.

This patch fixes an issue that maxpacket size of ep0 is incorrect
for SuperSpeed. Otherwise, CDC NCM class with SuperSpeed doesn't
work correctly on this driver because its control read data size
is more than 64 bytes.

Reported-by: Junki Kato <junki.kato.xk@renesas.com>
Fixes: 746bfe63bba3 ("usb: gadget: renesas_usb3: add support for Renesas USB3.0 peripheral controller")
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Junki Kato <junki.kato.xk@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/renesas_usb3.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -788,12 +788,15 @@ static void usb3_irq_epc_int_1_speed(str
 	switch (speed) {
 	case USB_STA_SPEED_SS:
 		usb3->gadget.speed = USB_SPEED_SUPER;
+		usb3->gadget.ep0->maxpacket = USB3_EP0_SS_MAX_PACKET_SIZE;
 		break;
 	case USB_STA_SPEED_HS:
 		usb3->gadget.speed = USB_SPEED_HIGH;
+		usb3->gadget.ep0->maxpacket = USB3_EP0_HSFS_MAX_PACKET_SIZE;
 		break;
 	case USB_STA_SPEED_FS:
 		usb3->gadget.speed = USB_SPEED_FULL;
+		usb3->gadget.ep0->maxpacket = USB3_EP0_HSFS_MAX_PACKET_SIZE;
 		break;
 	default:
 		usb3->gadget.speed = USB_SPEED_UNKNOWN;
@@ -2458,7 +2461,7 @@ static int renesas_usb3_init_ep(struct r
 			/* for control pipe */
 			usb3->gadget.ep0 = &usb3_ep->ep;
 			usb_ep_set_maxpacket_limit(&usb3_ep->ep,
-						USB3_EP0_HSFS_MAX_PACKET_SIZE);
+						USB3_EP0_SS_MAX_PACKET_SIZE);
 			usb3_ep->ep.caps.type_control = true;
 			usb3_ep->ep.caps.dir_in = true;
 			usb3_ep->ep.caps.dir_out = true;


