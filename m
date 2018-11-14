Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85342C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2912145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fr0701My"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2912145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbeKOItI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbeKOI1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:18 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B96F22513;
        Wed, 14 Nov 2018 22:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234135;
        bh=/GjJbxXY2PF+II1TwvnBfr1vR9hWy7TvKGclXlQKzf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fr0701MyvIadXCAkX2XURM+wvdvCMgs2UZHI+OmcbqvR9nqIsLhpJMRBA/yhb9IX2
         mVkzCuFgqWZxFA2hWUZRt8j5RnvZq8LkAsPMbJnwb/REetdkpLSAkaR/x2gZGXaAPU
         d3IgTD8CM+IOO1xlNtzdg7J9iSgnAM52UWVaxtMw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Holger=20Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 29/73] net: phy: realtek: fix RTL8201F sysfs name
Date:   Wed, 14 Nov 2018 17:21:23 -0500
Message-Id: <20181114222207.98701-29-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
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
index 7fc8508b5231..271e8adc39f1 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -220,7 +220,7 @@ static struct phy_driver realtek_drvs[] = {
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

