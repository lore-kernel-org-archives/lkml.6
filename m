Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5DDC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD5320868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD5320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeKYJGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 04:06:45 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:43982 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeKYJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 04:06:44 -0500
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 9653E200D4;
        Sun, 25 Nov 2018 00:17:14 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 5/5] USB: omap_udc: fix rejection of out transfers when DMA is used
Date:   Sun, 25 Nov 2018 00:17:08 +0200
Message-Id: <20181124221708.31003-6-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181124221708.31003-1-aaro.koskinen@iki.fi>
References: <20181124221708.31003-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 387f869d2579 ("usb: gadget: u_ether: conditionally align
transfer size") started aligning transfer size only if requested,
breaking omap_udc DMA mode. Set quirk_ep_out_aligned_size to restore
the old behaviour.

Fixes: 387f869d2579 ("usb: gadget: u_ether: conditionally align transfer size")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/gadget/udc/omap_udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 9b23e04c8f02..fcf13ef33b31 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2642,6 +2642,7 @@ omap_udc_setup(struct platform_device *odev, struct usb_phy *xceiv)
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 	udc->gadget.max_speed = USB_SPEED_FULL;
 	udc->gadget.name = driver_name;
+	udc->gadget.quirk_ep_out_aligned_size = 1;
 	udc->transceiver = xceiv;
 
 	/* ep0 is special; put it right after the SETUP buffer */
-- 
2.17.0

