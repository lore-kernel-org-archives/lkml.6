Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F74ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D16420818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D16420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeKIDQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:16:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:16215 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbeKIDQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:16:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 09:39:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="104575958"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga004.fm.intel.com with ESMTP; 08 Nov 2018 09:39:55 -0800
From:   thor.thayer@linux.intel.com
To:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv2] net: stmmac: Fix RX packet size > 8191
Date:   Thu,  8 Nov 2018 11:42:14 -0600
Message-Id: <1541698935-9752-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

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
---
v2  Change BUF_SIZE_8KiB directly instead of separate define in RFT.
---
 drivers/net/ethernet/stmicro/stmmac/common.h    | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/descs_com.h | 2 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c  | 2 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index b1b305f8f414..272b9ca66314 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -365,7 +365,8 @@ struct dma_features {
 
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
index 77914c89d749..5ef91a790f9d 100644
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
index abc3f85270cd..d8c5bc412219 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -140,7 +140,7 @@ static void clean_desc3(void *priv_ptr, struct dma_desc *p)
 static int set_16kib_bfsize(int mtu)
 {
 	int ret = 0;
-	if (unlikely(mtu >= BUF_SIZE_8KiB))
+	if (unlikely(mtu > BUF_SIZE_8KiB))
 		ret = BUF_SIZE_16KiB;
 	return ret;
 }
-- 
2.7.4

