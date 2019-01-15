Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA36C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA218205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfAOBoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:44:11 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:30927 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726769AbfAOBoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:44:10 -0500
X-UUID: 9688400387d94252bd3f98e8ce746956-20190115
X-UUID: 9688400387d94252bd3f98e8ce746956-20190115
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 957536321; Tue, 15 Jan 2019 09:44:01 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 09:43:58 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 15 Jan 2019 09:43:58 +0800
From:   <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Min Guo <min.guo@mediatek.com>
Subject: [PATCH v2 3/4] usb: musb: Extract set toggle as a separate interface
Date:   Tue, 15 Jan 2019 09:43:45 +0800
Message-ID: <1547516626-5084-4-git-send-email-min.guo@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Guo <min.guo@mediatek.com>

Add a common interface for set data toggle

Signed-off-by: Min Guo <min.guo@mediatek.com>
---
 drivers/usb/musb/musb_host.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index b59ce9a..16d0ba4 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -306,6 +306,25 @@ static inline void musb_save_toggle(struct musb_qh *qh, int is_in,
 	usb_settoggle(urb->dev, qh->epnum, !is_in, csr ? 1 : 0);
 }
 
+static inline u16 musb_set_toggle(struct musb_qh *qh, int is_in,
+	struct urb *urb)
+{
+	u16 csr = 0;
+	u16 toggle = 0;
+
+	toggle = usb_gettoggle(urb->dev, qh->epnum, !is_in);
+
+	if (is_in)
+		csr = toggle ? (MUSB_RXCSR_H_WR_DATATOGGLE
+				| MUSB_RXCSR_H_DATATOGGLE) : 0;
+	else
+		csr = toggle ? (MUSB_TXCSR_H_WR_DATATOGGLE
+				| MUSB_TXCSR_H_DATATOGGLE)
+				: MUSB_TXCSR_CLRDATATOG;
+
+	return csr;
+}
+
 /*
  * Advance this hardware endpoint's queue, completing the specified URB and
  * advancing to either the next URB queued to that qh, or else invalidating
@@ -772,13 +791,8 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 					);
 			csr |= MUSB_TXCSR_MODE;
 
-			if (!hw_ep->tx_double_buffered) {
-				if (usb_gettoggle(urb->dev, qh->epnum, 1))
-					csr |= MUSB_TXCSR_H_WR_DATATOGGLE
-						| MUSB_TXCSR_H_DATATOGGLE;
-				else
-					csr |= MUSB_TXCSR_CLRDATATOG;
-			}
+			if (!hw_ep->tx_double_buffered)
+				csr |= musb_set_toggle(qh, !is_out, urb);
 
 			musb_writew(epio, MUSB_TXCSR, csr);
 			/* REVISIT may need to clear FLUSHFIFO ... */
@@ -860,17 +874,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 	/* IN/receive */
 	} else {
-		u16	csr;
+		u16 csr = 0;
 
 		if (hw_ep->rx_reinit) {
 			musb_rx_reinit(musb, qh, epnum);
+			csr |= musb_set_toggle(qh, !is_out, urb);
 
-			/* init new state: toggle and NYET, maybe DMA later */
-			if (usb_gettoggle(urb->dev, qh->epnum, 0))
-				csr = MUSB_RXCSR_H_WR_DATATOGGLE
-					| MUSB_RXCSR_H_DATATOGGLE;
-			else
-				csr = 0;
 			if (qh->type == USB_ENDPOINT_XFER_INT)
 				csr |= MUSB_RXCSR_DISNYET;
 
-- 
1.9.1

