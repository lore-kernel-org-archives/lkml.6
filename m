Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51311C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C74208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E55TwAvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C74208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbeKOIf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:35:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389044AbeKOIa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:30:57 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827BA2252B;
        Wed, 14 Nov 2018 22:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234352;
        bh=da2o2nyR3BDZHBUQIrW87vzpE23+mBgQz24gC7oORVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E55TwAvRwHkqad13qkIybXLu0BQjhD13eF02Vga6cq5TXisnQmZ19hU2vEQRc8YZQ
         EePakaXu8eLVAsPo+lQ6OoxEbdHworWtc+hs+BhaCfI7kYJmkd4gkcBZZZtK/q4SUe
         AgAH1owUK85OrIepZMjDeTVyPeiZaofRiezV+sVU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thor Thayer <thor.thayer@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 25/27] net: stmmac: Fix RX packet size > 8191
Date:   Wed, 14 Nov 2018 17:25:14 -0500
Message-Id: <20181114222520.99926-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222520.99926-1-sashal@kernel.org>
References: <20181114222520.99926-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

[ Upstream commit 8137b6ef0ce469154e5cf19f8e7fe04d9a72ac5e ]

Ping problems with packets > 8191 as shown:

PING 192.168.1.99 (192.168.1.99) 8150(8178) bytes of data.
8158 bytes from 192.168.1.99: icmp_seq=1 ttl=64 time=0.669 ms
wrong data byte 8144 should be 0xd0 but was 0x0
16    10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
      20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
%< ---------------snip--------------------------------------
8112  b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf
      c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf
8144  0 0 0 0 d0 d1
      ^^^^^^^
Notice the 4 bytes of 0 before the expected byte of d0.

Databook notes that the RX buffer must be a multiple of 4/8/16
bytes [1].

Update the DMA Buffer size define to 8188 instead of 8192. Remove
the -1 from the RX buffer size allocations and use the new
DMA Buffer size directly.

[1] Synopsys DesignWare Cores Ethernet MAC Universal v3.70a
    [section 8.4.2 - Table 8-24]

Tested on SoCFPGA Stratix10 with ping sweep from 100 to 8300 byte packets.

Fixes: 286a83721720 ("stmmac: add CHAINED descriptor mode support (V4)")
Suggested-by: Jose Abreu <jose.abreu@synopsys.com>
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/common.h    | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/descs_com.h | 2 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c  | 2 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 627fec210e2f..8e2a19616bc9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -340,7 +340,8 @@ struct dma_features {
 
 /* GMAC TX FIFO is 8K, Rx FIFO is 16K */
 #define BUF_SIZE_16KiB 16384
-#define BUF_SIZE_8KiB 8192
+/* RX Buffer size must be < 8191 and multiple of 4/8/16 bytes */
+#define BUF_SIZE_8KiB 8188
 #define BUF_SIZE_4KiB 4096
 #define BUF_SIZE_2KiB 2048
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/descs_com.h b/drivers/net/ethernet/stmicro/stmmac/descs_com.h
index ca9d7e48034c..40d6356a7e73 100644
--- a/drivers/net/ethernet/stmicro/stmmac/descs_com.h
+++ b/drivers/net/ethernet/stmicro/stmmac/descs_com.h
@@ -31,7 +31,7 @@
 /* Enhanced descriptors */
 static inline void ehn_desc_rx_set_on_ring(struct dma_desc *p, int end)
 {
-	p->des1 |= cpu_to_le32(((BUF_SIZE_8KiB - 1)
+	p->des1 |= cpu_to_le32((BUF_SIZE_8KiB
 			<< ERDES1_BUFFER2_SIZE_SHIFT)
 		   & ERDES1_BUFFER2_SIZE_MASK);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 2a828a312814..acd65a4f94d4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -262,7 +262,7 @@ static void enh_desc_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
 				  int mode, int end)
 {
 	p->des0 |= cpu_to_le32(RDES0_OWN);
-	p->des1 |= cpu_to_le32((BUF_SIZE_8KiB - 1) & ERDES1_BUFFER1_SIZE_MASK);
+	p->des1 |= cpu_to_le32(BUF_SIZE_8KiB & ERDES1_BUFFER1_SIZE_MASK);
 
 	if (mode == STMMAC_CHAIN_MODE)
 		ehn_desc_rx_set_on_chain(p);
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index 28e4b5d50ce6..1af7b078b94d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -143,7 +143,7 @@ static void stmmac_clean_desc3(void *priv_ptr, struct dma_desc *p)
 static int stmmac_set_16kib_bfsize(int mtu)
 {
 	int ret = 0;
-	if (unlikely(mtu >= BUF_SIZE_8KiB))
+	if (unlikely(mtu > BUF_SIZE_8KiB))
 		ret = BUF_SIZE_16KiB;
 	return ret;
 }
-- 
2.17.1

