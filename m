Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945A7C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C7A21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfAVV2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:28:11 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.229]:46234 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725971AbfAVV2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:28:11 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 2271A443F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:28:10 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id m3acgvTLm90onm3acgMxdK; Tue, 22 Jan 2019 15:28:10 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=35152 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gm3ab-002LL4-H7; Tue, 22 Jan 2019 15:28:09 -0600
Date:   Tue, 22 Jan 2019 15:28:08 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] usb: gadget: udc: net2272: Fix bitwise and boolean operations
Message-ID: <20190122212808.GA27011@embeddedor>
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
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gm3ab-002LL4-H7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:35152
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(!x & y) strikes again.

Fix bitwise and boolean operations by enclosing the expression:

	intcsr & (1 << NET2272_PCI_IRQ)

in parentheses, before applying the boolean operator '!'.

Notice that this code has been there since 2011. So, it would
be helpful if someone can double-check this.

This issue was detected with the help of Coccinelle.

Fixes: ceb80363b2ec ("USB: net2272: driver for PLX NET2272 USB device controller")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/gadget/udc/net2272.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 660878a19505..b77f3126580e 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2083,7 +2083,7 @@ static irqreturn_t net2272_irq(int irq, void *_dev)
 #if defined(PLX_PCI_RDK2)
 	/* see if PCI int for us by checking irqstat */
 	intcsr = readl(dev->rdk2.fpga_base_addr + RDK2_IRQSTAT);
-	if (!intcsr & (1 << NET2272_PCI_IRQ)) {
+	if (!(intcsr & (1 << NET2272_PCI_IRQ))) {
 		spin_unlock(&dev->lock);
 		return IRQ_NONE;
 	}
-- 
2.20.1

