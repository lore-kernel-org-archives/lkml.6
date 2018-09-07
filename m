Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F0FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBFD2064D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBFD2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeIGKbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:31:35 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:11495 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725831AbeIGKbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:31:34 -0400
X-UUID: 33fac13fc5cc46e69affe135e60f132a-20180907
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1553609894; Fri, 07 Sep 2018 13:52:11 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 7 Sep 2018 13:52:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 7 Sep 2018 13:52:09 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] usb: xhci: fix interrupt transfer error happened on MTK platforms
Date:   Fri, 7 Sep 2018 13:51:48 +0800
Message-ID: <afafa68eb3a74a414848c116382e95811f924905.1536298766.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MTK xHCI controller use some reserved bytes in endpoint context for
bandwidth scheduling, so need keep them in xhci_endpoint_copy();

The issue is introduced by:
commit f5249461b504 ("xhci: Clear the host side toggle manually when
endpoint is soft reset")
It resets endpoints and will drop bandwidth scheduling parameters used
by interrupt or isochronous endpoints on MTK xHCI controller.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index ef350c3..b1f27aa 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1613,6 +1613,10 @@ void xhci_endpoint_copy(struct xhci_hcd *xhci,
 	in_ep_ctx->ep_info2 = out_ep_ctx->ep_info2;
 	in_ep_ctx->deq = out_ep_ctx->deq;
 	in_ep_ctx->tx_info = out_ep_ctx->tx_info;
+	if (xhci->quirks & XHCI_MTK_HOST) {
+		in_ep_ctx->reserved[0] = out_ep_ctx->reserved[0];
+		in_ep_ctx->reserved[1] = out_ep_ctx->reserved[1];
+	}
 }
 
 /* Copy output xhci_slot_ctx to the input xhci_slot_ctx.
-- 
1.9.1

