Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C28C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADF020879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079154;
	bh=HsfQMWgCE02UJ31MTxOpws29BPUEdNSf/yDJKookEsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K4MLBWyvAKetDPRerbCMzyJXYspyF6ZeMEw/EeIBdyZ7qPsW3fkZbUfAOEMjmz31e
	 EvjTgqQ0BuBEbY4walNSfqVvuKhPlxwBJnAsoimZ3dnBj201dW+oBQ2MzinXo6kEZp
	 j1r53sOPP/FqtieDP5sOHWaO441+6Bgwfj03kQek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbfAUN7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:59:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbfAUN7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:59:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38ED02084C;
        Mon, 21 Jan 2019 13:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079149;
        bh=HsfQMWgCE02UJ31MTxOpws29BPUEdNSf/yDJKookEsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5aFeZJqoU1ttLNtRh7P1qUsAHiPL/aKNCDVQzJk1x3P0SURPlYXhPjs2AJHkG6mB
         wfMjAaBK1UFRpu/WfrCdAR6Du2eHiaJI4EhHEirD8HzxloCwtsRSUN2YpKOe72YQSq
         JR2IxlxpuWjHOk8n4D7oR2FU2lPWAUeazrDKafZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan Whitehead <Bryan.Whitehead@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 25/99] lan743x: Remove phy_read from link status change function
Date:   Mon, 21 Jan 2019 14:48:17 +0100
Message-Id: <20190121134914.858908425@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bryan Whitehead <Bryan.Whitehead@microchip.com>

[ Upstream commit a0071840d2040ea1b27e5a008182b09b88defc15 ]

It has been noticed that some phys do not have the registers
required by the previous implementation.

To fix this, instead of using phy_read, the required information
is extracted from the phy_device structure.

fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: Bryan Whitehead <Bryan.Whitehead@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -962,13 +962,10 @@ static void lan743x_phy_link_status_chan
 
 		memset(&ksettings, 0, sizeof(ksettings));
 		phy_ethtool_get_link_ksettings(netdev, &ksettings);
-		local_advertisement = phy_read(phydev, MII_ADVERTISE);
-		if (local_advertisement < 0)
-			return;
-
-		remote_advertisement = phy_read(phydev, MII_LPA);
-		if (remote_advertisement < 0)
-			return;
+		local_advertisement =
+			ethtool_adv_to_mii_adv_t(phydev->advertising);
+		remote_advertisement =
+			ethtool_adv_to_mii_adv_t(phydev->lp_advertising);
 
 		lan743x_phy_update_flowcontrol(adapter,
 					       ksettings.base.duplex,


