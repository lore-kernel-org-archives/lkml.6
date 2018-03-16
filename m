Return-Path: <grygorii.strashko@ti.com>
X-Google-Smtp-Source: AG47ELvFPMI+H/e1xwU41AuXksbMnwbuIt9Etw7v+bEgiEJG5YmsSiOHyQunRMVCoP7CF3aJwVdf
ARC-Seal: i=1; a=rsa-sha256; t=1521238119; cv=none;
        d=google.com; s=arc-20160816;
        b=MkVRZOfpuMflV83Y91v/F6e/3ikRwKhRyMbYQIx0YP1WWdmJO1BCVODkNk5JgDl2Zu
         YQRw5wAfMF1LgFxcC1WlxmtxHiSqCClPbxQ64MRDjOdX718FKieizW7JV/O95HJkr9dk
         lg5JXc6uYSn5CwhUkroaIgktrr938E1l5raSMGoUGacvcxsrPkrPjcmFaWrkKJzxuhZJ
         4g3RDAeiiztwmap5fQ2/7/iTYxwUY9m2313PIYg5jUul8wJmQ11JnWJftXJEC9GmcPk7
         hJLsg3neOV8IKG1Yo/fsz8miMq4I2JKO1cTsWTDQdnoPVpN429CACClFc0313JfixmU/
         1jPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=dL786JRDsM6NSwe3BO4KBZaMBuiXQXTc6na7ReY7oc8=;
        b=clsgnxBNyeurJg5EluC8VZBaEEl3HwGCpevKSBxuWJ1YAIoFWRqsqngI6r7lhHXWki
         uAZE5fo82Dk+JshPxoq3ki6mZLFAQYzQ7gvY3qcnOnUgKjlhuzIs445l20sPwUQjt0XZ
         tCuI16KyNY4lEkfDTECIE606SfWgBQSfvmcFZiAICZ55PeO1TLhOT4Mnwc5yDsq0JPXV
         SniN7roTlyNBbVCmsKPNmW7WIEsj/4MkBS7VAzq72TSEgYNnBR7hd3gL61ulKxMrcmA/
         8FFWiZwjODHfY/2NN/qcw4/OjzDpXsItm3d0jGDzelAxXmsP0B2lNxReiwCDVinujM3w
         lb2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=gkfdVAui;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=gkfdVAui;
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
Subject: [PATCH v2 2/2] net: phy: relax error checking when creating sysfs link netdev->phydev
Date: Fri, 16 Mar 2018 17:08:35 -0500
Message-ID: <20180316220835.30006-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20180316220835.30006-1-grygorii.strashko@ti.com>
References: <20180316220835.30006-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595133782136044428?=
X-GMAIL-MSGID: =?utf-8?q?1595133781872094183?=
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
sysfs_create_link_nowarn() and adding error message instead.
After this change links (phy->netdev and netdev->phy) creation failure is not
fatal any more and system can continue working, which fixes TI CPSW issue.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
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
