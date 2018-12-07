Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9688C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9497720850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCZltnFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9497720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeLGIbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:31:01 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44175 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeLGIbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:31:00 -0500
Received: by mail-pf1-f202.google.com with SMTP id b17so2705944pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 00:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=h0iwBJAI3blijsYGp3lEIcvTsTsYT9KN9COxBytQTOM=;
        b=uCZltnFR7ax58zqG9scJ9N8E4r+dnuVYScOA347gjSPuL2UwS5lSXYU5kZNbE8SRRc
         VPeRo3+CQ7rjqAYQPU35WC86flUef44CRiMYhVR6XCnvklRJkFoIHz1FSI15fkqRX7pM
         QDKgwfJWcCJf/DygsHzjFnDRu3B28z07It0IpYIMXlSvKmGtylULsCuJ2Ny2A8+TjpL+
         5ADrCuhYW2zntZBy/Bey+X53Pn+f7Ix0tctwORs7Oq2qk87w8s+NbOp+2yKyIqyAKWoH
         PIFAm/rV7FdasptsQHU+6aAU37zGWz/CUwvsthgxJehkwZrldOXU6i4lTviQD6nGTZPB
         NgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=h0iwBJAI3blijsYGp3lEIcvTsTsYT9KN9COxBytQTOM=;
        b=AIFcqnIZ0vYwzLa91b8XbUSIhHx0KooPqj6+25k0ZYAy44besDcfqAuItg6Pa2bmR8
         K/E5UQFqudG8VfFIvQtiWC/IGeXi9UkgLyEFyBJDddZ0xNy67uD+r+BBJae9BePykGkk
         O2hROvwXDpEXl3wyy9f6vgnlRj1/BzPELwIP1695KFpXge0vK7Cq27a5PnSMlEZPN975
         ld5b7GzCz//mXbEXtz0/TWSnYQbU0TnW7mlX3tXuL6bkf7envACz/7LWZtXUDvzFF409
         89sJbSxkDoGGu/m970TAEOjKP8gsaw+nQiEjf8wCROptI7wt/STrOkb9Xip8tNogBdf+
         xvBg==
X-Gm-Message-State: AA+aEWZp/BFSyStfkccDdAVTzv4mAqakAckKDy1Q8APZq899w5H0irXc
        c8m8tFZQLve6kEAy3SV5E3ca4tO8Bg==
X-Google-Smtp-Source: AFSGD/WuxSPP9EfYkvdsWEKinjIInY73AbcqeXCXJTZGHGbuSCQQztpzkl4/IzMS+HK8qM+qymC7Mx9pTQs=
X-Received: by 2002:a62:61c7:: with SMTP id v190mr446590pfb.53.1544171459515;
 Fri, 07 Dec 2018 00:30:59 -0800 (PST)
Date:   Fri,  7 Dec 2018 00:30:26 -0800
Message-Id: <20181207083026.173789-1-tarick@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH] net/mlx4_core: Correctly set PFC param if global pause is
 turned off.
From:   Tarick Bedeir <tarick@google.com>
To:     Eran Ben Elisha <eranbe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tarick Bedeir <tarick@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rx_ppp and tx_ppp can be set between 0 and 255, so don't clamp to 1.

Fixes: 6e8814ceb7e8 ("net/mlx4_en: Fix mixed PFC and Global pause user control requests")
Signed-off-by: Tarick Bedeir <tarick@google.com>
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
2.20.0.rc2.403.gdbc3b29805-goog

