Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1D5C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F7220861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F7220861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeIGMJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:09:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16059 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725843AbeIGMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:09:10 -0400
X-UUID: a04a13ae6b03418fbd411adcd3ec253b-20180907
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1687779140; Fri, 07 Sep 2018 15:29:28 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 7 Sep 2018 15:29:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 7 Sep 2018 15:29:26 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <stable@vger.kernel.org>
Subject: [PATCH v2] usb: xhci: fix interrupt transfer error happened on MTK platforms
Date:   Fri, 7 Sep 2018 15:29:12 +0800
Message-ID: <e8698cc5710a9d1f25e33e2201e2177bfbfec75c.1536305256.git.chunfeng.yun@mediatek.com>
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
Fixes: f5249461b504 ("xhci: Clear the host side toggle manually when
endpoint is soft reset")

Cc: stable@vger.kernel.org
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Tested-by: Sean Wang <sean.wang@mediatek.com>
---
v2: add fix tag, Cc and Tested-by
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

