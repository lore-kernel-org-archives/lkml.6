Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CECBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BFA208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BFA208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbeHWLim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:38:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45430 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbeHWLim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:38:42 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 24E06C74;
        Thu, 23 Aug 2018 08:10:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 082/130] sh_eth: fix invalid context bug while calling auto-negotiation by ethtool
Date:   Thu, 23 Aug 2018 09:53:18 +0200
Message-Id: <20180823074932.549417188@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

[ Upstream commit 53a710b5044d8475faa6813000b6dd659400ef7b ]

Since commit 35b5f6b1a82b ("PHYLIB: Locking fixes for PHY I/O
potentially sleeping") phy_start_aneg() function utilizes a mutex
to serialize changes to phy state, however the helper function is
called in atomic context.

The bug can be reproduced by running "ethtool -r" command, the bug
is reported if CONFIG_DEBUG_ATOMIC_SLEEP build option is enabled.

Fixes: dc19e4e5e02f ("sh: sh_eth: Add support ethtool")
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/renesas/sh_eth.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2079,18 +2079,10 @@ static void sh_eth_get_regs(struct net_d
 
 static int sh_eth_nway_reset(struct net_device *ndev)
 {
-	struct sh_eth_private *mdp = netdev_priv(ndev);
-	unsigned long flags;
-	int ret;
-
 	if (!ndev->phydev)
 		return -ENODEV;
 
-	spin_lock_irqsave(&mdp->lock, flags);
-	ret = phy_start_aneg(ndev->phydev);
-	spin_unlock_irqrestore(&mdp->lock, flags);
-
-	return ret;
+	return phy_start_aneg(ndev->phydev);
 }
 
 static u32 sh_eth_get_msglevel(struct net_device *ndev)


