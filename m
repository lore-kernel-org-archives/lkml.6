Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBD9C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDBD20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcxMlgXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390221AbfAOXJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:09:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45550 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbfAOXJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:09:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so2019470pfd.12;
        Tue, 15 Jan 2019 15:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2713uGBszd3dEaGPmjaNVa1+AJ8H/PlaoGwKqkrQuSg=;
        b=GcxMlgXvGiHGUhr3bGfeTWWPo2BNigxeR+nKbnwJPF8rRBGhHFGW6vKPyNBVfHJABj
         OPU1DfnF5p/wlQOrMSpQv2v0OApYSFs/1XRRHJ/rlvdgLQZCGJmwRJesClj9Pii7PJSS
         DX+6zr7XZMS/XIletiCGnimfZRY+wDwHT/6Gq4Llu6v3tgGl8/Ir2OV7EUBecvFVyk5b
         X/BOb9RPO6oiWiBAhKHrGGuEgAgtEUl3gu2gM+f4PwemoBKirVSUcO1Ekj30hK/nqznp
         Bfzh1cNJv++1f3xhYaLGFCzo5S3vdTgUQ7w4JjBKjPN6EdZovzORMllQGg8Bhtlf/zBC
         pF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2713uGBszd3dEaGPmjaNVa1+AJ8H/PlaoGwKqkrQuSg=;
        b=VHr+lktPLXJPrsW3/6t+bKNwqA49qV1atXsF23cVIQNu0+iAeP7PSIT10NaP0aVoU1
         TXD/kUL1KrYQDXKD97zgkd0Oy7FYAOLYNtnG+zi/bpowMdA7LR0NbdveJJ6mrZH8vvxB
         jOwGFlNlAhO1p/IkH5pmHKdash/s+8MaV8RZSQQlzGNbNxbcF9wMlfi11jWg2cBBhWE9
         ByJ15WHbyIzH9husp3oUkMBLViVrCVXGo1hMrkvPCQtqRf7wGMLRPwAkjn2dLcP7hDfw
         OQcd+qke8jJ2XzfQlBJlR3GBh01DHH2rYceuibmhlAwaiEapdRv5w0Aq7QznrGeZ2FTe
         nRsw==
X-Gm-Message-State: AJcUukdpSQLkaaY5f7DQ8SJfQFu0xSoKoYBsslGb5IEIWHPnI/9Nkedu
        q2lgDeO4uAWuqUWq5tctHudYUsFJ
X-Google-Smtp-Source: ALg8bN6bmZ0JYRCrv46r7CA6dFCR2MRwf+Ovpq1CTKipnPogcbeA9whkPrIbzrPFzI8X+Up+shwt/Q==
X-Received: by 2002:a62:9fcf:: with SMTP id v76mr1067769pfk.144.1547593779984;
        Tue, 15 Jan 2019 15:09:39 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id s130sm5682434pgc.60.2019.01.15.15.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 15:09:39 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: phy: Add helpers to determine if PHY driver is generic
Date:   Tue, 15 Jan 2019 15:09:35 -0800
Message-Id: <20190115230936.28890-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are already checking in phy_detach() that the PHY driver is of
generic kind (1G or 10G) and we are going to make use of that in the SFP
layer as well for 1000BaseT SFP modules, so expose helper functions to
return that information.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/phy_device.c | 34 ++++++++++++++++++++++++++++++++--
 include/linux/phy.h          |  3 +++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 51990002d495..14f148c2b9ea 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1279,6 +1279,36 @@ struct phy_device *phy_attach(struct net_device *dev, const char *bus_id,
 }
 EXPORT_SYMBOL(phy_attach);
 
+static bool phy_driver_is_genphy_kind(struct phy_device *phydev,
+				      struct device_driver *driver)
+{
+	struct device *d = &phydev->mdio.dev;
+	bool ret = false;
+
+	if (!phydev->drv)
+		return ret;
+
+	get_device(d);
+	ret = d->driver == driver;
+	put_device(d);
+
+	return ret;
+}
+
+bool phy_driver_is_genphy(struct phy_device *phydev)
+{
+	return phy_driver_is_genphy_kind(phydev,
+					 &genphy_driver.mdiodrv.driver);
+}
+EXPORT_SYMBOL_GPL(phy_driver_is_genphy);
+
+bool phy_driver_is_genphy_10g(struct phy_device *phydev)
+{
+	return phy_driver_is_genphy_kind(phydev,
+					 &genphy_10g_driver.mdiodrv.driver);
+}
+EXPORT_SYMBOL_GPL(phy_driver_is_genphy_10g);
+
 /**
  * phy_detach - detach a PHY device from its network device
  * @phydev: target phy_device struct
@@ -1310,8 +1340,8 @@ void phy_detach(struct phy_device *phydev)
 	 * from the generic driver so that there's a chance a
 	 * real driver could be loaded
 	 */
-	if (phydev->mdio.dev.driver == &genphy_10g_driver.mdiodrv.driver ||
-	    phydev->mdio.dev.driver == &genphy_driver.mdiodrv.driver)
+	if (phy_driver_is_genphy(phydev) ||
+	    phy_driver_is_genphy_10g(phydev))
 		device_release_driver(&phydev->mdio.dev);
 
 	/*
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3b051f761450..f1c19bf8c658 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1183,4 +1183,7 @@ module_exit(phy_module_exit)
 #define module_phy_driver(__phy_drivers)				\
 	phy_module_driver(__phy_drivers, ARRAY_SIZE(__phy_drivers))
 
+bool phy_driver_is_genphy(struct phy_device *phydev);
+bool phy_driver_is_genphy_10g(struct phy_device *phydev);
+
 #endif /* __PHY_H */
-- 
2.17.1

