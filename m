Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CD185C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F3A208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtdK2QQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F3A208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965262AbeFNOIb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965247AbeFNOI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:08:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9699B208DA;
        Thu, 14 Jun 2018 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985306;
        bh=hY9YlyKLBYBZfov/lwlfYrkBNq+IYXDixgQl3Q3WI3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HtdK2QQAflTC8jZhcpgm2cJlvYg/tQ9kxGpsJIhWqCkRKRxpfA7VSgAFJg4gSfxQa
         8sPHAMbZOkItnunOMP6YxIb4WQyQEBcDN3gVxa4OT6LkQ2jdUSxGIg7PhkY9lir9fr
         YdE8Atbi3rBxk0JEYIj3Ib+FO+y6rQG7vhzVHbXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.16 24/43] usb: gadget: udc: renesas_usb3: disable the controllers irqs for reconnecting
Date:   Thu, 14 Jun 2018 16:04:28 +0200
Message-Id: <20180614132136.774003907@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132135.111973468@linuxfoundation.org>
References: <20180614132135.111973468@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit bd6bce004d78b867ba0c6d3712f1c5b50398af9a upstream.

This patch fixes an issue that reconnection is possible to fail
because unexpected state handling happens by the irqs. To fix the issue,
the driver disables the controller's irqs when disconnected.

Fixes: 746bfe63bba3 ("usb: gadget: renesas_usb3: add support for Renesas USB3.0 peripheral controller")
Cc: <stable@vger.kernel.org> # v4.5+
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/renesas_usb3.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -623,6 +623,13 @@ static void usb3_disconnect(struct renes
 	usb3_usb2_pullup(usb3, 0);
 	usb3_clear_bit(usb3, USB30_CON_B3_CONNECT, USB3_USB30_CON);
 	usb3_reset_epc(usb3);
+	usb3_disable_irq_1(usb3, USB_INT_1_B2_RSUM | USB_INT_1_B3_PLLWKUP |
+			   USB_INT_1_B3_LUPSUCS | USB_INT_1_B3_DISABLE |
+			   USB_INT_1_SPEED | USB_INT_1_B3_WRMRST |
+			   USB_INT_1_B3_HOTRST | USB_INT_1_B2_SPND |
+			   USB_INT_1_B2_L1SPND | USB_INT_1_B2_USBRST);
+	usb3_clear_bit(usb3, USB_COM_CON_SPD_MODE, USB3_USB_COM_CON);
+	usb3_init_epc_registers(usb3);
 
 	if (usb3->driver)
 		usb3->driver->disconnect(&usb3->gadget);


