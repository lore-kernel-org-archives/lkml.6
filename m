Return-Path: <grygorii.strashko@ti.com>
X-Google-Smtp-Source: AG47ELujUIyQz3Do8rwh/eDwOp7eFpELW6Tv23lGiig9Sq1Ykb01KYHoMAwPcfx3lGSnIpL+PX/h
ARC-Seal: i=1; a=rsa-sha256; t=1521066390; cv=none;
        d=google.com; s=arc-20160816;
        b=yoKsdgHSNYwt24RcNAK3YyDIfeaeAIUElM5lW8HA4Wj+ALiWuRyOrzK9VNgLtFntQY
         mCgwDitwAdwtkb/3ABtTefd78XlV/SNVkagK4KHbgwg6QaUGbxJMhCzl3PGaM/5CyYT2
         G0Z6DEB9ME1GirZu10suUtyTQy1GLM0oZYOrLHA+XB6tszZGbED/naL3yuE1emAXyBEH
         aqtehn4pFAipKXqn9HKs8SRtNmoGF1gwBtp406xMEq9ucs5GW6b2DHIYlnAmO5DGAVgN
         Zvw5RjrTPySsokFBPBb588Nv8WJLJjM6p+97llVewQZGLp8f8/f0u+mLpN/WbLCWBnGi
         krjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Zzz5HVlgn5sOhAmgFw06WOxTawYVb9EwDaeb0rR/kuY=;
        b=nns3Fg8x9grQXxjC+liCsGMxhZKXN/SO4HEGweYoGSUqXFyj4AbhiEPXgfOZGR7FAO
         crYv7Pp8UzzrDvm3pdFIgMTMH9xEVSWQJOzq2D5OL5Ad6KEObnaF8X1gAASC44Nh/E1G
         Bo8BxWAjGfLs/dg6hK4DIAHVEG1UoTlNAKSOXE2r30ue/06HyrfiMO2QdQpM285dVfzG
         7hK2Jr/2JBLqsMZN+9sd3j3g7k3pwLEIwAzoxLD9NaiLDuEfmFO4IUcNzW3TzgaGtj31
         gLZ5xIycjmhEN9nyJdD95gORmx/biGRLlCusKGUzZZsgsuMiAhmesJ3uze+FLv1DN/+Q
         lkkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=gUl4/Big;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=gUl4/Big;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/2] net: phy: relax error checking when creating sysfs link netdev->phydev
Date: Wed, 14 Mar 2018 17:26:24 -0500
Message-ID: <20180314222624.12744-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20180314222624.12744-1-grygorii.strashko@ti.com>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953711945737346?=
X-GMAIL-MSGID: =?utf-8?q?1594953711945737346?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some ethernet drivers (like TI CPSW) may connect and manage >1 Net PHYs per
one netdevice, as result such drivers will produce warning during system
boot and fail to connect second phy to netdevice when PHYLIB framework
will try to create sysfs link netdev->phydev for second PHY
in phy_attach_direct(), because sysfs link with the same name has been
created already for the first PHY. As result, second CPSW external
port will became unusable.

Fix it by relaxing error checking when PHYLIB framework is creating sysfs
link netdev->phydev in phy_attach_direct(), suppressing warning by using
sysfs_create_link_nowarn() and adding debug message instead.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Fixes: a3995460491d ("net: phy: Relax error checking on sysfs_create_link()")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/phy/phy_device.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 478405e..fe16f58 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1012,10 +1012,17 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	err = sysfs_create_link(&phydev->mdio.dev.kobj, &dev->dev.kobj,
 				"attached_dev");
 	if (!err) {
-		err = sysfs_create_link(&dev->dev.kobj, &phydev->mdio.dev.kobj,
-					"phydev");
-		if (err)
-			goto error;
+		err = sysfs_create_link_nowarn(&dev->dev.kobj,
+					       &phydev->mdio.dev.kobj,
+					       "phydev");
+		if (err) {
+			dev_err(&dev->dev, "could not add device link to %s err %d\n",
+				kobject_name(&phydev->mdio.dev.kobj),
+				err);
+			/* non-fatal - some net drivers can use one netdevice
+			 * with more then one phy
+			 */
+		}
 
 		phydev->sysfs_links = true;
 	}
-- 
2.10.5
