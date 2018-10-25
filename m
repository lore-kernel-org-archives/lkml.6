Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F03ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487022075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wgyDi/BB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487022075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbeJYW4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbeJYWxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:38 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF5C20870;
        Thu, 25 Oct 2018 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477240;
        bh=FU8DLVzAW/g3uAcG9sgAd5/Ax+n+mvDG0WrsMWBYsp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wgyDi/BBIpLn+GadgxNzAut/QNvsfxcOQYmk+NzyU3ZhFM3rNVusDib+/ZrZ/+Dxb
         bzusq7lybhBl3DeMOxvJL0WDeLNgugG5CmkKjYbkp5JTIqJaw2UcRlsL5NxxgGJ9wi
         bXO0hxcLFspVOtAY06JH4jD7HGceEDwcP9l/JCWk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 70/98] dm9000: Fix irq trigger type setup on non-dt platforms
Date:   Thu, 25 Oct 2018 10:18:25 -0400
Message-Id: <20181025141853.214051-70-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

[ Upstream commit a96d3b7593a3eefab62dd930e5c99201c3678ee4 ]

Commit b5a099c67a1c36b "net: ethernet: davicom: fix devicetree irq
resource" causes an interrupt storm after the ethernet interface
is activated on S3C24XX platform (ARM non-dt), due to the interrupt
trigger type not being set properly.

It seems, after adding parsing of IRQ flags in commit 7085a7401ba54e92b
"drivers: platform: parse IRQ flags from resources", there is no path
for non-dt platforms where irq_set_type callback could be invoked when
we don't pass the trigger type flags to the request_irq() call.

In case of a board where the regression is seen the interrupt trigger
type flags are passed through a platform device's resource and it is
not currently handled properly without passing the irq trigger type
flags to the request_irq() call.  In case of OF an of_irq_get() call
within platform_get_irq() function seems to be ensuring required irq_chip
setup, but there is no equivalent code for non OF/ACPI platforms.

This patch mostly restores irq trigger type setting code which has been
removed in commit ("net: ethernet: davicom: fix devicetree irq resource").

Fixes: b5a099c67a1c36b913 ("net: ethernet: davicom: fix devicetree irq resource")

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/davicom/dm9000.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index ef24b60b4d3f..d2e0a10a8511 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1296,6 +1296,7 @@ static int
 dm9000_open(struct net_device *dev)
 {
 	struct board_info *db = netdev_priv(dev);
+	unsigned int irq_flags = irq_get_trigger_type(dev->irq);
 
 	if (netif_msg_ifup(db))
 		dev_dbg(db->dev, "enabling %s\n", dev->name);
@@ -1303,9 +1304,11 @@ dm9000_open(struct net_device *dev)
 	/* If there is no IRQ type specified, tell the user that this is a
 	 * problem
 	 */
-	if (irq_get_trigger_type(dev->irq) == IRQF_TRIGGER_NONE)
+	if (irq_flags == IRQF_TRIGGER_NONE)
 		dev_warn(db->dev, "WARNING: no IRQ resource flags set.\n");
 
+	irq_flags |= IRQF_SHARED;
+
 	/* GPIO0 on pre-activate PHY, Reg 1F is not set by reset */
 	iow(db, DM9000_GPR, 0);	/* REG_1F bit0 activate phyxcer */
 	mdelay(1); /* delay needs by DM9000B */
@@ -1313,8 +1316,7 @@ dm9000_open(struct net_device *dev)
 	/* Initialize DM9000 board */
 	dm9000_init_dm9000(dev);
 
-	if (request_irq(dev->irq, dm9000_interrupt, IRQF_SHARED,
-			dev->name, dev))
+	if (request_irq(dev->irq, dm9000_interrupt, irq_flags, dev->name, dev))
 		return -EAGAIN;
 	/* Now that we have an interrupt handler hooked up we can unmask
 	 * our interrupts
-- 
2.17.1

