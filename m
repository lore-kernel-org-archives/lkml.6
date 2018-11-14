Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A414C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2037E2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2cLGxFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2037E2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbeKOI3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733161AbeKOI3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:24 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 299A52252C;
        Wed, 14 Nov 2018 22:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234260;
        bh=GfEuefqR47puI99k2KhJ7QjFX9XdAstorKkoqRbIYMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G2cLGxFwgwhVHypA+FScRSF6AgwbxDYmF34HEuSeX3/Tni+l/CFGa+WDsOe9z+8XG
         wjWb3m0ZVH0LtmgM6e2l5LPl5FDkbE+s1bWLEqegEVLrEKiAg3p41ivWo7gGEKLwhQ
         n6koPic5Q/A1ch2+6AEw3mPCYkOdRLDNRBgM3Bgc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Holger=20Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 23/59] net: phy: realtek: fix RTL8201F sysfs name
Date:   Wed, 14 Nov 2018 17:22:55 -0500
Message-Id: <20181114222335.99339-23-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holger Hoffstätte <holger@applied-asynchrony.com>

[ Upstream commit 0432e833191ad4d17b7fc2364941f91dad51db1a ]

Since 4.19 the following error in sysfs has appeared when using the
r8169 NIC driver:

$cd /sys/module/realtek/drivers
$ls -l
ls: cannot access 'mdio_bus:RTL8201F 10/100Mbps Ethernet': No such file or directory
[..garbled dir entries follow..]

Apparently the forward slash in "10/100Mbps Ethernet" is interpreted
as directory separator that leads nowhere, and was introduced in commit
513588dd44b ("net: phy: realtek: add RTL8201F phy-id and functions").

Fix this by removing the offending slash in the driver name.

Other drivers in net/phy seem to have the same problem, but I cannot
test/verify them.

Fixes: 513588dd44b ("net: phy: realtek: add RTL8201F phy-id and functions")
Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 082fb40c656d..c278a870484c 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -168,7 +168,7 @@ static struct phy_driver realtek_drvs[] = {
 		.flags          = PHY_HAS_INTERRUPT,
 	}, {
 		.phy_id		= 0x001cc816,
-		.name		= "RTL8201F 10/100Mbps Ethernet",
+		.name		= "RTL8201F Fast Ethernet",
 		.phy_id_mask	= 0x001fffff,
 		.features	= PHY_BASIC_FEATURES,
 		.flags		= PHY_HAS_INTERRUPT,
-- 
2.17.1

