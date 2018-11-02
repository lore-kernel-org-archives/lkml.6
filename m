Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEC2C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D562082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2NGo9IlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D562082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeKCDpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbeKCDpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:45:13 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3DD42081B;
        Fri,  2 Nov 2018 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183822;
        bh=/awlyUUM9d7n9POnmphbP2Kt5GrKEI3QrCnFB3zNYS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2NGo9IlYXjV5B/AkgYrQZ2v+tEEu7dQ9ZoGI1voFYHMOc7r87PNgmwqbfKSM6cJAb
         nEwK+f3rFgciEC/0LdVYqxWnG/pt8l3/z2mjolEjU3h904SxudTBmNbHAJvr/Z2O8F
         3hEVjqGYHcrCeY4o7uKqjoUBGvU95RrTQun2Z0+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neil MacLeod <neil@nmacleod.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 18/24] r8169: fix broken Wake-on-LAN from S5 (poweroff)
Date:   Fri,  2 Nov 2018 19:34:51 +0100
Message-Id: <20181102182842.573472714@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182839.725385066@linuxfoundation.org>
References: <20181102182839.725385066@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 649f0837a8cc2b39329f2de00fa0d04b029291c5 ]

It was reported that WoL from S5 is broken (WoL from S3 works) and the
analysis showed that during system shutdown the network interface was
brought down already when the actual kernel shutdown started.
Therefore netif_running() returned false and as a consequence the PHY
was suspended. Obviously WoL wasn't working then.
To fix this the original patch needs to be effectively reverted.
A side effect is that when normally bringing down the interface and
WoL is enabled the PHY will remain powered on (like it was before the
original patch).

Fixes: fe87bef01f9b ("r8169: don't check WoL when powering down PHY and interface is down")
Reported-by: Neil MacLeod <neil@nmacleod.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -4175,10 +4175,15 @@ static void rtl_wol_suspend_quirk(struct
 
 static bool rtl_wol_pll_power_down(struct rtl8169_private *tp)
 {
-	if (!netif_running(tp->dev) || !__rtl8169_get_wol(tp))
+	struct phy_device *phydev;
+
+	if (!__rtl8169_get_wol(tp))
 		return false;
 
-	phy_speed_down(tp->dev->phydev, false);
+	/* phydev may not be attached to netdevice */
+	phydev = mdiobus_get_phy(tp->mii_bus, 0);
+
+	phy_speed_down(phydev, false);
 	rtl_wol_suspend_quirk(tp);
 
 	return true;


