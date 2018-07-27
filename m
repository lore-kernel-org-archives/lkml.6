Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0228AC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F9B20894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F9B20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388832AbeG0RVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:21:06 -0400
Received: from bran.ispras.ru ([83.149.199.196]:22920 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388571AbeG0RVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:21:05 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id AB7AB203B2;
        Fri, 27 Jul 2018 18:58:30 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] net: mdio-mux: bcm-iproc: fix wrong getter and setter pair
Date:   Fri, 27 Jul 2018 18:57:47 +0300
Message-Id: <20180727155747.24978-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mdio_mux_iproc_probe() uses platform_set_drvdata() to store md pointer
in device, whereas mdio_mux_iproc_remove() restores md pointer by
dev_get_platdata(&pdev->dev). This leads to wrong resources release.

The patch replaces getter to platform_get_drvdata.

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 0831b7142df7..0c5b68e7da51 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -218,7 +218,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 
 static int mdio_mux_iproc_remove(struct platform_device *pdev)
 {
-	struct iproc_mdiomux_desc *md = dev_get_platdata(&pdev->dev);
+	struct iproc_mdiomux_desc *md = platform_get_drvdata(pdev);
 
 	mdio_mux_uninit(md->mux_handle);
 	mdiobus_unregister(md->mii_bus);
-- 
2.18.0

