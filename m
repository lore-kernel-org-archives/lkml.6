Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC5C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1075A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1075A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbeIMTBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:01:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbeIMTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:01:24 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E8C63D1A;
        Thu, 13 Sep 2018 13:51:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Vitor Soares <soares@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 029/197] Revert "net: stmmac: Do not keep rearming the coalesce timer in stmmac_xmit"
Date:   Thu, 13 Sep 2018 15:29:38 +0200
Message-Id: <20180913131842.734828401@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit e5133f2f1261f8ab412e7fc5e3694c9f84328f89 ]

This reverts commit 4ae0169fd1b3c792b66be58995b7e6b629919ecf.

This change in the handling of the coalesce timer is causing regression on
(at least) amlogic platforms.

Network will break down very quickly (a few seconds) after starting
a download. This can easily be reproduced using iperf3 for example.

The problem has been reported on the S805, S905, S912 and A113 SoCs
(Realtek and Micrel PHYs) and it is likely impacting all Amlogics
platforms using Gbit ethernet

No problem was seen with the platform using 10/100 only PHYs (GXL internal)

Reverting change brings things back to normal and allows to use network
again until we better understand the problem with the coalesce timer.

Cc: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Vitor Soares <soares@synopsys.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |    1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -112,7 +112,6 @@ struct stmmac_priv {
 	u32 tx_count_frames;
 	u32 tx_coal_frames;
 	u32 tx_coal_timer;
-	bool tx_timer_armed;
 
 	int tx_coalesce;
 	int hwts_tx_en;
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3126,16 +3126,13 @@ static netdev_tx_t stmmac_xmit(struct sk
 	 * element in case of no SG.
 	 */
 	priv->tx_count_frames += nfrags + 1;
-	if (likely(priv->tx_coal_frames > priv->tx_count_frames) &&
-	    !priv->tx_timer_armed) {
+	if (likely(priv->tx_coal_frames > priv->tx_count_frames)) {
 		mod_timer(&priv->txtimer,
 			  STMMAC_COAL_TIMER(priv->tx_coal_timer));
-		priv->tx_timer_armed = true;
 	} else {
 		priv->tx_count_frames = 0;
 		stmmac_set_tx_ic(priv, desc);
 		priv->xstats.tx_set_ic_bit++;
-		priv->tx_timer_armed = false;
 	}
 
 	skb_tx_timestamp(skb);


