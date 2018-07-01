Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E33C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4BE25440
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4BE25440
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753815AbeGAQrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:47:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38614 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032615AbeGAQrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:47:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E52AAA6;
        Sun,  1 Jul 2018 16:47:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 194/220] net: ethernet: fix suspend/resume in davinci_emac
Date:   Sun,  1 Jul 2018 18:23:38 +0200
Message-Id: <20180701160916.289679319@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

commit dc45519eb181b5687ac8382361a8aa085acd1fe1 upstream.

This patch reverts commit 3243ff2a05ec ("net: ethernet: davinci_emac:
Deduplicate bus_find_device() by name matching") and adds a comment
which should stop anyone from reintroducing the same "fix" in the future.

We can't use bus_find_device_by_name() here because the device name is
not guaranteed to be 'davinci_mdio'. On some systems it can be
'davinci_mdio.0' so we need to use strncmp() against the first part of
the string to correctly match it.

Fixes: 3243ff2a05ec ("net: ethernet: davinci_emac: Deduplicate bus_find_device() by name matching")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/ti/davinci_emac.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1385,6 +1385,11 @@ static int emac_devioctl(struct net_devi
 		return -EOPNOTSUPP;
 }
 
+static int match_first_device(struct device *dev, void *data)
+{
+	return !strncmp(dev_name(dev), "davinci_mdio", 12);
+}
+
 /**
  * emac_dev_open - EMAC device open
  * @ndev: The DaVinci EMAC network adapter
@@ -1484,8 +1489,14 @@ static int emac_dev_open(struct net_devi
 
 	/* use the first phy on the bus if pdata did not give us a phy id */
 	if (!phydev && !priv->phy_id) {
-		phy = bus_find_device_by_name(&mdio_bus_type, NULL,
-					      "davinci_mdio");
+		/* NOTE: we can't use bus_find_device_by_name() here because
+		 * the device name is not guaranteed to be 'davinci_mdio'. On
+		 * some systems it can be 'davinci_mdio.0' so we need to use
+		 * strncmp() against the first part of the string to correctly
+		 * match it.
+		 */
+		phy = bus_find_device(&mdio_bus_type, NULL, NULL,
+				      match_first_device);
 		if (phy) {
 			priv->phy_id = dev_name(phy);
 			if (!priv->phy_id || !*priv->phy_id)


