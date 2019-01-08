Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84C2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895DF2173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975666;
	bh=g0/Ab+Tn1m8YDkCvB0BaAEPtCdvKF3jldGCcdYS8jOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DgsKSfwp1Igd1DwRLTsrkDG2xjYwEQCCtzg/Yf0uSJZZoesQ9pUZNtQ0YIE+bdV48
	 jtPeDa8GPFuLfyoeOalPPBDvENBGNNQywPrySnUO4UAWRdmkhWHfo5w94X+IrfPPgG
	 sYlh5Kfp6pz/89YdM2Yy384jFgcseuKcF61itXno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfAHT1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:27:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729734AbfAHT1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:27:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94BBA20827;
        Tue,  8 Jan 2019 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975658;
        bh=g0/Ab+Tn1m8YDkCvB0BaAEPtCdvKF3jldGCcdYS8jOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5Nfd/ROsTma8/rSVFWL9WhkxA8ALWngRVsbLquXDJY7pvHhQFOD6H1IUYo5dd/Bl
         J99Ln/V/j/oYdrwAa145EwJu98/SsY+ayLsji9PRTVrpZ44qGIWFDpcktgPHajEro7
         Hw/XM1UvLbrmIzRHj0FKxcF0a0mU1zgqpLeOIt7o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 038/117] net: ethernet: ave: Set initial wol state to disabled
Date:   Tue,  8 Jan 2019 14:25:06 -0500
Message-Id: <20190108192628.121270-38-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

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

