Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4960FECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103CC2133D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="snOv61Ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103CC2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbeKIHdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbeKIHdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:52 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426EE20892;
        Thu,  8 Nov 2018 21:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714184;
        bh=lqScUk3D5yekfT/16D1F176PqOveAL5tGsvlgL5ik0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snOv61IpkPTCTakptOkE0E2nO/QvyAGsj4Vl4JUMQYMF8wU49N8BSiI3Id6vGnv4t
         yM308rcorS96Wbv6EgHheu2FHqv+5cK4U9+kjNk2QBt2DA7v4Z1YXYLAHyPrTIGqbv
         7ecRGdPZe1sEPnzWkG0PPVIfskcdieKK6XnQkKxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 099/144] dm9000: Fix irq trigger type setup on non-dt platforms
Date:   Thu,  8 Nov 2018 13:51:10 -0800
Message-Id: <20181108215104.854877232@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



