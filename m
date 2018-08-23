Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B06C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6EE208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6EE208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbeHWLit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:38:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45490 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbeHWLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:38:48 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CFE47C74;
        Thu, 23 Aug 2018 08:10:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 084/130] ravb: fix invalid context bug while calling auto-negotiation by ethtool
Date:   Thu, 23 Aug 2018 09:53:20 +0200
Message-Id: <20180823074932.645848658@linuxfoundation.org>
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

[ Upstream commit 0973a4dd79fe56a3beecfcff675ba4c01df0b0c1 ]

Since commit 35b5f6b1a82b ("PHYLIB: Locking fixes for PHY I/O
potentially sleeping") phy_start_aneg() function utilizes a mutex
to serialize changes to phy state, however the helper function is
called in atomic context.

The bug can be reproduced by running "ethtool -r" command, the bug
is reported if CONFIG_DEBUG_ATOMIC_SLEEP build option is enabled.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/renesas/ravb_main.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1122,15 +1122,10 @@ error_exit:
 
 static int ravb_nway_reset(struct net_device *ndev)
 {
-	struct ravb_private *priv = netdev_priv(ndev);
 	int error = -ENODEV;
-	unsigned long flags;
 
-	if (ndev->phydev) {
-		spin_lock_irqsave(&priv->lock, flags);
+	if (ndev->phydev)
 		error = phy_start_aneg(ndev->phydev);
-		spin_unlock_irqrestore(&priv->lock, flags);
-	}
 
 	return error;
 }


