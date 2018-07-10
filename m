Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5A6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9917C2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9917C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbeGJS3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:29:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732245AbeGJS3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:29:37 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BE5BAEB4;
        Tue, 10 Jul 2018 18:29:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dan Rue <dan.rue@linaro.org>
Subject: [PATCH 4.9 14/52] net: phy: micrel: fix crash when statistic requested for KSZ9031 phy
Date:   Tue, 10 Jul 2018 20:24:42 +0200
Message-Id: <20180710182450.939104219@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182449.285532226@linuxfoundation.org>
References: <20180710182449.285532226@linuxfoundation.org>
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

From: Grygorii Strashko <grygorii.strashko@ti.com>

commit bfe72442578bb112626e476ffe1f276504d85b95 upstream.

Now the command:
	ethtool --phy-statistics eth0
will cause system crash with meassage "Unable to handle kernel NULL pointer
dereference at virtual address 00000010" from:

 (kszphy_get_stats) from [<c069f1d8>] (ethtool_get_phy_stats+0xd8/0x210)
 (ethtool_get_phy_stats) from [<c06a0738>] (dev_ethtool+0x5b8/0x228c)
 (dev_ethtool) from [<c06b5484>] (dev_ioctl+0x3fc/0x964)
 (dev_ioctl) from [<c0679f7c>] (sock_ioctl+0x170/0x2c0)
 (sock_ioctl) from [<c02419d4>] (do_vfs_ioctl+0xa8/0x95c)
 (do_vfs_ioctl) from [<c02422c4>] (SyS_ioctl+0x3c/0x64)
 (SyS_ioctl) from [<c0107d60>] (ret_fast_syscall+0x0/0x44)

The reason: phy_driver structure for KSZ9031 phy has no .probe() callback
defined. As result, struct phy_device *phydev->priv pointer will not be
initializes (null).
This issue will affect also following phys:
 KSZ8795, KSZ886X, KSZ8873MLL, KSZ9031, KSZ9021, KSZ8061, KS8737

Fix it by:
- adding .probe() = kszphy_probe() callback to KSZ9031, KSZ9021
phys. The kszphy_probe() can be re-used as it doesn't do any phy specific
settings.
- removing statistic callbacks from other phys (KSZ8795, KSZ886X,
KSZ8873MLL, KSZ8061, KS8737) as they doesn't have corresponding
statistic counters.

Fixes: 2b2427d06426 ("phy: micrel: Add ethtool statistics counters")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Dan Rue <dan.rue@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/phy/micrel.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -801,9 +801,6 @@ static struct phy_driver ksphy_driver[]
 	.read_status	= genphy_read_status,
 	.ack_interrupt	= kszphy_ack_interrupt,
 	.config_intr	= kszphy_config_intr,
-	.get_sset_count = kszphy_get_sset_count,
-	.get_strings	= kszphy_get_strings,
-	.get_stats	= kszphy_get_stats,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {
@@ -948,9 +945,6 @@ static struct phy_driver ksphy_driver[]
 	.read_status	= genphy_read_status,
 	.ack_interrupt	= kszphy_ack_interrupt,
 	.config_intr	= kszphy_config_intr,
-	.get_sset_count = kszphy_get_sset_count,
-	.get_strings	= kszphy_get_strings,
-	.get_stats	= kszphy_get_stats,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {
@@ -960,6 +954,7 @@ static struct phy_driver ksphy_driver[]
 	.features	= (PHY_GBIT_FEATURES | SUPPORTED_Pause),
 	.flags		= PHY_HAS_MAGICANEG | PHY_HAS_INTERRUPT,
 	.driver_data	= &ksz9021_type,
+	.probe		= kszphy_probe,
 	.config_init	= ksz9021_config_init,
 	.config_aneg	= genphy_config_aneg,
 	.read_status	= genphy_read_status,
@@ -979,6 +974,7 @@ static struct phy_driver ksphy_driver[]
 	.features	= (PHY_GBIT_FEATURES | SUPPORTED_Pause),
 	.flags		= PHY_HAS_MAGICANEG | PHY_HAS_INTERRUPT,
 	.driver_data	= &ksz9021_type,
+	.probe		= kszphy_probe,
 	.config_init	= ksz9031_config_init,
 	.config_aneg	= genphy_config_aneg,
 	.read_status	= ksz9031_read_status,
@@ -998,9 +994,6 @@ static struct phy_driver ksphy_driver[]
 	.config_init	= kszphy_config_init,
 	.config_aneg	= ksz8873mll_config_aneg,
 	.read_status	= ksz8873mll_read_status,
-	.get_sset_count = kszphy_get_sset_count,
-	.get_strings	= kszphy_get_strings,
-	.get_stats	= kszphy_get_stats,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {
@@ -1012,9 +1005,6 @@ static struct phy_driver ksphy_driver[]
 	.config_init	= kszphy_config_init,
 	.config_aneg	= genphy_config_aneg,
 	.read_status	= genphy_read_status,
-	.get_sset_count = kszphy_get_sset_count,
-	.get_strings	= kszphy_get_strings,
-	.get_stats	= kszphy_get_stats,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {
@@ -1026,9 +1016,6 @@ static struct phy_driver ksphy_driver[]
 	.config_init	= kszphy_config_init,
 	.config_aneg	= ksz8873mll_config_aneg,
 	.read_status	= ksz8873mll_read_status,
-	.get_sset_count = kszphy_get_sset_count,
-	.get_strings	= kszphy_get_strings,
-	.get_stats	= kszphy_get_stats,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 } };


