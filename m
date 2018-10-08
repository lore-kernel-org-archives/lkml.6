Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1A7C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3DF21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXh4Lrbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3DF21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJHWiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeJHWiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72000214FA;
        Mon,  8 Oct 2018 15:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012366;
        bh=n0YveCtHLTwW8GiKDkUaXoKB65GoB7l/27hMIT4HNBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gXh4LrbzoBgSCABlmulPoqgfKmUIJL3WOvxO9YPL+xxyTrBjFx8dEBTBb8XWbHzXX
         Fxa6GTWh1qN59EUd+mUQkHFRkxMPfLtc5OphmL/lLX3qbrrs7hne45ToOBsyMElVhD
         5rndZDQxi2woWixgyI5amShpF4Uf9FmsEtimLk2Y=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 41/58] net: mscc: fix the frame extraction into the skb
Date:   Mon,  8 Oct 2018 11:25:06 -0400
Message-Id: <20181008152523.70705-41-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 652ef42c134da1bbb03bd4c9b4291dfaf8d7febb ]

When extracting frames from the Ocelot switch, the frame check sequence
(FCS) is present at the end of the data extracted. The FCS was put into
the sk buffer which introduced some issues (as length related ones), as
the FCS shouldn't be part of an Rx sk buffer.

This patch fixes the Ocelot switch extraction behaviour by discarding
the FCS.

Fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mscc/ocelot_board.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index 18df7d934e81..ccfcf3048cd0 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -91,7 +91,7 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 		struct sk_buff *skb;
 		struct net_device *dev;
 		u32 *buf;
-		int sz, len;
+		int sz, len, buf_len;
 		u32 ifh[4];
 		u32 val;
 		struct frame_info info;
@@ -116,14 +116,20 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 			err = -ENOMEM;
 			break;
 		}
-		buf = (u32 *)skb_put(skb, info.len);
+		buf_len = info.len - ETH_FCS_LEN;
+		buf = (u32 *)skb_put(skb, buf_len);
 
 		len = 0;
 		do {
 			sz = ocelot_rx_frame_word(ocelot, grp, false, &val);
 			*buf++ = val;
 			len += sz;
-		} while ((sz == 4) && (len < info.len));
+		} while (len < buf_len);
+
+		/* Read the FCS and discard it */
+		sz = ocelot_rx_frame_word(ocelot, grp, false, &val);
+		/* Update the statistics if part of the FCS was read before */
+		len -= ETH_FCS_LEN - sz;
 
 		if (sz < 0) {
 			err = sz;
-- 
2.17.1

