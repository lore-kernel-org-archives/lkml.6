Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8787C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4B020892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791180;
	bh=m/xhKAo0rVFKvhVuT/kKQPArkV7uebYGGST+W+tYX0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zqm3kVCeMTVmvDmbOEZurIVKmH4BmD4wEcYiv3IXIwtAn2tBBCuDdnuxowfrrQGCX
	 95TH6IQ3eIuPb0orBoY5MSBB3nUepg45fB37XL3vfDjMi2UUPBuW/gMHybwNUbLAIE
	 MR5JmK52tXE7pyWFWiVnjszOYnQSFkvvU0+6ySls=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4B020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeLNMjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:39:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730577AbeLNMEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:04:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A7B1214C4;
        Fri, 14 Dec 2018 12:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789088;
        bh=m/xhKAo0rVFKvhVuT/kKQPArkV7uebYGGST+W+tYX0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sx4Y6OQxwfOKvLOMrqJtdJ5tNqPcSji28cKwbSVRMNQri3jrXAEFKRN/Ef6oN80ZD
         IZ5mr6udH5N6loefEfiPiB5Cwqe8/FlJRp8Jboy5OCA8NNmR0bRTFyh/gqQR1Usqlh
         8dnNgkEChR+lcjzEFlG6Q+4vsUQwpYlxqW3pP1TI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 089/142] USB: omap_udc: fix rejection of out transfers when DMA is used
Date:   Fri, 14 Dec 2018 12:59:34 +0100
Message-Id: <20181214115750.613076910@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
2.19.1



