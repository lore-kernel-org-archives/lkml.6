Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0455DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B204D20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B204D20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbeHAUQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:16:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404239AbeHATDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AE8FA12B9;
        Wed,  1 Aug 2018 17:10:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahisa KOJIMA <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 288/336] net: socionext: reset hardware in ndo_stop
Date:   Wed,  1 Aug 2018 18:50:23 +0200
Message-Id: <20180801165040.046462282@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahisa KOJIMA <masahisa.kojima@linaro.org>

[ Upstream commit 9a00b697ce31e38c670a3042cf9f1e9cf28dabb5 ]

When the interface is down, head/tail of the descriptor
ring address is set to 0 in netsec_netdev_stop().
But netsec hardware still keeps the previous descriptor
ring address, so there is inconsistency between driver
and hardware after interface is up at a later time.
To address this inconsistency, add netsec_reset_hardware()
when the interface is down.

In addition, to minimize the reset process,
add flag to decide whether driver loads the netsec microcode.
Even if driver resets the netsec hardware, netsec microcode
keeps resident on RAM, so it is ok we only load the microcode
at initialization.

This patch is critical for installation over network.

Signed-off-by: Masahisa KOJIMA <masahisa.kojima@linaro.org>
Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/socionext/netsec.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1057,7 +1057,8 @@ static int netsec_netdev_load_microcode(
 	return 0;
 }
 
-static int netsec_reset_hardware(struct netsec_priv *priv)
+static int netsec_reset_hardware(struct netsec_priv *priv,
+				 bool load_ucode)
 {
 	u32 value;
 	int err;
@@ -1102,11 +1103,14 @@ static int netsec_reset_hardware(struct
 	netsec_write(priv, NETSEC_REG_NRM_RX_CONFIG,
 		     1 << NETSEC_REG_DESC_ENDIAN);
 
-	err = netsec_netdev_load_microcode(priv);
-	if (err) {
-		netif_err(priv, probe, priv->ndev,
-			  "%s: failed to load microcode (%d)\n", __func__, err);
-		return err;
+	if (load_ucode) {
+		err = netsec_netdev_load_microcode(priv);
+		if (err) {
+			netif_err(priv, probe, priv->ndev,
+				  "%s: failed to load microcode (%d)\n",
+				  __func__, err);
+			return err;
+		}
 	}
 
 	/* start DMA engines */
@@ -1328,6 +1332,7 @@ err1:
 
 static int netsec_netdev_stop(struct net_device *ndev)
 {
+	int ret;
 	struct netsec_priv *priv = netdev_priv(ndev);
 
 	netif_stop_queue(priv->ndev);
@@ -1343,12 +1348,14 @@ static int netsec_netdev_stop(struct net
 	netsec_uninit_pkt_dring(priv, NETSEC_RING_TX);
 	netsec_uninit_pkt_dring(priv, NETSEC_RING_RX);
 
+	ret = netsec_reset_hardware(priv, false);
+
 	phy_stop(ndev->phydev);
 	phy_disconnect(ndev->phydev);
 
 	pm_runtime_put_sync(priv->dev);
 
-	return 0;
+	return ret;
 }
 
 static int netsec_netdev_init(struct net_device *ndev)
@@ -1364,7 +1371,7 @@ static int netsec_netdev_init(struct net
 	if (ret)
 		goto err1;
 
-	ret = netsec_reset_hardware(priv);
+	ret = netsec_reset_hardware(priv, true);
 	if (ret)
 		goto err2;
 


