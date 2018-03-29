Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+xrt6jT7/4tzYWUYF6PkochLCBGVG9ccUDZEYvSlb8DtvRFNVyh9Wrrog4P16VHRcbcjg3
ARC-Seal: i=1; a=rsa-sha256; t=1522346686; cv=none;
        d=google.com; s=arc-20160816;
        b=ZJnh1Lk7ZP3mSUN/PXBmOLxElGYmhj+zhyE/zA3rPyzni5cXTLJYn5gtOJ98kEVmnw
         KkPj4ISKbejUkUjt3MNhKomAhi7FlLpyPKDvCHLERAfVRyITV9braLhseHPf/QDz6Qcg
         QW2PCSE6uWj60rIae9/+rnlnRXv7tzABJqyh+08IqfQbaN2VMVSkaYjXhntBrhtaaYpH
         GtSwNpW6z0MpDMGZr0ImzxglHh1FQBgWasG27DumZWEvEwI1aD80M2WJ/HLSqO/bPqfS
         xG0uPveRGCeFvMRbbBC/XDAizNCrmnCx4sEXc11soryeLgijvaWjZYQDST+fn+eBhuW4
         cRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XxrIJSwxkZJXDur/xuS1eKPUxbkMmjql1ESX1cgzRao=;
        b=yWKb0mE0ZNeeQFH6cKBDY6iT0yu3b4Fp/GqdmVmmJ4I5CpeDC1JjsJsA+jOlANm7km
         IAefCqet0hV+3SK6HfvxVReUCMSwNUCKlIhoT6ccaaofUL+bGs5JhdJnt1/VvKXIrr/C
         WJdXvBXjz3F5NHfeV8/+OayyovPuJhYyURL/obMjvAOESapC55YtEX55oUdp8OGImNol
         HTpZ0ZCmK3tjHiX/y84GxJzpS3L3gw03eXJ4O3T9uPhGcPFTVE0P8heI5YsCV/F0ab81
         9CesJajFkbAUtjkQl7hFCbvJ/IakvnSpJLw8AbZpMHl+ZsTo8F4x5c0K5k2Gp9I9k3G3
         CAjA==
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
Subject: [PATCH 4.14 05/43] net: phy: relax error checking when creating sysfs link netdev->phydev
Date: Thu, 29 Mar 2018 20:00:00 +0200
Message-Id: <20180329175730.675306460@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296027400290457?=
X-GMAIL-MSGID: =?utf-8?q?1596296199272070708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
