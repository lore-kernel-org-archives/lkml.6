Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3450821-1521219115-2-7010069222708985540
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521219114; b=hKdoIeF9A5oUkHDcL46cXfPMULZ57pY7RI6pygW0uDk+U98
    67rt/gfDn9mqKjCr7S2g0EdcD0Spk9QgGZ0gih0sSCCkycSOz8UAFyIrI8C4/oXH
    OwAEIFVmbjA1vpdWQLFsRtVfy7avKey6UHb6B5hGLRQHAA+nB3Qu7837jqRsb/MM
    XIXaOjG+fiam9orSzzCrT+9OOII7AKTHrrRmtWj7d9vcnpm6KcsjOrQ0oumC5Gi1
    xBiaSfXUcGD2lHpSLxkql/rIfnB8pPlZ5bW6hLP5LnRI+0T+H8uwYygv/xHPIFKG
    Iw+tJ/Xl3Aum97riY/qkk6fJohTwpl1LnVAWjDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521219114; bh=/+WrHXjhqle3ZnRpw9Ly6D4QuE
    qVXSWCYEufJ7ywMm4=; b=KSosRerhdWkwTrzUd0P6Yb/WGcW2RJa1U+smoeL4L7
    9bGYPXqcFIUPzTfRP5tlX9yiRudpe7/01Se0TK4pGCOP/SxwdG7X0L2W2151tNSE
    Jp5py491rhNXhYmGXqxExbNc/SQchdIHjf7w8KoGTNBVyWjJeJj+8gyJbR+KFFvA
    rUl9ds7uKCRdbmWqVuwS82gQMbn3lJe/nrwspJ2AryYTksf7m7G+3I/0ypqX/Rfq
    gJizWs2kY0VTLN7VURl2wbyG1FIGXmrU58C3DOTVtkSIDu9S3bNxVMI+5M/JHoKD
    JI0X8HyGRZsE74r8tyAnJ7bpYj6rmK6Wqa2XlhPBnvhQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeCPQvg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 12:51:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39494 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933979AbeCPPee (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:34:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 002/109] net: phy: Restore phy_resume() locking assumption
Date: Fri, 16 Mar 2018 16:22:31 +0100
Message-Id: <20180316152329.963710543@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

commit 9c2c2e62df3fa30fb13fbeb7512a4eede729383b upstream.

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
@@ -817,6 +817,7 @@ void phy_device_remove(struct phy_device
 int phy_init_hw(struct phy_device *phydev);
 int phy_suspend(struct phy_device *phydev);
 int phy_resume(struct phy_device *phydev);
+int __phy_resume(struct phy_device *phydev);
 int phy_loopback(struct phy_device *phydev, bool enable);
 struct phy_device *phy_attach(struct net_device *dev, const char *bus_id,
 			      phy_interface_t interface);
