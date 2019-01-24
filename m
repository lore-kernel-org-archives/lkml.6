Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EC6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D0A218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358853;
	bh=YvR4T+gE9ArdDFCwfhGv5otiSE1rAfnQY6iG1AMKZUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YapSYs5bZcPKD3TB+UQ11XB/uVbif4a0sNsM8lcfHMLebHASqSHjbAtAlD/Q5Upx6
	 U8b3sMQcimCqccFkNzYgyBITjkLvTZy/aXE1Ercaryu4YsHZPGAelr8oPgKYNkS1BO
	 XHoHAZp9ulDNpkytSmHPHIaySKDGO46CqUzTArqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbfAXTkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:40:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387470AbfAXTkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:40:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F0BD218D0;
        Thu, 24 Jan 2019 19:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358845;
        bh=YvR4T+gE9ArdDFCwfhGv5otiSE1rAfnQY6iG1AMKZUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3jkwJYnmRLHzPB+pY/fAULDnXuATjnjxYoQdm3LVPuKiSaKSIyMB9Jb7X0mJmrll
         pDQ5YMz1RSDuqEX4awPDx/YeUhbmQTcaRlZfyWnEgNtRE7pQ7hvCyFKydYcz+vKeQ5
         8/kLIBmYaTLE1re6/93PVfp7b6db53H1zgYISUuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 047/127] net: ethernet: ave: Set initial wol state to disabled
Date:   Thu, 24 Jan 2019 20:19:53 +0100
Message-Id: <20190124190214.243564069@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7200f2e3c9e267d29e2bfa075794339032e0b98e ]

If wol state of phy hardware is enabled after reset, phy_ethtool_get_wol()
returns that wol.wolopts is true.

However, since net_device.wol_enabled is zero and this doesn't apply wol
state until calling ethtool_set_wol(), so mdio_bus_phy_may_suspend()
returns true, that is, it's in a state where phy can suspend even though
wol state is enabled.

In this inconsistency, phy_suspend() returns -EBUSY, and at last,
suspend sequence fails with the following message:

    dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x58 returns -16
    PM: Device 65000000.ethernet-ffffffff:01 failed to suspend: error -16
    PM: Some devices failed to suspend, or early wake event detected

In order to fix the above issue, this patch forces to set initial wol state
to disabled as default.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/socionext/sni_ave.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 7c7cd9d94bcc..3d0114ba2bfe 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1210,9 +1210,13 @@ static int ave_init(struct net_device *ndev)
 
 	priv->phydev = phydev;
 
-	phy_ethtool_get_wol(phydev, &wol);
+	ave_ethtool_get_wol(ndev, &wol);
 	device_set_wakeup_capable(&ndev->dev, !!wol.supported);
 
+	/* set wol initial state disabled */
+	wol.wolopts = 0;
+	ave_ethtool_set_wol(ndev, &wol);
+
 	if (!phy_interface_is_rgmii(phydev))
 		phy_set_max_speed(phydev, SPEED_100);
 
-- 
2.19.1



