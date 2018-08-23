Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8917C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E862064E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E862064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeHWLiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:38:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbeHWLiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:38:14 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BBFE4C7B;
        Thu, 23 Aug 2018 08:09:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuiko Oshino <yuiko.oshino@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 075/130] smsc75xx: Add workaround for gigabit link up hardware errata.
Date:   Thu, 23 Aug 2018 09:53:11 +0200
Message-Id: <20180823074932.184711725@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuiko Oshino <yuiko.oshino@microchip.com>

[ Upstream commit d461e3da905332189aad546b2ad9adbe6071c7cc ]

In certain conditions, the device may not be able to link in gigabit mode. This software workaround ensures that the device will not enter the failure state.

Fixes: d0cad871703b898a442e4049c532ec39168e5b57 ("SMSC75XX USB 2.0 Gigabit Ethernet Devices")
Signed-off-by: Yuiko Oshino <yuiko.oshino@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/smsc75xx.c |   62 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -82,6 +82,9 @@ static bool turbo_mode = true;
 module_param(turbo_mode, bool, 0644);
 MODULE_PARM_DESC(turbo_mode, "Enable multiple frames per Rx transaction");
 
+static int smsc75xx_link_ok_nopm(struct usbnet *dev);
+static int smsc75xx_phy_gig_workaround(struct usbnet *dev);
+
 static int __must_check __smsc75xx_read_reg(struct usbnet *dev, u32 index,
 					    u32 *data, int in_pm)
 {
@@ -852,6 +855,9 @@ static int smsc75xx_phy_initialize(struc
 		return -EIO;
 	}
 
+	/* phy workaround for gig link */
+	smsc75xx_phy_gig_workaround(dev);
+
 	smsc75xx_mdio_write(dev->net, dev->mii.phy_id, MII_ADVERTISE,
 		ADVERTISE_ALL | ADVERTISE_CSMA | ADVERTISE_PAUSE_CAP |
 		ADVERTISE_PAUSE_ASYM);
@@ -990,6 +996,62 @@ static int smsc75xx_wait_ready(struct us
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


