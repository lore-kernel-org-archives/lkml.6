Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8257C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8385520846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="n+rmyVSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8385520846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeGZIQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:16:34 -0400
Received: from m12-12.163.com ([220.181.12.12]:52709 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbeGZIQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:16:34 -0400
X-Greylist: delayed 943 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jul 2018 04:16:33 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=AkLRQDrDZ2AtI3KJ6A
        oAjq+eAmzgisZzGW/p0rdow4w=; b=n+rmyVSkdUHotdngCUmLIIhx+CL9dtgn8N
        Xn42JngwFWGXCGbUB2fnF2xKOWVUVhYHONkd6QSnzrWvSWVr4K8avVTlhAo1xDej
        Vvcbv+Sroe/kznXVXdp6Vig6QltmFVWwAmj/eMxsBmdY6kza6vaBSl6c6NNx++oI
        LcNiUuK1Y=
Received: from centos.localdomain (unknown [1.202.237.184])
        by smtp8 (Coremail) with SMTP id DMCowADXn7IAbllboSC3Kw--.39391S3;
        Thu, 26 Jul 2018 14:45:20 +0800 (CST)
From:   tli012345@163.com
To:     thomas.lendacky@amd.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangpengpeng <tangpengpeng@higon.com>
Subject: [PATCH] net: fix amd-xgbe flow-control issue
Date:   Thu, 26 Jul 2018 14:45:16 +0800
Message-Id: <20180726064516.56740-1-tli012345@163.com>
X-Mailer: git-send-email 2.14.2
X-CM-TRANSID: DMCowADXn7IAbllboSC3Kw--.39391S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7JrykJry3tFWUKFyUAF4UCFg_yoW8Jr45pF
        Z8WryIvF40qrs0y3WrZ3W8Cr15ta93tFWaga9rAw1rAr1ak3s8Cr4DKay8uryv9rWUJF42
        krW5Aan3C3Z8trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jsOz3UUUUU=
X-Originating-IP: [1.202.237.184]
X-CM-SenderInfo: xwoliiistukqqrwthudrp/1tbiKQCP7FXlnRMJSAAAs1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tangpengpeng <tangpengpeng@higon.com>

If we enable or disable xgbe flow-control by ethtool ,
it does't work.Because the parameter is not properly
assigned,so we need to adjust the assignment order
of the parameters.

Signed-off-by: tangpengpeng <tangpengpeng@higon.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 4b5d625de8f0..8a3a60bb2688 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1111,14 +1111,14 @@ static void xgbe_phy_adjust_link(struct xgbe_prv_data *pdata)
 
 		if (pdata->tx_pause != pdata->phy.tx_pause) {
 			new_state = 1;
-			pdata->hw_if.config_tx_flow_control(pdata);
 			pdata->tx_pause = pdata->phy.tx_pause;
+			pdata->hw_if.config_tx_flow_control(pdata);
 		}
 
 		if (pdata->rx_pause != pdata->phy.rx_pause) {
 			new_state = 1;
-			pdata->hw_if.config_rx_flow_control(pdata);
 			pdata->rx_pause = pdata->phy.rx_pause;
+			pdata->hw_if.config_rx_flow_control(pdata);
 		}
 
 		/* Speed support */
-- 
2.14.2


