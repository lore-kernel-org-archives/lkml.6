Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42C3C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C1A2073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfBCOcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:32:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55152 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728451AbfBCOTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:19:48 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIcc-00062N-AQ; Sun, 03 Feb 2019 14:19:46 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9d-00077C-Kl; Sun, 03 Feb 2019 14:49:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Thor Thayer" <thor.thayer@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Jose Abreu" <jose.abreu@synopsys.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.336918941@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 168/305] net: stmmac: Fix RX packet size > 8191
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thor Thayer <thor.thayer@linux.intel.com>

commit 8137b6ef0ce469154e5cf19f8e7fe04d9a72ac5e upstream.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h    | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/descs_com.h | 2 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c  | 2 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -272,7 +272,8 @@ struct dma_features {
 
 /* GMAC TX FIFO is 8K, Rx FIFO is 16K */
 #define BUF_SIZE_16KiB 16384
-#define BUF_SIZE_8KiB 8192
+/* RX Buffer size must be < 8191 and multiple of 4/8/16 bytes */
+#define BUF_SIZE_8KiB 8188
 #define BUF_SIZE_4KiB 4096
 #define BUF_SIZE_2KiB 2048
 
--- a/drivers/net/ethernet/stmicro/stmmac/descs_com.h
+++ b/drivers/net/ethernet/stmicro/stmmac/descs_com.h
@@ -35,7 +35,7 @@
 /* Enhanced descriptors */
 static inline void ehn_desc_rx_set_on_ring(struct dma_desc *p, int end)
 {
-	p->des01.erx.buffer2_size = BUF_SIZE_8KiB - 1;
+	p->des01.erx.buffer2_size = BUF_SIZE_8KiB;
 	if (end)
 		p->des01.erx.end_ring = 1;
 }
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -242,7 +242,7 @@ static void enh_desc_init_rx_desc(struct
 {
 	p->des01.all_flags = 0;
 	p->des01.erx.own = 1;
-	p->des01.erx.buffer1_size = BUF_SIZE_8KiB - 1;
+	p->des01.erx.buffer1_size = BUF_SIZE_8KiB;
 
 	if (mode == STMMAC_CHAIN_MODE)
 		ehn_desc_rx_set_on_chain(p, end);
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -120,7 +120,7 @@ static void stmmac_clean_desc3(void *pri
 static int stmmac_set_16kib_bfsize(int mtu)
 {
 	int ret = 0;
-	if (unlikely(mtu >= BUF_SIZE_8KiB))
+	if (unlikely(mtu > BUF_SIZE_8KiB))
 		ret = BUF_SIZE_16KiB;
 	return ret;
 }

