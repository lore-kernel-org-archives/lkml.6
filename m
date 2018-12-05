Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A23EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41446214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ycUYEQO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41446214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeLEJks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728745AbeLEJkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:40:42 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E942084C;
        Wed,  5 Dec 2018 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002841;
        bh=l7UYJOdWHDChpfF+5PkyyBxi3l0A+iPgMALblCDnIBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ycUYEQO4/UmcFbZzZ1WmukF+nPuTlJ0mEMFdzdwHrj3hWh4XZwkxuUWJ/zLMoQ+H5
         Ao6BBUYwhRbVzXB8kHbbB1Tm7h0BauonEedflCE4jxc2bKq6PPcZzD9jYoJCcndfY1
         9I+OKH15Y26SZzVVQX71PwP+j4n/eRow3N6AUmiU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 084/123] net: phy: add workaround for issue where PHY driver doesn't bind to the device
Date:   Wed,  5 Dec 2018 04:35:16 -0500
Message-Id: <20181205093555.5386-84-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit c85ddecae6e5e82ca3ae6f20c63f1d865e2ff5ea ]

After switching the r8169 driver to use phylib some user reported that
their network is broken. This was caused by the genphy PHY driver being
used instead of the dedicated PHY driver for the RTL8211B. Users
reported that loading the Realtek PHY driver module upfront fixes the
issue. See also this mail thread:
https://marc.info/?t=154279781800003&r=1&w=2
The issue is quite weird and the root cause seems to be somewhere in
the base driver core. The patch works around the issue and may be
removed once the actual issue is fixed.

The Fixes tag refers to the first reported occurrence of the issue.
The issue itself may have been existing much longer and it may affect
users of other network chips as well. Users typically will recognize
this issue only if their PHY stops working when being used with the
genphy driver.

Fixes: f1e911d5d0df ("r8169: add basic phylib support")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 19ab8a7d1e48..733e35b7c4bb 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1930,6 +1930,14 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 	new_driver->mdiodrv.driver.remove = phy_remove;
 	new_driver->mdiodrv.driver.owner = owner;
 
+	/* The following works around an issue where the PHY driver doesn't bind
+	 * to the device, resulting in the genphy driver being used instead of
+	 * the dedicated driver. The root cause of the issue isn't known yet
+	 * and seems to be in the base driver core. Once this is fixed we may
+	 * remove this workaround.
+	 */
+	new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
+
 	retval = driver_register(&new_driver->mdiodrv.driver);
 	if (retval) {
 		pr_err("%s: Error %d in registering driver\n",
-- 
2.17.1

