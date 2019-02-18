Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B11BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ABD2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbfBRKeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:34:01 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:36233 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfBRKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:34:00 -0500
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Feb 2019 05:33:59 EST
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id F2A2B3C00C6;
        Mon, 18 Feb 2019 11:27:06 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PvFfovczOiIR; Mon, 18 Feb 2019 11:27:00 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id F15533C00C2;
        Mon, 18 Feb 2019 11:26:59 +0100 (CET)
Received: from vmlxhi-095.adit-jv.com (10.72.93.87) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Mon, 18 Feb
 2019 11:26:59 +0100
From:   Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
To:     <mathias.nyman@intel.com>
CC:     <gregkh@linuxfoundation.org>, <yasano@jp.adit-jv.com>,
        <erosca@de.adit-jv.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: host: xhci-rcar: Add XHCI_TRUST_TX_LENGTH quirk
Date:   Mon, 18 Feb 2019 11:26:34 +0100
Message-ID: <20190218102633.11738-1-spapageorgiou@de.adit-jv.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.93.87]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yasushi Asano <yasano@jp.adit-jv.com>

When plugging BUFFALO LUA4-U3-AGT USB3.0 to Gigabit Ethernet LAN
Adapter, warning messages filled up dmesg.

[  101.098287] xhci-hcd ee000000.usb: WARN Successful completion on short TX for slot 1 ep 4: needs XHCI_TRUST_TX_LENGTH quirk?
[  101.117463] xhci-hcd ee000000.usb: WARN Successful completion on short TX for slot 1 ep 4: needs XHCI_TRUST_TX_LENGTH quirk?
[  101.136513] xhci-hcd ee000000.usb: WARN Successful completion on short TX for slot 1 ep 4: needs XHCI_TRUST_TX_LENGTH quirk?

Adding the XHCI_TRUST_TX_LENGTH quirk resolves the issue.

Signed-off-by: Yasushi Asano <yasano@jp.adit-jv.com>
Signed-off-by: Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
---
 drivers/usb/host/xhci-rcar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index a6e463715779..671bce18782c 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -246,6 +246,7 @@ int xhci_rcar_init_quirk(struct usb_hcd *hcd)
 	if (!xhci_rcar_wait_for_pll_active(hcd))
 		return -ETIMEDOUT;
 
+	xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 	return xhci_rcar_download_firmware(hcd);
 }
 
-- 
2.20.1

