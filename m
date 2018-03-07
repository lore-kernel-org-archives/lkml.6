Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsDoqFlXsccjYhnoJJjmtLwxP5CGzLOd8sYtIhv6jtPZXHxx59SQ7bIzECgcMRYrabS4Y3D
ARC-Seal: i=1; a=rsa-sha256; t=1520451751; cv=none;
        d=google.com; s=arc-20160816;
        b=DJAQktjsPI6YAkUBmnHdXKcUfyvq//wabWlYz0vPeKzCXOXBMDnWTMmS8vE68+VJyi
         acHyzW7vMa0Wxjc2kBeHg+HXpDDQmOeH/+Uz8f1t8OiS6va6bgGs5li/5TWQK5rN2s74
         fVTkGQTQyRkBeKdt6RUw8LiXF3qU/6F7thPu63Fo3ctO8CeGBbCLHVj/s+8Qw3qIOkpR
         pcnFxXJwpkEIM5Wh3P1KpdonIJa5weoUnCZ/PRGdJowoC/WAhQW1riWGSm5DRtrKBx8n
         FCS9JkOr4yGX3faB7nYVd1qWdC2sBFJboUtYSiWP1d4rfi2Jb8wa0JlsY/euZ8V2m7sX
         /9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=i9yYyYmwMqhKb1S+jQmN4/D1mHbZWCJwSynLJKeRNpc=;
        b=f90kIw3AScbh6+HsT6UbVzG1R+kFVPs1gmRgJmYpfiqewLZWa9bOB8M/jiDx7rM3pw
         WxYOsObIQMSX8Fyw+p+0zP6hyLHUUdC5MOWckr5Jqiw6y5C7ZDPDsgbEWSqdrx1o/EG5
         bivKMdf5idF9zOWTiNrOZPmCrrfbGeLsqx5QDZUaKtSWY/g/cUsNNe7yPWCAB3Tg21eL
         U/2iCsN87N7lP7cZXvfpQgB5Fqu8cNBNQKfXVOA/vc/eppaq0Cq5P1MdgTxQxqOaWbWj
         b5jrM0G+TP+7kR3Gw21vQLPlT0uDzdyZGYPbzroRyTnJRlGtc5srqb9AAVCnSuzNYudg
         Mrqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 081/122] net: phy: Restore phy_resume() locking assumption
Date: Wed,  7 Mar 2018 11:38:13 -0800
Message-Id: <20180307191740.978694395@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309216117042404?=
X-GMAIL-MSGID: =?utf-8?q?1594309216117042404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>


[ Upstream commit 9c2c2e62df3fa30fb13fbeb7512a4eede729383b ]

commit f5e64032a799 ("net: phy: fix resume handling") changes the
locking semantics for phy_resume() such that the caller now needs to
hold the phy mutex. Not all call sites were adopted to this new
semantic, resulting in warnings from the added
WARN_ON(!mutex_is_locked(&phydev->lock)).  Rather than change the
semantics, add a __phy_resume() and restore the old behavior of
phy_resume().

Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Fixes: f5e64032a799 ("net: phy: fix resume handling")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy.c        |    2 +-
 drivers/net/phy/phy_device.c |   18 +++++++++++++-----
 include/linux/phy.h          |    1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -841,7 +841,7 @@ void phy_start(struct phy_device *phydev
 		break;
 	case PHY_HALTED:
 		/* if phy was suspended, bring the physical link up again */
-		phy_resume(phydev);
+		__phy_resume(phydev);
 
 		/* make sure interrupts are re-enabled for the PHY */
 		if (phy_interrupt_is_valid(phydev)) {
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -135,9 +135,7 @@ static int mdio_bus_phy_resume(struct de
 	if (!mdio_bus_phy_may_suspend(phydev))
 		goto no_resume;
 
-	mutex_lock(&phydev->lock);
 	ret = phy_resume(phydev);
-	mutex_unlock(&phydev->lock);
 	if (ret < 0)
 		return ret;
 
@@ -1028,9 +1026,7 @@ int phy_attach_direct(struct net_device
 	if (err)
 		goto error;
 
-	mutex_lock(&phydev->lock);
 	phy_resume(phydev);
-	mutex_unlock(&phydev->lock);
 	phy_led_triggers_register(phydev);
 
 	return err;
@@ -1156,7 +1152,7 @@ int phy_suspend(struct phy_device *phyde
 }
 EXPORT_SYMBOL(phy_suspend);
 
-int phy_resume(struct phy_device *phydev)
+int __phy_resume(struct phy_device *phydev)
 {
 	struct phy_driver *phydrv = to_phy_driver(phydev->mdio.dev.driver);
 	int ret = 0;
@@ -1173,6 +1169,18 @@ int phy_resume(struct phy_device *phydev
 
 	return ret;
 }
+EXPORT_SYMBOL(__phy_resume);
+
+int phy_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	mutex_lock(&phydev->lock);
+	ret = __phy_resume(phydev);
+	mutex_unlock(&phydev->lock);
+
+	return ret;
+}
 EXPORT_SYMBOL(phy_resume);
 
 int phy_loopback(struct phy_device *phydev, bool enable)
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -819,6 +819,7 @@ void phy_device_remove(struct phy_device
 int phy_init_hw(struct phy_device *phydev);
 int phy_suspend(struct phy_device *phydev);
 int phy_resume(struct phy_device *phydev);
+int __phy_resume(struct phy_device *phydev);
 int phy_loopback(struct phy_device *phydev, bool enable);
 struct phy_device *phy_attach(struct net_device *dev, const char *bus_id,
 			      phy_interface_t interface);
