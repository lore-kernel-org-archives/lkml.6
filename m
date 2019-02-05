Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378A4C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134542075D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfBELEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:04:09 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:8147 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbfBELEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:04:07 -0500
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; 
   d="scan'208";a="27296379"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 04:04:06 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch04.mchp-main.com (10.10.76.105) with Microsoft SMTP Server id
 14.3.352.0; Tue, 5 Feb 2019 04:04:06 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, "Vinod Koul" <vkoul@kernel.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 3/3] dmaengine: at_xdmac: only monitor overflow errors for peripheral xfer
Date:   Tue, 5 Feb 2019 12:03:43 +0100
Message-ID: <4af293348e03a30746d8c0e5eead2f480b2f13f9.1549364323.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <324b91c71a148a7694d28d9b8b4364095d9b0ebe.1549364323.git.nicolas.ferre@microchip.com>
References: <324b91c71a148a7694d28d9b8b4364095d9b0ebe.1549364323.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The overflow error flag (ROI: Request Overflow Error) is only relevant
for the case when the channel handles a peripheral synchronized transfer.
Not in the case of memory to memory transfer where there is no hardware
request signal.

Remove the use of this interrupt source in such a case. It's based on
the first descriptor which holds the configuration for the whole
linked list transfer.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/dma/at_xdmac.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index ec7a29d8e448..b558a23ffbc2 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -308,6 +308,11 @@ static inline int at_xdmac_csize(u32 maxburst)
 	return csize;
 };
 
+static inline bool at_xdmac_chan_is_peripheral_xfer(u32 cfg)
+{
+	return cfg & AT_XDMAC_CC_TYPE_PER_TRAN;
+}
+
 static inline u8 at_xdmac_get_dwidth(u32 cfg)
 {
 	return (cfg & AT_XDMAC_CC_DWIDTH_MASK) >> AT_XDMAC_CC_DWIDTH_OFFSET;
@@ -389,7 +394,13 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 		 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
 
 	at_xdmac_chan_write(atchan, AT_XDMAC_CID, 0xffffffff);
-	reg = AT_XDMAC_CIE_RBEIE | AT_XDMAC_CIE_WBEIE | AT_XDMAC_CIE_ROIE;
+	reg = AT_XDMAC_CIE_RBEIE | AT_XDMAC_CIE_WBEIE;
+	/*
+	 * Request Overflow Error is only for peripheral synchronized transfers
+	 */
+	if (at_xdmac_chan_is_peripheral_xfer(first->lld.mbr_cfg))
+		reg |= AT_XDMAC_CIE_ROIE;
+
 	/*
 	 * There is no end of list when doing cyclic dma, we need to get
 	 * an interrupt after each periods.
-- 
2.17.1

