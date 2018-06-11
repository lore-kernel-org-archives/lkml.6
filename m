Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E9557C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9843020869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9843020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934113AbeFKRwi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:52:38 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:39015 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933483AbeFKRwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:52:36 -0400
Received: from localhost.localdomain ([77.136.205.128])
        by mwinf5d63 with ME
        id xVsW1x00F2mkQqM03VsWLX; Mon, 11 Jun 2018 19:52:34 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 11 Jun 2018 19:52:34 +0200
X-ME-IP: 77.136.205.128
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, davem@davemloft.net, carlo@caione.org,
        khilman@baylibre.com
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] net: stmmac: dwmac-meson8b: Fix an error handling path in 'meson8b_dwmac_probe()'
Date:   Mon, 11 Jun 2018 19:52:27 +0200
Message-Id: <20180611175227.27509-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
X-Antivirus: Avast (VPS 180611-4, 11/06/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'of_device_get_match_data()' fails, we need to release some resources as
done in the other error handling path of this function.

Fixes: efacb568c962 ("net: stmmac: dwmac-meson: extend phy mode setting")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index 4ff231df7322..c5979569fd60 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -334,9 +334,10 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 
 	dwmac->data = (const struct meson8b_dwmac_data *)
 		of_device_get_match_data(&pdev->dev);
-	if (!dwmac->data)
-		return -EINVAL;
-
+	if (!dwmac->data) {
+		ret = -EINVAL;
+		goto err_remove_config_dt;
+	}
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	dwmac->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(dwmac->regs)) {
-- 
2.17.0

