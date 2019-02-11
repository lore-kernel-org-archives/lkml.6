Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B4BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC154222B5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897458;
	bh=PgJ0NIXdBHDgY2kD0hLp5gMNWzTDwWEaS18RGNwr45E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g5lrPnmF3tVNuDjG3DguPIeF63IFU8c/D4iIo8HqZw76vTeJ32tIxpkAaMase1wja
	 chO/uUZIGpzs/SVMVDnJ2Z7qygwuFb2qH8DyKNpYJWISrbNWMH3wf+zeK7m+XEsp00
	 FLNtCuYa0WtAVjrz6UjE1uP3terAGwhBfjc3/Cyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390745AbfBKPER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:04:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389995AbfBKPEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:04:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0615222A7;
        Mon, 11 Feb 2019 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897453;
        bh=PgJ0NIXdBHDgY2kD0hLp5gMNWzTDwWEaS18RGNwr45E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zNVwNvjikWN6frV1UFWYi9ZR4q0WWqR+70vXWQpp51zaww6Zy42iMuYKCqTsUMXVP
         XT2tu6FODJI1H3/hnjA7Ge01UxZULbenpOKxtRB/4jttNLAyTrL8JDVcpO6gUE75pB
         WlbOJXH/sguTIw2EjL7DmZ/GCjKx03BAinZWNlaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 187/205] usb: gadget: udc: net2272: Fix bitwise and boolean operations
Date:   Mon, 11 Feb 2019 15:19:45 +0100
Message-Id: <20190211141840.636244713@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2096,7 +2096,7 @@ static irqreturn_t net2272_irq(int irq,
 #if defined(PLX_PCI_RDK2)
 	/* see if PCI int for us by checking irqstat */
 	intcsr = readl(dev->rdk2.fpga_base_addr + RDK2_IRQSTAT);
-	if (!intcsr & (1 << NET2272_PCI_IRQ)) {
+	if (!(intcsr & (1 << NET2272_PCI_IRQ))) {
 		spin_unlock(&dev->lock);
 		return IRQ_NONE;
 	}


