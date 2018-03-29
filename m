Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48XeClhyhsJL5pkvg+UXQ/rL1hTzVaCIU7+LcQbQdAyYmfxFQjN3+GLeKhWFIezjbLez2dJ
ARC-Seal: i=1; a=rsa-sha256; t=1522346522; cv=none;
        d=google.com; s=arc-20160816;
        b=m0Rndwr8fcBDLZ2Yy0TAt6OG4UfvDfrje4+mIdZC0MfbnOm3uPRX20VeHyMZaywunX
         x0e7EWj4H2tRsw3JEmcW0HzqIpKohO3QKfK4aAPA7GohmBu+KUfQPkTmDXsWCLATOO3I
         WU2nPP80BevAAaZvnkAyvxyvtCepyy7Q6PLGnpn5AcWS2hmCmGymR5kLqKJ78zliW9Z9
         UWStMfm7Otyg2GiwV8B3XRlJLqQudRLHGIxXh/NQyYiswE2hFra5fENS7VYRIpAPHYA+
         SwtMSUB1dCrXrCJXzW4ax8NFs/Gqx0MLrvrH6u+3lmgkizjjjrCC5toVDqsMIY9UIMH3
         xE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NbYTuZMfuAXyNgJzdxH1uNOnX3LMAOAhYYBuEgLzuXM=;
        b=CF9D1RXIR+cfo92OQj+wwtzMJxkEPuMGrR/TZmgK7spvP4xZZy5RYOBOj8eXEW5ESm
         8Wa7jOsu29yEloVUwfXpK8HVMkVia1TBBF81QZM1lmhIvj0MGKRqkEeBgp1zynkN1Lil
         u6wura/0v43ayDqdaZ4PGFmx8kqUmKBO6kYp59kBiPIpa+oEal8SIletPyf3JiBsDSTd
         UnsrklO5w6YsBFjZmRETX2CNE10HmLfZeSPwhK8/eWW8j2gHje05PnKUl4yJFj9x5+JH
         2SgD/BF3cFnYyxr2Z4CdC2Z2amWaNTXDg4S3COJTQSjJhKeAQpm/HCHnMPc3O8B3YfAi
         aGhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 07/47] net: phy: relax error checking when creating sysfs link netdev->phydev
Date: Thu, 29 Mar 2018 19:59:48 +0200
Message-Id: <20180329175729.678329945@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296027400290457?=
X-GMAIL-MSGID: =?utf-8?q?1596296027400290457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Grygorii Strashko <grygorii.strashko@ti.com>


[ Upstream commit 4414b3ed74be0e205e04e12cd83542a727d88255 ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy_device.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -999,10 +999,17 @@ int phy_attach_direct(struct net_device
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
