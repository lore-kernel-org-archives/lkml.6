Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F263C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C5F208B0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eQQ4q2DN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C5F208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbeHATn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:43:29 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40838 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732418AbeHATn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:43:28 -0400
Received: by mail-qk0-f195.google.com with SMTP id c126-v6so13282956qkd.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DnLLkthm42YQbd+dryksrlRSy+2l4mH31DE5DMQIPos=;
        b=eQQ4q2DNtl8oadOPh0su54bcI1Pem4/CmScBZaKFfAxjPQfFLR4b0nnEQ6QgSnBSE3
         cBEP0PoqtidkJRO2TbrCtv1fq5K6EQ52CavFx6TzZ4+befGTl68ZutFEeBW4ZT0V1LLP
         yfR/i0earUQweKoBf5HbP+QD6ULUBlR0PkYcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DnLLkthm42YQbd+dryksrlRSy+2l4mH31DE5DMQIPos=;
        b=XCeq3A+z5t2WQmvet3sTUoCulcvOAg8Zug+EkiiWdlOFRKhRXYdLS3jQPHhGU8d2FR
         WbTHUviIj4DlYA8R78DO1yzKpL3pglzhS5xE7gisqCuCHURXvoj34k1DLsUxzyPwILUo
         2vo0ubGh9+SPVYqxvpFWW1J+gupKEdu/uUavCxsUuvAU62tVeAdaQVfTQ5OvhmtSkE6Y
         9EQi8bQSvoyOVjFj6r6cwxit2OWnFBfOT5dKe25lVcnm9YHUiSNPCcV4zi4fPbJIYHLm
         kN1o1l90n9P5hB5gkP2mKRsTaoM6jGA+qK0hrfArbX6mvZ2voWOOEQThiiIiF9oRVHhY
         TvxQ==
X-Gm-Message-State: AOUpUlFF4WMTIEN6ZVqtOCPeF0n6bbZw4Rxo9n7HHDz79/tLFaa8BvA5
        DZx8A0GwsYH/FAi64zG/KBkKLg==
X-Google-Smtp-Source: AAOMgpc2c4M0krfL9EpCtmVD9VsHASUs9UBczWisrNM3pQUHQUk/XMjhLq7siClB4dd8e3hnBiml1A==
X-Received: by 2002:a37:2121:: with SMTP id h33-v6mr24810138qkh.319.1533146195322;
        Wed, 01 Aug 2018 10:56:35 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m12-v6sm14401729qkl.54.2018.08.01.10.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 10:56:34 -0700 (PDT)
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
Subject: [PATCH v3 7/8] net: phy: Add support to configure clock in Broadcom iProc mdio mux
Date:   Wed,  1 Aug 2018 10:56:25 -0700
Message-Id: <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to configure the internal rate adjust register based on the
core clock supplied through device tree in the Broadcom iProc mdio mux.

The operating frequency of the mdio mux block is 11MHz. This is derrived
by dividing the clock to the mdio mux with the rate adjust register.

In some SoC's the default values of the rate adjust register do not yield
11MHz. These SoC's are required to specify the clock via the device tree
for proper operation.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 42 ++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 5640d78..5127010 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -13,7 +13,7 @@
  * You should have received a copy of the GNU General Public License
  * version 2 (GPLv2) along with this source code.
  */
-
+#include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/of_mdio.h>
@@ -22,6 +22,10 @@
 #include <linux/mdio-mux.h>
 #include <linux/delay.h>
 
+#define MDIO_RATE_ADJ_EXT_OFFSET	0x000
+#define MDIO_RATE_ADJ_INT_OFFSET	0x004
+#define MDIO_RATE_ADJ_DIVIDENT_SHIFT	16
+
 #define MDIO_SCAN_CTRL_OFFSET		0x008
 #define MDIO_SCAN_CTRL_OVRIDE_EXT_MSTR	28
 
@@ -49,21 +53,38 @@
 
 #define MDIO_REG_ADDR_SPACE_SIZE	0x250
 
+#define MDIO_OPERATING_FREQUENCY	11000000
+#define MDIO_RATE_ADJ_DIVIDENT		1
+
 struct iproc_mdiomux_desc {
 	void *mux_handle;
 	void __iomem *base;
 	struct device *dev;
 	struct mii_bus *mii_bus;
+	struct clk *core_clk;
 };
 
 static void mdio_mux_iproc_config(struct iproc_mdiomux_desc *md)
 {
+	u32 divisor;
 	u32 val;
 
 	/* Disable external mdio master access */
 	val = readl(md->base + MDIO_SCAN_CTRL_OFFSET);
 	val |= BIT(MDIO_SCAN_CTRL_OVRIDE_EXT_MSTR);
 	writel(val, md->base + MDIO_SCAN_CTRL_OFFSET);
+
+	if (md->core_clk) {
+		/* use rate adjust regs to derrive the mdio's operating
+		 * frequency from the specified core clock
+		 */
+		divisor = clk_get_rate(md->core_clk) / MDIO_OPERATING_FREQUENCY;
+		divisor = divisor / (MDIO_RATE_ADJ_DIVIDENT + 1);
+		val = divisor;
+		val |= MDIO_RATE_ADJ_DIVIDENT << MDIO_RATE_ADJ_DIVIDENT_SHIFT;
+		writel(val, md->base + MDIO_RATE_ADJ_EXT_OFFSET);
+		writel(val, md->base + MDIO_RATE_ADJ_INT_OFFSET);
+	}
 }
 
 static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
@@ -204,6 +225,20 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	md->core_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(md->core_clk)) {
+		if (PTR_ERR(md->core_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		md->core_clk = NULL;
+	} else {
+		rc = clk_prepare_enable(md->core_clk);
+		if (rc) {
+			dev_err(&pdev->dev, "failed to enable core clk\n");
+			return rc;
+		}
+	}
+
 	bus = md->mii_bus;
 	bus->priv = md;
 	bus->name = "iProc MDIO mux bus";
@@ -217,7 +252,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 	rc = mdiobus_register(bus);
 	if (rc) {
 		dev_err(&pdev->dev, "mdiomux registration failed\n");
-		return rc;
+		goto out_clk;
 	}
 
 	platform_set_drvdata(pdev, md);
@@ -237,6 +272,8 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 
 out_register:
 	mdiobus_unregister(bus);
+out_clk:
+	clk_disable_unprepare(md->core_clk);
 	return rc;
 }
 
@@ -246,6 +283,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 
 	mdio_mux_uninit(md->mux_handle);
 	mdiobus_unregister(md->mii_bus);
+	clk_disable_unprepare(md->core_clk);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
1.9.1

