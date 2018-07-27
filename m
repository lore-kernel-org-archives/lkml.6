Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2D4C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C1320671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dXYzPslO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C1320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389932AbeG0WrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:47:24 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39158 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389890AbeG0WrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:47:23 -0400
Received: by mail-qt0-f194.google.com with SMTP id q12-v6so6512391qtp.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HFsq6PnVJdmjM9IRM54aqQrw1tICaaWu3noJdqJOWCY=;
        b=dXYzPslOGt9xexHq7cxwNPVxT1Icd2yGWBNzoX4pWSCd3ClaLIFKQpuOjzhJ2ZvIL9
         JUoe3LiQ5H5vcHcSN7y2L5YKSVptbq/3rwo+lgxcQdghX9MAeB4q/63R5JZhq9jHCbSV
         iCkBxRV0AQIn89VrcPYweLgZvyMK48OVVjEgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HFsq6PnVJdmjM9IRM54aqQrw1tICaaWu3noJdqJOWCY=;
        b=ks5jbJ3/i8w22EqEtwdwHsLi89cJVqrRjctFboJ3IJ8V6gBntRcozRoPWOqVIYb6LA
         bLBDp92G4k6Hc/VxCpDAZQKpXrFyK1fTi4HQdPMytrmJp32nnFouoaUubeM65yU16PKD
         C6M6+HFNFpAkn5RMLIvCP7GN2R7nniSafdobLlJJ9vgikBQZ7uvDd9Szq9mHSpWCdWIy
         cW/CzsAMbEST3haF2+XjegEVJjFrB8r8xvhx6TrCiaSNA3hXaKjPxd4/HKmVgw2Jv1DC
         6bs0HuiaUHxd6vpU3z50XZ821pqxqWsiEng5H4h6gWa+OjRCxArT+OtiUT5xsxl2SuRk
         QjWw==
X-Gm-Message-State: AOUpUlFn/+WL4/E4H0VNzCI9fSTkFTDO54z5MUYFX7PuMrnsFLX/KNwE
        VhZKtxQfFi1vW/Ew0MBl+uzqEw==
X-Google-Smtp-Source: AAOMgpcSaavhdQqZRZi+p5RZL81W7eqGV0x5b2c3qpEKfea4HyrjXj2NDZW41KlpPezP707QV4EZvw==
X-Received: by 2002:ac8:1a5d:: with SMTP id q29-v6mr8082164qtk.132.1532726619466;
        Fri, 27 Jul 2018 14:23:39 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e21-v6sm3416622qtc.67.2018.07.27.14.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 14:23:39 -0700 (PDT)
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
Subject: [PATCH v2 6/7] net: phy: Add support to configure clock in Broadcom iProc mdio mux
Date:   Fri, 27 Jul 2018 14:23:32 -0700
Message-Id: <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
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
 drivers/net/phy/mdio-mux-bcm-iproc.c | 46 ++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index c36ce4b..51d1003 100644
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
 	u32 val;
+	u32 divisor;
 
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
@@ -198,10 +219,22 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 		return PTR_ERR(md->base);
 	}
 
+	md->core_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(md->core_clk)) {
+		md->core_clk = NULL;
+	} else {
+		rc = clk_prepare_enable(md->core_clk);
+		if (rc) {
+			dev_err(&pdev->dev, "failed to enable core clk\n");
+			return rc;
+		}
+	}
+
 	md->mii_bus = mdiobus_alloc();
 	if (!md->mii_bus) {
 		dev_err(&pdev->dev, "mdiomux bus alloc failed\n");
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
 	}
 
 	bus = md->mii_bus;
@@ -217,7 +250,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 	rc = mdiobus_register(bus);
 	if (rc) {
 		dev_err(&pdev->dev, "mdiomux registration failed\n");
-		goto out;
+		goto out_alloc;
 	}
 
 	platform_set_drvdata(pdev, md);
@@ -236,8 +269,11 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 
 out_register:
 	mdiobus_unregister(bus);
-out:
+out_alloc:
 	mdiobus_free(bus);
+out:
+	if (md->core_clk)
+		clk_disable_unprepare(md->core_clk);
 	return rc;
 }
 
@@ -248,6 +284,8 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 	mdio_mux_uninit(md->mux_handle);
 	mdiobus_unregister(md->mii_bus);
 	mdiobus_free(md->mii_bus);
+	if (md->core_clk)
+		clk_disable_unprepare(md->core_clk);
 
 	return 0;
 }
-- 
1.9.1

