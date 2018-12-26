Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA6DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4905A21901
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864088;
	bh=gC7K2xUh7Zr/EIXlaVbNvGn0QO630L3Ju1a7EsoM6HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u9nmLIJfQKVYgX737GTIegC7ZrpX9vdjWJYgilBfgR9MVSI9qh9gbr8K4i8/tmCyC
	 XjRaMRQevHQhljcZxXzYEG7+Yu1wacygTvA/llVdkqG+2MfRroe7KupPi5mBAGQEFb
	 tPq6HrK9psNETc4rnYi4hilaeHZmH6KHCYhgSWxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbeLZWl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729416AbeLZWlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:41:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7373C218E2;
        Wed, 26 Dec 2018 22:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864082;
        bh=gC7K2xUh7Zr/EIXlaVbNvGn0QO630L3Ju1a7EsoM6HM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xhfiso6G5Z7/UN6EJPzLxTRoNgquyw0AjtGAoTlVoSrIiuQthc5dDMQhaj7yuLO6G
         fLF8VWeJnbk5lyhJWUXGvfMs7sTtfqkiS73mr9Tbumk8zCoGetQF+kBv9YUdiSNMWL
         /U+k/ucA5/M+nHH3NpmvQzVMEj9i6RKkmbvYavfM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anssi Hannula <anssi.hannula@bitwise.fi>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 46/59] net: macb: fix random memory corruption on RX with 64-bit DMA
Date:   Wed, 26 Dec 2018 17:38:26 -0500
Message-Id: <20181226223839.150262-46-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi>

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
index d6f8d6c8b0f1..db5be65b2553 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -674,6 +674,11 @@ static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_
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

