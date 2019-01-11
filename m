Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F78EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A9521872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217109;
	bh=rMs6te+1l7ImYu5wvk2zflcZD4DwEAYniwtMHPV29bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wWhYqC7dDUnxhlWubAma96MYv9NcuYC9w8p9Nd/ywIe8gX4l2odeqByVbAU1EzHPL
	 SI/SDWcfqjl3Zjng0DSkLYIWtQIv+XAoGGoEvmv0RXeuP+c3oljulhSSojuTy9DV9W
	 nTwDWblGIcxJ3AOmDJKO2EeaIVxspIvEaQM8ga8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbfAKObr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:31:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389229AbfAKObo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2052133F;
        Fri, 11 Jan 2019 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217104;
        bh=rMs6te+1l7ImYu5wvk2zflcZD4DwEAYniwtMHPV29bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vh/u4ixOMp1vn2ukVSr7UQZRQ274VWT5MQnocyrP3IN8XGQNMvGD4ls1v2Sqc9Ee8
         Uzxh1cYFm2Kr3/ZvXOobxXrQBf7We4DrJsexlJUVxHI78Hl2n9BtfJlf0zds2OJ1bo
         auGUStPyV+XwDm5dsXRMuosOPcZtUsqMo8BTjEiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 043/105] net: macb: fix random memory corruption on RX with 64-bit DMA
Date:   Fri, 11 Jan 2019 15:14:14 +0100
Message-Id: <20190111131106.741635535@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

[ Upstream commit e100a897bf9b19089e57f236f2398c9e0538900e ]

64-bit DMA addresses are split in upper and lower halves that are
written in separate fields on GEM. For RX, bit 0 of the address is used
as the ownership bit (RX_USED). When the RX_USED bit is unset the
controller is allowed to write data to the buffer.

The driver does not guarantee that the controller already sees the upper
half when the RX_USED bit is cleared, possibly resulting in the
controller writing an incoming frame to an address with an incorrect
upper half and therefore possibly corrupting unrelated system memory.

Fix that by adding the necessary DMA memory barrier between the writes.

This corruption was observed on a ZynqMP based system.

Fixes: fff8019a08b6 ("net: macb: Add 64 bit addressing support for GEM")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Acked-by: Harini Katakam <harini.katakam@xilinx.com>
Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 0b2f9ddfb1c4..3aabc36eec0b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -675,6 +675,11 @@ static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_
 	if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
 		desc_64 = macb_64b_desc(bp, desc);
 		desc_64->addrh = upper_32_bits(addr);
+		/* The low bits of RX address contain the RX_USED bit, clearing
+		 * of which allows packet RX. Make sure the high bits are also
+		 * visible to HW at that point.
+		 */
+		dma_wmb();
 	}
 #endif
 	desc->addr = lower_32_bits(addr);
-- 
2.19.1



