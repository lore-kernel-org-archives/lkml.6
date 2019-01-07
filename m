Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBCBC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA182089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867046;
	bh=mmXLF8aT1pGkw52DP5sy5UWhrhUanjCpYAawrKnBhCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tuQ0BGww/G5vfl1D6WxEF3x527CY21iR6004Bw7aeXqycvM7fLNgRVkW7f9bDz1Dj
	 azALPfCBTUl/9HeImrsSaP0YLo+m9VzwTJpWxyFq7U5p4/DuoeOMc8DQ2jlzbGQuEt
	 Out20O91IoVi2rGVj0+f3pwc5ulCadZMjXAAAac4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfAGNAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbfAGNAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:00:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3DEE21736;
        Mon,  7 Jan 2019 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866002;
        bh=mmXLF8aT1pGkw52DP5sy5UWhrhUanjCpYAawrKnBhCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbXc2/Gc/xuHRqGXaKeE04TBMxC9Gzvep5uGwdc+mittDp8w3Rofz2Dt/URZo7+SH
         kq/LShM1Y/13w+9nN9mNfAqE05Xp8eISnx14BoEqYnI4aVVVC0UTG7FmXisrbUSR+z
         f4ZKiVWC2eyAu2NxnsJ8giSlXl9QnhT5K2YBs9aE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 014/101] net: phy: Fix the issue that netif always links up after resuming
Date:   Mon,  7 Jan 2019 13:32:02 +0100
Message-Id: <20190107105332.304954889@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -159,11 +159,8 @@ static int mdio_bus_phy_restore(struct d
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


