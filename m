Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33FAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673EE206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865245;
	bh=XQ4bDL8QOtY3q/l8Svb57V2H7TDJ4zk2e9klQAPRtr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XmgHrMGhHspM+UCLh8L0asithTlZiCYtCRbZqgTYz9T5g4eWyHPsoFxenl9sVBo7k
	 o+foU9zQyLvr/omolYqQ5My3J3ILNAiyxoFFuz/dhgX8oe2kh1shiYE0rDv20YqEx9
	 ZMwE1x3BKzy6/txSMso+wxUFZwN/fu/NeFjwZP7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfAGMpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:45:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbfAGMpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A78C2183E;
        Mon,  7 Jan 2019 12:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865141;
        bh=XQ4bDL8QOtY3q/l8Svb57V2H7TDJ4zk2e9klQAPRtr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yHCM1Wz6xS9TUSTRVqIZKFWfhcJ9qmbzg0HR6ssms1ez7kSnhU9I7372hfvuSVnjx
         SCuFRUtvGDBvr46yplfAGlpa40pdP9bx+5sj0oIF9bsGllIr00WmDVt8BN2lAwZVqG
         EFzzafza1R3ulloEEjv0/WDYOZK4dSlknQevKlmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 017/170] net: phy: Fix the issue that netif always links up after resuming
Date:   Mon,  7 Jan 2019 13:30:44 +0100
Message-Id: <20190107104455.068553047@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

[ Upstream commit 8742beb50f2db903d3b6d69ddd81d67ce9914453 ]

Even though the link is down before entering hibernation,
there is an issue that the network interface always links up after resuming
from hibernation.

If the link is still down before enabling the network interface,
and after resuming from hibernation, the phydev->state is forcibly set
to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.

In suspend sequence, only if the PHY is attached, mdio_bus_phy_suspend()
calls phy_stop_machine(), and mdio_bus_phy_resume() calls
phy_start_machine().
In resume sequence, it's enough to do the same as mdio_bus_phy_resume()
because the state has been preserved.

This patch fixes the issue by calling phy_start_machine() in
mdio_bus_phy_restore() in the same way as mdio_bus_phy_resume().

Fixes: bc87922ff59d ("phy: Move PHY PM operations into phy_device")
Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy_device.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -164,11 +164,8 @@ static int mdio_bus_phy_restore(struct d
 	if (ret < 0)
 		return ret;
 
-	/* The PHY needs to renegotiate. */
-	phydev->link = 0;
-	phydev->state = PHY_UP;
-
-	phy_start_machine(phydev);
+	if (phydev->attached_dev && phydev->adjust_link)
+		phy_start_machine(phydev);
 
 	return 0;
 }


