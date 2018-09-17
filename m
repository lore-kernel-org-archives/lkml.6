Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ACEECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5C02088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5C02088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeIREW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:22:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbeIREW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:22:58 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7CD85CA0;
        Mon, 17 Sep 2018 22:53:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 23/70] net: phy: Fix the register offsets in Broadcom iProc mdio mux driver
Date:   Tue, 18 Sep 2018 00:41:56 +0200
Message-Id: <20180917211651.099975508@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arun Parameswaran <arun.parameswaran@broadcom.com>

[ Upstream commit 77fefa93bfebe4df44f154f2aa5938e32630d0bf ]

Modify the register offsets in the Broadcom iProc mdio mux to start
from the top of the register address space.

Earlier, the base address pointed to the end of the block's register
space. The base address will now point to the start of the mdio's
address space. The offsets have been fixed to match this.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -22,7 +22,7 @@
 #include <linux/mdio-mux.h>
 #include <linux/delay.h>
 
-#define MDIO_PARAM_OFFSET		0x00
+#define MDIO_PARAM_OFFSET		0x23c
 #define MDIO_PARAM_MIIM_CYCLE		29
 #define MDIO_PARAM_INTERNAL_SEL		25
 #define MDIO_PARAM_BUS_ID		22
@@ -30,20 +30,22 @@
 #define MDIO_PARAM_PHY_ID		16
 #define MDIO_PARAM_PHY_DATA		0
 
-#define MDIO_READ_OFFSET		0x04
+#define MDIO_READ_OFFSET		0x240
 #define MDIO_READ_DATA_MASK		0xffff
-#define MDIO_ADDR_OFFSET		0x08
+#define MDIO_ADDR_OFFSET		0x244
 
-#define MDIO_CTRL_OFFSET		0x0C
+#define MDIO_CTRL_OFFSET		0x248
 #define MDIO_CTRL_WRITE_OP		0x1
 #define MDIO_CTRL_READ_OP		0x2
 
-#define MDIO_STAT_OFFSET		0x10
+#define MDIO_STAT_OFFSET		0x24c
 #define MDIO_STAT_DONE			1
 
 #define BUS_MAX_ADDR			32
 #define EXT_BUS_START_ADDR		16
 
+#define MDIO_REG_ADDR_SPACE_SIZE	0x250
+
 struct iproc_mdiomux_desc {
 	void *mux_handle;
 	void __iomem *base;
@@ -169,6 +171,14 @@ static int mdio_mux_iproc_probe(struct p
 	md->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res->start & 0xfff) {
+		/* For backward compatibility in case the
+		 * base address is specified with an offset.
+		 */
+		dev_info(&pdev->dev, "fix base address in dt-blob\n");
+		res->start &= ~0xfff;
+		res->end = res->start + MDIO_REG_ADDR_SPACE_SIZE - 1;
+	}
 	md->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(md->base)) {
 		dev_err(&pdev->dev, "failed to ioremap register\n");


