Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D3CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F24208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UkbAAYkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F24208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbeHATnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:43:11 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41805 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731944AbeHATnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:43:10 -0400
Received: by mail-qk0-f193.google.com with SMTP id d22-v6so13260902qkc.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VsjrZXC5OpUj/mRiqlhQAUbom/HbTgymFwHCvgsVH+Q=;
        b=UkbAAYkwE2gu12HbAzYfSoiYhCVdI9HTJefzYMB5D9sexJQxRqruuXlzfZKbaVX0FN
         35hXX798+Kp1T9S09HSk4bIGJdH0/BrMqHSlFsdbW3k02P8KdhbyvyoCnlPBeKwEyt7S
         j0ewwRBwIbnaV4Ep0BmB0m8LMRqUg/z2UxeI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VsjrZXC5OpUj/mRiqlhQAUbom/HbTgymFwHCvgsVH+Q=;
        b=s29i6o9Po8gRxSf2xa0OPdCIk/01oxrHgGsmBXWASjSECE504C57ndvGqK/QMMPZ/K
         kT9w9z64FABasodHa7lCRNi0bw6T91yQsMVHE69oHngOzPvA8YMSDCwCBJ3j7eHkfNM8
         99TOdJGal2Ue0vouW/5HoEqGDd5kpu+cKOFwx+u8v1G7o9ecEHX7m5nVARk06PgS6OHX
         5iQ2g8TAR2/kxxIMat8HgKZsUVqg8LhNeTP6NB+CeUGwwX7BLS4lG03OENDazBz/Xe0A
         TbzMla6ARRhadSCCrM8LvCSJbhjp8uQ1gOP/fc5FuE24qzX1yK3nOCc2C3EuLFDg4LsV
         5Mww==
X-Gm-Message-State: AOUpUlEW5rDB2ArUOJiaNW74LNA7vQvdxjWBj5PloLnRRGr/c3jjV1HY
        OI2I20O9gbS25miMhipfIEL4Cg==
X-Google-Smtp-Source: AAOMgpeYQYGuDQM3wU3CPgOjA076imUVDu/zQuFvYTEAMfNHOtQlI6PNVFR21z6aH2M9QGQK6cuQkQ==
X-Received: by 2002:a37:8f41:: with SMTP id r62-v6mr25449255qkd.412.1533146178315;
        Wed, 01 Aug 2018 10:56:18 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m12-v6sm14401729qkl.54.2018.08.01.10.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 10:56:17 -0700 (PDT)
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
Subject: [PATCH v3 2/8] net: phy: Fix the register offsets in Broadcom iProc mdio mux driver
Date:   Wed,  1 Aug 2018 10:56:20 -0700
Message-Id: <1533146186-8374-3-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
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

