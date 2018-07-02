Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAFCC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E312538F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E312538F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754677AbeGBMJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:09:37 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.218]:39436 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752042AbeGBMJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:09:35 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id F2FFBD8FE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jul 2018 07:09:34 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZxeAfwrPiPvAdZxeAf50VQ; Mon, 02 Jul 2018 07:09:34 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=58866 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fZxeA-002zfa-BT; Mon, 02 Jul 2018 07:09:34 -0500
Date:   Mon, 2 Jul 2018 07:09:32 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] net: stmmac_tc: use 64-bit arithmetic instead of 32-bit
Message-ID: <20180702120932.GA13079@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fZxeA-002zfa-BT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:58866
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix UL to constant 1024 in order to give the compiler complete
information about the proper arithmetic to use. Notice that this
constant is used in a context that expects an expression of type
u64 (64 bits, unsigned) and  following expressions are currently
being evaluated using 32-bit arithmetic:

qopt->idleslope * 1024 * ptr
qopt->hicredit * 1024 * 8
qopt->locredit * 1024 * 8

Addresses-Coverity-ID: 1470246 ("Unintentional integer overflow")
Addresses-Coverity-ID: 1470248 ("Unintentional integer overflow")
Addresses-Coverity-ID: 1470249 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 0b0fca0..8fedc28 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -321,7 +321,7 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	speed_div = (priv->speed == SPEED_100) ? 100000 : 1000000;
 
 	/* Final adjustments for HW */
-	value = qopt->idleslope * 1024 * ptr;
+	value = qopt->idleslope * 1024UL * ptr;
 	do_div(value, speed_div);
 	priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
 
@@ -329,10 +329,10 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	do_div(value, speed_div);
 	priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
 
-	value = qopt->hicredit * 1024 * 8;
+	value = qopt->hicredit * 1024UL * 8;
 	priv->plat->tx_queues_cfg[queue].high_credit = value & GENMASK(31, 0);
 
-	value = qopt->locredit * 1024 * 8;
+	value = qopt->locredit * 1024UL * 8;
 	priv->plat->tx_queues_cfg[queue].low_credit = value & GENMASK(31, 0);
 
 	ret = stmmac_config_cbs(priv, priv->hw,
-- 
2.7.4

