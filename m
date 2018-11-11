Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ACFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135A42080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135A42080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbeKLGBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:01:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52544 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727101AbeKLGBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:01:36 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvst-0000lM-Gi; Sun, 11 Nov 2018 19:59:03 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001fx-FU; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Yuiko Oshino" <yuiko.oshino@microchip.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.806972982@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 227/366] smsc75xx: Add workaround for gigabit link up
 hardware errata.
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yuiko Oshino <yuiko.oshino@microchip.com>

commit d461e3da905332189aad546b2ad9adbe6071c7cc upstream.

In certain conditions, the device may not be able to link in gigabit mode. This software workaround ensures that the device will not enter the failure state.

Fixes: d0cad871703b898a442e4049c532ec39168e5b57 ("SMSC75XX USB 2.0 Gigabit Ethernet Devices")
Signed-off-by: Yuiko Oshino <yuiko.oshino@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/usb/smsc75xx.c | 62 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -81,6 +81,9 @@ static bool turbo_mode = true;
 module_param(turbo_mode, bool, 0644);
 MODULE_PARM_DESC(turbo_mode, "Enable multiple frames per Rx transaction");
 
+static int smsc75xx_link_ok_nopm(struct usbnet *dev);
+static int smsc75xx_phy_gig_workaround(struct usbnet *dev);
+
 static int __must_check __smsc75xx_read_reg(struct usbnet *dev, u32 index,
 					    u32 *data, int in_pm)
 {
@@ -840,6 +843,9 @@ static int smsc75xx_phy_initialize(struc
 		return -EIO;
 	}
 
+	/* phy workaround for gig link */
+	smsc75xx_phy_gig_workaround(dev);
+
 	smsc75xx_mdio_write(dev->net, dev->mii.phy_id, MII_ADVERTISE,
 		ADVERTISE_ALL | ADVERTISE_CSMA | ADVERTISE_PAUSE_CAP |
 		ADVERTISE_PAUSE_ASYM);
@@ -977,6 +983,62 @@ static int smsc75xx_wait_ready(struct us
 	return -EIO;
 }
 
+static int smsc75xx_phy_gig_workaround(struct usbnet *dev)
+{
+	struct mii_if_info *mii = &dev->mii;
+	int ret = 0, timeout = 0;
+	u32 buf, link_up = 0;
+
+	/* Set the phy in Gig loopback */
+	smsc75xx_mdio_write(dev->net, mii->phy_id, MII_BMCR, 0x4040);
+
+	/* Wait for the link up */
+	do {
+		link_up = smsc75xx_link_ok_nopm(dev);
+		usleep_range(10000, 20000);
+		timeout++;
+	} while ((!link_up) && (timeout < 1000));
+
+	if (timeout >= 1000) {
+		netdev_warn(dev->net, "Timeout waiting for PHY link up\n");
+		return -EIO;
+	}
+
+	/* phy reset */
+	ret = smsc75xx_read_reg(dev, PMT_CTL, &buf);
+	if (ret < 0) {
+		netdev_warn(dev->net, "Failed to read PMT_CTL: %d\n", ret);
+		return ret;
+	}
+
+	buf |= PMT_CTL_PHY_RST;
+
+	ret = smsc75xx_write_reg(dev, PMT_CTL, buf);
+	if (ret < 0) {
+		netdev_warn(dev->net, "Failed to write PMT_CTL: %d\n", ret);
+		return ret;
+	}
+
+	timeout = 0;
+	do {
+		usleep_range(10000, 20000);
+		ret = smsc75xx_read_reg(dev, PMT_CTL, &buf);
+		if (ret < 0) {
+			netdev_warn(dev->net, "Failed to read PMT_CTL: %d\n",
+				    ret);
+			return ret;
+		}
+		timeout++;
+	} while ((buf & PMT_CTL_PHY_RST) && (timeout < 100));
+
+	if (timeout >= 100) {
+		netdev_warn(dev->net, "timeout waiting for PHY Reset\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int smsc75xx_reset(struct usbnet *dev)
 {
 	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);

