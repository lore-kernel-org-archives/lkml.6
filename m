Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeC0XUV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 19:20:21 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34905 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeC0XUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 19:20:12 -0400
X-Google-Smtp-Source: AIpwx49ae3wyCet/GtyNrYaz5G0Twj5RxCVrI7bT1p7+Y7BI6qeCW1FKT5cSb+bnvY9SSt7dDmVcQQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Florian Westphal <fw@strlen.de>,
        linux-kernel@vger.kernel.org (open list),
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH net-next 2/2] net: bgmac: Mask interrupts during probe
Date: Tue, 27 Mar 2018 16:20:02 -0700
Message-Id: <20180327232002.29399-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180327232002.29399-1-f.fainelli@gmail.com>
References: <20180327232002.29399-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can have interrupts left enabled form e.g: the bootloader which used
the network device for network boot. Make sure we have those disabled as
early as possible to avoid spurious interrupts.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 46d7b8068425..2326cc219c46 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1492,6 +1492,8 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 	struct net_device *net_dev = bgmac->net_dev;
 	int err;
 
+	bgmac_chip_intrs_off(bgmac);
+
 	net_dev->irq = bgmac->irq;
 	SET_NETDEV_DEV(net_dev, bgmac->dev);
 	dev_set_drvdata(bgmac->dev, bgmac);
-- 
2.14.1
