Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtNKq6zWX0/UV4/fZAzMzYTjzIeBzs1B0NbyZGlI3pvMk1tfyjcbxFr0YGrF6OGeLtw951b
ARC-Seal: i=1; a=rsa-sha256; t=1521214442; cv=none;
        d=google.com; s=arc-20160816;
        b=fwbLNuEOvYYdVLGuxiduvzXOLvy9gskWDxd6nnZqoN6o4sFpfPBqaay06JIhc3jQZ8
         Wh4Yrmo4OIm3fyhXA0nOH1YznQXzidGKu21PFiR/vC+a+WTE0x9za2nrUH6wyVXeszjS
         yEt88u67+vQlnxqEQ+GeLacyPGdEVIMLKIj5v3HQTaBBLNkoOJQ9IndIp3yYcbP1mJTT
         Pl6Wh9k1FcR+KDMCrkaPUT+tzpBNeUQQfHnqD8Eb1NeKpl8XFEOVlvyYKI9sTyzx8xlE
         qUJk61A71aYZpfP8VaYv/Xe4LH68tnR5Bj4Lu6km9IBRq2qyLbopra2wXaAJgaMZ21WA
         BbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j+72SpJmeOv8iKnqp+/QlzEImMJDREbTKJudetPyQx4=;
        b=ypuHSUPoZPDXCjn4LBUty/0opGPAcAwp31CZom1MhGybDV5FCgggFOStuXGpIqoasj
         4YCTyU923X/rju38TAhP0IwdPPGhrjzD/V073dvmQkZmSN4J1rzQWWLcGt0BiTr86vz2
         0zcsXyzsQMQywuQ8mwJ5K9qfxvey9adFHEKsAtNx0tIwvhJvX14dHufvhS8zYoOTGOt5
         zT39pS+9f+jwqAgwFM3nt3BWGD7nfJ9QjhabcNhtGsv9XUVDjEbQcvKM7jzAD/O5kS3b
         VkTQOyRhC5q+BmIZmC+Z98/RMjp1IhZQZO1uDFWocT1EvNsiJY1y49z5C5di15bMt95u
         K69Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 001/109] [PATCH] net: phy: fix resume handling
Date: Fri, 16 Mar 2018 16:22:30 +0100
Message-Id: <20180316152329.909955433@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108955573114687?=
X-GMAIL-MSGID: =?utf-8?q?1595108955573114687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit f5e64032a799d4f54decc7eb6aafcdffb67f9ad9 ]

When a PHY has the BMCR_PDOWN bit set, it may decide to ignore writes
to other registers, or reset the registers to power-on defaults.
Micrel PHYs do this for their interrupt registers.

The current structure of phylib tries to enable interrupts before
resuming (and releasing) the BMCR_PDOWN bit.  This fails, causing
Micrel PHYs to stop working after a suspend/resume sequence if they
are using interrupts.

Fix this by ensuring that the PHY driver resume methods do not take
the phydev->lock mutex themselves, but the callers of phy_resume()
take that lock.  This then allows us to move the call to phy_resume()
before we enable interrupts in phy_start().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/at803x.c     |    4 ----
 drivers/net/phy/phy.c        |    9 +++------
 drivers/net/phy/phy_device.c |   10 ++++++----
 3 files changed, 9 insertions(+), 14 deletions(-)

--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -239,14 +239,10 @@ static int at803x_resume(struct phy_devi
 {
 	int value;
 
-	mutex_lock(&phydev->lock);
-
 	value = phy_read(phydev, MII_BMCR);
 	value &= ~(BMCR_PDOWN | BMCR_ISOLATE);
 	phy_write(phydev, MII_BMCR, value);
 
-	mutex_unlock(&phydev->lock);
-
 	return 0;
 }
 
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -828,7 +828,6 @@ EXPORT_SYMBOL(phy_stop);
  */
 void phy_start(struct phy_device *phydev)
 {
-	bool do_resume = false;
 	int err = 0;
 
 	mutex_lock(&phydev->lock);
@@ -841,6 +840,9 @@ void phy_start(struct phy_device *phydev
 		phydev->state = PHY_UP;
 		break;
 	case PHY_HALTED:
+		/* if phy was suspended, bring the physical link up again */
+		phy_resume(phydev);
+
 		/* make sure interrupts are re-enabled for the PHY */
 		if (phy_interrupt_is_valid(phydev)) {
 			err = phy_enable_interrupts(phydev);
@@ -849,17 +851,12 @@ void phy_start(struct phy_device *phydev
 		}
 
 		phydev->state = PHY_RESUMING;
-		do_resume = true;
 		break;
 	default:
 		break;
 	}
 	mutex_unlock(&phydev->lock);
 
-	/* if phy was suspended, bring the physical link up again */
-	if (do_resume)
-		phy_resume(phydev);
-
 	phy_trigger_machine(phydev, true);
 }
 EXPORT_SYMBOL(phy_start);
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -135,7 +135,9 @@ static int mdio_bus_phy_resume(struct de
 	if (!mdio_bus_phy_may_suspend(phydev))
 		goto no_resume;
 
+	mutex_lock(&phydev->lock);
 	ret = phy_resume(phydev);
+	mutex_unlock(&phydev->lock);
 	if (ret < 0)
 		return ret;
 
@@ -1026,7 +1028,9 @@ int phy_attach_direct(struct net_device
 	if (err)
 		goto error;
 
+	mutex_lock(&phydev->lock);
 	phy_resume(phydev);
+	mutex_unlock(&phydev->lock);
 	phy_led_triggers_register(phydev);
 
 	return err;
@@ -1157,6 +1161,8 @@ int phy_resume(struct phy_device *phydev
 	struct phy_driver *phydrv = to_phy_driver(phydev->mdio.dev.driver);
 	int ret = 0;
 
+	WARN_ON(!mutex_is_locked(&phydev->lock));
+
 	if (phydev->drv && phydrv->resume)
 		ret = phydrv->resume(phydev);
 
@@ -1639,13 +1645,9 @@ int genphy_resume(struct phy_device *phy
 {
 	int value;
 
-	mutex_lock(&phydev->lock);
-
 	value = phy_read(phydev, MII_BMCR);
 	phy_write(phydev, MII_BMCR, value & ~BMCR_PDOWN);
 
-	mutex_unlock(&phydev->lock);
-
 	return 0;
 }
 EXPORT_SYMBOL(genphy_resume);
