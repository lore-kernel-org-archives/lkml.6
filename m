Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EBCC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3C820870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676200;
	bh=SfIAeKxNlgVhcFSaY5P/4WKkz5nPLHDa1qzFrQDdmY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dG1YneDDYW5DABmtE/Gn5nKmECd24srAP6N+a266tzcVU8Rod4hwxWPT/pwOkrz0D
	 H3R8Jb1LJgzbzHIH8wguef77uzXG3fPZMEbkTqC55ZRnqMwLwTTKNUEVHazYl9U5Ke
	 o/LmL+7OeITPDT9J/W+q/wrakvFeMhN1mMpy/mvg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3C820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeLMEnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbeLMEbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AC0720873;
        Thu, 13 Dec 2018 04:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675495;
        bh=SfIAeKxNlgVhcFSaY5P/4WKkz5nPLHDa1qzFrQDdmY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArSqtpJ8Hg6xdMHqEgzJm5Z0CzPWh2x+XoJ26+GL4ln6TmJMBuiwDZvdTC6oUNL/U
         Jes2eSGMnTsSf/B+WkBmWEXLHWZRKkYmQ1nlbmP7TG52dW5P6I5UOdkUnGD6IrOlUm
         4XcPG2QCQKdz7MW8qWSmSWVQBA8qLfhMfLMpAh2o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 25/41] net: phy: Fix not to call phy_resume() if PHY is not attached
Date:   Wed, 12 Dec 2018 23:30:38 -0500
Message-Id: <20181213043054.75891-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit ef1b5bf506b1f0ee3edc98533e1f3ecb105eb46a ]

This patch fixes an issue that mdio_bus_phy_resume() doesn't call
phy_resume() if the PHY is not attached.

Fixes: 803dd9c77ac3 ("net: phy: avoid suspending twice a PHY")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5b56a86e88ff..7830777b3595 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -76,7 +76,7 @@ static LIST_HEAD(phy_fixup_list);
 static DEFINE_MUTEX(phy_fixup_lock);
 
 #ifdef CONFIG_PM
-static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
+static bool mdio_bus_phy_may_suspend(struct phy_device *phydev, bool suspend)
 {
 	struct device_driver *drv = phydev->mdio.dev.driver;
 	struct phy_driver *phydrv = to_phy_driver(drv);
@@ -88,10 +88,11 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	/* PHY not attached? May suspend if the PHY has not already been
 	 * suspended as part of a prior call to phy_disconnect() ->
 	 * phy_detach() -> phy_suspend() because the parent netdev might be the
-	 * MDIO bus driver and clock gated at this point.
+	 * MDIO bus driver and clock gated at this point. Also may resume if
+	 * PHY is not attached.
 	 */
 	if (!netdev)
-		return !phydev->suspended;
+		return suspend ? !phydev->suspended : phydev->suspended;
 
 	/* Don't suspend PHY if the attached netdev parent may wakeup.
 	 * The parent may point to a PCI device, as in tg3 driver.
@@ -121,7 +122,7 @@ static int mdio_bus_phy_suspend(struct device *dev)
 	if (phydev->attached_dev && phydev->adjust_link)
 		phy_stop_machine(phydev);
 
-	if (!mdio_bus_phy_may_suspend(phydev))
+	if (!mdio_bus_phy_may_suspend(phydev, true))
 		return 0;
 
 	return phy_suspend(phydev);
@@ -132,7 +133,7 @@ static int mdio_bus_phy_resume(struct device *dev)
 	struct phy_device *phydev = to_phy_device(dev);
 	int ret;
 
-	if (!mdio_bus_phy_may_suspend(phydev))
+	if (!mdio_bus_phy_may_suspend(phydev, false))
 		goto no_resume;
 
 	ret = phy_resume(phydev);
-- 
2.19.1

