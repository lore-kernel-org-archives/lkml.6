Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeEAVBf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 17:01:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41858 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeEAVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 17:01:33 -0400
X-Google-Smtp-Source: AB8JxZrdM/rR6qyn4ZYbDcjiXmXy0MVu7ybcbytm/Gvvc/xS82/ZJw0yxOgco2jO2fsBvqjxVWEyYQ==
Date: Tue, 1 May 2018 14:01:30 -0700
From: Kees Cook <keescook@chromium.org>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH] net: stmmac: Avoid VLA usage
Message-ID: <20180501210130.GA47709@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLAs from the kernel[1], this switches
the "status" stack buffer to use the existing small (8) upper bound on
how many queues can be checked for DMA, and adds a sanity-check just to
make sure it doesn't operate under pathological conditions.

[1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b65e2d144698..19bdc23fa314 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2045,7 +2045,11 @@ static void stmmac_dma_interrupt(struct stmmac_priv *priv)
 				tx_channel_count : rx_channel_count;
 	u32 chan;
 	bool poll_scheduled = false;
-	int status[channels_to_check];
+	int status[max_t(u32, MTL_MAX_TX_QUEUES, MTL_MAX_RX_QUEUES)];
+
+	/* Make sure we never check beyond our status buffer. */
+	if (WARN_ON_ONCE(channels_to_check > ARRAY_SIZE(status)))
+		channels_to_check = ARRAY_SIZE(status);
 
 	/* Each DMA channel can be used for rx and tx simultaneously, yet
 	 * napi_struct is embedded in struct stmmac_rx_queue rather than in a
-- 
2.7.4


-- 
Kees Cook
Pixel Security
