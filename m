Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938972AbeE1MuT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163968AbeE1K4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:56:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 333/496] dp83640: Ensure against premature access to PHY registers after reset
Date: Mon, 28 May 2018 12:01:58 +0200
Message-Id: <20180528100333.848248827@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Esben Haabendal <eha@deif.com>

[ Upstream commit 76327a35caabd1a932e83d6a42b967aa08584e5d ]

The datasheet specifies a 3uS pause after performing a software
reset. The default implementation of genphy_soft_reset() does not
provide this, so implement soft_reset with the needed pause.

Signed-off-by: Esben Haabendal <eha@deif.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/dp83640.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1207,6 +1207,23 @@ static void dp83640_remove(struct phy_de
 	kfree(dp83640);
 }
 
+static int dp83640_soft_reset(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_soft_reset(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* From DP83640 datasheet: "Software driver code must wait 3 us
+	 * following a software reset before allowing further serial MII
+	 * operations with the DP83640."
+	 */
+	udelay(10);		/* Taking udelay inaccuracy into account */
+
+	return 0;
+}
+
 static int dp83640_config_init(struct phy_device *phydev)
 {
 	struct dp83640_private *dp83640 = phydev->priv;
@@ -1501,6 +1518,7 @@ static struct phy_driver dp83640_driver
 	.flags		= PHY_HAS_INTERRUPT,
 	.probe		= dp83640_probe,
 	.remove		= dp83640_remove,
+	.soft_reset	= dp83640_soft_reset,
 	.config_init	= dp83640_config_init,
 	.config_aneg	= genphy_config_aneg,
 	.read_status	= genphy_read_status,
