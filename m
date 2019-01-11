Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01520C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6384206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218484;
	bh=+K+CEzHbfyVqI5eFNWJMqwMw+yUDo0XzmvYDS/+yqjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XJuSsXDSZFfqoLDU031K3jNNknS6LhwHhFH9JFBUgwAIp1Yvsv2BEnpkrtAGRj4Wh
	 yVqjZaf92X/C8qAOcgKVNuN9E/682Ya1PZCN9B9XS1t5huXoIyPTQlGEgBytpIqL5n
	 Z6iOKgUf0SBM7OY1LbJCTpnB/nJ9hDsT4P3ctCYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391733AbfAKOyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:54:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390161AbfAKOhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48FAD204EC;
        Fri, 11 Jan 2019 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217437;
        bh=+K+CEzHbfyVqI5eFNWJMqwMw+yUDo0XzmvYDS/+yqjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3jUOe9wxjOFNsn272vwnanWSHgmV8Klw8GqZ0kUD2DQ73NECnv1TsQrR6gnLiO84
         In0nijHbh8mQ4auOcnjfkXegIay8De2u1z/t8MQKxkrTVXh+nqrk1nO4O7Y4jhTVCN
         V4st0CYS7aNC/6eZsSNYVbMOhUvU8X3OQk3BCcNc=
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
Subject: [PATCH 4.19 059/148] net: macb: fix random memory corruption on RX with 64-bit DMA
Date:   Fri, 11 Jan 2019 15:13:57 +0100
Message-Id: <20190111131116.627394872@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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
index 240fd36b5074..2de9197df074 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -682,6 +682,11 @@ static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_
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



