Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F5DC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEAF2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEAF2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389397AbeG0Lcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:32:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732140AbeG0Lcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:32:46 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CA8F5CB7;
        Fri, 27 Jul 2018 10:11:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alessandro Antenucci <antenucci@korg.it>,
        Bin Liu <b-liu@ti.com>, Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.4 13/23] usb: core: handle hub C_PORT_OVER_CURRENT condition
Date:   Fri, 27 Jul 2018 12:09:14 +0200
Message-Id: <20180727100845.677581822@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727100845.054377089@linuxfoundation.org>
References: <20180727100845.054377089@linuxfoundation.org>
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

From: Bin Liu <b-liu@ti.com>

commit 249a32b7eeb3edb6897dd38f89651a62163ac4ed upstream.

Based on USB2.0 Spec Section 11.12.5,

  "If a hub has per-port power switching and per-port current limiting,
  an over-current on one port may still cause the power on another port
  to fall below specific minimums. In this case, the affected port is
  placed in the Power-Off state and C_PORT_OVER_CURRENT is set for the
  port, but PORT_OVER_CURRENT is not set."

so let's check C_PORT_OVER_CURRENT too for over current condition.

Fixes: 08d1dec6f405 ("usb:hub set hub->change_bits when over-current happens")
Cc: <stable@vger.kernel.org>
Tested-by: Alessandro Antenucci <antenucci@korg.it>
Signed-off-by: Bin Liu <b-liu@ti.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/hub.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1123,10 +1123,14 @@ static void hub_activate(struct usb_hub
 
 		if (!udev || udev->state == USB_STATE_NOTATTACHED) {
 			/* Tell hub_wq to disconnect the device or
-			 * check for a new connection
+			 * check for a new connection or over current condition.
+			 * Based on USB2.0 Spec Section 11.12.5,
+			 * C_PORT_OVER_CURRENT could be set while
+			 * PORT_OVER_CURRENT is not. So check for any of them.
 			 */
 			if (udev || (portstatus & USB_PORT_STAT_CONNECTION) ||
-			    (portstatus & USB_PORT_STAT_OVERCURRENT))
+			    (portstatus & USB_PORT_STAT_OVERCURRENT) ||
+			    (portchange & USB_PORT_STAT_C_OVERCURRENT))
 				set_bit(port1, hub->change_bits);
 
 		} else if (portstatus & USB_PORT_STAT_ENABLE) {


