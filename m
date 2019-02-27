Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BB7C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A5A21852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfB0HAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 02:00:04 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:4044 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726931AbfB0HAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 02:00:04 -0500
X-IronPort-AV: E=Sophos;i="5.58,418,1544454000"; 
   d="scan'208";a="8979692"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Feb 2019 16:00:02 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 525144031DA5;
        Wed, 27 Feb 2019 16:00:02 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com
Cc:     julia.lawall@lip6.fr, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] phy: renesas: rcar-gen2: Fix memory leak at error paths
Date:   Wed, 27 Feb 2019 16:00:26 +0900
Message-Id: <1551250826-10302-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes memory leak at error paths of the probe function.
In for_each_child_of_node, if the loop returns, the driver should
call of_put_node() before returns.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Fixes: 1233f59f745 ("phy: Renesas R-Car Gen2 PHY driver")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/renesas/phy-rcar-gen2.c b/drivers/phy/renesas/phy-rcar-gen2.c
index 72eeb06..570b4e4 100644
--- a/drivers/phy/renesas/phy-rcar-gen2.c
+++ b/drivers/phy/renesas/phy-rcar-gen2.c
@@ -285,6 +285,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
 		error = of_property_read_u32(np, "reg", &channel_num);
 		if (error || channel_num > 2) {
 			dev_err(dev, "Invalid \"reg\" property\n");
+			of_node_put(np);
 			return error;
 		}
 		channel->select_mask = select_mask[channel_num];
@@ -300,6 +301,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
 						   &rcar_gen2_phy_ops);
 			if (IS_ERR(phy->phy)) {
 				dev_err(dev, "Failed to create PHY\n");
+				of_node_put(np);
 				return PTR_ERR(phy->phy);
 			}
 			phy_set_drvdata(phy->phy, phy);
-- 
2.7.4

