Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98449ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5485220664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYrYLmoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5485220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeKAIJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730275AbeKAIJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE08220838;
        Wed, 31 Oct 2018 23:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027343;
        bh=lnwAYRnij7/dG5MTGCKc2ZqWr+tKNp1FUnymCKTx1sA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYrYLmoQ8RXDRkOGR3Uh3q1GKazOfUu4wLPtYWKx3SXH5KMxFfzcAQpNkl+X4V06O
         kYGNqW5hevFR71JC4YzEgo6GOUncOaI3+qBY03s1hK6SpjqAVv2JlCI3l5gtsO62LL
         qhE3i7FGUY1RLByivQb+RGRd3UVcsFPIhLTptIMY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 075/126] net: stmmac: dwmac-sun8i: fix OF child-node lookup
Date:   Wed, 31 Oct 2018 19:07:03 -0400
Message-Id: <20181031230754.29029-75-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit ac63043d8cb5503c7e0fe110f947eacf2663804e ]

Use the new of_get_compatible_child() helper to lookup the mdio-internal
child node instead of using of_find_compatible_node(), which searches
the entire tree from a given start node and thus can return an unrelated
(i.e. non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the mdio-mux node). Fortunately, this was inadvertently
balanced by a failure to drop the mdio-mux reference after lookup.

While at it, also fix the related mdio-internal- and phy-node reference
leaks.

Fixes: 634db83b8265 ("net: stmmac: dwmac-sun8i: Handle integrated/external MDIOs")
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index f9a61f90cfbc..0f660af01a4b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -714,8 +714,9 @@ static int get_ephy_nodes(struct stmmac_priv *priv)
 		return -ENODEV;
 	}
 
-	mdio_internal = of_find_compatible_node(mdio_mux, NULL,
+	mdio_internal = of_get_compatible_child(mdio_mux,
 						"allwinner,sun8i-h3-mdio-internal");
+	of_node_put(mdio_mux);
 	if (!mdio_internal) {
 		dev_err(priv->device, "Cannot get internal_mdio node\n");
 		return -ENODEV;
@@ -729,13 +730,20 @@ static int get_ephy_nodes(struct stmmac_priv *priv)
 		gmac->rst_ephy = of_reset_control_get_exclusive(iphynode, NULL);
 		if (IS_ERR(gmac->rst_ephy)) {
 			ret = PTR_ERR(gmac->rst_ephy);
-			if (ret == -EPROBE_DEFER)
+			if (ret == -EPROBE_DEFER) {
+				of_node_put(iphynode);
+				of_node_put(mdio_internal);
 				return ret;
+			}
 			continue;
 		}
 		dev_info(priv->device, "Found internal PHY node\n");
+		of_node_put(iphynode);
+		of_node_put(mdio_internal);
 		return 0;
 	}
+
+	of_node_put(mdio_internal);
 	return -ENODEV;
 }
 
-- 
2.17.1

