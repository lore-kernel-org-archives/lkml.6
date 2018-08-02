Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56986C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6BC20862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DVmxEOUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6BC20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbeHBCmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:42:15 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34939 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732392AbeHBCmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:42:14 -0400
Received: by mail-qt0-f196.google.com with SMTP id a5-v6so563750qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VsjrZXC5OpUj/mRiqlhQAUbom/HbTgymFwHCvgsVH+Q=;
        b=DVmxEOUYOHzrEWaNwNqxrjCBhcbHLa9zr8AAQd246c+q6pGHg6yCXVKHxLVXb7jGPX
         WOstrBxw6kjm3pxUB/wfVKzK+cNa8uDbFgaU9pQFOCw60q+J7kKP2ZW+DCxpHYvEEkCu
         XkUoDC1wJ6CYcoLxqw9yflFbYhgy6RYUKq21o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VsjrZXC5OpUj/mRiqlhQAUbom/HbTgymFwHCvgsVH+Q=;
        b=eYmQrxrY/ppFBC5irj7KucnxHG7HZgELLKgPh1zzBGnBR5rw4Wzx6AEk3LnBYrIvyL
         hITnAVh2Mz9oNBiNLnClQZPH0kk1hJJNO/Vdxi17xzZXOdORcb3uS9BWLDG/nOrx1AbP
         bD6Dneav77kZ0u2Eyf4OSZmTUPr1OKp7mpctFdbnR8l4uBrPLv5pUhZ7PbNLns1/PBXo
         +voscJ9/9KFxmoSu+rp8uHEhfREJsx71OlI4k57diiUMI3N8BhWYnlgIT3XVJ5s4u7WX
         n7lZM5rtikSXbuRqfZnOjv84xjjAfmG+AmnnvHGREJnfmvzDbrqYQNcH11cP7iLmy5/m
         gfLA==
X-Gm-Message-State: AOUpUlHy/+UEwBo7K9TI2H0h/cey9E0RjtywXHEc/1Ai7Yg52meOk605
        jqw6R2PKKboGltZ0/hJSecxZdQ==
X-Google-Smtp-Source: AAOMgpd6FLlQOIZ4d1/DI2VKP8vuXtMASY02S7UDSIAeC/nWKPYiD4hdVV28hz+cSKMO+s/4bCz94w==
X-Received: by 2002:a0c:aa06:: with SMTP id d6-v6mr649834qvb.26.1533171224345;
        Wed, 01 Aug 2018 17:53:44 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e81-v6sm325116qka.3.2018.08.01.17.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 17:53:43 -0700 (PDT)
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arun Parameswaran <arun.parameswaran@broadcom.com>
Subject: [PATCH v4 2/8] net: phy: Fix the register offsets in Broadcom iProc mdio mux driver
Date:   Wed,  1 Aug 2018 17:53:47 -0700
Message-Id: <1533171233-14557-3-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the register offsets in the Broadcom iProc mdio mux to start
from the top of the register address space.

Earlier, the base address pointed to the end of the block's register
space. The base address will now point to the start of the mdio's
address space. The offsets have been fixed to match this.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 0831b71..48bb74a 100644
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
@@ -169,6 +171,14 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
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
-- 
1.9.1

