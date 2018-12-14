Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C552C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33696214D9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789363;
	bh=/S3ssEe52RpyDnGd1tiPJ09QRa5Ip+owtH1d2bGhIgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eNhBtSf9yAaC6dVra8+CLth755rPF4mw47rCrhqxycP5h3IRxzlugnVegqoWog6OG
	 +UGYm0sLLdOAXLXlSUx/a/aiT0swxH4s5V1ZeaowatqRGnZF5eAuCRU04HmVg6wVea
	 Jc/dNGfdubljhRal1+DzTSRIPB9ViX1iogPlsF9Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33696214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbeLNMJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:09:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731093AbeLNMJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F6BC214C4;
        Fri, 14 Dec 2018 12:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789356;
        bh=/S3ssEe52RpyDnGd1tiPJ09QRa5Ip+owtH1d2bGhIgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jodhiOwNjr7KIeszENgn6+SeV7d7unqLC7gKwXy9HDbO2ECZL546U2wssJH6DJBU7
         seFRK3e/RyfG7nXWOAfsgO5PicBcbczRGs6EAn2071g+cpe69VH9GeXYgGFB3zRFiL
         J/w8bznEWq9k2rngEI5A+vG6VBLedierG3YXTPPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 51/89] USB: omap_udc: fix rejection of out transfers when DMA is used
Date:   Fri, 14 Dec 2018 13:00:04 +0100
Message-Id: <20181214115732.199524433@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

[ Upstream commit 069caf5950dfa75d0526cd89c439ff9d9d3136d8 ]

Commit 387f869d2579 ("usb: gadget: u_ether: conditionally align
transfer size") started aligning transfer size only if requested,
breaking omap_udc DMA mode. Set quirk_ep_out_aligned_size to restore
the old behaviour.

Fixes: 387f869d2579 ("usb: gadget: u_ether: conditionally align transfer size")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/omap_udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index c8facc8aa87e..ee0b87a0773c 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2661,6 +2661,7 @@ omap_udc_setup(struct platform_device *odev, struct usb_phy *xceiv)
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 	udc->gadget.max_speed = USB_SPEED_FULL;
 	udc->gadget.name = driver_name;
+	udc->gadget.quirk_ep_out_aligned_size = 1;
 	udc->transceiver = xceiv;
 
 	/* ep0 is special; put it right after the SETUP buffer */
-- 
2.19.1



