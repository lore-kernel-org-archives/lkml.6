Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3928EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09A521901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499083;
	bh=OqMowmmWgcMZXzXMf+US2qEqc06PAHgFXJ37/t0RQcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zm340ViLVM/H8UqH7KUNFhoGE5Z3o00piqlLWSoec4UnezFy/aM9/nb6DRimQNNZQ
	 gs8QkZ7zi7ka51ddprLsBNxwq2kXUs+CZgY37amPKZGe1EfvSkU8felUgCD6TZEu+L
	 XIYD3PRUhVVDgI030kXIxqVzUna8qNmc99a3AR/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391698AbfBROLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:11:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390535AbfBROLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:11:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B70FA217D7;
        Mon, 18 Feb 2019 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499075;
        bh=OqMowmmWgcMZXzXMf+US2qEqc06PAHgFXJ37/t0RQcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJK50ADP9l3m2ILVVBtSAVV3TO2n4FpQozb6kka7ASLtyiUgV55Cdi8LfwWF1ISPF
         yyIWYntrQ/C4Tch8A3xpQPNcMWNmFg8Ttrre1PrnSb5CLjYPwQwztphojFquGNHfUA
         2V2al/fcLPQWdcI8h7SFWdYLyHe32Sl98Wb99Xrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 3.18 068/108] usb: gadget: udc: net2272: Fix bitwise and boolean operations
Date:   Mon, 18 Feb 2019 14:44:04 +0100
Message-Id: <20190218133522.673292137@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 07c69f1148da7de3978686d3af9263325d9d60bd upstream.

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
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/net2272.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2072,7 +2072,7 @@ static irqreturn_t net2272_irq(int irq,
 #if defined(PLX_PCI_RDK2)
 	/* see if PCI int for us by checking irqstat */
 	intcsr = readl(dev->rdk2.fpga_base_addr + RDK2_IRQSTAT);
-	if (!intcsr & (1 << NET2272_PCI_IRQ)) {
+	if (!(intcsr & (1 << NET2272_PCI_IRQ))) {
 		spin_unlock(&dev->lock);
 		return IRQ_NONE;
 	}


