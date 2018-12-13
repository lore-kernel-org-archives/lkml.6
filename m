Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E702C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA69320879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675457;
	bh=IE+yPgSbVfJbIs2LCz0YI+Khyq714R7BXWzxNJl8Yqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tY35yfCn5rYtwuFQSySSK1rRTGX2U2D1Qrn5wBk6csf3M3bPf4iH7V2CdyojhcK1S
	 1Gz6EasGWCANk9Ye2vv+P/5SwmCLn88CCAo6V5CbNwMgEuMW8vGw/Xj0+6AySBN22F
	 78e2VLxUOs09FfzrkT6aPLly9DKCxzdao/4IoJJs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA69320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeLMEa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:30:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbeLMEay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C06CB20879;
        Thu, 13 Dec 2018 04:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675453;
        bh=IE+yPgSbVfJbIs2LCz0YI+Khyq714R7BXWzxNJl8Yqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0/mYpIyTyzpjDRTzGt6fCLF+gnzeLeUvABIAxmA5YzrfyhznM+nluhzGCRws2qBa
         +zOaF5ruWZNTDBPEFLVZaJ7cYJRr1NZhMcL0dD1gQxOneNVGAwnEsGPxHr0qXWxgzJ
         BgML0tObGiL41E1x/HZRdnL9vaHOgQvNjHDhaZTU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tarick Bedeir <tarick@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 73/73] net/mlx4_core: Correctly set PFC param if global pause is turned off.
Date:   Wed, 12 Dec 2018 23:28:38 -0500
Message-Id: <20181213042838.75160-73-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tarick Bedeir <tarick@google.com>

[ Upstream commit bd5122cd1e0644d8bd8dd84517c932773e999766 ]

rx_ppp and tx_ppp can be set between 0 and 255, so don't clamp to 1.

Fixes: 6e8814ceb7e8 ("net/mlx4_en: Fix mixed PFC and Global pause user control requests")
Signed-off-by: Tarick Bedeir <tarick@google.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index f11b45001cad..d290f0787dfb 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1084,8 +1084,8 @@ static int mlx4_en_set_pauseparam(struct net_device *dev,
 
 	tx_pause = !!(pause->tx_pause);
 	rx_pause = !!(pause->rx_pause);
-	rx_ppp = priv->prof->rx_ppp && !(tx_pause || rx_pause);
-	tx_ppp = priv->prof->tx_ppp && !(tx_pause || rx_pause);
+	rx_ppp = (tx_pause || rx_pause) ? 0 : priv->prof->rx_ppp;
+	tx_ppp = (tx_pause || rx_pause) ? 0 : priv->prof->tx_ppp;
 
 	err = mlx4_SET_PORT_general(mdev->dev, priv->port,
 				    priv->rx_skb_size + ETH_FCS_LEN,
-- 
2.19.1

