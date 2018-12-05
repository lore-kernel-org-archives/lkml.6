Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92D3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BA42146D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039476;
	bh=ohsLwIEi2p7/+QJ3iaqjbvX2dSnYZv8lsb0qnV1anig=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KKUg7ptLrc7NYDSbY/eSd6lDIIcbTrqySxi+eSCziDdp9A+9N2864nhslSuYXRhA5
	 Cj5SMaeAke/7pkiZtpc6jrpFaVsxgIzlH94Z+vNCO2HZOFpGPvbaU5Oap8nj7lemaq
	 KTLQhWvyXBM0E0JH1ximLxSu7iTbq3ayrXXoeC/E=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BA42146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeLETvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:15 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46298 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbeLETvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:13 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so18596046oif.13;
        Wed, 05 Dec 2018 11:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kV+bfkiFbMBXJunTBXrEXEZOatnnsr69uBsZeOB6vV8=;
        b=Qf35j1AnfIusUGol2qoPYMrNlSmw53zQnAFvZSwAwqw+zVpBot2hlxER3i8BxuTdoU
         ZPQCVtrxPX1mRO8Skkp24Zd1wgF21enFCaUsxzpZDHpQP8GfOO+PK0GSWM50wEsKK99m
         j/KmQ/FBReTqnX5REbokB7N84wZoZA98jpF6wD6TkG1n6WGb1399NgXlLNSiQ0sdnJYP
         4ftqGPbJrFtihBxPNs6EUPtyd3GVZB+AxKYsqtGgyAPdSjdvMk1/syyzyBxXIAWhO+ga
         Qpl0OKZ8qw2MuB7egxJ9ioWYs7uNEj32p0KuJU2q3W6U2L+0EOg9ML2iwxTTL0oyyUn3
         +Z3A==
X-Gm-Message-State: AA+aEWatSVDIf3ispLXB5K6/cYtuOZTFl6Zp8gXT61xDPoPrc8GDuS30
        D1fZjs5PfjZ16FqDmtTVKkPQFms=
X-Google-Smtp-Source: AFSGD/Vw2xyPBuMfRWc6LCcAZLtIZgBj6fkHey+JeMWTTALy+VvNSUAe0KUClEvAfXtfSq5Ir78asw==
X-Received: by 2002:a54:468b:: with SMTP id k11mr14909094oic.27.1544039472473;
        Wed, 05 Dec 2018 11:51:12 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:11 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] phy: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:35 -0600
Message-Id: <20181205195050.4759-19-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which all of these are.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 +++---
 drivers/phy/rockchip/phy-rockchip-typec.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 24bd2717abdb..91fba60267a0 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1168,8 +1168,8 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		struct phy *phy;
 
 		/* This driver aims to support both otg-port and host-port */
-		if (of_node_cmp(child_np->name, "host-port") &&
-		    of_node_cmp(child_np->name, "otg-port"))
+		if (!of_node_name_eq(child_np, "host-port") &&
+		    !of_node_name_eq(child_np, "otg-port"))
 			goto next_child;
 
 		phy = devm_phy_create(dev, child_np, &rockchip_usb2phy_ops);
@@ -1183,7 +1183,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		phy_set_drvdata(rport->phy, rport);
 
 		/* initialize otg/host port separately */
-		if (!of_node_cmp(child_np->name, "host-port")) {
+		if (of_node_name_eq(child_np, "host-port")) {
 			ret = rockchip_usb2phy_host_port_init(rphy, rport,
 							      child_np);
 			if (ret)
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index c57e496f0b0c..e32edeebcd63 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -1176,10 +1176,10 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(np, child_np) {
 		struct phy *phy;
 
-		if (!of_node_cmp(child_np->name, "dp-port"))
+		if (of_node_name_eq(child_np, "dp-port"))
 			phy = devm_phy_create(dev, child_np,
 					      &rockchip_dp_phy_ops);
-		else if (!of_node_cmp(child_np->name, "usb3-port"))
+		else if (of_node_name_eq(child_np, "usb3-port"))
 			phy = devm_phy_create(dev, child_np,
 					      &rockchip_usb3_phy_ops);
 		else
-- 
2.19.1

